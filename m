Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6516D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfO8-000366-PF; Fri, 19 Dec 2025 13:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ztxonckgabdntb3=lzjmnqe5bqma=jxntfp6n9jtwhj@em483429.getutm.app>)
 id 1vWfO6-00035h-9Y
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:38 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ztxonckgabdntb3=lzjmnqe5bqma=jxntfp6n9jtwhj@em483429.getutm.app>)
 id 1vWfO4-0007uK-Rq
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170465; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=OlIux2AkyHzRDJL2I5mcGC77DHOFvv+lW8smwFu391w=; b=CVKuG9gzjIOC3phQcXfXIigznM
 LVf2lZiGLtk88q/Olt11AUR798ZYs/HugQaw96rJuyQ44NQBJytZ3XjgMwirdrcxIpeVG7C0jqP/G
 5jtj5m3tw4OEuPO4WJDxaDAgKa8obbvVqFPJh7Pb4LBMGZgVOEuze8f8ROTSy3J6BqnbXo3qkjfs7
 M//myKt1wdwAVGJnwF/Ysy+9oalmgkotDBpMBNOY86o2+82bTkZPxb3k7yev8sKCD8RQtMGBfNb7c
 vd3T7/0DMIZbe5+GsSJf1aTqGqZ/yRyJL5eJR8J8nNMX99Ly3p4MfvNzP3RrgHHIGRN6aL20QcH6B
 W9LF5qrw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169565; h=from : subject :
 to : message-id : date;
 bh=OlIux2AkyHzRDJL2I5mcGC77DHOFvv+lW8smwFu391w=;
 b=MaxV0X8ATrd2L1EWwkteffofQTk2LQAAZqm5i2q2MGW4R+xQWekRF+O/9BsKRfkgdfLGY
 soqYRV8eye+4gOS2LPAUlVIa4qNmPhk9JyiDyBIH1DtIS8/gEM8RLsOMFJxrnxOYWifotWf
 sy5PoxQFrqo7gMIKIUmnLnSVIERgY0mhTATUJbqZBvrmmsctWRra58kmPT/RvAuEWoOgXrt
 gIcsavibhuBJhxJQnXyaQ3bc0DuxnRkp4CurZMt31Pj7eROFBVNFrHaGNdtfV8ZEcAKMVVe
 nd4SgLF3jwN7f4l+V4CwnX0lfe7ZU3x3AS40hI/gQh0ng2J7MgC8RLu5oKrg==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNq-pH9RFX-0t; Fri, 19 Dec 2025 18:39:22 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNo-AIkwcC8uKAK-En8S; Fri, 19 Dec 2025 18:39:21 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH RFC v2 1/6] egl-helpers: store handle to native device
Date: Fri, 19 Dec 2025 10:38:47 -0800
Message-ID: <20251219183853.4426-2-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: N8UKRW5tH_9t.9f231FjHVcDd.M-LN3QNc9nK
Feedback-ID: 483429m:483429abrvJvs:483429sTzOrhDc5L
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.ztxonckgabdntb3=lzjmnqe5bqma=jxntfp6n9jtwhj@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make way for other platforms by making the variable more general. Also we
will be using the device in the future so let's save the pointer in the
global instead of just a boolean flag.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/ui/egl-helpers.h      | 2 +-
 hw/display/virtio-gpu-virgl.c | 2 +-
 ui/egl-helpers.c              | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf52..c239d323177 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -12,7 +12,7 @@
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 extern DisplayGLMode qemu_egl_mode;
-extern bool qemu_egl_angle_d3d;
+extern void *qemu_egl_angle_native_device;
 
 typedef struct egl_fb {
     int width;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad62..20c856c04e3 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1152,7 +1152,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
-    if (qemu_egl_angle_d3d) {
+    if (qemu_egl_angle_native_device) {
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e3f2872cc14..57bcf994989 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -28,7 +28,7 @@
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
 DisplayGLMode qemu_egl_mode;
-bool qemu_egl_angle_d3d;
+void *qemu_egl_angle_native_device;
 
 /* ------------------------------------------------------------------ */
 
@@ -651,7 +651,7 @@ int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
         }
 
         trace_egl_init_d3d11_device(device);
-        qemu_egl_angle_d3d = device != NULL;
+        qemu_egl_angle_native_device = d3d11_device;
     }
 #endif
 
-- 
2.50.1 (Apple Git-155)


