Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37541C54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reRGK-00028P-Aj; Sun, 25 Feb 2024 22:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1reRGF-000280-Hj; Sun, 25 Feb 2024 22:02:37 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1reRGC-0007IO-0v; Sun, 25 Feb 2024 22:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1708916540;
 bh=P01nfGOU3QpYWHqwi45UZJvKYiFgO/x2B24hvgvUGcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fCP1q/UFz0FQXWyN8ab5X+OGHz9XzZJQG7q6pvWhF4LWVCzlM6/g1pm5kWPwNlJWd
 /hQElWerXGBUZxDywiLHjafJ+KaK6AIQhlUtK4jl3YzAUn/mV60g28DRKTrwUAIQVq
 vBv525/GvAXE44GxqKPsjLEqmPI+IbyJB1D7FHkL5Prttmheicb517OMakBZBDpzZN
 cp/IMPSWJ2psiUAbgq5VFpXpSaouonvdW2g4zQMmojXii715dXgvZB6E5DgrEInqXT
 biJhba39nLZgR7PHLINwXc1orAsXhS22KHMofwdAdgXC7w6auyKApI4sGYisRaN5KY
 REw4JqQFzEFQQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Tjllc2Rpzz4wcT; Mon, 26 Feb 2024 14:02:20 +1100 (AEDT)
Date: Mon, 26 Feb 2024 14:01:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr: avoid overhead of finding vhyp class in critical
 operations
Message-ID: <Zdv_HrGqrB3CSpv6@zatzit>
References: <20240224073359.1025835-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zwKHaT/h1ti62TU9"
Content-Disposition: inline
In-Reply-To: <20240224073359.1025835-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--zwKHaT/h1ti62TU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 05:33:59PM +1000, Nicholas Piggin wrote:
> PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
> interrupts and TLB misses and is quite costly. Running the
> kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
> TLB and spends a lot of time in TLB and page table walking code. The
> test takes 67 seconds to complete with a lot of time being spent in
> code related to finding the vhyp class:
>=20
>    12.01%  [.] g_str_hash
>     8.94%  [.] g_hash_table_lookup
>     8.06%  [.] object_class_dynamic_cast
>     6.21%  [.] address_space_ldq
>     4.94%  [.] __strcmp_avx2
>     4.28%  [.] tlb_set_page_full
>     4.08%  [.] address_space_translate_internal
>     3.17%  [.] object_class_dynamic_cast_assert
>     2.84%  [.] ppc_radix64_xlate
>=20
> Keep a pointer to the class and avoid this lookup. This reduces the
> execution time to 40 seconds.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This feels a bit ugly, but the performance problem of looking up the
> class in fast paths can't be ignored. Is there a "nicer" way to get the
> same result?

Not one I'm aware of, unfortunately.

>=20
> Thanks,
> Nick
>=20
>  target/ppc/cpu.h           |  3 ++-
>  target/ppc/mmu-book3s-v3.h |  4 +---
>  hw/ppc/pegasos2.c          |  1 +
>  target/ppc/cpu_init.c      |  9 +++------
>  target/ppc/excp_helper.c   | 16 ++++------------
>  target/ppc/kvm.c           |  4 +---
>  target/ppc/mmu-hash64.c    | 16 ++++------------
>  target/ppc/mmu-radix64.c   |  4 +---
>  8 files changed, 17 insertions(+), 40 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ec14574d14..eb85d9aa71 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1437,6 +1437,7 @@ struct ArchCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> +    PPCVirtualHypervisorClass *vhyp_class;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> @@ -1535,7 +1536,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCVirtu=
alHypervisorClass,
> =20
>  static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
>  {
> -    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_nested(cp=
u);
> +    return cpu->vhyp_class->cpu_in_nested(cpu);
>  }
>  #endif /* CONFIG_USER_ONLY */
> =20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 674377a19e..f3f7993958 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *=
cpu)
>      uint64_t base;
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        return vhc->hpt_mask(cpu->vhyp);
> +        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
>      }
>      if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
>          ppc_v3_pate_t pate;
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 04d6decb2b..c22e8b336d 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -400,6 +400,7 @@ static void pegasos2_machine_reset(MachineState *mach=
ine, ShutdownCause reason)
>      machine->fdt =3D fdt;
> =20
>      pm->cpu->vhyp =3D PPC_VIRTUAL_HYPERVISOR(machine);
> +    pm->cpu->vhyp_class =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(pm->cpu->vh=
yp);
>  }
> =20
>  enum pegasos2_rtas_tokens {
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9bccddb350..63d0094024 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6631,6 +6631,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      cpu->vhyp =3D vhyp;
> +    cpu->vhyp_class =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(vhyp);
> =20
>      /*
>       * With a virtual hypervisor mode we never allow the CPU to go
> @@ -7224,9 +7225,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->cpu_exec_enter(cpu->vhyp, cpu);
> +        cpu->vhyp_class->cpu_exec_enter(cpu->vhyp, cpu);
>      }
>  }
> =20
> @@ -7235,9 +7234,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->cpu_exec_exit(cpu->vhyp, cpu);
> +        cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
>      }
>  }
>  #endif /* CONFIG_TCG */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 98952de267..445350488c 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -840,9 +840,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int exc=
p)
>           * HV mode, we need to keep hypercall support.
>           */
>          if (lev =3D=3D 1 && cpu->vhyp) {
> -            PPCVirtualHypervisorClass *vhc =3D
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>              powerpc_reset_excp_state(cpu);
>              return;
>          }
> @@ -1012,9 +1010,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>           * HV mode, we need to keep hypercall support.
>           */
>          if (lev =3D=3D 1 && cpu->vhyp) {
> -            PPCVirtualHypervisorClass *vhc =3D
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>              powerpc_reset_excp_state(cpu);
>              return;
>          }
> @@ -1534,9 +1530,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
> =20
>          /* "PAPR mode" built-in hypercall emulation */
>          if (lev =3D=3D 1 && books_vhyp_handles_hcall(cpu)) {
> -            PPCVirtualHypervisorClass *vhc =3D
> -                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -            vhc->hypercall(cpu->vhyp, cpu);
> +            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
>              powerpc_reset_excp_state(cpu);
>              return;
>          }
> @@ -1677,10 +1671,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, in=
t excp)
>      }
> =20
>      if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>          /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED =
call */
> -        vhc->deliver_hv_excp(cpu, excp);
> +        cpu->vhyp_class->deliver_hv_excp(cpu, excp);
> =20
>          powerpc_reset_excp_state(cpu);
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 26fa9d0575..5b5b96ab6b 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -862,9 +862,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
>      sregs.pvr =3D env->spr[SPR_PVR];
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        sregs.u.s.sdr1 =3D vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
> +        sregs.u.s.sdr1 =3D cpu->vhyp_class->encode_hpt_for_kvm_pr(cpu->v=
hyp);
>      } else {
>          sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
>      }
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d645c0bb94..196b4b2a48 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -516,9 +516,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCC=
PU *cpu,
>      const ppc_hash_pte64_t *hptes;
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        return vhc->map_hptes(cpu->vhyp, ptex, n);
> +        return cpu->vhyp_class->map_hptes(cpu->vhyp, ptex, n);
>      }
>      base =3D ppc_hash64_hpt_base(cpu);
> =20
> @@ -538,9 +536,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const pp=
c_hash_pte64_t *hptes,
>                              hwaddr ptex, int n)
>  {
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
> +        cpu->vhyp_class->unmap_hptes(cpu->vhyp, hptes, ptex, n);
>          return;
>      }
> =20
> @@ -820,9 +816,7 @@ static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr =
ptex, uint64_t pte1)
>      hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_R;
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
> +        cpu->vhyp_class->hpte_set_r(cpu->vhyp, ptex, pte1);
>          return;
>      }
>      base =3D ppc_hash64_hpt_base(cpu);
> @@ -837,9 +831,7 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr =
ptex, uint64_t pte1)
>      hwaddr base, offset =3D ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_C;
> =20
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc =3D
> -            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
> +        cpu->vhyp_class->hpte_set_c(cpu->vhyp, ptex, pte1);
>          return;
>      }
>      base =3D ppc_hash64_hpt_base(cpu);
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 5823e039e6..496ba87a95 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -677,9 +677,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, v=
addr eaddr,
> =20
>      /* Get Partition Table */
>      if (cpu->vhyp) {
> -        PPCVirtualHypervisorClass *vhc;
> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        if (!vhc->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
> +        if (!cpu->vhyp_class->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
>              if (guest_visible) {
>                  ppc_radix64_raise_hsi(cpu, access_type, eaddr, eaddr,
>                                        DSISR_R_BADCONFIG);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zwKHaT/h1ti62TU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmXb/xkACgkQzQJF27ox
2Gc3oQ/+MNisQm+HVmTWCDSzUSkS11ZnamZuqKcthA5X4QYuwxVaegguCjTUr625
oBAXdw/GPv4NCZvrxUJbNPn1TQmbILtdsIpgV4bC8Qyl60Flc/1FKANLBnCDzBTO
ZhW+HlQv09iN8s+3qftbBiLukK/TNeNZT5cEbZNXslobwMV6YcYlsEd3nGF1w8PL
wMtofovEwU9V3Ce4YDtmaUg9FPT87Tu9LU1t6MKc3ma2LVRW81nKXx/fH5zmJvsB
/iprUZaqpixj1jx2hwNlwyYAQ4bsXz5S7Nk4hkQNx/aYe5XWiJX8LEdsrXit9ynf
5TruUVlVliUIHGcj95g3hnCEyM7JQSWce594GUOKEkBKHmTR/HvFPXYKPrwqfXjU
PsIu8hpV2VyjMQnYoID9MjHYDUQaZ/3yRzgUakeKr4zTKv5qyXLoSkpdMOk09RiX
UE8TlTbkxoE1byMbdUImrbjHQIT+6VR3/ljbrlDvEHrWeDF/9EMAvkALlhjYu/4Y
783JrXpOfLpR0avwqlRSCxwSzvCtY+q6pwADYhqafITbFWZNOrLB1aMcIxp7W8CM
UjD0WwHgl6W9kAIXFWZmdQ51Ny5aACqNja+plv0GvtoIvkPoXBYxvJhrd6ncnEw5
JzVzHA0CXTmKr4M8CNl2RfEcOo2BuwaNSopv9XEGHz9Ij2D10RA=
=UX8z
-----END PGP SIGNATURE-----

--zwKHaT/h1ti62TU9--

