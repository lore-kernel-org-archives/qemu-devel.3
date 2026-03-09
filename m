Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B550F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxA-0000n6-W3; Mon, 09 Mar 2026 11:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwZ-0007zu-T8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwV-0000Ps-HO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48540355459so5922965e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071689; x=1773676489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xRjEhQJtjZMDsvFKB7U/z4AeDldYrLH9CdDk4sJlXaI=;
 b=e9AzbE4IDOJcEZ3uSnUYnwuZ1Qf5dwRpQqUztDrZM7JGMjXwdxHj1tyBJwSTLxoYjl
 Gr1oF9XYtNCpBCAEFZtPxuzxwtxb9UmcIoY/K+tgbCd4VY/yh4HpKWHW/dQYxpZ9O9y7
 13UtrY3CrKH/7PA+F7yX0x5Arz12zRFLa7iZd46zui3twfqJzeqvo5vfeO/qfThnJNys
 mFs8iU0mgNh67bJs3jGUotwtzqxBaJKWFLVwQysQaUap01W65K3ta1D5K34BgKsp3266
 oYtaMQuZQGkeInROtASuGsFoRJjyDatm4EChJiIr9r5rzo8HdOHNEZpBqiYHLaitUAxy
 vhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071689; x=1773676489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xRjEhQJtjZMDsvFKB7U/z4AeDldYrLH9CdDk4sJlXaI=;
 b=lzHdwLaRCIYg+PeC+/gsvBaFtHOgiCzF70a4Brv0oBqcAgRlQ2q2zyK5dJHRRUv9vh
 2Nugk3ee/DI9tjvOFYZswqb6Pa+0mFac28zZWCndRIJkQQ4GDyaKnOx0g0vc7y0GtWHi
 QqjxQxFC0eTl4xkonKBQVkpFvLetyIQulzDfS+FeFasGMdwUNLwjHad3DLn4ctezzC52
 8GF+L6Cp9hJnGVgDldz9Zg7OYfRPSm101ENjS/Sb40O4yXF01cf+7vU03iKYD84aT5iu
 l4lWUjWS5kwCUtViTqCMXeY4Zf+zNrqzKF9Ht5UYoNTB5iL/sihkeNAJBrmcbRRwoocr
 twTA==
X-Gm-Message-State: AOJu0YzXR4qLZNWCYeoApGIA4aSkAJs5z8X0RQMfNlBNHtavWcmysit9
 kH3HC1c9Elc36HI/LTMHlee2kC8SZmJLgesvGyeZBr1rn1/cJrkvCmTckk8RVoxIBX7GvOEdGat
 mX+XklYQ=
X-Gm-Gg: ATEYQzw/lPfd0gNz4pWEI8L7/KJbExqZSJ8pr2iYGfbpaYCg8oo+dmxp9/q5vGhLsRq
 iqirsKy4qDR4CdHZr3rmVmMAUDIS2t4Bp5o1/sNO+kclxX26M3aFzhEGTXsMp7kuY6KUj+whJ/n
 qEUNitUtXDqrFZfKUiP2wWuMi2OH4uSls1Cw2AiXtbIIqFEA3q0ZZgZMARKNcVtDwn1PGpoFau2
 pqlo1+NUCjf+N0c45SBWl/iHHJyHAGDYMecJvcQOn5o3jzhYJXB8nGYptj+dBeMQn8beINw8hL2
 TfMhf/77pPaaW410EkN97vPRMBUcr1NMBz+tC6zKq05SsRVutrYbcPrsW6hg3/DJYcL/F5wOefh
 F+u2EIpyUNP/3Gglb02oAeizwGJe+Uys7ScKBvD1n3pi4rCy0I2VkUeJBL0D7A9kqPVsizQSSON
 QQOvoVu6twGvq5oXqwWnp2sbGkz/HLvZyJVNITDDqy0JAn8Pu5WMhfu2fy6np/I/TWibAaNFW5
X-Received: by 2002:a05:600c:3510:b0:485:3c05:24cd with SMTP id
 5b1f17b1804b1-4853c0527dfmr52218495e9.33.1773071689229; 
 Mon, 09 Mar 2026 08:54:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853f8f9938sm11894425e9.23.2026.03.09.08.54.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/49] virtio-snd: remove a redundant memory allocation
Date: Mon,  9 Mar 2026 16:51:52 +0100
Message-ID: <20260309155219.62400-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Roman Kiryanov <rkir@google.com>

This change also makes its lifetime explicit and
prevents NULL dereferences.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305042523.335493-1-rkir@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/virtio-snd.h |  2 +-
 hw/audio/virtio-snd.c         | 53 ++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 9560bac8b15..da2ba9675e1 100644
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
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b8376433f7d..0f78cec967d 100644
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
-- 
2.53.0


