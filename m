Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32458C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 21:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz0oK-00061n-Jk; Mon, 22 Apr 2024 17:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rz0oH-00061P-Nl
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rz0oG-0005Pn-3F
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713819762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwJuwB6i9c99azBPYvE/J6EUjLdCcbSxnTCMkwsd7pk=;
 b=CkggT1NkYKsb92ZRBjtWuOaQJt2EwBCO7iMcZESiokR+HZaZWDg/yZ96Gx7s/Ua/53CkV+
 WcclF78vYsq5ti3/G12UNGFajKguXX9bPotJUVmtFGUGKZITgfLFj7+HgiyUOwXT1ZLohH
 mv27ZD4f+PVieStukVduTnuay+RO9HI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-UzPyFOt9PFm6KgY6Xp_jrQ-1; Mon, 22 Apr 2024 17:02:40 -0400
X-MC-Unique: UzPyFOt9PFm6KgY6Xp_jrQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343da0a889dso4502316f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 14:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713819759; x=1714424559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwJuwB6i9c99azBPYvE/J6EUjLdCcbSxnTCMkwsd7pk=;
 b=Sd4ATSTztxtyzB7uvLMf91tmcUY/mg29M0nDTzz3X6MfPADUVW01515L3qxDTE6UaZ
 qeDDhRgGFimSybLrDEsp4AYQzf/PP9wp0xvO5S2Z1oJeieC+meyaFMdYWKjIH4D721of
 jq7RoM6b4RuCBVwiiP2V5om0Xi1PtiqFOkXZxc9lXTvKQ0Xvl1c+7uKPwT9ioBAOduKS
 DpmFk55PAm4v7kuQAvtn6iH8T4Mk4jAWMpQgmh+DEZ9oukk2DSK1kZJKabJnAU0HFRLX
 xFvZ6bwFd5zggSG1FkziCFtXRL+U0RmCbxkvsHyvYxg8upqOL7Eweo2WQN+w6j0O1yOE
 G0tw==
X-Gm-Message-State: AOJu0Yy0Vr+q0PipiDafkjETXtupTaSeq/qFpqFqIH/zNUGcEEREf5qI
 zuji2RlbWmsU0XdmbL48cLPIgK15FVdC0lky9GpTJfa24u5Ly6G4chzGbck8e9zcivkCftYXPPn
 1lYm5/5ZlFLLaDEwduS9j1rHWUfPl+3Qz7sVeYjav8Rjm5Qc3V3FG
X-Received: by 2002:a5d:6886:0:b0:34a:48a0:fa70 with SMTP id
 h6-20020a5d6886000000b0034a48a0fa70mr9661631wru.40.1713819759382; 
 Mon, 22 Apr 2024 14:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXcGkwYev8eLWne2WYn1nUMwPSn49/yj9KubKu7k+QyjB4Jz4eA7ILwKKal0njRFvnSvsYpA==
X-Received: by 2002:a5d:6886:0:b0:34a:48a0:fa70 with SMTP id
 h6-20020a5d6886000000b0034a48a0fa70mr9661607wru.40.1713819758748; 
 Mon, 22 Apr 2024 14:02:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfe6c5000000b003436cb45f7esm12864850wrm.90.2024.04.22.14.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 14:02:38 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:02:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Message-ID: <20240422170056-mutt-send-email-mst@kernel.org>
References: <20240422142056.3023-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422142056.3023-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
> Since VirtIO devices can change endianness at runtime,
> we need to use the device endianness, not the target
> one.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>



This is all completely bogus. Virtio SND is from Virtio 1.0 only.
It is unconditionally little endian.
If it's not it's a guest bug pls just fix it there.


> ---
> v2: Use virtio_is_big_endian()
> v3: Remove "hw/core/cpu.h
> ---
>  hw/audio/virtio-snd.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index c80b58bf5d..939cd78026 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -24,7 +24,6 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "hw/audio/virtio-snd.h"
> -#include "hw/core/cpu.h"
>  
>  #define VIRTIO_SOUND_VM_VERSION 1
>  #define VIRTIO_SOUND_JACK_DEFAULT 0
> @@ -395,13 +394,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
>   * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
>   * params.
>   */
> -static void virtio_snd_get_qemu_audsettings(audsettings *as,
> +static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
>                                              virtio_snd_pcm_set_params *params)
>  {
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
>      as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>      as->fmt = virtio_snd_get_qemu_format(params->format);
>      as->freq = virtio_snd_get_qemu_freq(params->rate);
> -    as->endianness = target_words_bigendian() ? 1 : 0;
> +    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
>  }
>  
>  /*
> @@ -464,7 +465,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>          s->pcm->streams[stream_id] = stream;
>      }
>  
> -    virtio_snd_get_qemu_audsettings(&as, params);
> +    virtio_snd_get_qemu_audsettings(s, &as, params);
>      stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>          (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>      stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
> -- 
> 2.41.0


