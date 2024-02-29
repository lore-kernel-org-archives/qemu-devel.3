Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4FC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpQI-0005Te-T5; Thu, 29 Feb 2024 18:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpQG-0005T0-MM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:02:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpQB-0006Ui-R8
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:02:40 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c1a7d51fb5so1126154b6e.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709247746; x=1709852546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+FjtQ/FsVILsUbpCoTp3msJhtQx3r+SxfudK/yQyxoI=;
 b=ANmB9jevY9gILIbAyEONTW1sRRU6f15fvH93MURDwfnorpiwJyYdqvqI70ntqmosM5
 CDzmAAd/gn8chy6su24xTSLdRauPPdOwq1Jil1p9FO218AR1oQPLn7A0b1EMgn8w2ROF
 7GmbZdSz4sDMDHiyV/uG2CY3VNk1tHFAa9QJAeygInixaR82nM5KQzIce+DH8T1WP/md
 YyM3q0bmLYXHCeAAsJulKQYfiJvma+4WD7cwoo2Jb/xJ143CGMJeFmAWCVmhP9I9zg1u
 5xh9Q8kSmV6FJ1aDmibJ8yjZQEM8IA2ynOODbihKF+OzU6XjsAqtLqGc1DtBC0lI/oxU
 JRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709247746; x=1709852546;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+FjtQ/FsVILsUbpCoTp3msJhtQx3r+SxfudK/yQyxoI=;
 b=KXfvm01KM1GKbo9l39oCNAIeQaJoQxDhRfTkdtLrMv4t6NsLSuORZ9G/RuS20dQBtQ
 RKAGEtmZO6kn3m8seRgAJ5053N2Cxz8bR0avry3sR+ccDPQFAB68iZBhJQlVzEi+sp9q
 HRibOvq1m6hH4HlLqsoekT/eKAA9CTiamdJqslkklbb6vRjL6uNINv+oRX2Lor8LxZyX
 FrUhvroo7CBCNunVlJgUNdnxxgUM90yu6hiVHWC0xEiAwFrzPxlLU0dw1qxh6BNPyzDg
 Ebf2zVT/s2uLia33DEPOGBnjHUmc2Gj8m9sOSDD69WnEjb3qfwgVu+bVOTufCfAcijYE
 UAMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMfB37e7kyqvwJ6LG+axeb7n2GzQKBrL1RSLis0/ehNlik+KWW/GEZV63kZuboa6haqDTmn4FDgA4ycfWe40njZsv9dfk=
X-Gm-Message-State: AOJu0YxK5X5ogl+HkcY1VoJRdkP9q1eYHhwGLTXyPPt8Pj2GCV8qQrIw
 HtfLl0LdpICVWAZPfE99aNrtAioRidSBF6rODjA71JO3XV6iTbXSP0lZIle4+jI=
X-Google-Smtp-Source: AGHT+IETvL450/wveP8Yf5S/xC8o3Tu4q/7Y4AM00unAuToaThWyjjffAGD53vNi4LfIpqNqHQaXgg==
X-Received: by 2002:a05:6808:1202:b0:3c0:72ba:64e with SMTP id
 a2-20020a056808120200b003c072ba064emr21624oil.39.1709247746247; 
 Thu, 29 Feb 2024 15:02:26 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 v184-20020a6389c1000000b005e43cb66a7asm1856051pgd.87.2024.02.29.15.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:02:25 -0800 (PST)
Message-ID: <8d494fe8-c0f0-47b3-9f59-ac69f10c1e64@linaro.org>
Date: Thu, 29 Feb 2024 13:02:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 06/22] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-7-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> +    bool new_state = ((env->cp15.hcr_el2 & HCR_VI) &&
> +                      (env->cp15.hcrx_el2 & HCRX_VINMI)) ||
> +                     ((env->cp15.hcr_el2 & HCR_VF) &&
> +                      (env->cp15.hcrx_el2 & HCRX_VFNMI)) ||
> +        (env->irq_line_state & CPU_INTERRUPT_VNMI);

Because the GIC cannot signal an FIQ with superpriority, I think you should not include VF 
&& VFNMI in CPU_INTERRUPT_VNMI.

See comments for patch 8.


r~

