Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75808C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4J6R-0007LP-VX; Tue, 07 May 2024 07:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4J6J-0007Jy-CP; Tue, 07 May 2024 07:35:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4J6F-0005Ws-Df; Tue, 07 May 2024 07:35:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ed96772f92so20479425ad.0; 
 Tue, 07 May 2024 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715081709; x=1715686509; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUfisGXlQ6XIMnU7ToSy8ElBx4rzS5Tl99dEAuichME=;
 b=lUDzUfnGNBmBHwzUZZEx/Yfhb49CmGMUjctBeUWvY5RqiWzYzK65Q3RDZerCgiNrP3
 iyalge94SRHA2JjhhhQAWlyHGcu4rNZNOsOlGXN91VtRCk6CUpKcRmW2LjAl2K6D538S
 LJqB6vSSOg3jFOpm7ZPpI8r450eS7iyOtuGR7nRR82HpoXv8tml2+Ukyzim4aHAlkHId
 5AhUzlrXE3UbLSiRuRXDf1on6DZa2dnhHXgLNCtl8Vl/tQDzxvhzr4QxjUYCSN8Y6lMF
 XMHActVGohZvmB0gPDSqSKt2MlEUgMdhz+OJaCtWHjkKqDqaqIoV4VJRzJOwWKtACHYL
 FlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715081709; x=1715686509;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nUfisGXlQ6XIMnU7ToSy8ElBx4rzS5Tl99dEAuichME=;
 b=Er4cdOuhhUBoUVSGNJTpsKVWV/Jqecvdu6oTRA99FXAszBZdp9+OPm5M9kFHuk7ggZ
 ha9Y1IsOe5ka8MCZQ2lus4NckI7OwygzYh3r+lkkllhxWW+IksJBKtFxJ/Tojp+lJPjK
 FgpUfog9JvP4ZqTURx0Gp7xau0cmyfbXoWdq2uvBl15iSRb8uC/xwLZ1XOfp/MN8L8Sa
 rUPGy4YTs9urPtRsN2GlGt9I1JmpCbTcPEF7SwDE9lak3gAg9g62U+9LTR+HQ4yQjhNJ
 gW5+Rb/kmgOVgZ5JmhlTCW5dro1UjK3U8tp81tonljBKDW5bG/zvFVHxDHUIJOP8o0go
 /R+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50/H64JHo1j4KdKz4Dpi2B44S9vbucxFwS4iCE4C5YDoa+A+k+iFPSqyO/Mk2xZUchr4DXjrK3fWLS47Yi2PePVqt3gVW+QX3p6X2gmFEn1Hft3sv0Ru387Q=
X-Gm-Message-State: AOJu0YwmVRTgnOVK35steNrJwdfao+tXXUuyd1o3FNigJyIz6nOW1M94
 5SjZOiHiAXT17n+iJQEZ4mqAldE11wnNTbKJPBYZtxToviJ7p3MY
X-Google-Smtp-Source: AGHT+IF7GB5UGEzpsyRzjHSXTXSXbu/+2nnNNjWIwDHD6urq1mWKqziPHeN/v4uE9FkDGeYTZwvOtA==
X-Received: by 2002:a17:902:e5cb:b0:1e2:c8f9:4cd7 with SMTP id
 u11-20020a170902e5cb00b001e2c8f94cd7mr13236055plf.64.1715081709322; 
 Tue, 07 May 2024 04:35:09 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a170902e88600b001e96982c4fbsm9803396plg.118.2024.05.07.04.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 04:35:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 21:35:04 +1000
Message-Id: <D13DQ21WSMJQ.2KDPTPCN9FM4G@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 22/28] target/ppc: Remove ppc_hash32_pp_prot() and
 reuse common function
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <cc6221f9333bae65037c42ca9ba0540f9e96c493.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <cc6221f9333bae65037c42ca9ba0540f9e96c493.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
> pp_check() in mmu_common.c. Rename the latter to ppc_pte_prot() and
> merge with ppc_hash32_pp_prot() to remove duplicated code.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   |  2 +-
>  target/ppc/mmu-hash32.c | 47 +----------------------------------------
>  target/ppc/mmu_common.c | 19 +++++++++--------
>  3 files changed, 12 insertions(+), 56 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 61c2aadd0d..d7c923b017 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -255,7 +255,7 @@ static inline int prot_for_access_type(MMUAccessType =
access_type)
>  #ifndef CONFIG_USER_ONLY
> =20
>  /* PowerPC MMU emulation */
> -
> +int ppc_pte_prot(int key, int pp, int nx);

Hmm, these were split by 496272a7018. 64 was being split
out too at the time, so maybe not immediately obvious
they were the same.

Good consolidation but can you keep pp in the name?
It's taking ppc's PTE[pp] (page protection) field and
converting it to QEMU prot value.

ppc_hash32_pp_prot is probably fine, 6xx is hash too.
and could stay in mmu-hash32.c, so just use that
version unchanged?

Thanks,
Nick

>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
>                        int mmu_idx, bool guest_visible);
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 3976416840..ee9df351ae 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -42,51 +42,6 @@ struct mmu_ctx_hash32 {
>      int key;                       /* Access key                */
>  };
> =20
> -static int ppc_hash32_pp_prot(int key, int pp, int nx)
> -{
> -    int prot;
> -
> -    if (key =3D=3D 0) {
> -        switch (pp) {
> -        case 0x0:
> -        case 0x1:
> -        case 0x2:
> -            prot =3D PAGE_READ | PAGE_WRITE;
> -            break;
> -
> -        case 0x3:
> -            prot =3D PAGE_READ;
> -            break;
> -
> -        default:
> -            abort();
> -        }
> -    } else {
> -        switch (pp) {
> -        case 0x0:
> -            prot =3D 0;
> -            break;
> -
> -        case 0x1:
> -        case 0x3:
> -            prot =3D PAGE_READ;
> -            break;
> -
> -        case 0x2:
> -            prot =3D PAGE_READ | PAGE_WRITE;
> -            break;
> -
> -        default:
> -            abort();
> -        }
> -    }
> -    if (nx =3D=3D 0) {
> -        prot |=3D PAGE_EXEC;
> -    }
> -
> -    return prot;
> -}
> -
>  static int ppc_hash32_pte_prot(int mmu_idx,
>                                 target_ulong sr, ppc_hash_pte32_t pte)
>  {
> @@ -95,7 +50,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
>      key =3D !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
>      pp =3D pte.pte1 & HPTE32_R_PP;
> =20
> -    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
> +    return ppc_pte_prot(key, pp, !!(sr & SR32_NX));
>  }
> =20
>  static target_ulong hash32_bat_size(int mmu_idx,
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 41ef174ab4..0ce5c1e841 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -75,22 +75,23 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong va=
lue)
>  /***********************************************************************=
******/
>  /* PowerPC MMU emulation */
> =20
> -static int pp_check(int key, int pp, int nx)
> +int ppc_pte_prot(int key, int pp, int nx)
>  {
>      int access;
> =20
>      /* Compute access rights */
> -    access =3D 0;
>      if (key =3D=3D 0) {
>          switch (pp) {
>          case 0x0:
>          case 0x1:
>          case 0x2:
> -            access |=3D PAGE_WRITE;
> -            /* fall through */
> +            access =3D PAGE_READ | PAGE_WRITE;
> +            break;
>          case 0x3:
> -            access |=3D PAGE_READ;
> +            access =3D PAGE_READ;
>              break;
> +        default:
> +            g_assert_not_reached();
>          }
>      } else {
>          switch (pp) {
> @@ -104,6 +105,8 @@ static int pp_check(int key, int pp, int nx)
>          case 0x2:
>              access =3D PAGE_READ | PAGE_WRITE;
>              break;
> +        default:
> +            g_assert_not_reached();
>          }
>      }
>      if (nx =3D=3D 0) {
> @@ -140,7 +143,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>                                  MMUAccessType access_type)
>  {
>      target_ulong ptem, mmask;
> -    int access, ret, pteh, ptev, pp;
> +    int ret, pteh, ptev, pp;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
> @@ -159,11 +162,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targ=
et_ulong pte0,
>                      return -3;
>                  }
>              }
> -            /* Compute access rights */
> -            access =3D pp_check(ctx->key, pp, ctx->nx);
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
> -            ctx->prot =3D access;
> +            ctx->prot =3D ppc_pte_prot(ctx->key, pp, ctx->nx);
>              ret =3D check_prot(ctx->prot, access_type);
>              if (ret =3D=3D 0) {
>                  /* Access granted */


