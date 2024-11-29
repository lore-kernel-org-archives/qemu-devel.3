Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282D8D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4Ne-0001kW-Gy; Fri, 29 Nov 2024 12:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH4Nc-0001hp-Gz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:02:08 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH4Na-000606-61
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:02:08 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e2880606so14651f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732899724; x=1733504524; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHo8K0Rqtg9qhR5+I18DYilOtsmmfysbbakGl8pgDvY=;
 b=hl/FY/TQRAVTaYGJJdihWDBt+5BKIuEC21YrLgWaPVr2Nh5Usv1B5+hPmEJQpQsJAB
 TgVtfsSq+sIVm349deRUZrGZwoRfjEAk/DjdoiPkXw2QZ+da1BUB/ErwiiAREQ11G8N+
 xBv3mGaM4QXf8HFDYWWCImHvYOKFtrQKeTvXV67KyO3GV247UGLkMYLkyWiuuhbHCnhZ
 Hn+T7ZJuWkun8R51dmm6pioUX0n+IYe6paSx3D/k5zSCZeZMNTvzmXRex1uUEMkRFyeu
 /b3dSajAoBjrBrKOMBtdgwk6LvAPQJ14ptYa0dcnHFYQhRXmTsuFBFrB08H4DO645jF6
 6rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732899724; x=1733504524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHo8K0Rqtg9qhR5+I18DYilOtsmmfysbbakGl8pgDvY=;
 b=qQZZIf8P1Ma5p5FGrRNsNF+4Djhx1SXKrUULsMv1I2YfI7X8i8E+QAoEyR6uy3ChDe
 8V076ToixwJckGsuPCsgzLMvhp6pVpG5bLmhKBGjMkeUv50a9YYYd6xVk9UofhncgGHW
 Tr5oAPluWaZA08e9m5/83UZvoaaojVjg9skkTASH0yLfWfzZ3wazRrfeONdwfIXw2UCT
 s/fe7JvQa3MQgANAMFhTm6dzMy25JAln7JPeDzW6yrzfIiKjy87abWk3mSk3SobOONhe
 nkRhFzQJj7DESMsrCO1BLvMZrAzqWbtw4rz3Z1SA9U3xHvSw4uZQpYGd4hXz+9k7oMDV
 rssg==
X-Gm-Message-State: AOJu0YzbgAyub8hLTgBH4PMOIiFlTkVS8NWrnD0Wt290ZEfr7sqYLZ7n
 /cTpt9RxVEn6qN6FRhDdpj2ITtSWaJ2QMx/EIEMuPL2sRUHrudbv1eRuoJjLPSnBBebQMbPeySr
 N0WQS2LKPIvzrglPej72K8KjPWtM2hQ/luk1oTg==
X-Gm-Gg: ASbGncu0zQYVdcNcUMuyvrKTi+0wwfVaIWTNAC2zPmpA733SHgz3Ps9itNoOevok4Dj
 qhA+exGYJrxReKM/bx7tNDDh2qKMe1Yur
X-Google-Smtp-Source: AGHT+IE9yuQ15jSycnqCz+XaDKN9D+7vMeUTpWFyg8Ejbr0lYjuZS+3ezEkMvmvgxdGIEg3ZSBaf8uNq9vIBlUEHfr4=
X-Received: by 2002:a5d:5f54:0:b0:382:46ea:1113 with SMTP id
 ffacd0b85a97d-385c6ccaf4bmr12292196f8f.4.1732899722636; Fri, 29 Nov 2024
 09:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20241127170143.1664829-1-alex.bennee@linaro.org>
In-Reply-To: <20241127170143.1664829-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2024 17:01:51 +0000
Message-ID: <CAFEAcA-xFF1dEE=8dpfu2COBH9m0J_MWxworYqSk2hOf2KD2bw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: implement SEL2 physical and virtual timers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Andrei Homescu <ahomescu@google.com>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>, 
 =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi.denis.courmont@huawei.com>, 
 "open list:Virt" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 27 Nov 2024 at 17:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
> shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
> actual implementation utilises the same logic as the rest of the
> timers so all we need to do is:
>
>   - define the timers and their access functions
>   - conditionally add the correct system registers
>   - create a new accessfn as the rules are subtly different to the
>     existing secure timer
>
> Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Andrei Homescu <ahomescu@google.com>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
> Cc: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  include/hw/arm/bsa.h |   2 +
>  target/arm/cpu.h     |   2 +
>  target/arm/gtimer.h  |   4 +-
>  hw/arm/virt.c        |   2 +
>  target/arm/cpu.c     |   8 +++
>  target/arm/helper.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 172 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
> index 8eaab603c0..b4ecca1b1c 100644
> --- a/include/hw/arm/bsa.h
> +++ b/include/hw/arm/bsa.h
> @@ -22,6 +22,8 @@
>  #define QEMU_ARM_BSA_H
>
>  /* These are architectural INTID values */
> +#define ARCH_TIMER_S_VIRT_EL2_IRQ  19
> +#define ARCH_TIMER_S_EL2_IRQ       20
>  #define VIRTUAL_PMU_IRQ            23
>  #define ARCH_GIC_MAINT_IRQ         25
>  #define ARCH_TIMER_NS_EL2_IRQ      26
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d86e641280..10b5354d6f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1139,6 +1139,8 @@ void arm_gt_vtimer_cb(void *opaque);
>  void arm_gt_htimer_cb(void *opaque);
>  void arm_gt_stimer_cb(void *opaque);
>  void arm_gt_hvtimer_cb(void *opaque);
> +void arm_gt_sel2timer_cb(void *opaque);
> +void arm_gt_sel2vtimer_cb(void *opaque);
>
>  unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
>  void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
> diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
> index b992941bef..3c097c59c7 100644
> --- a/target/arm/gtimer.h
> +++ b/target/arm/gtimer.h
> @@ -15,7 +15,9 @@ enum {
>      GTIMER_HYP      =3D 2,
>      GTIMER_SEC      =3D 3,
>      GTIMER_HYPVIRT  =3D 4,
> -#define NUM_GTIMERS   5
> +    GTIMER_SEC_PEL2 =3D 5,
> +    GTIMER_SEC_VEL2 =3D 6,
> +#define NUM_GTIMERS   7

Maybe we should add comments to this enum giving the architectural
names of these timers?

    GTIMER_PHYS     =3D 0, /* EL1 physical timer */
    GTIMER_VIRT     =3D 1, /* EL1 virtual timer */
    GTIMER_HYP      =3D 2, /* EL2 physical timer */
    GTIMER_SEC      =3D 3, /* EL3 physical timer */
    GTIMER_HYPVIRT  =3D 4, /* EL2 virtual timer */
    GTIMER_SEC_PEL2 =3D 5, /* Secure EL2 physical timer */
    GTIMER_SEC_VEL2 =3D 6, /* Secure EL2 virtual timer */

>  };
>
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1a381e9a2b..451d154459 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryR=
egion *mem)
>              [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>              [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>              [GTIMER_HYPVIRT] =3D ARCH_TIMER_NS_EL2_VIRT_IRQ,
> +            [GTIMER_SEC_PEL2] =3D ARCH_TIMER_S_EL2_IRQ,
> +            [GTIMER_SEC_VEL2] =3D ARCH_TIMER_S_VIRT_EL2_IRQ,
>          };
>
>          for (unsigned irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {

We probably need to also update at least sbsa-ref for this new
pair of interrupts, and perhaps others (if they allow CPUs
with FEAT_SEL2).

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 6938161b95..e42ab8ce8b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2078,6 +2078,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>                                                arm_gt_stimer_cb, cpu);
>          cpu->gt_timer[GTIMER_HYPVIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL, =
scale,
>                                                    arm_gt_hvtimer_cb, cpu=
);
> +
> +        /* FEAT_SEL2 also has physical and virtual timers */
> +        if (cpu_isar_feature(aa64_sel2, cpu)) {
> +            cpu->gt_timer[GTIMER_SEC_PEL2] =3D timer_new(QEMU_CLOCK_VIRT=
UAL, scale,
> +                                                       arm_gt_sel2timer_=
cb, cpu);
> +            cpu->gt_timer[GTIMER_SEC_VEL2] =3D timer_new(QEMU_CLOCK_VIRT=
UAL, scale,
> +                                                       arm_gt_sel2vtimer=
_cb, cpu);
> +        }

We create all the other gt_timer[] entries regardless of whether the
feature that uses them exists, and I think we should do the same
here. It's pretty harmless and it means code elsewhere doesn't
have to be super-careful about "is cpu->gt_timer[n] valid or is
it zeroed out memory?".

>      }
>  #endif
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f38eb054c0..b5a8a5846e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2668,6 +2668,41 @@ static CPAccessResult gt_stimer_access(CPUARMState=
 *env,
>      }
>  }
>
> +static CPAccessResult gt_sel2timer_access(CPUARMState *env,
> +                                          const ARMCPRegInfo *ri,
> +                                          bool isread)
> +{
> +    /*
> +     * The AArch64 register view of the secure EL2 timers are mostly
> +     * accessible from EL3 and EL2 although can also be trapped to EL2
> +     * from EL1 depending on nested virt config.
> +     */
> +    switch (arm_current_el(env)) {
> +    case 0:
> +        return CP_ACCESS_TRAP;
> +    case 1:
> +        if (!arm_is_secure(env)) {
> +            return CP_ACCESS_TRAP;
> +        } else if (arm_hcr_el2_eff(env) & HCR_NV) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +        return CP_ACCESS_TRAP;
> +    case 2:
> +        if (!arm_is_secure(env)) {
> +            return CP_ACCESS_TRAP;
> +        }
> +        return CP_ACCESS_OK;
> +    case 3:
> +        if (env->cp15.scr_el3 & SCR_EEL2) {
> +            return CP_ACCESS_OK;
> +        } else {
> +            return CP_ACCESS_TRAP;
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  uint64_t gt_get_countervalue(CPUARMState *env)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
> @@ -3175,6 +3210,62 @@ static void gt_sec_ctl_write(CPUARMState *env, con=
st ARMCPRegInfo *ri,
>      gt_ctl_write(env, ri, GTIMER_SEC, value);
>  }
>
> +static void gt_sec_pel2_timer_reset(CPUARMState *env, const ARMCPRegInfo=
 *ri)
> +{
> +    gt_timer_reset(env, ri, GTIMER_SEC_PEL2);
> +}
> +
> +static void gt_sec_pel2_cval_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> +                                   uint64_t value)
> +{
> +    gt_cval_write(env, ri, GTIMER_SEC_PEL2, value);
> +}
> +
> +static uint64_t gt_sec_pel2_tval_read(CPUARMState *env, const ARMCPRegIn=
fo *ri)
> +{
> +    return gt_tval_read(env, ri, GTIMER_SEC_PEL2);
> +}
> +
> +static void gt_sec_pel2_tval_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> +                              uint64_t value)
> +{
> +    gt_tval_write(env, ri, GTIMER_SEC_PEL2, value);
> +}

gt_tval_read() and gt_tval_write() have a switch which
determines whether they obey the physical offset (CNTPOFF_EL2)
or the virtual offset (CNTVOFF_EL2) or neither. For GTIMER_SEC_PEL2
the correct answer is "neither", which is what you get by default,
but for GTIMER_SEC_VEL2 we should be honouring CNTVOFF_EL2,
so you need to add a case to the switch for that.

We also need to fix a pre-existing bug in gt_recalc_timer(),
which does
        uint64_t offset =3D timeridx =3D=3D GTIMER_VIRT ?
            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
and so fails to include CNTVOFF_EL2 when working with
GTIMER_HYPVIRT; then you can also add GTIMER_SEC_VEL2 to that.

> +
> +static void gt_sec_pel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> +                              uint64_t value)
> +{
> +    gt_ctl_write(env, ri, GTIMER_SEC_PEL2, value);
> +}
> +
> +static void gt_sec_vel2_timer_reset(CPUARMState *env, const ARMCPRegInfo=
 *ri)
> +{
> +    gt_timer_reset(env, ri, GTIMER_SEC_VEL2);
> +}
> +
> +static void gt_sec_vel2_cval_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> +                              uint64_t value)
> +{
> +    gt_cval_write(env, ri, GTIMER_SEC_VEL2, value);
> +}
> +
> +static uint64_t gt_sec_vel2_tval_read(CPUARMState *env, const ARMCPRegIn=
fo *ri)
> +{
> +    return gt_tval_read(env, ri, GTIMER_SEC_VEL2);
> +}
> +
> +static void gt_sec_vel2_tval_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> +                                   uint64_t value)
> +{
> +    gt_tval_write(env, ri, GTIMER_SEC_VEL2, value);
> +}
> +
> +static void gt_sec_vel2_ctl_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> +                              uint64_t value)
> +{
> +    gt_ctl_write(env, ri, GTIMER_SEC_VEL2, value);
> +}
> +
>  static void gt_hv_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      gt_timer_reset(env, ri, GTIMER_HYPVIRT);
> @@ -3231,6 +3322,20 @@ void arm_gt_stimer_cb(void *opaque)
>      gt_recalc_timer(cpu, GTIMER_SEC);
>  }
>
> +void arm_gt_sel2timer_cb(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    gt_recalc_timer(cpu, GTIMER_SEC_PEL2);
> +}
> +
> +void arm_gt_sel2vtimer_cb(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    gt_recalc_timer(cpu, GTIMER_SEC_VEL2);
> +}
> +
>  void arm_gt_hvtimer_cb(void *opaque)
>  {
>      ARMCPU *cpu =3D opaque;
> @@ -6613,6 +6718,56 @@ static const ARMCPRegInfo el2_sec_cp_reginfo[] =3D=
 {
>        .access =3D PL2_RW, .accessfn =3D sel2_access,
>        .nv2_redirect_offset =3D 0x48,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.vstcr_el2) },
> +#ifndef CONFIG_USER_ONLY
> +    /* Secure EL2 Physical Timer */
> +    { .name =3D "CNTHPS_TVAL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 5, .opc2 =3D 0,
> +      .type =3D ARM_CP_NO_RAW | ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .readfn =3D gt_sec_pel2_tval_read,
> +      .writefn =3D gt_sec_pel2_tval_write,
> +      .resetfn =3D gt_sec_pel2_timer_reset,
> +    },
> +    { .name =3D "CNTHPS_CTL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 5, .opc2 =3D 1,
> +      .type =3D ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .fieldoffset =3D offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_P=
EL2].ctl),
> +      .resetvalue =3D 0,
> +      .writefn =3D gt_sec_pel2_ctl_write, .raw_writefn =3D raw_write,
> +    },
> +    { .name =3D "CNTHPS_CVAL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 5, .opc2 =3D 2,
> +      .type =3D ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .fieldoffset =3D offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_P=
EL2].cval),
> +      .writefn =3D gt_sec_pel2_cval_write, .raw_writefn =3D raw_write,
> +    },
> +    /* Secure EL2 Virtual Timer */
> +    { .name =3D "CNTHVS_TVAL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 4, .opc2 =3D 0,
> +      .type =3D ARM_CP_NO_RAW | ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .readfn =3D gt_sec_vel2_tval_read,
> +      .writefn =3D gt_sec_vel2_tval_write,
> +      .resetfn =3D gt_sec_vel2_timer_reset,
> +    },
> +    { .name =3D "CNTHVS_CTL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 4, .opc2 =3D 1,
> +      .type =3D ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .fieldoffset =3D offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_V=
EL2].ctl),
> +      .resetvalue =3D 0,
> +      .writefn =3D gt_sec_vel2_ctl_write, .raw_writefn =3D raw_write,
> +    },
> +    { .name =3D "CNTHVS_CVAL_EL2", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 14, .crm =3D 4, .opc2 =3D 2,
> +      .type =3D ARM_CP_IO, .access =3D PL2_RW,
> +      .accessfn =3D gt_sel2timer_access,
> +      .fieldoffset =3D offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC_V=
EL2].cval),
> +      .writefn =3D gt_sec_vel2_cval_write, .raw_writefn =3D raw_write,
> +    },
> +#endif
>  };

thanks
-- PMM

