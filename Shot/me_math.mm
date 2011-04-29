//
//  math.m
//  math lib
//
//  Created by 영호 천 on 09. 06. 05.
//  Copyright 2009 ... All rights reserved.
//

#include "me_math.h"
#import <OpenGLES/ES1/gl.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 2d

float vec2length(vector2f v)
{
	return sqrtf(v[0]*v[0] + v[1]*v[1]);
}

void vec2copy(vector2f p1, vector2f p2)
{
	p1[0]=p2[0];
	p1[1]=p2[1];
}

void vec2add(vector2f get, vector2f p1, vector2f p2)
{
	get[0]=p1[0]+p2[0];
	get[1]=p1[1]+p2[1];
}

void vec2sub(vector2f get, vector2f p1, vector2f p2)
{
	get[0]=p1[0]-p2[0];
	get[1]=p1[1]-p2[1];
}

void vec2zero(vector2f v)
{
	v[0]=v[1]=0.0f;
}

void vec2one(vector2f v)
{
	v[0]=v[1]=1.0f;
}


void vec2normalize(vector2f v)
{
	float length = vec2length(v);
	v[0]/=length;
	v[1]/=length;
}

float GetAngle(vector2f p1, vector2f p2)
{
	float Angle;
	float Delta[2];
	
	vec2sub(Delta, p2, p1);
	float Distance = vec2length(Delta);
	float DeltaNormal[2];
	DeltaNormal[0] = Delta[0] / Distance;
	DeltaNormal[1] = Delta[1] / Distance;
	
	if(DeltaNormal[0] == 0.0f) DeltaNormal[0] = 0.0001f;
	
	if(DeltaNormal[0] <= 0.0f)
	{
		Angle = (atan(DeltaNormal[1]/DeltaNormal[0]) - 3.141592f * 0.5f);
	}
	else
	{
		Angle = (atan(DeltaNormal[1]/DeltaNormal[0]) + 3.141592f * 0.5f);
	}
	
	Angle *= 57.32484076f;
	
	while(Angle < 0.0f) Angle += 360.0f;
	while(Angle > 360.0f) Angle -= 360.0f;
	
	return Angle;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3d

float vec3length(vector3f v)
{
	return sqrtf(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
}

void vec3copy(vector3f p1, vector3f p2)
{
	p1[0]=p2[0];
	p1[1]=p2[1];
	p1[2]=p2[2];
}

void vec3add(vector3f get, vector3f p1, vector3f p2)
{
	get[0]=p1[0]+p2[0];
	get[1]=p1[1]+p2[1];
	get[2]=p1[2]+p2[2];
}

void vec3sub(vector3f get, vector3f p1, vector3f p2)
{
	get[0]=p1[0]-p2[0];
	get[1]=p1[1]-p2[1];
	get[2]=p1[2]-p2[2];
}

void vec3zero(vector3f v)
{
	v[0]=0;
	v[1]=0;
	v[2]=0;
}

void vec3one(vector3f v)
{
	v[0]=v[1]=v[2]=1;
}

void vec3cross(vector3f get, vector3f p1, vector3f p2)
{
	get[0] = (p1[1] * p2[2]) - (p1[2] * p2[1]);
	get[1] = (p1[2] * p2[0]) - (p1[0] * p2[2]);
	get[2] = (p1[0] * p2[1]) - (p1[1] * p2[0]);
}

void vec3normalize(vector3f v)
{
	float length = vec3length(v);
	v[0]/=length;
	v[1]/=length;
	v[2]/=length;
}


////////////////////////////////////////////////////////////////////////////////////////////
// 4d

void vec4copy(vector4f p1, vector4f p2)
{
	p1[0]=p2[0];
	p1[1]=p2[1];
	p1[2]=p2[2];
	p1[3]=p2[3];
}

void vec4zero(vector4f v)
{
	v[0]=v[1]=v[2]=v[3]=0.0f;
}

void vec4one(vector4f v)
{
	v[0]=v[1]=v[2]=v[3]=1.0f;
}

void vec4add(vector4f get, vector4f p1, vector4f p2)
{
	get[0] = p1[0] + p2[0];
	get[1] = p1[1] + p2[1];
	get[2] = p1[2] + p2[2];
	get[3] = p1[3] + p2[3];
}


/////////
void me_Perspective(double fovy, double aspect, double zNear, double zFar)
{
	// Start in projection mode.
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	double xmin, xmax, ymin, ymax;
	ymax = zNear * tan(fovy * M_PI / 360.0);
	ymin = -ymax;
	xmin = ymin * aspect;
	xmax = ymax * aspect;
	glFrustumf(xmin, xmax, ymin, ymax, zNear, zFar);
}

void me_LookAt(float eyex, float eyey, float eyez,float centerx, float centery, float centerz,float upx, float upy, float upz)
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

    float m[16];
    float x[3], y[3], z[3];
    float mag;
    
    /* Make rotation matrix */
    
    /* Z vector */
    z[0] = eyex - centerx;
    z[1] = eyey - centery;
    z[2] = eyez - centerz;
    mag = sqrt(z[0] * z[0] + z[1] * z[1] + z[2] * z[2]);
    if (mag) {          /* mpichler, 19950515 */
        z[0] /= mag;
        z[1] /= mag;
        z[2] /= mag;
    }
    
    /* Y vector */
    y[0] = upx;
    y[1] = upy;
    y[2] = upz;
    
    /* X vector = Y cross Z */
    x[0] = y[1] * z[2] - y[2] * z[1];
    x[1] = -y[0] * z[2] + y[2] * z[0];
    x[2] = y[0] * z[1] - y[1] * z[0];
    
    /* Recompute Y = Z cross X */
    y[0] = z[1] * x[2] - z[2] * x[1];
    y[1] = -z[0] * x[2] + z[2] * x[0];
    y[2] = z[0] * x[1] - z[1] * x[0];
    
    /* mpichler, 19950515 */
    /* cross product gives area of parallelogram, which is < 1.0 for
     * non-perpendicular unit-length vectors; so normalize x, y here
     */
    
    mag = sqrt(x[0] * x[0] + x[1] * x[1] + x[2] * x[2]);
    if (mag) {
        x[0] /= mag;
        x[1] /= mag;
        x[2] /= mag;
    }
    
    mag = sqrt(y[0] * y[0] + y[1] * y[1] + y[2] * y[2]);
    if (mag) {
        y[0] /= mag;
        y[1] /= mag;
        y[2] /= mag;
    }
    
#define M(row,col)  m[col*4+row]
    M(0, 0) = x[0];
    M(0, 1) = x[1];
    M(0, 2) = x[2];
    M(0, 3) = 0.0;
    M(1, 0) = y[0];
    M(1, 1) = y[1];
    M(1, 2) = y[2];
    M(1, 3) = 0.0;
    M(2, 0) = z[0];
    M(2, 1) = z[1];
    M(2, 2) = z[2];
    M(2, 3) = 0.0;
    M(3, 0) = 0.0;
    M(3, 1) = 0.0;
    M(3, 2) = 0.0;
    M(3, 3) = 1.0;
#undef M
    glMultMatrixf(m);
    
    /* Translate Eye to Origin */
    glTranslatef(-eyex, -eyey, -eyez);
}

float me_GetRand()
{
	return (float)rand() / (float)RAND_MAX;
}