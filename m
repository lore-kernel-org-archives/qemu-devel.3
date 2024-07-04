Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A549FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGiE-0000hO-Fe; Thu, 04 Jul 2024 03:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGhv-0000bZ-Ez; Thu, 04 Jul 2024 03:16:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGhg-0002hS-81; Thu, 04 Jul 2024 03:16:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb0d88fdc8so1371645ad.2; 
 Thu, 04 Jul 2024 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077384; x=1720682184; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oezTeJBRlFuNdoRr4itJQE5TWsPguCtpbNGnqiaxMw=;
 b=jO8pznpYA73JFbJ8sIoY+b2WCxP+1HOUpgSpmtBYKg4TpMkpzPHS4kLIQFBnRjrB2E
 k8hSE3Bp5cEG1m1omycHvJe++t+7k6bfp0DuaRqpszmxcWj2xNzlWpIxqCQ1SR9rPiZk
 LZGap/Qt0mMwGN0lUdtlA1fLwVcdIug/fS3QLMbXEr59+2k0RdmqaD593g6qZte//og4
 Ig4L/2G477xaROQIcJ2pUsy4Bi1NLL1iIdl0U+XYwXhGmg6lnNFa3ohpPynpr4ZgMjPE
 C4ki1NYd0uX4MdiyRK4W4kuNZaGvPn+UxTAQ7K+81MMODIFBSDdD7bCVqmZphW9n/Arb
 VOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077384; x=1720682184;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6oezTeJBRlFuNdoRr4itJQE5TWsPguCtpbNGnqiaxMw=;
 b=DGZcircG4FuBbxX+fqC2FSSaBJs/+cLaDQYa75pzOmA/P/hWTyhNKIh2GFZkgBAzc0
 HTmfHNPcTTfWP0P9BztwugZLa2LPDsuTrZgVWPVXh4ElK4pKaDn7kq3Ir0Aj6U3rtzkQ
 pz8fkV6OWShkIQyia4GOTTq3t+pzbfnBs/AjHnusOwrQ00bmLV2HSvppOSjc0Cn5k8M8
 uGqZsh+3do3FkNEN2yc6NASe+VHNdjoaVrcqSgNLAzWt747QfyoBM7Yn5/MZXG9YnUJu
 OFpU9c9I87GRgjmQmiUjG210xZ1NxxVqkW6CPFAgF4M71PVaxathwLyuqRC3B24kukQt
 qvzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX08czooAf6RvMkdz7PIbmPm9NCYz+itfOosjUdv7xRyLVAA6zyIssquXQUauAC7x6NBmRLyRE4Rnz/iuMePIpqERU8XasMphlWPb+S8Qa5SFo/WOVdVnrgWd4=
X-Gm-Message-State: AOJu0Yy5peibNwQy1gYvAlwIkHSqJWKMz0LadGYL9mbBlqPTArdi2b7p
 W8JoXt3qJOCEuL+54UDtedXBG3gneK1JuPVO1gcyDWNeBWjFr8NR
X-Google-Smtp-Source: AGHT+IGIGyyXzuiCjfnegwS2B5iTjWkvDcSBJA94ftw6wgiTWbGKs7FyomPWk33EfQmXOe0FEd4pOA==
X-Received: by 2002:a17:903:1111:b0:1fa:2e4:204d with SMTP id
 d9443c01a7336-1fb33edfd04mr6078685ad.43.1720077383930; 
 Thu, 04 Jul 2024 00:16:23 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb36ff02e4sm5131715ad.116.2024.07.04.00.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:16:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:16:18 +1000
Message-Id: <D2GKJIW74X64.RE6VSXU1TTQP@gmail.com>
Subject: Re: [PATCH 30/43] target/ppc: Unexport some functions from
 mmu-book3s-v3.h
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <d024465e3cf461c3106e758d753b93cc2590eaba.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <d024465e3cf461c3106e758d753b93cc2590eaba.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> The ppc_hash64_hpt_base() and ppc_hash64_hpt_mask() functions are
> mostly used by mmu-hash64.c only but there is one call to
> ppc_hash64_hpt_mask() in hw/ppc/spapr_vhyp_mmu.c.in a helper function
> that can be moved to mmu-hash64.c which allows these functions to be
> removed from the header.
>

Fine. Probably too big to inline anyway.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/spapr_vhyp_mmu.c    | 21 ++++------------
>  target/ppc/mmu-book3s-v3.h | 40 -------------------------------
>  target/ppc/mmu-hash64.c    | 49 ++++++++++++++++++++++++++++++++++++++
>  target/ppc/mmu-hash64.h    |  1 +
>  4 files changed, 54 insertions(+), 57 deletions(-)
>
> diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
> index b3dd8b3a59..2d41d7f77b 100644
> --- a/hw/ppc/spapr_vhyp_mmu.c
> +++ b/hw/ppc/spapr_vhyp_mmu.c
> @@ -15,19 +15,6 @@
>  #include "helper_regs.h"
>  #include "hw/ppc/spapr.h"
>  #include "mmu-hash64.h"
> -#include "mmu-book3s-v3.h"
> -
> -
> -static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
> -{
> -    /*
> -     * hash value/pteg group index is normalized by HPT mask
> -     */
> -    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) =
{
> -        return false;
> -    }
> -    return true;
> -}
> =20
>  static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                              target_ulong opcode, target_ulong *args)
> @@ -70,7 +57,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
> =20
>      pteh &=3D ~0x60ULL;
> =20
> -    if (!valid_ptex(cpu, ptex)) {
> +    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
>          return H_PARAMETER;
>      }
> =20
> @@ -119,7 +106,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu
>      const ppc_hash_pte64_t *hptes;
>      target_ulong v, r;
> =20
> -    if (!valid_ptex(cpu, ptex)) {
> +    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
>          return REMOVE_PARM;
>      }
> =20
> @@ -250,7 +237,7 @@ static target_ulong h_protect(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
>      const ppc_hash_pte64_t *hptes;
>      target_ulong v, r;
> =20
> -    if (!valid_ptex(cpu, ptex)) {
> +    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
>          return H_PARAMETER;
>      }
> =20
> @@ -287,7 +274,7 @@ static target_ulong h_read(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      int i, ridx, n_entries =3D 1;
>      const ppc_hash_pte64_t *hptes;
> =20
> -    if (!valid_ptex(cpu, ptex)) {
> +    if (!ppc_hash64_valid_ptex(cpu, ptex)) {
>          return H_PARAMETER;
>      }
> =20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index f3f7993958..263ce55c1f 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -83,46 +83,6 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
>  }
> =20
> -static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
> -{
> -    uint64_t base;
> -
> -    if (cpu->vhyp) {
> -        return 0;
> -    }
> -    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
> -        ppc_v3_pate_t pate;
> -
> -        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
> -            return 0;
> -        }
> -        base =3D pate.dw0;
> -    } else {
> -        base =3D cpu->env.spr[SPR_SDR1];
> -    }
> -    return base & SDR_64_HTABORG;
> -}
> -
> -static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
> -{
> -    uint64_t base;
> -
> -    if (cpu->vhyp) {
> -        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
> -    }
> -    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
> -        ppc_v3_pate_t pate;
> -
> -        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
> -            return 0;
> -        }
> -        base =3D pate.dw0;
> -    } else {
> -        base =3D cpu->env.spr[SPR_SDR1];
> -    }
> -    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
> -}
> -
>  #endif /* TARGET_PPC64 */
> =20
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index cbc8efa0c3..7bc0323f26 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -508,6 +508,46 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_=
hash_pte64_t pte)
>      return prot;
>  }
> =20
> +static hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
> +{
> +    uint64_t base;
> +
> +    if (cpu->vhyp) {
> +        return 0;
> +    }
> +    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        ppc_v3_pate_t pate;
> +
> +        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
> +            return 0;
> +        }
> +        base =3D pate.dw0;
> +    } else {
> +        base =3D cpu->env.spr[SPR_SDR1];
> +    }
> +    return base & SDR_64_HTABORG;
> +}
> +
> +static hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
> +{
> +    uint64_t base;
> +
> +    if (cpu->vhyp) {
> +        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
> +    }
> +    if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        ppc_v3_pate_t pate;
> +
> +        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
> +            return 0;
> +        }
> +        base =3D pate.dw0;
> +    } else {
> +        base =3D cpu->env.spr[SPR_SDR1];
> +    }
> +    return (1ULL << ((base & SDR_64_HTABSIZE) + 18 - 7)) - 1;
> +}
> +
>  const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
>                                               hwaddr ptex, int n)
>  {
> @@ -545,6 +585,15 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const p=
pc_hash_pte64_t *hptes,
>                          false, n * HASH_PTE_SIZE_64);
>  }
> =20
> +bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
> +{
> +    /* hash value/pteg group index is normalized by HPT mask */
> +    if (((ptex & ~7ULL) / HPTES_PER_GROUP) & ~ppc_hash64_hpt_mask(cpu)) =
{
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static unsigned hpte_page_shift(const PPCHash64SegmentPageSizes *sps,
>                                  uint64_t pte0, uint64_t pte1)
>  {
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index de653fcae5..ae8d4b37ae 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -120,6 +120,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCC=
PU *cpu,
>                                               hwaddr ptex, int n);
>  void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hpt=
es,
>                              hwaddr ptex, int n);
> +bool ppc_hash64_valid_ptex(PowerPCCPU *cpu, target_ulong ptex);
> =20
>  static inline uint64_t ppc_hash64_hpte0(PowerPCCPU *cpu,
>                                          const ppc_hash_pte64_t *hptes, i=
nt i)


