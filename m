Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E024C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qoR-0003L6-QA; Fri, 17 May 2024 02:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qoM-0003Kd-Gl; Fri, 17 May 2024 02:11:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qoK-0002Du-M0; Fri, 17 May 2024 02:11:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so2497515ad.2; 
 Thu, 16 May 2024 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715926279; x=1716531079; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjilQDOKv37siGHwi0CP72IHz145mFO7hMylJq8GeUs=;
 b=NaIxqap+PBZ9UYUvuuqnD/ffqvE4Z39A+jvRjY/3MFO9MOflmllYYmyoQ0ToSRJicr
 vE6cnwnZ/MV/YKhVk7UNkGVVTVgClhCDpz0ocRuFUv9aM4+WQAAm6AOO3OAVfS8TcUNk
 8TJbnmYQFafVlGpMwI/jvog2ob0RXx6XkfcYOjgN4McjiCkMhZ1QU6LJ4hrrN9S0N2m+
 kzaNDImR5rbqLkrEfI2O0R82sM4XDv//QkAUbbOj7vlq3ywF1hepI5mvwQEn5ObpBoji
 +4s8c9olHmPXftjHZuXBPtk37LNVMrrjHWhBX0a6gW5wDw+zcazHtZhjy1Mc7WiKLfTy
 tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715926279; x=1716531079;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cjilQDOKv37siGHwi0CP72IHz145mFO7hMylJq8GeUs=;
 b=DztavqswgdX6Q9I8M/qM9oVF6vTPXMf3m5lb/QVPGJU9aqykQywAu0NSt2u7cVjq1/
 hr+N1nKXsj3P7M5nAHv/KCCZDtti3+g5v+Ang8G3cSldizvfKvgtzPuyjCx41A29EWTx
 2waGBBUsS79mFHLfKz+vqWdSP+hL/Le2uCiUpz6xQzeAicuPnStVUWg4lYDQMIK9SY/I
 JqG/8ZKxpbKp9EkB9HIs1g2yeOiwcv4knWZeEOOwepoqCSRavFhxxL8W5uetumj2yhlj
 bQiAB7eZtfEmWsMjXsxFhAekEDRWPhRJU4AaTVUAhy7TiFUEXfI5gSjD8chzZJWB6FK+
 Le1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJfB/0A+tFQGRQtkhGZFqeyyA+pwj0o2tZdqIkn+N2qobKPZYDWbaRuPKnt6Wq99rqNCNRLwWz0/0PzxbyRNxVOnEtMhpRRg1s9V2+nIARiBlxLMd5WWi9znQ=
X-Gm-Message-State: AOJu0YyAMhPFD0Zn3j8/atRRmjVn+73vhW3CYSXCpGYMsY3AxafNgpTV
 AA4OzgMiX0zDIkQ+ly/+lrb5q0uJ8UgA71eOYg3WuU0IW8ZTJYJk
X-Google-Smtp-Source: AGHT+IHkw3HTt4x0CRHBWj/ylEB2+QRFfDXrHpmmWS3SZH5EJsZ5Jud7bdrsSwZz8ZPyUqiqGQl0Hw==
X-Received: by 2002:a17:902:d58a:b0:1ec:a65a:e4ad with SMTP id
 d9443c01a7336-1ef44059ea7mr248256765ad.66.1715926278713; 
 Thu, 16 May 2024 23:11:18 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c0362d4sm148574885ad.210.2024.05.16.23.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 23:11:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 16:11:13 +1000
Message-Id: <D1BP3JMB7X6H.6TYQ4FYWBZRH@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 35/61] target/ppc: Remove pp_check() and reuse
 ppc_hash32_pp_prot()
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <ed76f84bb9b16f8ecffa6ed6154b97fc7a8acdc1.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <ed76f84bb9b16f8ecffa6ed6154b97fc7a8acdc1.1715555763.git.balaton@eik.bme.hu>
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

On Mon May 13, 2024 at 9:28 AM AEST, BALATON Zoltan wrote:
> The ppc_hash32_pp_prot() function in mmu-hash32.c is the same as
> pp_check() in mmu_common.c, merge these to remove duplicated code.
> Define the common function as static lnline otherwise exporting the
> function from mmu-hash32.c would stop the compiler inlining it which
> results in slightly lower performance.
>

It's already hard to review patches that move code around, it's better
to keep the changes before/after the move unless really necessary.

For mmu_common.c hunks,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c | 45 -----------------------------------------
>  target/ppc/mmu-hash32.h | 36 +++++++++++++++++++++++++++++++++
>  target/ppc/mmu_common.c | 44 ++--------------------------------------
>  3 files changed, 38 insertions(+), 87 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 1e8f1df0f0..d5f2057eb1 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -37,51 +37,6 @@
>  #  define LOG_BATS(...) do { } while (0)
>  #endif
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
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index 7119a63d97..bf99161858 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -102,6 +102,42 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU=
 *cpu,
>      stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte=
1);
>  }
> =20
> +static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
> +{
> +    int prot;
> +
> +    if (key) {
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
> +    } else {
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
> +    }
> +    return nx ? prot : prot | PAGE_EXEC;
> +}
> +
>  typedef struct {
>      uint32_t pte0, pte1;
>  } ppc_hash_pte32_t;
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index e1462a25dd..9e0bfbda67 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -77,44 +77,6 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong val=
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
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code)
>  {
> @@ -137,7 +99,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target=
_ulong pte0,
>                                  MMUAccessType access_type)
>  {
>      target_ulong ptem, mmask;
> -    int access, ret, pteh, ptev, pp;
> +    int ret, pteh, ptev, pp;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
> @@ -156,11 +118,9 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targ=
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
>              if (check_prot_access_type(ctx->prot, access_type)) {
>                  /* Access granted */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");


