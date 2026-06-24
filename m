Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7BBCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNsq-0002wc-7T; Wed, 24 Jun 2026 09:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsX-0002dM-8O; Wed, 24 Jun 2026 09:42:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsV-000221-Fd; Wed, 24 Jun 2026 09:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308002; bh=UionjM9okuVr30pX3e19TeiANShrLy3DkF/YO9W4QMI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DaFF0XkaT/qq4zb2Ie8MJV04OdrfQSKtAo2+jCILPlGUwOdr17O8mZkQXgRzklGjp
 MLqxJ7VaTHCVfYJ8dhS0pSqGHZ4h+kfRQjH6ET9WXagoYpMm/DmxHm032rBzs40mto
 /Q149K97NUhE+YFdIlbRViIKCA7ROpgYfuSaiIqAojPxwrcrnlWt9Rly1QkANo1Z+/
 hDU4Mq5TRZeK1TUakg8xwya7NhMJZPYXG/tBjAY8rjlzFOp0kTRBu+Vx2WzZlKATdi
 Zul1lGQXqLluCYezq9kcHFuQ5gpy402xJEq35RUVrwy26jja+/WuxFdi8g5GskBwn5
 Y41fjoRfAwLbA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 290201BAA15;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA22F3DEA64;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 099/107] ui/sdl2: Explicitly specify EGL platform
Date: Wed, 24 Jun 2026 16:31:44 +0300
Message-ID: <20260624133301.403266-99-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Mesa's eglGetDisplay() chooses the native EGL platform from
EGL_PLATFORM, limited autodetection, or the build-time default. If that
selects Wayland while SDL is using the X11 video backend, Mesa can treat
the X11 Display pointer as a wl_display and crash during eglInitialize().

Probe EGL with the X11 platform explicitly before enabling
SDL_HINT_VIDEO_X11_FORCE_EGL.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3540
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 6157908503f9a5a14d17a8ecf8cc3308107e1458)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf5..c97a0d5c24 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -61,6 +61,11 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
 
 EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win);
 
+#if defined(CONFIG_X11) || defined(CONFIG_GBM) || defined(WIN32)
+EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
+                                EGLenum platform);
+#endif
+
 #if defined(CONFIG_X11) || defined(CONFIG_GBM)
 
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e3f2872cc1..069a524955 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -520,8 +520,8 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win)
  * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't seem
  * like mesa will be able to advertise these (even though it can do EGL 1.5).
  */
-static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
-                                       EGLenum platform)
+EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
+                                EGLenum platform)
 {
     EGLDisplay dpy = EGL_NO_DISPLAY;
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 987ad334bb..9dd5e305e1 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -862,7 +862,8 @@ static void sdl2_set_hint_x11_force_egl(void)
     }
 
     /* Prefer EGL over GLX to get dma-buf support. */
-    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
+    egl_display = qemu_egl_get_display((EGLNativeDisplayType)x_disp,
+                                       EGL_PLATFORM_X11_KHR);
 
     if (egl_display != EGL_NO_DISPLAY) {
         /*
-- 
2.47.3


