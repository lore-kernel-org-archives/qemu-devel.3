Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D283EC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFvf-00082a-KY; Thu, 04 Jul 2024 02:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFvb-00080E-98; Thu, 04 Jul 2024 02:26:47 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFvK-0003Tc-Tt; Thu, 04 Jul 2024 02:26:43 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d84546a05bso168928b6e.1; 
 Wed, 03 Jul 2024 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074388; x=1720679188; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLuN46C4BGiKw1/tfoptRDY0mOk9Ckz/1JHR/VI42Nc=;
 b=InAulfYs/lutoxRevoEnBwlvuJkbkuNZtxOlb7CJQ0yB4s6b1wMAZBmni6JMMOjIwx
 JVdrYupWQIPnrbffWVNOCNHTtnHQoKzjrkTK7h+ZIdRBdmFduBznUhXKwliSkS4WjL27
 ZnnEXG7MWfbKGrUYDFjtQ85IJp5aVH/s08ZcJwNGhiqHvwA/O738RFGQjBzMiOYSEC4H
 K61wWu1TjcAibL52AVElrMhVICIVdR4usR42/BR7g7g5i0mGLrCcTj2+r7K2bvAK+pRS
 P+gYEFl/VLKrd5LtwzX38gci/UPAE0mEdAuTtbRaNR//NEaBOuUoK+bdpGm3NAOMbrdK
 KXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074388; x=1720679188;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cLuN46C4BGiKw1/tfoptRDY0mOk9Ckz/1JHR/VI42Nc=;
 b=R0pi14U9Bs7Ds5q+ER+jN/q0u8wbNi5o3dRTI5LS/MNFMazUwivwVCsR3lJppaTRYH
 ykv97pQPSkV57iu3wj2Jw4ESKOn2O9SbiTm6eFt43SZCE+pScMtuTcVeZuJRAGvhSfv7
 gHhkAs87EfLCuaTcbCnf2PKElvC9ThCa5OAkEVEzh+kjASZXrH2IbI9zVWRuX8wHHUtR
 nfJJggFrLPo8NREF5q1QM0w1UFhfPZAtT1krn/9fDlNqJMAkQrLoUORORx0FD37/t5WZ
 ueCu70OTv7idbf3C2ccr6HbPsEqJdXjyPywlF/LCDlPwYuayvP0kvzEfB22XVWPUX7BM
 UAgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNgLgCufFN5i8WSlX4esULmX7TLtK4AIJDQhoKfcvQpRG4sFT9P/3MDQZLq+tvwTnirLZSiCF9LZRGECQ/74GDIyTM6Vq5VUCJiqT5sifDGW299zihBZGOsM8=
X-Gm-Message-State: AOJu0YwPCS5QPtA/yAP3fSu1CFrAozsMC/461EZzekENahQz/CN8UiST
 puWCRFHYo47UZVp0Wrgkab2qmHHKbln/ergGGORN/t3rL1/n/PhNPUjAQw==
X-Google-Smtp-Source: AGHT+IEfWh2UtbqPx6n7EHOV9VHPkUxomazFE2l8yzRGcXYi887gNUPHThv+6esxjB2pIF6yDRmZog==
X-Received: by 2002:a05:6808:10ca:b0:3d6:32c9:cc58 with SMTP id
 5614622812f47-3d914c8f8f8mr855326b6e.28.1720074388012; 
 Wed, 03 Jul 2024 23:26:28 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70802564236sm11460976b3a.48.2024.07.03.23.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:26:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:26:22 +1000
Message-Id: <D2GJHAKG0ITD.90M3JWSZKLRD@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 17/43] target/ppc/mmu_common.c: Remove ptem field from
 mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <9673b851e2644f7d808fb034ec6cbd1470540381.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <9673b851e2644f7d808fb034ec6cbd1470540381.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> Instead of passing around ptem in context use it once in the same
> function so it can be removed from mmu_ctx_t.

The downside here is now updating the SPRs in different places.

You already passed hash back with a pointer elsewhere, what about
passing ptmem back? I woud prefer that but you're maintaining
this code so if you prefer this... Either way,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 784e833ff2..339df377e8 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -41,7 +41,6 @@
>  typedef struct {
>      hwaddr raddr;      /* Real address             */
>      int prot;          /* Protection bits          */
> -    target_ulong ptem; /* Virtual segment ID | API */
>      int key;           /* Access key               */
>  } mmu_ctx_t;
> =20
> @@ -95,16 +94,18 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong =
eaddr,
> =20
>  static int ppc6xx_tlb_check(CPUPPCState *env,
>                              mmu_ctx_t *ctx, target_ulong eaddr,
> -                            MMUAccessType access_type, bool nx)
> +                            MMUAccessType access_type, target_ulong ptem=
,
> +                            bool nx)
>  {
>      ppc6xx_tlb_t *tlb;
>      target_ulong *pte1p;
>      int nr, best, way, ret;
> +    bool is_code =3D (access_type =3D=3D MMU_INST_FETCH);
> =20
>      best =3D -1;
>      ret =3D -1; /* No TLB found */
>      for (way =3D 0; way < env->nb_ways; way++) {
> -        nr =3D ppc6xx_tlb_getnum(env, eaddr, way, access_type =3D=3D MMU=
_INST_FETCH);
> +        nr =3D ppc6xx_tlb_getnum(env, eaddr, way, is_code);
>          tlb =3D &env->tlb.tlb6[nr];
>          /* This test "emulates" the PTE index match for hardware TLBs */
>          if ((eaddr & TARGET_PAGE_MASK) !=3D tlb->EPN) {
> @@ -124,7 +125,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>                        access_type =3D=3D MMU_INST_FETCH ? 'I' : 'D');
>          /* Check validity and table match */
>          if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) !=3D 0 ||
> -            (tlb->pte0 & PTE_PTEM_MASK) !=3D ctx->ptem) {
> +            (tlb->pte0 & PTE_PTEM_MASK) !=3D ptem) {
>              continue;
>          }
>          /* all matches should have equal RPN, WIMG & PP */
> @@ -164,6 +165,10 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>              }
>          }
>      }
> +    if (ret =3D=3D -1) {
> +        int r =3D is_code ? SPR_ICMP : SPR_DCMP;
> +        env->spr[r] =3D ptem;
> +    }
>  #if defined(DUMP_PAGE_TABLES)
>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {
>          CPUState *cs =3D env_cpu(env);
> @@ -293,7 +298,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
> -    target_ulong vsid, sr, pgidx;
> +    target_ulong vsid, sr, pgidx, ptem;
>      bool pr, ds, nx;
> =20
>      /* First try to find a BAT entry if there are any */
> @@ -320,7 +325,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>                    access_type =3D=3D MMU_DATA_STORE, type);
>      pgidx =3D (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
>      hash =3D vsid ^ pgidx;
> -    ctx->ptem =3D (vsid << 7) | (pgidx >> 10);
> +    ptem =3D (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
> =20
>      qemu_log_mask(CPU_LOG_MMU, "pte segment: key=3D%d ds %d nx %d vsid "
>                    TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
> @@ -339,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          /* Initialize real address with an invalid value */
>          ctx->raddr =3D (hwaddr)-1ULL;
>          /* Software TLB search */
> -        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, nx);
> +        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
>      }
> =20
>      /* Direct-store segment : absolutely *BUGGY* for now */
> @@ -741,7 +746,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>              cs->exception_index =3D POWERPC_EXCP_IFTLB;
>              env->error_code =3D 1 << 18;
>              env->spr[SPR_IMISS] =3D eaddr;
> -            env->spr[SPR_ICMP] =3D 0x80000000 | ctx.ptem;
> +            env->spr[SPR_ICMP] |=3D 0x80000000;
>              goto tlb_miss;
>          case -2:
>              /* Access rights violation */
> @@ -772,7 +777,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>                  env->error_code =3D 0;
>              }
>              env->spr[SPR_DMISS] =3D eaddr;
> -            env->spr[SPR_DCMP] =3D 0x80000000 | ctx.ptem;
> +            env->spr[SPR_DCMP] |=3D 0x80000000;
>  tlb_miss:
>              env->error_code |=3D ctx.key << 19;
>              env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +


