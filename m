Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A312DFD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09J1-00016h-Hj; Tue, 10 Mar 2026 22:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Iq-0000s2-3A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:08 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09In-0003v5-F1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:03 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12732165d1eso15305839c88.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196080; x=1773800880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2azvhenDuoU6WjYUo29+uag0Q0mEkgR7SmdStxi/ig=;
 b=MX1auBrTTf8K6XFV2hCi4TWF5ntvJJSxeUN/5sZi5dGP+6uHY2sr/K0sJTz/cR6s39
 GcTI8mul0KzEu+cGjOH5/SBTY/Z3JjKiLYIRar0gquEpeGUNwvW5ypGt7z0ElHaphRBZ
 cZHsVx/P2mjhGS57qYtN3uCT+8NGSPFGt5jqSIsQJ6kqeIHr59BItv1lanSJVpRb1iTB
 GASBNlqWulL3cz+hnkN/x8QYQbBSZu8VEG2ZgnCZMThrDHE9fU0YP9ss1QqtK1A7Om7Q
 iLRUGFCL7VdkVz2z3hFUx2oPr1MGtjmWrlh5dMkzvg5YUtDPKSWXIihBmA2afZtkEyV6
 8/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196080; x=1773800880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M2azvhenDuoU6WjYUo29+uag0Q0mEkgR7SmdStxi/ig=;
 b=WGl+VuhnyN4WRoBFsyKOncKNAaLywMYOpKRIrtGdGEzVG2BAR3GzUePDrRCPJQK5m1
 rTtRBj+AhoSIDwODDPGM0OMaBsNL8OE0mc1RlWf5LN1ZQjBFlSmlKCLdM7AccpEbAguK
 qi32UAkfuI2alB9rZDNu5vK+roj27MNWaM5LO5LMfWgenjkAYpJd9bdNKlo4+bo4Zkic
 zhAAy675Agm7C1gzc/YNC3cRRpdaK301Zgsc8VOm8Cr2hV3pvtrphn1tSiX7TD+hzZP9
 Tv0b8XbL3oXowm0T5y7SYgxFQNnHHOBlzJIaq8t9OwvLEXAFN6TmZHF/U/r0BIYeTJ0M
 mJ0w==
X-Gm-Message-State: AOJu0YwZrO4NKdIbBRWTyDUqqO2dCKM9tLiMFSc2IUc5nlP1BjNN0cTN
 xvO6nt5ocZ7mQv0Ym+paK2Mzhfn/EJEhgNfqat5lMVT9mw1jX+NqIupXe7iznw==
X-Gm-Gg: ATEYQzx7D+m8DBsnGNO/kR6kXargt4afw+gkpS3LUb2A2sbmHlOkZgUJ2GMT9iPock/
 GfYNGcqbWpMfBn5cqYGnt645YBkrpII3QhQZIa16nRvT/2NNArF88U5fUl4lXbo58YrfoPo/RPa
 taI1E3aVYoNFWvlnjs+4gFRqoDDyhXPNKZ9yr6aM0+nEpnSrxIhuVe0l+SbtmRJR8W2ZWsjUWMp
 P2HTElj83TDNIIaiBMQC2dyhXCV1YCpjgfvaglvIE6uDiuMj+i/82179qot1iqaYJBDspMVNT/z
 P/mAA8GguqGif7QRInJscRUGrnOUpGwmRiPPmzkFYOuS5ATyP5GN3KWKx/N4TMgWDNFpAl/WYhF
 YfZ7vdyqyxCyXPYvCLZKqt05CXdtU4wzrfZlOWfL6CtjEinFefhJ0Wnpx5TcstpqQpPYwvdJeRz
 6Qmws5WVrWfK+qPjYscSDclqkC42zypiYWktW2F5xGmnXSYWewQE4=
X-Received: by 2002:a05:7022:68a9:b0:128:d375:f1cc with SMTP id
 a92af1059eb24-128e77a8ad6mr424952c88.12.1773196079614; 
 Tue, 10 Mar 2026 19:27:59 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7cd6aafsm915123c88.14.2026.03.10.19.27.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:27:59 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 2/3] virtio-gpu: decouple Venus from CONFIG_OPENGL
Date: Tue, 10 Mar 2026 23:27:51 -0300
Message-ID: <20260311022752.64192-3-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022752.64192-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
 <20260311022752.64192-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 hw/display/virtio-gpu-virgl.c | 84 ++++++++++++++++++++++++++++++-----
 4 files changed, 97 insertions(+), 16 deletions(-)

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
index 7269477..dd93b65 100644
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
 
@@ -257,6 +269,7 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     }
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
+        features |= (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);
     }
     if (virtio_gpu_context_init_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2e..b5526cd 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -133,7 +133,9 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    if (!display_opengl) {
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        /* Venus renders via Vulkan in the render server — no GL display needed */
+    } else if (!display_opengl) {
         error_setg(errp,
                    "The display backend does not have OpenGL support enabled");
         error_append_hint(errp,
@@ -217,4 +219,6 @@ static void virtio_register_types(void)
 type_init(virtio_register_types)
 
 module_dep("hw-display-virtio-gpu");
+#ifdef CONFIG_OPENGL
 module_dep("ui-opengl");
+#endif
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f75482..66a70e3 100644
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
@@ -903,6 +915,44 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 
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
+             * Check if virglrenderer owns the resource to pick the right handler.
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
@@ -1169,6 +1219,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     uint32_t flags = 0;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+#ifdef CONFIG_OPENGL
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
@@ -1180,12 +1231,23 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
@@ -1223,14 +1285,16 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 
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


