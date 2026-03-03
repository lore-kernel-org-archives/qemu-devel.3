Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BDCEC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVV-0007wF-Mv; Tue, 03 Mar 2026 08:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPVA-0007RU-J6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:36 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPUz-0000Nk-5x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:22 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 623D90Je018783
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 22:09:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vKmzwmUyPdcq+hYe6gh7JqKYAafIRCDgFX2ryEYv01E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772543351; v=1;
 b=J2km3fHY+p6LbdhjAGOJhjSXiqx/6PikqAYZUTANdrxuSby3k+WdqQIEBjuQgJLE
 xYUdl8oHueyaAkrE6Et1gdgEYx9mKANbmjw9BoSXm3gcae/DKq8WeEfXeFYZvfQe
 luOVAEux8MqYZYHAmPuwOar0ab0k3T6Li2326iN4JfYDbK6pZnpoYkxPKjjIlSwX
 HBZ2NcIieAUAID6joFIzB6ogtfG6SN2NbLh0Ct2cmgMfn2RV9wOjw9vfJMhJNRB2
 yiOgl2s11fBn/4qeB0jP97AjNVIgktd/xEXx4FN2yJ1xNE2n4lWmKRp/+U74g0xR
 0cyw7DFtaX93XZSmQoBtcQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 03 Mar 2026 22:08:56 +0900
Subject: [PATCH 3/3] ui/surface: Avoid including epoxy/gl.h in header files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-gl-v1-3-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
References: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

include/ui/shader.h and include/ui/surface.h are included by files that
do not depend on Epoxy so they shouldn't include epoxy/gl.h. Otherwise,
compilations of these files can fail because the path to the directory
containing epoxy/gl.h may not be passed to the compiler.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h |  4 ++--
 include/ui/shader.h  |  2 --
 include/ui/surface.h |  5 +----
 ui/console-gl.c      | 27 ++++++++++++++-------------
 ui/shader.c          |  1 +
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 98feaa58bdd1..9ac1e5b82daa 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -423,8 +423,8 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
 bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
-                                       int fd, GLuint *texture,
-                                       GLuint *mem_obj);
+                                       int fd, uint32_t *texture,
+                                       uint32_t *mem_obj);
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
diff --git a/include/ui/shader.h b/include/ui/shader.h
index 4c5acb2ce8b2..e82213263c47 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_SHADER_H
 #define QEMU_SHADER_H
 
-#include <epoxy/gl.h>
-
 typedef struct QemuGLShader QemuGLShader;
 
 void qemu_gl_run_texture_blit(QemuGLShader *gls, bool flip);
diff --git a/include/ui/surface.h b/include/ui/surface.h
index f16f7be8be81..d2542d3ace5f 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -8,7 +8,6 @@
 #include "ui/qemu-pixman.h"
 
 #ifdef CONFIG_OPENGL
-# include <epoxy/gl.h>
 # include "ui/shader.h"
 #endif
 
@@ -19,9 +18,7 @@ typedef struct DisplaySurface {
     pixman_image_t *image;
     uint8_t flags;
 #ifdef CONFIG_OPENGL
-    GLenum glformat;
-    GLenum gltype;
-    GLuint texture;
+    uint32_t texture;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 73be35c1fc78..d4b9017b53de 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include <epoxy/gl.h>
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/shader.h"
@@ -66,6 +67,9 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
+    GLenum glformat;
+    GLenum gltype;
+
     assert(gls);
     assert(QEMU_IS_ALIGNED(surface_stride(surface), surface_bytes_per_pixel(surface)));
 
@@ -73,7 +77,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
         return;
     }
 
-    assert(map_format(surface_format(surface), &surface->glformat, &surface->gltype));
+    assert(map_format(surface_format(surface), &glformat, &gltype));
     glGenTextures(1, &surface->texture);
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, surface->texture);
@@ -81,16 +85,12 @@ void surface_gl_create_texture(QemuGLShader *gls,
                   surface_stride(surface) / surface_bytes_per_pixel(surface));
     if (epoxy_is_desktop_gl()) {
         glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
-                     surface_width(surface),
-                     surface_height(surface),
-                     0, surface->glformat, surface->gltype,
-                     surface_data(surface));
+                     surface_width(surface), surface_height(surface), 0,
+                     glformat, gltype, surface_data(surface));
     } else {
-        glTexImage2D(GL_TEXTURE_2D, 0, surface->glformat,
-                     surface_width(surface),
-                     surface_height(surface),
-                     0, surface->glformat, surface->gltype,
-                     surface_data(surface));
+        glTexImage2D(GL_TEXTURE_2D, 0, glformat,
+                     surface_width(surface), surface_height(surface), 0,
+                     glformat, gltype, surface_data(surface));
         glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_SWIZZLE_A, GL_ONE);
     }
 
@@ -150,17 +150,18 @@ void surface_gl_update_texture(QemuGLShader *gls,
                                int x, int y, int w, int h)
 {
     uint8_t *data = (void *)surface_data(surface);
+    GLenum glformat;
+    GLenum gltype;
 
     assert(gls);
+    assert(map_format(surface_format(surface), &glformat, &gltype));
 
     if (surface->texture) {
         glBindTexture(GL_TEXTURE_2D, surface->texture);
         glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
                       surface_stride(surface)
                       / surface_bytes_per_pixel(surface));
-        glTexSubImage2D(GL_TEXTURE_2D, 0,
-                        x, y, w, h,
-                        surface->glformat, surface->gltype,
+        glTexSubImage2D(GL_TEXTURE_2D, 0, x, y, w, h, glformat, gltype,
                         data + surface_stride(surface) * y
                         + surface_bytes_per_pixel(surface) * x);
     }
diff --git a/ui/shader.c b/ui/shader.c
index ab448c41d4c6..76ee4c32785d 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include <epoxy/gl.h>
 #include "ui/shader.h"
 
 #include "ui/shader/texture-blit-vert.h"

-- 
2.53.0


