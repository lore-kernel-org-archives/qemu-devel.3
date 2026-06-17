Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3E7CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs9X-0004jF-0F; Wed, 17 Jun 2026 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9K-0003zG-Le
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9H-0004vs-GW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ize/azyYjVC4psFbO+fkpnMb5YAHDb3xCKakjrdKRg=;
 b=ASjsGeFYKv7m6tQUuylUSKMhtiJXOur+abP4dlYU9EJh9MxJZQbSCkCdZnvu2CSdIhoBUe
 Bzx71Z5ChAzNEzGtQJyB638J6run9u0xXQZFICTecpBDov0LcQ0IIal/Cm7n+THNaellgp
 umop2bf9NCOuyiG/43l8pGSsCDoFTCM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-0HPLWugvN9-qQRNkkER85A-1; Wed,
 17 Jun 2026 11:25:48 -0400
X-MC-Unique: 0HPLWugvN9-qQRNkkER85A-1
X-Mimecast-MFC-AGG-ID: 0HPLWugvN9-qQRNkkER85A_1781709946
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79C741801323
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68C61180035F; Wed, 17 Jun 2026 15:25:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:23 +0400
Subject: [GIT PULL 26/27] ui/sdl2: Explicitly specify EGL platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-26-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wXA/r+DI+eRqTS0szOikrlV8F1n/OI8Fb3jj2mHY064=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpr2+fQlnb36StzENaXB2NV115JpkRxqDrg
 wqxDWmc46eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5eR1D/9VZ1mPdiWZLk+DVl7Y9Im6aT3O1Xrmiclolgj963yosUn0bNZSEi9FqPKzV7hR6fhCf1K
 nzxKhTzBxarRyWfCXlnTI0qlf6ReDv6dBQqq5rr2dKOzuwcYsjDqCh/Sz2aK65FQ7KYvdz53dhY
 yULbC3gSLVvwXyyZNheoXcu8UUBL+0J58Dyj0GKItWQbDdqwEkP4Swi/r0WE1U1u5wIZn6I/smu
 sL6jVQqkmb+r72hbscoto6/1SxrJfGUA07gch6Ui0tXAGPtCbydq5yzuQ9uYxnQdENIB4W4iUyO
 IhqTYkYuSRPQ/Gs9taEydzFomTO+/xZK8C5YeNrzwqiPp7lyosmQj+QItuuWfgLa4HZE6+Q63Mm
 cYbUEKOlXUSUUpmRGRlhOJ1KoqiOXbBAS6D1RKiBK/6ZTmtkOtoYCuPNTbBtsE/9uB9XSzriOU5
 tuC7T3hG2PHNAhFCDtLl/cCSfvGsoMxsiOugbfFlsc4LBHrNupHoGhnhE5xdfZFzKkFq8qdoAzG
 o34NgfxeT7OI0ptYWESEIf7IPP4MO65D5CaEZ4n4ubIV8GwKFODeNwjpL7sJryCIHJhyq1Nrn2v
 KZZgzQsBUDm2eWvims8haV0SYtyCatZE7b57ZZQN+w4BniGDD051Js8+R7IVhFaaIVMV++4TNPz
 nTwUnfjEukAOXGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/ui/egl-helpers.h | 5 +++++
 ui/egl-helpers.c         | 4 ++--
 ui/sdl2.c                | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf52..c97a0d5c248 100644
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
index e3f2872cc14..069a5249554 100644
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
index 4fcdbd79d3c..ce14bd1f4e1 100644
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
2.54.0


