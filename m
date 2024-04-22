Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FADC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 21:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz0wf-0000tt-Qb; Mon, 22 Apr 2024 17:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rz0wa-0000sw-5V
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rz0wX-0006yv-3N
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713820276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9jM+qZgW0RWPcmc9y+SSgz/sapjvb9rr3uaw8e04Os=;
 b=g7kEkP52Cl5nMHaCbzd2vNizaKhYiatfO/EP203P7YGyOBA6aSVY89x42FGBZ0iGFZe5Zn
 X5ztcf46MivVhpqCf/zlj0xmvY9Ug8U8z9sX/rCeBqPEqsn9sOjUiCqosfMnYSt3GWTkx+
 STRZjA4j7ZlmVBrgnRcq9N3g4lYeiHg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-LkOxN8j8OZqiSsDycL_t1g-1; Mon, 22 Apr 2024 17:11:14 -0400
X-MC-Unique: LkOxN8j8OZqiSsDycL_t1g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343f1064acaso3676466f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 14:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713820273; x=1714425073;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9jM+qZgW0RWPcmc9y+SSgz/sapjvb9rr3uaw8e04Os=;
 b=lmco9MUF8DTe/bXzUeyNjj7rpKJkkL+27S7FoujoCkGhpXAPPyHogXhoxoIaDVFVwy
 QVvKXFnBB8lMXcfJX36JKg2JhJAYmyxMxM7xVJ5MTt1L882MPRDAe5Te64s/JSTqrHqN
 OZNqzPJYw0TPFaFqAcMBG2sc8E8dAmscuQfkifCOGvNLyYocG/Kl7nBRLuVc+0a/UOvm
 R4BQXsFVHVyPGiVxNFeBjvqADCaIIWWVO2XP0j9fgW1SVOQbgSF02BVmFR4MG1A/BBJb
 NrSBOq1bvxEXeK69h6aNXY/M2qAcd0NG9aRHDtRRUZkcp6sFRh2ULA1lvuidH82Qbw+F
 d4zg==
X-Gm-Message-State: AOJu0YyjmXCnFEvPsa00ygADz+5W2x0coF+/nHBR/9vj8brYkNupR0r6
 W1Ad1Y6bpxz2BelGn088Fwd4YSY4fOzrgoOOJv6jSYkrXVgYsPLSo9rBoGxp/f4mjI+xdjnBZUf
 u/f3h1BCBMnGMf3xQOAxL2L7Alzvh3G8aurwNhHyM0+7HYjcANWFz7DH9i4EB
X-Received: by 2002:adf:f045:0:b0:34a:e6bb:9bf with SMTP id
 t5-20020adff045000000b0034ae6bb09bfmr4336733wro.4.1713820272860; 
 Mon, 22 Apr 2024 14:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Xzh7RGaBB0aQHzMm0i2yEZVllgYPTJmnonpateEZYAtlbQ6Op5U/5RN3uS2qSisUXQb/OA==
X-Received: by 2002:adf:f045:0:b0:34a:e6bb:9bf with SMTP id
 t5-20020adff045000000b0034ae6bb09bfmr4336717wro.4.1713820272312; 
 Mon, 22 Apr 2024 14:11:12 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
 by smtp.gmail.com with ESMTPSA id
 c11-20020adffb0b000000b0034b1a91be72sm1071253wrr.14.2024.04.22.14.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 14:11:11 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:11:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Message-ID: <20240422170913-mutt-send-email-mst@kernel.org>
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daudé wrote:
> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
> > > Since VirtIO devices can change endianness at runtime,
> > > we need to use the device endianness, not the target
> > > one.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > 
> > 
> > 
> > This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> > It is unconditionally little endian.
> 
> Oh, then the fix is as simple as:
> 
>  -    as->endianness = target_words_bigendian() ? 1 : 0;
>  +    as->endianness = 0; /* VIRTIO 1.0: always LE. */

Makes sense. Pls clarify in commit log whether the incorrect
value leads to any failures or this was found by code review.

> > If it's not it's a guest bug pls just fix it there.
> > 
> > 
> > > ---
> > > v2: Use virtio_is_big_endian()
> > > v3: Remove "hw/core/cpu.h
> > > ---
> > >   hw/audio/virtio-snd.c | 9 +++++----
> > >   1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > index c80b58bf5d..939cd78026 100644
> > > --- a/hw/audio/virtio-snd.c
> > > +++ b/hw/audio/virtio-snd.c
> > > @@ -24,7 +24,6 @@
> > >   #include "trace.h"
> > >   #include "qapi/error.h"
> > >   #include "hw/audio/virtio-snd.h"
> > > -#include "hw/core/cpu.h"
> > >   #define VIRTIO_SOUND_VM_VERSION 1
> > >   #define VIRTIO_SOUND_JACK_DEFAULT 0
> > > @@ -395,13 +394,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
> > >    * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
> > >    * params.
> > >    */
> > > -static void virtio_snd_get_qemu_audsettings(audsettings *as,
> > > +static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
> > >                                               virtio_snd_pcm_set_params *params)
> > >   {
> > > +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > > +
> > >       as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
> > >       as->fmt = virtio_snd_get_qemu_format(params->format);
> > >       as->freq = virtio_snd_get_qemu_freq(params->rate);
> > > -    as->endianness = target_words_bigendian() ? 1 : 0;
> > > +    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
> > >   }
> > >   /*
> > > @@ -464,7 +465,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> > >           s->pcm->streams[stream_id] = stream;
> > >       }
> > > -    virtio_snd_get_qemu_audsettings(&as, params);
> > > +    virtio_snd_get_qemu_audsettings(s, &as, params);
> > >       stream->info.direction = stream_id < s->snd_conf.streams / 2 +
> > >           (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
> > >       stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
> > > -- 
> > > 2.41.0
> > 


