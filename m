Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D8FEFCE5F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 04:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy0HP-0002jg-VO; Wed, 04 Mar 2026 23:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ugWpaQQKCr0unlujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--rkir.bounces.google.com>)
 id 1vy0HK-0002jE-62
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 23:25:38 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ugWpaQQKCr0unlujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--rkir.bounces.google.com>)
 id 1vy0HI-0002yn-0O
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 23:25:37 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b630753cc38so35211684a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 20:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772684731; x=1773289531; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zmWuZMm9qYkKyEuxzdgGzX/TxOaZzKIIsrN0QTku0QM=;
 b=Yv2bxpBffRueJX9EToKToXWYyEAvYSUNV8xMPb1QeStU0owfnxdVBYzGK25q/IPPxQ
 yQay1uHEQ2kZxbrXUxVHq3S22diTVyrFAPj4cFKz87eDo6GMLu2SJLZCG/X/V3D0pi8D
 fkiv/tlxo4qowR/gDvD8EprvvNwIM7df3h29DF9jzuAxKzChpYcxZRXkZ3c9H8kI5vNI
 owSWCVEql23WoExEoK/aoWZ+NP/1AFXTL0v2c4KrM6HD1sOtaqLWJ3OwVkfHN+mTCxEe
 5KtJQpP2XA7K0zYComsp3ewkS9AcdOcIinj2liLILBfRDPoiRn+hdHkDSVZlKbQwsJ2p
 3rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772684731; x=1773289531;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zmWuZMm9qYkKyEuxzdgGzX/TxOaZzKIIsrN0QTku0QM=;
 b=VCb3qLixDrbnWXe/8eD5032vhkeWasrD3Bwtm2YFZ6CR1x6Zlf560tBu+RAwz+w0ij
 UofjVEa7t8vfhctQH6bnpOhj08+/X7vQI8VS8Q5Nc7Jtx8jS/zvplxfuLA6euP0Ne3Ia
 KpV7mbXUOvDKgBOT1NjhzHeknFmpHET/QoUaIK1EEHaaxl9LWy3wAuHDDLnWMJTM7/+A
 WQ2w+zvztitVU3JL19mk7Et3wBLW6w3IXLSdfg7CkW/rdbV1Uk7qzWsJIdSlbqauXL8Z
 A8Gi75Bkxb7uF37m7ENwf1ToiFanL2Lzw9eqOoocPGqpXTC4grwu58D2Ci6aJVPx8ihW
 JLxg==
X-Gm-Message-State: AOJu0YzD0TwYuDmKsCmMzCg7TkjExC0jk7qJGwjrmDsiLLNGv6pgidnC
 XFCCWwg3xnQjhHubjEKa1PWKp88og0qdxQrULf5mLZhq8pRH0+XF49PEGjOFRvy/Qdnv7hXoFw=
 =
X-Received: from pfnp23.prod.google.com ([2002:aa7:8617:0:b0:829:6cf2:95da])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:744a:b0:829:793f:da6c
 with SMTP id d2e1a72fcca58-829793ffb04mr2795265b3a.39.1772684730493; Wed, 04
 Mar 2026 20:25:30 -0800 (PST)
Date: Thu,  5 Mar 2026 04:25:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305042523.335493-1-rkir@google.com>
Subject: [PATCH 1/2] virtio-snd: remove a redundant memory allocation
From: Roman Kiryanov <rkir@google.com>
To: manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3ugWpaQQKCr0unlujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--rkir.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This change also makes its lifetime explicit and
prevents NULL dereferences.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/audio/virtio-snd.c         | 53 ++++++++++++++++-------------------
 include/hw/audio/virtio-snd.h |  2 +-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b8376433f7..0f78cec967 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -130,7 +130,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
                                                        uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL :
-        s->pcm->streams[stream_id];
+        s->pcm.streams[stream_id];
 }
 
 /*
@@ -143,7 +143,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
                                                             uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL
-        : &s->pcm->pcm_params[stream_id];
+        : &s->pcm.pcm_params[stream_id];
 }
 
 /*
@@ -260,7 +260,7 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
 {
     virtio_snd_pcm_set_params *st_params;
 
-    if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
+    if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
@@ -424,8 +424,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
-    if (s->pcm->streams == NULL ||
-        s->pcm->pcm_params == NULL ||
+    if (s->pcm.streams == NULL ||
+        s->pcm.pcm_params == NULL ||
         stream_id >= s->snd_conf.streams) {
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
@@ -440,7 +440,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream = g_new0(VirtIOSoundPCMStream, 1);
         stream->active = false;
         stream->id = stream_id;
-        stream->pcm = s->pcm;
+        stream->pcm = &s->pcm;
         stream->s = s;
         stream->latency_bytes = 0;
         qemu_mutex_init(&stream->queue_mutex);
@@ -450,7 +450,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
          * stream_id >= s->snd_conf.streams was checked before so this is
          * in-bounds
          */
-        s->pcm->streams[stream_id] = stream;
+        s->pcm.streams[stream_id] = stream;
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
@@ -884,11 +884,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
-            || vsnd->pcm->streams[stream_id] == NULL) {
+            || vsnd->pcm.streams[stream_id] == NULL) {
             goto tx_err;
         }
 
-        stream = vsnd->pcm->streams[stream_id];
+        stream = vsnd->pcm.streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
@@ -966,11 +966,11 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
-            || !vsnd->pcm->streams[stream_id]) {
+            || !vsnd->pcm.streams[stream_id]) {
             goto rx_err;
         }
 
-        stream = vsnd->pcm->streams[stream_id];
+        stream = vsnd->pcm.streams[stream_id];
         if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
@@ -1064,11 +1064,10 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
-    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
-    vsnd->pcm->snd = vsnd;
-    vsnd->pcm->streams =
+    vsnd->pcm.snd = vsnd;
+    vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
-    vsnd->pcm->pcm_params =
+    vsnd->pcm.pcm_params =
         g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
 
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
@@ -1335,23 +1334,19 @@ static void virtio_snd_unrealize(DeviceState *dev)
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
-    if (vsnd->pcm) {
-        if (vsnd->pcm->streams) {
-            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-                stream = vsnd->pcm->streams[i];
-                if (stream) {
-                    virtio_snd_process_cmdq(stream->s);
-                    virtio_snd_pcm_close(stream);
-                    qemu_mutex_destroy(&stream->queue_mutex);
-                    g_free(stream);
-                }
+    if (vsnd->pcm.streams) {
+        for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+            stream = vsnd->pcm.streams[i];
+            if (stream) {
+                virtio_snd_process_cmdq(stream->s);
+                virtio_snd_pcm_close(stream);
+                qemu_mutex_destroy(&stream->queue_mutex);
+                g_free(stream);
             }
-            g_free(vsnd->pcm->streams);
         }
-        g_free(vsnd->pcm->pcm_params);
-        g_free(vsnd->pcm);
-        vsnd->pcm = NULL;
+        g_free(vsnd->pcm.streams);
     }
+    g_free(vsnd->pcm.pcm_params);
     qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 9560bac8b1..da2ba9675e 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -216,7 +216,7 @@ struct VirtIOSound {
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
-    VirtIOSoundPCM *pcm;
+    VirtIOSoundPCM pcm;
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-- 
2.53.0.473.g4a7958ca14-goog


