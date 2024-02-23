Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C2BC54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 22:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rddzS-0003YT-Iz; Fri, 23 Feb 2024 17:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rddPX-0004CU-6O
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:48:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rddPU-0000DT-TF
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:48:50 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e45d0c9676so628364b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 13:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708724926; x=1709329726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYlMYISlgRm/4KA4kPSTs9crtAC5Oq8DsbR8nT4sCZg=;
 b=rudQvtDmWJ8mv6cm0nVAf9iCSXf5vuPULtMgz9AqJAdLO8yl3OstAawacm4w+LDc1o
 1MGGOx85tU9aDTnFvOb1WS0ND3ZWfTJDBnxuGoW1DJN6ao3yipemsPCqmzMURd/TIWCJ
 4K0yJ7UYKkh8uOipOZ9nW0YeOKLeqG4WcaBD1zGYqf+dBUDBD35Ap+k62Ae6FT5YA8Sf
 nRPwZa7bvEgRWizcMtmXyP/8EA+ptL5jrqfbH+hPuj7L4NYySdqdeKvfWJJgjNrAy0VA
 XZGMIDtDUt7Dme23cXuR3gN6OSZ9CuhXiNGDMhOjRmOwwMni8oDVkiqVB/qOQ5QpA7uk
 nniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708724926; x=1709329726;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYlMYISlgRm/4KA4kPSTs9crtAC5Oq8DsbR8nT4sCZg=;
 b=WOhFgdenIobfYJN1Z+YAOo9hq3mKunxuqwp+X5XqRuROaC8wz5uinQdBufCgzMvI4B
 f/2gIaqZ2DF+vNDA7EaDZzmv3zKLQ+RizsJK4sGBr/paUc65mGRlb9VMSKGnyc56fQai
 FiemPOjsbA0zwtcdEYMmaQiIbTHgjBke830UPHtnrT9/3jZZr5SBJHBGw6lWY4b1ZyZZ
 hOjbSC/EbdxjuFsOJWT2B72ilrF3pYEh7OEqlVsPg8TPnbWkQTz9JyK3Uf5cevGiKVgF
 cD/KZENsDcS5LDOcrXED9Xq879z+uBtzMIGBB4TcmL3h+ZmNue7eHfOXNqeMuxQGKHwa
 k3/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkL5ocheBYSyPQtzIyc07auHp+U09oWQ3yzWD8ah7rAMrEbEzuWjMcE6QY0hnL3Tf4TAB7rGXUD0J9V9UIldZF5RiKe8k=
X-Gm-Message-State: AOJu0Yx+RYrXIjmYkYk3xuutKku5rTL6UqRSVCrCIqFHE0lLJprA+3iy
 kKjeqmeS+YDLdm1vzju5mV0Fu3gRqkm+/ItN+SbcDYH3Uas6j/R93mG0YappUas=
X-Google-Smtp-Source: AGHT+IH0JIipgWq0yW+9PYeUO31ba0z3MVahn53jKiSr5nBp9cymt7yNXDvEx0QpSWsbVzN8Az54Jw==
X-Received: by 2002:a05:6a21:3a4b:b0:1a0:5f9b:9ec7 with SMTP id
 zu11-20020a056a213a4b00b001a05f9b9ec7mr1226908pzb.13.1708724926104; 
 Fri, 23 Feb 2024 13:48:46 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d188-20020a6336c5000000b005dc89957e06sm12691396pga.71.2024.02.23.13.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 13:48:45 -0800 (PST)
Message-ID: <2704e5de-6c2b-42ca-8379-a1aae1fb0db3@linaro.org>
Date: Fri, 23 Feb 2024 11:48:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 19/21] hw/intc/arm_gicv3: Report the NMI interrupt
 in gicv3_cpuif_update()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-20-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-20-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> In CPU Interface, if the IRQ has the superpriority property, report
> NMI to the corresponding PE.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Remove handling nmi_is_irq flag.
> ---
>   hw/intc/arm_gicv3_cpuif.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index f5bf8df32b..3ffeb9543b 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -931,6 +931,7 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
>       /* Tell the CPU about its highest priority pending interrupt */
>       int irqlevel = 0;
>       int fiqlevel = 0;
> +    int nmilevel = 0;
>       ARMCPU *cpu = ARM_CPU(cs->cpu);
>       CPUARMState *env = &cpu->env;
>   
> @@ -967,7 +968,9 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
>               g_assert_not_reached();
>           }
>   
> -        if (isfiq) {
> +        if (cs->hppi.superprio) {
> +            nmilevel = 1;
> +        } else if (isfiq) {
>               fiqlevel = 1;
>           } else {
>               irqlevel = 1;

NMI only applies to group 1, per Table 4-6.  Because group 0 always produces fiq, I think 
you need to swap the ordering of the IFs.


r~

