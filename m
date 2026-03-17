Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F6FFED9EF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YXw-0004zS-GS; Tue, 17 Mar 2026 13:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXr-0004ts-FS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:32 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXp-00078x-2q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:30 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2c0e3a2605fso643800eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769767; x=1774374567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI53HZkSc7DNY29qJq30SopvLPnb6dODYs8Z/mK2TEw=;
 b=ja94keE27aX6eBqZD5TOu7Mj8/Z7BBh+Qtc5YA0yCSrhWq6J9iAlljU8pxLu6MTgxr
 wHlYIk19R51KPsISjJWNqhPyxfsvLkCX9hpMjmFgvA0MhJowB8G22qO1th13wIAtMLO8
 o4XWmBTd8XlV02bEXOVJoX3wHUA9eDkvdtrpKTB8hYAi65Nb4u1q+okg6RQt9Dhl2nYr
 xhFZMUl7GXQmFmgmJ+W82/7MvKZ9TmI3QYSAack6A2I+ganUczWcKQNwSUuNf15oxTVW
 eaXd8fViHmUci6ExtGsXZbZ+d+0AXWVU+8bC3tYl2JpQrBYdpPULTsfCEkWPHw1KxuHR
 o1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769767; x=1774374567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZI53HZkSc7DNY29qJq30SopvLPnb6dODYs8Z/mK2TEw=;
 b=aB7cDQwtNi5ZaSmv/ov3R4Eex/QL1kD6jCkudkF+ew1gS7FtLwX4nBo4vAGwUT8y8k
 N1TSFl95vfZ16QUv0wxSbPT7Te+Vkc1fjSs7/f/4Mv8smZEeXIXfygvTDjIh/fJuPEDN
 U5NBryvWNY+MKNOqJrwKdrbrNNBYFWSiMO+3u3lWNl+2uJsrF4Y4JvjpUQ2sOafHvoMg
 Uu8ltf0eoJwcLN54Gg6MDNpDk1vgL6OM6LET4j4bM8KNrALhIkb39H63AsB+E3Xtfmvv
 TPtTBA81Yp03S/rL00Yb+ZmzxEg3TyDCfk/iwEImS9GdhcMEmRHal1+8i/W/HxIyqNYa
 0J+A==
X-Gm-Message-State: AOJu0Yzfv61rwiuogXFAhtoV45JsOb5542VETGyDb8FxAzS+nxI7u9uo
 M4JBRibWaFlGZLWnXh6tC605QzOmQym5EzLRX9Y4D3AFldg0dzRvut5aGV1H6dhf
X-Gm-Gg: ATEYQzysBBEd4qlLVn4ig3Qf4FITavkhGcPj0Tt2Nhwtclp0ebPK1ypseaQcVUI4BWs
 sey3ivlvmDAmy/psHDoGbWRBIALLqfiKWeaJ2gsDoW1uAtrPJzFjT0TbjwIgmJ5AESGyE5P0u9f
 4cTkD6cjpa+20Pu8c1dENwyJccSnvbTXVZFEzgmRePfP4dUiwXnJJXguLRKOXLO7F7Q5qNjEWUR
 vWSxBizK7I0fmqOkCfjf/DHKR36wrQg/rS67BZZFp1/bKDQMzIQohQHpXbsZJmoSi6HJUvFXAei
 pV1SKlpz5oijJE2kqmHmhhsObTGsEW0mtYjahUoiyJkTrPLdUfXcrArHC27f4N2IHLEIc8/WgIB
 U3YpU+/i2tBoT/6dKFf3GF1GmQTvWwRz+Fse79Z2hjNYtF7zjHZYZKasgCIvCyDszjApO8tEauX
 seJEUnuxKg4AdfLJbc/dcVfJpSmOxeCC+VgaEtJ9/V46bLx5Yfk1J/
X-Received: by 2002:a05:7301:4b03:b0:2c0:c903:4be1 with SMTP id
 5a478bee46e88-2c0e4e4fe47mr206289eec.0.1773769767240; 
 Tue, 17 Mar 2026 10:49:27 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e536896csm282115eec.3.2026.03.17.10.49.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:49:26 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 2/4] virtio-gpu: decouple Venus from CONFIG_OPENGL
Date: Tue, 17 Mar 2026 14:49:13 -0300
Message-ID: <20260317174915.31829-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174915.31829-1-lucaaamaral@gmail.com>
References: <20260317174915.31829-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Venus (virtio-gpu Vulkan context) currently requires an OpenGL
display backend due to build-time and runtime coupling.  On macOS,
no OpenGL display backend exists.

Remove the opengl.found() build requirement for the virtio-gpu-gl
module; virglrenderer provides Venus independently of OpenGL.

Gate GL-specific code paths behind CONFIG_OPENGL and display_opengl:
- Only advertise VIRGL/VIRGL2 capsets when display_opengl is set
- Only pass VIRGL_RENDERER_NO_VIRGL when !display_opengl with Venus
- Null out GL context callbacks when no GL display is available
- Route 2D display commands to the software renderer (pixman) when
  Venus runs without GL (venus no-GL mode)
- Allow Venus to bypass the OpenGL display check at device realize

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/meson.build        |  8 ++--
 hw/display/virtio-gpu-base.c  | 15 ++++++-
 hw/display/virtio-gpu-gl.c    |  6 ++-
 hw/display/virtio-gpu-virgl.c | 85 ++++++++++++++++++++++++++++++-----
 4 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041..509479e7 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -76,9 +76,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
   hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
 
-  if virgl.found() and opengl.found()
+  if virgl.found()
     virtio_gpu_gl_ss = ss.source_set()
-    virtio_gpu_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', virgl, opengl],
+    virtio_gpu_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', virgl],
                          if_true: [files('virtio-gpu-gl.c', 'virtio-gpu-virgl.c'), pixman, virgl])
     hw_display_modules += {'virtio-gpu-gl': virtio_gpu_gl_ss}
   endif
@@ -99,9 +99,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
                         if_true: files('vhost-user-gpu-pci.c'))
   hw_display_modules += {'virtio-gpu-pci': virtio_gpu_pci_ss}
 
-  if virgl.found() and opengl.found()
+  if virgl.found()
     virtio_gpu_pci_gl_ss = ss.source_set()
-    virtio_gpu_pci_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', virgl, opengl],
+    virtio_gpu_pci_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', virgl],
                              if_true: [files('virtio-gpu-pci-gl.c'), pixman])
     hw_display_modules += {'virtio-gpu-pci-gl': virtio_gpu_pci_gl_ss}
   endif
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index cb76302e..cc9704cd 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qapi/qapi-types-virtio.h"
 
@@ -157,7 +158,18 @@ virtio_gpu_get_flags(void *opaque)
     VirtIOGPUBase *g = opaque;
     int flags = GRAPHIC_FLAGS_NONE;
 
-    if (virtio_gpu_virgl_enabled(g->conf)) {
+    if (virtio_gpu_venus_enabled(g->conf)) {
+        /* TODO: set GRAPHIC_FLAGS_VK for direct Vulkan scanout */
+    }
+
+    /*
+     * TODO: virtio_gpu_virgl_enabled() checks VIRTIO_GPU_FLAG_VIRGL_ENABLED
+     * which is set for both OpenGL (VIRGL) and Vulkan (Venus) backends.
+     * This condition should ideally use a dedicated OpenGL-only flag. For
+     * now, display_opengl correctly gates GL scanout since Venus leaves it
+     * at 0.
+     */
+    if (virtio_gpu_virgl_enabled(g->conf) && display_opengl) {
         flags |= GRAPHIC_FLAGS_GL;
     }
 
@@ -273,6 +285,7 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     }
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
+        features |= (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);
     }
     if (virtio_gpu_context_init_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c4..1a95e6a7 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -124,7 +124,9 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    if (!display_opengl) {
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        /* Venus uses Vulkan in the render server, no GL needed */
+    } else if (!display_opengl) {
         error_setg(errp,
                    "The display backend does not have OpenGL support enabled");
         error_append_hint(errp,
@@ -245,4 +247,6 @@ static void virtio_register_types(void)
 type_init(virtio_register_types)
 
 module_dep("hw-display-virtio-gpu");
+#ifdef CONFIG_OPENGL
 module_dep("ui-opengl");
+#endif
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b7a2d160..2f9700e0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -19,8 +19,10 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
-
+#include "system/system.h"
+#ifdef CONFIG_OPENGL
 #include "ui/egl-helpers.h"
+#endif
 
 #include <virglrenderer.h>
 
@@ -50,6 +52,16 @@ struct virtio_gpu_virgl_resource {
     void *map_fixed;
 };
 
+/*
+ * Venus no-GL mode: Venus is enabled but no OpenGL display is available.
+ * Display commands use software (pixman) rendering; Venus/3D commands
+ * go through the virglrenderer render server.
+ */
+static bool virtio_gpu_venus_nogl(VirtIOGPU *g)
+{
+    return virtio_gpu_venus_enabled(g->parent_obj.conf) && !display_opengl;
+}
+
 static struct virtio_gpu_virgl_resource *
 virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
 {
@@ -63,7 +75,7 @@ virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
     return container_of(res, struct virtio_gpu_virgl_resource, base);
 }
 
-#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4 && defined(CONFIG_OPENGL)
 static void *
 virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 {
@@ -1032,6 +1044,45 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
+    /*
+     * Venus no-GL mode: route 2D display commands to the base software
+     * renderer (pixman). The guest kernel always uses 2D commands for
+     * display framebuffers even with VIRGL enabled; Venus/3D commands
+     * go through the virglrenderer render server as usual.
+     */
+    if (virtio_gpu_venus_nogl(g)) {
+        switch (cmd->cmd_hdr.type) {
+        case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
+        case VIRTIO_GPU_CMD_SET_SCANOUT:
+        case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
+        case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
+        case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
+        case VIRTIO_GPU_CMD_GET_EDID:
+            virtio_gpu_simple_process_cmd(g, cmd);
+            return;
+        case VIRTIO_GPU_CMD_RESOURCE_UNREF:
+        case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
+        case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING: {
+            /*
+             * Both 2D (simple) and blob (virgl) resources share g->reslist.
+             * Check if virglrenderer owns the resource to pick
+             * the right handler.
+             */
+            struct virtio_gpu_resource_unref hdr;
+            struct virgl_renderer_resource_info info;
+            VIRTIO_GPU_FILL_CMD(hdr);
+            if (virgl_renderer_resource_get_info(hdr.resource_id, &info)) {
+                /* Not in virglrenderer — it's a 2D software resource */
+                virtio_gpu_simple_process_cmd(g, cmd);
+                return;
+            }
+            break; /* virglrenderer owns it — fall through */
+        }
+        default:
+            break;
+        }
+    }
+
     virgl_renderer_force_ctx_0();
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_CTX_CREATE:
@@ -1433,6 +1484,7 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
     uint32_t flags = 0;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+#ifdef CONFIG_OPENGL
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
@@ -1450,9 +1502,14 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
+#endif /* CONFIG_OPENGL */
 #if VIRGL_VERSION_MAJOR >= 1
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
-        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+        flags |= VIRGL_RENDERER_VENUS
+               | VIRGL_RENDERER_RENDER_SERVER;
+        if (!display_opengl) {
+            flags |= VIRGL_RENDERER_NO_VIRGL;
+        }
     }
     if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_DRM;
@@ -1475,6 +1532,12 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 
+    if (!display_opengl) {
+        virtio_gpu_3d_cbs.create_gl_context = NULL;
+        virtio_gpu_3d_cbs.destroy_gl_context = NULL;
+        virtio_gpu_3d_cbs.make_current = NULL;
+    }
+
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
@@ -1546,14 +1609,16 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
 
-    /* VIRGL is always supported. */
-    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
+    /* OpenGL: VIRGL/VIRGL2 require a GL display backend */
+    if (display_opengl) {
+        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
 
-    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                               &capset_max_ver,
-                               &capset_max_size);
-    if (capset_max_ver) {
-        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_ver) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
+        }
     }
 
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
-- 
2.52.0


