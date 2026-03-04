Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD66CEF900B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR5-0003u4-4q; Wed, 04 Mar 2026 11:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR2-0003sl-Uc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR0-0002RY-Nv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:56 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-660fc3f30c1so1150707a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643053; x=1773247853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAB/auB+/ZlG8yg4/ASl1ctvXg5k+xmktjm09EQeMvc=;
 b=QgdBdAl/kkCfqz9auLPO6ShKsZ6Ghp9Iu2mBHksNGgdl+Lp8O++nYEuzr8NHTx+wVI
 s7qD9LuX2pm72Me05WYNRPmYNV+f53QXN192W1T9YN79G/KAv+WZ8p/ungJLyVVsrUrQ
 KhZ1PdMqKuoOq61MmDcReizfo8Gld0Oh0r9jzFuxSCFUUsIE9mUvkTlwUysi1x68ON+o
 3yxNKXCYyB+oilEzFwo0o5b7nDuNvGkaKUNj/8dcm+kfnZKixlkJ8AKyNhVzNA1sitQE
 2CfBOOjZAt+Mi/aOKL8cq6Qixfll/s37vlSOGxCg7AIsghrzb9MzEaV9SYTc2T1ZySkW
 bHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643053; x=1773247853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAB/auB+/ZlG8yg4/ASl1ctvXg5k+xmktjm09EQeMvc=;
 b=LD7sw9oX6UZVUPhnQIWfGET2ce12JcdQUuYaRVyCgYP5IVWxgo6X2eGUd6Fcyc8eb5
 8mtYnI/oLU8oBSBnovcmm+8ZR2MGNwjlez6xkC9F1An3lhYkkqvbAFd3rvB6RvkZlmwT
 GeA6dcLj51LULXEN4JjBR6Ep+5QAzA4/iu5Fb591c+npOhH7t4BvDF14pjXbYaYTvXLe
 YqhVoHk342rqvYstk81aOFRLSlC/jqQzAPJ/w4LOIpgDwTXsQg86b+OFwEv6OMzDdz/C
 tgfy3EYON1fXcaj912SMY6uPBi+ayIOSUFjWzH9eait3ZFy2ugZBbpN8oH6L+jIe4RW3
 Ogzw==
X-Gm-Message-State: AOJu0Yz4Ycd4I2jluOVIPRkYWyyC3CfeJNfyXQRcPSj/E2fVS0qviFgE
 sOLRuRUb9giDNl55g+FPWOmyTXIjQkXE4uFpZ2w4hkdwlguh6O//pThfUZEH5L61llk=
X-Gm-Gg: ATEYQzyS8uEEkXebQ2w5O8LdGe2pJSMExahJK34fMzn3obwFfnS+iiCOBjsRNgPCd91
 hsRfL0I9Z06loLOgXXFmw75OZmvJqClA7xtpu93ptDcmEYN9jzvUEd5Emwh32b+cpWKH7mpjXx2
 0gz6ncfYCnWufDJfs8op3tiZuB8c3fcmFDJLniCaPlPtGQtupSIgsaVLeII1wh/ad/iVKoOgj/Q
 eglzLWzzGGY+LWPji0qVZdOeaUr1rVxUSbUpQ9cLPwmMtGISkszHkqHl464iOykFtoIho4REBbH
 InTBquH76np/qrT3gf758CZFfdCQS2vcQNWVoTPQYkmgg2IG7tbkCHN/zitH3f5AoyQ/Nhwwmps
 BmZSGh/uEp0Hzl6uZaf+GdHBCkKkSUUADOkd39waG6X72CVzc42/vF6NPafGenHsv4hnro7DLSr
 3MIgqBPb1l8gnP4uZVwC2Vpz8=
X-Received: by 2002:a17:907:3ea5:b0:b93:3792:4b03 with SMTP id
 a640c23a62f3a-b93f1403760mr165938266b.32.1772643052806; 
 Wed, 04 Mar 2026 08:50:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-660f2cf4f81sm726768a12.2.2026.03.04.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4CB662D6C;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 11/20] virtio-gpu: Support asynchronous fencing
Date: Wed,  4 Mar 2026 16:50:33 +0000
Message-ID: <20260304165043.1437519-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Support asynchronous fencing feature of virglrenderer. It allows Qemu to
handle fence as soon as it's signalled instead of periodically polling
the fence status. This feature is required for enabling DRM context
support in Qemu because legacy fencing mode isn't supported for DRM
contexts in virglrenderer.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-10-dmitry.osipenko@collabora.com>
---
 meson.build                    |   2 +
 include/hw/virtio/virtio-gpu.h |  11 +++
 hw/display/virtio-gpu-gl.c     |   5 ++
 hw/display/virtio-gpu-virgl.c  | 127 +++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/meson.build b/meson.build
index e623f398be9..b51b4be2a55 100644
--- a/meson.build
+++ b/meson.build
@@ -2524,6 +2524,8 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.found()
   config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
+  config_host_data.set('VIRGL_VERSION_MINOR', virgl.version().split('.')[1])
+  config_host_data.set('VIRGL_VERSION_MICRO', virgl.version().split('.')[2])
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 65312f869dd..2610a32e408 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -233,6 +233,13 @@ struct VirtIOGPUClass {
                              Error **errp);
 };
 
+struct virtio_gpu_virgl_context_fence {
+    uint32_t ctx_id;
+    uint32_t ring_idx;
+    uint64_t fence_id;
+    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
+};
+
 /* VirtIOGPUGL renderer states */
 typedef enum {
     RS_START,       /* starting state */
@@ -250,6 +257,9 @@ struct VirtIOGPUGL {
     QEMUTimer *print_stats;
 
     QEMUBH *cmdq_resume_bh;
+
+    QEMUBH *async_fence_bh;
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
 };
 
 struct VhostUserGPU {
@@ -380,5 +390,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
 
 #endif
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2ef987..3e0680880e1 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -169,6 +169,11 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     if (gl->renderer_state >= RS_INITED) {
 #if VIRGL_VERSION_MAJOR >= 1
         qemu_bh_delete(gl->cmdq_resume_bh);
+
+        if (gl->async_fence_bh) {
+            virtio_gpu_virgl_reset_async_fences(g);
+            qemu_bh_delete(gl->async_fence_bh);
+        }
 #endif
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             timer_free(gl->print_stats);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f00c666f61f..ae1880c358b 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -24,6 +24,23 @@
 
 #include <virglrenderer.h>
 
+/*
+ * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixed
+ * in 1.1.0. Undefine bugged version of the macro and provide our own.
+ */
+#if defined(VIRGL_CHECK_VERSION) && \
+    VIRGL_VERSION_MAJOR == 1 && VIRGL_VERSION_MINOR < 1
+#undef VIRGL_CHECK_VERSION
+#endif
+
+#ifndef VIRGL_CHECK_VERSION
+#define VIRGL_CHECK_VERSION(major, minor, micro) \
+    (VIRGL_VERSION_MAJOR > (major) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR > (minor) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR == (minor) && \
+     VIRGL_VERSION_MICRO >= (micro))
+#endif
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
@@ -1079,6 +1096,103 @@ static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
 }
 #endif
 
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
+{
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    while (!QSLIST_EMPTY(&gl->async_fenceq)) {
+        f = QSLIST_FIRST(&gl->async_fenceq);
+
+        QSLIST_REMOVE_HEAD(&gl->async_fenceq, next);
+
+        g_free(f);
+    }
+}
+
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+static void virtio_gpu_virgl_async_fence_bh(void *opaque)
+{
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    if (gl->renderer_state != RS_INITED) {
+        return;
+    }
+
+    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
+
+    while (!QSLIST_EMPTY(&async_fenceq)) {
+        f = QSLIST_FIRST(&async_fenceq);
+
+        QSLIST_REMOVE_HEAD(&async_fenceq, next);
+
+        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
+            /*
+             * the guest can end up emitting fences out of order
+             * so we should check all fenced cmds not just the first one.
+             */
+            if (cmd->cmd_hdr.fence_id > f->fence_id) {
+                continue;
+            }
+            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
+                    continue;
+                }
+                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
+                    continue;
+                }
+            }
+            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+            QTAILQ_REMOVE(&g->fenceq, cmd, next);
+            g_free(cmd);
+        }
+
+        trace_virtio_gpu_fence_resp(f->fence_id);
+        g_free(f);
+        g->inflight--;
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
+        }
+    }
+}
+
+static void
+virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
+                                  uint32_t ring_idx, uint64_t fence_id)
+{
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    f = g_new(struct virtio_gpu_virgl_context_fence, 1);
+    f->ctx_id = ctx_id;
+    f->ring_idx = ring_idx;
+    f->fence_id = fence_id;
+
+    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
+
+    qemu_bh_schedule(gl->async_fence_bh);
+}
+
+static void virgl_write_async_fence(void *opaque, uint32_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, 0, UINT32_MAX, fence);
+}
+
+static void virgl_write_async_context_fence(void *opaque, uint32_t ctx_id,
+                                            uint32_t ring_idx, uint64_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
+}
+#endif
+
 static virgl_renderer_gl_context
 virgl_create_context(void *opaque, int scanout_idx,
                      struct virgl_renderer_gl_ctx_param *params)
@@ -1178,6 +1292,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
     virgl_renderer_reset();
+
+    virtio_gpu_virgl_reset_async_fences(g);
 }
 
 int virtio_gpu_virgl_init(VirtIOGPU *g)
@@ -1190,6 +1306,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+        virtio_gpu_3d_cbs.write_fence         = virgl_write_async_fence;
+        virtio_gpu_3d_cbs.write_context_fence = virgl_write_async_context_fence;
+        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
+        flags |= VIRGL_RENDERER_THREAD_SYNC;
+#endif
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
@@ -1223,6 +1345,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     gl->cmdq_resume_bh = virtio_bh_io_new_guarded(DEVICE(g),
                                                   virtio_gpu_virgl_resume_cmdq_bh,
                                                   g);
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+    gl->async_fence_bh = virtio_bh_io_new_guarded(DEVICE(g),
+                                                  virtio_gpu_virgl_async_fence_bh,
+                                                  g);
+#endif
 #endif
 
     return 0;
-- 
2.47.3


