Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2653CC79FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Cbp-0001je-Mn; Wed, 09 Sep 2026 03:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4Cbn-0001j9-AZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:20:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4Cbe-0002Or-89
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:20:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so22408255e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788938425; x=1789543225; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DPKEfWVDEzs3B3CT+saSZ2CnwDE2sbu5CLkjZRXrQsM=;
 b=hzqH2A3+XVqm23I9y+2Di3pv4IY0JSKmVlcV/c/KljBEKGNfygrmrk9LkjzBZeZIaO
 hQPMH5JRGis3RPOGQ6ttroeGzyOBV+I6V+OgJeoS/qPZqVMGyfUJyV9gSLFOOUP0BJie
 pxKBHqvz/JCKKxc3UNNzwUam/llH3F49hTFJX3cYuZiaNc0wq6lKTIOcq+vIYMO+jHny
 elFCm76ztVsR3sMqMwMguqTvFQ5FBBQXKi1GZiOPl/od7NrbJaHYkppsR5+M/W/m6iUj
 ALdusw4T9AIlKVmuQS69S6IHo8nefpw0THJVO8NNfhMv3Q+VRRNhq3T9IyQ/nR7XuWpf
 CVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938425; x=1789543225;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DPKEfWVDEzs3B3CT+saSZ2CnwDE2sbu5CLkjZRXrQsM=;
 b=YMvdl1kRW3JNudbeurYdm7ktekizYQ9a65OStNnOHNs3Ap0dyiRt0lVNHjyWMWfi/m
 /utVqIcz55Y6rWuhsl52F23eALOujO+g2qtoOzEt2cLmaci1sEW/uH9X4lwD1vHVFtOs
 Grqndx2OXS7gtC+O9nSZV+F1owkKy8Q4l2iIciZA0Hszym0wLy/5PE/WCoivCkVk5ACR
 acQFq3uVpkYEVwiVv2C0ZMWh/xeWvRq8qvrSv8vqkg6gaaGtQwZlERmmuywB4Dj1qWWH
 ET9HB2hI1l6f8hq9+2Q1v3370yDzkaxOkvSfxIRhU5fOxOMGX0nCtehjQGopK/fbc7Jo
 z4vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaFcQ6gZ0GAg1iv0yuyArbZmKHaS0uMKazGgswkSP7b4/k601Q/+7HzrFJvsHXsXr2lBkO2xDjnG+i@nongnu.org
X-Gm-Message-State: AFuF++kirzPTzCINTYrNpE9R/xDMLtJKKOvbomPPFLtpx8BHINOHsxNe
 NIiaeyNMRUUmuxVQ7Gi1UkvQRSyV0Vp/NpLCokCIEjxP5qIjqOLAbsp8bX1Zw7+J/uY=
X-Gm-Gg: AYBFou2bJ/502E/LdqtTknptsbXf3IkhkoW6Xt040hOBnrZeVYipI8m0W5qndxL2eZs
 oX6pFQxLYL+/3nAU5L7dqImzYQf+Nkn+hWQ0PDZgIdiFSPC5bKKAP/RAr07GR17nj2Y2EENS7J9
 siH1qIp7U1QPfsIP0NNPKAFwOoF6Kkxlzj9+TIBUyT/oYqIKpgdPV6f7jdz+ogAYTGRqw/fK24+
 /MOn2S1Q1btkxRqBVcK02BUnXhnMHIzlyNl8FNq1+xCWcPuiC50fT44inck0nIvyK3ZnlxV+C4r
 1o/MjJ88YYQvuH5mMQ9wKdZrPjQGv/euJQbXTG11kfJkZXFg7w9QWDP0kQjPJoqyn4ScI6NmmOz
 weaN5m1SIBzs1kk/fVVM3WfxAQP72DS7TnJB35UkZA6JvdDiMNJ6n4Sa+SS7EVlMeWBnHteQnN3
 J1yPbwk//V55js9LFnkjyth2nyV063XVlgMk10RtlwNjYUhh2OO6sdwhQt5GPlAtlIe//OFSnyn
 pf+OKGhl2mcz+o3+IrD8RbdtWYBMyc5iOV3uBfYTOIz9W1Z6h4fyaXeoWUT4WgHfu2OjLRFGwg1
 qduYN+vR4p+vsWmZXu53XytxQZKHg0aDq2whpzTrJ4Ru/LBy+jBBRpb1Z+OFE7j5HMAeQnb7EFE
 XgZWNpMN23pJZKejeIj+ghhUEFIvdMKGLACM=
X-Received: by 2002:a05:600d:864b:20b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49cfea38642mr221668605e9.24.1788938425354; 
 Wed, 09 Sep 2026 00:20:25 -0700 (PDT)
Received: from meli-email.org (athedsl-116222.home.otenet.gr. [85.75.29.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fd8a566sm38260205e9.1.2026.09.09.00.20.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2026 00:20:25 -0700 (PDT)
Date: Wed, 09 Sep 2026 10:15:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 10/10] hw/audio/virtio-sound: add missing vmstate fields
User-Agent: meli/0.8.13
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <20260803081159.91981-11-alexander@mihalicyn.com>
In-Reply-To: <20260803081159.91981-11-alexander@mihalicyn.com>
Message-ID: <tl35q0.2bcgb86nv445o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Mon, 03 Aug 2026 11:11, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>The virtio-sound device is currently not migratable. Add the
>missing VMSTATE fields, enable migration and reconnect the audio
>streams after migration.
>
>The queue_inuse[] array variables mimic the inuse variable in
>struct VirtQueue which is private. They are needed to restart
>the virtio queues after migration.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: trivial rebase changes]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
>v4:
>	- added assert(. > 0) before decremeting s->queue_inuse[.]
>	  (suggested by Manos Pitsidianakis)
>v3:
>	- added latency_bytes field to VMStateDescription
>
>	As suggested by Marc-André Lureau:
>	- removed the "rc" variable from virtio_snd_post_load()
>	- dropped info field from VMStateDescription, because
>	  it can't be modified by guest and initialized only from realize
>	- added minimum_version_id/version_id so we can extend VMStateDescription
>	  without breaking compatibility in the future
>---
> hw/audio/virtio-snd.c         | 83 +++++++++++++++++++++++++++++++----
> include/hw/audio/virtio-snd.h |  1 +
> 2 files changed, 76 insertions(+), 8 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 12473862d24..6df7ea0eb04 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -24,7 +24,6 @@
> #include "qapi/error.h"
> #include "hw/audio/virtio-snd.h"
> 
>-#define VIRTIO_SOUND_VM_VERSION 1
> #define VIRTIO_SOUND_JACK_DEFAULT 0
> #define VIRTIO_SOUND_STREAM_DEFAULT 2
> #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>@@ -74,17 +73,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
>                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
>                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
> 
>+static const VMStateDescription vmstate_virtio_snd_stream = {
>+    .name = "virtio-sound-stream",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
> static const VMStateDescription vmstate_virtio_snd_device = {
>-    .name = TYPE_VIRTIO_SND,
>-    .version_id = VIRTIO_SOUND_VM_VERSION,
>-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>+    .name = "virtio-sound-device",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MAX),
>+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
>+            snd_conf.streams,
>+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
>+        VMSTATE_END_OF_LIST()
>+    },
> };
> 
> static const VMStateDescription vmstate_virtio_snd = {
>-    .name = TYPE_VIRTIO_SND,
>-    .unmigratable = 1,
>-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>-    .version_id = VIRTIO_SOUND_VM_VERSION,
>+    .name = "virtio-sound",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>     .fields = (const VMStateField[]) {
>         VMSTATE_VIRTIO_DEVICE,
>         VMSTATE_END_OF_LIST()
>@@ -813,6 +835,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>                  sizeof(virtio_snd_hdr));
>     virtqueue_push(cmd->vq, cmd->elem,
>                    sizeof(virtio_snd_hdr) + cmd->payload_size);
>+    g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
>+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
>     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> }
> 
>@@ -859,6 +883,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
> 
>     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>     while (elem) {
>+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
>         cmd = g_new0(virtio_snd_ctrl_command, 1);
>         cmd->elem = elem;
>         cmd->vq = vq;
>@@ -976,6 +1001,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>             goto tx_err;
>         }
> 
>+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
>         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>         buffer->elem = elem;
>         buffer->populated = false;
>@@ -1060,6 +1086,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>             goto rx_err;
>         }
> 
>+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
>         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>         buffer->elem = elem;
>         buffer->vq = vq;
>@@ -1200,6 +1227,8 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
>     virtqueue_push(buffer->vq,
>                    buffer->elem,
>                    sizeof(virtio_snd_pcm_status));
>+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
>+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
>     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>     QSIMPLEQ_REMOVE(&stream->queue,
>                     buffer,
>@@ -1293,6 +1322,8 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
>     virtqueue_push(buffer->vq,
>                    buffer->elem,
>                    sizeof(virtio_snd_pcm_status) + buffer->size);
>+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
>+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
>     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>     QSIMPLEQ_REMOVE(&stream->queue,
>                     buffer,
>@@ -1411,6 +1442,37 @@ static void virtio_snd_unrealize(DeviceState *dev)
>     virtio_cleanup(vdev);
> }
> 
>+static int virtio_snd_post_load(VirtIODevice *vdev)
>+{
>+    VirtIOSound *s = VIRTIO_SND(vdev);
>+    uint32_t i;
>+
>+    for (i = 0; i < s->snd_conf.streams; i++) {
>+        struct VirtIOSoundPCMStream *stream;
>+
>+        stream = virtio_snd_pcm_get_stream(s, i);

i < s->snd_conf.streams so this will not be NULL. Is it okay if I add an 
assert anyway before we merging this? I can add it before sending a pull 
request.

(A little paranoia can't hurt).

In any case:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+        if (virtio_snd_pcm_state_prepared(stream->state)) {
>+            virtio_snd_pcm_open(stream);
>+
>+            if (stream->state == VIRTIO_SND_PCM_STATE_STARTED) {
>+                virtio_snd_pcm_set_active(stream, true);
>+            }
>+        }
>+    }
>+
>+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
>+        if (s->queue_inuse[i]) {
>+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i])) {
>+                error_report(
>+                    "virtio-snd: could not rewind %u elements in queue %u",
>+                    s->queue_inuse[i], i);
>+            }
>+            s->queue_inuse[i] = 0;
>+        }
>+    }
>+
>+    return 0;
>+}
> 
> static void virtio_snd_reset(VirtIODevice *vdev)
> {
>@@ -1442,6 +1504,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>             virtio_snd_pcm_buffer_free(buffer);
>         }
>     }
>+
>+    for (uint32_t i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
>+        vsnd->queue_inuse[i] = 0;
>+    }
> }
> 
> static void virtio_snd_class_init(ObjectClass *klass, const void *data)
>@@ -1455,6 +1521,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
> 
>     dc->vmsd = &vmstate_virtio_snd;
>     vdc->vmsd = &vmstate_virtio_snd_device;
>+    vdc->post_load = virtio_snd_post_load;
>     vdc->realize = virtio_snd_realize;
>     vdc->unrealize = virtio_snd_unrealize;
>     vdc->get_config = virtio_snd_get_config;
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index 85d5d7c8619..384d2868c19 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -194,6 +194,7 @@ struct VirtIOSound {
>     VirtIODevice parent_obj;
> 
>     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
>     uint64_t features;
>     VirtIOSoundPCMStream *streams;
>     AudioBackend *audio_be;
>-- 
>2.47.3
>

