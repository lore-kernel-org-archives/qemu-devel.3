Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C17C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reZ4R-0004hB-DS; Mon, 26 Feb 2024 06:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1reZ4P-0004g7-01; Mon, 26 Feb 2024 06:22:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1reZ4M-0001h6-3r; Mon, 26 Feb 2024 06:22:52 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TjypN5Xffz1h0dB;
 Mon, 26 Feb 2024 19:20:28 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id D39BC1402CE;
 Mon, 26 Feb 2024 19:22:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:22:41 +0800
Message-ID: <caa15abf-4b9b-8d72-afb4-be18223ad56a@huawei.com>
Date: Mon, 26 Feb 2024 19:22:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v3 17/21] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-18-ruanjinjie@huawei.com>
 <81167528-32e3-4741-84e4-3c70b788fc2c@linaro.org>
In-Reply-To: <81167528-32e3-4741-84e4-3c70b788fc2c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.331,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 2024/2/24 4:52, Richard Henderson wrote:
> On 2/23/24 00:32, Jinjie Ruan via wrote:
>> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>>
>> When introduce NMI interrupt, there are some updates to the semantics
>> for the
>> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
>> should return 1022 if the intid has super priority. And for
>> ICC_NMIAR1_EL1
>> register, it should return 1023 if the intid do not have super priority.
>> Howerever, these are not necessary for ICC_HPPIR1_EL1 register.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   hw/intc/arm_gicv3_cpuif.c | 46 ++++++++++++++++++++++++++++++++++++---
>>   hw/intc/gicv3_internal.h  |  1 +
>>   2 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index e1a60d8c15..f5bf8df32b 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -1097,7 +1097,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState
>> *cs, CPUARMState *env)
>>       return cs->hppi.irq;
>>   }
>>   -static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
>> +static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env,
>> +                                 bool is_nmi, bool is_hppi)
>>   {
>>       /* Return the highest priority pending interrupt register value
>>        * for group 1.
>> @@ -1108,6 +1109,16 @@ static uint64_t icc_hppir1_value(GICv3CPUState
>> *cs, CPUARMState *env)
>>           return INTID_SPURIOUS;
>>       }
>>   +    if (!is_hppi) {
>> +        if (is_nmi && (!cs->hppi.superprio)) {
>> +            return INTID_SPURIOUS;
>> +        }
>> +
>> +        if ((!is_nmi) && cs->hppi.superprio) {
>> +            return INTID_NMI;
>> +        }
>> +    }
>> +
>>       /* Check whether we can return the interrupt or if we should return
>>        * a special identifier, as per the
>> CheckGroup1ForSpecialIdentifiers
>>        * pseudocode. (We can simplify a little because for us
>> ICC_SRE_EL1.RM
>> @@ -1168,7 +1179,30 @@ static uint64_t icc_iar1_read(CPUARMState *env,
>> const ARMCPRegInfo *ri)
>>       if (!icc_hppi_can_preempt(cs)) {
>>           intid = INTID_SPURIOUS;
>>       } else {
>> -        intid = icc_hppir1_value(cs, env);
>> +        intid = icc_hppir1_value(cs, env, false, false);
>> +    }
>> +
>> +    if (!gicv3_intid_is_special(intid)) {
>> +        icc_activate_irq(cs, intid);
>> +    }
>> +
>> +    trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
>> +    return intid;
>> +}
> 
> This is incorrect.  For icc_iar1_read, you need something like
> 
>     if (!is_hppi
>         && cs->hppi.superprio
>         && env->cp15.sctlr_el[current_el] & SCTLR_NMI) {
>         return INTID_NMI;
>     }
> 
> I think that if SCTLR_NMI is not set, the whole system ignores
> Superpriority entirely, so returning SPURIOUS here would be incorrect. 
> This would make sense, letting an OS that is not configured for FEAT_NMI
> to run on ARMv8.8 hardware without modification.

You are right. SCTLR_ELx.NMI decide whether IRQ and FIQ interrupts to
have Superpriority as an additional attribute.

> 
> 
>> +
>> +static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo
>> *ri)
>> +{
>> +    GICv3CPUState *cs = icc_cs_from_env(env);
>> +    uint64_t intid;
>> +
>> +    if (icv_access(env, HCR_IMO)) {
>> +        return icv_iar_read(env, ri);
>> +    }
>> +
>> +    if (!icc_hppi_can_preempt(cs)) {
>> +        intid = INTID_SPURIOUS;
>> +    } else {
>> +        intid = icc_hppir1_value(cs, env, true, false);
> 
> Here... believe that the result *should* only consider superpriority.  I
> guess SPURIOUS is the correct result when there is no pending interrupt
> with superpriority?  It's really unclear to me from the register
> description.
> 
> Peter?
> 
>> @@ -2344,6 +2378,12 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[]
>> = {
>>         .access = PL1_R, .accessfn = gicv3_irq_access,
>>         .readfn = icc_iar1_read,
>>       },
>> +    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
>> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
>> +      .type = ARM_CP_IO | ARM_CP_NO_RAW,
>> +      .access = PL1_R, .accessfn = gicv3_irq_access,
>> +      .readfn = icc_nmiar1_read,
>> +    },
> 
> This register is UNDEFINED if FEAT_GICv3_NMI is not implemented.
> You need to register this separately.
> 
> 
> r~

