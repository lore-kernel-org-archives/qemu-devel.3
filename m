Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC333FCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu5-0003OQ-TQ; Mon, 09 Mar 2026 18:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTw-0000wg-5q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:44 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTu-0002FF-1B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:43 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2be4781d2baso8408142eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092980; x=1773697780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSPh/+vq5xols2V8eYLNVaZ56CQbQABrVTIm10x7/7Y=;
 b=Gl3LFUQ3jwuFwBTz5t8hVuO7SLsGi00IXpWPKK6bD7TdhuqjQjX2cMD5V0sclQl3Ha
 dU/sd2JL+GkhzMaT64oLVWJ8JREdW+7UoymPCYzcl+BED4Ogjg5LQnUgQlsVjJizxw7B
 KiB7HCh1Pz2+jhswc0ZmJu02EZ/eQt/pz0+GU5O+Jo0R7ErqVozVD2PrwbN3vGl8R52g
 sbnekUl8kHt74KRHnZZFUNAyHVdhLkoox75Oexm9bhIGVv9ApUeIBqWd4RouUmeCIyjN
 zpFwhXsHnwLk10DC3AuWqiAy1/gdnJZNKA8YbPRWpqWHN/CvRLlL93rT13c2s5QZ/4Fv
 Pz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092980; x=1773697780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSPh/+vq5xols2V8eYLNVaZ56CQbQABrVTIm10x7/7Y=;
 b=XrzWecxCrwsPI+ZRGSXn0gJzzg7AaHXdASlJSO7yjgA59jBAds0qTqH260QogHQjQJ
 XGDTV9eiCrpK70+Ov3eLnuk4nHm644RydCTR+nYM1r3CMc8n5LwZ6v6mHUEq7M4qTyAY
 kOqMvBEC/4XMDF8ye98KsuO3Wa0xstZf70yUjTgwAfjhjpjQACJqEXP0iYg2fFWFlTiS
 oqv4bI/lnweRnM3yyV2jjBtIYRR4FxFg7FxSV0tlEkRLW0sD1oG9x+GJtHWsVmpUnuIU
 DiVzQvilE0yO4fdiSEFAXj0JVAXYxlvjkS49JFdMHAnH4Kj/oQ/9elSt3krkJcJjtYG1
 WgbA==
X-Gm-Message-State: AOJu0Yw8WIY0tj/4r1DjgvuBJX8qp7fPG+9Cp3PdhM5c7yFUYjQyhpZ5
 ZF+/Tn85SjmisuYCSuWxhoP2XDQZAX9urMCFIEViQAujphApYa3t4NyF7i8UkVAi
X-Gm-Gg: ATEYQzyJy14xca+Uq69i5QnxFlzoMIFarrzCo5Ax65XzJwWW9echR/fqkGAb60y+b+Q
 f22vRsXkWBqccJw/LVdZ2aAV+IFMCQP34yYHN3vxTpTVYf0SYi7oL8E/Z3YIY8e99J/p1chQIVg
 gKbNij7ByDhz/qZvsnRVqwnenEoguRzgc7zCYFyXsyiUupAMjfunZSmfLJYlzK9oPdEvVC0Wcj5
 xFNEgARBE/RojFmecz9c8orapfDvjHCrv3rD50O+rKNgZVctKG0/DMmyfiUozA3ige0lpMdpyAa
 /NldvT1tOvPP6WWTBMXuk1WJzLIVOUX/bK/XC68SNjcUOfQ6Euq2G2ygGxfih8/Hf5LWnZDsqdt
 MreeSlI0QfgMxispagOCfEHlyfojSJus7cd7JigeKi17Lk9YUy9A16E2kRqLulmEfs7RKp4f67q
 6sY2JAud1xPC1lkIv4EBzwIwv3rgqdAfMVoeUgXFHeV2y0IylT7rDujys+9omIM4PAv22bvA==
X-Received: by 2002:a05:7300:e619:b0:2be:22e9:2178 with SMTP id
 5a478bee46e88-2be4dff6135mr5235592eec.17.1773092980210; 
 Mon, 09 Mar 2026 14:49:40 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f96f25bsm10519495eec.28.2026.03.09.14.49.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:39 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 2/3] virtio-gpu: decouple Venus from CONFIG_OPENGL
Date: Mon,  9 Mar 2026 18:49:29 -0300
Message-ID: <20260309214930.92616-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214930.92616-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

Introduce GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
Vulkan scanout support alongside the existing GL and DMABUF paths.

Gate Venus at device realize when the HVF map granule exceeds the
guest page size; this ensures blob mappings succeed at runtime.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/meson.build        |  8 ++--
 hw/display/virtio-gpu-base.c  |  8 +++-
 hw/display/virtio-gpu-gl.c    | 17 ++++++-
 hw/display/virtio-gpu-virgl.c | 89 ++++++++++++++++++++++++++++++-----
 include/ui/console.h          |  2 +
 ui/console.c                  |  7 +++
 6 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c04..509479e 100644
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
index 7269477..faee6dc 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/display/edid.h"
+#include "system/system.h"
 #include "trace.h"
 #include "qapi/qapi-types-virtio.h"
 
@@ -157,7 +158,11 @@ virtio_gpu_get_flags(void *opaque)
     VirtIOGPUBase *g = opaque;
     int flags = GRAPHIC_FLAGS_NONE;
 
-    if (virtio_gpu_virgl_enabled(g->conf)) {
+    if (virtio_gpu_venus_enabled(g->conf)) {
+        /* TODO: set GRAPHIC_FLAGS_VK for direct Vulkan scanout */
+    }
+
+    if (virtio_gpu_virgl_enabled(g->conf) && display_opengl) {
         flags |= GRAPHIC_FLAGS_GL;
     }
 
@@ -257,6 +262,7 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     }
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
+        features |= (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);
     }
     if (virtio_gpu_context_init_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2e..e55fe87 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -17,6 +17,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/system.h"
+#include "system/hvf.h"
+#include "exec/target_page.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
@@ -133,7 +135,18 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    if (!display_opengl) {
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        /* Venus renders via Vulkan -- no GL display needed */
+        uint64_t map_gran = hvf_get_map_granule();
+        if (map_gran > qemu_target_page_size()) {
+            error_report("Venus disabled: host map granule (%zu) > guest "
+                         "page size (%zu). Requires macOS 26+ or guest "
+                         "F_BLOB_ALIGNMENT support.",
+                         (size_t)map_gran, qemu_target_page_size());
+            g->parent_obj.conf.flags &=
+                ~(1 << VIRTIO_GPU_FLAG_VENUS_ENABLED);
+        }
+    } else if (!display_opengl) {
         error_setg(errp,
                    "The display backend does not have OpenGL support enabled");
         error_append_hint(errp,
@@ -217,4 +230,6 @@ static void virtio_register_types(void)
 type_init(virtio_register_types)
 
 module_dep("hw-display-virtio-gpu");
+#ifdef CONFIG_OPENGL
 module_dep("ui-opengl");
+#endif
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f75482..826d6d7 100644
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
 
@@ -29,6 +31,16 @@ struct virtio_gpu_virgl_resource {
     MemoryRegion *mr;
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
@@ -42,7 +54,7 @@ virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
     return container_of(res, struct virtio_gpu_virgl_resource, base);
 }
 
-#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4 && defined(CONFIG_OPENGL)
 static void *
 virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 {
@@ -903,6 +915,45 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 
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
+                /* Not in virglrenderer -- it's a 2D software resource */
+                virtio_gpu_simple_process_cmd(g, cmd);
+                return;
+            }
+            break; /* virglrenderer owns it -- fall through */
+        }
+        default:
+            break;
+        }
+    }
+
     virgl_renderer_force_ctx_0();
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_CTX_CREATE:
@@ -1169,6 +1220,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     uint32_t flags = 0;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+#ifdef CONFIG_OPENGL
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
@@ -1180,12 +1232,23 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
@@ -1223,22 +1286,26 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 
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
 
+    /* Vulkan: Venus capset (gated at device realize if needed) */
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
                                    &capset_max_ver,
                                    &capset_max_size);
         if (capset_max_size) {
-            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VENUS);
+            virtio_gpu_virgl_add_capset(capset_ids,
+                                        VIRTIO_GPU_CAPSET_VENUS);
         }
     }
 
diff --git a/include/ui/console.h b/include/ui/console.h
index 98feaa5..fa7fdec 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -361,6 +361,8 @@ enum {
     GRAPHIC_FLAGS_GL       = 1 << 0,
     /* require a console/display with DMABUF import */
     GRAPHIC_FLAGS_DMABUF   = 1 << 1,
+    /* require a console/display with Vulkan scanout */
+    GRAPHIC_FLAGS_VK       = 1 << 2,
 };
 
 typedef struct GraphicHwOps {
diff --git a/ui/console.c b/ui/console.c
index f445db1..d53dc10 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -594,6 +594,13 @@ static bool console_compatible_with(QemuConsole *con,
         return false;
     }
 
+    if (flags & GRAPHIC_FLAGS_VK) {
+        error_setg(errp,
+                   "The console requires Vulkan scanout "
+                   "(not yet implemented).");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.52.0


