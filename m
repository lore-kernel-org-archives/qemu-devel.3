Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD57C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC7E7-0000kQ-L8; Tue, 28 May 2024 20:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC7E5-0000jT-Fe; Tue, 28 May 2024 20:31:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC7E3-0002E3-C0; Tue, 28 May 2024 20:31:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so286663b3a.0; 
 Tue, 28 May 2024 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716942689; x=1717547489; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyTsky4jI5zz7g9luSPJ19DijDmERwSrOrQtvwCE5VI=;
 b=ADfxXP9AFqN+e04WQ0Tglmza2ui6vWfKPuXJPnbyMMHENTQbU1IrZoIO4jjEzPffFD
 4vs2dW/xoelMIHLMFFQWYN+9yjVP6t/AyRcuP8JDkjaH0mSghRq155KCeq/sZ5VT9kYD
 AQ59DPqqAf1/5Ae36aaGGLvb4QFGJ/Hsq6RzhgXfYqa05kLfGRWKc3iQDiadcKGFa9KZ
 ATaKPIIQcgQz28uKAmtCXGRniQ/A9hZ6jqccelS6nAXOkPapkit3hQoWcdAbRCBr1nuj
 ErYF3w3/AOK2uZ7a6xQmF8s2fsxAWu2rJZRGxZ1Prjgg/g2m4eR+BK0tKzXa4XXLc+0X
 VBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716942689; x=1717547489;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uyTsky4jI5zz7g9luSPJ19DijDmERwSrOrQtvwCE5VI=;
 b=lhr3NO2qdtuF1uvsMGd9Y+HidXOe6SiERi/GQp2/YYE79HH6CDkgWGSenE6WXF486a
 TH48FP8LGwevvzPYpXfaDwmml2Z/ErcNo3mu41GJyTyr0kFR2KEku5RXBiR/cnxb+1sg
 9QC2mS3Z+qLw7+ew/fAUolexncZhTH10Nm3zDFNuhaEr+uKD4nhbcUoVRzcwIld21HYj
 uVrBRRLzouPPBMuowMnOUlGCsqsumcBuUe5WtSYfyzafMN6QuIdK0tbEVpL6YPLbpyWp
 59rSUyBh2S8dzT3NpUzW+up4nEZlkYgBPinHrH6OAP4fWg6I+psLeF/V3eNxNXtqCUYj
 puug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmoV4podfKwQB8OTbvGml4vGjphTqiEMMgiEjcP1PHg6iAUoE4eqRgsFPSUBfXZHXUH8L5Y22hLnhSbT9eNIVio5kbRin+lde5t7vJjNpZXEfyXw63hZfeVKM=
X-Gm-Message-State: AOJu0YwvzOmU/8i/RmbRt+S2xkjFerNNCHA/ANLDRgpI2LJeW04il/EI
 KkB2er0uEL8b4pP/aDZdjKkXxtqS9qYRbQv1GCsVzT626iYJqwZx
X-Google-Smtp-Source: AGHT+IFcQC9S90gtTWCahlCUzoDtONN0UEdNXN140V2FkK+L2boEpvl9Y2CjE/nJpNslqRC+FNuWEw==
X-Received: by 2002:a05:6a00:90a8:b0:6f8:b8d7:1123 with SMTP id
 d2e1a72fcca58-702029d689amr1018980b3a.1.1716942689233; 
 Tue, 28 May 2024 17:31:29 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc2584dfsm7004504b3a.76.2024.05.28.17.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:31:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:31:23 +1000
Message-Id: <D1LPDW58FUJ2.10TPCAQT8CHZ5@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 07/10] target/ppc: Add helpers to check for SMT
 sibling threads
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-8-npiggin@gmail.com>
 <1f9c8eb6-aa4f-4740-89a6-20b510b21d7d@linux.ibm.com>
In-Reply-To: <1f9c8eb6-aa4f-4740-89a6-20b510b21d7d@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 28, 2024 at 7:16 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 5/26/24 17:56, Nicholas Piggin wrote:
> > Add helpers for TCG code to determine if there are SMT siblings
> > sharing per-core and per-lpar registers. This simplifies the
> > callers and makes SMT register topology simpler to modify with
> > later changes.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/cpu.h             |  7 +++++++
> >   target/ppc/cpu_init.c        |  2 +-
> >   target/ppc/excp_helper.c     | 16 +++++++---------
> >   target/ppc/misc_helper.c     | 27 ++++++---------------------
> >   target/ppc/timebase_helper.c | 20 +++++++-------------
> >   5 files changed, 28 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 9a89083932..8fd6ade471 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1406,6 +1406,13 @@ struct CPUArchState {
> >       uint64_t pmu_base_time;
> >   };
> >  =20
> > +#define PPC_CPU_HAS_CORE_SIBLINGS(cs)                           \
> > +    (cs->nr_threads > 1)
> > +
> > +#define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
> > +    ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
> > +     PPC_CPU_HAS_CORE_SIBLINGS(cs))
> > +
> >   #define _CORE_ID(cs)                                            \
> >       (POWERPC_CPU(cs)->env.core_index)
> >  =20
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index ae483e20c4..e71ee008ed 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6975,7 +6975,7 @@ static void ppc_cpu_realize(DeviceState *dev, Err=
or **errp)
> >  =20
> >       pcc->parent_realize(dev, errp);
> >  =20
> > -    if (env_cpu(env)->nr_threads > 1) {
> > +    if (PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
> >           env->flags |=3D POWERPC_FLAG_SMT;
> >       }
> >  =20
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 0cd542675f..fd45da0f2b 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -3029,7 +3029,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, targe=
t_ulong rb)
> >           brdcast =3D true;
> >       }
> >  =20
> > -    if (cs->nr_threads =3D=3D 1 || !brdcast) {
> > +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs) || !brdcast) {
>
> Since there are multiple usage of above macro in negation below as well,=
=20
> we may probably want to introduce another macro PPC_CPU_HAS_SINGLE_CORE

Ah, you mean SINGLE_THREAD. Yes it would read a bit better.

Thanks,
Nick

> which checks only for nr_threads =3D=3D 1. Anyways,
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
>
> >           ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
> >           return;
> >       }
> > @@ -3067,21 +3067,19 @@ void helper_book3s_msgsndp(CPUPPCState *env, ta=
rget_ulong rb)
> >       CPUState *cs =3D env_cpu(env);
> >       PowerPCCPU *cpu =3D env_archcpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >       int ttir =3D rb & PPC_BITMASK(57, 63);
> >  =20
> >       helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_=
MSGP);
> >  =20
> > -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> > -        nr_threads =3D 1; /* msgsndp behaves as 1-thread in LPAR-per-t=
hread mode*/
> > -    }
> > -
> > -    if (!dbell_type_server(rb) || ttir >=3D nr_threads) {
> > +    if (!dbell_type_server(rb)) {
> >           return;
> >       }
> >  =20
> > -    if (nr_threads =3D=3D 1) {
> > -        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
> > +    /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> > +        if (ttir =3D=3D 0) {
> > +            ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
> > +        }
> >           return;
> >       }
> >  =20
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index 46ba3a5584..598c956cdd 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -49,9 +49,8 @@ void helper_spr_core_write_generic(CPUPPCState *env, =
uint32_t sprn,
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1) {
> > +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
> >           env->spr[sprn] =3D val;
> >           return;
> >       }
> > @@ -196,7 +195,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulo=
ng val)
> >               return;
> >           }
> >  =20
> > -        if (cs->nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT=
_1LPAR)) {
> > +        if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >               env->spr[SPR_PTCR] =3D val;
> >               tlb_flush(cs);
> >           } else {
> > @@ -243,16 +242,12 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >       target_ulong dpdes =3D 0;
> >  =20
> >       helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_=
IC_MSGP);
> >  =20
> > -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> > -        nr_threads =3D 1; /* DPDES behaves as 1-thread in LPAR-per-thr=
ead mode */
> > -    }
> > -
> > -    if (nr_threads =3D=3D 1) {
> > +    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> >               dpdes =3D 1;
> >           }
> > @@ -279,21 +274,11 @@ void helper_store_dpdes(CPUPPCState *env, target_=
ulong val)
> >       PowerPCCPU *cpu =3D env_archcpu(env);
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> >       helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR=
_IC_MSGP);
> >  =20
> > -    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
> > -        nr_threads =3D 1; /* DPDES behaves as 1-thread in LPAR-per-thr=
ead mode */
> > -    }
> > -
> > -    if (val & ~(nr_threads - 1)) {
> > -        qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
> > -                      TARGET_FMT_lx"\n", val);
> > -        val &=3D (nr_threads - 1); /* Ignore the invalid bits */
> > -    }
> > -
> > -    if (nr_threads =3D=3D 1) {
> > +    /* DPDES behaves as 1-thread in LPAR-per-thread mode */
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
> >           return;
> >       }
> > diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.=
c
> > index 788c498d63..abe7b95696 100644
> > --- a/target/ppc/timebase_helper.c
> > +++ b/target/ppc/timebase_helper.c
> > @@ -63,9 +63,8 @@ void helper_store_purr(CPUPPCState *env, target_ulong=
 val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_purr(env, val);
> >           return;
> >       }
> > @@ -82,9 +81,8 @@ void helper_store_tbl(CPUPPCState *env, target_ulong =
val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_tbl(env, val);
> >           return;
> >       }
> > @@ -99,9 +97,8 @@ void helper_store_tbu(CPUPPCState *env, target_ulong =
val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_tbu(env, val);
> >           return;
> >       }
> > @@ -141,9 +138,8 @@ void helper_store_hdecr(CPUPPCState *env, target_ul=
ong val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_hdecr(env, val);
> >           return;
> >       }
> > @@ -158,9 +154,8 @@ void helper_store_vtb(CPUPPCState *env, target_ulon=
g val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_vtb(env, val);
> >           return;
> >       }
> > @@ -175,9 +170,8 @@ void helper_store_tbu40(CPUPPCState *env, target_ul=
ong val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >       CPUState *ccs;
> > -    uint32_t nr_threads =3D cs->nr_threads;
> >  =20
> > -    if (nr_threads =3D=3D 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR))=
 {
> > +    if (!PPC_CPU_HAS_LPAR_SIBLINGS(cs)) {
> >           cpu_ppc_store_tbu40(env, val);
> >           return;
> >       }
> > @@ -288,7 +282,7 @@ static void write_tfmr(CPUPPCState *env, target_ulo=
ng val)
> >   {
> >       CPUState *cs =3D env_cpu(env);
> >  =20
> > -    if (cs->nr_threads =3D=3D 1) {
> > +    if (!PPC_CPU_HAS_CORE_SIBLINGS(cs)) {
> >           env->spr[SPR_TFMR] =3D val;
> >       } else {
> >           CPUState *ccs;


