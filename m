Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD014C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGqS-00017T-FE; Thu, 04 Jul 2024 03:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGqL-00016v-Nj; Thu, 04 Jul 2024 03:25:26 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGpy-00082J-Lg; Thu, 04 Jul 2024 03:25:16 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7f3d59ff826so13230739f.3; 
 Thu, 04 Jul 2024 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077899; x=1720682699; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XL8AI5Ymq0bzxxc7HB7sVFxNLhfrMnfc9Ou2uomqwrs=;
 b=JQHqkyBmPhGCvj5gfEuVyA32wcCSD1Bqbs/uNj9knvWxEJtgqYjPOvvJDUAajFjxQr
 H6SlEhXk94bad/a8eTTx7PjNLxhrevkzQMUazNk3uQoIHAkzBq+1OuJxJhYs6ULr9y88
 212S59cZycFF8YzDzlyOXX/IBV0Si3DgVcL78nOIdVSiULvY1uwcMCCW2C+zEooWS/1D
 ekoxfq9Wsj++IO1Yu1TCZyd5wOyzCEujn4jUoSL/4HQT/m8+dz5VlP/nylBLunIpnepX
 qmf7LxuEYjOl7LuuhXnDevVor8YiBKNiH1ioM5q1EgpOPYabXMPb7flXDQgRJrVhEkGc
 CJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077899; x=1720682699;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XL8AI5Ymq0bzxxc7HB7sVFxNLhfrMnfc9Ou2uomqwrs=;
 b=wXnGkc31JFdwJKNVyhIMzr60F3R7OP0uU+djTSIcXdrK2nHNBvAzoGbJ4zJI1uzMJ5
 EGLTH5xxEpTNK4c3D4yJ2Asrpb0RmNT18+Rks4g4u5VRpeFtwSNu0gbrt5mfXkUyNwU+
 F72grAL18jhSKVtJZ+FrR8nmLAJKLNM7zDwC6tlW857sXyxgquebnnZGCBGJ0H0DZTgm
 3uSt1pO/CJx1ZcQ2Ni/B5hylynq2h92GZ/O1hh5Ty0X08CzkwkkgmpPNpVX4qvcfOYYk
 OMmggOX1Js4MIGO3cacpp27vofPSMKIiY7X7bWEjq9COLnVjQy0zoIb+lDGjuhW5iMpu
 bK2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtT78VxYihQhSCVsyTFcgGgjODijttxdJPD+sENAugCL5UUZzS5jhekdNJEZHy5ayuw2r+FHfFlkXPpq+HCFlX+s0aaCbNSYrNcKX248jK2GTu+A5X25mMCkM=
X-Gm-Message-State: AOJu0YwHcR2HlPKEMpOoJF4sSSSaOPj8wQNy/9aWQTYidx98/HWX3/l0
 dJyopCDBx9Yml1s54Uokz90TcTCRpRJj38QDdZHHJ1Ogii7GYqrC
X-Google-Smtp-Source: AGHT+IHPuJdgChxbI7XY/DQ89jFfaKZjdzW0DJiKKB6N+K3jwrIw4aHw72UiiMMbctFcQqDCEtDZcw==
X-Received: by 2002:a05:6e02:1fe8:b0:375:d79c:16c7 with SMTP id
 e9e14a558f8ab-38398af7a0bmr11180685ab.14.1720077899470; 
 Thu, 04 Jul 2024 00:24:59 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-75e8dfc09f7sm612898a12.26.2024.07.04.00.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:24:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:24:53 +1000
Message-Id: <D2GKQ3QLDI8T.3U02OG4NCAAWM@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 39/43] target/ppc: Change parameter type of some inline
 functions
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <1fdc0583f2e14924123c9a99c250710129b61dfb.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <1fdc0583f2e14924123c9a99c250710129b61dfb.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd29.google.com
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
> These functions take PowerPCCPU but only need the env from it. Change
> their parameter to CPUPPCState *env.

I suppose that's okay. Probably generates a little better code.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 13 +++++++------
>  target/ppc/mmu-hash32.h | 12 ++++++------
>  target/ppc/mmu_common.c | 20 +++++++++-----------
>  3 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 6d0adf3357..f18faf0f46 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -244,10 +244,11 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cp=
u,
>                                       target_ulong sr, target_ulong eaddr=
,
>                                       ppc_hash_pte32_t *pte)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      hwaddr hpt_base, pteg_off, pte_addr, hash;
>      uint32_t vsid, pgidx, ptem;
> =20
> -    hpt_base =3D ppc_hash32_hpt_base(cpu);
> +    hpt_base =3D ppc_hash32_hpt_base(env);
>      vsid =3D sr & SR32_VSID;
>      pgidx =3D (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
>      hash =3D vsid ^ pgidx;
> @@ -256,21 +257,21 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cp=
u,
>      /* Page address translation */
>      qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
>                    HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
> -                  hpt_base, ppc_hash32_hpt_mask(cpu), hash);
> +                  hpt_base, ppc_hash32_hpt_mask(env), hash);
> =20
>      /* Primary PTEG lookup */
>      qemu_log_mask(CPU_LOG_MMU, "0 htab=3D" HWADDR_FMT_plx "/" HWADDR_FMT=
_plx
>                    " vsid=3D%" PRIx32 " ptem=3D%" PRIx32 " hash=3D" HWADD=
R_FMT_plx
> -                  "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, ptem, =
hash);
> -    pteg_off =3D get_pteg_offset32(cpu, hash);
> +                  "\n", hpt_base, ppc_hash32_hpt_mask(env), vsid, ptem, =
hash);
> +    pteg_off =3D get_pteg_offset32(env, hash);
>      pte_addr =3D ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 0, pte=
m, pte);
>      if (pte_addr =3D=3D -1) {
>          /* Secondary PTEG lookup */
>          qemu_log_mask(CPU_LOG_MMU, "1 htab=3D" HWADDR_FMT_plx "/" HWADDR=
_FMT_plx
>                        " vsid=3D%" PRIx32 " api=3D%" PRIx32 " hash=3D" HW=
ADDR_FMT_plx
> -                      "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, pt=
em,
> +                      "\n", hpt_base, ppc_hash32_hpt_mask(env), vsid, pt=
em,
>                        ~hash);
> -        pteg_off =3D get_pteg_offset32(cpu, ~hash);
> +        pteg_off =3D get_pteg_offset32(env, ~hash);
>          pte_addr =3D ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 1,=
 ptem,
>                                            pte);
>      }
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 4db55fb0a0..ec8d881def 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -59,19 +59,19 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, M=
MUAccessType access_type,
>  #define HPTE32_R_WIMG           0x00000078
>  #define HPTE32_R_PP             0x00000003
> =20
> -static inline hwaddr ppc_hash32_hpt_base(PowerPCCPU *cpu)
> +static inline hwaddr ppc_hash32_hpt_base(CPUPPCState *env)
>  {
> -    return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
> +    return env->spr[SPR_SDR1] & SDR_32_HTABORG;
>  }
> =20
> -static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
> +static inline hwaddr ppc_hash32_hpt_mask(CPUPPCState *env)
>  {
> -    return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
> +    return ((env->spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
>  }
> =20
> -static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
> +static inline hwaddr get_pteg_offset32(CPUPPCState *env, hwaddr hash)
>  {
> -    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
> +    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(env);
>  }
> =20
>  static inline bool ppc_hash32_key(bool pr, target_ulong sr)
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 60f8736210..b45eb64f6e 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -166,8 +166,8 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr =
*raddr, int *prot,
>  #if defined(DUMP_PAGE_TABLES)
>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {
>          CPUState *cs =3D env_cpu(env);
> -        hwaddr base =3D ppc_hash32_hpt_base(env_archcpu(env));
> -        hwaddr len =3D ppc_hash32_hpt_mask(env_archcpu(env)) + 0x80;
> +        hwaddr base =3D ppc_hash32_hpt_base(env);
> +        hwaddr len =3D ppc_hash32_hpt_mask(env) + 0x80;
>          uint32_t a0, a1, a2, a3;
> =20
>          qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\=
n",
> @@ -263,7 +263,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, hwaddr *raddr,
>                                         hwaddr *hashp, bool *keyp,
>                                         MMUAccessType access_type, int ty=
pe)
>  {
> -    PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx, ptem;
>      bool key, ds, nx;
> @@ -305,7 +304,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, hwaddr *raddr,
>          /* Page address translation */
>          qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_ma=
sk "
>                        HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
> -                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu)=
, hash);
> +                      ppc_hash32_hpt_base(env), ppc_hash32_hpt_mask(env)=
, hash);
>          *hashp =3D hash;
> =20
>          /* Software TLB search */
> @@ -499,13 +498,12 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int =
type)
> =20
>  static void mmu6xx_dump_mmu(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu =3D env_archcpu(env);
>      ppc6xx_tlb_t *tlb;
>      target_ulong sr;
>      int type, way, entry, i;
> =20
> -    qemu_printf("HTAB base =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(=
cpu));
> -    qemu_printf("HTAB mask =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(=
cpu));
> +    qemu_printf("HTAB base =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(=
env));
> +    qemu_printf("HTAB mask =3D 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(=
env));
> =20
>      qemu_printf("\nSegment registers:\n");
>      for (i =3D 0; i < 32; i++) {
> @@ -743,10 +741,10 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr ea=
ddr,
>              env->spr[SPR_DCMP] |=3D 0x80000000;
>  tlb_miss:
>              env->error_code |=3D key << 19;
> -            env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
> -                                  get_pteg_offset32(cpu, hash);
> -            env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +
> -                                  get_pteg_offset32(cpu, ~hash);
> +            env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(env) +
> +                                  get_pteg_offset32(env, hash);
> +            env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(env) +
> +                                  get_pteg_offset32(env, ~hash);
>              break;
>          case -2:
>              /* Access rights violation */


