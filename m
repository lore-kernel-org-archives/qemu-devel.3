Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01552C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 13:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDlRH-0002WE-Fg; Sun, 02 Jun 2024 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlRG-0002Vy-CU
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlRF-0006uY-0I
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717335594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXFYe5YnnJ4tEYsVSpcUbocr77FhC1YFieX/jzAHh4s=;
 b=EUFOB6YjgwURz0+5smjeCtu/aZsZieBcsdO2VR4LGf6vicAiIMVH7ibeEx8a7IgGdfPhri
 rImTcuM1mEI+noRs6Vpb8+amzm8OQRRkRaaNHbyXaQCnF4Bsw33LzCn7JhQgRCDLCPIgsr
 RFr61hoI63vQFoKrZ7CEQbWJAC0WHWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-pzVlczzNOVu0IM6FaAq8-g-1; Sun, 02 Jun 2024 09:39:50 -0400
X-MC-Unique: pzVlczzNOVu0IM6FaAq8-g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212adbe3b6so17085855e9.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 06:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717335589; x=1717940389;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXFYe5YnnJ4tEYsVSpcUbocr77FhC1YFieX/jzAHh4s=;
 b=BfXgyAjYgE0mqcOfvHlFy8aDahHVgBhyCB6wpNMGY4qGb2pAZPDOviNIPpScDgL2b6
 fBGd5+xJsWvyDpBqZHoindI3E+h4WqGusiAzyCUqb+bRGg5mwuFz/uro80tu5GJYRfMg
 R1gfrdeadLOR3hAqByoR7LLEeqi+8sK9ICmJJx7TgOnznN2gO0dsSrLUsj+eKE6I3oIW
 s8TcQ5mPvkan5pw0wiqGRJozIfdOG5kw/WWn/KeYdqA+Mrg0GoTNaMmUXGrM599kwKPU
 8GJB7R++5bcZj+zHaOMlCEZCSA+Zuyilm1Jx8fGu8T3k/9ZVFfPBo46w6NxPGTpEgz5u
 Elsg==
X-Gm-Message-State: AOJu0YxeOwmezsyKZEWKJI+PeYsH+Rdpjx8NxoQvrxyfkGuNhplv1U9o
 3X9eOGnlC27riJ/YcR0wMKbYNDIm8Z+gqzmG24HpDmE9L1vdO3yoKtU1YrAhr0CzUIMow64c+9w
 XlxUwO3s13kauoWO8PlPJ8QnJ6C58O+1a3igHSy1VozDY2Htn64tA
X-Received: by 2002:a05:600c:3143:b0:421:2a49:cf34 with SMTP id
 5b1f17b1804b1-4212e04754bmr53154595e9.5.1717335588918; 
 Sun, 02 Jun 2024 06:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdt8SD29hCT2jwsPDkHIW///O6eVGTWrjiBxM/a9mO20444AJBLiT1vAVKZkEk9YrGMTT0mQ==
X-Received: by 2002:a05:600c:3143:b0:421:2a49:cf34 with SMTP id
 5b1f17b1804b1-4212e04754bmr53154485e9.5.1717335588368; 
 Sun, 02 Jun 2024 06:39:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42134f12e72sm52118145e9.34.2024.06.02.06.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 06:39:47 -0700 (PDT)
Date: Sun, 2 Jun 2024 09:39:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v4] hw/audio/virtio-snd: Always use little endian audio
 format
Message-ID: <20240602093933-mutt-send-email-mst@kernel.org>
References: <20240422211830.25606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422211830.25606-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 22, 2024 at 11:18:30PM +0200, Philippe Mathieu-Daudé wrote:
> The VIRTIO Sound Device conforms with the Virtio spec v1.2,
> thus only use little endianness.
> 
> Remove the suspicious target_words_bigendian() noticed during
> code review.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Supersedes: <20240422142056.3023-1-philmd@linaro.org>
> v4: always LE (MST)
> ---
>  hw/audio/virtio-snd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index c80b58bf5d..ba4fff7302 100644
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
> @@ -401,7 +400,7 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>      as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>      as->fmt = virtio_snd_get_qemu_format(params->format);
>      as->freq = virtio_snd_get_qemu_freq(params->rate);
> -    as->endianness = target_words_bigendian() ? 1 : 0;
> +    as->endianness = 0; /* Conforming to VIRTIO 1.0: always little endian. */
>  }
>  
>  /*
> -- 
> 2.41.0


