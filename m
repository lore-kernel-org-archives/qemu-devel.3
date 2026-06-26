Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D28CDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5po-0001ro-Ig; Fri, 26 Jun 2026 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5pm-0001qh-RZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:39:02 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5pk-0003p7-RX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:39:02 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so124686966b.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782477539; cv=none;
 d=google.com; s=arc-20260327;
 b=JkgWyjzXZvc5p+qLdY6uXz0MYB64popMtn+q9dgUgimJn2ncgnBBFp6I65L9Ysb26V
 LFPLasteqqTvHHFEDG6/nTx/ZQu5J49fJ9SqYux/x0zh3zNip6X+NeRM6n8/uUlN+u74
 g0yG/pVclYvtlgji/KG6fWn6I/L72pI8ZIAHJHuMW3NojWeUgHTSCilAodXJbmH2DD8X
 26UlEW4iUYKOKaju0hiGlLE25HHFGjsM+8zxQf7sZO9d7lRkIydNxe5LzL88NRcmTgPs
 YZpLpfQdKJ4HFBn2acU0U3MDDDwFx+LSwZnvixFIRF1yHBRgGDobRvdvYJYVrf/Mekuj
 lLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ntai7gYoTVsMBeoXA5ozrWU9QrtxlQkjhUHU84wVLjk=;
 fh=WTMaVroxeFO+odfNo/HlSXKoRZAjtoqL4+bW6Ec/xOQ=;
 b=oPGrjzLRd17dNZt9x8WiGh06NWgcMricV5IO2dFLqclMwK9zz6uO7SAk08WxGbJ4EV
 kvDHYR0ye7Nt5SkJWYt+gMQzJAUrjD3YgE8fFvqjPW1NlK++3r51y4t+7BedCmp3FFdI
 E0PDL7XsNJZT47RHqMgsGl2DloTSS39n2vVNpFhPNJqnYaQjz4GHg73rOvgJuUI1bY4Z
 M5hUVvXuOGEGBcg6LwE3wb53iat+bvkM1o33ANfzstp8qq0qqgZMD5p2EOXCufINInkI
 cRw8aYgnpMtOszsU3Dz0AVElht6u1zA+kBql/K5TfsIcRgFFzku1ew4WDn66tEfCEYVQ
 BuJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477539; x=1783082339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ntai7gYoTVsMBeoXA5ozrWU9QrtxlQkjhUHU84wVLjk=;
 b=Q80QI18Ln4kG0dqSFBMsuDUg6vi3eupPAzeMjVFWTFvQNAIbitPtbiG8BeJQM5uOLo
 aQ0jOrmJWs0X1f4T40JdkUATFyYGlWG6QKP2qhYWyS0gHuH0VJjnhWjXYLY2VOyZ6Unr
 uRnU4aSE6Y41mvNDe5CfYjPqUzwRiaOecSLYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477539; x=1783082339;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ntai7gYoTVsMBeoXA5ozrWU9QrtxlQkjhUHU84wVLjk=;
 b=MAOQrqTcQb2CJTQNZzzxGKSe1yyTW/jtDUByAojq6k9sIEPJXaoqX73aqBO3Rl496Y
 WGqlwoBWDWblrbt4pl1ZlBvntQ7MApoN/INP7asC2O0Ic7NST9FHLX8CXmm6Wh5Prl9e
 U+XnA6kl1txYGghOdx8ed+kv8kHW0Nz2Ju8geKdR060wQQkovUjxDCDDUcr0GCZIFnRN
 AFy0rfasPKaQyLLdzEo5Y9zr5YmizEdaUqz6tamhUYta4L9CwnnSvnSu8zbEzGNGEOcQ
 pFusXlYCwQDjlYGAmNlWIKiRuPWbZdqDX6yVb4x57N9vRjfEV232PzDhtwLme0/B28Iu
 gM8A==
X-Gm-Message-State: AOJu0Yyhi4HiNxwDBFnCwmSUyTjnP05SxUyz6JFucQ5+954juC5YR25c
 srlH2PiTOAo3VOvElNLBRuOClVNFwe4BQWxJGgwwx3VqhEznzROPR1gdoqUIp8nzhe11x4unnc9
 z4TRrD1njtsjeCAETfaVNDrjLHMpCu0P20bmnVeyvbQ==
X-Gm-Gg: AfdE7ckD68wXq9YEyUuZrS26XS9gxUXpVuO+YuPzP8WrRH3DvSP1KgezgF7Ebb96d3c
 0OD/ayyKxEpb/xpyylT8Riv+fIP/8Uf2sDMJqctELl8NkqGrbPvEh3ZIiF/rKqBLnJnY3zaWAUE
 vaY8V0zCM+si3ynGKbSnlElPPOuPKJ3M3Lm+/dXjaSI63b0nIkegisjffN/W51tEGHMRAOhJ3bA
 R+nhyYf2ictBv/bjAo7sGlQSoNmo42fwDz1Qwagdqt2AIolKAzQqnVsqGa8Lw0aAOBiJjURoima
 8LIcXNmJVCqVY0qXXoEN+tgFEvzM
X-Received: by 2002:a17:907:940a:b0:be2:36d7:573b with SMTP id
 a640c23a62f3a-c1205e6d939mr448268766b.12.1782477539029; Fri, 26 Jun 2026
 05:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-9-alexander@mihalicyn.com>
 <178239957439.405566.14149573819359101904.b4-review@b4>
In-Reply-To: <178239957439.405566.14149573819359101904.b4-review@b4>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 14:38:47 +0200
X-Gm-Features: AVVi8CcJSRx6U78TyRmOYvVcjMkrbcIoNbx3S0t1-pmMs5AZT_xs9C_EvC9mQiE
Message-ID: <CAJqdLroxhRbrKBw=8pgV0WWPzC53jX6gjHsey380ZdPWOJ6cTw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] hw/audio/virtio-sound: add missing vmstate fields
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x631.google.com
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

Am Do., 25. Juni 2026 um 17:00 Uhr schrieb <marcandre.lureau@redhat.com>:
>
> > The virtio-sound device is currently not migratable. Add the
> > missing VMSTATE fields, enable migration and reconnect the audio
> > streams after migration.
> >
> > The queue_inuse[] array variables mimic the inuse variable in
> > struct VirtQueue which is private. They are needed to restart
> > the virtio queues after migration.
> >
> > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > [AM: trivial rebase changes]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > Message-ID: <20260625095250.65073-9-alexander@mihalicyn.com>
> >
> > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-sn=
d.h
> > index 28d0322b979..523c456436b 100644
> > --- a/include/hw/audio/virtio-snd.h
> > +++ b/include/hw/audio/virtio-snd.h
> > @@ -197,6 +197,7 @@ struct VirtIOSound {
> >      VirtIODevice parent_obj;
> >
> >      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > +    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> >      uint64_t features;
> >      VirtIOSoundPCMStream *streams;
> >      AudioBackend *audio_be;
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index 53f9066ab24..b3de8abcb61 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -24,7 +24,6 @@
> >  #include "qapi/error.h"
> >  #include "hw/audio/virtio-snd.h"
> >
> > -#define VIRTIO_SOUND_VM_VERSION 1
> >  #define VIRTIO_SOUND_JACK_DEFAULT 0
> >  #define VIRTIO_SOUND_STREAM_DEFAULT 2
> >  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > @@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO_SND_=
PCM_RATE_5512)
> >                                  | BIT(VIRTIO_SND_PCM_RATE_192000)
> >                                  | BIT(VIRTIO_SND_PCM_RATE_384000);
> >
> > +static const VMStateDescription vmstate_virtio_snd_stream =3D {
> > +    .name =3D "virtio-sound-stream",
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT64(info.rates, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(info.direction, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(info.channels_min, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(info.channels_max, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> > +        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> > +        VMSTATE_END_OF_LIST()
>
> While reviewing the VirtIOSoundPCMStream state:
>
> - "id" field should be removed after or with "allocate an array of stream=
s"
> - "buf_wpos" seems dead code, drop it?
> - "info" seems immutable from the guest side, I don't think we should mig=
rate it
> - "positions" seems to be dead code. Drop it?
>
> Otherwise, the patch looks ok to me

Dear Marc-Andr=C3=A9,

thank you again for such a detailed review comments. I have addressed all
these suggestions in -v3 (have just sent). And also, it looks like
previously I missed
latency_bytes field too (it was added in upstream QEMU after the
original patches were published).

Kind regards,
Alex

>
> > +    },
> > +};
> > +
> >  static const VMStateDescription vmstate_virtio_snd_device =3D {
> > -    .name =3D TYPE_VIRTIO_SND,
> > -    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > -    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > +    .name =3D "virtio-sound-device",
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_M=
AX),
> > +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
> > +            snd_conf.streams,
> > +            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> >  };
> >
> >  static const VMStateDescription vmstate_virtio_snd =3D {
> > -    .name =3D TYPE_VIRTIO_SND,
> > -    .unmigratable =3D 1,
> > -    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > -    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > +    .name =3D "virtio-sound",
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_VIRTIO_DEVICE,
> >          VMSTATE_END_OF_LIST()
> > @@ -800,6 +822,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command=
 *cmd)
> >                   sizeof(virtio_snd_hdr));
> >      virtqueue_push(cmd->vq, cmd->elem,
> >                     sizeof(virtio_snd_hdr) + cmd->payload_size);
> > +    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> >      virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> >  }
> >
> > @@ -846,6 +869,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vd=
ev, VirtQueue *vq)
> >
> >      elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> >      while (elem) {
> > +        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> >          cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> >          cmd->elem =3D elem;
> >          cmd->vq =3D vq;
> > @@ -956,6 +980,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
> >              goto tx_err;
> >          }
> >
> > +        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> >          size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> >
> >          buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > @@ -1035,6 +1060,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevic=
e *vdev, VirtQueue *vq)
> >              goto rx_err;
> >          }
> >
> > +        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> >          size =3D iov_size(elem->in_sg, elem->in_num) -
> >              sizeof(virtio_snd_pcm_status);
> >          buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > @@ -1177,6 +1203,7 @@ static inline void return_tx_buffer(VirtIOSoundPC=
MStream *stream,
> >      virtqueue_push(buffer->vq,
> >                     buffer->elem,
> >                     sizeof(virtio_snd_pcm_status));
> > +    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> >      virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >      QSIMPLEQ_REMOVE(&stream->queue,
> >                      buffer,
> > @@ -1270,6 +1297,7 @@ static inline void return_rx_buffer(VirtIOSoundPC=
MStream *stream,
> >      virtqueue_push(buffer->vq,
> >                     buffer->elem,
> >                     sizeof(virtio_snd_pcm_status) + buffer->size);
> > +    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> >      virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >      QSIMPLEQ_REMOVE(&stream->queue,
> >                      buffer,
> > @@ -1387,6 +1415,40 @@ static void virtio_snd_unrealize(DeviceState *de=
v)
> >      virtio_cleanup(vdev);
> >  }
> >
> > +static int virtio_snd_post_load(VirtIODevice *vdev)
> > +{
> > +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> > +    uint32_t i;
> > +
> > +    for (i =3D 0; i < s->snd_conf.streams; i++) {
> > +        struct VirtIOSoundPCMStream *stream;
> > +
> > +        stream =3D virtio_snd_pcm_get_stream(s, i);
> > +        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > +            virtio_snd_pcm_open(stream);
> > +
> > +            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
> > +                virtio_snd_pcm_set_active(stream, true);
> > +            }
> > +        }
> > +    }
> > +
> > +    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > +        if (s->queue_inuse[i]) {
> > +            bool rc;
>
> I would just drop the variable ("rc" is rather for int in general)

+

>
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

