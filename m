Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883CEC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcyB-000828-F6; Fri, 23 Feb 2024 16:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdcXY-0000CA-Ve
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:53:05 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdcXV-0007mW-F6
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:53:04 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso10847465ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708721580; x=1709326380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLiC4OnbOh3lK4zPHLdHplQPQ3q/yVVUpzIq3J07Sec=;
 b=uWzQSBL2ZfRRBqbTS2A2FbaMy74pxtcFzQ1+s7cWxzDN9QpJaKwQN3eLpIR/N8z3Bq
 nQk+CPIucKcUbzVSG6Xhb4zwWNvFTwT49st9+wFuve8ZJWX0q/2w4qh0mg4ZzlcGS2gy
 lm6DVlL70l6vNPSrTKSDZEWPpx/MR4eXy0gUfpHAbTTLwAXFDRjGIkppMVpJLEDTrLt2
 jXP+0srHKhcVfyYogBE/T6aJ8B++JSKwDZqgVD0668xRGnqYhwy3Lg7PoXs5gfxi1PUl
 JEtygWlTxHpYbosr84D7VJ9m3Wn1IKPqaTNkKGQ6S6yHf+h/IpmqIE/U43yDtp9YztdU
 xZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708721580; x=1709326380;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLiC4OnbOh3lK4zPHLdHplQPQ3q/yVVUpzIq3J07Sec=;
 b=U6WA7JJ+KxFarnLLPMl+mKILhuEUXvAqr8nC8W1A99Hm+fYQ6hLMujZhf0wAJijlgm
 gaOy5/hETzwC7UXSjTXEHsMuvANwqDhhheaa+pAZNdXECDEUBsl8jCGB2Z7N/4cMOPVX
 CRDOz1DnfqzelJ8nBqpLoF6wm0twKM3AfcVyRld7QDWngC/Tz0TH0NVCJ+k7i9CznQup
 85xXbFD4hFWD6swzooUaDazrEQgYKt6V7D9LfQLAdUrzb4xgC7wkNp/d6lg2INjRFLOo
 UVSH0OltKZgTWv0noR3ZHl2mRT8NjK5FOk0N3zrkCC1EbaeB6GWvoYqvntjeLKAThPeR
 ESsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw7OthsYmhtlJXxURxUm3pzL6wJNeIBFTV84a8SShuCwTzo3fOCL/O7ERNNYmFV6bjYbec4zCcKQg0ViGYd/vAJP5nvvo=
X-Gm-Message-State: AOJu0YxLLgZ7z4tM/74LI9n5e/umATkZdkc+OOudBbM1u1gqMFxW1Yqg
 bvd6TdY8ItqSvL1MXEEMxWCc9FXMnlQpx22ekCPCpXx8xTzCdxMuMPFmb59s2IQefzQ5u080ogq
 4
X-Google-Smtp-Source: AGHT+IEbGMxDvj/BueArQc/2hGDPy++2XKNi//qKk/rByJQb5kkBUzFM24/as/np0udaP+d8r4l6lA==
X-Received: by 2002:a17:902:e752:b0:1dc:2d63:9bf6 with SMTP id
 p18-20020a170902e75200b001dc2d639bf6mr1094466plf.4.1708721579757; 
 Fri, 23 Feb 2024 12:52:59 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k13-20020a170902f28d00b001dbcf653024sm11404614plc.293.2024.02.23.12.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:52:59 -0800 (PST)
Message-ID: <81167528-32e3-4741-84e4-3c70b788fc2c@linaro.org>
Date: Fri, 23 Feb 2024 10:52:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/21] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-18-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-18-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
> 
> When introduce NMI interrupt, there are some updates to the semantics for the
> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> should return 1022 if the intid has super priority. And for ICC_NMIAR1_EL1
> register, it should return 1023 if the intid do not have super priority.
> Howerever, these are not necessary for ICC_HPPIR1_EL1 register.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 46 ++++++++++++++++++++++++++++++++++++---
>   hw/intc/gicv3_internal.h  |  1 +
>   2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index e1a60d8c15..f5bf8df32b 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1097,7 +1097,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
>       return cs->hppi.irq;
>   }
>   
> -static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
> +static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env,
> +                                 bool is_nmi, bool is_hppi)
>   {
>       /* Return the highest priority pending interrupt register value
>        * for group 1.
> @@ -1108,6 +1109,16 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
>           return INTID_SPURIOUS;
>       }
>   
> +    if (!is_hppi) {
> +        if (is_nmi && (!cs->hppi.superprio)) {
> +            return INTID_SPURIOUS;
> +        }
> +
> +        if ((!is_nmi) && cs->hppi.superprio) {
> +            return INTID_NMI;
> +        }
> +    }
> +
>       /* Check whether we can return the interrupt or if we should return
>        * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
>        * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
> @@ -1168,7 +1179,30 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>       if (!icc_hppi_can_preempt(cs)) {
>           intid = INTID_SPURIOUS;
>       } else {
> -        intid = icc_hppir1_value(cs, env);
> +        intid = icc_hppir1_value(cs, env, false, false);
> +    }
> +
> +    if (!gicv3_intid_is_special(intid)) {
> +        icc_activate_irq(cs, intid);
> +    }
> +
> +    trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
> +    return intid;
> +}

This is incorrect.  For icc_iar1_read, you need something like

     if (!is_hppi
         && cs->hppi.superprio
         && env->cp15.sctlr_el[current_el] & SCTLR_NMI) {
         return INTID_NMI;
     }

I think that if SCTLR_NMI is not set, the whole system ignores Superpriority entirely, so 
returning SPURIOUS here would be incorrect.  This would make sense, letting an OS that is 
not configured for FEAT_NMI to run on ARMv8.8 hardware without modification.


> +
> +static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    GICv3CPUState *cs = icc_cs_from_env(env);
> +    uint64_t intid;
> +
> +    if (icv_access(env, HCR_IMO)) {
> +        return icv_iar_read(env, ri);
> +    }
> +
> +    if (!icc_hppi_can_preempt(cs)) {
> +        intid = INTID_SPURIOUS;
> +    } else {
> +        intid = icc_hppir1_value(cs, env, true, false);

Here... believe that the result *should* only consider superpriority.  I guess SPURIOUS is 
the correct result when there is no pending interrupt with superpriority?  It's really 
unclear to me from the register description.

Peter?

> @@ -2344,6 +2378,12 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>         .access = PL1_R, .accessfn = gicv3_irq_access,
>         .readfn = icc_iar1_read,
>       },
> +    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
> +      .type = ARM_CP_IO | ARM_CP_NO_RAW,
> +      .access = PL1_R, .accessfn = gicv3_irq_access,
> +      .readfn = icc_nmiar1_read,
> +    },

This register is UNDEFINED if FEAT_GICv3_NMI is not implemented.
You need to register this separately.


r~

