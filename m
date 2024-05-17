Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5DBC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qyX-00068Q-UL; Fri, 17 May 2024 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qyQ-000640-Uw; Fri, 17 May 2024 02:21:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qyP-0005MP-1L; Fri, 17 May 2024 02:21:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f457853950so673462b3a.0; 
 Thu, 16 May 2024 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715926903; x=1716531703; darn=nongnu.org;
 h=in-reply-to:references:content-transfer-encoding:to:from:subject:cc
 :message-id:date:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=FeeNNGrnUI6xEipAlVPokaIyoM09Dpa6e2226P5bCLw=;
 b=DRP6TPYqbowITK5kUBiKtO8lxxj7Z+F/wqVx8neEiPlay9nztEXtfU/1a7u0dzEWuS
 3W8eDbKv85rIiz0iBndIKXApsVtDdhX1yXGBRTbuIAlIyysSk1eE+jHy60jv3gNKcwSh
 BDiEVIrHIvC8SxOTsjBuUy15bw/3NP/Wik1Y4VGuFccHrl7Zp15I2POuskFY1KTrZ2Ap
 hDlVJZg4cSVnW2ZCPduyqBhTDHereAxdUxNZ1JDBOmJ3cBxHeGtHHOMrMldEKJGTPDK6
 1kB0ZSejoIKGCIae4p2E7gsNLlAq5xeL3O4f0thrFTOpJGcirNeZZZ754KVwxghP5PaD
 R8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715926903; x=1716531703;
 h=in-reply-to:references:content-transfer-encoding:to:from:subject:cc
 :message-id:date:mime-version:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FeeNNGrnUI6xEipAlVPokaIyoM09Dpa6e2226P5bCLw=;
 b=BOJFLcxoAdcyR/Q9MEZ+87Yh4DgwYTqK/Nkw6q/BeSHL9y/kNfRuCosyT2g6HyFJd1
 TCHPTjl6IXTrVIgl9Zjp24N/mKAAQBksF0S2W84LydtxFSObNet1o7pwvZKA2OseKQlB
 eYkFWla7klm9I47xQVajWNK+357W8QZj8rBdf0M5X6SUOC/hyo/3za7GaTARINixxIob
 IUpbl0ketXY/jAmRdTekDnE/5Mraoua4yNWA1oNZC+PBn56NochLLtq+C2QGmhrGIZbM
 129b0wl3HoXXJEADDVEyApJR8mG1ZpcWBFATzeZShUklrzGwADVgtaTt9KJ4Ngc9ns+q
 b5HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF3bl38ienfmzwCjKahDdM4Qm61at5y/kgvE5z8ldVM5lZZDRwzEOLslZz0k+WHmBRt/MJ1rmKzsoBSwdvlyd/aSHk+SdhHVbm5p3vwR8epO11rlIM7IXnvjI=
X-Gm-Message-State: AOJu0YwFiull/YVSYQom1TZ/cT+d25g3VN+e+US0eXllcxae8uHSz3YP
 qr956lLT3oUG1wtyWQNoqX5rPT7CJ47W+6DLwHKXIoRA/7uH9pXP
X-Google-Smtp-Source: AGHT+IHLrJRuMqKP/chFOj2oeZ/9lY4C4oV7RoFJoxcZZ76snS8zotafIiaN5xIQcric4gfuB1TA6g==
X-Received: by 2002:a05:6a21:3d85:b0:1af:cb48:fbc5 with SMTP id
 adf61e73a8af0-1afde0ecb46mr24898073637.16.1715926902779; 
 Thu, 16 May 2024 23:21:42 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2b53sm14064053b3a.151.2024.05.16.23.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 23:21:42 -0700 (PDT)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 16:21:37 +1000
Message-Id: <D1BPBI452YKP.HT0RH2UYZGHW@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 36/61] target/ppc/mmu_common.c: Remove local name for
 a constant
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <b9605839090fd145b067db34b2bdce45548c0631.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <b9605839090fd145b067db34b2bdce45548c0631.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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
> The mmask local variable is a less descriptive local name for a
> constant. Drop it and use the constant directly in the two places it
> is needed.

Wow, lots more. I might take up to patch 34ish for first PR.

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 9e0bfbda67..5d0090014a 100644
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


