Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB28C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP4w-0007t0-8J; Tue, 20 Feb 2024 07:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP4t-0007sY-Qz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:18:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP4s-0004KQ-62
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:18:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4126aee00b2so10186175e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431505; x=1709036305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxZ/1Wp/ALyY7BKNpyDflf3LMmHEkqKQ6VtkdTvFR64=;
 b=a6KCuex10yLUrR8sQrC1G0LpngBfUV27CRl+VmxNtNpjcG8OwpXbRskVcV/GPKzWw+
 CZXwORUOB1uR7ajPJ85/obp7tL81DtYvrcSe2EHm6VypCrNZjO3su2kiKQmnrTo2wR+S
 UBgEQMENI70HSjuGdC2n/MROixdMXL6Vyv1w9BWZfzkFikaYlRU8h8uMlOM2M5etA7+U
 cdBrcHm8P78RICAnJRq342ydvPSSPyhfOdDmFXnefMj5/l7jDmlVftRVdxvF5bZ61UDS
 ymlOEY7EFsTWsCfFJ+4vgsnZ3Gw6Ad4N00Y9/uIMRyZKd4ZxbGW6VSG6QRyTBfKxb5zy
 Crcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431505; x=1709036305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxZ/1Wp/ALyY7BKNpyDflf3LMmHEkqKQ6VtkdTvFR64=;
 b=my8EB3tJopLpiRxyWv0RsRrOq8ZIWkRg+m6KFEBV1KvRWSkFj4LC7Z7yNXcjMzkyWC
 qGA1HcagwxMwIT+N4B8skEEKwd53JF53DYoR85fZH/BOPQzC1ToaijuzJ4U/yMk+iaHt
 2EhKLNyDJTDtGaGW+uPuiWLoxzUyvyrxQLW2R8gkLj+9C8xbzIrLgbPIfVYwDTdHEOkx
 BWUktuYCziZ0mx7GiCgD/cRk4EAG6kaCBj1bLlb36R1Ze+aKS1Ipdu37d46ZRqAm5iP3
 2Veo3egJd2HzoMmKEXXKedB+V/eJn9It/N+zwby+CzaI8k+7O9qv+rVrEOdaRQfr77Bo
 JGNg==
X-Gm-Message-State: AOJu0Yx2hMcvy25LRXygl4BZd1EAzpXEiuQiJ5XS9oR6Ve3DECOPB1MG
 sLuCAKJaofqc2pGzu+gczOlVRrqntz5wAeO/Be7X0+XoFcDK87QLb0x1M+iHRWg=
X-Google-Smtp-Source: AGHT+IH53uDhVOEv2S5z/e47ksjK8i7feXGNgRLZNkxAI+xdusYGRNLUcpaR3EJIFajL+S2dzNLdRw==
X-Received: by 2002:adf:fe0f:0:b0:33c:e35b:7a59 with SMTP id
 n15-20020adffe0f000000b0033ce35b7a59mr10054563wrr.48.1708431504685; 
 Tue, 20 Feb 2024 04:18:24 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:18:24 -0800 (PST)
Message-ID: <9ac1a0a8-7a71-4074-8ea5-62cd98fefed8@linaro.org>
Date: Tue, 20 Feb 2024 13:18:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/21] hw/arm/omap.h: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <3a8b80f6427bf84580eec8f7c5c411fab5419e1f.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3a8b80f6427bf84580eec8f7c5c411fab5419e1f.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/hw/arm/omap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 067e9419f7..2f59220c0e 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -1008,7 +1008,7 @@ void omap_mpu_wakeup(void *opaque, int irq, int req);
>                         __func__, paddr)
>   
>   /* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
> -   (Board-specifc tags are not here)  */
> +   (Board-specific tags are not here)  */

Unfortunately you need to update the comment style, otherwise
this patch doesn't pass ./scripts/checkpatch.pl.

With this fixed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

