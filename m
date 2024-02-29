Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626D5C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpWq-0008NN-Gj; Thu, 29 Feb 2024 18:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpWn-0008Kt-2Z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:09:25 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpWk-0007cS-9F
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:09:23 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-21eea6aab5eso900822fac.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709248160; x=1709852960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4Zks7rS4NPMc826tI+OvfXrAECpt++NHSHMSdDgNRw=;
 b=Y+7GPmFGZ9xcChpa88y53Ps4dFrQmII74hAf3F8UXJvZdEHjqf+UnpsVcNGDdbRjkI
 kzebRqdkEWzJtglV3C85dmkYFNlRTTEjzvTJf6meEHLp00iJ2wb0fv1C7+t1AgguBhRy
 zugD0V0u+VsylMdeD1vsrZzt2R5VQ2kKRQ5q4R+EyRIOH5T+LPo7t8NpHinaNmKP/cX8
 dkon5S90Z2hIJ3MeyxT4E7Ad/H8914djJH+TVVQbWO1MynWO/Rc8/pU89fgHic1uSZKA
 /zgyU5VqbmdwtFBiKAuvjYXNr/sY5DolGNU6vZnA7cSp5nCsN9szLBqzkPv+/qaxeeif
 7YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709248160; x=1709852960;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4Zks7rS4NPMc826tI+OvfXrAECpt++NHSHMSdDgNRw=;
 b=uN0KbA/5OixHhCT1NGDlQUHLC5Q12E4PJJcAQRODUDgi4Cnc9DBiWPouzjzkpx4JNA
 QPrJK9krTLC5/MpZjKw6n0RltxDoR1u5b+N5TxKNpUZwAojHy6TYdeESZ7JrMdMLg2Js
 sglLnwZN2k5pGOxC50CDX5EBW2SBVqy7HuxCxqWC0LKch4pL6h6n4vlOvo9mwNFKOPfm
 sx/Rc0Jk0NkU6J5oE7NY1w8KgfB7XdhXblLXm0o+WHjl1l3l8mrTSTsQ1DMO53WM48E/
 it1zAs0hRBb0yhhY+Rq5T/Z8RiEmeUCCC1dYP1bQCbZXow6FpFWcMbUiXFBc6+LJyiZx
 KPrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsmARyq2VsLZ92uoqPfZxfeQgTXA8oaHh1ySCLcpZcQZ3haJLWRb0WJe5VUi8WM3xoLEAMLYbpq6XcOs6aAO4Rc5E5K2k=
X-Gm-Message-State: AOJu0YziRafSaOriyDixtiqE3FVXz4YqtU5DtyTG3wGaRd8DZak0RVkh
 4aQnLhLAErCxnWUz/7+GvsWqK3o/3PCnk3J8LEXKuFZoHzQertMlDu6HNiXh1u4=
X-Google-Smtp-Source: AGHT+IE5k4szT7KekWPPUMAumtRNVedgTUTdTu014ISPFCGWby1UGHVoATxaRFlGODWLcuknYprTsg==
X-Received: by 2002:a05:6870:9585:b0:21f:dc71:c3f4 with SMTP id
 k5-20020a056870958500b0021fdc71c3f4mr4074275oao.43.1709248160555; 
 Thu, 29 Feb 2024 15:09:20 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 du6-20020a056a002b4600b006e5933a0da9sm1733399pfb.165.2024.02.29.15.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:09:20 -0800 (PST)
Message-ID: <e7fd1fba-ee1d-4b78-b743-128fa8217ed8@linaro.org>
Date: Thu, 29 Feb 2024 13:09:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 12/22] target/arm: Handle NMI in
 arm_cpu_do_interrupt_aarch64()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-13-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
> with superpriority is always IRQ, never FIQ, so the NMI exception trap entry
> behave like IRQ. However, VNMI can be IRQ or FIQ, FIQ can only come from
> hcrx_el2.HCRX_VFNMI bit, IRQ can be raised from the GIC or come from the
> hcrx_el2.HCRX_VINMI bit.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Also handle VNMI in arm_cpu_do_interrupt_aarch64().
> v3:
> - Remove the FIQ NMI handle.
> ---
>   target/arm/helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b796dbdf21..bd34b3506a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11459,12 +11459,21 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>           break;
>       case EXCP_IRQ:
>       case EXCP_VIRQ:
> +    case EXCP_NMI:
>           addr += 0x80;
>           break;
>       case EXCP_FIQ:
>       case EXCP_VFIQ:
>           addr += 0x100;
>           break;
> +    case EXCP_VNMI:
> +        if (env->irq_line_state & CPU_INTERRUPT_VNMI ||
> +            env->cp15.hcrx_el2 & HCRX_VINMI) {
> +            addr += 0x80;
> +        } else if (env->cp15.hcrx_el2 & HCRX_VFNMI) {
> +            addr += 0x100;
> +        }
> +        break;

By not combining VFNMI with CPU_INTERRUPT_VNMI, you don't need this complication.
Just

      case EXCP_IRQ:
      case EXCP_VIRQ:
+    case EXCP_NMI:


r~

