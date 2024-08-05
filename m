Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501AAC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 02:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sanHE-00022P-3v; Sun, 04 Aug 2024 22:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sanHC-0001zJ-77; Sun, 04 Aug 2024 22:16:46 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sanH9-0000Cg-Tx; Sun, 04 Aug 2024 22:16:45 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48ffdfae096so1017680137.0; 
 Sun, 04 Aug 2024 19:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722824202; x=1723429002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWOlq7VJ8Grt7xT6U8tb0YAZ5Qxtd9rebMW1NB0h13c=;
 b=Dd9wZog0cW6ex6p3Gl9wjGiiqLMearo14DIuEYOXsmve6L/CCXUTAmiYMgwE6mGLTz
 /bIsuPRb/5TL4oB/EFFR6DPypgBmp7GG8PYE0DlT5Ea/Ch6LNhT8Pkcq4ApHaoOphNV6
 /8pjjwfUiI1vjYiYWB/Hm+Q65L4CBrcUWQJ76kWudPppUjBxB2tG6nuU9vq6ZWy4+lAC
 fs6OWd/nchr59ubZEHlXa4gfvV9j+Mgfb8efVMc0FPEeCIJjA6s8Gb/ErEpDaS6IpmnU
 adqr4qJB6sqseB6GsSsTric/qanuQJzPrTfeWQKr3BO2ruPBV+HFclwjrKSVH+ucOzqQ
 RRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722824202; x=1723429002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWOlq7VJ8Grt7xT6U8tb0YAZ5Qxtd9rebMW1NB0h13c=;
 b=KIXsqtnxXXObmEtUFVDC6Qa47Ne7R+WrmBnDBUAyNT88NqhaHJQ3lh/P8judG/FUia
 B6eX6N1f2p9riGj9E4GBghtH0s0MO+1sr4lVm9jJOGv9GfLzZwJyjw9GYG+wiO/Heh7I
 GxvqpprtSjccdWpwc73AGnWU6STw+PJ3OoxBNUqGGl5ufo8ysV8j99lnHFTsfRLZnL1k
 XCxeUhvZ+J5z9+y1aqj9U9lAHxkiHHLPAv8Ttqzv9iCW3ik9UdGZ3kiEU8LfUcIFo0UW
 wICn01Qj2CVUctf3iUvKnhLUTsNcrn5oRXtNxvzCrztC720y+uit08q4jkQGS5iLDw1k
 E41A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/quOfgxqLI7QUsv7yo+oSAFU4WNYjzZ1KH/d/BTtR4zcl2uqla4Gr6xAimE1tdWDVx9dP9EV2MVLYrNiyQjeNTvx5tllxr7Nx86I6QUqibskd8D8ClJ2jgA9DIQ==
X-Gm-Message-State: AOJu0YyWchCgo8wX7Ns2/jqeCNIWrcXdlLWGBI6T8JfAdfrz51E9KuIA
 wCjHAa22CfOYe+eu3msD/Nkq6HmRJ9ptl3Uz/q5LKzPu5o6AoNZna/hAkMxMUyNQau+Ikcj+uyV
 ruN3d87kGjlaRylVWX0+A1PGio8PIWmcEjlQ=
X-Google-Smtp-Source: AGHT+IFLJgzv30VKyksZXoK1d+YgcP+ryhc5g+9K47rgOGTf/KfcYOsOOe/3hCtSzU6IxY5irNOkE4tveWxJOYEjO2s=
X-Received: by 2002:a05:6102:3592:b0:493:c261:1a7a with SMTP id
 ada2fe7eead31-4945bbf8f88mr7942856137.0.1722824202442; Sun, 04 Aug 2024
 19:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240727042758.2341031-1-alvinga@andestech.com>
 <0b70d915-2662-479c-bfc4-61f39d57b7bf@linux.alibaba.com>
 <SEYPR03MB670094F09BB2737B058DACCFA8B72@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <ccc48bff-b7e5-4399-805d-b4599ba90616@linux.alibaba.com>
In-Reply-To: <ccc48bff-b7e5-4399-805d-b4599ba90616@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 12:16:16 +1000
Message-ID: <CAKmqyKOR4nPEyPppLcquj7Wkdd=_+eMFgQOsuw5kFAgXE6us4Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Remove riscv_cpu_claim_interrupts()
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jul 29, 2024 at 5:52=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
>
> On 2024/7/29 14:07, Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) wro=
te:
> > Hi Zhiwei,
> >
> >> -----Original Message-----
> >> From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> >> Sent: Monday, July 29, 2024 1:47 PM
> >> To: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andeste=
ch.com>;
> >> qemu-riscv@nongnu.org; qemu-devel@nongnu.org
> >> Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
> >> liwei1518@gmail.com; dbarboza@ventanamicro.com
> >> Subject: Re: [PATCH] RISC-V: Remove riscv_cpu_claim_interrupts()
> >>
> >> [EXTERNAL MAIL]
> >>
> >> On 2024/7/27 12:27, Alvin Chang wrote:
> >>> The function of riscv_cpu_claim_interrupts() was introduced in commit
> >>> e3e7039 ("RISC-V: Allow interrupt controllers to claim interrupts") t=
o
> >>> enforce hardware controlled of SEIP signal when there is an attached
> >>> external interrupt controller.
> >>>
> >>> In later RISC-V privileged specification version 1.10, SEIP became
> >>> software-writable, even if there is an attached external interrupt
> >>> controller. Thus, the commit 33fe584 ("target/riscv: Allow software
> >>> access to MIP SEIP") was introduced to remove that limitation, and it
> >>> also removed the usage of "miclaim" mask.
> >>>
> >>> It seems the function of riscv_cpu_claim_interrupts() is no longer us=
ed.
> >>> Therefore, we remove it in this commit.
> >> As MTIP/MSIP/MEIP in mip are still read-only fields in mip. I think we=
 should
> >> not remove it.
> > IIUC, riscv_cpu_claim_interrupts() was used to achieve exclusive contro=
l between external interrupt controller and software.
> It still  can be used as an exclusive check. For example, two interrupt
> controllers try to bind the same MEIP field.

Exactly, that's what riscv_cpu_claim_interrupts() is doing. It's
checking to ensure that multiple interrupt controllers don't bind to
the same MIP field.

So the function is still used.

I think we could debate if we need it or not. I do think it's probably
worth keeping as it doesn't really cost us anything and it might help
catch setup issues.

Alistair

> > It is not used to check the read-only fields such as MTIP/MSIP/MEIP in =
mip.
> Once it was.
> > Moreover, env->miclaim is no longer used in latest code.
> Yes, we don't need it any more. When you remove it,   upgrade the
> version number in machine.c is necessary.
> >
> >> Perhaps we should  add an assert for read-only fields for this functio=
n.
> > I agree. Maybe we can add relevant assertions for those fields in rmw_m=
ip64() ?
>
> Just make them readable by adding a write mask for them.
>
> Thanks,
> Zhiwei
>
> >
> >
> > Best regards,
> > Alvin
> >
> >> Thanks,
> >> Zhiwei
> >>
> >>> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> >>> ---
> >>>    hw/intc/riscv_aclint.c    | 20 --------------------
> >>>    hw/intc/riscv_aplic.c     | 11 -----------
> >>>    hw/intc/riscv_imsic.c     |  8 --------
> >>>    hw/intc/sifive_plic.c     | 15 ---------------
> >>>    target/riscv/cpu.c        |  1 -
> >>>    target/riscv/cpu.h        |  3 ---
> >>>    target/riscv/cpu_helper.c | 11 -----------
> >>>    target/riscv/machine.c    |  1 -
> >>>    8 files changed, 70 deletions(-)
> >>>
> >>> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c index
> >>> e9f0536b1c..54cf69dada 100644
> >>> --- a/hw/intc/riscv_aclint.c
> >>> +++ b/hw/intc/riscv_aclint.c
> >>> @@ -280,7 +280,6 @@ static Property riscv_aclint_mtimer_properties[] =
=3D {
> >>>    static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **=
errp)
> >>>    {
> >>>        RISCVAclintMTimerState *s =3D RISCV_ACLINT_MTIMER(dev);
> >>> -    int i;
> >>>
> >>>        memory_region_init_io(&s->mmio, OBJECT(dev),
> >> &riscv_aclint_mtimer_ops,
> >>>                              s, TYPE_RISCV_ACLINT_MTIMER,
> >>> s->aperture_size); @@ -291,14 +290,6 @@ static void
> >>> riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
> >>>
> >>>        s->timers =3D g_new0(QEMUTimer *, s->num_harts);
> >>>        s->timecmp =3D g_new0(uint64_t, s->num_harts);
> >>> -    /* Claim timer interrupt bits */
> >>> -    for (i =3D 0; i < s->num_harts; i++) {
> >>> -        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + =
i));
> >>> -        if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
> >>> -            error_report("MTIP already claimed");
> >>> -            exit(1);
> >>> -        }
> >>> -    }
> >>>    }
> >>>
> >>>    static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType
> >>> type) @@ -472,7 +463,6 @@ static Property riscv_aclint_swi_properties=
[] =3D {
> >>>    static void riscv_aclint_swi_realize(DeviceState *dev, Error **err=
p)
> >>>    {
> >>>        RISCVAclintSwiState *swi =3D RISCV_ACLINT_SWI(dev);
> >>> -    int i;
> >>>
> >>>        memory_region_init_io(&swi->mmio, OBJECT(dev),
> >> &riscv_aclint_swi_ops, swi,
> >>>                              TYPE_RISCV_ACLINT_SWI,
> >>> RISCV_ACLINT_SWI_SIZE); @@ -480,16 +470,6 @@ static void
> >>> riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
> >>>
> >>>        swi->soft_irqs =3D g_new(qemu_irq, swi->num_harts);
> >>>        qdev_init_gpio_out(dev, swi->soft_irqs, swi->num_harts);
> >>> -
> >>> -    /* Claim software interrupt bits */
> >>> -    for (i =3D 0; i < swi->num_harts; i++) {
> >>> -        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base +
> >> i));
> >>> -        /* We don't claim mip.SSIP because it is writable by softwar=
e */
> >>> -        if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP=
) < 0)
> >> {
> >>> -            error_report("MSIP already claimed");
> >>> -            exit(1);
> >>> -        }
> >>> -    }
> >>>    }
> >>>
> >>>    static void riscv_aclint_swi_reset_enter(Object *obj, ResetType
> >>> type) diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c inde=
x
> >>> 32edd6d07b..cde8337542 100644
> >>> --- a/hw/intc/riscv_aplic.c
> >>> +++ b/hw/intc/riscv_aplic.c
> >>> @@ -873,17 +873,6 @@ static void riscv_aplic_realize(DeviceState *dev=
,
> >> Error **errp)
> >>>        if (!aplic->msimode) {
> >>>            aplic->external_irqs =3D g_malloc(sizeof(qemu_irq) *
> >> aplic->num_harts);
> >>>            qdev_init_gpio_out(dev, aplic->external_irqs,
> >>> aplic->num_harts);
> >>> -
> >>> -        /* Claim the CPU interrupt to be triggered by this APLIC */
> >>> -        for (i =3D 0; i < aplic->num_harts; i++) {
> >>> -            RISCVCPU *cpu =3D
> >> RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
> >>> -            if (riscv_cpu_claim_interrupts(cpu,
> >>> -                (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
> >>> -                error_report("%s already claimed",
> >>> -                             (aplic->mmode) ? "MEIP" : "SEIP");
> >>> -                exit(1);
> >>> -            }
> >>> -        }
> >>>        }
> >>>
> >>>        msi_nonbroken =3D true;
> >>> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c index
> >>> b90f0d731d..8c61a5f28b 100644
> >>> --- a/hw/intc/riscv_imsic.c
> >>> +++ b/hw/intc/riscv_imsic.c
> >>> @@ -347,14 +347,6 @@ static void riscv_imsic_realize(DeviceState *dev=
,
> >> Error **errp)
> >>>                              IMSIC_MMIO_SIZE(imsic->num_pages));
> >>>        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
> >>>
> >>> -    /* Claim the CPU interrupt to be triggered by this IMSIC */
> >>> -    if (riscv_cpu_claim_interrupts(rcpu,
> >>> -            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
> >>> -        error_setg(errp, "%s already claimed",
> >>> -                   (imsic->mmode) ? "MEIP" : "SEIP");
> >>> -        return;
> >>> -    }
> >>> -
> >>>        /* Create output IRQ lines */
> >>>        imsic->external_irqs =3D g_malloc(sizeof(qemu_irq) *
> >> imsic->num_pages);
> >>>        qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages=
);
> >>> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c index
> >>> e559f11805..f0f3dcce1f 100644
> >>> --- a/hw/intc/sifive_plic.c
> >>> +++ b/hw/intc/sifive_plic.c
> >>> @@ -356,7 +356,6 @@ static void sifive_plic_irq_request(void *opaque,=
 int
> >> irq, int level)
> >>>    static void sifive_plic_realize(DeviceState *dev, Error **errp)
> >>>    {
> >>>        SiFivePLICState *s =3D SIFIVE_PLIC(dev);
> >>> -    int i;
> >>>
> >>>        memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_plic_ops,=
 s,
> >>>                              TYPE_SIFIVE_PLIC, s->aperture_size); @@
> >>> -385,20 +384,6 @@ static void sifive_plic_realize(DeviceState *dev, E=
rror
> >> **errp)
> >>>        s->m_external_irqs =3D g_malloc(sizeof(qemu_irq) * s->num_hart=
s);
> >>>        qdev_init_gpio_out(dev, s->m_external_irqs, s->num_harts);
> >>>
> >>> -    /*
> >>> -     * We can't allow the supervisor to control SEIP as this would a=
llow the
> >>> -     * supervisor to clear a pending external interrupt which will r=
esult in
> >>> -     * lost a interrupt in the case a PLIC is attached. The SEIP bit=
 must be
> >>> -     * hardware controlled when a PLIC is attached.
> >>> -     */
> >>> -    for (i =3D 0; i < s->num_harts; i++) {
> >>> -        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(s->hartid_base + i)=
);
> >>> -        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
> >>> -            error_setg(errp, "SEIP already claimed");
> >>> -            return;
> >>> -        }
> >>> -    }
> >>> -
> >>>        msi_nonbroken =3D true;
> >>>    }
> >>>
> >>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c index
> >>> a90808a3ba..19feb032d6 100644
> >>> --- a/target/riscv/cpu.c
> >>> +++ b/target/riscv/cpu.c
> >>> @@ -967,7 +967,6 @@ static void riscv_cpu_reset_hold(Object *obj,
> >> ResetType type)
> >>>            }
> >>>        }
> >>>        env->mcause =3D 0;
> >>> -    env->miclaim =3D MIP_SGEIP;
> >>>        env->pc =3D env->resetvec;
> >>>        env->bins =3D 0;
> >>>        env->two_stage_lookup =3D false;
> >>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h index
> >>> 1619c3acb6..6277979afd 100644
> >>> --- a/target/riscv/cpu.h
> >>> +++ b/target/riscv/cpu.h
> >>> @@ -258,8 +258,6 @@ struct CPUArchState {
> >>>        bool external_seip;
> >>>        bool software_seip;
> >>>
> >>> -    uint64_t miclaim;
> >>> -
> >>>        uint64_t mie;
> >>>        uint64_t mideleg;
> >>>
> >>> @@ -565,7 +563,6 @@ void riscv_cpu_do_transaction_failed(CPUState *cs=
,
> >> hwaddr physaddr,
> >>>    hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>>    bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)=
;
> >>>    void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env); -int
> >>> riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
> >>>    uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
> >>>                                  uint64_t value);
> >>>    void riscv_cpu_interrupt(CPURISCVState *env); diff --git
> >>> a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c index
> >>> 395a1d9140..bcafa55acd 100644
> >>> --- a/target/riscv/cpu_helper.c
> >>> +++ b/target/riscv/cpu_helper.c
> >>> @@ -619,17 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env,
> >> target_ulong geilen)
> >>>        env->geilen =3D geilen;
> >>>    }
> >>>
> >>> -int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts) -=
{
> >>> -    CPURISCVState *env =3D &cpu->env;
> >>> -    if (env->miclaim & interrupts) {
> >>> -        return -1;
> >>> -    } else {
> >>> -        env->miclaim |=3D interrupts;
> >>> -        return 0;
> >>> -    }
> >>> -}
> >>> -
> >>>    void riscv_cpu_interrupt(CPURISCVState *env)
> >>>    {
> >>>        uint64_t gein, vsgein =3D 0, vstip =3D 0, irqf =3D 0; diff --g=
it
> >>> a/target/riscv/machine.c b/target/riscv/machine.c index
> >>> 492c2c6d9d..0eabb6c076 100644
> >>> --- a/target/riscv/machine.c
> >>> +++ b/target/riscv/machine.c
> >>> @@ -378,7 +378,6 @@ const VMStateDescription vmstate_riscv_cpu =3D {
> >>>            VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> >>>            VMSTATE_UINT64(env.mstatus, RISCVCPU),
> >>>            VMSTATE_UINT64(env.mip, RISCVCPU),
> >>> -        VMSTATE_UINT64(env.miclaim, RISCVCPU),
> >>>            VMSTATE_UINT64(env.mie, RISCVCPU),
> >>>            VMSTATE_UINT64(env.mvien, RISCVCPU),
> >>>            VMSTATE_UINT64(env.mvip, RISCVCPU),
> > CONFIDENTIALITY NOTICE:
> >
> > This e-mail (and its attachments) may contain confidential and legally =
privileged information or information protected from disclosure. If you are=
 not the intended recipient, you are hereby notified that any disclosure, c=
opying, distribution, or use of the information contained herein is strictl=
y prohibited. In this case, please immediately notify the sender by return =
e-mail, delete the message (and any accompanying documents) and destroy all=
 printed hard copies. Thank you for your cooperation.
> >
> > Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.
>

