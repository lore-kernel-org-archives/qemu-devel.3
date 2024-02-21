Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC31C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcsrQ-0006OU-Qu; Wed, 21 Feb 2024 15:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsrP-0006OK-Td
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:06:31 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcsrN-0004q4-U5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:06:31 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7bf7e37dc60so388465439f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708545987; x=1709150787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nGTOERJajhvkvcCpTrMLtKW49YgUT4pv8GWLdEl9PbQ=;
 b=wPivL64iXza6VvMUwSMrODIcEFwU1EbUh9uPaBOOIod9eF7s/ODaTvZoHrp6+x/39O
 dO6SV/XwwwQ2WjCcHlZ2W4/ss4GTdVGeK+M1hID1TyoepdPsevn8NxHYiOlVYrrITWfS
 Sf9TYuKR/YKvZYADbTtlocrqJlh6eDcWHPXi4BLqAdF7CCrGXTO5gsc8vm4ICQEqO6OF
 8bJcwMmoRhnw7netsJtCr9EMgxXyBLvajxP/eoRkFERqAxL8QvCStbvLcDEBHRspVGJ4
 MaEsmQ1SNTwxb3IoTNGmyCmznsX5y8F2D8KALNH8PJhFVkbVN1amAixEMwt3tcOY2ziI
 q7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708545987; x=1709150787;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGTOERJajhvkvcCpTrMLtKW49YgUT4pv8GWLdEl9PbQ=;
 b=ogSRc1GxWBjZije1TRXjd+Wap/4zcvsyEQbKJW/aw2dHZQdfuE7fBpDPBLmPXY24+R
 5IljDvd6WjqA5WLGBD+qyShJthQ0rMGX1rseOrydl5LNYhCwxFoH8Sup0mSRjk7cvBlL
 sY6O806I3YkMKbLcRE3UNOBC533OEmH994tcmSszLtXQzwZzZV1i9lHcW+vlZI/mLWo7
 sbM4F+wQZvqTG7GIxxrjhBLJpgXNYh2Pj0bQYzrxPr5HMZE2HOI5YRkh/ou3GZ1KY4mR
 kADjraktuNApVrhlMW8fyIrOUxLBnWvDG+AdEnrc4SwQhVOBDLfI/AuFCKc8SmnpeV+t
 fpNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT5Fh/GIfmsT/zx1VTi31gxZOeYJw/PXnJ3By8ecv0oeIvZYLl2IDXDZyGikME/mxyLbCZS6TT/M2C1DnmHCET6moBWjs=
X-Gm-Message-State: AOJu0YxjVkV+W5Nrq4lEiaG+EoDHOVfh0shaje5rUWXFbMrmx1/XmENx
 KqPbnQn4cHXfTRSrba2ROf3a9AAdJhJHwdfHVcD0LsvTPr4IFL5Nww7U8X1r29Q=
X-Google-Smtp-Source: AGHT+IGh3TSCd/OpUukGJOO8T/cpOrUdNjv2OjPjt10fkDmG5/nAoDOeCbholTFrbupKWTnKZ5yxTQ==
X-Received: by 2002:a92:d305:0:b0:364:1e0e:7648 with SMTP id
 x5-20020a92d305000000b003641e0e7648mr18912985ila.7.1708545987548; 
 Wed, 21 Feb 2024 12:06:27 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a24-20020a637f18000000b005dc27ff85c1sm9092059pgd.0.2024.02.21.12.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:06:27 -0800 (PST)
Message-ID: <94867836-95f4-4da2-96e9-583e508a762d@linaro.org>
Date: Wed, 21 Feb 2024 10:06:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/22] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-7-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2d.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> This only implements the external delivery method via the GICv3.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/cpu-qom.h |  3 ++-
>   target/arm/cpu.c     | 39 ++++++++++++++++++++++++++++++++++-----
>   target/arm/cpu.h     |  2 ++
>   target/arm/helper.c  |  1 +
>   4 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 8e032691db..66d555a605 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -36,11 +36,12 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>   #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>   #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>   
> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
> +/* Meanings of the ARMCPU object's five inbound GPIO lines */
>   #define ARM_CPU_IRQ 0
>   #define ARM_CPU_FIQ 1
>   #define ARM_CPU_VIRQ 2
>   #define ARM_CPU_VFIQ 3
> +#define ARM_CPU_NMI 4
>   
>   /* For M profile, some registers are banked secure vs non-secure;
>    * these are represented as a 2-element array where the first element
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5e5978c302..055670343e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -128,7 +128,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>   
>       return (cpu->power_state != PSCI_OFF)
>           && cs->interrupt_request &
> -        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
> +        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI
>            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
>            | CPU_INTERRUPT_EXITTB);
>   }

I think you should not include CPU_INTERRUPT_NMI when it cannot be delivered, e.g. 
FEAT_NMI not enabled.


> @@ -668,6 +668,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>       CPUARMState *env = cpu_env(cs);
>       bool pstate_unmasked;
>       bool unmasked = false;
> +    bool nmi_unmasked = false;
>   
>       /*
>        * Don't take exceptions if they target a lower EL.
> @@ -678,13 +679,29 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>           return false;
>       }
>   
> +    nmi_unmasked = (!(env->allint & PSTATE_ALLINT)) &
> +                   (!((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
> +                   (env->pstate & PSTATE_SP) && cur_el == target_el));

I don't see SCTLR_ELx.NMI being tested anywhere, which is required to enable everything else.

>       case EXCP_FIQ:
> -        pstate_unmasked = !(env->daif & PSTATE_F);
> +        if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> +            pstate_unmasked = (!(env->daif & PSTATE_F)) & nmi_unmasked;
> +        } else {
> +            pstate_unmasked = !(env->daif & PSTATE_F);
> +        }
>           break;
>   
>       case EXCP_IRQ:
> -        pstate_unmasked = !(env->daif & PSTATE_I);
> +        if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> +            pstate_unmasked = (!(env->daif & PSTATE_I)) & nmi_unmasked;
> +        } else {
> +            pstate_unmasked = !(env->daif & PSTATE_I);
> +        }
>           break;

I don't see what this is doing.  While Superpriority is IMPLEMENTATION DEFINED, how are 
you defining it for QEMU?  Is there a definition from real hw which makes sense under 
emulation?


r~

