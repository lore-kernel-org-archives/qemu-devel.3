Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93066CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXe3v-000812-VD; Thu, 11 Jun 2026 07:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXe3r-00080n-ID
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:59:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXe3o-0002ip-Qz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:59:03 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65BBwJ9O051609
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 20:58:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EWetuJiHT7vGcULrusmUiGSo0APax55alXNWEdS4eJk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781179103; v=1;
 b=uY76W6012C0JrjJUGrXmS25D5+zBHFxdfJ9qq8VaeAn2FyF6bZJPlplwEM2hAkQz
 cBeQ871ZNVPe2Ir/JmF8InlN2lVwCQ+N8hbeipoEMybfutv5VoZaD2AidyDPWp/a
 idJixBGBDLukkGAvP1BwREcMnLxLXfYO9aTx96GNnRAt2NQhkZrvZKYqOHtp5OyS
 OvJbdhvkv/Mozn6idWoAX7c4KQEnKaxYwSvaRToy5GGhvbj2Bo0s563YPebxqVZz
 QIX7nzRtw884Wlb7qT4x9J66EhDKHWNown0MNiM475SpapNIso8q8cCrx8gJjWTX
 rznsExj27ipASok7BeUFlg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 20:58:03 +0900
Subject: [PATCH] ui/sdl2: Explicitly specify EGL platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ND3eKUHN1EQxOL5BQTM0tzI3MloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0Ax9Ff/2cAAAA=
X-Change-ID: 20260611-sdl-a148cd469727
To: qemu-devel@nongnu.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ZmOFnUB6Z9kyemQSEXpuabyAQJBIFF6ju13VCv3aA7c=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5bWojtG2znkXW+86dxmL1veFmcd6SeqZcK5+tXWJSoV7
 UoLZ+7vKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEhrBsP/NLW3tcq62jwdv4x2
 Nj37u7V+0+8vXXfv7Fzlynno59S4UoY/HG9a/Pd/3/xl94PPT7/XrZtis/9Iecb6BmODar608lV
 buAE=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

Mesa's eglGetDisplay() chooses the native EGL platform from
EGL_PLATFORM, limited autodetection, or the build-time default. If that
selects Wayland while SDL is using the X11 video backend, Mesa can treat
the X11 Display pointer as a wl_display and crash during eglInitialize().

Probe EGL with the X11 platform explicitly before enabling
SDL_HINT_VIDEO_X11_FORCE_EGL.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3540
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Resolving the issue described in the GitLab work item also requires:
https://github.com/libsdl-org/SDL/pull/15806
---
 include/ui/egl-helpers.h | 5 +++++
 ui/egl-helpers.c         | 4 ++--
 ui/sdl2.c                | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf52f..c97a0d5c248f 100644
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
index e3f2872cc14b..069a52495541 100644
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
index 4fcdbd79d3c0..ce14bd1f4e15 100644
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

---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260611-sdl-a148cd469727

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


