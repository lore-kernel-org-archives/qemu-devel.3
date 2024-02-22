Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75113C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4In-00056x-3u; Thu, 22 Feb 2024 03:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rd4Il-00056b-DP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:19:31 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rd4Ij-0000Bw-83
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:19:31 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-299b92948a6so2600622a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1708589967; x=1709194767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUNUQX84YXaR9RAgYPY4aMXTgKLnytEunHUSSy6i7OY=;
 b=SmvnuOydiYbBgVm0aYTN2Cfd7fr54Ofos76P189rdLkrbQfudCQQvh56nwL+Kf3nt6
 cttS4O0YUWDCrw3BNXlGs6CGagcFpIEa/Wqt1ORoC51mcZvnl8T+Cxtpqvf4cY6VVtcu
 /pA7HX2asb2BGZCZqS9Qfukl4kN+xAWgCIf6yhYwiq/iELBC9ABh4pPLAyFhttRQZvlD
 v7SrQlMxrQ85+1JL/Esnn6MQZHHrDIvKSHkiMMycH+MNIDm3CEUPGgXisMl2VPP43ska
 Z5vTEigRwA4cbEGDC77FciUR/qcmq/Mmr8MXcT+j7Ir7bDVb1hIThiLGyIroNuNgxaVG
 adLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708589967; x=1709194767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUNUQX84YXaR9RAgYPY4aMXTgKLnytEunHUSSy6i7OY=;
 b=HkP3F2bVAPqIGZhbi+f/+nXDz3oJqd8qU3YqTgqxAot2c/eu2LVlHcDjc+6j2Fhp2L
 n5EZlE8ntDNr9UKKe1YZKwKIz+Qtkbr8FxeNBGR2zS4X8WccOnJW5U+0Qewsk3F4NXLL
 DsQMUoDM7pMEcMUQYrM3k9Jo+vWc533fk2X9mFsGxv9caOelV2eh1MrbJZcKn0S7D28t
 TUEiHk8zNFZP/D4vbnfd0Q56eUpvUOULXHHkuh4omaTySUICa/UmvJS4/bEWgRaQzIYW
 yukxTbxIrVDZTJ8i4+okChVlSs32W2sAWRvUaRl+I6/ZgtadYCBA2oieV3jHQjidmYvo
 mhlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/CnwH10gyC+j9gmNP9NboW03XujX5dB0qUe1URmfH9FANjuENGWbFGnziVKgNyavBqobSCpltYL2GLyPHboVRHh3OwaA=
X-Gm-Message-State: AOJu0Yy7kUgenxQrMrAeobFtxMhh6NQKm3AoJ0Nrf8LpQ9cO42mQ6AI3
 vVUIij2c4JhM/DYOh0omNQNRtnm0d2qd40+1pNhjKUTFecKtXDXsKqNZoqh9I8Jr/MO6jBHwyua
 avsvd0njH3P7/WyfGsecmKqjzoBfBkuE127Go
X-Google-Smtp-Source: AGHT+IFGUutP7DcFGvS6uDfO1v+BiwwKsMjocsbuAAT8jVBST0XIHiDDr6S+MKSJOa/aDFheJ2KkRMcWwfJXi0HpEcc=
X-Received: by 2002:a17:90b:90:b0:299:5ebb:1ee0 with SMTP id
 bb16-20020a17090b009000b002995ebb1ee0mr9474890pjb.28.1708589966874; Thu, 22
 Feb 2024 00:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-4-thuth@redhat.com>
 <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
 <e38c7fa5-8dc8-4e7a-a4a9-06a88206b325@linaro.org>
In-Reply-To: <e38c7fa5-8dc8-4e7a-a4a9-06a88206b325@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 22 Feb 2024 09:19:15 +0100
Message-ID: <CAJ307EinjJNJoN3+zhWJQ8rCGY99rqRDFGFjTA1=3O+_j9XKOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] meson: Enable -Wvla
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x1036.google.com
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

On Wed, Feb 21, 2024 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/2/24 17:59, Thomas Huth wrote:
> > On 21/02/2024 17.26, Thomas Huth wrote:
> >> From: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> QEMU has historically used variable length arrays only very rarely.
> >> Variable length arrays are a potential security issue where an
> >> on-stack dynamic allocation isn't correctly size-checked, especially
> >> when the size comes from the guest.  (An example problem of this kind
> >> from the past is CVE-2021-3527).  Forbidding them entirely is a
> >> defensive measure against further bugs of this kind.
> >>
> >> Enable -Wvla to prevent any new uses from sneaking into the codebase.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> Message-ID: <20240125173211.1786196-3-peter.maydell@linaro.org>
> >> [thuth: rebased to current master branch]
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   meson.build | 1 +
> >>   1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> >> diff --git a/meson.build b/meson.build
> >> index c1dc83e4c0..0ef1654e86 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -592,6 +592,7 @@ warn_flags =3D [
> >>     '-Wstrict-prototypes',
> >>     '-Wtype-limits',
> >>     '-Wundef',
> >> +  '-Wvla',
> >>     '-Wwrite-strings',
> >>     # Then disable some undesirable warnings
> >
> > Sigh, there's a new warning in the latest master branch:
> >
> >   https://gitlab.com/thuth/qemu/-/jobs/6225992174
> >
> > Caused by commit d65aba828 ("hw/sparc/leon3: implement multiprocessor")=
...
> > Cl=C3=A9ment, Philippe, could this maybe be written in a different way =
that
> > does not trigger a -Wvla warning?
>
> Cl=C3=A9ment, ResetData::entry isn't used, so we can simplify removing
> the whole ResetData structure, but I'm not sure this is intended:

AFAICT, it used to take the kernel entry point before the bootloader
part was implemented. But I'm wondering if it could not be one of the
issues being the avocado failure. I do want to resurrect it but I
missed the time at the moment...
I'll do some testing with your patch and see how it goes anyway.

> -- >8 --
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 4873b59b6c..1ff6b5d63d 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -68,14 +68,6 @@
>   #define LEON3_APB_PNP_OFFSET (0x800FF000)
>   #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
>
> -typedef struct ResetData {
> -    struct CPUResetData {
> -        int id;
> -        SPARCCPU *cpu;
> -    } info[MAX_CPUS];
> -    uint32_t entry;             /* save kernel entry in case of reset */
> -} ResetData;
> -
>   static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t va=
l)
>   {
>       stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> @@ -148,17 +140,14 @@ static void write_bootloader(void *ptr, hwaddr
> kernel_addr)
>
>   static void leon3_cpu_reset(void *opaque)
>   {
> -    struct CPUResetData *info =3D (struct CPUResetData *) opaque;
> -    int id =3D info->id;
> -    ResetData *s =3D (ResetData *)DO_UPCAST(ResetData, info[id], info);
> -    CPUState *cpu =3D CPU(s->info[id].cpu);
> +    CPUState *cpu =3D opaque;
>       CPUSPARCState *env =3D cpu_env(cpu);
>
>       cpu_reset(cpu);
>
>       cpu->halted =3D cpu->cpu_index !=3D 0;
> -    env->pc =3D s->entry;
> -    env->npc =3D s->entry + 4;
> +    env->pc =3D LEON3_PROM_OFFSET;
> +    env->npc =3D LEON3_PROM_OFFSET + 4;
>   }
>
>   static void leon3_cache_control_int(CPUSPARCState *env)
> @@ -259,7 +248,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>       ram_addr_t ram_size =3D machine->ram_size;
>       const char *bios_name =3D machine->firmware ?: LEON3_PROM_FILENAME;
>       const char *kernel_filename =3D machine->kernel_filename;
> -    SPARCCPU *cpu;
> +    SPARCCPU *cpu[MAX_CPUS];
>       CPUSPARCState   *env;
>       MemoryRegion *address_space_mem =3D get_system_memory();
>       MemoryRegion *prom =3D g_new(MemoryRegion, 1);
> @@ -267,28 +256,22 @@ static void leon3_generic_hw_init(MachineState
> *machine)
>       char       *filename;
>       int         bios_size;
>       int         prom_size;
> -    ResetData  *reset_info;
>       DeviceState *dev, *irqmpdev;
>       int i;
>       AHBPnp *ahb_pnp;
>       APBPnp *apb_pnp;
>
> -    reset_info =3D g_malloc0(sizeof(ResetData));
> -
>       for (i =3D 0; i < machine->smp.cpus; i++) {
>           /* Init CPU */
> -        cpu =3D SPARC_CPU(object_new(machine->cpu_type));
> -        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu,
> "start_cpu", 1);
> -        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1)=
;
> -        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> -        env =3D &cpu->env;
> +        cpu[i] =3D SPARC_CPU(object_new(machine->cpu_type));
> +        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_start_cpu,
> "start_cpu", 1);
> +        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_set_pil_in,
> "pil", 1);
> +        qdev_realize(DEVICE(cpu[i]), NULL, &error_fatal);
> +        env =3D &cpu[i]->env;
>
>           cpu_sparc_set_id(env, i);
>
> -        /* Reset data */
> -        reset_info->info[i].id =3D i;
> -        reset_info->info[i].cpu =3D cpu;
> -        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
> +        qemu_register_reset(leon3_cpu_reset, cpu[i]);
>       }
>
>       ahb_pnp =3D GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
> @@ -312,13 +295,12 @@ static void leon3_generic_hw_init(MachineState
> *machine)
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
>
>       for (i =3D 0; i < machine->smp.cpus; i++) {
> -        cpu =3D reset_info->info[i].cpu;
> -        env =3D &cpu->env;
> +        env =3D &cpu[i]->env;
>           qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
> -                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                    qdev_get_gpio_in_named(DEVICE(cpu[i]=
),
>
> "start_cpu", 0));
>           qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
> -                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                    qdev_get_gpio_in_named(DEVICE(cpu[i]=
),
>                                                              "pil", 0));
>           env->irq_manager =3D irqmpdev;
>           env->qemu_irq_ack =3D leon3_irq_manager;
> @@ -396,11 +378,6 @@ static void leon3_generic_hw_init(MachineState
> *machine)
>                * bootloader.
>                */
>               write_bootloader(memory_region_get_ram_ptr(prom), entry);
> -            reset_info->entry =3D LEON3_PROM_OFFSET;
> -            for (i =3D 0; i < machine->smp.cpus; i++) {
> -                reset_info->info[i].cpu->env.pc =3D LEON3_PROM_OFFSET;
> -                reset_info->info[i].cpu->env.npc =3D LEON3_PROM_OFFSET +=
 4;
> -            }
>           }
>       }
> ---
>
> Regards,
>
> Phil.

