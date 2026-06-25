Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4BBCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZd-0003iW-SC; Thu, 25 Jun 2026 11:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZD-0002y4-U5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZB-0004LX-IQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ovciup2M4ElQFK3lKjkZ3qFv/rPFba3hf8YDcysyvs=;
 b=OIv2uAVbzQo4fmY1U7XZXSj2jSWGTrbZQekHGjbfaO/BXwGPYqN0q7bkaTV4o1ivyYgfSs
 wB/CB5a3/khbi7jgJ+mvc+fViyL4whP4L4wiBZe0hWT2MYXC3TlzrozlgHkwbXWYXCsgGu
 oqrR2kFyaNTqtvI9VrZj41HXb70h/LI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-CDEL3hpsNJureYhnMgF79Q-1; Thu,
 25 Jun 2026 11:00:31 -0400
X-MC-Unique: CDEL3hpsNJureYhnMgF79Q-1
X-Mimecast-MFC-AGG-ID: CDEL3hpsNJureYhnMgF79Q_1782399630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3238118A0E02; Thu, 25 Jun 2026 15:00:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D143180065F; Thu, 25 Jun 2026 15:00:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 8/9] hw/audio/virtio-sound: add missing vmstate fields
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260625095250.65073-9-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-9-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957439.405566.14149573819359101904.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7291;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MnuM9ZkSHwKSDh8dRAi3h6RXN6feEa23ryDWJEsxjck=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJaXsuIn72xMY8R29zpImdi0oEvPKI7GiTiK
 gaFl2K8C02JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5RenD/4lFX6OoQeheRwE/+6OHjkSorx1hMFr3enxa95dQ+Te0/ff/LbY20SGnGwQoAqs58IJ16M
 sjkZRiBGI8Yj1yQD+MmJwDdi4kyo3Bfb6ymuMj1YA4v2nOPzGPQMvzOXrZr3EsACNuoJp/mv+8n
 oHJ4VEJvYqhrWt3ucLfEeXUQuybX/gHPWYi8IieD8qnVG3oKt1abBQx/XXwNSEut1zZ5AJiVXLt
 Al++kFjAH5bXDN4r7ZO6VhkCF3QnZwEnpfOSiV/t6vmWBMeBMn3MqeNm4xIAGjHVeMloGtL9HN/
 m94cY2LgqqM2GeImNRw3Dhyw94+bROByuLjv15R1uPjXkTTPcRhl8uR0abopfBAv0zbJd5eruli
 LzJZYbQHAHhma3KpI7UL0DgSlEGeOf77b2HkzKL3xyI4gMSJeHPyHO3bxOYz16Z9aAunffL+Aty
 HNB/5OGuRnI5IXQF0q5ToH65lySXLG+W+Mwcv8ktZ2xpoaLABkLHi+agNaqHfpPvtsm0iMYgWf4
 9WLIpglcmySYuLpukffZDYbvlabzz1nfAUTPczt3wW9M+Hj9dIqEW7Wu4mUdpHrdx9Wdn5Ft7yK
 19jYnC5/qRNX9FzT8W7CBRWO1EvGQsATTB2yYbRRZP3zsacsmcGoL9TViIrwP3voFNGNH2pBJsJ
 HX7BLjlxbjqxJBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> The virtio-sound device is currently not migratable. Add the
> missing VMSTATE fields, enable migration and reconnect the audio
> streams after migration.
> 
> The queue_inuse[] array variables mimic the inuse variable in
> struct VirtQueue which is private. They are needed to restart
> the virtio queues after migration.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> [AM: trivial rebase changes]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Message-ID: <20260625095250.65073-9-alexander@mihalicyn.com>
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
> index 28d0322b979..523c456436b 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -197,6 +197,7 @@ struct VirtIOSound {
>      VirtIODevice parent_obj;
>  
>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> +    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
>      uint64_t features;
>      VirtIOSoundPCMStream *streams;
>      AudioBackend *audio_be;
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 53f9066ab24..b3de8abcb61 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -24,7 +24,6 @@
>  #include "qapi/error.h"
>  #include "hw/audio/virtio-snd.h"
>  
> -#define VIRTIO_SOUND_VM_VERSION 1
>  #define VIRTIO_SOUND_JACK_DEFAULT 0
>  #define VIRTIO_SOUND_STREAM_DEFAULT 2
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> @@ -78,17 +77,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
>                                  | BIT(VIRTIO_SND_PCM_RATE_192000)
>                                  | BIT(VIRTIO_SND_PCM_RATE_384000);
>  
> +static const VMStateDescription vmstate_virtio_snd_stream = {
> +    .name = "virtio-sound-stream",
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
> +        VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
> +        VMSTATE_UINT64(info.rates, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(info.direction, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(info.channels_min, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(info.channels_max, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
> +        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> +        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> +        VMSTATE_END_OF_LIST()

While reviewing the VirtIOSoundPCMStream state:

- "id" field should be removed after or with "allocate an array of streams"
- "buf_wpos" seems dead code, drop it?
- "info" seems immutable from the guest side, I don't think we should migrate it
- "positions" seems to be dead code. Drop it?

Otherwise, the patch looks ok to me

> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_snd_device = {
> -    .name = TYPE_VIRTIO_SND,
> -    .version_id = VIRTIO_SOUND_VM_VERSION,
> -    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
> +    .name = "virtio-sound-device",
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MAX),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
> +            snd_conf.streams,
> +            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> +        VMSTATE_END_OF_LIST()
> +    },
>  };
>  
>  static const VMStateDescription vmstate_virtio_snd = {
> -    .name = TYPE_VIRTIO_SND,
> -    .unmigratable = 1,
> -    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
> -    .version_id = VIRTIO_SOUND_VM_VERSION,
> +    .name = "virtio-sound",
>      .fields = (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
> @@ -800,6 +822,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>                   sizeof(virtio_snd_hdr));
>      virtqueue_push(cmd->vq, cmd->elem,
>                     sizeof(virtio_snd_hdr) + cmd->payload_size);
> +    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
>      virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
>  }
>  
> @@ -846,6 +869,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>  
>      elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>      while (elem) {
> +        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
>          cmd = g_new0(virtio_snd_ctrl_command, 1);
>          cmd->elem = elem;
>          cmd->vq = vq;
> @@ -956,6 +980,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>              goto tx_err;
>          }
>  
> +        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
>          size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
>  
>          buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> @@ -1035,6 +1060,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>              goto rx_err;
>          }
>  
> +        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
>          size = iov_size(elem->in_sg, elem->in_num) -
>              sizeof(virtio_snd_pcm_status);
>          buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> @@ -1177,6 +1203,7 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
>      virtqueue_push(buffer->vq,
>                     buffer->elem,
>                     sizeof(virtio_snd_pcm_status));
> +    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
>      virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>      QSIMPLEQ_REMOVE(&stream->queue,
>                      buffer,
> @@ -1270,6 +1297,7 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
>      virtqueue_push(buffer->vq,
>                     buffer->elem,
>                     sizeof(virtio_snd_pcm_status) + buffer->size);
> +    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
>      virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>      QSIMPLEQ_REMOVE(&stream->queue,
>                      buffer,
> @@ -1387,6 +1415,40 @@ static void virtio_snd_unrealize(DeviceState *dev)
>      virtio_cleanup(vdev);
>  }
>  
> +static int virtio_snd_post_load(VirtIODevice *vdev)
> +{
> +    VirtIOSound *s = VIRTIO_SND(vdev);
> +    uint32_t i;
> +
> +    for (i = 0; i < s->snd_conf.streams; i++) {
> +        struct VirtIOSoundPCMStream *stream;
> +
> +        stream = virtio_snd_pcm_get_stream(s, i);
> +        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> +            virtio_snd_pcm_open(stream);
> +
> +            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
> +                virtio_snd_pcm_set_active(stream, true);
> +            }
> +        }
> +    }
> +
> +    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
> +        if (s->queue_inuse[i]) {
> +            bool rc;

I would just drop the variable ("rc" is rather for int in general)

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


