/* 
 * Linux VeeJay
 *
 * Copyright(C)2004 Niels Elburg <elburg@hio.hen.nl>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License , or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307 , USA.
 */
#include <config.h>
#include "overclock.h"
#include <stdlib.h>


extern void *(* veejay_memcpy)(void *to, const void *from, size_t len);

vj_effect *overclock_init(int w, int h)
{
    vj_effect *ve = (vj_effect *) malloc(sizeof(vj_effect));
    ve->num_params = 2;

    ve->defaults = (int *) malloc(sizeof(int) * ve->num_params);	/* default values */
    ve->limits[0] = (int *) malloc(sizeof(int) * ve->num_params);	/* min */
    ve->limits[1] = (int *) malloc(sizeof(int) * ve->num_params);	/* max */
    ve->limits[0][0] = 2;
    ve->limits[1][0] = (h/8);
    ve->limits[0][1] = 1;
    ve->limits[1][1] = 90;
    ve->defaults[0] = 5;
    ve->defaults[1] = 2;
    ve->description = "Radial cubics";
    ve->sub_format = 0;
    ve->extra_frame = 0;
    ve->has_internal_data= 0;

    return ve;
}

static uint8_t *oc_buf[3];

//copied from xine
static inline void blur(uint8_t *dst, uint8_t *src, int w, int radius, int dstStep, int srcStep){
	int x;
	const int length= radius*2 + 1;
	const int inv= ((1<<16) + length/2)/length;

	int sum= 0;

	for(x=0; x<radius; x++){
		sum+= src[x*srcStep]<<1;
	}
	sum+= src[radius*srcStep];

	for(x=0; x<=radius; x++){
		sum+= src[(radius+x)*srcStep] - src[(radius-x)*srcStep];
		dst[x*dstStep]= (sum*inv + (1<<15))>>16;
	}

	for(; x<w-radius; x++){
		sum+= src[(radius+x)*srcStep] - src[(x-radius-1)*srcStep];
		dst[x*dstStep]= (sum*inv + (1<<15))>>16;
	}

	for(; x<w; x++){
		sum+= src[(2*w-radius-x-1)*srcStep] - src[(x-radius-1)*srcStep];
		dst[x*dstStep]= (sum*inv + (1<<15))>>16;
	}
}

//copied from xine
static inline void blur2(uint8_t *dst, uint8_t *src, int w, int radius, int power, int dstStep, int srcStep){
	uint8_t temp[2][4096];
	uint8_t *a= temp[0], *b=temp[1];
	
	if(radius){
		blur(a, src, w, radius, 1, srcStep);
		for(; power>2; power--){
			uint8_t *c;
			blur(b, a, w, radius, 1, 1);
			c=a; a=b; b=c;
		}
		if(power>1)
			blur(dst, a, w, radius, dstStep, 1);
		else{
			int i;
			for(i=0; i<w; i++)
				dst[i*dstStep]= a[i];
		}
	}else{
		int i;
		for(i=0; i<w; i++)
			dst[i*dstStep]= src[i*srcStep];
	}
}

int overclock_malloc(int w, int h)
{
	const int len = w* h;
	const int uv_len = len /4;
	oc_buf[0] = (uint8_t*) vj_malloc(sizeof(uint8_t) * len );
	if(!oc_buf[0]) return 0;
	oc_buf[1] = (uint8_t*) vj_malloc(sizeof(uint8_t) * uv_len);
	if(!oc_buf[1]) return 0;
	oc_buf[2] = (uint8_t*) vj_malloc(sizeof(uint8_t) * uv_len);
	if(!oc_buf[2]) return 0;
	return 1;
}

void overclock_free()
{
	if(oc_buf[0]) free( oc_buf[0] );
	if(oc_buf[1]) free( oc_buf[1] );
	if(oc_buf[2]) free( oc_buf[2] );
}

void overclock_apply(uint8_t *yuv[3], int width, int height, int n, int radius )
{
    unsigned int x,y,dx,dy,z;
    uint8_t t = 0; 
	int s = 0;
    int i = 0;
    int N = (n * 2);
    const unsigned int len = (width * height);
    const unsigned int uv_len = len / 4;
    const int uv_height = height  /2;
    const int uv_width = width / 2;
    uint8_t *Y = yuv[0];
    uint8_t *Cb = yuv[1];
    uint8_t *Cr = yuv[2];

	for ( y = 0 ; y < height ; y ++)
	{
		blur2( oc_buf[0] + (y*width),Y + (y*width) ,width, radius,1,1,1);
	}

	for( y = 0 ; y < height; y += (1+rand()%N) )
    {
	    int r = 1 + rand() % N;
		for( x = 0; x < width; x+= r )
	    {
			s = 0;
			for(dy = 0; dy < N; dy++ )
		    {
				for(dx = 0; dx < N; dx ++ )
			    {
				   s += oc_buf[0][(y+dy)*width+x+dx];
				}
			}
			t = (uint8_t) (s / (N*N));
			for(dy = 0; dy < N; dy++ )
		    {
				for(dx = 0; dx < N; dx ++ )
			    {
				   i  = (y+dy)*width+x+dx;
				   Y[i] = ( oc_buf[0][i] > Y[i] ? ((Y[i]+t)>>1) : t );
				}
			}
	    }
	}
}
