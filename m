Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3BDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 02:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqOhi-00058s-MV; Fri, 29 Mar 2024 22:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqOhf-000584-Gh; Fri, 29 Mar 2024 22:44:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqOhb-0000cr-OJ; Fri, 29 Mar 2024 22:44:19 -0400
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V61kz6ZWTz1xtRn;
 Sat, 30 Mar 2024 10:42:03 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 4064818005F;
 Sat, 30 Mar 2024 10:44:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 10:44:06 +0800
Message-ID: <8263a597-298d-158e-524a-21ac906363b4@huawei.com>
Date: Sat, 30 Mar 2024 10:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-18-ruanjinjie@huawei.com>
 <CAFEAcA_p6i5KNcQW3NLZY=kwUXuUPXM+8ncC8T-gPNVUWJ6CHA@mail.gmail.com>
In-Reply-To: <CAFEAcA_p6i5KNcQW3NLZY=kwUXuUPXM+8ncC8T-gPNVUWJ6CHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.913,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2024/3/28 22:50, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 08:53, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>>
>> When introduce NMI interrupt, there are some updates to the semantics for the
>> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
>> should return 1022 if the intid has non-maskable property. And for
>> ICC_NMIAR1_EL1 register, it should return 1023 if the intid do not have
>> non-maskable property. Howerever, these are not necessary for ICC_HPPIR1_EL1
>> register.
>>
>> And the APR and RPR has NMI bits which should be handled correctly.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v10:
>> - is_nmi -> nmi.
>> - is_hppi -> hppi.
>> - Exchange the order of nmi and hppi parameters.
>> - superprio -> nmi.
>> - Handle APR and RPR NMI bits.
>> - Update the commit message, super priority -> non-maskable property.
>> v7:
>> - Add Reviewed-by.
>> v4:
>> - Define ICC_NMIAR1_EL1 only if FEAT_GICv3_NMI is implemented.
>> - Check sctrl_elx.SCTLR_NMI to return 1022 for icc_iar1_read().
>> - Add gicv3_icc_nmiar1_read() trace event.
>> - Do not check icc_hppi_can_preempt() for icc_nmiar1_read().
>> - Add icv_nmiar1_read() and call it when EL2Enabled() and HCR_EL2.IMO == '1'
>> ---
>>  hw/intc/arm_gicv3_cpuif.c | 115 ++++++++++++++++++++++++++++++++++----
>>  hw/intc/gicv3_internal.h  |   5 ++
>>  hw/intc/trace-events      |   1 +
>>  3 files changed, 110 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index e1a60d8c15..76e2286e70 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -795,6 +795,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>      return intid;
>>  }
>>
>> +static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>> +{
>> +    /* todo */
>> +    uint64_t intid = INTID_SPURIOUS;
>> +    return intid;
>> +}
>> +
>>  static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
>>  {
>>      /*
>> @@ -825,11 +832,15 @@ static inline int icc_num_aprs(GICv3CPUState *cs)
>>      return aprmax;
>>  }
>>
>> -static int icc_highest_active_prio(GICv3CPUState *cs)
>> +static uint64_t icc_highest_active_prio(GICv3CPUState *cs)
>>  {
>>      /* Calculate the current running priority based on the set bits
>>       * in the Active Priority Registers.
>>       */
>> +    ARMCPU *cpu = ARM_CPU(cs->cpu);
>> +    CPUARMState *env = &cpu->env;
>> +
>> +    uint64_t prio;
>>      int i;
>>
>>      for (i = 0; i < icc_num_aprs(cs); i++) {
>> @@ -839,7 +850,32 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
>>          if (!apr) {
>>              continue;
>>          }
>> -        return (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
>> +        prio = (i * 32 + ctz32(apr)) << (icc_min_bpr(cs) + 1);
>> +
>> +        if (cs->gic->nmi_support) {
>> +            if (cs->gic->gicd_ctlr & GICD_CTLR_DS) {
>> +                if ((cs->icc_apr[GICV3_G0][i] & ICC_AP1R_EL1_NMI) ||
>> +                    (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) ||
>> +                    (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI)) {
>> +                    prio |= ICC_RPR_EL1_NMI;
>> +                }
>> +            } else if (!arm_is_secure(env)) {
>> +                if (cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
>> +                    prio |= ICC_RPR_EL1_NMI;
>> +                }
>> +            } else {
>> +                if (cs->icc_apr[GICV3_G1][i] & ICC_AP1R_EL1_NMI) {
>> +                    prio |= ICC_RPR_EL1_NMI;
>> +                }
>> +            }
>> +
>> +            if (arm_feature(env, ARM_FEATURE_EL3) &&
>> +                cs->icc_apr[GICV3_G1NS][i] & ICC_AP1R_EL1_NMI) {
>> +                prio |= ICC_RPR_EL1_NSNMI;
>> +            }
>> +        }
>> +
>> +        return prio;
> 
> This function is used both for getting the ICC_RPR value,
> and also in icc_hppi_can_preempt(). So we can't put the
> special RPR NMI bits in here. Also doing that will not work well
> with the way the code in icc_rpr_read() adjusts the priority
> for non-secure accesses. I think we should follow the structure
> of the pseudocode here, and do the setting of the RPR bits 62 and 63
> in icc_rpr_read(). (In the pseudocode this is ICC_RPR_EL1 calling
> GetHighestActivePriority() and then doing the NMI bits locally.)
> 
> The NMI bit also exists only in the AP1R0 bit, not in every AP
> register. So you can check it before the for() loop, something like this:
> 
>     if (cs->gic->nmi_support) {
>         /*
>          * If an NMI is active this takes precedence over anything else
>          * for priority purposes; the NMI bit is only in the AP1R0 bit.
>          * We return here the effective priority of the NMI, which is
>          * either 0x0 or 0x80. Callers will need to check NMI again for
>          * purposes of either setting the RPR register bits or for
>          * prioritization of NMI vs non-NMI.
>          */
>         prio = 0;
>         if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
>             return 0;
>         }
>         if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
>             return (cs->gic->gicd_ctlr & GICD_CTLR_DS) ? 0 : 0x80;
>         }
>     }
> 
> Then in icc_rpr_read() we can pretty much directly write the same
> logic that the pseudocode uses to determine whether to set the RPR
> NMI bits, after the point where we do the shifting of the prio for
> the NS view:
> 
>     if (cs->gic->nmi_support) {
>         /* NMI info is reported in the high bits of RPR */
>         if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
>             if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
>                 prio |= ICC_RPR_EL1_NMI;

It seems ICC_RPR_EL1_NSNMI in pseudocode:

// GICv3.3
if HaveNMIExt() then
    if HaveEL(EL3) && (IsNonSecure() || IsRealm()) then
        pPriority<63> = ICC_AP1R_EL1NS<63>;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
else
    pPriority<63> = ICC_AP1R_EL1S<63>;
    pPriority<62> = ICC_AP1R_EL1NS<63>;

>             }
>         } else {
>             if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
>                 prio |= ICC_RPR_EL1_NSNMI;
>             }
>             if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
>                 prio |= ICC_RPR_EL1_NMI;
>             }
>         }
>     }
> 
>>      }
>>      /* No current active interrupts: return idle priority */
>>      return 0xff;
>> @@ -896,7 +932,7 @@ static bool icc_hppi_can_preempt(GICv3CPUState *cs)
>>      /* Return true if we have a pending interrupt of sufficient
>>       * priority to preempt.
>>       */
>> -    int rprio;
>> +    uint64_t rprio;
> 
> You won't need to change the type of this variable with the change above.
> 
>>      uint32_t mask;
>>
>>      if (icc_no_enabled_hppi(cs)) {
> 
> icc_hppi_can_preempt() needs more changes than this (check the
> pseudocode in CanSignalInterrupt(), and the text in 4.8, particularly
> 4.8.6):
> 
>  * the (cs->hppi.prio >= cs->icc_pmr_el1) check only applies
>    if !cs->hppi.nmi
>  * if this is an NMI and GICD_CTLR.DS is 0 and it's a G1NS
>    interrupt, then we mask if the PMR is < 0x80, or if
>    we're in Secure state and the PMR == 0x80
>  * if this is an NMI and the (masked) hppi.prio is equal to the
>    (masked) running priority, then we preempt if there's not
>    already an active NMI, ie if the APR NMI bit is clear
> 
>> @@ -1034,7 +1070,7 @@ static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>      gicv3_cpuif_update(cs);
>>  }
>>
>> -static void icc_activate_irq(GICv3CPUState *cs, int irq)
>> +static void icc_activate_irq(GICv3CPUState *cs, int irq, bool nmi)
>>  {
> 
> When activating an interrupt, we set the NMI bit in the
> priority register based only on the interrupt's config,
> not on what register was used to activate it. So we don't
> want a 'bool nmi' argument, we want a local:
>    bool nmi = cs->hppi.nmi;
> 
> (Compare the pseudocode in the spec: ICC_IAR0_EL1, ICC_IAR1_EL1,
> and ICC_NMIAR1_EL1 all call AcknowledgeInterrupt(pendID)
> to activate it.)
> 
>>      /* Move the interrupt from the Pending state to Active, and update
>>       * the Active Priority Registers
>> @@ -1047,6 +1083,10 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
>>
>>      cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
>>
>> +    if (cs->gic->nmi_support) {
>> +        cs->icc_apr[cs->hppi.grp][regno] |= (nmi ? ICC_AP1R_EL1_NMI : 0);
>> +    }
> 
> In the APRs, we set only the NMI bit for an NMI and the ordinary priority
> bit for a non-NMI; so this should be
> 
>      if (cs->gic->nmi_support && nmi) {
>          cs->icc_apr[cs->hppi.grp][regno] |= ICC_AP1R_EL1_NMI;
>      } else {
>          cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
>      }
> 
> (Otherwise if we had a non-NMI that was interrupted by an NMI
> at the same priority we wouldn't be able to distinguish this
> from the NMI interrupting when nothing else was active.)
> 
>> +
>>      if (irq < GIC_INTERNAL) {
>>          cs->gicr_iactiver0 = deposit32(cs->gicr_iactiver0, irq, 1, 1);
>>          cs->gicr_ipendr0 = deposit32(cs->gicr_ipendr0, irq, 1, 0);
>> @@ -1097,7 +1137,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
>>      return cs->hppi.irq;
>>  }
>>
>> -static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
>> +static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env, bool hppi,
>> +                                 bool nmi)
>>  {
>>      /* Return the highest priority pending interrupt register value
>>       * for group 1.
>> @@ -1108,6 +1149,18 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
>>          return INTID_SPURIOUS;
>>      }
>>
>> +    if (!hppi) {
>> +        int el = arm_current_el(env);
>> +
>> +        if (nmi && (!cs->hppi.nmi)) {
>> +            return INTID_SPURIOUS;
>> +        }
>> +
>> +        if (!nmi && cs->hppi.nmi && env->cp15.sctlr_el[el] & SCTLR_NMI) {
>> +            return INTID_NMI;
>> +        }
>> +    }
>> +
> 
> Rather than passing two extra boolean arguments into this
> function, I think it's better to follow the pseudocode's
> structure, and have the "should we instead return a
> special INTID_*" checks be done in the callers of this function.
> They all end up different so they don't really share code
> by pushing the checks into this function.
> 
>>      /* Check whether we can return the interrupt or if we should return
>>       * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
>>       * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
>> @@ -1149,7 +1202,7 @@ static uint64_t icc_iar0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>      }
>>
>>      if (!gicv3_intid_is_special(intid)) {
>> -        icc_activate_irq(cs, intid);
>> +        icc_activate_irq(cs, intid, false);
>>      }
>>
>>      trace_gicv3_icc_iar0_read(gicv3_redist_affid(cs), intid);
>> @@ -1168,17 +1221,36 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>      if (!icc_hppi_can_preempt(cs)) {
>>          intid = INTID_SPURIOUS;
>>      } else {
>> -        intid = icc_hppir1_value(cs, env);
>> +        intid = icc_hppir1_value(cs, env, false, false);
>>      }
>>
>>      if (!gicv3_intid_is_special(intid)) {
>> -        icc_activate_irq(cs, intid);
>> +        icc_activate_irq(cs, intid, false);
>>      }
>>
>>      trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
>>      return intid;
>>  }
>>
>> +static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>> +{
>> +    GICv3CPUState *cs = icc_cs_from_env(env);
>> +    uint64_t intid;
>> +
>> +    if (icv_access(env, HCR_IMO)) {
>> +        return icv_nmiar1_read(env, ri);
>> +    }
>> +
>> +    intid = icc_hppir1_value(cs, env, false, true);
>> +
>> +    if (!gicv3_intid_is_special(intid)) {
>> +        icc_activate_irq(cs, intid, true);
>> +    }
>> +
>> +    trace_gicv3_icc_nmiar1_read(gicv3_redist_affid(cs), intid);
>> +    return intid;
>> +}
>> +
>>  static void icc_drop_prio(GICv3CPUState *cs, int grp)
>>  {
>>      /* Drop the priority of the currently active interrupt in
>> @@ -1207,6 +1279,10 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
>>          }
>>          /* Clear the lowest set bit */
>>          *papr &= *papr - 1;
>> +
>> +        if (cs->gic->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
>> +            *papr &= (~ICC_AP1R_EL1_NMI);
>> +        }
> 
> The NMI bit is only in the AP1R0 register, and if it is set then
> we should clear only it and not any other AP bits. At the moment
> this code clears the lowest set bit and also the NMI bit.
> 
>>          break;
>>      }
>>
>> @@ -1555,7 +1631,7 @@ static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>          return icv_hppir_read(env, ri);
>>      }
>>
>> -    value = icc_hppir1_value(cs, env);
>> +    value = icc_hppir1_value(cs, env, true, false);
>>      trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
>>      return value;
>>  }
>> @@ -1693,7 +1769,11 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>          return;
>>      }
>>
>> -    cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
>> +    if (cs->gic->nmi_support) {
>> +        cs->icc_apr[grp][regno] = value & (0xFFFFFFFFU | ICC_AP1R_EL1_NMI);
>> +    } else {
>> +        cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
>> +    }
>>      gicv3_cpuif_update(cs);
>>  }
>>
>> @@ -1783,7 +1863,7 @@ static void icc_dir_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>  static uint64_t icc_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>  {
>>      GICv3CPUState *cs = icc_cs_from_env(env);
>> -    int prio;
>> +    uint64_t prio;
>>
>>      if (icv_access(env, HCR_FMO | HCR_IMO)) {
>>          return icv_rpr_read(env, ri);
>> @@ -2482,6 +2562,15 @@ static const ARMCPRegInfo gicv3_cpuif_icc_apxr23_reginfo[] = {
>>      },
>>  };
>>
>> +static const ARMCPRegInfo gicv3_cpuif_gicv3_nmi_reginfo[] = {
>> +    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
>> +      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
>> +      .type = ARM_CP_IO | ARM_CP_NO_RAW,
>> +      .access = PL1_R, .accessfn = gicv3_irq_access,
>> +      .readfn = icc_nmiar1_read,
>> +    },
>> +};
>> +
>>  static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>  {
>>      GICv3CPUState *cs = icc_cs_from_env(env);
>> @@ -2838,6 +2927,10 @@ void gicv3_init_cpuif(GICv3State *s)
>>           */
>>          define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>>
>> +        if (s->nmi_support) {
>> +            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
>> +        }
>> +
>>          /*
>>           * The CPU implementation specifies the number of supported
>>           * bits of physical priority. For backwards compatibility
> 
> icc_highest_active_group() also needs to be changed, because
> if the NMI bit is set in an AP register that is what defines
> the group of the highest priority active interrupt. Something
> like this at the top of icc_highest_active_group() should do:
> 
> +    if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
> +        return GICV3_G1;
> +    }
> +    if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
> +        return GICV3_G1NS;
> +    }
> 
> thanks
> -- PMM

