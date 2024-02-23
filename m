Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992D9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 22:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdddz-0002qW-AJ; Fri, 23 Feb 2024 17:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdd1C-0003Kc-2H
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:23:42 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdd19-0004i0-Uq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 16:23:41 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso1172230a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708723417; x=1709328217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxyXl7urU3w5LyYVdJZCEAYTMHbHOgk3syipo1ACVGg=;
 b=sF+zUQlui+evHPyVM4RHnoSo2Uq1H/aP0vEDAmYeg+MFLTylKr1ZsTK3addF3M4SyO
 D60CcEFRC6qUtBqMdly+P3BPDI/CrPE08LXC0RdSeheLl4y4r04PM5Sr7nGNYpsk3IKd
 E0oU/899HAbA/UBwYB1wxNRPoYhBDtJeKODolEoci4kbBEyYTmg/QjrYCHp0mMUWZaaY
 +P6EhcyxxbL3gTEVN925RYJHH00mlOw79Iu22JduSapFzsuRa9RVUaDAOP2qt6wbGEE+
 VXpO5OwjEaZ1w1+3Aa5opHTSy+8m+yJ7Sjl16o4RM8R2TjNSoeynklEVApZF8ZJATfFE
 L/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708723417; x=1709328217;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxyXl7urU3w5LyYVdJZCEAYTMHbHOgk3syipo1ACVGg=;
 b=SN5UGrjuy8qV8Alw9wnHvBcGUqR7fmE+P/OOb4aD/m9Z2uvM2EH44GxfzJ/n/hroGg
 oMtI/3QDJoXVvZWbzFD8+LQgrbbTg1BU+2AXC00zJmcgKq/708D4QPBwQXtuJrNYgFFs
 AMfB4X5FoIfqQ6H+EockLkH2eCkF1tjIhpWD8HRg6nih+EiU9q7NRtM0sW+3CyeXdYbW
 iJU9akUizSBk8QvoJFtnWb6/cttWjLExuprKahzwnrJLAr9+vNOPeMgakffoHwz90Cvg
 2bCH2zFBXyABZyprCiH5XTW88DPq4CZU6tu30RSbpRzqBqjKigxn8ZqqVA9GF+O+DXLq
 LYuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9DVKAd9VWgHYipzABStdvYmvbI6TjjDuNmQliXdxFCzptr2UvITmGWTkp6lYawcATzktwiAB074oLUy0bROFuc/1UOEg=
X-Gm-Message-State: AOJu0Yw4xUqLZw2sAbTUjxM5LCpPaq5yKCG6e9yHUocM037LRJfSKjuF
 iiwdk1kTPwUR1aWCc4pX2ONCazd9HFmevX3vBrZvY4f/VrI1gwcDy/ISHXVv1bQ=
X-Google-Smtp-Source: AGHT+IFm+E31/Pt8xiZp+ECtmd8r8Kp6miQOEB8Lng2rTFrCXeLwMcrmzDtf0VLAGbS3oo5gwfgwwA==
X-Received: by 2002:a05:6a21:8796:b0:19a:4935:458 with SMTP id
 ph22-20020a056a21879600b0019a49350458mr1024514pzb.35.1708723417419; 
 Fri, 23 Feb 2024 13:23:37 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d188-20020a6336c5000000b005dc89957e06sm12674114pga.71.2024.02.23.13.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 13:23:36 -0800 (PST)
Message-ID: <603344eb-d67c-4aa6-8e4b-09b9f570759b@linaro.org>
Date: Fri, 23 Feb 2024 11:23:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 18/21] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-19-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-19-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
> If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI prioirty
> is higher than 0x80, otherwise it is higher than 0x0. And save NMI
> super prioirty information in hppi.superprio to deliver NMI exception.
> Since both GICR and GICD can deliver NMI, it is both necessary to check
> whether the pending irq is NMI in gicv3_redist_update_noirqset and
> gicv3_update_noirqset. And In irqbetter(), only a non-NMI with the same
> priority and a smaller interrupt number can be preempted but not NMI.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Add missing brace
> ---
>   hw/intc/arm_gicv3.c | 63 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 56 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index 0b8f79a122..75999edd19 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -21,7 +21,7 @@
>   #include "hw/intc/arm_gicv3.h"
>   #include "gicv3_internal.h"
>   
> -static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
> +static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool is_nmi)
>   {
>       /* Return true if this IRQ at this priority should take
>        * precedence over the current recorded highest priority
> @@ -33,11 +33,21 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
>       if (prio < cs->hppi.prio) {
>           return true;
>       }
> +
> +    /*
> +     * Current highest prioirity pending interrupt is not a NMI
> +     * and the new IRQ is a NMI with same priority.
> +     */
> +    if (prio == cs->hppi.prio && !cs->hppi.superprio && is_nmi) {

It would be best to not mix terminology -- superpriority or nmi but not a mix.  It's 
unfortunate that the manual does so...

It is very tempting expand prio to more bits so that all of the rest of this Just Works.
Because of...

> +            if (superprio) {
> +                is_nmi = 1;
> +
> +                /* DS = 0 & Non-secure NMI */
> +                if ((!(cs->gic->gicd_ctlr & GICD_CTLR_DS)) &&
> +                    extract32(cs->gicr_igroupr0, i, 1)) {
> +                    prio = 0x80;
> +                } else {
> +                    prio = 0x0;
> +                }
> +            } else {
> +               is_nmi = 0;
> +               prio = cs->gicr_ipriorityr[i];

... the need to check GICD_CTLR_DS for interpreting superpriority within the continuum, 
per section 4.8.1 (NMI prioritization), it would seem that we could map

     Secure NMI         -> 0
     Non-secure NMI     -> 0x100
     prio 0x00 .. 0xff  -> prio * 2 + 1

which matches the ordering in Figure 4-6.

> @@ -240,10 +271,28 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
>                */
>               continue;
>           }
> -        prio = s->gicd_ipriority[i];
> -        if (irqbetter(cs, i, prio)) {
> +
> +        superprio = *gic_bmp_ptr32(s->superprio, i);
> +        /* NMI */
> +        if (superprio & (1 << (i & 0x1f))) {
> +            is_nmi = 1;
> +
> +            /* DS = 0 & Non-secure NMI */
> +            if ((!(s->gicd_ctlr & GICD_CTLR_DS)) &&
> +                gicv3_gicd_group_test(s, i)) {
> +                    prio = 0x80;
> +            } else {
> +                    prio = 0x0;
> +            }
> +        } else {
> +            is_nmi = 0;
> +            prio = s->gicd_ipriority[i];
> +        }

In any case, let's not have two copies of this resolution.


r~

