Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C62C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 22:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfp7J-0003ZV-CE; Thu, 29 Feb 2024 17:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfp7C-0003Yo-Mw
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 17:42:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfp7A-00023t-1p
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 17:42:58 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so12714195ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709246573; x=1709851373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ETVhg8Ne398brIPeThJ2esYVmViUwVa64/zKryTlTc=;
 b=XeWBAUd9dWA1TfKZEdK3QG4VFHteVOePRWh+lVbxpauKbrB/TFnoC4gpT15C3QBUGW
 SLpJ1vUfLNsEtO6vdQry9Fm4fkKXv3EVz7Y/Szk/PpIBMnbK95oNHTGfFdaIx9++Ovfe
 /g4FOSE4D4aDY+7NStr0n0p/AWgJSXuR6YwGBVpP72sUR1Ats7oRuU5Ze/bFago2Pl20
 sO+w7opvR0tvnYTlKZSuHsmKPLGGrAykDzJUAB34UWUY8kH18Z2uonfp9g7HqWfmYhIy
 94oI1KNcsl3Xl8bKdrFZRwE42JJiO7fjDPgaDFYOHfT1fZgV6BBH021BzK483Mvqx5v+
 FYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709246573; x=1709851373;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ETVhg8Ne398brIPeThJ2esYVmViUwVa64/zKryTlTc=;
 b=mpPVYZymfz9JZtaZcamD6veBOIwOuu4IKVSUGjXFwKDn4x9gxeQFvJ/7OhHdsRtwgM
 eyRePDrklfrSKOjfmsVV5mgDpc5bLjQvIyUgqwoFFcQCtF05v+2jTCvj7NWnBbq46V4G
 Re4x87pEqYOoHCYAL+L/FdM1andtPRYsKVA6lb7vc1lHqyw8lPTHPirZFUbjodYdGEGi
 /Fe1ZrykMo4gzvjIKuu+5VRXCJhzOP6nZE8R0CCL2A0yEv6VlCH1FVYovZCA8DcJNeDK
 6MwXiGw3frAEzokf/wgJmtkBdFiNw5r0y+KCDLhsaPrKhra7cZNv1hGt/5zVR6Aj5P0q
 e41A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3U5UrJGYRO4GQ4mBGMwIXorPWP6C+hzqsuGhXdGb8b/K60QuoPcbKxkcvSWggh2JaTUg9wPnUpYqmCGMOmbHWacOHBO0=
X-Gm-Message-State: AOJu0YwvlroXsd0KIgBinc5/l/KtKumxQsRO1uBZkqEZD7oF/ABJaBk2
 jFE05wONcGiqRhUcuIq7sdDF7//I8dKPjhK1kn6cC+J67u5SZAySZ2TN7EG3cs0=
X-Google-Smtp-Source: AGHT+IEhq79AH+rBdMbqgJc1+OVGN+z5s0CAud7JnamkMoAOo+m1do3KKbvDcFy2kJxwRV6ROBGufQ==
X-Received: by 2002:a17:903:1104:b0:1db:a55b:617e with SMTP id
 n4-20020a170903110400b001dba55b617emr4558721plh.39.1709246573516; 
 Thu, 29 Feb 2024 14:42:53 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 k23-20020a170902ba9700b001da105d6a83sm2016463pls.224.2024.02.29.14.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 14:42:53 -0800 (PST)
Message-ID: <fce60803-ac84-4b8c-af04-65c382ae1fec@linaro.org>
Date: Thu, 29 Feb 2024 12:42:49 -1000
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
> @@ -900,6 +945,31 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
>       }
>   }
>   
> +void arm_cpu_update_vnmi(ARMCPU *cpu)
> +{
> +    /*
> +     * Update the interrupt level for VNMI, which is the logical OR of
> +     * the HCRX_EL2.VINMI or HCRX_EL2.VFNMI bit and the input line level from
> +     * the GIC.
> +     */
> +    CPUARMState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    bool new_state = ((env->cp15.hcr_el2 & HCR_VI) &&
> +                      (env->cp15.hcrx_el2 & HCRX_VINMI)) ||
> +                     ((env->cp15.hcr_el2 & HCR_VF) &&
> +                      (env->cp15.hcrx_el2 & HCRX_VFNMI)) ||

Need to use arm_hcr_el2_eff and arm_hcrx_el2_eff.  I see this is an existing error from 
the other functions too.

> +        (env->irq_line_state & CPU_INTERRUPT_VNMI);
> +
> +    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VNMI) != 0)) {
> +        if (new_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_VNMI);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VNMI);
> +        }
> +    }
> +}

This is incomplete, as you need additional changes within the other two functions to not 
raise IRQ when VINMI is set, etc.


r~

