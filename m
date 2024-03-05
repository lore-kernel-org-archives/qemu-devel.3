Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3121C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 22:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhdOq-0006IA-Be; Tue, 05 Mar 2024 17:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhdOo-0006Hs-Ow
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:36:38 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhdOm-0007fk-P4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:36:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so22554455ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709678195; x=1710282995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LVR9EKDH7j1wrn134WCqqi+cLYwpjmOW2kc7JdRsXd4=;
 b=ei4AVEIvM8rJiDJFUz4PraTTAX9GjPVnSmhNyF/BL8LcLAt8vxBT2MZEWznldng7GK
 dImG4akLMpvK1T8JUp+6mvZ7xBPF6Lnlrj0Q4qS+laEYs5P4bbrc7Fad85KXtEYxitz3
 9y6Qpnf3LdkMfQ2fScP3FZg67vkf40J6UwHLgX701Q+bxquF5iBYdpjRYTUBWB+DfbWq
 zu5IreXuAA3LGUoG6mC+nkDzLcuJ7MQkGKsSKkElURVasyajc6nh+PE71kl6esfj7trW
 P0cgqajf+SQqEDK7fHwNpUp8/9gNYHigL+sYfWWMFqtOXwNbReKIEGJId0PsIQ+MiX/H
 +Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709678195; x=1710282995;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LVR9EKDH7j1wrn134WCqqi+cLYwpjmOW2kc7JdRsXd4=;
 b=UQtLGdpMkL4gm+pqBo9/76o/sg5vsSrmIIuLfbgGBYnYbXO/28araLnOFpkEutjdLP
 1BbdttFcV3y6SXGxcr+98hvp28bhNsxS2bTQFPcvGljoTOZ+9n2lcD1jG38DKiVsPRGi
 aEk8ID+k9CJr/2snUbvSWa+dxh9LaECidUaDDcKostuRWiXuYYPErJUHApc1ZOR6ycNg
 EzQX5igqaOpR9wmxXbJQBBMdgHJXItBb1tM67CuL3kJS6pGpoxIrO9IxDys89yFM4u5j
 Vw4bHf9NV4jVTW7lMCf7ltOdQ50Icz3572En5byv3ox5n2YNC7qZV9R1FbQoJMIhP0BL
 TYcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyQYTmojTchrNULwfeU3RhAXN19uUC7rLE9vsuS/ozt92q4SMiUH/U/gHoGzK7rYkrmPimKaSBfRl6o8ExNK8+1+TgcHg=
X-Gm-Message-State: AOJu0YzC3OrAuDqMwZKFxf+6SNyUq6hm+w5fOoULf15xDsyjlWQ8RuZ5
 pdmYm4yVCsMJQmIS9cxssU+NcZ8pIZQxtLcSML49kzEy19PKof8awrY6Jnsyrx4=
X-Google-Smtp-Source: AGHT+IGL5mY4l009frFOsSycvaIm9vZ+qQVaXejDubltmCDLfBm05E96F7G5osTdF7GUCJPL70zN8Q==
X-Received: by 2002:a17:903:11d2:b0:1dc:f360:7537 with SMTP id
 q18-20020a17090311d200b001dcf3607537mr3596024plh.54.1709678193986; 
 Tue, 05 Mar 2024 14:36:33 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 k11-20020a170902c40b00b001dba98889a3sm11069647plk.71.2024.03.05.14.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 14:36:33 -0800 (PST)
Message-ID: <ae5ff031-a8d2-41ef-92e3-9026d51129da@linaro.org>
Date: Tue, 5 Mar 2024 12:36:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 19/23] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-20-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-20-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/4/24 21:03, Jinjie Ruan via wrote:
> -static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
> +static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio,
> +                      bool has_superprio)
>   {
>       /* Return true if this IRQ at this priority should take
>        * precedence over the current recorded highest priority
> @@ -33,11 +34,22 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
>       if (prio < cs->hppi.prio) {
>           return true;
>       }
> +
> +    /*
> +     * The same priority IRQ with superpriority should signal to the CPU
> +     * as it have the priority higher than the labelled 0x80 or 0x00.
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

This should be reordered for clarity:

     if (prio != cs->hppi.prio) {
         return prio < cs->hppi.prio;
     }

     if (has_superprio != cs->hppi.superprio) {
         return has_superprio;
     }

     return irq <= cs->hppa.irq;

So that we do not have to keep incorporating previous tests.



> @@ -129,6 +141,43 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
>       return pend;
>   }
>   
> +static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist,
> +                               uint8_t *prio, int irq)
> +{
> +    bool has_superprio = false;
> +    uint32_t superprio = 0x0;
> +
> +    if (is_redist) {
> +        superprio = extract32(cs->gicr_isuperprio, irq, 1);
> +    } else {
> +        superprio = *gic_bmp_ptr32(cs->gic->superprio, irq);
> +        superprio = superprio & (1 << (irq & 0x1f));
> +    }
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

has_superprio == superprio -- you can eliminate has_superprio,
or even leverage the code path:

     if (superprio) {
         ...
         return true;
     }

     if (is_redist)
     ...
     return false;

> @@ -168,9 +219,10 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
>       if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) && cs->gic->lpi_enable &&
>           (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
>           (cs->hpplpi.prio != 0xff)) {
> -        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
> +        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, false)) {

New argument should be hpplpi.superprio.

There are several places where we're setting irq and prio which might need to clear 
superprio, e.g. update_for_one_lpi.  But also anywhere else that deals with PendingIrq.

> +        cs->hppi.superprio = 0x0;

false, not 0x0.


r~

