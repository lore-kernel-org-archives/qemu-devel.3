Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188C6C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txS9K-0006cc-Uq; Wed, 26 Mar 2025 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1txS9J-0006cS-Qe
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:54:33 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1txS9H-0001WC-QL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:54:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so959434566b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1743000870; x=1743605670; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkMoG0KkYxIKtK/KZ7iuZYasYyf1E9Eci4K7pKg4RNA=;
 b=WvEVyVZqrHzKeypZNPDpWC8mLlZ90uWIGk7L9LFKGoB4rVy5TBTt1EF12/MtGTPCKv
 5xXpHXdgIGaqjwmC0qL+prVXNDTp/COHb7/4Whne7t7lTzlXokO515Vr1f0RnmyAXqJ8
 Q0uM+16FKKiNmlyRHcaEPU4A/zdGirUSBpjQL92689NOc97hf75GUegNIsY0K2ZcODLs
 PF676wN2G1LAq2HOyevz25ZO19CKLh0iEv7iRhCBQ5l6cHOGE7VAOJA4B4VwAXaUH1+I
 1FbiAlx/kgPHhD+/6jBlNZGHaj8OvbVcwSH5qDyMIS1Sv5OQIW1WtNumNWNJPqJuObbP
 UYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743000870; x=1743605670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkMoG0KkYxIKtK/KZ7iuZYasYyf1E9Eci4K7pKg4RNA=;
 b=AoYP61VIr6Agth+XWea0xPy7dI2Y8OSzAXyFAqHaloDpuSxNm4d3vwX1IGkz3pWQD0
 9FliF2Ij9m7tkq/Xzvp1HabscyQifiYuyYyEHaiP49t2KsTPyTGVPfv6JInmNq8U7Er0
 QzD3xCrC5j2G7A0l00bFpwuCeY6VgX6QjxKYDnxvmeMc8PjHxxnVyrD+DyYYokteblr3
 mOcxgzoOouSbfFjb3VF/KCgcc8q+2JjjVuJoaVwjgBvM2pdzGFipUa0X1t8iqLI7J5u1
 7dgZ5PErXjKsrhpm6ahXAMRXk8RFcrEkPZjQZJGq9nxUtahbcrHV0s6sOvwlF+OgZKRr
 Cplg==
X-Gm-Message-State: AOJu0YwMYUEx/XFmMC3Y1U/jBdapX/nq90RpvtLkmhMU4oH1I4GPyInp
 DHi2fW5OZcDmmUMYcy18NQtu2FcW2oujCQIMvhVxDVniijsAhGEZMkqyr/YG87LxdVSkfzLeclS
 gNweC8tsvpais/SE05BUcaLjZs3i9J8re4pBC
X-Gm-Gg: ASbGncsrKSP1Jioqe/E++jceV3eNdA5axLNVBVVhhaYIOLPG2wVs/LQO8gYfjYQFijO
 hTFmsQmR+yMKP7Ok7cXaF2140hn5RYCMj+OIkTFKvPz+9uOinr2k9PBdW9/XvC/dOC3StMg9pvM
 U1NRPw4X1xZ22iyFpMAU4VT2CwCg==
X-Google-Smtp-Source: AGHT+IGXMU+uHcUzce2WcmYXIR1CNWWZ+jwHOzsJBJtVCqaWe5fSeZ3LgKjcXOVvgRHQoWscc9GmViVA29UVSNPDibM=
X-Received: by 2002:a17:907:bc8b:b0:ac2:1c64:b26 with SMTP id
 a640c23a62f3a-ac3f2267561mr2097593566b.32.1743000869251; Wed, 26 Mar 2025
 07:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-5-philmd@linaro.org>
In-Reply-To: <20250325123927.74939-5-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 26 Mar 2025 15:54:16 +0100
X-Gm-Features: AQ5f1JqmPLWuH5IVSowOg1unjDn-gPB1_wUbyfw_XD-YNgtENiEQyE7lpz-47As
Message-ID: <CAJ307EinbLm9yNPHrJgHFr3DjR_byKcw_uq5MbYQ6xNSGAJmEQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 4/4] target/sparc: Move hardware fields from
 CPUSPARCState to SPARCCPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x62f.google.com
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

Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>


On Tue, Mar 25, 2025 at 1:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Keep CPUSPARCState for architectural fields, move Leon3
> hardware specific fields to SPARCCPU.
>
> Reset the Leon3 specific 'cache_control' field in
> leon3_cpu_reset() instead of sparc_cpu_reset_hold().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/sparc/cpu.h          | 10 +++++-----
>  hw/sparc/leon3.c            | 35 ++++++++++++++++++-----------------
>  target/sparc/cpu.c          |  1 -
>  target/sparc/int32_helper.c |  8 ++++++--
>  target/sparc/ldst_helper.c  | 12 ++++++------
>  5 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 462bcb6c0e6..abb71c314dc 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -543,11 +543,6 @@ struct CPUArchState {
>  #define SOFTINT_REG_MASK (SOFTINT_STIMER|SOFTINT_INTRMASK|SOFTINT_TIMER)
>  #endif
>      sparc_def_t def;
> -
> -    /* Leon3 */
> -    DeviceState *irq_manager;
> -    void (*qemu_irq_ack)(CPUSPARCState *env, int intno);
> -    uint32_t cache_control;
>  };
>
>  /**
> @@ -560,6 +555,11 @@ struct ArchCPU {
>      CPUState parent_obj;
>
>      CPUSPARCState env;
> +
> +    /* Leon3 */
> +    DeviceState *irq_manager;
> +    void (*qemu_irq_ack)(SPARCCPU *cpu, int intno);
> +    uint32_t cache_control;
>  };
>
>  /**
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 0aeaad3becc..06966861744 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -152,6 +152,7 @@ static void leon3_cpu_reset(void *opaque)
>      int id =3D info->id;
>      ResetData *s =3D container_of(info, ResetData, info[id]);
>      CPUState *cpu =3D CPU(s->info[id].cpu);
> +    SPARCCPU *scpu =3D SPARC_CPU(cpu);
>      CPUSPARCState *env =3D cpu_env(cpu);
>
>      cpu_reset(cpu);
> @@ -159,41 +160,41 @@ static void leon3_cpu_reset(void *opaque)
>      cpu->halted =3D cpu->cpu_index !=3D 0;
>      env->pc =3D s->entry;
>      env->npc =3D s->entry + 4;
> +    scpu->cache_control =3D 0;
>  }
>
> -static void leon3_cache_control_int(CPUSPARCState *env)
> +static void leon3_cache_control_int(SPARCCPU *cpu)
>  {
>      uint32_t state =3D 0;
>
> -    if (env->cache_control & CACHE_CTRL_IF) {
> +    if (cpu->cache_control & CACHE_CTRL_IF) {
>          /* Instruction cache state */
> -        state =3D env->cache_control & CACHE_STATE_MASK;
> +        state =3D cpu->cache_control & CACHE_STATE_MASK;
>          if (state =3D=3D CACHE_ENABLED) {
>              state =3D CACHE_FROZEN;
>              trace_int_helper_icache_freeze();
>          }
>
> -        env->cache_control &=3D ~CACHE_STATE_MASK;
> -        env->cache_control |=3D state;
> +        cpu->cache_control &=3D ~CACHE_STATE_MASK;
> +        cpu->cache_control |=3D state;
>      }
>
> -    if (env->cache_control & CACHE_CTRL_DF) {
> +    if (cpu->cache_control & CACHE_CTRL_DF) {
>          /* Data cache state */
> -        state =3D (env->cache_control >> 2) & CACHE_STATE_MASK;
> +        state =3D (cpu->cache_control >> 2) & CACHE_STATE_MASK;
>          if (state =3D=3D CACHE_ENABLED) {
>              state =3D CACHE_FROZEN;
>              trace_int_helper_dcache_freeze();
>          }
>
> -        env->cache_control &=3D ~(CACHE_STATE_MASK << 2);
> -        env->cache_control |=3D (state << 2);
> +        cpu->cache_control &=3D ~(CACHE_STATE_MASK << 2);
> +        cpu->cache_control |=3D (state << 2);
>      }
>  }
>
> -static void leon3_irq_ack(CPUSPARCState *env, int intno)
> +static void leon3_irq_ack(SPARCCPU *cpu, int intno)
>  {
> -    CPUState *cpu =3D CPU(env_cpu(env));
> -    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
> +    grlib_irqmp_ack(cpu->irq_manager, CPU(cpu)->cpu_index, intno);
>  }
>
>  /*
> @@ -248,10 +249,10 @@ static void leon3_start_cpu(void *opaque, int n, in=
t level)
>      async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
>  }
>
> -static void leon3_irq_manager(CPUSPARCState *env, int intno)
> +static void leon3_irq_manager(SPARCCPU *cpu, int intno)
>  {
> -    leon3_irq_ack(env, intno);
> -    leon3_cache_control_int(env);
> +    leon3_irq_ack(cpu, intno);
> +    leon3_cache_control_int(cpu);
>  }
>
>  static void leon3_generic_hw_init(MachineState *machine)
> @@ -320,8 +321,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>          qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
>                                      qdev_get_gpio_in_named(DEVICE(cpu),
>                                                             "pil", 0));
> -        env->irq_manager =3D irqmpdev;
> -        env->qemu_irq_ack =3D leon3_irq_manager;
> +        cpu->irq_manager =3D irqmpdev;
> +        cpu->qemu_irq_ack =3D leon3_irq_manager;
>      }
>
>      sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 37406227cb7..d62ad6c4db2 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -78,7 +78,6 @@ static void sparc_cpu_reset_hold(Object *obj, ResetType=
 type)
>      env->pc =3D 0;
>      env->npc =3D env->pc + 4;
>  #endif
> -    env->cache_control =3D 0;
>      cpu_put_fsr(env, 0);
>  }
>
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index f0266061023..a902702559d 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -168,8 +168,12 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>
>  #if !defined(CONFIG_USER_ONLY)
>      /* IRQ acknowledgment */
> -    if ((intno & ~15) =3D=3D TT_EXTINT && env->qemu_irq_ack !=3D NULL) {
> -        env->qemu_irq_ack(env, intno);
> +    if ((intno & ~15) =3D=3D TT_EXTINT) {
> +        SPARCCPU *cpu =3D env_archcpu(env);
> +
> +        if (cpu->qemu_irq_ack !=3D NULL) {
> +            cpu->qemu_irq_ack(cpu, intno);
> +        }
>      }
>  #endif
>  }
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index d4de32d3c48..0a11360ccaf 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -513,7 +513,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwadd=
r addr,
>
>  /* Leon3 cache control */
>
> -static void leon3_cache_control_st(CPUSPARCState *env, target_ulong addr=
,
> +static void leon3_cache_control_st(SPARCCPU *cpu, target_ulong addr,
>                                     uint64_t val, int size)
>  {
>      DPRINTF_CACHE_CONTROL("st addr:%08x, val:%" PRIx64 ", size:%d\n",
> @@ -534,7 +534,7 @@ static void leon3_cache_control_st(CPUSPARCState *env=
, target_ulong addr,
>          val &=3D ~CACHE_CTRL_IP;
>          val &=3D ~CACHE_CTRL_DP;
>
> -        env->cache_control =3D val;
> +        cpu->cache_control =3D val;
>          break;
>      case 0x04:              /* Instruction cache configuration */
>      case 0x08:              /* Data cache configuration */
> @@ -546,7 +546,7 @@ static void leon3_cache_control_st(CPUSPARCState *env=
, target_ulong addr,
>      };
>  }
>
> -static uint64_t leon3_cache_control_ld(CPUSPARCState *env, target_ulong =
addr,
> +static uint64_t leon3_cache_control_ld(SPARCCPU *cpu, target_ulong addr,
>                                         int size)
>  {
>      uint64_t ret =3D 0;
> @@ -558,7 +558,7 @@ static uint64_t leon3_cache_control_ld(CPUSPARCState =
*env, target_ulong addr,
>
>      switch (addr) {
>      case 0x00:              /* Cache control */
> -        ret =3D env->cache_control;
> +        ret =3D cpu->cache_control;
>          break;
>
>          /* Configuration registers are read and only always keep those
> @@ -599,7 +599,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulo=
ng addr,
>          case 0x08:          /* Leon3 Instruction Cache config */
>          case 0x0C:          /* Leon3 Date Cache config */
>              if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
> -                ret =3D leon3_cache_control_ld(env, addr, size);
> +                ret =3D leon3_cache_control_ld(env_archcpu(env), addr, s=
ize);
>              } else {
>                  qemu_log_mask(LOG_UNIMP,
>                                "%08x: unimplemented access size: %d\n", a=
ddr,
> @@ -819,7 +819,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>          case 0x08:          /* Leon3 Instruction Cache config */
>          case 0x0C:          /* Leon3 Date Cache config */
>              if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
> -                leon3_cache_control_st(env, addr, val, size);
> +                leon3_cache_control_st(env_archcpu(env), addr, val, size=
);
>              } else {
>                  qemu_log_mask(LOG_UNIMP,
>                                "%08x: unimplemented access size: %d\n", a=
ddr,
> --
> 2.47.1
>

