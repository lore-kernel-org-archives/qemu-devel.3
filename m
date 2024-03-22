Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C8FC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 05:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnX67-0000Ci-51; Fri, 22 Mar 2024 01:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnX61-0000Bi-JZ; Fri, 22 Mar 2024 01:05:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rnX5x-0007F8-4N; Fri, 22 Mar 2024 01:05:36 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V19Gp0KTQzbdVl;
 Fri, 22 Mar 2024 13:04:18 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 811C91400D7;
 Fri, 22 Mar 2024 13:05:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 13:05:06 +0800
Message-ID: <53e82726-6b92-4176-a59d-c720e2c37ef4@huawei.com>
Date: Fri, 22 Mar 2024 13:05:06 +0800
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
 <CAFEAcA8+9Xd-GDNzBqGfDxoc7Bg-+wK59vcsyyNmrXrvAitAuQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8+9Xd-GDNzBqGfDxoc7Bg-+wK59vcsyyNmrXrvAitAuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.36,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2024/3/22 2:28, Peter Maydell wrote:
> On Thu, 21 Mar 2024 at 15:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Something somewhere needs to implement "if SCTLR_ELx.NMI is 0 then
>> we don't take EXCP_VINMI etc but instead (maybe) EXCP_VIRQ etc".
>> At the moment nothing does that:
>>  * arm_cpu_update_vinmi() doesn't look at the NMI bit before
>>    deciding whether to set CPU_INTERRUPT_VINMI
>>  * in arm_excp_unmasked() if NMI is 0 then allIntMask takes its
>>    default value of false and so arm_excp_unmasked() returns true,
>>    so VINMI is not masked
>>  * arm_cpu_exec_interrupt() doesn't look at the NMI bit before
>>    deciding whether to check the CPU_INTERRUPT_VINMI bit in interrupt_request
>>
>> So even if SCTLR_ELx.NMI is 0 we'll still try to take a VINMI
>> if it's set up in the HCR_EL2 bits.
>>
>> However we do this the required behaviour is that if NMI is 0
>> then it is as if the interrupt doesn't have superpriority and
>> it falls back to being handled as an ordinary IRQ, VIRQ, VFIQ etc.
>> I think the best place to do this is probably here in
>> arm_cpu_exec_interrupt() -- if SCTLR_ELx.NMI isn't set then
>> treat the VFNMI bit like VFIQ, the VINMI bit like VIRQ, and
>> the NMI bit like IRQ.
> 
> Folding in something like this I think will work:
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 91c2896de0f..797ae3eb805 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -837,7 +837,8 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
> int interrupt_request)
> 
>      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
> 
> -    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
> +        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
>          if (interrupt_request & CPU_INTERRUPT_NMI) {
>              excp_idx = EXCP_NMI;
>              target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> @@ -862,7 +863,22 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
> int interrupt_request)
>                  goto found;
>              }
>          }
> +    } else {
> +        /*
> +         * NMI disabled: interrupts with superpriority are handled
> +         * as if they didn't have it
> +         */
> +        if (interrupt_request & CPU_INTERRUPT_NMI) {
> +            interrupt_request |= CPU_INTERRUPT_HARD;

The CPU_INTERRUPT_NMI and CPU_INTERRUPT_HARD are set simultaneously,
should the CPU_INTERRUPT_NMI be cleared?

> +        }
> +        if (interrupt_request & CPU_INTERRUPT_VINMI) {
> +            interrupt_request |= CPU_INTERRUPT_VIRQ;
> +        }
> +        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
> +            interrupt_request |= CPU_INTERRUPT_VFIQ;
> +        }
>      }> +
>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>          excp_idx = EXCP_FIQ;
>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> 
> 
>> What semantics do we intend for the VINMI/VFNMI bits in interrupt_request
>> and for the incoming IRQ, FIQ, NMI lines? The GIC spec suggests
>> (but doesn't mandate) that NMI could be signalled by asserting
>> both NMI and IRQ, and plain IRQ by asserting just IRQ (table 4-6
>> in the GIC spec). I think the GIC changes in this patchset assert
>> only the NMI line for an IRQNMI, and not both NMI and IRQ. That's OK
>> and I think makes more sense for QEMU than signalling both lines,
>> but it's not the same as what we wind up doing with the handling
>> of the HCR_EL2 bits in these functions, because you don't change
>> the existing arm_cpu_update_virq() so that it only sets the
>> CPU_INTERRUPT_VIRQ bit if this is a VIRQ and not a VIRQNMI.
>> So if the guest sets HCR_EL2.VI and HCRX_EL2.VINMI then
>> arm_cpu_update_virq() will say "this is a VIRQ" and also
>> arm_cpu_update_vinmi() will say "This is a VINMI" and so both bits
>> get set in the interrupt_request field.
>>
>> I think the fix for this is probably to have arm_cpu_update_virq()
>> and arm_cpu_update_vfiq() check that this is not a VINMI/VFNMI,
>> so we only set 1 bit in interrupt_request, not 2.
> 
> And for this a change like:
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 03a48a41366..91c2896de0f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -926,7 +926,8 @@ void arm_cpu_update_virq(ARMCPU *cpu)
>      CPUARMState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
> 
> -    bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
> +    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
> +                      !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
>          (env->irq_line_state & CPU_INTERRUPT_VIRQ);
> 
>      if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
> @@ -947,7 +948,8 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
>      CPUARMState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
> 
> -    bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
> +    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VF) &&
> +                      !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
>          (env->irq_line_state & CPU_INTERRUPT_VFIQ);
> 
>      if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
> 
> 
> thanks
> -- PMM

