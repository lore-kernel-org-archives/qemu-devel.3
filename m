Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0243FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytb5-0006m1-SI; Mon, 22 Apr 2024 09:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytb4-0006l1-Ir
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:20:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytb2-0003ON-Jo
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:20:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41a5b68eceeso6167405e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713792035; x=1714396835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2uQmAeWSIT8jc3t5xicFBYi2SNpXCUo+mLWo2/O0Cd4=;
 b=mpbXM71lVKlw0hcgESKJfaTa3eky+BXdVyBzDFMWuqVqpieTHI9eS7c591JDDosNK3
 H0KUsc2r2W5c69lpvWeH+/E6Y1ERwFSfF6XeQWY1+AljOG3vSntNVgKgN7KxUtlsrrVG
 Kxdkp+0OAN0AZdNm9+tAPuuS6yXzfs+6LG3sUrR9FizDN2cOaDpJykJ8ykYn4ze/qE1+
 F40C4JypdV+0Q8rk/C7DNs1VpzcreDN/gLlG1U7iAmlWUWpboadMnQ6fcWwu3vewpInv
 qYJvUm/ZLlUVGTFzNBKpn4U66sydP9Dr2wVXA8p+gFaiPCoB3iOXbap9r89M9xug3cGT
 TAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713792035; x=1714396835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uQmAeWSIT8jc3t5xicFBYi2SNpXCUo+mLWo2/O0Cd4=;
 b=tabZIw8XGPj2wz2a6ENh5Qf/mrAhYR/9vXxq8tY7BwtD2qVSs9MoGrUSMg2tfgsAmK
 yZiRpQKzwYzPvnrwUPgxMvssnb8U+TAwTltdMl0q4ZbOneHYAgz48joSu2BFQ1sfUE0u
 +nQujbhCPTY9fO1PPAQX+a1rQu1UOhKsYzisMZKq8+WTJw/k5anbHYk3+SKajY/pxJEA
 h+koRjMelFMutBAErbHm8hyvBb4hetJshbq4poYJP0c8qlXGze6I+d8OSrCPIk6Mt5X6
 YyiewCpM3yQqk4ciiSb8D1rFKZdcZZ7KiKdDb7HF0Gs2ji6KFI7MhaHHnpOOwNoKf3Qu
 3Vbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvSgjm0WsVlI+/Rj2hYLFEzBvmDbhf9WshHWQ/ciTDzjH7rrvtPz0Vk8xPfBGQwv9Qu2DmP/J+W9lIeIk3vbsI/YXCsL4=
X-Gm-Message-State: AOJu0YxU6/Oq3j//9J/vCbz6PiPCsvKwCr/AjHH2DAX8u/8SxW9RiP5L
 LuNepx1/SRY0+VuruK5wSz+MTU4+FllH6+NwyUcjM4HJMBBuhjy97QOIeLxmRyU=
X-Google-Smtp-Source: AGHT+IFA0yzCc2AWI9Rf80UIRc8lu27GF7QnJFd9KSVPCQ5f2Lhqy5fVxrDthNY040QJb52zfLWqvw==
X-Received: by 2002:a05:600c:4ec9:b0:419:ed35:e312 with SMTP id
 g9-20020a05600c4ec900b00419ed35e312mr5648774wmq.21.1713792034810; 
 Mon, 22 Apr 2024 06:20:34 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 d5-20020a05600c34c500b0041a33b8f328sm5228050wmq.12.2024.04.22.06.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:20:34 -0700 (PDT)
Message-ID: <71e598d8-19f0-46de-9dc1-b8322d87e2dd@linaro.org>
Date: Mon, 22 Apr 2024 15:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] virtio-snd: add virtio_snd_is_config_valid()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zheyu Ma <zheyuma97@gmail.com>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
 <491c651b075ac51f1c54f561bebaaac6dfc7f8de.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <491c651b075ac51f1c54f561bebaaac6dfc7f8de.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Manos,

On 22/4/24 14:52, Manos Pitsidianakis wrote:
> Factor out virtio_snd_config value validation in a separate function, in
> order to re-use it in follow up commits.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 47 ++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index c80b58bf5d..7ca9ed251c 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -1045,6 +1045,34 @@ virtio_snd_vm_state_change(void *opaque, bool running,
>       }
>   }
>   
> +static bool
> +virtio_snd_is_config_valid(virtio_snd_config snd_conf, Error **errp)
> +{
> +    if (snd_conf.jacks > 8) {
> +        error_setg(errp,
> +                   "Invalid number of jacks: %"PRIu32
> +                   ": maximum value is 8", snd_conf.jacks);
> +        return false;
> +    }
> +    if (snd_conf.streams < 1 || snd_conf.streams > 64) {

Why the undocumented 10 -> 64 change?

> +        error_setg(errp,
> +                   "Invalid number of streams: %"PRIu32
> +                   ": minimum value is 1, maximum value is 64",
> +                   snd_conf.streams);
> +        return false;
> +    }
> +
> +    if (snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
> +        error_setg(errp,
> +                  "Invalid number of channel maps: %"PRIu32
> +                  ": VIRTIO v1.2 sets the maximum value at %"PRIu32,
> +                  snd_conf.chmaps, VIRTIO_SND_CHMAP_MAX_SIZE);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static void virtio_snd_realize(DeviceState *dev, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -1055,24 +1083,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>   
>       trace_virtio_snd_realize(vsnd);
>   
> -    /* check number of jacks and streams */
> -    if (vsnd->snd_conf.jacks > 8) {
> -        error_setg(errp,
> -                   "Invalid number of jacks: %"PRIu32,
> -                   vsnd->snd_conf.jacks);
> -        return;
> -    }
> -    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
> -        error_setg(errp,
> -                   "Invalid number of streams: %"PRIu32,
> -                    vsnd->snd_conf.streams);
> -        return;
> -    }
> -
> -    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
> -        error_setg(errp,
> -                   "Invalid number of channel maps: %"PRIu32,
> -                   vsnd->snd_conf.chmaps);
> +    if (!virtio_snd_is_config_valid(vsnd->snd_conf, errp)) {
>           return;
>       }
>   


