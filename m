Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2523BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGoo-0008Bd-CX; Thu, 04 Jul 2024 03:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGon-0008B9-Dm; Thu, 04 Jul 2024 03:23:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGol-0007ih-JJ; Thu, 04 Jul 2024 03:23:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9ffd24262so1908875ad.0; 
 Thu, 04 Jul 2024 00:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077826; x=1720682626; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A0iJqgeSJYMYQ73UL0tRJug27HPE3ffc1yMIU4leos=;
 b=hgvF+CoSJUrqiCmewEGWtMeKVMUo24jED0kgfU19dF3CECDB8uJ10c6FRQNu6SMZTO
 MoS1pz6X7NobWOquzLeMQYuab4Yt13pS790I2T98Iu3cohih4keMNOeumQnQre+srqeL
 PQGKdRCWB6mnePsl33j9iq6oBHYKtnviLeXY7zZZKLBjZhz8JDsY1alBuknvR3jnS8AY
 XbYLIqnhTeb+/F9CQVdj4c76OTdk93Qm8DTajRq+2LshulENiDzqJGLnmnxIj8ihlVyi
 PmBVhqX1yf1dfD7+srJbhpQoSjekCnzlGFPK4AZxGHakMTo6mxQCvMTzosY0s4Y7kCYK
 BpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077826; x=1720682626;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8A0iJqgeSJYMYQ73UL0tRJug27HPE3ffc1yMIU4leos=;
 b=aL9G1a9Tkhl7YqiXM+Nd4ebOGysba7o18w1KtjvapdonzyWAAE/TyNyDfylNF5QP52
 zH5slRV50xWpnDoMoGXWAPB2QLRRzBNBqK3YXRfnvezrrXve4NeJkkddHCdGeve4iiFd
 zbWYoFfuQiFLmCtA91Cq7tspTn3izmJvdAjVJpKlu110YgMZ5juXZ5YfdB2195n8ab4b
 qxQsWW8riLfw+4R3RvGzTfbBmDKrukNkSwriAAqDZhnK7AZyuXZq1ZODJF3wyvRrIiMv
 W1itckxrOzfdK/AydS7vIIiiHCaSFffKY3LhJtk2xiLGx1O4+78HHITQFsNWrCPaGWyM
 SUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUloayyu19GR9J/gO6GqjliVtDK0XP3Dk9wKTO3gwWNk1w6r7coguVr3b+CwimQYLoQ9jBMnRrvV/Wv75UvPFyfD9W8r5oJFILS3dJBgUZoptLk2ERmivsGea8=
X-Gm-Message-State: AOJu0YypxK+5nd1MUiCqLozXNwdGcOQ3wndWwKqOICqu3wtG5aldFo/9
 qdZ67D9oN4IjNv8dPSfsuI/zYH5EF1aGzGeyaUNtxVzevW+LkZt7
X-Google-Smtp-Source: AGHT+IEqbl7idm4aCYyuRxJFrnf9H6S2fDwjlhOSZoXKCN9KyVu9D4ljcpLM4MOxeMJDu+KVXXnh7w==
X-Received: by 2002:a05:6a21:18d:b0:1be:f71e:2196 with SMTP id
 adf61e73a8af0-1c0cc75d5c7mr809131637.27.1720077825796; 
 Thu, 04 Jul 2024 00:23:45 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb2bbb0947sm11886145ad.16.2024.07.04.00.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:23:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:23:40 +1000
Message-Id: <D2GKP5ZJALUO.32T039WPN2HL8@gmail.com>
Subject: Re: [PATCH 37/43] target/ppc/mmu-hash32.c: Return and use pte
 address instead of base + offset
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <4aaf949d46cae9fa8e1a20b29492262d874897af.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <4aaf949d46cae9fa8e1a20b29492262d874897af.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> Change ppc_hash32_pteg_search() to return pte address instead of an
> offset to avoid needing to get the base and add offset to it when we
> already have the address we need.

I think this looks good, but would need small rebase if the previous
patch is changed.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 51 ++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 7a6a674f8a..cc1e790d0e 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -204,58 +204,48 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cp=
u, hwaddr pteg_off,
>                                       bool secondary, target_ulong ptem,
>                                       ppc_hash_pte32_t *pte)
>  {
> -    hwaddr pte_offset =3D pteg_off;
> +    hwaddr pte_addr =3D ppc_hash32_hpt_base(cpu) + pteg_off;
>      target_ulong pte0, pte1;
> -    hwaddr base =3D ppc_hash32_hpt_base(cpu);
>      int i;
> =20
> -    for (i =3D 0; i < HPTES_PER_GROUP; i++) {
> -        pte0 =3D ldl_phys(CPU(cpu)->as, base + pte_offset);
> +    for (i =3D 0; i < HPTES_PER_GROUP; i++, pte_addr +=3D HASH_PTE_SIZE_=
32) {
> +        pte0 =3D ldl_phys(CPU(cpu)->as, pte_addr);
>          /*
>           * pte0 contains the valid bit and must be read before pte1,
>           * otherwise we might see an old pte1 with a new valid bit and
>           * thus an inconsistent hpte value
>           */
>          smp_rmb();
> -        pte1 =3D ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZ=
E_32 / 2);
> +        pte1 =3D ldl_phys(CPU(cpu)->as, pte_addr + HASH_PTE_SIZE_32 / 2)=
;
> =20
>          if ((pte0 & HPTE32_V_VALID)
>              && (secondary =3D=3D !!(pte0 & HPTE32_V_SECONDARY))
>              && HPTE32_V_COMPARE(pte0, ptem)) {
>              pte->pte0 =3D pte0;
>              pte->pte1 =3D pte1;
> -            return pte_offset;
> +            return pte_addr;
>          }
> -
> -        pte_offset +=3D HASH_PTE_SIZE_32;
>      }
> -
>      return -1;
>  }
> =20
> -static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_=
t pte1)
> +static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_addr, uint32_t =
pte1)
>  {
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -    hwaddr offset =3D pte_offset + 6;
> -
>      /* The HW performs a non-atomic byte update */
> -    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
> +    stb_phys(CPU(cpu)->as, pte_addr + 6, ((pte1 >> 8) & 0xff) | 0x01);
>  }
> =20
> -static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_=
t pte1)
> +static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_addr, uint64_t =
pte1)
>  {
> -    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> -    hwaddr offset =3D pte_offset + 7;
> -
>      /* The HW performs a non-atomic byte update */
> -    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> +    stb_phys(CPU(cpu)->as, pte_addr + 7, (pte1 & 0xff) | 0x80);
>  }
> =20
>  static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
>                                       target_ulong sr, target_ulong eaddr=
,
>                                       ppc_hash_pte32_t *pte)
>  {
> -    hwaddr pteg_off, pte_offset;
> +    hwaddr pteg_off, pte_addr;
>      hwaddr hash;
>      uint32_t vsid, pgidx, ptem;
> =20
> @@ -277,18 +267,18 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cp=
u,
>              ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu),
>              vsid, ptem, hash);
>      pteg_off =3D get_pteg_offset32(cpu, hash);
> -    pte_offset =3D ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
> -    if (pte_offset =3D=3D -1) {
> +    pte_addr =3D ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
> +    if (pte_addr =3D=3D -1) {
>          /* Secondary PTEG lookup */
>          qemu_log_mask(CPU_LOG_MMU, "1 htab=3D" HWADDR_FMT_plx "/" HWADDR=
_FMT_plx
>                  " vsid=3D%" PRIx32 " api=3D%" PRIx32
>                  " hash=3D" HWADDR_FMT_plx "\n", ppc_hash32_hpt_base(cpu)=
,
>                  ppc_hash32_hpt_mask(cpu), vsid, ptem, ~hash);
>          pteg_off =3D get_pteg_offset32(cpu, ~hash);
> -        pte_offset =3D ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, pt=
e);
> +        pte_addr =3D ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, pte)=
;
>      }
> =20
> -    return pte_offset;
> +    return pte_addr;
>  }
> =20
>  bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access=
_type,
> @@ -298,7 +288,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong sr;
> -    hwaddr pte_offset, raddr;
> +    hwaddr pte_addr, raddr;
>      ppc_hash_pte32_t pte;
>      bool key;
>      int prot;
> @@ -360,8 +350,8 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>      }
> =20
>      /* 6. Locate the PTE in the hash table */
> -    pte_offset =3D ppc_hash32_htab_lookup(cpu, sr, eaddr, &pte);
> -    if (pte_offset =3D=3D -1) {
> +    pte_addr =3D ppc_hash32_htab_lookup(cpu, sr, eaddr, &pte);
> +    if (pte_addr =3D=3D -1) {
>          if (guest_visible) {
>              if (access_type =3D=3D MMU_INST_FETCH) {
>                  cs->exception_index =3D POWERPC_EXCP_ISI;
> @@ -380,7 +370,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>          return false;
>      }
>      qemu_log_mask(CPU_LOG_MMU,
> -                "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset);
> +                  "found PTE at address %08" HWADDR_PRIx "\n", pte_addr)=
;
> =20
>      /* 7. Check access permissions */
>      key =3D ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
> @@ -410,13 +400,12 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>      qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> =20
>      /* 8. Update PTE referenced and changed bits if necessary */
> -
>      if (!(pte.pte1 & HPTE32_R_R)) {
> -        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
> +        ppc_hash32_set_r(cpu, pte_addr, pte.pte1);
>      }
>      if (!(pte.pte1 & HPTE32_R_C)) {
>          if (access_type =3D=3D MMU_DATA_STORE) {
> -            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
> +            ppc_hash32_set_c(cpu, pte_addr, pte.pte1);
>          } else {
>              /*
>               * Treat the page as read-only for now, so that a later writ=
e


