Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A1C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdGM-0005Ie-JD; Tue, 19 Mar 2024 13:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdGL-0005IE-N7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:28:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdGI-0000mB-5l
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:28:33 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso140264a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710869308; x=1711474108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOwEUj9xPQk9/xMWe7WXcb2JPRH0w5ppYiC8cOHOmTI=;
 b=jM8zckow4tYkE1ZTgEaAxgXTJfp6mwNKDFmvpIRBRS+mu2FxSuAIIxe/kmXt/Dul+D
 FrDvv3dJe2gILMfJ2u7dD+tsyD+I8/JxqRD68+T2PovJLSQYBgfQaIvwsEJnJrJafB0G
 ut6/si98NlAEYo5hHhC/CTdaiuWUlNRrAfUO4pTGqbDdfijQdq4E7O4QS1GYnobSYs24
 R+tW9KBWhEqymDupmmTXwl3XGMu5Y0JNgBARXj8wAjPctOkTE9YsVeGQ9icTHdDq1xOL
 u7WksfNXP2oMvTfqsmOqDDziS3UuG0ZN7NRcBZcAEOS7vGgQ/luRSl1betTUoGlhbhRn
 2aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710869308; x=1711474108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOwEUj9xPQk9/xMWe7WXcb2JPRH0w5ppYiC8cOHOmTI=;
 b=jiHSWRCQJPhbz/bYMT3C/uzfVH0o08pSIgkvuGBy42fSDGKUs5fsD7fiQWPJwjqIbd
 AiUWwPC0dmJL7T9hC0MoFXQdC8lMmsqd+6A271Z91XODxGvP3IplbFdUKtBUwRtKo6u2
 t3TEy8hjpDZUeKZxFgseU+3fcTYuVNCpyVR/Tvu61dSoWccAW84OlJZ/RQ2AKOCjHRAA
 0yqg96yPfRQDr+ywudC5bXIh7HRdy3ck/1GfXq2iPevpo4Kq4lWzWQ0Q3glv5KerKgYz
 vpgN2mj1cipt15j7lCjzZWDMc7YC7r4p7SQWnV4fpSMt8MdlxeCLkWRQsMaOhDP2OfpR
 Qojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvN1/U4tbK7y5UP/mgzegkuTA+WXJxKxLWKzTg46nS8eoECnYyMXZ2ptU+pYpjM44HFcwzz5iU6vCB0BYekGBCFYzw1Ns=
X-Gm-Message-State: AOJu0YylO9H39Q94Ef9AxDwDPg9paGMek/4S6Dnl7HyloE+9c4hKTn3I
 ETC29uxiY8Z8+uHWUHt4in4fAWkGz4PXonrEgRIFggGF038lKUqEZ/7ZMyHQ0jsqY7z8WrLZfPW
 bd7n82TjF58FU6mK9AANMgodHNnzjlFbA6LEkog==
X-Google-Smtp-Source: AGHT+IGuXXSXLLlCJLI0XdGzKWdQroeOFGKx2P6Yhe8g5zaNNL6LDzXJUsoTApTg9JTYLg9qYY/p3h+LusOAX3WWtL8=
X-Received: by 2002:a50:f617:0:b0:566:902e:65e4 with SMTP id
 c23-20020a50f617000000b00566902e65e4mr3319827edn.18.1710869307940; Tue, 19
 Mar 2024 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
In-Reply-To: <20240318093546.2786144-7-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 17:28:16 +0000
Message-ID: <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This only implements the external delivery method via the GICv3.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v8:
> - Fix the rcu stall after sending a VNMI in qemu VM.
> v7:
> - Add Reviewed-by.
> v6:
> - env->cp15.hcr_el2 -> arm_hcr_el2_eff().
> - env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
> - Not include VF && VFNMI in CPU_INTERRUPT_VNMI.
> v4:
> - Accept NMI unconditionally for arm_cpu_has_work() but add comment.
> - Change from & to && for EXCP_IRQ or EXCP_FIQ.
> - Refator nmi mask in arm_excp_unmasked().
> - Also handle VNMI in arm_cpu_exec_interrupt() and arm_cpu_set_irq().
> - Rename virtual to Virtual.
> v3:
> - Not include CPU_INTERRUPT_NMI when FEAT_NMI not enabled
> - Add ARM_CPU_VNMI.
> - Refator nmi mask in arm_excp_unmasked().
> - Test SCTLR_ELx.NMI for ALLINT mask for NMI.
> ---
>  target/arm/cpu-qom.h   |  4 +-
>  target/arm/cpu.c       | 85 +++++++++++++++++++++++++++++++++++++++---
>  target/arm/cpu.h       |  4 ++
>  target/arm/helper.c    |  2 +
>  target/arm/internals.h |  9 +++++
>  5 files changed, 97 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 8e032691db..e0c9e18036 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -36,11 +36,13 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>  #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>  #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>
> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
> +/* Meanings of the ARMCPU object's six inbound GPIO lines */
>  #define ARM_CPU_IRQ 0
>  #define ARM_CPU_FIQ 1
>  #define ARM_CPU_VIRQ 2
>  #define ARM_CPU_VFIQ 3
> +#define ARM_CPU_NMI 4
> +#define ARM_CPU_VNMI 5
>
>  /* For M profile, some registers are banked secure vs non-secure;
>   * these are represented as a 2-element array where the first element

> @@ -678,13 +687,31 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>          return false;
>      }
>
> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
> +        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
> +        allIntMask = env->pstate & PSTATE_ALLINT ||
> +                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
> +                      (env->pstate & PSTATE_SP));
> +    }
> +
>      switch (excp_idx) {
> +    case EXCP_NMI:
> +        pstate_unmasked = !allIntMask;
> +        break;
> +
> +    case EXCP_VNMI:
> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
> +             (hcr_el2 & HCR_TGE)) {
> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
> +            return false;
> +        }

VINMI and VFNMI aren't the same thing: do we definitely want to
merge them into one EXCP_VNMI ? It feels like it would be simpler
to keep them separate. Similarly CPU_INTERRUPT_VNMI, and
arm_cpu_update_vnmi() probably want VINMI and VFNMI versions.

> +        return !allIntMask;
>      case EXCP_FIQ:
> -        pstate_unmasked = !(env->daif & PSTATE_F);
> +        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
>          break;
>
>      case EXCP_IRQ:
> -        pstate_unmasked = !(env->daif & PSTATE_I);
> +        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
>          break;
>
>      case EXCP_VFIQ:
> @@ -692,13 +719,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>              /* VFIQs are only taken when hypervized.  */
>              return false;
>          }
> -        return !(env->daif & PSTATE_F);
> +        return !(env->daif & PSTATE_F) && (!allIntMask);
>      case EXCP_VIRQ:
>          if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
>              /* VIRQs are only taken when hypervized.  */
>              return false;
>          }
> -        return !(env->daif & PSTATE_I);
> +        return !(env->daif & PSTATE_I) && (!allIntMask);
>      case EXCP_VSERR:
>          if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
>              /* VIRQs are only taken when hypervized.  */
> @@ -804,6 +831,24 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>
>      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
>
> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> +        if (interrupt_request & CPU_INTERRUPT_NMI) {
> +            excp_idx = EXCP_NMI;
> +            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                                  cur_el, secure, hcr_el2)) {
> +                goto found;
> +            }
> +        }
> +        if (interrupt_request & CPU_INTERRUPT_VNMI) {
> +            excp_idx = EXCP_VNMI;
> +            target_el = 1;
> +            if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                                  cur_el, secure, hcr_el2)) {
> +                goto found;
> +            }
> +        }
> +    }
>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>          excp_idx = EXCP_FIQ;
>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> @@ -900,6 +945,28 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
>      }
>  }
>
> +void arm_cpu_update_vnmi(ARMCPU *cpu)
> +{
> +    /*
> +     * Update the interrupt level for VNMI, which is the logical OR of
> +     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
> +     */
> +    CPUARMState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
> +                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
> +        (env->irq_line_state & CPU_INTERRUPT_VNMI);
> +
> +    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VNMI) != 0)) {
> +        if (new_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_VNMI);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_VNMI);
> +        }
> +    }
> +}

I think Richard noted on a previous version of the series that
the existing arm_cpu_update_virq() and arm_cpu_update_vfiq()
also need changing so they don't set CPU_INTERRUPT_VIRQ
or CPU_INTERRUPT_VFIQ if the HCRX_EL2 bits indicate that
we should be signalling a VINMI or VFNMI instead.
That also means that VIRQ and VFIQ will change values based
on changes in HCRX_EL2, which means that hcrx_write() needs
to have calls to arm_cpu_update_{virq,vfiq,vnmi} the way
that do_hcr_write() already does.

The use of the _eff() versions of the functions here is
correct but it introduces a new case where we need to
reevaluate the status of the VNMI etc interrupt status:
when we change from Secure to NonSecure or when we change
SCR_EL3.EEL2 or SCR_EL3.HXEN. We either need to make sure
we reevaluate when we drop from EL3 to EL2 (which would be
OK since VINMI and VFNMI can't be taken at EL3 and none of
these bits can change except at EL3) or else make the calls
to reevaluate them when we write to SCR_EL3. At least, I don't
think we currently reevaluate these bits on an EL change.

> +
>  void arm_cpu_update_vserr(ARMCPU *cpu)
>  {
>      /*
> @@ -929,7 +996,9 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
>          [ARM_CPU_IRQ] = CPU_INTERRUPT_HARD,
>          [ARM_CPU_FIQ] = CPU_INTERRUPT_FIQ,
>          [ARM_CPU_VIRQ] = CPU_INTERRUPT_VIRQ,
> -        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
> +        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ,
> +        [ARM_CPU_NMI] = CPU_INTERRUPT_NMI,
> +        [ARM_CPU_VNMI] = CPU_INTERRUPT_VNMI
>      };
>
>      if (!arm_feature(env, ARM_FEATURE_EL2) &&
> @@ -955,8 +1024,12 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
>      case ARM_CPU_VFIQ:
>          arm_cpu_update_vfiq(cpu);
>          break;
> +    case ARM_CPU_VNMI:
> +        arm_cpu_update_vnmi(cpu);
> +        break;
>      case ARM_CPU_IRQ:
>      case ARM_CPU_FIQ:
> +    case ARM_CPU_NMI:
>          if (level) {
>              cpu_interrupt(cs, mask[irq]);
>          } else {
> @@ -1355,7 +1428,7 @@ static void arm_cpu_initfn(Object *obj)
>           */
>          qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
>      } else {
> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);

You should also update the value passed when we init the
GPIOs in the arm_cpu_kvm_set_irq case, and update the comment
that explains why, which currently reads:

        /* VIRQ and VFIQ are unused with KVM but we add them to maintain
         * the same interface as non-KVM CPUs.
         */

so it mentions also the NMI and VNMI inputs.

>      }
>
>      qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index de740d223f..629221e1a9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -61,6 +61,8 @@
>  #define EXCP_DIVBYZERO      23   /* v7M DIVBYZERO UsageFault */
>  #define EXCP_VSERR          24
>  #define EXCP_GPC            25   /* v9 Granule Protection Check Fault */
> +#define EXCP_NMI            26
> +#define EXCP_VNMI           27
>  /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
>
>  #define ARMV7M_EXCP_RESET   1
> @@ -80,6 +82,8 @@
>  #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
>  #define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
>  #define CPU_INTERRUPT_VSERR CPU_INTERRUPT_TGT_INT_0
> +#define CPU_INTERRUPT_NMI   CPU_INTERRUPT_TGT_EXT_4
> +#define CPU_INTERRUPT_VNMI  CPU_INTERRUPT_TGT_EXT_0

>  /* The usual mapping for an AArch64 system register to its AArch32
>   * counterpart is for the 32 bit world to have access to the lower
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index aa0151c775..875a7fa8da 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10793,6 +10793,8 @@ void arm_log_exception(CPUState *cs)
>              [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
>              [EXCP_VSERR] = "Virtual SERR",
>              [EXCP_GPC] = "Granule Protection Check",
> +            [EXCP_NMI] = "NMI",
> +            [EXCP_VNMI] = "Virtual NMI"
>          };
>
>          if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 516e0584bf..cb217a9ce7 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1109,6 +1109,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
>   */
>  void arm_cpu_update_vfiq(ARMCPU *cpu);
>
> +/**
> + * arm_cpu_update_vnmi: Update CPU_INTERRUPT_VNMI bit in cs->interrupt_request
> + *
> + * Update the CPU_INTERRUPT_VNMI bit in cs->interrupt_request, following
> + * a change to either the input VNMI line from the GIC or the HCRX_EL2.VINMI.
> + * Must be called with the BQL held.
> + */
> +void arm_cpu_update_vnmi(ARMCPU *cpu);

thanks
-- PMM

