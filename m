Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CEFC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gtf-0002Bp-A0; Wed, 08 May 2024 08:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gtd-0002BM-Mr; Wed, 08 May 2024 08:59:45 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gta-0004oQ-QI; Wed, 08 May 2024 08:59:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b4952a1b51so3329027a91.0; 
 Wed, 08 May 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715173181; x=1715777981; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8/JzhXWzLe+h44Q9nFJDW8OEvJknZ6fYD8T3B8zk1I=;
 b=hoX3fY80HOk1Z5JYSVFIPBYZ1GY0CByKnXHU4FJjQ9Jj7lsxcl+unNKF/L6QUXavOO
 NWmgX4NrEY1Mh7AUu1nc8aSEdloZzYNz6jgIsEB/ewFWgatpD2b5rZWdZ2hSyUm1blad
 Lwjn2DtB/a3RuBeCDqdeMAP36wxqxHijNE2XFHgu4M7VnTk3EbqzqSQoRYr6C78+ROk3
 jFSOcM3C5VKsd+eimqkIAMa6sx8Z+Pbt1SM8VwZbpjbR6UWxQVh98pI5klRY7YbcVAjN
 y1tAsbEEwEHiTPeO4BT2WEeE2UdkMPGiWK/wdsaG6nRKgpMV7N4lvxqbdZBu7PnNPdXE
 RzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173181; x=1715777981;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k8/JzhXWzLe+h44Q9nFJDW8OEvJknZ6fYD8T3B8zk1I=;
 b=tlTpJLvVArMiifgnZtfCMEowPE6kGAu076Pf6OEwLUo0Y1xRFS1bO+ufrNI6VvDCGE
 j9aXooqZHSvn/rMMDeUtcK6T/wOeSWmo0UnoX4eddFMKLOFvi9iJw+vibna5VVfQyb6E
 gMr1F7qDV3XYTIvjwJASKp1K4AJ5SNxtwLGraCpCg/K2NqxNgW0BzYbcWAFiQxaZOpat
 SbWi4pGAfT728gBB6L2RXrHyHSS9i0tZPU5gzCxvZNyN+NZ4X7cVZOqr098KgtijqsRC
 QAbKZjg1bVttQdPwPCDN3np5hQG6g3Z2xoRuLyg98dEkE5L3OJEJfqDZJ6tvjZITJly0
 qTvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWi9O5W3QVUg5i7QkPTeV9IoPPIS7cU4peFVEPl8hSl63zUjDmLKtLFKEpBpWTEvbdulGFP002k9FWTimbZRxzvRHcDi5vgChkm+BjMlBajkyT20p2C1ROukQ=
X-Gm-Message-State: AOJu0YzHTy1Ivy/a5noyMhCNkQ2qWhm0qosiosZsXqj7hRoVmLoj93+p
 fERVv8U1zjiNzobTs3rA9XGki3VYVQf7CwqqUKQyfdR1HBzjloN7
X-Google-Smtp-Source: AGHT+IESAyjKe2JxSvdtsNn4yFFDACVGbJowfj5/9yqgWXlAhQNDMq+mVw2TrAx8eDKrFB4XvY6bQA==
X-Received: by 2002:a17:90b:2357:b0:2a9:f861:223e with SMTP id
 98e67ed59e1d1-2b6167d1d07mr2423682a91.29.1715173180936; 
 Wed, 08 May 2024 05:59:40 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 o8-20020a17090ab88800b002b2927bf5b6sm1364988pjr.16.2024.05.08.05.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:59:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:59:35 +1000
Message-Id: <D14A5BE2YD6R.E2OEOD1CO9NE@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 22/33] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <0eddf525bf31e603cc561f1c8973ea44247a7bf1.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <0eddf525bf31e603cc561f1c8973ea44247a7bf1.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
> pp_check() in mmu_common.c, merge these to remove duplicated code.
> Define the common function in internal.h as static lnline otherwise
> exporting the function from mmu-hash32.c would stop the compiler
> inlining it which results in slightly lower performance.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   | 35 ++++++++++++++++++++++++++++++++
>  target/ppc/mmu-hash32.c | 45 -----------------------------------------
>  target/ppc/mmu_common.c | 44 ++--------------------------------------
>  3 files changed, 37 insertions(+), 87 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 4a90dd2584..46176c4711 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -256,6 +256,41 @@ static inline int prot_for_access_type(MMUAccessType=
 access_type)
>  #ifndef CONFIG_USER_ONLY
> =20
>  /* PowerPC MMU emulation */
> +static inline int ppc_hash32_pp_prot(int key, int pp, int nx)
> +{
> +    int prot;
> +
> +    if (key =3D=3D 0) {
> +        switch (pp) {
> +        case 0x0:
> +        case 0x1:
> +        case 0x2:
> +            prot =3D PAGE_READ | PAGE_WRITE;
> +            break;
> +        case 0x3:
> +            prot =3D PAGE_READ;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } else {
> +        switch (pp) {
> +        case 0x0:
> +            prot =3D 0;
> +            break;
> +        case 0x1:
> +        case 0x3:
> +            prot =3D PAGE_READ;
> +            break;
> +        case 0x2:
> +            prot =3D PAGE_READ | PAGE_WRITE;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    return nx ? prot : prot | PAGE_EXEC;
> +}
> =20
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 6dfedab11d..960751a50e 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -43,51 +43,6 @@ struct mmu_ctx_hash32 {
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
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index d92c9607b8..87cac12d68 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -76,44 +76,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong val=
ue)
>  /***********************************************************************=
******/
>  /* PowerPC MMU emulation */
> =20
> -static int pp_check(int key, int pp, int nx)
> -{
> -    int access;
> -
> -    /* Compute access rights */
> -    access =3D 0;
> -    if (key =3D=3D 0) {
> -        switch (pp) {
> -        case 0x0:
> -        case 0x1:
> -        case 0x2:
> -            access |=3D PAGE_WRITE;
> -            /* fall through */
> -        case 0x3:
> -            access |=3D PAGE_READ;
> -            break;
> -        }
> -    } else {
> -        switch (pp) {
> -        case 0x0:
> -            access =3D 0;
> -            break;
> -        case 0x1:
> -        case 0x3:
> -            access =3D PAGE_READ;
> -            break;
> -        case 0x2:
> -            access =3D PAGE_READ | PAGE_WRITE;
> -            break;
> -        }
> -    }
> -    if (nx =3D=3D 0) {
> -        access |=3D PAGE_EXEC;
> -    }
> -
> -    return access;
> -}
> -
>  static int check_prot(int prot, MMUAccessType access_type)
>  {
>      return prot & prot_for_access_type(access_type) ? 0 : -2;
> @@ -141,7 +103,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>                                  MMUAccessType access_type)
>  {
>      target_ulong ptem, mmask;
> -    int access, ret, pteh, ptev, pp;
> +    int ret, pteh, ptev, pp;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
> @@ -160,11 +122,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targ=
et_ulong pte0,
>                      return -3;
>                  }
>              }
> -            /* Compute access rights */
> -            access =3D pp_check(ctx->key, pp, ctx->nx);
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
> -            ctx->prot =3D access;
> +            ctx->prot =3D ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
>              ret =3D check_prot(ctx->prot, access_type);
>              if (ret =3D=3D 0) {
>                  /* Access granted */


