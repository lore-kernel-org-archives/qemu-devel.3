Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573DEC982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qr1-0005Cp-0M; Sat, 19 Sep 2026 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqy-0005C9-Tn
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:24 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007Hs-6b
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:24 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7230695e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808115; x=1790412915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6M0nfJL6B1hRZbNEfE9XctLUkdS0dQKDP4zpnJvlvQU=;
 b=mgtpsq4ame9lKECpcImr/M8Wl7Uz1aH15hL14wOOHD18SuQK4eQjD0K+kGV0i0xqkt
 o1696xUdGlapiL9f9385shboomdv0Nl0WyzbV8h6F7zQ1jFW8hirDc6X2NwkSYnLJCgB
 EpfQPFJq3tQycs2pI8HQTmwFnNYU4TAxdz/evEIF/pY15IGMmiFivH/Co2qClcvAU76/
 NXaoPsQ9u7fycndPG4kk2AcBy42c81Y5jo3T2zufDORlRM/+Pz6NTHMGnTh1/B92ciWE
 moI8rqglUGGVf3T+qC1ErhZ03kGkc7YEQExj0fIapzXImuJWqXaCVtFaQuAy5ep7XwEW
 Vaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808115; x=1790412915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6M0nfJL6B1hRZbNEfE9XctLUkdS0dQKDP4zpnJvlvQU=;
 b=kSJaj7LYPZ0y1tLmfRs1cHw1HZuQztMBqv0oeOkpynJ/rU0OSaeXf5hjAyaFFQRovm
 kxT1BK3QgzsE1nV9fB419YKn1m20/GsMfELyAh2KvT/qKyXUXp2kzHh2hC5x8ftBGJjs
 lRTJe++SkAN153zldEc/58GC3c1POMiv8MWUMmPdBwdNp1Ce5RTr2UdeUHkxS72mOTE3
 7alMxnzmCYQi5AgEjmpD/6keHjB+FoLKFuWYPeRmAN5wToWbH+awpe8/38yZ3e0ZldPX
 Wht9niX2c3m5ZmTtF9/sZxQvZ0GMc7klibO9cVAUUmrpbvp+xpGUHXXHIOno+GGwrewf
 xCHg==
X-Gm-Message-State: AFuF++lF3lN4/X9aTjsYlUaAtG8117Z94KGJmgMuYZPMQnm4i+bijnxP
 JCsy+GMJgDvv3QhQdvoHDqFD5JQ4oPXvp28G3NIEMkyFs9OkLoSwM9eipIYaHwS7PdOxgSAb9eU
 nG87aQdw=
X-Gm-Gg: AYBFou0bfYnV+KUMy5xSn75Gb5skEmSnQaGh0bcK5KCgZPeoLNim3ezGPUOyCBzecd7
 AP3CcRHEMt6cPEaXojkXFriWzqBZjmWnplT7i838WoMIoJ3fgTjGJIcUi5k3VP89IZ/NP0XO9Xf
 QeeF5uIn53S+JIIQMFoIH07tcvJqFc3rUcDrevAj1fgZsPQJH8AmSrNV4SOIOEhh9nc6lBbGvbh
 IMCTC2u9lEGtHdUpeeFZd1eMImnSgUB1j/RInIc3zVV0Knu9ot2RbuPOkh4EKNMLA2gIpJhG73z
 cRiIgMfwJEHlyb4OB5RZeav1bK0+OiEKk+UqMInXAOqebsrJVWxrT5Qo50InodhNWsWHe3TTGCk
 qSO4EyOxeF+BYfOlEwM8J3nm0I/EUZlVRr+mIxaG3DpxB1ssZ0lrMtNRIFIZmHkf9W+gQm6BCA7
 R/MYtmOcbLgrCDVnEwrgSpv+6q95uZ+YoK4ToUkCpPHXEhDn0bG3YhaZrKaCYOWYoM41ZHkGFD7
 vNuEx2LE/ao7Cu1M8IFsU39OuzNOTNwjLMLRdBta1KL1mT/rXQ7vdogiaonW7/cOqDvwFzZGRXg
 VgAdyVnSYKEtOHBgdZ8H446W0g0qUpewhoDs1cyhyRD8SQhvOXwqNEyDl3B9hrs07Uvy0wTwH+D
 cKymK7jpEULo/njToaX0iZeTnambIyQq5jA==
X-Received: by 2002:a05:600c:6212:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49fc56f8327mr57061625e9.15.1789808114748; 
 Sat, 19 Sep 2026 01:55:14 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:14 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 03/10] hw/audio/virtio-sound: remove command and stream
 mutexes
Date: Sat, 19 Sep 2026 11:54:50 +0300
Message-ID: <20260919085510.3388454-4-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

All code in virtio-snd.c runs with the BQL held. Remove the
command queue mutex and the stream queue mutexes. The qatomic
functions are also not needed.

[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260803081159.91981-4-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h |   3 -
 hw/audio/virtio-snd.c         | 244 +++++++++++++++-------------------
 2 files changed, 109 insertions(+), 138 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index b60b098ccd..884c475ffd 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -143,7 +143,6 @@ struct VirtIOSoundPCMStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    QemuMutex queue_mutex;
     bool active;
     uint32_t latency_bytes;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
@@ -215,9 +214,7 @@ struct VirtIOSound {
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-    QemuMutex cmdq_mutex;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
-    bool processing_cmdq;
     /*
      * Convenience queue to keep track of invalid tx/rx queue messages inside
      * the tx/rx callbacks.
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 46d81cc9ec..cbf739f8a7 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -19,7 +19,6 @@
 #include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "qemu/lockable.h"
 #include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -442,7 +441,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->s = s;
         stream->latency_bytes = 0;
-        qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
 
         /*
@@ -566,9 +564,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream) {
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            stream->active = start;
-        }
+        stream->active = start;
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             audio_be_set_active_out(s->audio_be, stream->voice.out, start);
         } else {
@@ -592,10 +588,8 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
     VirtIOSoundPCMBuffer *buffer, *next;
     size_t count = 0;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
-            count += 1;
-        }
+    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
+        count += 1;
     }
     return count;
 }
@@ -737,23 +731,15 @@ static void virtio_snd_process_cmdq(VirtIOSound *s)
 {
     virtio_snd_ctrl_command *cmd;
 
-    if (unlikely(qatomic_read(&s->processing_cmdq))) {
-        return;
-    }
+    while (!QTAILQ_EMPTY(&s->cmdq)) {
+        cmd = QTAILQ_FIRST(&s->cmdq);
 
-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
-        qatomic_set(&s->processing_cmdq, true);
-        while (!QTAILQ_EMPTY(&s->cmdq)) {
-            cmd = QTAILQ_FIRST(&s->cmdq);
+        /* process command */
+        process_cmd(s, cmd);
 
-            /* process command */
-            process_cmd(s, cmd);
+        QTAILQ_REMOVE(&s->cmdq, cmd, next);
 
-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
-
-            virtio_snd_ctrl_cmd_free(cmd);
-        }
-        qatomic_set(&s->processing_cmdq, false);
+        virtio_snd_ctrl_cmd_free(cmd);
     }
 }
 
@@ -896,17 +882,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
             goto tx_err;
         }
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
-            buffer->elem = elem;
-            buffer->populated = false;
-            buffer->vq = vq;
-            buffer->size = size;
-            buffer->offset = 0;
-            stream->latency_bytes += size;
 
-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
-        }
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+        buffer->elem = elem;
+        buffer->populated = false;
+        buffer->vq = vq;
+        buffer->size = size;
+        buffer->offset = 0;
+        stream->latency_bytes += size;
+
+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         continue;
 
 tx_err:
@@ -983,14 +968,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
             goto rx_err;
         }
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
-            buffer->elem = elem;
-            buffer->vq = vq;
-            buffer->size = 0;
-            buffer->offset = 0;
-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
-        }
+
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+        buffer->elem = elem;
+        buffer->vq = vq;
+        buffer->size = 0;
+        buffer->offset = 0;
+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
+
         continue;
 
 rx_err:
@@ -1094,7 +1079,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
-    qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
     QSIMPLEQ_INIT(&vsnd->invalid);
 
@@ -1162,52 +1146,50 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
     VirtIOSoundPCMBuffer *buffer;
     size_t size;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            if (!virtio_queue_ready(buffer->vq)) {
-                return;
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        if (!virtio_queue_ready(buffer->vq)) {
+            return;
+        }
+        if (!stream->active) {
+            /* Stream has stopped, so do not perform audio_be_write. */
+            return_tx_buffer(stream, buffer);
+            continue;
+        }
+        if (!buffer->populated) {
+            iov_to_buf(buffer->elem->out_sg,
+                        buffer->elem->out_num,
+                        sizeof(virtio_snd_pcm_xfer),
+                        buffer->data,
+                        buffer->size);
+            buffer->populated = true;
+        }
+        for (;;) {
+            size = audio_be_write(stream->s->audio_be,
+                                stream->voice.out,
+                                buffer->data + buffer->offset,
+                                MIN(buffer->size, available));
+            assert(size <= MIN(buffer->size, available));
+            if (size == 0) {
+                /* break out of both loops */
+                available = 0;
+                break;
             }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform audio_be_write. */
+            buffer->size -= size;
+            buffer->offset += size;
+            available -= size;
+            update_latency(stream, size);
+            if (buffer->size < 1) {
                 return_tx_buffer(stream, buffer);
-                continue;
-            }
-            if (!buffer->populated) {
-                iov_to_buf(buffer->elem->out_sg,
-                           buffer->elem->out_num,
-                           sizeof(virtio_snd_pcm_xfer),
-                           buffer->data,
-                           buffer->size);
-                buffer->populated = true;
-            }
-            for (;;) {
-                size = audio_be_write(stream->s->audio_be,
-                                 stream->voice.out,
-                                 buffer->data + buffer->offset,
-                                 MIN(buffer->size, available));
-                assert(size <= MIN(buffer->size, available));
-                if (size == 0) {
-                    /* break out of both loops */
-                    available = 0;
-                    break;
-                }
-                buffer->size -= size;
-                buffer->offset += size;
-                available -= size;
-                update_latency(stream, size);
-                if (buffer->size < 1) {
-                    return_tx_buffer(stream, buffer);
-                    break;
-                }
-                if (!available) {
-                    break;
-                }
+                break;
             }
             if (!available) {
                 break;
             }
         }
+        if (!available) {
+            break;
+        }
     }
 }
 
@@ -1258,55 +1240,53 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
     VirtIOSoundPCMBuffer *buffer;
     size_t size, max_size, to_read;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            if (!virtio_queue_ready(buffer->vq)) {
-                return;
-            }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform audio_be_read. */
-                return_rx_buffer(stream, buffer);
-                continue;
-            }
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        if (!virtio_queue_ready(buffer->vq)) {
+            return;
+        }
+        if (!stream->active) {
+            /* Stream has stopped, so do not perform audio_be_read. */
+            return_rx_buffer(stream, buffer);
+            continue;
+        }
+
+        max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
+        if (max_size <= sizeof(virtio_snd_pcm_status)) {
+            return_rx_buffer(stream, buffer);
+            continue;
+        }
+        max_size -= sizeof(virtio_snd_pcm_status);
 
-            max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
-            if (max_size <= sizeof(virtio_snd_pcm_status)) {
+        for (;;) {
+            if (buffer->size >= max_size) {
                 return_rx_buffer(stream, buffer);
-                continue;
+                break;
             }
-            max_size -= sizeof(virtio_snd_pcm_status);
-
-            for (;;) {
-                if (buffer->size >= max_size) {
-                    return_rx_buffer(stream, buffer);
-                    break;
-                }
-                to_read = stream->params.period_bytes - buffer->size;
-                to_read = MIN(to_read, available);
-                to_read = MIN(to_read, max_size - buffer->size);
-                size = audio_be_read(stream->s->audio_be,
-                                     stream->voice.in,
-                                     buffer->data + buffer->size,
-                                     to_read);
-                if (!size) {
-                    available = 0;
-                    break;
-                }
-                buffer->size += size;
-                available -= size;
-                if (buffer->size >= stream->params.period_bytes) {
-                    return_rx_buffer(stream, buffer);
-                    break;
-                }
-                if (!available) {
-                    break;
-                }
+            to_read = stream->params.period_bytes - buffer->size;
+            to_read = MIN(to_read, available);
+            to_read = MIN(to_read, max_size - buffer->size);
+            size = audio_be_read(stream->s->audio_be,
+                                    stream->voice.in,
+                                    buffer->data + buffer->size,
+                                    to_read);
+            if (!size) {
+                available = 0;
+                break;
+            }
+            buffer->size += size;
+            available -= size;
+            if (buffer->size >= stream->params.period_bytes) {
+                return_rx_buffer(stream, buffer);
+                break;
             }
             if (!available) {
                 break;
             }
         }
+        if (!available) {
+            break;
+        }
     }
 }
 
@@ -1323,11 +1303,9 @@ static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
         (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
         return_rx_buffer;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            cb(stream, buffer);
-        }
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        cb(stream, buffer);
     }
 }
 
@@ -1346,14 +1324,12 @@ static void virtio_snd_unrealize(DeviceState *dev)
             if (stream) {
                 virtio_snd_process_cmdq(stream->s);
                 virtio_snd_pcm_close(stream);
-                qemu_mutex_destroy(&stream->queue_mutex);
                 g_free(stream);
             }
         }
         g_free(vsnd->pcm.streams);
     }
     g_free(vsnd->pcm.pcm_params);
-    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
@@ -1374,12 +1350,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
      */
     g_assert(QSIMPLEQ_EMPTY(&vsnd->invalid));
 
-    WITH_QEMU_LOCK_GUARD(&vsnd->cmdq_mutex) {
-        while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
-            cmd = QTAILQ_FIRST(&vsnd->cmdq);
-            QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
-            virtio_snd_ctrl_cmd_free(cmd);
-        }
+    while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
+        cmd = QTAILQ_FIRST(&vsnd->cmdq);
+        QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
+        virtio_snd_ctrl_cmd_free(cmd);
     }
 }
 
-- 
γαῖα πυρί μιχθήτω


