Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4353BCEB2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 10:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKDCx-00038Y-LX; Sat, 15 Nov 2025 05:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vKDCv-000366-3J
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 05:08:37 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vKDCt-0000R8-G2
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 05:08:36 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so4836072a12.0
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763201313; x=1763806113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPwwwfarx1OEITJOA7flN3Mdo07OxHCviVSBxeZDZSk=;
 b=Z94HS58iRhdGmMfyZzDZ5zhRMh1mOMvuWnTEEyYzMsgHqTcE8yzxud08NVGkR8CT5j
 4FoJ9qHttOvdbH13lXOQidr/TqLtznL658RC7OnBTtD+HX1L5Y+g4ATiUyluTpbb6S15
 9G1ZJcU05c2KRhiKyMzC+Swrdk6rOcQi1YmFxBFxWBG15dmiAZUjDSHw59+/j+BDeysF
 NlLWcB01fKK4Yva8+WDwQtKHP+suTwBG75rhmEDwjtYHFBVgNqp/ewjXSdwV7QzeQWji
 5jlkkEHrPb8c2vnw2baz9lxkr5c0J9L4QxjsjnnpZbIBnRglRazwGsbOjn+hYceM9mTi
 WNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763201313; x=1763806113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rPwwwfarx1OEITJOA7flN3Mdo07OxHCviVSBxeZDZSk=;
 b=rKle7tSAwM9Ytn8k8Jy3GXZQVz7B7yn3m368ZZe69Nio+bUhLl7044eDAh8JRthiPK
 PuPvJH1qQv0QLx7HQ3ieWvI7TV2UPebY47sxi/jdOL2T4ne2tb+EkSKlRPs9tl1nG1ij
 hNoejg+aQSneqPXzjOpuT+bxz3OSMgWwRA6HaxaRiCxHvtylePZkSlWAHtGZ/lJEAXeP
 GwqD9ZA2d5ca+p2P1PIKANiwwEBpBhtKX1XWrKCzyGPisuolIH56CulS7p+F1lfRuHaP
 WS64BUFS7x4j2P3Q+Ue8RSPMT3+2u8rAP/xX/ESuCf5JKYFCNPU3PzHj8uvEVSKT8vgT
 azJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDoM+F7pSLm7cunGZ/Fssgdrr/xu16QKTTcwYqlt4zTBavwhdM1rfN0CIlLWBngIhfTEwAwpIKM4db@nongnu.org
X-Gm-Message-State: AOJu0YxvTXCeb/7yNEpDHvZhBGJuFYFAvCSDSQSsSX7riH69uR6KWq6h
 1TwKp9kRLA3E8Zu2gPifDtQNIa5kCITXCJ/VBdwCRxo1SG2SFtzI51cm6H/f5z6xInjvgHDD7Cd
 WvfjMsI7RIk0azqApD2Vbu8I30vp6fgDd+MtXBKv3fA==
X-Gm-Gg: ASbGncuT/iqmKmjDJC6uYJOxluAgd/uABDCVYpzGtjaFjKdlQ1n/M7G1vpfjJuWtT07
 mx2dUedvHNqZobTk2XquxKIhQMC1chdwTl8apsJD4T+c8/H1Z7ut1kLBUD/e0Ee1j3TChGvwzbB
 oxsMGsK36pVNBTeIrkwB3zQQJP6neSs36Sco7gl21dCW5xoE4xgmtCDsraJEb1Q3HHarNWofdGk
 v5jhQID+fvddcf9j0/RqIH3tInhBA/BpiIkUyKzaL/AiWl4jcf5fk+8cIB7Xql1HDXbWc3f
X-Google-Smtp-Source: AGHT+IEbb2T7DOZ4haozsq/fmcmQsNsz6a+md0A4S3mAfB8hKgojFdchpL3nygq64X8h5PoDgKVKvIU1SjnMErIvRLg=
X-Received: by 2002:a05:6402:518a:b0:641:2a61:7da8 with SMTP id
 4fb4d7f45d1cf-64350e21ae8mr5823770a12.15.1763201313090; Sat, 15 Nov 2025
 02:08:33 -0800 (PST)
MIME-Version: 1.0
References: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
In-Reply-To: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 15 Nov 2025 12:08:07 +0200
X-Gm-Features: AWmQ_bnMVEu_xgAT_FgCGb3HwGS4Yh1m17YhVmiQ9u3RZ5FyZ5XvUuHYgU147Wo
Message-ID: <CAAjaMXYV5M-Zkg=1ycopGJBRpcuR5HHx6Cp0FVkws4+QR0VEug@mail.gmail.com>
Subject: Re: [PATCH v1] audio/virtio-snd: fix latency calc
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, Nov 14, 2025 at 11:35=E2=80=AFAM Yanfeng Liu <yfliu2008@qq.com> wro=
te:
>
> Media players needs meaningful latency_bytes update but it is
> zero now most of the time. This adds stream-wise latency_bytes
> calculation so that to improve the situation.
>
> Signed-off-by: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
> ---

Thanks for this patch. The virtio spec doesn't adequately explain what
latency_bytes means, could you explain what it does and why it's
needed? And also what behavior in media players this patch fixes?

Thanks again!

>  hw/audio/virtio-snd.c         | 12 +++++++++++-
>  include/hw/audio/virtio-snd.h |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 9101560f38..ed0422b45a 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -431,6 +431,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s=
, uint32_t stream_id)
>          stream->id =3D stream_id;
>          stream->pcm =3D s->pcm;
>          stream->s =3D s;
> +        stream->latency_bytes =3D 0;
>          qemu_mutex_init(&stream->queue_mutex);
>          QSIMPLEQ_INIT(&stream->queue);
>
> @@ -899,6 +900,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *v=
dev, VirtQueue *vq)
>              buffer->vq =3D vq;
>              buffer->size =3D size;
>              buffer->offset =3D 0;
> +            stream->latency_bytes +=3D size;
>
>              QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>          }
> @@ -1112,12 +1114,19 @@ error_cleanup:
>      virtio_snd_unrealize(dev);
>  }
>
> +static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
> +{
> +    s->latency_bytes =3D s->latency_bytes > used ?
> +                       s->latency_bytes - used : 0;
> +}
> +
>  static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
>                                      VirtIOSoundPCMBuffer *buffer)
>  {
>      virtio_snd_pcm_status resp =3D { 0 };
>      resp.status =3D cpu_to_le32(VIRTIO_SND_S_OK);
> -    resp.latency_bytes =3D cpu_to_le32((uint32_t)buffer->size);
> +    update_latency(stream, buffer->size);
> +    resp.latency_bytes =3D cpu_to_le32(stream->latency_bytes);
>      iov_from_buf(buffer->elem->in_sg,
>                   buffer->elem->in_num,
>                   0,
> @@ -1178,6 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int a=
vailable)
>                  buffer->size -=3D size;
>                  buffer->offset +=3D size;
>                  available -=3D size;
> +                update_latency(stream, size);
>                  if (buffer->size < 1) {
>                      return_tx_buffer(stream, buffer);
>                      break;
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index c176066584..9560bac8b1 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -150,6 +150,7 @@ struct VirtIOSoundPCMStream {
>      } voice;
>      QemuMutex queue_mutex;
>      bool active;
> +    uint32_t latency_bytes;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>  };
>
> --
> 2.34.1
>

