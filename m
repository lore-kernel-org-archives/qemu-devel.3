Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D92AC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxow-0002VO-UU; Tue, 12 Mar 2024 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxoX-0002OS-OJ; Tue, 12 Mar 2024 04:48:56 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxoU-0005SM-US; Tue, 12 Mar 2024 04:48:48 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso4712587a12.3; 
 Tue, 12 Mar 2024 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710233325; x=1710838125; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ArqjDfcouDVJS2rSVrYQjD3YfBrDe/r3Oas2h05ZLs=;
 b=ls/3Y8E8ptCyHXIwjOhAmfCozW752ONCNvSEgRUPtQuxwOMKlDS2LTjS4SUD+gUocY
 HpNiSWyHQ1nJoTGPQR0pYFaAMGFKi+aHjkShmkZDv87gqewGSCsr15hoQ34tFuDNwkNb
 ZYpSCwDn5924ZZXuf7CFBvnB4+tqgnrLujTv3FFYRxBHRlwuiCBBIJnE7o3ifTKLsSu/
 umEJeS6M0nLMIL/2SgZVwwvm3PGjeHMruhxdHZnx+W19B7bCsbw+o2mJvRVTnSOiyusf
 n3/pxqIyHayl0pofqA97DxexU5nlAqcKAouXOjuqmZlXQv/cUqmqKYHyOgvfao7f31Yl
 XsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710233325; x=1710838125;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6ArqjDfcouDVJS2rSVrYQjD3YfBrDe/r3Oas2h05ZLs=;
 b=vWC6iF8hGQ/hBPJCQRJjkEWRdshfRmWTfjxjYnRA0xksWky7Zi7eyq2Wj0pr3M4ToY
 oGBmWeGa98wFqjZKVuw6T6v9a4y78PFpTtdFYJHw1qQo7sxhGuDXeiQL3bbp8sPNJ/h1
 ZwIo5MFW1KM57oG/YQtHwZOeUtuj+H/rdU4bDenpB+sw3KSy7yNCfHZX71WwhoWFe2Ty
 OklIomBsT+qZ9mtM48FA7GYJvLgoo4fut0u1CDIwjow6n4JVjJVfEJN6aCTGrLxL0hXA
 j0yrwEfXpbCFLfKK9U0EPUMYes4TbWa7Uai+X1h7EHbZw0CAO0BzgAbEHQ4Wb41ts3Oe
 f66w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKNadXKDb1xPe8h7HjeFPXaJaTJSAUgkVgSOsY8FOLQAj4rklRiEtFTsKPlKMVWnp24MkrqXwBAtV1RA2eofdeoZD0
X-Gm-Message-State: AOJu0YzmQm8mhgGaGu3BdvpA9fzPuWqyW2mDsJlCgpzH6WT5A8IchR6V
 2Rx8ZM/ybbL4jTHs9J5cQV5bfyHUnzqQgNmPJOWvxvBAcJz4tyV4yS3bdCuq0Jw=
X-Google-Smtp-Source: AGHT+IGihvil68I4Fi32bVEKLa6m5X7a3u4hraqrtyEVTFEGw5+Anj4Fm8pTW314qhckIcpnvmzw9w==
X-Received: by 2002:a05:6a20:d909:b0:1a3:2b4e:3491 with SMTP id
 jd9-20020a056a20d90900b001a32b4e3491mr440864pzb.22.1710233324794; 
 Tue, 12 Mar 2024 01:48:44 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 p18-20020a17090adf9200b0029951d04dc4sm5294506pjv.54.2024.03.12.01.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:48:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 18:48:39 +1000
Message-Id: <CZRN44HD20CR.33XSLDXL84FZH@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "BALATON Zoltan" <balaton@eik.bme.hu>, "David
 Gibson" <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr: avoid overhead of finding vhyp class in critical
 operations
X-Mailer: aerc 0.15.2
References: <20240224073359.1025835-1-npiggin@gmail.com>
 <a465cc07-17ee-48ea-95e6-14c15697ab09@linux.ibm.com>
In-Reply-To: <a465cc07-17ee-48ea-95e6-14c15697ab09@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

On Tue Mar 12, 2024 at 4:38 PM AEST, Harsh Prateek Bora wrote:
> Hi Nick,
>
> One minor comment below:
>
> On 2/24/24 13:03, Nicholas Piggin wrote:
> > PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
> > interrupts and TLB misses and is quite costly. Running the
> > kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
> > TLB and spends a lot of time in TLB and page table walking code. The
> > test takes 67 seconds to complete with a lot of time being spent in
> > code related to finding the vhyp class:
> >=20
> >     12.01%  [.] g_str_hash
> >      8.94%  [.] g_hash_table_lookup
> >      8.06%  [.] object_class_dynamic_cast
> >      6.21%  [.] address_space_ldq
> >      4.94%  [.] __strcmp_avx2
> >      4.28%  [.] tlb_set_page_full
> >      4.08%  [.] address_space_translate_internal
> >      3.17%  [.] object_class_dynamic_cast_assert
> >      2.84%  [.] ppc_radix64_xlate
> >=20
> > Keep a pointer to the class and avoid this lookup. This reduces the
> > execution time to 40 seconds.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This feels a bit ugly, but the performance problem of looking up the
> > class in fast paths can't be ignored. Is there a "nicer" way to get the
> > same result?
> >=20
> > Thanks,
> > Nick
> >=20
> >   target/ppc/cpu.h           |  3 ++-
> >   target/ppc/mmu-book3s-v3.h |  4 +---
> >   hw/ppc/pegasos2.c          |  1 +
> >   target/ppc/cpu_init.c      |  9 +++------
> >   target/ppc/excp_helper.c   | 16 ++++------------
> >   target/ppc/kvm.c           |  4 +---
> >   target/ppc/mmu-hash64.c    | 16 ++++------------
> >   target/ppc/mmu-radix64.c   |  4 +---
> >   8 files changed, 17 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index ec14574d14..eb85d9aa71 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1437,6 +1437,7 @@ struct ArchCPU {
> >       int vcpu_id;
> >       uint32_t compat_pvr;
> >       PPCVirtualHypervisor *vhyp;
> > +    PPCVirtualHypervisorClass *vhyp_class;
> >       void *machine_data;
> >       int32_t node_id; /* NUMA node this CPU belongs to */
> >       PPCHash64Options *hash64_opts;
> > @@ -1535,7 +1536,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCVir=
tualHypervisorClass,
> >  =20
> >   static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
> >   {
> > -    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_nested(=
cpu);
> > +    return cpu->vhyp_class->cpu_in_nested(cpu);
> >   }
> >   #endif /* CONFIG_USER_ONLY */
> >  =20
> > diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> > index 674377a19e..f3f7993958 100644
> > --- a/target/ppc/mmu-book3s-v3.h
> > +++ b/target/ppc/mmu-book3s-v3.h
> > @@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU=
 *cpu)
> >       uint64_t base;
> >  =20
> >       if (cpu->vhyp) {
>
> All the checks for cpu->vhyp needs to be changed to check for=20
> cpu->vhyp_class now, for all such instances.

It wasn't supposed to, because vhyp !=3D NULL implies vhyp_class !=3D NULL.
It's supposed to be an equivalent transformation just changing the
lookup function.

Okay to leave it as is?

Thanks,
Nick

>
> With that,
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
>
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        return vhc->hpt_mask(cpu->vhyp);
> > +        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
> >       }
> >       if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
> >           ppc_v3_pate_t pate;
> > diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> > index 04d6decb2b..c22e8b336d 100644
> > --- a/hw/ppc/pegasos2.c
> > +++ b/hw/ppc/pegasos2.c
> > @@ -400,6 +400,7 @@ static void pegasos2_machine_reset(MachineState *ma=
chine, ShutdownCause reason)
> >       machine->fdt =3D fdt;
> >  =20
> >       pm->cpu->vhyp =3D PPC_VIRTUAL_HYPERVISOR(machine);
> > +    pm->cpu->vhyp_class =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(pm->cpu->=
vhyp);
> >   }
> >  =20
> >   enum pegasos2_rtas_tokens {
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 9bccddb350..63d0094024 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6631,6 +6631,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
> >       CPUPPCState *env =3D &cpu->env;
> >  =20
> >       cpu->vhyp =3D vhyp;
> > +    cpu->vhyp_class =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(vhyp);
> >  =20
> >       /*
> >        * With a virtual hypervisor mode we never allow the CPU to go
> > @@ -7224,9 +7225,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
> >       PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        vhc->cpu_exec_enter(cpu->vhyp, cpu);
> > +        cpu->vhyp_class->cpu_exec_enter(cpu->vhyp, cpu);
> >       }
> >   }
> >  =20
> > @@ -7235,9 +7234,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
> >       PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        vhc->cpu_exec_exit(cpu->vhyp, cpu);
> > +        cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
> >       }
> >   }
> >   #endif /* CONFIG_TCG */
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 98952de267..445350488c 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -840,9 +840,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
> >            * HV mode, we need to keep hypercall support.
> >            */
> >           if (lev =3D=3D 1 && cpu->vhyp) {
> > -            PPCVirtualHypervisorClass *vhc =3D
> > -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -            vhc->hypercall(cpu->vhyp, cpu);
> > +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
> >               powerpc_reset_excp_state(cpu);
> >               return;
> >           }
> > @@ -1012,9 +1010,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, in=
t excp)
> >            * HV mode, we need to keep hypercall support.
> >            */
> >           if (lev =3D=3D 1 && cpu->vhyp) {
> > -            PPCVirtualHypervisorClass *vhc =3D
> > -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -            vhc->hypercall(cpu->vhyp, cpu);
> > +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
> >               powerpc_reset_excp_state(cpu);
> >               return;
> >           }
> > @@ -1534,9 +1530,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, i=
nt excp)
> >  =20
> >           /* "PAPR mode" built-in hypercall emulation */
> >           if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
> > -            PPCVirtualHypervisorClass *vhc =3D
> > -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -            vhc->hypercall(cpu->vhyp, cpu);
> > +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
> >               powerpc_reset_excp_state(cpu);
> >               return;
> >           }
> > @@ -1677,10 +1671,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, =
int excp)
> >       }
> >  =20
> >       if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >           /* Deliver interrupt to L1 by returning from the H_ENTER_NEST=
ED call */
> > -        vhc->deliver_hv_excp(cpu, excp);
> > +        cpu->vhyp_class->deliver_hv_excp(cpu, excp);
> >  =20
> >           powerpc_reset_excp_state(cpu);
> >  =20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 26fa9d0575..5b5b96ab6b 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -862,9 +862,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> >       sregs.pvr =3D env->spr[SPR_PVR];
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        sregs.u.s.sdr1 =3D vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
> > +        sregs.u.s.sdr1 =3D cpu->vhyp_class->encode_hpt_for_kvm_pr(cpu-=
>vhyp);
> >       } else {
> >           sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> >       }
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index d645c0bb94..196b4b2a48 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -516,9 +516,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerP=
CCPU *cpu,
> >       const ppc_hash_pte64_t *hptes;
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        return vhc->map_hptes(cpu->vhyp, ptex, n);
> > +        return cpu->vhyp_class->map_hptes(cpu->vhyp, ptex, n);
> >       }
> >       base =3D ppc_hash64_hpt_base(cpu);
> >  =20
> > @@ -538,9 +536,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const =
ppc_hash_pte64_t *hptes,
> >                               hwaddr ptex, int n)
> >   {
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
> > +        cpu->vhyp_class->unmap_hptes(cpu->vhyp, hptes, ptex, n);
> >           return;
> >       }
> >  =20
> > @@ -820,9 +816,7 @@ static void ppc_hash64_set_r(PowerPCCPU *cpu, hwadd=
r ptex, uint64_t pte1)
> >       hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_R;
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
> > +        cpu->vhyp_class->hpte_set_r(cpu->vhyp, ptex, pte1);
> >           return;
> >       }
> >       base =3D ppc_hash64_hpt_base(cpu);
> > @@ -837,9 +831,7 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwadd=
r ptex, uint64_t pte1)
> >       hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_C;
> >  =20
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc =3D
> > -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
> > +        cpu->vhyp_class->hpte_set_c(cpu->vhyp, ptex, pte1);
> >           return;
> >       }
> >       base =3D ppc_hash64_hpt_base(cpu);
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index 5823e039e6..496ba87a95 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -677,9 +677,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu,=
 vaddr eaddr,
> >  =20
> >       /* Get Partition Table */
> >       if (cpu->vhyp) {
> > -        PPCVirtualHypervisorClass *vhc;
> > -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> > -        if (!vhc->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
> > +        if (!cpu->vhyp_class->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
> >               if (guest_visible) {
> >                   ppc_radix64_raise_hsi(cpu, access_type, eaddr, eaddr,
> >                                         DSISR_R_BADCONFIG);


