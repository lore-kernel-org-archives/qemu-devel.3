Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82150C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryu3i-0000vh-Ke; Mon, 22 Apr 2024 09:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryu3g-0000uq-FU
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:50:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ryu3e-00017X-JT
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:50:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so4840844a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713793808; x=1714398608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FT0pNmlLF8T1db8AyoCWX9vXkT6kKYWcAtRC3FBdyVM=;
 b=zGmTvlTD6p610Ikgktovl4G8Oh/Ty1GNJIeXwG9Vtxrh7Gykd1hkDH/vIbodV/BfDx
 oFzk3LgT/AHgYenwxj3SQ1lf/v9iZ8TvPPRUKMCfRinScFdFXDOpYiuuWpWC8QMNh2cn
 m6DaR/h9UeibJU9dV6sbBTalnc1FuELxOdeybJw1uIpOc64f3ZuuaM2sgGL4675Ta/Nb
 Ya6W+g+D8563UH8drUb+aBTt/3vnbd3lev9aqYf/O2eoUdJXQtSagCyyBng03ZVp/ClB
 aoJi8c6ak2kQYLPcMrxayEAX8nSDcdsyFi663tUtXvvO3cMDtYWni+lzYQisO8x8Mqe6
 UpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713793808; x=1714398608;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FT0pNmlLF8T1db8AyoCWX9vXkT6kKYWcAtRC3FBdyVM=;
 b=sNM0H5JLuuvbTmrqYe84dTSfG9roOaWN60B/tllpG15Aq5TqPktPW6T5nblVP0XEG6
 lG9Sq+CaxyOvBkv4jvcDIeqZl7JNKx/mhYemO5Eevx05hHzcxp3Ye6o6HGnDTft/jugZ
 0Nz6NuK1eyLCunGeFk2ulCLsZPZuiyr+lw30cBr1i+CagAm7otMa/lQ3V/ITobV3gErw
 9g9oOSbhN583cgBsAHE7l8eT70GW/5Ajce8UknE5REJWBV+qiFt4uBbVsqtvBazKjASO
 ajLvBMNJ77S3jqBGpgilpoCs1O4485HisKHSQ4DiD4k6tioWP7Hlrqi3LOglQQVnDEzd
 fDFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvmQcORkX3g2rc60goZ/KmPaFnbe5bvi1ixn7niMgqC6jh6FZ/XIeI9eLfapLKZpw/7WRHAmil7CWlXiaXmJPU9QUgqT4=
X-Gm-Message-State: AOJu0YyRBNWnMhC4Oou9iC7vngvUNcCeEVGQnteW52vQKaC0pTR/2Rs3
 wwi/uj9RZ4DVSQw40gnZHYRKYOlEnNROMgrZluU33/aBpi8xmqMNA3ZUa3SyAfJzoqjhtu8uQfq
 s
X-Google-Smtp-Source: AGHT+IH1Bgw+w5bFT5OrYFD7LMKXILoSiXr7X1GfMQQX+/SNycH+Nn0r+2HTjbs+HgFosAqEXbeFuw==
X-Received: by 2002:a50:c345:0:b0:571:bed1:3a36 with SMTP id
 q5-20020a50c345000000b00571bed13a36mr10938598edb.38.1713793808016; 
 Mon, 22 Apr 2024 06:50:08 -0700 (PDT)
Received: from meli-email.org (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 k3-20020aa7c383000000b00570439141a0sm5685531edq.3.2024.04.22.06.50.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:50:07 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:45:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/audio/virtio-snd: Use device endianness instead of
 target one
User-Agent: meli 0.8.5-rc.3
References: <20240422131355.2264-1-philmd@linaro.org>
In-Reply-To: <20240422131355.2264-1-philmd@linaro.org>
Message-ID: <ccjrh.pmmuyk4rntp2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 22 Apr 2024 16:13, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Since VirtIO devices can change endianness at runtime,
>we need to use the device endianness, not the target
>one.

Hey Philippe, can you clarify what do you mean by they can change 
endianness at runtime?

The target's one is used because that's the one it will be using to do 
I/O with its kernel's audio interface.





>
>Cc: qemu-stable@nongnu.org
>Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/audio/virtio-snd.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index c80b58bf5d..82c5647660 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -395,13 +395,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
>  * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
>  * params.
>  */
>-static void virtio_snd_get_qemu_audsettings(audsettings *as,
>+static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
>                                             virtio_snd_pcm_set_params *params)
> {
>+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>+
>     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>     as->fmt = virtio_snd_get_qemu_format(params->format);
>     as->freq = virtio_snd_get_qemu_freq(params->rate);
>-    as->endianness = target_words_bigendian() ? 1 : 0;
>+    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
> }
> 
> /*
>@@ -464,7 +466,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>         s->pcm->streams[stream_id] = stream;
>     }
> 
>-    virtio_snd_get_qemu_audsettings(&as, params);
>+    virtio_snd_get_qemu_audsettings(s, &as, params);
>     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>-- 
>2.41.0
>

