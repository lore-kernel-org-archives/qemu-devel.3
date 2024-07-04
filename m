Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F078C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFUC-0000dM-Rg; Thu, 04 Jul 2024 01:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFU1-0000Ue-8X; Thu, 04 Jul 2024 01:58:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFTz-0000Mq-Ky; Thu, 04 Jul 2024 01:58:16 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-75c5bdab7faso146424a12.1; 
 Wed, 03 Jul 2024 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072693; x=1720677493; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lQMwcZ+KLDClZojB/B/a05839/pE7VyfnI+5mPpuxs=;
 b=SWrfXvjg6yXzKCoDFvoAdEg8cpr7/mYO5bRkxEWi6phNyBxr4GHIL9vCYaArZWFotJ
 mUFwlxzALLvx3kZdSpYMJbZbKSVRjkbmLDOZktdGoj78Z03wxY46u5ewttthtGUy215Z
 ZSfbFgweu4kV683zCeP7TY1WpUVL06mdh63efLUs8byVwhKZHljPhkodeXlrV6VY7Obr
 9JpOZbbhPlFv60Bt2aHSSszovEnjL/Ehms1aizyKjPYGndc5YquYw85pa3SeGpMelJBv
 6xCZrrPlycSVHoG5m6PC25Z8xHnq/biHkwwecpAwzyKZ8xGTEeTEXjGtTK5opOijBAoU
 8Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072693; x=1720677493;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9lQMwcZ+KLDClZojB/B/a05839/pE7VyfnI+5mPpuxs=;
 b=spk7NgRX4TKrlzTLlNKkTN72io/7vNsbcoIWwborwOVulh4Az6rhuam3xzvJYIb6wn
 drMOFLfw2wR+AabBp/urxEb/F0fWDrXY3Hspczp30dJiHV7UepGloSnCYxIi5Y+DvJcc
 eZUohS+nQT2nVbNqL2CYMcXRlJ6tDcuZ2qfh31Yy9+Vi7o7aWLNbu1QFOm6Bg+hOeSvf
 5aXozW/ejEysHWygxWf89lKCxZZCKv73ZBSgx9KQph2bLX0oYahsIPQV/pVkJuBmZlXN
 9bZfXimYgsPD6tLTFTuFRimQyNCsk84Zq7ah3ZfVc45BRSVljnT7ezbzdh9ZdrrK1NJb
 Bfjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjUKV5hOluPHDlP5Xgz7kD8ENT42booINEJvMvmFf2jKlmzTFYG+9EAKELs8mKd6+cvsmraryJEYr7jv3jUzeE16rbxUhvrOFhgaH4+cPexeyFfu03C23m7sY=
X-Gm-Message-State: AOJu0Yw5sgCtP9Qy7poLDZi/K4XVpGq6u5nCzX8VuVNl8KcZ9dr2ldHA
 WaQ1ykuP5DafA5jwDzbeF+mRCjmT/V7epzzqkTYnWxVGoBN4nWvW
X-Google-Smtp-Source: AGHT+IHlIbnb9FEFK7yuzy/KOQ00z/EyYuUsutn0DfOe2xUmoWtcxFtA4Ne4ZIOs7ms/DnoINNzo5Q==
X-Received: by 2002:a05:6a20:12d5:b0:1be:c947:f17a with SMTP id
 adf61e73a8af0-1c0cc74b5f3mr628504637.24.1720072692767; 
 Wed, 03 Jul 2024 22:58:12 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb167dd71esm25485885ad.238.2024.07.03.22.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:58:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:58:07 +1000
Message-Id: <D2GIVNWQTDIC.3I8L3C0I3H7IC@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 03/43] target/ppc/mmu_common.c: Remove single use local
 variable
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <9a0cc672e293a803a47c06375e6ca9781c90fbdb.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <9a0cc672e293a803a47c06375e6ca9781c90fbdb.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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
> The ptem variable in ppc6xx_tlb_pte_check() is used only once,
> simplify by removing it as the value is already clear itself without
> adding a local name for it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 2618cdec6a..371ec24485 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -98,7 +98,6 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_=
ulong pte0,
>                                  target_ulong pte1, int h,
>                                  MMUAccessType access_type)
>  {
> -    target_ulong ptem;
>      int ret, pteh, ptev, pp;
> =20
>      ret =3D -1;
> @@ -107,9 +106,8 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>      pteh =3D (pte0 >> 6) & 1;
>      if (ptev && h =3D=3D pteh) {
>          /* Check vsid & api */
> -        ptem =3D pte0 & PTE_PTEM_MASK;
>          pp =3D pte1 & 0x00000003;
> -        if (ptem =3D=3D ctx->ptem) {
> +        if ((pte0 & PTE_PTEM_MASK) =3D=3D ctx->ptem) {
>              if (ctx->raddr !=3D (hwaddr)-1ULL) {
>                  /* all matches should have equal RPN, WIMG & PP */
>                  if ((ctx->raddr & PTE_CHECK_MASK) !=3D (pte1 & PTE_CHECK=
_MASK)) {


