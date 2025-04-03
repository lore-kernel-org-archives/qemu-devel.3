Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E74C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OZZ-0006sI-KA; Thu, 03 Apr 2025 13:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1u0Msm-0003nM-1V
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:53:32 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1u0Msk-0000Ms-Db
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:53:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22435603572so11050685ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743695607; x=1744300407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=REwPsuC/Zo+NZ1xL2bWVm+fPOTfIvVA3rA4SqfRMqiM=;
 b=G6rT5ijwB8I2X+4rMbPx/2So1xkFODBzr7xaPwTAVFbVRuPh6kgzry0dHvh+LamooR
 cgob7FrFAavC125w0rVMqWEPotmU2UHMeD96FDvpk694RoHMiOWZqEXwaWzdsK0IAeCf
 T3N+LU5dal5bn8W7Hr4CuRWRXh7OZfpSm3jSTawHz6obENIYcrRAMp08+IEIzoYIEDvQ
 SpYfyiG/9/zaMeVVhOkb+Jh090pdI0uobltcBApjrHcKs4AIUGvcD4CHGQ7+AvX5GZqq
 xWed69mxdpEW/D+PkCU1FsroOJnvzqDpV2TS5jszIwZuNkWqzsGhAglbzGUgjzZjGEzs
 H+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695607; x=1744300407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REwPsuC/Zo+NZ1xL2bWVm+fPOTfIvVA3rA4SqfRMqiM=;
 b=V1sRGwYKYD6XQfwPPtLE7586v/dXL+MAf8ftz0I9NIkejrYQYSEiOAeie1JpDgMXmn
 Q3MMQZ6HYLwxNtxs67yfDNbr1x/bNL+uUY4WgpPgSkxiDW7lYDRV58iPlsUqhQtWqgIf
 Kg/tpRdbdPHhnKFzGdVHhYi4ePUXZAd+YmpUce/wToeAtdyCx3fKn23+1b9vFcy0r7H+
 UwTxam+6DC87oPsl1I4SZv6kOMCIrX904uyNN+cKC8KMPzcfPSd3DPJGLnZtbGXNkQsN
 hM6SclJILhxAl4qOA4oakCujbgbxKJx4jxcgXtJl6fmo2ed1SYgVDuGZ0Cy1PWdM4VCP
 kM/w==
X-Gm-Message-State: AOJu0YyMMTeodOfq4uXkaLicmpZyMo5C30QWWNjJJ0PxmO9uSFu94+v8
 Mru9pJ6OLmdpyxuD/CJmGT5WBAd1HyieMypGpBAVBXmtXzaG9rTAzNfdhikTbZI=
X-Gm-Gg: ASbGncuca8TH4IVVNis6bFbFyf1r0E5HPGRNPdpyWLhMGuNo2YV0hDY1RwSYM3T8D8o
 o9+ZCVPhz29XO1swm54VmOgoX1YFS/n+p0CdcoybWd8DLRrobtdqMQEAyIsNuBmv1i3Lvf7qRS8
 GrZTU6tosg/omdeswLaFP8cA5y7PlhwoMENQBtnsB/yO1GtT9+pMhpwno82aVoFAgqYHKk/M6n0
 Yq2Z0B2LkrNdyLyXuTwrZVNqCqyGQfWpSClmP7KpiReqcpYPrlLXJ5/2NDtlyHKkPRKv1B2ykN+
 jXaXKGxWJIOafVzEHEgHXZjQ9UZblTENjRTa04g/pCL/ZDDl3BTHcbD0TQ==
X-Google-Smtp-Source: AGHT+IG9gH2hGcbB5UsFFVVR5XvABwb8V37MV2soiPH2zx4dvR+kkN/JZCAa9SuT0sXauud0z7AoPg==
X-Received: by 2002:a17:903:19ef:b0:223:33cb:335f with SMTP id
 d9443c01a7336-2292f9493e3mr327512825ad.3.1743695607136; 
 Thu, 03 Apr 2025 08:53:27 -0700 (PDT)
Received: from desktop.lan ([112.32.32.142]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f36besm1664772b3a.72.2025.04.03.08.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 08:53:26 -0700 (PDT)
From: Jiang XueQian <jiangxueqian@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jiang XueQian <jiangxueqian@gmail.com>
Subject: [PATCH] virtio-gpu-gl: Add 'serverfd' property
Date: Thu,  3 Apr 2025 23:51:29 +0800
Message-ID: <20250403155129.3396821-1-jiangxueqian@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jiangxueqian@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Apr 2025 13:41:35 -0400
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

This property passes socket of a externally started virgl_render_server
to virglrenderer, so that it won't try to spawn new process and get
killed by seccomp, allowing virtio-gpu-gl venus and sandbox to enable
at the same time.

Signed-off-by: Jiang XueQian <jiangxueqian@gmail.com>
---
 hw/display/virtio-gpu-gl.c     | 15 +++++++++++++++
 hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
 include/hw/virtio/virtio-gpu.h |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 683fad3bf8..e7c89f7c29 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/qdev-properties.h"
+#include "monitor/monitor.h"
 
 #include <virglrenderer.h>
 
@@ -143,6 +144,17 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
+    if (g->parent_obj.conf.serverfd) {
+        g->parent_obj.conf.serverfd_parsed =
+            monitor_fd_param(monitor_cur(), g->parent_obj.conf.serverfd, errp);
+        if (g->parent_obj.conf.serverfd_parsed < 0) {
+            error_prepend(errp, "unable to parse serverfd: ");
+            return;
+        }
+    }
+#endif
+
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
     g->capset_ids = virtio_gpu_virgl_get_capsets(g);
     VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
@@ -159,6 +171,9 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
+    DEFINE_PROP_STRING("serverfd", VirtIOGPU, parent_obj.conf.serverfd),
+#endif
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b3879..420aae3b05 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1030,6 +1030,19 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
                                    qctx);
 }
 
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
+static int virgl_get_server_fd(void *opaque, uint32_t version)
+{
+    VirtIOGPU *g = opaque;
+
+    if (g->parent_obj.conf.serverfd) {
+        return g->parent_obj.conf.serverfd_parsed;
+    }
+
+    return -1;
+}
+#endif
+
 static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
     .version             = 1,
     .write_fence         = virgl_write_fence,
@@ -1097,6 +1110,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     uint32_t flags = 0;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
+    virtio_gpu_3d_cbs.version = 3;
+    virtio_gpu_3d_cbs.get_server_fd = virgl_get_server_fd;
+#endif
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a42957c4e2..40a81f500c 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -128,6 +128,8 @@ struct virtio_gpu_base_conf {
     uint32_t xres;
     uint32_t yres;
     uint64_t hostmem;
+    char *serverfd;
+    int serverfd_parsed;
 };
 
 struct virtio_gpu_ctrl_command {
-- 
2.49.0


