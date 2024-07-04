Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382D3C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPG1b-0004iZ-7k; Thu, 04 Jul 2024 02:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG1V-0004gK-Ry; Thu, 04 Jul 2024 02:32:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPG1U-0006iH-0o; Thu, 04 Jul 2024 02:32:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so232039b3a.2; 
 Wed, 03 Jul 2024 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074770; x=1720679570; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcFFBnU+YY0pTUb3FVdmVnTU4+BOt7OchAPyEOUOKjo=;
 b=kdQMi9XerSmfTFaZobJbBM39XnAjvbc8R5TblnJ1M0yoXTeUShy9SobMLrQhs3Y/Op
 FwPyM5F0lbJlgkaJ70WHPAUOn4djVTXimVEr0+4cm1CCNhZS1Xu10du5SOFX3houff0k
 ENFSjQ9CI3QgFKs3ED8FBsfXgOXYQHgSZgGBhCRQs2dRiilOPp5xwlajuSnlIE5jiIgo
 2Miwzu29mXGEWbUwZtpoAi68dbdhkBn2S9UQ2jHF8oh1XbVZSz1w/xpZnfjldXJ1PHch
 MsU99e7cRQrmgdVsItRU7dI+wKDRIg9AEBKiKG4yOuQjUpCsLQCtAT5fGxKEXDMo3Tnm
 3PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074770; x=1720679570;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rcFFBnU+YY0pTUb3FVdmVnTU4+BOt7OchAPyEOUOKjo=;
 b=g5veXUmXWz1WeZXKHd/NmZ1NS55zRDs7FWLACW84hPck8W8bPXAbUzJxp1CItEWVll
 NcYi4uFpOEHUUToQXsMUOcsOd9zgWReZIblrEkdAkTbKwEIjZP2zVKu115bWCUomTd28
 hQLDqHkw2PN5eGzctBS+IDRyGh8LgHAkbyi8hpjTgpVAw16S+oXps0o3YnaEFuUwFI5h
 tL/sIn+4dboKckTvqFqAMb+4NcPuEPaRO01JvQJ7IDPZX8EJHdvnEC8XO+2WaK2zfRI7
 GTr3Bch5OkhBzyONAl7tbjtzfqb2SDKeMClHa2SuxADwzhaYKy8CwHySRFBAtxY07JvR
 /Log==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7AK0b5ssz3+Glx9aOCpnRjg4Rqfh96st2idganlzIl1FQ0mRU20+o1eFoD02+LpCrDNhpYOdeeXfUlXG/hFyBzTgwxEvRip1+bKMF4bR0+ZRSMxkeV4mQVkc=
X-Gm-Message-State: AOJu0Yzb3N9XHGWo1/sGQ3hmNcAE0G8P+qzfn0yf9USPYcF8J/Oou7MZ
 JwOKSy7zMd/jrib/fziKj08XbvLfm45P+Q9GdWlrLhKwUXNwWN7w
X-Google-Smtp-Source: AGHT+IEJ7w3/06BxTriXrcZtvNubUHjbuNu0QCuRRYf0GYJXKYrIxtmwxANZYys/nnmhq+yIrA1BOw==
X-Received: by 2002:a05:6a00:4b55:b0:706:8e4:56a1 with SMTP id
 d2e1a72fcca58-70b0096cb8emr819472b3a.18.1720074768822; 
 Wed, 03 Jul 2024 23:32:48 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804989f5asm11504673b3a.195.2024.07.03.23.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:32:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:32:43 +1000
Message-Id: <D2GJM5NE55UZ.3L5C0BVVEJ51M@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 22/43] target/ppc/mmu_common.c: Stop using ctx in
 ppc6xx_tlb_check()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <e3538f2cd74f716237586971bddcbc40d27fb38b.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <e3538f2cd74f716237586971bddcbc40d27fb38b.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
> Pass raddr and prot in function parameters instead.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index be09c3b1a3..ede409eb99 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -91,10 +91,9 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong e=
addr,
> =20
>  /* Software driven TLB helpers */
> =20
> -static int ppc6xx_tlb_check(CPUPPCState *env,
> -                            mmu_ctx_t *ctx, target_ulong eaddr,
> -                            MMUAccessType access_type, target_ulong ptem=
,
> -                            bool key, bool nx)
> +static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
> +                            target_ulong eaddr, MMUAccessType access_typ=
e,
> +                            target_ulong ptem, bool key, bool nx)
>  {
>      ppc6xx_tlb_t *tlb;
>      target_ulong *pte1p;
> @@ -102,7 +101,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>      bool is_code =3D (access_type =3D=3D MMU_INST_FETCH);
> =20
>      /* Initialize real address with an invalid value */
> -    ctx->raddr =3D (hwaddr)-1ULL;
> +    *raddr =3D (hwaddr)-1ULL;
>      best =3D -1;
>      ret =3D -1; /* No TLB found */
>      for (way =3D 0; way < env->nb_ways; way++) {
> @@ -130,17 +129,17 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>              continue;
>          }
>          /* all matches should have equal RPN, WIMG & PP */
> -        if (ctx->raddr !=3D (hwaddr)-1ULL &&
> -            (ctx->raddr & PTE_CHECK_MASK) !=3D (tlb->pte1 & PTE_CHECK_MA=
SK)) {
> +        if (*raddr !=3D (hwaddr)-1ULL &&
> +            (*raddr & PTE_CHECK_MASK) !=3D (tlb->pte1 & PTE_CHECK_MASK))=
 {
>              qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
>              /* TLB inconsistency */
>              continue;
>          }
>          /* Keep the matching PTE information */
>          best =3D nr;
> -        ctx->raddr =3D tlb->pte1;
> -        ctx->prot =3D ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
> -        if (check_prot_access_type(ctx->prot, access_type)) {
> +        *raddr =3D tlb->pte1;
> +        *prot =3D ppc_hash32_prot(key, tlb->pte1 & HPTE32_R_PP, nx);
> +        if (check_prot_access_type(*prot, access_type)) {
>              qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>              ret =3D 0;
>              break;
> @@ -152,7 +151,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>      if (best !=3D -1) {
>          qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
>                        " prot=3D%01x ret=3D%d\n",
> -                      ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
> +                      *raddr & TARGET_PAGE_MASK, *prot, ret);
>          /* Update page flags */
>          pte1p =3D &env->tlb.tlb6[best].pte1;
>          *pte1p |=3D 0x00000100; /* Update accessed flag */
> @@ -162,7 +161,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>                  *pte1p |=3D 0x00000080;
>              } else {
>                  /* Force page fault for first write access */
> -                ctx->prot &=3D ~PAGE_WRITE;
> +                *prot &=3D ~PAGE_WRITE;
>              }
>          }
>      }
> @@ -344,7 +343,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          *hashp =3D hash;
> =20
>          /* Software TLB search */
> -        return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, key,=
 nx);
> +        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
> +                                access_type, ptem, key, nx);
>      }
> =20
>      /* Direct-store segment : absolutely *BUGGY* for now */


