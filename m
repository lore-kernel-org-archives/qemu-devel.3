Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAA606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rIoTsG9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKGq-0004bf-1L; Mon, 26 Oct 2026 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oumeng086@gmail.com>)
 id 1xLEiq-0002OQ-8O
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:02:20 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oumeng086@gmail.com>)
 id 1xLEio-0008Qa-8B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:02:19 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso859516a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 00:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792998136; cv=none;
 d=google.com; s=arc-20260327;
 b=RJECTozwCmIEWP6CqGVeys2VRRJL90XXg7nZBG+sy1CcyZM34F3+DxLWcI5dk/Mo9b
 l58Wril2krqlyz30d0Ke7xZADCTmKZzKePLkQQHdiluXt1Ynh+mkFIZIeNaJfWu/muVq
 LI2PnlIjvCrWz6eSytUAJYi2tXY5JaStWUYn1QJZHf7mlUrriE+c9GgeJtsAhgqToPVz
 yFlJRopSqwx1171bXAzmc+Uh35Cp//50T0IPE2oAl8NV8z+FUitytoKh/yg8H88yJi4+
 cjfxplDStJ0vDH97DQSZLckx4wroXLMLQ0vNAOJy/LzVFqfUKncJMV1TvjwoDV724xb7
 rivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=j5kDaAotKNOG2Le8IgejclKvNtJ+pK7P/qatmpjPobE=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=KrnDZD2z7+7wEOwee00WbhSctnAwwPKUCwZWpc4J6DG7XsSHXQL/KdPobmrgLhy/W8
 Iy2uHU+8CxjgxD1DAIC1XamIfKnzbPlw+53RUpklS99Xy/vIWZ+pdwvV/h1DZ3siWEA6
 Lvrs6+Cgn+7mf9NkZta5PmENJoKuu7avIMzZYp1HU41vtUOenNDPchBLrUflwme3m8T0
 KlvfEL94Ca6SjU3FYBKo6hZCAlPCm6hz8GOOvAg7EnSzswJXrrudamgYjGME2j8krynJ
 4JepYCw+1GTgemV9dflgAkohbje4dfuyY8Wh2oV0HkAAzmESySet4itz2fQcabs8dq1N
 488Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792998136; x=1793602936; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j5kDaAotKNOG2Le8IgejclKvNtJ+pK7P/qatmpjPobE=;
 b=rIoTsG9vBpAKi+VSg3+0B4VZmrIM+Hfy5zbebFf57wqYUldAs1TAfM6vgdB3ev8iNs
 A7KYY/v88f7JZ3RI93ffuSoUgFwjQjSf8Qca8FLGOvg5OH1soC3Oqaz65YECI3LVRvTn
 jN12lV/HgIi56NzcaGjAmfDuu9FL8jbL7wucw7iFYFhXnT2VRCCsuQAvG+aKf+25cI6e
 WylCXv2EYOjSwERGsMxw1WgQrDA2b57dEKBYzWJjIkz1xmCyVxG5TjRkGoRcusB8Fi1d
 7upuV6pAK/ZdA20d/jY/z5ChlWX32S+06mLP5DgDlxSIU0XwwhYjXzAqc+goAnCxEFo9
 10fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792998136; x=1793602936;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j5kDaAotKNOG2Le8IgejclKvNtJ+pK7P/qatmpjPobE=;
 b=UoNcNYSxqbJAiiZXTE5yo8l5Wv4VSnHWS+DEUyZ2tjD19HvH/wEzO/XMLntRZ1gqq7
 2BsrJdwEg96l/KJJu3EN3LaIKjH3XfdtZ23qYzYtbCcMYSkXmweoK0awN3lB/2FHb3jD
 L1gsXeyu4Nuw+1+ZgeEF5fIUc+TukinZ0A5abl/Kx88TGzM+xVBo2W6nIVd6P7b132fG
 w8V/kG05w/2IDCcSAYLSlbASzH9T94Uw8ichnhp3q4iFpOWsgwzCgYPZjUeo7uQz4cEX
 AyGoM/114K+NpkmXcYeS2VJrmCJ96rl1PXbEgwpBi0/sczu8+iVWVsGoUEfy8zz6YaNu
 ZeBA==
X-Gm-Message-State: AFq9FYKLuVYToTZiRwazJ1LfW8KqvBInp3IgKnZJziDi/lNqy3ZG9roW
 pvvfVchVqJqJ+pmMzgIA41diNnyI7I6fvxKDMHu1f276bqt9B3RrrKDHUIGwdRSVLAbCw/r46oQ
 RUQQgiA442I9MKp0VfZyfhSIoXD8ffYw2dS1gbRQYauwh
X-Gm-Gg: AYBFou2dBwjeGPExACKPzfhXmL+Pt82whvLdLnzkSo/c55MMT/RGbJTKEGKi8731Lkg
 Cno9F/MBWfKyzrrZDj17HFTfRXzxBFKK2y4/W9n9rN4Q0QEOBKZxmp8fHsKTpYSBpX+b+j1y3ud
 uCwuMmIjuGqdqgBkrcY0tBPeQF9fnaMmRkFLWBFudxGjGngUsjxjFoeZwV7jgDia8btIuSA4ryj
 5G3lWJDqLDOIXm3mGRw59Fuq4Zpr6hEcMuSVdajtM3Ejt8iDGe5AOKy+9otVunUZUS5LMSWpvJb
 gfS+86yYVCYYuU20AlYuH2+vI/kIwxxGE9/b1rR0vLIFBPJ0O+QzrDhbvTj3fKRbiB/Td3TEOuZ
 VLOtAAIDmeEKp0RLxuWhgQb3uXD6oHt9XoP5qrw==
X-Received: by 2002:a17:90b:3a48:b0:3ad:6ec8:35cf with SMTP id
 98e67ed59e1d1-3adeae70722mr5084301a91.51.1792998135986; Mon, 26 Oct 2026
 00:02:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: meng ou <oumeng086@gmail.com>
Date: Mon, 26 Oct 2026 15:02:00 +0800
X-Gm-Features: AclHuK8wWOe2nClNzxGLUpwInmAKraDKlS8esLB37FLVyNMvHFVVeQB_Iji7gyE
Message-ID: <CAPSUqz14daiP8DvLBzcMwBzmpCmMe9B25Q2CFO6s8joCnfW-_Q@mail.gmail.com>
Subject: [PATCH] virtio-gpu: run scanout reset cleanup on the main loop thread
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=oumeng086@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:57:46 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio-gpu: run scanout reset cleanup on the main loop thread

virtio_gpu_gl_reset() executes in the context of the thread that wrote the
device reset register, i.e. a TCG vCPU thread.  It calls
virtio_gpu_virgl_reset_scanout() -> egl_scanout_disable() ->
egl_fb_destroy() -> glDeleteFramebuffers(), which requires the display EGL
context to be current on that thread.  It is not:

  #01 egl_fb_destroy                ui/egl-helpers.c
  #02 egl_scanout_disable           ui/egl-headless.c
  #04 virtio_gpu_virgl_reset_scanout
  #05 virtio_gpu_gl_reset           hw/display/virtio-gpu-gl.c
  #11 do_st_mmio_leN                accel/tcg/cputlb.c

Hosts whose GL implementation dereferences the missing context crash.  This
was reproduced on Android/aarch64 with both zink and llvmpipe, which makes
it a threading bug rather than a driver bug.

Defer the cleanup to the main loop: add a VirtIOGPUClass reset_scanout
callback, invoke it from the existing virtio_gpu_reset_bh() before
reset_finished is signalled, and reduce virtio_gpu_gl_reset() to setting
renderer_state to RS_RESET.

Signed-off-by: oumeng <q15817976513@163.com>
---
 hw/display/virtio-gpu-gl.c     | 13 ++++++++++++-
 hw/display/virtio-gpu.c        |  5 +++++
 include/hw/virtio/virtio-gpu.h |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c..9a93fdf 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -99,7 +99,8 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
      * thread, and when the renderer is unblocked.
      */
     if (gl->renderer_state == RS_INITED) {
-        virtio_gpu_virgl_reset_scanout(g);
+        /* scanout cleanup is deferred to virtio_gpu_reset_bh() which runs
+         * on the main loop thread (reset_scanout class callback). */
         gl->renderer_state = RS_RESET;
     }
 }
@@ -209,6 +210,15 @@ static void
virtio_gpu_gl_device_unrealize(DeviceState *qdev)
      */
 }

+static void virtio_gpu_gl_reset_scanout(VirtIOGPU *g)
+{
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    if (gl->renderer_state == RS_INITED) {
+        virtio_gpu_virgl_reset_scanout(g);
+    }
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -222,6 +232,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
*klass, const void *data)
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;

     vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
+    vgc->reset_scanout = virtio_gpu_gl_reset_scanout;
     vdc->realize = virtio_gpu_gl_device_realize;
     vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5d43ffb..4a2789f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1841,6 +1841,11 @@ static void virtio_gpu_reset_bh(void *opaque)
         qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
     }

+    /* scanout/GL cleanup must run here, on the main loop thread */
+    if (vgc->reset_scanout) {
+        vgc->reset_scanout(g);
+    }
+
     g->reset_finished = true;
     qemu_cond_signal(&g->reset_cond);
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 631dfc6..91072b0 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -234,6 +234,7 @@ struct VirtIOGPUClass {
     void (*resource_destroy)(VirtIOGPU *g,
                              struct virtio_gpu_simple_resource *res,
                              Error **errp);
+    void (*reset_scanout)(VirtIOGPU *g);
 };

 struct virtio_gpu_virgl_context_fence {
-- 
2.53.0

