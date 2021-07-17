#ifndef __GL_SHARED_H
#define __GL_SHARED_H

// for static checker sake
#if !defined(GL) && !defined(EGL)
	#define GL
	#warning "This WILL break your build. Fix it!"
#endif


#if defined(GL)
	#include <GL/glew.h>
#elif defined(EGL)
	#include <EGL/eglplatform.h>
	#include <GLES2/gl2.h>
	#include <EGL/egl.h>
#endif

#include "../../shared.h"

void SGLShadersLoad(void);
void SGLInit(struct XAVA_HANDLE *xava);
void SGLApply(struct XAVA_HANDLE *xava);
void SGLClear(struct XAVA_HANDLE *xava);
void SGLDraw(struct XAVA_HANDLE *xava);
void SGLCleanup(void);

#endif
