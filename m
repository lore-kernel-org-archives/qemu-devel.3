Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA9BD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfOH-00038R-CZ; Fri, 19 Dec 2025 13:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ju0f6auefxqwyu6=tsoyom8uy8gr=35ye7doiqiutz7@em483429.getutm.app>)
 id 1vWfOF-00038D-Ps
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:48 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ju0f6auefxqwyu6=tsoyom8uy8gr=35ye7doiqiutz7@em483429.getutm.app>)
 id 1vWfOE-0007vO-07
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170471; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=aN++4iDum0qJTzZcSSI7HultjHQDo0BXii/8/8KmwzU=; b=jCPOLhP0WcLZRHW09mLq19VO3B
 ANTHGcXr9dRDGJ4iWrsAdgC+H29ndvre6TPuHeGDSWcIrVil8VIf8bneUFL1K0yP9IXb+ZJkOoMmi
 4Ej2+Z2PUMKAKcH4M6sXZIzPxMSNvED/afmCdwt8IlMYwMluLBYaH0N+3fIW5rpioZSGUlJklWYbV
 mQWzadeW0ODkC8Y8nWM6J1ydPWxZETnQbmnc0DD1m8jlL+MY+IQHSYT+FUqZZEOHAreYp2bgwtDSt
 rz//bWvUAFEEe11CIQk2CcZw5eLZQQ5tqMKo/iFZnuJHrh9AShZ3gKhtbMMHlvtjgJJs5PAp5MqqY
 L8uF6zRw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169571; h=from : subject :
 to : message-id : date;
 bh=aN++4iDum0qJTzZcSSI7HultjHQDo0BXii/8/8KmwzU=;
 b=gBK7ak6wUFpE/g1kD5BamzWa7qwrmmyVkQBe4PaVMItXaMUXZCfJ4/GJvuWym+WASf+hH
 672z80Q7IdAewB26ZHQ6KcofAmwJfiKTkxJw3Kbrbq8sFQsNazRkRCtU/K5WkH0VNfyBJfd
 lf4r4R0lBYaZN+YVc2B/ZxRr5jK+ACFXG1vBQzKZdbWlAkxxswOr2TKRpokQV2gmFod80JI
 ewwT2W1TFxqVQ4b6IxIcZyxxYCp9d0O5zLYA4gzCRwBp7scrnS7VWg2aqvECsLzLRGf8Eso
 ICAGfStUKZpJmju4ev2FImBAICpx2B2MP3QsfWiNgAofK0LA8ePLp3XXUFwQ==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNy-pH9Ro7-JY; Fri, 19 Dec 2025 18:39:30 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNx-AIkwcC8uKAK-Df58; Fri, 19 Dec 2025 18:39:29 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RFC v2 4/6] virtio-gpu-virgl: support scanout of Metal textures
Date: Fri, 19 Dec 2025 10:38:50 -0800
Message-ID: <20251219183853.4426-5-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: lhQx7F0tXprM.QvCkUwYddCQk.uyX8agyIkG7
Feedback-ID: 483429m:483429abrvJvs:483429s1xkRlrMmE
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.ju0f6auefxqwyu6=tsoyom8uy8gr=35ye7doiqiutz7@em483429.getutm.app;
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

When supported, virglrenderer will return a MTLTexture handle that can be
directly used for scanout.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 meson.build                   |  4 ++++
 include/ui/console.h          |  2 ++
 hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
 hw/display/virtio-gpu.c       | 10 ++++++++--
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index d9293294d8e..05bad663764 100644
--- a/meson.build
+++ b/meson.build
@@ -832,6 +832,7 @@ version_res = []
 coref = []
 iokit = []
 pvg = not_found
+metal = not_found
 emulator_link_args = []
 midl = not_found
 widl = not_found
@@ -859,6 +860,7 @@ elif host_os == 'darwin'
   host_dsosuf = '.dylib'
   pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
                    required: get_option('pvg'))
+  metal = dependency('appleframeworks', modules: 'Metal', required: false)
 elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -2591,6 +2593,7 @@ if xen.found()
     ('0' + xen_version[2]).substring(-2)
   config_host_data.set('CONFIG_XEN_CTRL_INTERFACE_VERSION', xen_ctrl_version)
 endif
+config_host_data.set('CONFIG_METAL', metal.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -4874,6 +4877,7 @@ summary(summary_info, bool_yn: true, section: 'Crypto')
 summary_info = {}
 if host_os == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
+  summary_info += {'Metal support':           metal}
 endif
 summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'SDL support':       sdl}
diff --git a/include/ui/console.h b/include/ui/console.h
index 25e45295d44..a45b524c575 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -134,12 +134,14 @@ struct QemuConsoleClass {
 typedef enum ScanoutTextureNativeType {
     SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
     SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
+    SCANOUT_TEXTURE_NATIVE_TYPE_METAL,
 } ScanoutTextureNativeType;
 
 typedef struct ScanoutTextureNative {
     ScanoutTextureNativeType type;
     union {
         void *d3d_tex2d;
+        void *metal_texture;
     } u;
 } ScanoutTextureNative;
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9fcc01b6f46..b3e83046643 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -438,6 +438,13 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
 #if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= NATIVE_HANDLE_SUPPORT_VERSION
         if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
             switch (ext.native_type) {
+#ifdef CONFIG_METAL
+            case VIRGL_NATIVE_HANDLE_METAL_TEXTURE: {
+                native.type = SCANOUT_TEXTURE_NATIVE_TYPE_METAL;
+                native.u.metal_texture = ext.native_handle;
+                break;
+            }
+#endif
             case VIRGL_NATIVE_HANDLE_NONE:
             case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
                 /* already handled above */
@@ -1184,7 +1191,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #if VIRGL_VERSION_MAJOR >= 1
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
-        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+        flags |= VIRGL_RENDERER_VENUS;
+#ifndef CONFIG_METAL /* Metal does not support render server */
+        flags |= VIRGL_RENDERER_RENDER_SERVER;
+#endif
     }
 #endif
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daff..38010c0fcc2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1483,12 +1483,18 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPU *g = VIRTIO_GPU(qdev);
+    bool have_ext_memory;
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+#ifdef CONFIG_METAL
+        have_ext_memory = true;
+#else
+        have_ext_memory = virtio_gpu_have_udmabuf();
+#endif
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
             !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
-            !virtio_gpu_have_udmabuf()) {
-            error_setg(errp, "need rutabaga or udmabuf for blob resources");
+            !have_ext_memory) {
+            error_setg(errp, "need rutabaga or ext memory for blob resources");
             return;
         }
 
-- 
2.50.1 (Apple Git-155)


