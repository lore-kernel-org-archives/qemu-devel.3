Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBAEC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyhE-0002pY-1w; Thu, 06 Feb 2025 05:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfygn-0002g8-OL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:00:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfygl-0006hL-Nv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:00:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38db0146117so280987f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738836050; x=1739440850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FL4sfXzYv1XscA5pyR3O+D6HIujVSPODF5XSlxyw1eo=;
 b=oK6Yjd9JT1AOM9buDYhlbYUDimJmPB+Wf0rKppSCgcVlUX8W9w6XmS4gb6tH6whQ97
 7gKcKdg59TBvDRZYnAkTZWwKlI9J3bKC2p2JKOH1x88Cu8XtvaTvgCxZMGRDCSPF+wML
 TXMwAlU0HSxJ9HAQ2B5zaQ5ey/K+ZsCva2TTlbuNuAm9kAV9XNyLaGvNQMFplDDJHDbK
 MeOMNcRSCVe2az98UIx8jb43n5YuN0cPkGrClWI1jAfCkeE0dq+g2Isc8pMBhvMQb47i
 Ip0/jHZ+S4l9mciTkNLiWnyxjuT6AUVhyaI87IqR0oqrERWZA8U43eQUtefJ0q/TXfWK
 7Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738836050; x=1739440850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FL4sfXzYv1XscA5pyR3O+D6HIujVSPODF5XSlxyw1eo=;
 b=hEa+79S+je2OdrYFywx6FWevOE2QxMPHNmPifcxJrTJUhT8iRGmr8JBMrahYrkrr4v
 x3tNV/2K2sOBu5b0IhV44ulMbzWgk0tVWgeFdpo/JqUdgZM1aFspe+EjGErgX7/FSgE0
 zfNkGta5KX6OR8LX5Mi73NdKGU4l76JjqcDdqyQj/qN/KgrHbyipJrr47PasEzWWMa4i
 QXtHPp6UhaE1pmRPd1oORB6S8WHg8PdHUEgawUzqJI1aP+GZXZWL833nacJldVTfaRie
 TQajKgfNtXZtEyi+e7IjFxdUTdQvpiFy6N7hpZbZ8lXoVdHXT4CnGFr2BJTkMHzyrK10
 khrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh2rOzs0CFu95hvsgq3vw6Mt1BxXLXuCix9FdrLNLqlfMKVyG/EeXtSP5iaRad/UXd0fi7BsfDUU9s@nongnu.org
X-Gm-Message-State: AOJu0Yw45iniP1NboyHeHG6VEhHA0d6xypx3+HFo+m8LLwA0bRRXDP0t
 KCE6p+CtUjVIBJ1LPzMdAIsO96JXn3nV6uhO3F7QpZx1ePvCv9ZT16Bms99N/uI=
X-Gm-Gg: ASbGncu8qoZ+TI5Dyqnv4HSNCivk7EpDBZF4pZkvY1RIqr8fW31koFZhP9FMe7tZBkR
 VJ/PkAkpavj9b24J72nu/ROfNy9nOS7AXFtkAxmdhmVQQHXAi+IXypm6+TkY6UpDUAHissSCwl6
 HazpPe9tRAj8uvsTuysByu9rCpHeqNra9DKsCLw0xB0viki8nmvcjET+c2puqQQc3FYiBeXjrur
 wQI0LEVX6DAaByW/pX8KIRDl0Asa83+m105mq34Bic0UjZj1QYXeKDbjzBsC5+XGakHIXJmdu4N
 MDKlr6BlbyxM/u+ZFkOH4fGqL5g8qnF+Boe5JjbVCjyKR5+jEWnBU8tHCRE=
X-Google-Smtp-Source: AGHT+IH+OjZ2RNXoIw29R3CxgjSrUbWny2nWVFWzpi/X0zO+/v0MFBpfXL4QaVQEqztv+LV5FXtNbw==
X-Received: by 2002:a5d:5983:0:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-38db4861100mr5008652f8f.3.1738836049767; 
 Thu, 06 Feb 2025 02:00:49 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd35e88sm1262836f8f.26.2025.02.06.02.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 02:00:49 -0800 (PST)
Message-ID: <8cbad5be-e67b-46bd-9198-f7c90ad5ff56@linaro.org>
Date: Thu, 6 Feb 2025 11:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 15/1/25 20:04, BALATON Zoltan wrote:
> The interrupt enable registers are not reset to 0 but some bits are
> enabled on reset. At least some U-Boot versions seem to expect this
> and not initialise these registers before expecting interrupts. The
> numbers in this patch match what QorIQ P1022 has on reset and fix
> U-Boot for this SoC and should not break other drivers that initialise
> (and thus overwrite) these reset values.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> I've also noticed that the work around marked with an XXX comment near
> line 600 breaks the U-Boot I've tested so I need to disable it:
> if ((s->sdmasysad % boundary_chk) == 0) {
> -        page_aligned = true;
> +//        page_aligned = true;
> }
> What should this hack fix and could it be now removed or somehow
> restricted to cases where it's needed?

Cc'ing Jamin for
https://lore.kernel.org/qemu-devel/20241213031205.641009-2-jamin_lin@aspeedtech.com/

> 
> hw/sd/sdhci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 58375483e3..88eb0bfcb2 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
>       s->data_count = 0;
>       s->stopped_state = sdhc_not_stopped;
>       s->pending_insert_state = false;
> +    s->norintstsen = 0x013f;
> +    s->errintstsen = 0x117f;

I guess the problem is earlier:

     /*
      * Set all registers to 0. Capabilities/Version registers are not 
cleared
      * and assumed to always preserve their value, given to them during
      * initialization
      */
     memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - 
(uintptr_t)&s->sdmasysad);

Not all registers have to be reset.

