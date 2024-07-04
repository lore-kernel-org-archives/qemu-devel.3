Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25757C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFVj-0003No-Iq; Thu, 04 Jul 2024 02:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFVg-0003KZ-0w; Thu, 04 Jul 2024 02:00:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFVe-0001PR-4f; Thu, 04 Jul 2024 01:59:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c961b5f215so225020a91.0; 
 Wed, 03 Jul 2024 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072796; x=1720677596; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NARh6RoI8bsTF4YfQnl5mrgW5VZhzn9qjH/7WR50fOA=;
 b=BrIAB6nHn8sZRP0RslkLnRpp9EanaSBdKkmP9ph+Rd9qUlIvIfUTOl7pDWeNFdIOQ0
 GOw/btEin+UFaNLJnYkMqErXzvN6OHUmROaNrv6d/HAYnGzVAVZIEeklXh/16+WZdXld
 XgzqIRahJi8VLtNwj4nWoCcNNk9wwv12qmOAID2EIQFwAHjbByhoH/TRcUx4jZ1FE/vk
 xFJkf1AUj15bCdkDRi66o6o2hmqMnG5isvh43Rb9Rml6jIHC6dsOiFp1O63fAXWheCgC
 jnUjfp7MIbKihKFnFJzaT74VVKhdCSA0loq8thC8Q4McGIYHSzM/pOHZauTgtxy8s5fE
 bBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072796; x=1720677596;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NARh6RoI8bsTF4YfQnl5mrgW5VZhzn9qjH/7WR50fOA=;
 b=MWW7J7J+YW8dlEQjh6AoxWYJ44avVT5MAMIIowjC+rnUXK2V55bi9n4Er4YmDv0Dm4
 czJ2YOOSETSV8RXGjfQW2aCTgqTzFZqr3tuu5IQKDea8nV6PazedPtrYAYUo8H4fkM3H
 5guh3KiMLgvJy91hgxBbtpq/k5dzsO57Bz1NI6ayFMX1CPx8gE1S22qvDRwUB1qNwzSD
 ny9eYKnanWWxZJbypfEFNQOo/5X6o8tsQHhQubxxIN0o6jIGrP8aNRmhpqFXS7KTpFtO
 yaHlFQsYHTYlq2IAauvURW9ZEdpWiKePIT0FDc5V0T9/NeR0UrQw9W54q/5VG/PnJuk1
 XOAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDqJJ8O8RbU52+r9gNE8J5nE3b06UenIM6S0dG2WxC1wZlHkcyBdbfFey+HWURmCPgSl1siLDPYJOXyDaFubkTBtM13V14TmqAGDZ7L4ieytrwZ3vae3qjoHo=
X-Gm-Message-State: AOJu0YwY3511K3rbnWBGzJOmWkG9hZU4WFun9Iaq8wdezLuN0mV8LDMS
 wu/z/rH6w5+i7P6aeq0XK7JQ/JY+WylXr7fjvZxdYbzBISP1Ff5W
X-Google-Smtp-Source: AGHT+IGBLir1FCHiU2VD9sgvpAoRL1MakngQYr2BHlK4ELpCXyCz98S9liimKeX6K7NBr9gxH4tc2g==
X-Received: by 2002:a17:90b:1246:b0:2c8:820:71c4 with SMTP id
 98e67ed59e1d1-2c99c6b1e82mr451882a91.29.1720072796190; 
 Wed, 03 Jul 2024 22:59:56 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a92a05dsm601935a91.3.2024.07.03.22.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:59:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:59:50 +1000
Message-Id: <D2GIWZGW4D6D.2JVPKCLWFZAC1@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 06/43] target/ppc/mmu_common.c: Remove yet another
 single use local variable
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <baae5a07e11fe460f315e6ae4a1126c14b8988e2.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <baae5a07e11fe460f315e6ae4a1126c14b8988e2.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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
> In ppc6xx_tlb_pte_check() the pp variable is used only once to pass it
> to a function parameter with the same name. Remove the local and
> inline the value. Also use named constant for the hex value to make it
> clearer.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b21f52290f..799d2ced9b 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -98,13 +98,12 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>                                  target_ulong pte1, int pteh,
>                                  MMUAccessType access_type)
>  {
> -    int ret, pp;
> +    int ret;
> =20
>      ret =3D -1;
>      /* Check validity and table match */
>      if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) =3D=3D pteh) {
>          /* Check vsid & api */
> -        pp =3D pte1 & 0x00000003;
>          if ((pte0 & PTE_PTEM_MASK) =3D=3D ctx->ptem) {
>              if (ctx->raddr !=3D (hwaddr)-1ULL) {
>                  /* all matches should have equal RPN, WIMG & PP */
> @@ -115,7 +114,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>              }
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
> -            ctx->prot =3D ppc_hash32_prot(ctx->key, pp, ctx->nx);
> +            ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, =
ctx->nx);
>              if (check_prot_access_type(ctx->prot, access_type)) {
>                  /* Access granted */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");


