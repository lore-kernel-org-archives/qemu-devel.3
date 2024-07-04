Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2CDC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFTe-0008Uq-Ow; Thu, 04 Jul 2024 01:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFTb-0008S4-3j; Thu, 04 Jul 2024 01:57:51 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFTN-0000I8-D4; Thu, 04 Jul 2024 01:57:50 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d63332595cso159728b6e.3; 
 Wed, 03 Jul 2024 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072656; x=1720677456; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCZ8upx1bTQZ38D7msG26tPoasryY5yU45aYJ2ZY/NU=;
 b=eO4W77xBR71CrioWHgiZvRI99WKeJtF2Yxnim5xk8ShzwVEvN0j3TGDkjsNoaDgG88
 cY/YKNwgg0Gkdb1sAFUisvv5agH4EOJeOC6sQs9EQxCniqAnQstjkuHg8RBue7mWluaN
 P2yllJLbLpOdV5UkgjfiYF9Dccek333CxuKXZgq1ludc6zold/X4LJtGyJrPXVrO7oPX
 BX+IAEFJEIOOvQj77ldnl/W/6XGtRhwHpR8VImrJ1Ofank7DuQJhbHahadncueyvzBvx
 LpPmX8PBg+gSLXEmgILNkLwa7XqaVJaHFNXduUjixKQE36S7ipbLXOStr9aDIhqeleIi
 sXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072656; x=1720677456;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VCZ8upx1bTQZ38D7msG26tPoasryY5yU45aYJ2ZY/NU=;
 b=jOrc49HLXfTANl89yPXb59OTB7lHJafFFjsq0o+CljDMd19DfsdfnKyYiUuIaWdiGa
 W6NWQK9jgIoJqYG05FfSOUUgtIDigmtFpvTXEY/apN7t1LZ/Y5Q3jAphfzFIkn2/yvl1
 ZDyU+mOX/ekGJlKXvp9Vj3MoxFTXVPk+FPKrPIcTx6vTWbn4d3fRzOckdFtqbfIFYI93
 Y5yKo2euj4EbBy+mO7zvnbjoNvXrAP6ORgegMC63D5jCyENDGVw8p/+Npjs7nSj3d0dU
 qgvIxnAT+jNEPFVUTb87fkQGt+Uks/G3UTyXqoKuoZYxDFjd0aNbuQLJPlXfVH1voVIp
 2qaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVewyPysQOmaMjJIbTiLUHtNJaGxmqOrVyPS3AhtjPLmLDwUVwT9q6wZrtLWzdGRmu/p/h00wXM/MaIzwIBamehCXavwD9umpIu+vpB/YVjaHOV58FCgF+1Gvk=
X-Gm-Message-State: AOJu0YzDOq7bncbMXZTuHpWLwEPAAw/NFLCC4Rb2Xi1T4V8u9mVJyq3M
 /dCv295LSSGcx89IuZa9oF3aPZrNQLJvvuYHkjD7T58vBdNGmaRT
X-Google-Smtp-Source: AGHT+IHcJVgOojXacSRx9U5zWFrMA/g8VCe2uDpnWkWTWOXxaDrgB8uVCnF5IHGT/l5y8djy5iSCCQ==
X-Received: by 2002:a05:6808:11c7:b0:3d6:7a8e:6843 with SMTP id
 5614622812f47-3d914eac561mr596422b6e.57.1720072655791; 
 Wed, 03 Jul 2024 22:57:35 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecfae8sm11434754b3a.107.2024.07.03.22.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:57:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:57:30 +1000
Message-Id: <D2GIV6X9HDKP.ZB5WMQUZPEYE@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 02/43] target/ppc/mmu_common.c: Remove local name for a
 constant
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <7ec05c493e91bd8ec351127aab8017a5a8caf29d.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <7ec05c493e91bd8ec351127aab8017a5a8caf29d.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x236.google.com
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
> The mmask local variable is a less descriptive local name for a
> constant. Drop it and use the constant directly in the two places it
> is needed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 08c5b61f76..2618cdec6a 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -98,7 +98,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_=
ulong pte0,
>                                  target_ulong pte1, int h,
>                                  MMUAccessType access_type)
>  {
> -    target_ulong ptem, mmask;
> +    target_ulong ptem;
>      int ret, pteh, ptev, pp;
> =20
>      ret =3D -1;
> @@ -108,12 +108,11 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>      if (ptev && h =3D=3D pteh) {
>          /* Check vsid & api */
>          ptem =3D pte0 & PTE_PTEM_MASK;
> -        mmask =3D PTE_CHECK_MASK;
>          pp =3D pte1 & 0x00000003;
>          if (ptem =3D=3D ctx->ptem) {
>              if (ctx->raddr !=3D (hwaddr)-1ULL) {
>                  /* all matches should have equal RPN, WIMG & PP */
> -                if ((ctx->raddr & mmask) !=3D (pte1 & mmask)) {
> +                if ((ctx->raddr & PTE_CHECK_MASK) !=3D (pte1 & PTE_CHECK=
_MASK)) {
>                      qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
>                      return -3;
>                  }


