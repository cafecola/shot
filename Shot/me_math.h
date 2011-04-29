// me_math.h, me_math.mm
// 수학관련 함수
#pragma once

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>

#define RAD2DEGREE(p) ((p)*57.29577951f)
#define DEGREE2RAD(p) ((p)*0.01745329f)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 2차원 벡터
typedef float vector2f[2];

float vec2length(vector2f v);
void vec2copy(vector2f p1, vector2f p2);
void vec2add(vector2f get, vector2f p1, vector2f p2);
void vec2sub(vector2f get, vector2f p1, vector2f p2);
void vec2normalize(vector2f v);
void vec2zero(vector2f v);
void vec2one(vector2f v);
float GetAngle(vector2f p1, vector2f p2);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3차원 벡터
typedef float vector3f[3];

float vec3length(vector3f v);
void vec3copy(vector3f p1, vector3f p2);
void vec3add(vector3f get, vector3f p1, vector3f p2);
void vec3sub(vector3f get, vector3f p1, vector3f p2);
void vec3zero(vector3f v);
void vec3one(vector3f v);
void vec3cross(vector3f get, vector3f p1, vector3f p2);
void vec3normalize(vector3f v);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4차원 벡터
typedef float vector4f[4];

void vec4copy(vector4f p1, vector4f p2);
void vec4add(vector4f get, vector4f p1, vector4f p2);
void vec4zero(vector4f v);
void vec4one(vector4f v);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 매트릭스 관련
void me_Perspective(double fovy, double aspect, double zNear, double zFar);
void me_LookAt(float eyex, float eyey, float eyez, float centerx, float centery, float centerz, float upx, float upy, float upz);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 난수 관련
float me_GetRand();	// 0~1 사이의 랜덤값을 제공한다