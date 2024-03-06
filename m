Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595FDC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhh5V-0002ym-2M; Tue, 05 Mar 2024 21:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhh5S-0002y8-5D; Tue, 05 Mar 2024 21:32:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhh5O-0004yY-C4; Tue, 05 Mar 2024 21:32:53 -0500
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TqGcQ6Sxxz1h1FT;
 Wed,  6 Mar 2024 10:30:14 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 866521A0172;
 Wed,  6 Mar 2024 10:32:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 10:32:34 +0800
Message-ID: <f4db0f14-a290-fddf-00b5-71bb3d247294@huawei.com>
Date: Wed, 6 Mar 2024 10:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v6 19/23] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-20-ruanjinjie@huawei.com>
 <ae5ff031-a8d2-41ef-92e3-9026d51129da@linaro.org>
In-Reply-To: <ae5ff031-a8d2-41ef-92e3-9026d51129da@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.98,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/3/6 6:36, Richard Henderson wrote:
> On 3/4/24 21:03, Jinjie Ruan via wrote:
>> -static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
>> +static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio,
>> +                      bool has_superprio)
>>   {
>>       /* Return true if this IRQ at this priority should take
>>        * precedence over the current recorded highest priority
>> @@ -33,11 +34,22 @@ static bool irqbetter(GICv3CPUState *cs, int irq,
>> uint8_t prio)
>>       if (prio < cs->hppi.prio) {
>>           return true;
>>       }
>> +
>> +    /*
>> +     * The same priority IRQ with superpriority should signal to the CPU
>> +     * as it have the priority higher than the labelled 0x80 or 0x00.
>> +     */
>> +    if (prio == cs->hppi.prio && !cs->hppi.superprio && has_superprio) {
>> +        return true;
>> +    }
>> +
>>       /* If multiple pending interrupts have the same priority then it
>> is an
>>        * IMPDEF choice which of them to signal to the CPU. We choose to
>> -     * signal the one with the lowest interrupt number.
>> +     * signal the one with the lowest interrupt number if they don't
>> have
>> +     * superpriority.
>>        */
>> -    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
>> +    if (prio == cs->hppi.prio && !cs->hppi.superprio &&
>> +        !has_superprio && irq <= cs->hppi.irq) {
>>           return true;
>>       }
>>       return false;
> 
> This should be reordered for clarity:
> 
>     if (prio != cs->hppi.prio) {
>         return prio < cs->hppi.prio;
>     }
> 
>     if (has_superprio != cs->hppi.superprio) {
>         return has_superprio;
>     }
> 
>     return irq <= cs->hppa.irq;
> 
> So that we do not have to keep incorporating previous tests.

This looks much cleaner.

> 
> 
> 
>> @@ -129,6 +141,43 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
>>       return pend;
>>   }
>>   +static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist,
>> +                               uint8_t *prio, int irq)
>> +{
>> +    bool has_superprio = false;
>> +    uint32_t superprio = 0x0;
>> +
>> +    if (is_redist) {
>> +        superprio = extract32(cs->gicr_isuperprio, irq, 1);
>> +    } else {
>> +        superprio = *gic_bmp_ptr32(cs->gic->superprio, irq);
>> +        superprio = superprio & (1 << (irq & 0x1f));
>> +    }
>> +
>> +    if (superprio) {
>> +        has_superprio = true;
>> +
>> +        /* DS = 0 & Non-secure NMI */
>> +        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
>> +            ((is_redist && extract32(cs->gicr_igroupr0, irq, 1)) ||
>> +             (!is_redist && gicv3_gicd_group_test(cs->gic, irq)))) {
>> +            *prio = 0x80;
>> +        } else {
>> +            *prio = 0x0;
>> +        }
>> +    } else {
>> +        has_superprio = false;
>> +
>> +        if (is_redist) {
>> +            *prio = cs->gicr_ipriorityr[irq];
>> +        } else {
>> +            *prio = cs->gic->gicd_ipriority[irq];
>> +        }
>> +    }
>> +
>> +    return has_superprio;
>> +}
> 
> has_superprio == superprio -- you can eliminate has_superprio,
> or even leverage the code path:
> 
>     if (superprio) {
>         ...
>         return true;
>     }
> 
>     if (is_redist)
>     ...
>     return false;
> 
>> @@ -168,9 +219,10 @@ static void
>> gicv3_redist_update_noirqset(GICv3CPUState *cs)
>>       if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) &&
>> cs->gic->lpi_enable &&
>>           (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
>>           (cs->hpplpi.prio != 0xff)) {
>> -        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
>> +        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, false)) {
> 
> New argument should be hpplpi.superprio.
> 
> There are several places where we're setting irq and prio which might
> need to clear superprio, e.g. update_for_one_lpi.  But also anywhere
> else that deals with PendingIrq.
> 
>> +        cs->hppi.superprio = 0x0;
> 
> false, not 0x0.
> 
> 
> r~

