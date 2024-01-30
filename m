Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6D0C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 14:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUomM-00033k-9P; Tue, 30 Jan 2024 09:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUomK-00031b-NB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:07:56 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUomI-0005Yn-Eh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:07:56 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d911dac3dcso3389045ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706623673; x=1707228473; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWn6HVS1jzdsFr5YAvimxHBQvWBr9yrhv0FolGw2rZE=;
 b=jSNIa4QAFfwgkR2E0FSSIAwdiz2qDWAaFx79kDLxj8ALbITI1+1/rygiqjgSM3g4D8
 gKGU0K3dZlr19QKoo8p0XQz5EiTGBxTC9aMjogZKm5KpQlaAaukZAS//E31rBQeLo4eE
 ITuIg6MU+7zLLSWk5yehT6k70HcMW+3ZzH1UeUmGiP3aVs+GVClrUNqbCKmwfEfzDZf0
 am3j6VrMnPkXCAUXizfpNGi/WKHIQp87DMI951b7GtLyGIbAKuZC5SVV6cTSehg1G3nt
 oErMOdef2ON/G4hQiMGhYwcmCKJiG+pF1u+KsxZ5p/0Gsgi0Hg39MmfHornlMiAlBFYC
 pLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623673; x=1707228473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWn6HVS1jzdsFr5YAvimxHBQvWBr9yrhv0FolGw2rZE=;
 b=mb5JyW3xrB49BHaCXrfLnMW1uJFzSCGvKhSrm5lJhIgnrDG034e7fGdl6naQXRZ0kE
 Hn2IYlWHazLh9zdI6LfuWedtaeqMXvEZbRELiBKwxrHlkD/e6U7NHDRdOOG2rmUuU3Tp
 ufsXnMn9ci5I5cEmHHb0xKcIqhLcNfPSbwHIu8ZGu6ynzzP4qum6896EgIhAtYqasldd
 FZV8PXPe+6iPUHYgnEh6DudWJM3vJcVkUDgNdCKBCnVQ7SPCgbAj57nZCHX6ZCZcJQSh
 uKpKawhyvQnZGXnRDYmOOtUK9mcLWIjkMHD5HMe2gDEqw5hqcZyvqOeR7ZKfaVgyb2ve
 T1Qw==
X-Gm-Message-State: AOJu0YyHlffB0AbEcuZi1Nq8W5452TUUI4yYUkT1g0nHlGZI7GMFpMXw
 wvKt+vHv6cnYr5pj8I/gSEGSnuqPEe9kPWn78qG5MLkOYxyAb5xx2FKyTPyAvcnFba+XiDnQJ+J
 +1xAq+Xvwf/V0GT84nJWGUYFBV6mauRQ2vD5X
X-Google-Smtp-Source: AGHT+IERhZleRYPfIZc9kFFfBYhKWAqnrCM94+5VeQAPHaJYYdk7NA5EEyUeD+2s2twV+YzyGNzx2yDEXkZcxe0OR9k=
X-Received: by 2002:a17:90a:9283:b0:295:2982:2bbb with SMTP id
 n3-20020a17090a928300b0029529822bbbmr1462623pjo.24.1706623672703; Tue, 30 Jan
 2024 06:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-7-chigot@adacore.com>
 <42f8556d-a094-4448-9183-b158ac12e650@linaro.org>
In-Reply-To: <42f8556d-a094-4448-9183-b158ac12e650@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 30 Jan 2024 15:07:41 +0100
Message-ID: <CAJ307EgrGcFveMyq+HxLsOS_0VRW_q3nVu6zgknxPbBzymc=QQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] leon3: implement multiprocessor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x631.google.com
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

On Tue, Jan 30, 2024 at 12:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 16/1/24 14:02, Cl=C3=A9ment Chigot wrote:
> > This allows to register more than one CPU on the leon3_generic machine.
> >
> > Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/sparc/leon3.c | 106 +++++++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 74 insertions(+), 32 deletions(-)
> >
> > diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> > index 7866f0a049..eacd85ee4f 100644
> > --- a/hw/sparc/leon3.c
> > +++ b/hw/sparc/leon3.c
> > @@ -54,6 +54,8 @@
> >   #define LEON3_PROM_OFFSET    (0x00000000)
> >   #define LEON3_RAM_OFFSET     (0x40000000)
> >
> > +#define MAX_CPUS  4
> > +
> >   #define LEON3_UART_OFFSET  (0x80000100)
> >   #define LEON3_UART_IRQ     (3)
> >
> > @@ -67,9 +69,12 @@
> >   #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
> >
> >   typedef struct ResetData {
> > -    SPARCCPU *cpu;
> > -    uint32_t  entry;            /* save kernel entry in case of reset =
*/
> > -    target_ulong sp;            /* initial stack pointer */
> > +    struct CPUResetData {
> > +        int id;
> > +        SPARCCPU *cpu;
> > +        target_ulong sp;  /* initial stack pointer */
> > +    } info[MAX_CPUS];
> > +    uint32_t entry;             /* save kernel entry in case of reset =
*/
> >   } ResetData;
> >
> >   static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t =
val)
> > @@ -125,18 +130,19 @@ static void write_bootloader(CPUSPARCState *env, =
uint8_t *base,
> >       stl_p(p++, 0x01000000); /* nop */
> >   }
> >
> > -static void main_cpu_reset(void *opaque)
> > +static void leon3_cpu_reset(void *opaque)
> >   {
> > -    ResetData *s   =3D (ResetData *)opaque;
> > -    CPUState *cpu =3D CPU(s->cpu);
> > -    CPUSPARCState  *env =3D &s->cpu->env;
> > +    struct CPUResetData *info =3D (struct CPUResetData *) opaque;
> > +    int id =3D info->id;
> > +    ResetData *s =3D (ResetData *)DO_UPCAST(ResetData, info[id], info)=
;
> > +    CPUState *cpu =3D CPU(s->info[id].cpu);
> > +    CPUSPARCState *env =3D cpu_env(cpu);
> >
> >       cpu_reset(cpu);
> > -
> > -    cpu->halted =3D 0;
> > -    env->pc     =3D s->entry;
> > -    env->npc    =3D s->entry + 4;
> > -    env->regbase[6] =3D s->sp;
> > +    cpu->halted =3D cpu->cpu_index !=3D 0;
> > +    env->pc =3D s->entry;
> > +    env->npc =3D s->entry + 4;
> > +    env->regbase[6] =3D s->info[id].sp;
>
> You take care to initialize with different stack, ...
>
> >   }
> >
> >   static void leon3_cache_control_int(CPUSPARCState *env)
> > @@ -170,8 +176,8 @@ static void leon3_cache_control_int(CPUSPARCState *=
env)
> >
> >   static void leon3_irq_ack(CPUSPARCState *env, int intno)
> >   {
> > -    /* No SMP support yet, only CPU #0 available so far.  */
> > -    grlib_irqmp_ack(env->irq_manager, 0, intno);
> > +    CPUState *cpu =3D CPU(env_cpu(env));
> > +    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
> >   }
> >
> >   /*
> > @@ -213,6 +219,20 @@ static void leon3_set_pil_in(void *opaque, int n, =
int level)
> >       }
> >   }
> >
> > +static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data =
data)
> > +{
> > +    cpu->halted =3D 0;
> > +}
> > +
> > +static void leon3_start_cpu(void *opaque, int n, int level)
> > +{
> > +    CPUState *cs =3D CPU(opaque);
> > +
> > +    if (level) {
> > +        async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NU=
LL);
> > +    }
> > +}
> > +
> >   static void leon3_irq_manager(CPUSPARCState *env, int intno)
> >   {
> >       leon3_irq_ack(env, intno);
> > @@ -238,17 +258,21 @@ static void leon3_generic_hw_init(MachineState *m=
achine)
> >       AHBPnp *ahb_pnp;
> >       APBPnp *apb_pnp;
> >
> > -    /* Init CPU */
> > -    cpu =3D SPARC_CPU(cpu_create(machine->cpu_type));
> > -    env =3D &cpu->env;
> > +    reset_info =3D g_malloc0(sizeof(ResetData));
> >
> > -    cpu_sparc_set_id(env, 0);
> > +    for (i =3D 0; i < machine->smp.cpus; i++) {
> > +        /* Init CPU */
> > +        cpu =3D SPARC_CPU(cpu_create(machine->cpu_type));
> > +        env =3D &cpu->env;
> >
> > -    /* Reset data */
> > -    reset_info        =3D g_new0(ResetData, 1);
> > -    reset_info->cpu   =3D cpu;
> > -    reset_info->sp    =3D LEON3_RAM_OFFSET + ram_size;
> > -    qemu_register_reset(main_cpu_reset, reset_info);
> > +        cpu_sparc_set_id(env, i);
> > +
> > +        /* Reset data */
> > +        reset_info->info[i].id =3D i;
> > +        reset_info->info[i].cpu =3D cpu;
> > +        reset_info->info[i].sp =3D LEON3_RAM_OFFSET + ram_size;
>
> ... but all CPUs are initialized with the same stack. Is this
> expected?

Indeed, I've just blindly updated the existing code.
The official doc (see [1] =C2=A74.2.15) does not mention anything about SP
when a reset occurs. The program loaded should take care of their
initialization.
I'll remove that. Thanks for the notice.

[1] https://gaisler.com/doc/gr712rc-usermanual.pdf

> > +        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
> > +    }
> >
> >       ahb_pnp =3D GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
> >       sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
> > @@ -266,14 +290,28 @@ static void leon3_generic_hw_init(MachineState *m=
achine)
> >
> >       /* Allocate IRQ manager */
> >       irqmpdev =3D qdev_new(TYPE_GRLIB_IRQMP);
> > +    object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cp=
us,
> > +                            &error_fatal);
> >       sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
> > -    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
> > -                                        env, "pil", 1);
> > -    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
> > -                                qdev_get_gpio_in_named(DEVICE(cpu), "p=
il", 0));
> > +
> > +    for (i =3D 0; i < machine->smp.cpus; i++) {
> > +        cpu =3D reset_info->info[i].cpu;
> > +        env =3D &cpu->env;
> > +        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_c=
pu,
> > +                                            cpu, "start_cpu", 1);
> > +        qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
> > +                                    qdev_get_gpio_in_named(DEVICE(cpu)=
,
> > +                                                           "start_cpu"=
, 0));
> > +        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil=
_in,
> > +                                            env, "pil", 1);
> > +        qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
> > +                                    qdev_get_gpio_in_named(DEVICE(cpu)=
,
> > +                                                           "pil", 0));
> > +        env->irq_manager =3D irqmpdev;
> > +        env->qemu_irq_ack =3D leon3_irq_manager;
> > +    }
> > +
> >       sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
> > -    env->irq_manager =3D irqmpdev;
> > -    env->qemu_irq_ack =3D leon3_irq_manager;
> >       grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
> >                               GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
> >                               2, 0, GRLIB_APBIO_AREA);
> > @@ -347,10 +385,13 @@ static void leon3_generic_hw_init(MachineState *m=
achine)
> >               uint8_t *bootloader_entry;
> >
> >               bootloader_entry =3D memory_region_get_ram_ptr(prom);
> > -            write_bootloader(env, bootloader_entry, entry);
> > -            env->pc =3D LEON3_PROM_OFFSET;
> > -            env->npc =3D LEON3_PROM_OFFSET + 4;
> > +            write_bootloader(&reset_info->info[0].cpu->env, bootloader=
_entry,
> > +                             entry);
> >               reset_info->entry =3D LEON3_PROM_OFFSET;
> > +            for (i =3D 0; i < machine->smp.cpus; i++) {
> > +                reset_info->info[i].cpu->env.pc =3D LEON3_PROM_OFFSET;
> > +                reset_info->info[i].cpu->env.npc =3D LEON3_PROM_OFFSET=
 + 4;
> > +            }
> >           }
> >       }
> >
> > @@ -389,6 +430,7 @@ static void leon3_generic_machine_init(MachineClass=
 *mc)
> >       mc->init =3D leon3_generic_hw_init;
> >       mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("LEON3");
> >       mc->default_ram_id =3D "leon3.ram";
> > +    mc->max_cpus =3D MAX_CPUS;
> >   }
> >
> >   DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
>

