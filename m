Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63332C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 03:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnW1W-00085e-Mx; Thu, 21 Mar 2024 23:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnW1O-00084j-1N; Thu, 21 Mar 2024 23:56:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnW1J-0002ks-9l; Thu, 21 Mar 2024 23:56:45 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V17lj14dFz1vx3v;
 Fri, 22 Mar 2024 11:55:45 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 2712F140133;
 Fri, 22 Mar 2024 11:56:32 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:56:31 +0800
Message-ID: <1b4f0b6a-f1b1-8531-e117-fb85aedfa440@huawei.com>
Date: Fri, 22 Mar 2024 11:56:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v9 06/23] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
 <20240321130812.2983113-7-ruanjinjie@huawei.com>
 <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
In-Reply-To: <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.32; envelope-from=ruanjinjie@huawei.com;
 helo=szxga06-in.huawei.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.36,
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



On 2024/3/21 23:46, Peter Maydell wrote:
> On Thu, 21 Mar 2024 at 13:10, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> This only implements the external delivery method via the GICv3.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v9:
>> - Update the GPIOs passed in the arm_cpu_kvm_set_irq, and update the comment.
>> - Definitely not merge VINMI and VFNMI into EXCP_VNMI.
>> - Update VINMI and VFNMI when writing HCR_EL2 or HCRX_EL2.
>> v8:
>> - Fix the rcu stall after sending a VNMI in qemu VM.
>> v7:
>> - Add Reviewed-by.
>> v6:
>> - env->cp15.hcr_el2 -> arm_hcr_el2_eff().
>> - env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
>> - Not include VF && VFNMI in CPU_INTERRUPT_VNMI.
>> v4:
>> - Accept NMI unconditionally for arm_cpu_has_work() but add comment.
>> - Change from & to && for EXCP_IRQ or EXCP_FIQ.
>> - Refator nmi mask in arm_excp_unmasked().
>> - Also handle VNMI in arm_cpu_exec_interrupt() and arm_cpu_set_irq().
>> - Rename virtual to Virtual.
>> v3:
>> - Not include CPU_INTERRUPT_NMI when FEAT_NMI not enabled
>> - Add ARM_CPU_VNMI.
>> - Refator nmi mask in arm_excp_unmasked().
>> - Test SCTLR_ELx.NMI for ALLINT mask for NMI.
>> ---
>>  target/arm/cpu-qom.h   |   5 +-
>>  target/arm/cpu.c       | 124 ++++++++++++++++++++++++++++++++++++++---
>>  target/arm/cpu.h       |   6 ++
>>  target/arm/helper.c    |  33 +++++++++--
>>  target/arm/internals.h |  18 ++++++
>>  5 files changed, 172 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
>> index 8e032691db..b497667d61 100644
>> --- a/target/arm/cpu-qom.h
>> +++ b/target/arm/cpu-qom.h
>> @@ -36,11 +36,14 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>>  #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>>  #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>>
>> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
>> +/* Meanings of the ARMCPU object's seven inbound GPIO lines */
>>  #define ARM_CPU_IRQ 0
>>  #define ARM_CPU_FIQ 1
>>  #define ARM_CPU_VIRQ 2
>>  #define ARM_CPU_VFIQ 3
>> +#define ARM_CPU_NMI 4
>> +#define ARM_CPU_VINMI 5
>> +#define ARM_CPU_VFNMI 6
>>
>>  /* For M profile, some registers are banked secure vs non-secure;
>>   * these are represented as a 2-element array where the first element
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index ab8d007a86..f1e7ae0975 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -122,6 +122,13 @@ void arm_restore_state_to_opc(CPUState *cs,
>>  }
>>  #endif /* CONFIG_TCG */
>>
>> +/*
>> + * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
>> + * IRQ without Superpriority. Moreover, if the GIC is configured so that
>> + * FEAT_GICv3_NMI is only set if FEAT_NMI is set, then we won't ever see
>> + * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
>> + * unconditionally.
>> + */
>>  static bool arm_cpu_has_work(CPUState *cs)
>>  {
>>      ARMCPU *cpu = ARM_CPU(cs);
>> @@ -129,6 +136,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>>      return (cpu->power_state != PSCI_OFF)
>>          && cs->interrupt_request &
>>          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>> +         | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
>>           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
>>           | CPU_INTERRUPT_EXITTB);
>>  }
>> @@ -668,6 +676,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>>      CPUARMState *env = cpu_env(cs);
>>      bool pstate_unmasked;
>>      bool unmasked = false;
>> +    bool allIntMask = false;
>>
>>      /*
>>       * Don't take exceptions if they target a lower EL.
>> @@ -678,13 +687,36 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>>          return false;
>>      }
>>
>> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
>> +        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
>> +        allIntMask = env->pstate & PSTATE_ALLINT ||
>> +                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
>> +                      (env->pstate & PSTATE_SP));
>> +    }
>> +
>>      switch (excp_idx) {
>> +    case EXCP_NMI:
>> +        pstate_unmasked = !allIntMask;
>> +        break;
>> +
>> +    case EXCP_VINMI:
>> +        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
>> +            /* VINMIs are only taken when hypervized.  */
>> +            return false;
>> +        }
>> +        return !allIntMask;
>> +    case EXCP_VFNMI:
>> +        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
>> +            /* VFNMIs are only taken when hypervized.  */
>> +            return false;
>> +        }
>> +        return !allIntMask;
>>      case EXCP_FIQ:
>> -        pstate_unmasked = !(env->daif & PSTATE_F);
>> +        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
>>          break;
>>
>>      case EXCP_IRQ:
>> -        pstate_unmasked = !(env->daif & PSTATE_I);
>> +        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
>>          break;
>>
>>      case EXCP_VFIQ:
>> @@ -692,13 +724,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>>              /* VFIQs are only taken when hypervized.  */
>>              return false;
>>          }
>> -        return !(env->daif & PSTATE_F);
>> +        return !(env->daif & PSTATE_F) && (!allIntMask);
>>      case EXCP_VIRQ:
>>          if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
>>              /* VIRQs are only taken when hypervized.  */
>>              return false;
>>          }
>> -        return !(env->daif & PSTATE_I);
>> +        return !(env->daif & PSTATE_I) && (!allIntMask);
>>      case EXCP_VSERR:
>>          if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
>>              /* VIRQs are only taken when hypervized.  */
>> @@ -804,6 +836,32 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>
>>      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
>>
>> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
>> +        if (interrupt_request & CPU_INTERRUPT_NMI) {
>> +            excp_idx = EXCP_NMI;
>> +            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
>> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +                                  cur_el, secure, hcr_el2)) {
>> +                goto found;
>> +            }
>> +        }
>> +        if (interrupt_request & CPU_INTERRUPT_VINMI) {
>> +            excp_idx = EXCP_VINMI;
>> +            target_el = 1;
>> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +                                  cur_el, secure, hcr_el2)) {
>> +                goto found;
>> +            }
>> +        }
>> +        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
>> +            excp_idx = EXCP_VFNMI;
>> +            target_el = 1;
>> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +                                  cur_el, secure, hcr_el2)) {
>> +                goto found;
>> +            }
>> +        }
>> +    }
> 
> Something somewhere needs to implement "if SCTLR_ELx.NMI is 0 then
> we don't take EXCP_VINMI etc but instead (maybe) EXCP_VIRQ etc".
> At the moment nothing does that:
>  * arm_cpu_update_vinmi() doesn't look at the NMI bit before
>    deciding whether to set CPU_INTERRUPT_VINMI
>  * in arm_excp_unmasked() if NMI is 0 then allIntMask takes its
>    default value of false and so arm_excp_unmasked() returns true,
>    so VINMI is not masked
>  * arm_cpu_exec_interrupt() doesn't look at the NMI bit before
>    deciding whether to check the CPU_INTERRUPT_VINMI bit in interrupt_request
> 
> So even if SCTLR_ELx.NMI is 0 we'll still try to take a VINMI
> if it's set up in the HCR_EL2 bits.
> 
> However we do this the required behaviour is that if NMI is 0
> then it is as if the interrupt doesn't have superpriority and
> it falls back to being handled as an ordinary IRQ, VIRQ, VFIQ etc.
> I think the best place to do this is probably here in
> arm_cpu_exec_interrupt() -- if SCTLR_ELx.NMI isn't set then
> treat the VFNMI bit like VFIQ, the VINMI bit like VIRQ, and
> the NMI bit like IRQ.

A PE that implements FEAT_NMI and FEAT_GICv3 also implements
FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not
implement FEAT_GICv3_NMI.

As the GIC side has checked the FEAT_GICv3_NMI is implemented or Not. So
if cpu_isar_feature(aa64_nmi, env_archcpu(env)) is false, the
FEAT_GICv3_NMI will also not implemented,the CPU_INTERRUPT_NMI/VINMI can
not come from GIC, so we only need to check cpu_isar_feature(aa64_nmi,
env_archcpu(env)) and SCTLR_ELx.NMI is set in hcr_write() and
hcrx_write() for CPU side.

> 
>>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>>          excp_idx = EXCP_FIQ;
>>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
>> @@ -900,6 +958,48 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
>>      }
>>  }
>>
>> +void arm_cpu_update_vinmi(ARMCPU *cpu)
>> +{
>> +    /*
>> +     * Update the interrupt level for VINMI, which is the logical OR of
>> +     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
>> +     */
>> +    CPUARMState *env = &cpu->env;
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
>> +                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
>> +        (env->irq_line_state & CPU_INTERRUPT_VINMI);
>> +
>> +    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VINMI) != 0)) {
>> +        if (new_state) {
>> +            cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
>> +        } else {
>> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VINMI);
>> +        }
>> +    }
>> +}
> 
> What semantics do we intend for the VINMI/VFNMI bits in interrupt_request
> and for the incoming IRQ, FIQ, NMI lines? The GIC spec suggests
> (but doesn't mandate) that NMI could be signalled by asserting
> both NMI and IRQ, and plain IRQ by asserting just IRQ (table 4-6
> in the GIC spec). I think the GIC changes in this patchset assert
> only the NMI line for an IRQNMI, and not both NMI and IRQ. That's OK
> and I think makes more sense for QEMU than signalling both lines,
> but it's not the same as what we wind up doing with the handling
> of the HCR_EL2 bits in these functions, because you don't change
> the existing arm_cpu_update_virq() so that it only sets the
> CPU_INTERRUPT_VIRQ bit if this is a VIRQ and not a VIRQNMI.
> So if the guest sets HCR_EL2.VI and HCRX_EL2.VINMI then
> arm_cpu_update_virq() will say "this is a VIRQ" and also
> arm_cpu_update_vinmi() will say "This is a VINMI" and so both bits
> get set in the interrupt_request field.
> 
> I think the fix for this is probably to have arm_cpu_update_virq()
> and arm_cpu_update_vfiq() check that this is not a VINMI/VFNMI,
> so we only set 1 bit in interrupt_request, not 2.
> 
> thanks
> -- PMM

