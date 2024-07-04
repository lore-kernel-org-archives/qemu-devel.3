Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A7C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPG0o-00045M-Fw; Thu, 04 Jul 2024 02:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG0m-00044B-OZ; Thu, 04 Jul 2024 02:32:08 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG0g-0006UQ-Ma; Thu, 04 Jul 2024 02:32:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-713fa1aea36so84534a12.1; 
 Wed, 03 Jul 2024 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074721; x=1720679521; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIMi0AvqBRT4/4LWMxrnO67VCT0BMrL8MeI1Si6Wm/w=;
 b=isUnTR9VQxxUzQi9GdTbCU+dqVWWV/52yFvoAlm5rJdahfnGjjETx1c7iRXiCGZ6Xc
 GCSgPOuSDAyf/YK63D11WUn1BAyppfsadinWaeFx4H5kFVwpwb9w+knE5NnWrKURAyfE
 AmMpsaHmSuf/i0DA7bxWZ6v2IkyftGxHuaKeiG1ARiZnR60/v1YohAWRrpgt8Nuicq+o
 kSdRJsFM1TaXSADPKXk3N3wWRQhFok5l1JoHfy5o+FWEhW8ZHJJXKSfmBAawrXuNtIG8
 R07APx9jQyqfrV49L3MCpRY0TJcvNKr0p2Wk8AkN5gkMMZGDjKFb20kpjcO6P6ZA/ASR
 qWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074721; x=1720679521;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DIMi0AvqBRT4/4LWMxrnO67VCT0BMrL8MeI1Si6Wm/w=;
 b=h+CJKfatfw5VFMX+UIeLNj9js1p/JOsMG3jLxHK84B8ViJa502o1n/DL614+wqFALy
 laHEiXCRFWi7l+TN5SAv8xLJhLly6zytJb81We5CapZKugunG5jgYDubWw1xYiLPDElK
 7Tfkt6+1qXghtQrvLAF0rngdxgNAMxFahOVOkbvXpW9sq/Hfk18mR61B3uPftymupnfW
 eahpqfv3CSR4xoP1Hu8AD1rzCxdGDoxTwmpwwf0fNSJmTyKCm4vuand/QlKcTxDRUXwA
 v1GLuFuOKSXm4fj7ggFGKnUA308aGdVEAhNytjOQN7vYAAe1vN+pkul8g5wYthVYMyZS
 23AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXza3TjMqN0rPz5IqFq0hpGnlaKP8mcjTtygcOWWeF0BxZWIWvj0aFfYsyr4D8X3s7Ax7zu4wOaQ+sACQTzEawI917FZEKBcR4LsMMOdPPmk2OGEW8zmx/Qur0=
X-Gm-Message-State: AOJu0Yz8YXXKVw2SuuQzOCMte/GD27KHXTO45Iy3B862jgj+THLiza0M
 29nFEoTUjQOl/W5rOmhBbhr+jbxpbr5lQCMROY8/bLcC6zrfrAEg
X-Google-Smtp-Source: AGHT+IHLntVHLuIIohqsQFIFgs4SgdOdhIv0HbJi9AEhAQXlU5U7adPoqyKe/VcYjjSvsG/VVYKWMw==
X-Received: by 2002:a05:6a21:189:b0:1c0:8cc3:6412 with SMTP id
 adf61e73a8af0-1c0cc8c9541mr654171637.47.1720074720742; 
 Wed, 03 Jul 2024 23:32:00 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708024694basm11457670b3a.51.2024.07.03.23.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:32:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:31:55 +1000
Message-Id: <D2GJLJODYKU7.7D9NIVL7GEXY@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 21/43] target/ppc/mmu_common.c: Remove key field from
 mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <dc94408b2c492102c1b0f3965c8780dc7050236c.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <dc94408b2c492102c1b0f3965c8780dc7050236c.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> Pass it as a function parameter and remove it from mmu_ctx_t.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index fe321ab49c..be09c3b1a3 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -41,7 +41,6 @@
>  typedef struct {
>      hwaddr raddr;      /* Real address             */
>      int prot;          /* Protection bits          */
> -    int key;           /* Access key               */
>  } mmu_ctx_t;
> =20
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
> @@ -95,7 +94,7 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong ea=
ddr,
>  static int ppc6xx_tlb_check(CPUPPCState *env,
>                              mmu_ctx_t *ctx, target_ulong eaddr,
>                              MMUAccessType access_type, target_ulong ptem=
,
> -                            bool nx)
> +                            bool key, bool nx)
>  {
>      ppc6xx_tlb_t *tlb;
>      target_ulong *pte1p;
> @@ -140,7 +139,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>          /* Keep the matching PTE information */
>          best =3D nr;
>          ctx->raddr =3D tlb->pte1;
> -        ctx->prot =3D ppc_hash32_prot(ctx->key, tlb->pte1 & HPTE32_R_PP,=
 nx);
> +        ctx->prot =3D ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
>          if (check_prot_access_type(ctx->prot, access_type)) {
>              qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>              ret =3D 0;
> @@ -295,13 +294,14 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>  }
> =20
>  static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                       target_ulong eaddr, hwaddr *hashp=
,
> +                                       target_ulong eaddr,
> +                                       hwaddr *hashp, bool *keyp,
>                                         MMUAccessType access_type, int ty=
pe)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx, ptem;
> -    bool pr, ds, nx;
> +    bool key, pr, ds, nx;
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> @@ -312,7 +312,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      pr =3D FIELD_EX64(env->msr, MSR, PR);
> =20
>      sr =3D env->sr[eaddr >> 28];
> -    ctx->key =3D ppc_hash32_key(pr, sr);
> +    key =3D ppc_hash32_key(pr, sr);
> +    *keyp =3D key;
>      ds =3D sr & SR32_T;
>      nx =3D sr & SR32_NX;
>      vsid =3D sr & SR32_VSID;
> @@ -329,7 +330,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      ptem =3D (vsid << 7) | (pgidx >> 10); /* Virtual segment ID | API */
> =20
>      qemu_log_mask(CPU_LOG_MMU, "pte segment: key=3D%d ds %d nx %d vsid "
> -                  TARGET_FMT_lx "\n", ctx->key, ds, nx, vsid);
> +                  TARGET_FMT_lx "\n", key, ds, nx, vsid);
>      if (!ds) {
>          /* Check if instruction fetch is allowed, if needed */
>          if (type =3D=3D ACCESS_CODE && nx) {
> @@ -343,7 +344,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          *hashp =3D hash;
> =20
>          /* Software TLB search */
> -        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
> +        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key,=
 nx);
>      }
> =20
>      /* Direct-store segment : absolutely *BUGGY* for now */
> @@ -367,8 +368,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      case ACCESS_EXT: /* eciwx or ecowx */
>          return -4;
>      }
> -    if ((access_type =3D=3D MMU_DATA_STORE || ctx->key !=3D 1) &&
> -        (access_type =3D=3D MMU_DATA_LOAD || ctx->key !=3D 0)) {
> +    if ((access_type =3D=3D MMU_DATA_STORE || !key) &&
> +        (access_type =3D=3D MMU_DATA_LOAD || key)) {
>          ctx->raddr =3D eaddr;
>          return 2;
>      }
> @@ -709,6 +710,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>      CPUPPCState *env =3D &cpu->env;
>      mmu_ctx_t ctx;
>      hwaddr hash =3D 0; /* init to 0 to avoid used uninit warning */
> +    bool key;
>      int type, ret;
> =20
>      if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, pro=
tp)) {
> @@ -726,7 +728,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>      }
> =20
>      ctx.prot =3D 0;
> -    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, &hash,
> +    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
>                                        access_type, type);
>      if (ret =3D=3D 0) {
>          *raddrp =3D ctx.raddr;
> @@ -778,7 +780,7 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>              env->spr[SPR_DMISS] =3D eaddr;
>              env->spr[SPR_DCMP] |=3D 0x80000000;
>  tlb_miss:
> -            env->error_code |=3D ctx.key << 19;
> +            env->error_code |=3D key << 19;
>              env->spr[SPR_HASH1] =3D ppc_hash32_hpt_base(cpu) +
>                                    get_pteg_offset32(cpu, hash);
>              env->spr[SPR_HASH2] =3D ppc_hash32_hpt_base(cpu) +


