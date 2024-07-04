Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49249C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGNx-0006PC-AG; Thu, 04 Jul 2024 02:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGNv-0006Ol-BZ; Thu, 04 Jul 2024 02:56:03 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGNt-0006r7-Ez; Thu, 04 Jul 2024 02:56:03 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70afe18837cso215482b3a.3; 
 Wed, 03 Jul 2024 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720076159; x=1720680959; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/e4XUFKeP/C1zD0IaiK8ZXn5JvxyC5guzxuW/XjQkI0=;
 b=Rm27IczHgu5jr0ZtmO7Jxf3kG5F8zFcK39R+V7Xp8fMsFZNsoDWlInmliTsBm7fuwB
 h3s319+lX1fvWqKlaOY5xc3ryMfGfFe38j2fcu9vGQq9VDRdG2qGPdbfWWhEe+a2MLPq
 IDZtZNvVk2kgru8ZklWvX8TSNo5wzNnnfBIgBaooQdMWGGrNwRXPN1thLigImo6aqY1j
 GufrDmFn13dFxx08x4OGHnMXVrGVx3bfkCGzqn622UFG0xBZrVg84a3iZ7rhXw2G48KO
 1UIBeBaDG0fG/EUQkPLUEC2356yFDXyyveWREOIpPyeZ6+jo1n+gk2pkOxDD7IfGg8Mr
 Bjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720076159; x=1720680959;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/e4XUFKeP/C1zD0IaiK8ZXn5JvxyC5guzxuW/XjQkI0=;
 b=psgZ9SZHSvvxr04GhgdbGgsFq1T5XGHqiXIZhdFPyGr0SoG4F356Io1AnOgr1mHTcB
 7OuwOBSicsecgsWApwVPovwzuAiUvAHu8ltxBZSlfzyqE7Yek8OCpUCxWO6Xsgw8VoYq
 MChgkFeMCng0pRBLMc1eQ1Yu1JETuQLR9Hu05NPT3zpx4b8JGDsL58s5FW//DF9oPtfz
 uX9BQiT2qsKgFNU0B+TgEQKnEdwFcy+g8u1oZprWvCYH3ZLU+czzZ3QH5xdBxL1H3VXc
 94MQ+PpEH1tJg/2Ug9bPMJ63tAL2jW7imGCfsVSJceYAq9jWqweeSjm9JXiXeZaGWT/l
 YtZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUInBIYLJ9CyXYYm3oeoYF/Gfi4Avaw54AuJBITwyw2DbQPjYjIOAvodX/dmNOjwwCTHd9iTpsV76INm/WlNc/oSzS5S7mNp5z5lPiPUQPjShrQrSDsumFj2Y0=
X-Gm-Message-State: AOJu0Yy6dp8l4HCxrv/Wslt39RZryKQb1fvbJbyL5/gkRd4tO6T9G4pe
 58CshEMAu7vU6LnfQfAXiE4dFFnVWINX17ynBIy+3ks7ariOq32e2HoSlg==
X-Google-Smtp-Source: AGHT+IGSKPlt38cLnPgrv8RGeyrnNsDUPvGVjhwSTwuWiYlarGCgRza02EYTlZYb2avXi5FZddcf+A==
X-Received: by 2002:a05:6a00:2d8f:b0:706:6f82:7e0c with SMTP id
 d2e1a72fcca58-70b00ad14eamr865004b3a.32.1720076159460; 
 Wed, 03 Jul 2024 23:55:59 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecfce9sm11545721b3a.101.2024.07.03.23.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:55:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:55:53 +1000
Message-Id: <D2GK3WB9X38H.67PWCTA8385M@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 25/43] target/ppc: Remove bat_size_prot()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <bdb79c79ec33b22071f1ffc641dcfefe9f90ec84.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <bdb79c79ec33b22071f1ffc641dcfefe9f90ec84.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
> There is already a hash32_bat_prot() function that does most if this
> and the rest can be inlined. Export hash32_bat_prot() and rename it to
> ppc_hash32_bat_prot() to match other functions and use it in
> get_bat_6xx_tlb().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 18 +-------------
>  target/ppc/mmu-hash32.h | 14 +++++++++++
>  target/ppc/mmu_common.c | 52 ++++++++++-------------------------------
>  3 files changed, 27 insertions(+), 57 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 160311de87..6f0f0bbb00 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -48,22 +48,6 @@ static target_ulong hash32_bat_size(int mmu_idx,
>      return BATU32_BEPI & ~((batu & BATU32_BL) << 15);
>  }
> =20
> -static int hash32_bat_prot(PowerPCCPU *cpu,
> -                           target_ulong batu, target_ulong batl)
> -{
> -    int pp, prot;
> -
> -    prot =3D 0;
> -    pp =3D batl & BATL32_PP;
> -    if (pp !=3D 0) {
> -        prot =3D PAGE_READ | PAGE_EXEC;
> -        if (pp =3D=3D 0x2) {
> -            prot |=3D PAGE_WRITE;
> -        }
> -    }
> -    return prot;
> -}
> -
>  static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
>                                      MMUAccessType access_type, int *prot=
,
>                                      int mmu_idx)
> @@ -95,7 +79,7 @@ static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, ta=
rget_ulong ea,
>          if (mask && ((ea & mask) =3D=3D (batu & BATU32_BEPI))) {
>              hwaddr raddr =3D (batl & mask) | (ea & ~mask);
> =20
> -            *prot =3D hash32_bat_prot(cpu, batu, batl);
> +            *prot =3D ppc_hash32_bat_prot(batu, batl);
> =20
>              return raddr & TARGET_PAGE_MASK;
>          }
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 5902cf8333..bd75f7d647 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -143,6 +143,20 @@ static inline int ppc_hash32_prot(bool key, int pp, =
bool nx)
>      return nx ? prot : prot | PAGE_EXEC;
>  }
> =20
> +static inline int ppc_hash32_bat_prot(target_ulong batu, target_ulong ba=
tl)
> +{
> +    int prot =3D 0;
> +    int pp =3D batl & BATL32_PP;
> +
> +    if (pp) {
> +        prot =3D PAGE_READ | PAGE_EXEC;
> +        if (pp =3D=3D 0x2) {
> +            prot |=3D PAGE_WRITE;
> +        }
> +    }
> +    return prot;
> +}
> +
>  typedef struct {
>      uint32_t pte0, pte1;
>  } ppc_hash_pte32_t;
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index aa002bba35..624ed51a92 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -193,40 +193,13 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwadd=
r *raddr, int *prot,
>      return ret;
>  }
> =20
> -/* Perform BAT hit & translation */
> -static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
> -                                 int *validp, int *protp, target_ulong *=
BATu,
> -                                 target_ulong *BATl)
> -{
> -    target_ulong bl;
> -    int pp, valid, prot;
> -
> -    bl =3D (*BATu & BATU32_BL) << 15;
> -    valid =3D 0;
> -    prot =3D 0;
> -    if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
> -        (FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000001))) {
> -        valid =3D 1;
> -        pp =3D *BATl & 0x00000003;
> -        if (pp !=3D 0) {
> -            prot =3D PAGE_READ | PAGE_EXEC;
> -            if (pp =3D=3D 0x2) {
> -                prot |=3D PAGE_WRITE;
> -            }
> -        }
> -    }
> -    *blp =3D bl;
> -    *validp =3D valid;
> -    *protp =3D prot;
> -}
> -
>  static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                           target_ulong eaddr, MMUAccessType access_type=
)
> +                           target_ulong eaddr, MMUAccessType access_type=
,
> +                           bool pr)
>  {
>      target_ulong *BATlt, *BATut, *BATu, *BATl;
>      target_ulong BEPIl, BEPIu, bl;
> -    int i, valid, prot;
> -    int ret =3D -1;
> +    int i, ret =3D -1;
>      bool ifetch =3D access_type =3D=3D MMU_INST_FETCH;
> =20
>      qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func=
__,
> @@ -243,20 +216,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ct=
x_t *ctx,
>          BATl =3D &BATlt[i];
>          BEPIu =3D *BATu & BATU32_BEPIU;
>          BEPIl =3D *BATu & BATU32_BEPIL;
> -        bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
>          qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu=
 "
>                        TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func_=
_,
>                        ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
> -        if ((eaddr & BATU32_BEPIU) =3D=3D BEPIu &&
> -            ((eaddr & BATU32_BEPIL) & ~bl) =3D=3D BEPIl) {
> -            /* BAT matches */
> -            if (valid !=3D 0) {
> +        bl =3D (*BATu & BATU32_BL) << 15;
> +        if ((!pr && (*BATu & BATU32_VS)) || (pr && (*BATu & BATU32_VP)))=
 {
> +            if ((eaddr & BATU32_BEPIU) =3D=3D BEPIu &&
> +                ((eaddr & BATU32_BEPIL) & ~bl) =3D=3D BEPIl) {
>                  /* Get physical address */
>                  ctx->raddr =3D (*BATl & BATU32_BEPIU) |
>                      ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL=
)) |
>                      (eaddr & 0x0001F000);
>                  /* Compute access rights */
> -                ctx->prot =3D prot;
> +                ctx->prot =3D ppc_hash32_bat_prot(*BATu, *BATl);
>                  if (check_prot_access_type(ctx->prot, access_type)) {
>                      qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR=
_FMT_plx
>                                    " prot=3D%c%c\n", i, ctx->raddr,
> @@ -300,16 +272,16 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>      PowerPCCPU *cpu =3D env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid, sr, pgidx, ptem;
> -    bool key, pr, ds, nx;
> +    bool key, ds, nx;
> +    bool pr =3D FIELD_EX64(env->msr, MSR, PR);
> =20
>      /* First try to find a BAT entry if there are any */
> -    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> +    if (env->nb_BATs &&
> +        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) =3D=3D 0) {
>          return 0;
>      }
> =20
>      /* Perform segment based translation when no BATs matched */
> -    pr =3D FIELD_EX64(env->msr, MSR, PR);
> -
>      sr =3D env->sr[eaddr >> 28];
>      key =3D ppc_hash32_key(pr, sr);
>      *keyp =3D key;


