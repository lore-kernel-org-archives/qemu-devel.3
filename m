Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D7C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfqB6-0001ag-Oo; Thu, 29 Feb 2024 18:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfqB4-0001YZ-Nu
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:51:02 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfqB1-0007d5-PR
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:51:01 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so1075599a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709250656; x=1709855456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zmVxuFUEGQdDvRSRdxaqxOgShxxkewFXHQMBt5bgE9s=;
 b=BZnNrR1K7I61E47zn4FJ6VbcdQSHMWmDDGWQMnvz1GXrzlHCR5Bl2d09uGGEqpFHQB
 dkpq6ySAobdtEv4BepoZU1jXQzx4IkcSReDVkFBPNYUHsXulnfzcfj4/u5Wc+KOp1JwK
 vyjDDYNNIpWA8dvs6gs/YDkhDH8nq4zzHU0HM9E0WOLASN9A5xyGqhXBzeWXXHzPcgS/
 wx1kIdoxVjN5YEBuvQYZitlFsm8crVurUutSX6Ielsp+rvnI0YwgvzLlZL/heE/HfJYj
 uT/2jNUxxnEN1a7l6snkTi8B7RKH9IrBqE0WPxk/JU9SA7slgAsbFadtCnfkdzGrEGb7
 t4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709250656; x=1709855456;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmVxuFUEGQdDvRSRdxaqxOgShxxkewFXHQMBt5bgE9s=;
 b=m4beBpavBlGr7XyF7yq3iSbEP6s2ZlLEh6C+r4vtOa8Zeyw1tfbzkpjFkTQ9Yi16vb
 6Y5vD3WCo/YsmzTPDSBKchdfxNMQCZtJC+4qWwnJlBtSA/YNmFejJJenQYFu1YZtxmx8
 ANtJX6IMMi21MIc+QLqTI7xaD9T/7M3AJr04xANXXGBlAzsh+14SeirUW30fxGPA5TXq
 YScvCp8U4HAQNiGn58tiPfDGe4Ad+GApSrz/K4maR6khMWMuiFbZSqmSXBXun8VMvS9u
 0KeGxoWQradtw3vqTXeDKjyMw9VAvmahhRL34WFrOM/r3eFTHAZA7nla8kCd02bAwlCL
 XD1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi6mNEfWsKoudYhhMaPNmf8FNipvvAG7Ms8+8iycTDWEoKMh3CBo0vzBjT3Gfc7sS7iIJ+97NaH2GPTq6G7F/NVwnJiAY=
X-Gm-Message-State: AOJu0Ywokw0vZxkA8QveNeXjYtpbupkVMIUmthI0LAsdb4KpS399kvwB
 3H90NDk2ZMyrh5CO62KDf9sjPnO7fh3kMbRM+nE4SH5+t2rjokhudQtqo9JGj6E=
X-Google-Smtp-Source: AGHT+IFk0ZEg9tMYpsrlLkHU3P6MZf5gg2tUD5sXr1JUN0MUS+ypuHj+DPxIGbeURlKrmLxq69tqEA==
X-Received: by 2002:a05:6a21:3a86:b0:1a1:2a5b:a845 with SMTP id
 zv6-20020a056a213a8600b001a12a5ba845mr3286358pzb.41.1709250656452; 
 Thu, 29 Feb 2024 15:50:56 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170902d50a00b001db5241804csm2092730plg.20.2024.02.29.15.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:50:56 -0800 (PST)
Message-ID: <85d632e6-8eb9-4bb5-bef4-b6430d499e61@linaro.org>
Date: Thu, 29 Feb 2024 13:50:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 18/22] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-19-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-19-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
> v4:
> - Replace is_nmi with has_superprio to not a mix NMI and superpriority.
> - Update the comment in irqbetter().
> - Extract gicv3_get_priority() to avoid code repeat.
> ---
> v3:
> - Add missing brace
> ---
>   hw/intc/arm_gicv3.c | 71 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
> index 0b8f79a122..1d16a53b23 100644
> --- a/hw/intc/arm_gicv3.c
> +++ b/hw/intc/arm_gicv3.c
> @@ -21,7 +21,8 @@
>   #include "hw/intc/arm_gicv3.h"
>   #include "gicv3_internal.h"
>   
> -static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
> +static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio,
> +                      bool has_superprio)
>   {
>       /* Return true if this IRQ at this priority should take
>        * precedence over the current recorded highest priority
> @@ -33,11 +34,24 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
>       if (prio < cs->hppi.prio) {
>           return true;
>       }
> +
> +    /*
> +     * Current highest prioirity pending interrupt is an IRQ without
> +     * superpriority, the new IRQ with superpriority has same priority
> +     * should signal to the CPU as it have the priority higher than
> +     * the labelled 0x80 or 0x00.
> +     */
> +    if (prio == cs->hppi.prio && !cs->hppi.superprio && has_superprio) {
> +        return true;
> +    }
> +
>       /* If multiple pending interrupts have the same priority then it is an
>        * IMPDEF choice which of them to signal to the CPU. We choose to
> -     * signal the one with the lowest interrupt number.
> +     * signal the one with the lowest interrupt number if they don't have
> +     * superpriority.
>        */
> -    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
> +    if (prio == cs->hppi.prio && !cs->hppi.superprio &&
> +        !has_superprio && irq <= cs->hppi.irq) {
>           return true;
>       }
>       return false;
> @@ -129,6 +143,35 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
>       return pend;
>   }
>   
> +static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist,
> +                               uint32_t superprio, uint8_t *prio, int irq)
> +{
> +    bool has_superprio = false;
> +
> +    if (superprio) {
> +        has_superprio = true;
> +
> +        /* DS = 0 & Non-secure NMI */
> +        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
> +            ((is_redist && extract32(cs->gicr_igroupr0, irq, 1)) ||
> +             (!is_redist && gicv3_gicd_group_test(cs->gic, irq)))) {
> +            *prio = 0x80;
> +        } else {
> +            *prio = 0x0;
> +        }
> +    } else {
> +        has_superprio = false;
> +
> +        if (is_redist) {
> +            *prio = cs->gicr_ipriorityr[irq];
> +        } else {
> +            *prio = cs->gic->gicd_ipriority[irq];
> +        }
> +    }
> +
> +    return has_superprio;
> +}

Did you not like the idea to map {priority, !superpriority} into a single value?

It would eliminate the change in irqbetter(), which is a bit more complex than it needs to be.

> @@ -152,10 +197,13 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
>               if (!(pend & (1 << i))) {
>                   continue;
>               }
> -            prio = cs->gicr_ipriorityr[i];
> -            if (irqbetter(cs, i, prio)) {
> +            superprio = extract32(cs->gicr_isuperprio, i, 1);
> +            has_superprio = gicv3_get_priority(cs, true, superprio, &prio, i);

It would allow moving the read of gicr_isuperprio into gicv3_get_priority(), alongside the 
read of gicr_ipriorityr.

Is there a bug here not handling is_redist for GCIR_INMI*?

> @@ -168,7 +216,7 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
>       if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) && cs->gic->lpi_enable &&
>           (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
>           (cs->hpplpi.prio != 0xff)) {
> -        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
> +        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, false)) {

Always passing false here is incorrect -- again missing the redistributor nmi bit?


r~

