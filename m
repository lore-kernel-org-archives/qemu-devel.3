Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72023CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITZE-0001w6-7v; Mon, 10 Nov 2025 10:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITZ3-0001ss-HL
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:12:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITZ1-0003S0-21
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:12:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso33174735e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762787534; x=1763392334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cosRvGSsVkgCTBq1yvXIjBQmbJ5iq2ZSdaC0e5uZW0=;
 b=kNmX9sKlaWzUPcpMhMyvQwW8VJQX9NS36iwqr97oQORGvCl3hXHhlG6OQc2usojH41
 +WkcwFcwgjQvIIRps7gLh2ebjpePURyttlHhsi74GaZNH0wi3RQXKAlFQAZlJf7ckwJO
 6GtM/GaCwJu5YkIiyQ/Dxkfw4egYVCs/xfBeaa5BRSmM0LJPzmPxgx6z7f16GTPJwf1Q
 6tRnCDwiRDV6L8UqLEy/MJoEr7hsQtQAUppIN77RKx9BI1xuzqZpv2ruc9Qw3kS6aWjO
 ft3BrmamwuBo1vnQHSC/7wC0Jxmxu48HdU3PUrFTV+hj58vk+3XzBD0v8Z4CuXnST+9q
 4mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762787534; x=1763392334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cosRvGSsVkgCTBq1yvXIjBQmbJ5iq2ZSdaC0e5uZW0=;
 b=YmRuMMhuCRjS3jKoTxh5V+JuIfY/FptrZCyRXHl9GQv+b2r0QtsKr7/zkMCOa7/wBS
 grJmzkqOvXiq9MrY/lhNZQnmm75cU5HcNugBSg4f0qlYbF3/Q6OHyFSAdCXl31RlvQ5X
 H+E056pBK68/mTipUbQiId4H0qn3E6Qa55+6mDVOIEM6vik5gohiVGgfopKwFWmlmytn
 mrcHblkEzqXd/8QEIEFmZNghnfCuYWlpIrCQA3rt4pqs40V9wB7jo1z8Wt7LGZmITGBS
 fX4yF0Q3tvMYw1OEBv2xlVE2WZcH+btVACwg6VWIDoVT1an2/6qfqT3s6SNOK3UZY3uw
 +JGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnVtHgxEeYU5tmWSGhb7lhBWyviRYZ9eymcgv8qMNAnYEdXjTiiS64uat8EcLS9dWarQk7D1Bwlc06@nongnu.org
X-Gm-Message-State: AOJu0YwTl6Aytt+j0Wo5la4a0EBGPUhtuuU4LDDBugmLUOVx+Jad8jOe
 UEpeLew5cHmp0rx5WrwL586uCJIfVNpcEQ59L4u7D0ENRMcDCV1c71knp8cvRrGvL3U=
X-Gm-Gg: ASbGncsEO8X6QgxvigMcRCPxX4rJ2cvg/zavacVZGOrgYs6fegQQiA5nanUT4AwDMw6
 C1FGigaPi0QAy4o8ES5IwtJ9+z9MFpsZQta1p2keIwhmxgVK8ZS32czLuYJoQSEpkOnQkXFGMRU
 yif7cGWOogoSuu4YGeEhGryDM/C0Ljbo9UBdu4tQeqmdwe9rOc7NGseURPKvf5yk9kO69OoWT97
 4gYKlBQgZwek/ptBBCFeE1bApgVR+mqhcziB2foorhraMYgfG275dd6LRe8Ec/yR8Q+qUbr6ccA
 Ft7ntNTt9tjcr8q+zNh1ZSCkAAilsPGMv3KiKPIAEQJSj0bHXAZmqCYKC1Oy7sm1KJEBLTaDNhM
 xsneUXSov3ZUSMsRa2qPvWAlM/3zpZYTT6FwY2LW6nzNvUfJYnrtGSK/JYoO/hgFJts5sKYdjJa
 M/PknXqj5HGKZFS6JHLmTCrEQ1c5eiMskeKrN62WTwTJl6NLgCgPwQaeg=
X-Google-Smtp-Source: AGHT+IFA/fvAfQFwN744BjHot82tX6yHuUIK39yx/qgkYz8+u+PcsYGtKvRgajCXFuV46JkzYNF3pQ==
X-Received: by 2002:a05:600c:4e4c:b0:46d:5189:3583 with SMTP id
 5b1f17b1804b1-477734656damr66766495e9.0.1762787533420; 
 Mon, 10 Nov 2025 07:12:13 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477632bda1asm260022395e9.3.2025.11.10.07.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:12:12 -0800 (PST)
Message-ID: <9e4afca6-d508-48bb-9315-7c59027314db@linaro.org>
Date: Mon, 10 Nov 2025 16:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] hw/arm/fsl-imx8mm: Adding support for Watchdog
 Timers
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-10-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-10-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/11/25 12:22, Gaurav Sharma wrote:
> It enables emulation of WDT in iMX8MM
> Added WDT IRQ lines
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/fsl-imx8mm.c            | 28 ++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  7 +++++++
>   4 files changed, 37 insertions(+)


> @@ -481,6 +486,28 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
>                       fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
>   
> +    /* Watchdogs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_WDTS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } wdog_table[FSL_IMX8MM_NUM_WDTS] = {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG1].addr, FSL_IMX8MM_WDOG1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG2].addr, FSL_IMX8MM_WDOG2_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG3].addr, FSL_IMX8MM_WDOG3_IRQ },
> +        };
> +
> +        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
> +                                 true, &error_abort);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> +                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


