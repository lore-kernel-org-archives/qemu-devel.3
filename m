Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E907BC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 09:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnEhP-0006o5-3y; Thu, 21 Mar 2024 05:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnEhM-0006nY-TV; Thu, 21 Mar 2024 05:26:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnEhJ-0001kp-IT; Thu, 21 Mar 2024 05:26:56 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0g4v2ycWz1h30Z;
 Thu, 21 Mar 2024 17:23:59 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 72EB31A0172;
 Thu, 21 Mar 2024 17:26:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 17:26:32 +0800
Message-ID: <90475c65-f148-9f49-8c5b-ea55137e1a6f@huawei.com>
Date: Thu, 21 Mar 2024 17:26:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
 <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
In-Reply-To: <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.399,
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



On 2024/3/20 1:28, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> This only implements the external delivery method via the GICv3.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
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
>>  target/arm/cpu-qom.h   |  4 +-
>>  target/arm/cpu.c       | 85 +++++++++++++++++++++++++++++++++++++++---
>>  target/arm/cpu.h       |  4 ++
>>  target/arm/helper.c    |  2 +
>>  target/arm/internals.h |  9 +++++
>>  5 files changed, 97 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
>> index 8e032691db..e0c9e18036 100644
>> --- a/target/arm/cpu-qom.h
>> +++ b/target/arm/cpu-qom.h
>> @@ -36,11 +36,13 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>>  #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>>  #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>>
>> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
>> +/* Meanings of the ARMCPU object's six inbound GPIO lines */
>>  #define ARM_CPU_IRQ 0
>>  #define ARM_CPU_FIQ 1
>>  #define ARM_CPU_VIRQ 2
>>  #define ARM_CPU_VFIQ 3
>> +#define ARM_CPU_NMI 4
>> +#define ARM_CPU_VNMI 5
>>
>>  /* For M profile, some registers are banked secure vs non-secure;
>>   * these are represented as a 2-element array where the first element
> 
>> @@ -678,13 +687,31 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
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
>> +    case EXCP_VNMI:
>> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
>> +             (hcr_el2 & HCR_TGE)) {
>> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
>> +            return false;
>> +        }
> 
> VINMI and VFNMI aren't the same thing: do we definitely want to
> merge them into one EXCP_VNMI ? It feels like it would be simpler
> to keep them separate. Similarly CPU_INTERRUPT_VNMI, and
> arm_cpu_update_vnmi() probably want VINMI and VFNMI versions.

It's not like that. The VFNMI cannot be reported from the GIC, there
will be no opportunity to call arm_cpu_update_vfnmi().
> 
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
>> @@ -692,13 +719,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
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
>> @@ -804,6 +831,24 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
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
>> +        if (interrupt_request & CPU_INTERRUPT_VNMI) {
>> +            excp_idx = EXCP_VNMI;
>> +            target_el = 1;
>> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +                                  cur_el, secure, hcr_el2)) {
>> +                goto found;
>> +            }
>> +        }
>> +    }
>>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>>          excp_idx = EXCP_FIQ;
>>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
>> @@ -900,6 +945,28 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
>>      }
>>  }
>>
>> +void arm_cpu_update_vnmi(ARMCPU *cpu)
>> +{
>> +    /*
>> +     * Update the interrupt level for VNMI, which is the logical OR of
>> +     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
>> +     */
>> +    CPUARMState *env = &cpu->env;
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
>> +                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
>> +        (env->irq_line_state & CPU_INTERRUPT_VNMI);
>> +
>> +    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VNMI) != 0)) {
>> +        if (new_state) {
>> +            cpu_interrupt(cs, CPU_INTERRUPT_VNMI);
>> +        } else {
>> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VNMI);
>> +        }
>> +    }
>> +}
> 
> I think Richard noted on a previous version of the series that
> the existing arm_cpu_update_virq() and arm_cpu_update_vfiq()
> also need changing so they don't set CPU_INTERRUPT_VIRQ
> or CPU_INTERRUPT_VFIQ if the HCRX_EL2 bits indicate that
> we should be signalling a VINMI or VFNMI instead.
> That also means that VIRQ and VFIQ will change values based
> on changes in HCRX_EL2, which means that hcrx_write() needs
> to have calls to arm_cpu_update_{virq,vfiq,vnmi} the way
> that do_hcr_write() already does.
> 
> The use of the _eff() versions of the functions here is
> correct but it introduces a new case where we need to
> reevaluate the status of the VNMI etc interrupt status:
> when we change from Secure to NonSecure or when we change
> SCR_EL3.EEL2 or SCR_EL3.HXEN. We either need to make sure
> we reevaluate when we drop from EL3 to EL2 (which would be
> OK since VINMI and VFNMI can't be taken at EL3 and none of
> these bits can change except at EL3) or else make the calls
> to reevaluate them when we write to SCR_EL3. At least, I don't
> think we currently reevaluate these bits on an EL change.
> 
>> +
>>  void arm_cpu_update_vserr(ARMCPU *cpu)
>>  {
>>      /*
>> @@ -929,7 +996,9 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
>>          [ARM_CPU_IRQ] = CPU_INTERRUPT_HARD,
>>          [ARM_CPU_FIQ] = CPU_INTERRUPT_FIQ,
>>          [ARM_CPU_VIRQ] = CPU_INTERRUPT_VIRQ,
>> -        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
>> +        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ,
>> +        [ARM_CPU_NMI] = CPU_INTERRUPT_NMI,
>> +        [ARM_CPU_VNMI] = CPU_INTERRUPT_VNMI
>>      };
>>
>>      if (!arm_feature(env, ARM_FEATURE_EL2) &&
>> @@ -955,8 +1024,12 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
>>      case ARM_CPU_VFIQ:
>>          arm_cpu_update_vfiq(cpu);
>>          break;
>> +    case ARM_CPU_VNMI:
>> +        arm_cpu_update_vnmi(cpu);
>> +        break;
>>      case ARM_CPU_IRQ:
>>      case ARM_CPU_FIQ:
>> +    case ARM_CPU_NMI:
>>          if (level) {
>>              cpu_interrupt(cs, mask[irq]);
>>          } else {
>> @@ -1355,7 +1428,7 @@ static void arm_cpu_initfn(Object *obj)
>>           */
>>          qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
>>      } else {
>> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
>> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
> 
> You should also update the value passed when we init the
> GPIOs in the arm_cpu_kvm_set_irq case, and update the comment
> that explains why, which currently reads:
> 
>         /* VIRQ and VFIQ are unused with KVM but we add them to maintain
>          * the same interface as non-KVM CPUs.
>          */
> 
> so it mentions also the NMI and VNMI inputs.
> 
>>      }
>>
>>      qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index de740d223f..629221e1a9 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -61,6 +61,8 @@
>>  #define EXCP_DIVBYZERO      23   /* v7M DIVBYZERO UsageFault */
>>  #define EXCP_VSERR          24
>>  #define EXCP_GPC            25   /* v9 Granule Protection Check Fault */
>> +#define EXCP_NMI            26
>> +#define EXCP_VNMI           27
>>  /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
>>
>>  #define ARMV7M_EXCP_RESET   1
>> @@ -80,6 +82,8 @@
>>  #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
>>  #define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
>>  #define CPU_INTERRUPT_VSERR CPU_INTERRUPT_TGT_INT_0
>> +#define CPU_INTERRUPT_NMI   CPU_INTERRUPT_TGT_EXT_4
>> +#define CPU_INTERRUPT_VNMI  CPU_INTERRUPT_TGT_EXT_0
> 
>>  /* The usual mapping for an AArch64 system register to its AArch32
>>   * counterpart is for the 32 bit world to have access to the lower
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index aa0151c775..875a7fa8da 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -10793,6 +10793,8 @@ void arm_log_exception(CPUState *cs)
>>              [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
>>              [EXCP_VSERR] = "Virtual SERR",
>>              [EXCP_GPC] = "Granule Protection Check",
>> +            [EXCP_NMI] = "NMI",
>> +            [EXCP_VNMI] = "Virtual NMI"
>>          };
>>
>>          if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 516e0584bf..cb217a9ce7 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -1109,6 +1109,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
>>   */
>>  void arm_cpu_update_vfiq(ARMCPU *cpu);
>>
>> +/**
>> + * arm_cpu_update_vnmi: Update CPU_INTERRUPT_VNMI bit in cs->interrupt_request
>> + *
>> + * Update the CPU_INTERRUPT_VNMI bit in cs->interrupt_request, following
>> + * a change to either the input VNMI line from the GIC or the HCRX_EL2.VINMI.
>> + * Must be called with the BQL held.
>> + */
>> +void arm_cpu_update_vnmi(ARMCPU *cpu);
> 
> thanks
> -- PMM

