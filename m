Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9492AC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGfv-0007p8-4c; Thu, 04 Jul 2024 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGft-0007oo-EJ; Thu, 04 Jul 2024 03:14:37 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGfg-0000mU-QO; Thu, 04 Jul 2024 03:14:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso196193a12.2; 
 Thu, 04 Jul 2024 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077262; x=1720682062; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvM+JY9llc1yrsZbMZtJx0ON/R5aA3EvnXFd+lfNpJc=;
 b=H7Y2IU/MvXrjZtqOUId7g49/a2Phnud+KcQ6RlNohv1TIfpcJObx+1Ya34uvgqOdtL
 iN0F3HDgp1KPXKO4A2LlsSoF9SK0XE+JNb4QK7xoAuulbTqccMLMIxkiSZlh3e5T7d/a
 lkWecXPtgGuHsNUMmXsVQ8dUc8Eqbqu7J7nl9uQuB+TrCB+PYyBaCfhqXD5k55lQt+ZZ
 Lset1UKuWHkQ8EN+Df/zuKr4v1+1sXqGBxvlTg/d3DJmMJx6Q3lgdyGu+DKm5EOf6+Lu
 6dXZ729gE1ce/Tv+anv8qaX5RWaub23kZJVMx0oUIY2EzDoVVQ1CKi6azmaaRMZEaVY7
 6CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077262; x=1720682062;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fvM+JY9llc1yrsZbMZtJx0ON/R5aA3EvnXFd+lfNpJc=;
 b=mosj7kg33cO25W98mKFM1pX2tuNJ5X2XrGX1+Fu/wsaCS0bPDX6fRptHlVot9PFWYq
 2hWbMf9lgAzNtHPSLtAMUrAtZrzpcRUPZKEEXUAfBwpR2O79K3REGJstP1xF+Gdo42Wk
 F7iHM+b2yh7leOR0UxzbXxOAtlNNUuUfq73rU12GYm9TVhfJD4ZyXBsJjfopPcQgR3TD
 he+1EWu/HVxHOU3pMRFbGZ77clFE0MFpKGLO4lcMCgaZj3VXvI85oUsjGaTWbrgiZcsp
 A0D1c53VO0yJF3HZLyJ87tMZPi83LMEC/tA8xn96PngottcSiL4awihGQ3S+8wiYkNup
 IWKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaqY36ywwTv1e27Kr0lmWgYFrf+IFS+5/t3SedzmK/Rakn+hFyFsEGd7RbltLtdGjoa9HO1bgPoJy6XUquDf75naG2/Ty7tto/5RqNGDbZhKmsMwyi/F4gieE=
X-Gm-Message-State: AOJu0YxbB28gBgfE8pxZj9klXNXwmYROFbpvgoME7Kbh+k03tBku3+Cd
 QzKOFusqm9MR0HyBZaOY3+i67HjbdiYjugi031kUaofIL/+X4vkT
X-Google-Smtp-Source: AGHT+IEN6OI3BvMXjAzccMQqsUIxesmrFJzs4ecH+hvTwtcFWoyNi13oKFuMwyx4DiLtGl+8BJY4ZQ==
X-Received: by 2002:a17:90a:17ca:b0:2c3:cc6:636e with SMTP id
 98e67ed59e1d1-2c99c5057c0mr631089a91.2.1720077261945; 
 Thu, 04 Jul 2024 00:14:21 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a9535f3sm744011a91.17.2024.07.04.00.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:14:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:14:15 +1000
Message-Id: <D2GKHYJUPWOG.326ZQ5FBPLOOV@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 28/43] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_raddr()
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <33549d905b47111a94389f07d676b311c4ffef4f.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <33549d905b47111a94389f07d676b311c4ffef4f.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> This function is used only once and does not add more clarity than
> doing it inline.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Ah, not really sure I agree. Yes I suppose in this case because it
has that comment. But you could instead remove the comment and
leave the function there (because the comment is redundant with
the function name), and then your main function is 1 line
instead of 4.

Don't remove functions just because they're called once, if they
are a nice self-contained and well named thing. But okay for here
I suppose.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu-hash32.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 6f0f0bbb00..c4de1647e2 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -298,15 +298,6 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu=
,
>      return pte_offset;
>  }
> =20
> -static hwaddr ppc_hash32_pte_raddr(target_ulong sr, ppc_hash_pte32_t pte=
,
> -                                   target_ulong eaddr)
> -{
> -    hwaddr rpn =3D pte.pte1 & HPTE32_R_RPN;
> -    hwaddr mask =3D ~TARGET_PAGE_MASK;
> -
> -    return (rpn & ~mask) | (eaddr & mask);
> -}
> -
>  bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access=
_type,
>                        hwaddr *raddrp, int *psizep, int *protp, int mmu_i=
dx,
>                        bool guest_visible)
> @@ -440,11 +431,12 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr,=
 MMUAccessType access_type,
>               */
>              prot &=3D ~PAGE_WRITE;
>          }
> -     }
> +    }
> +    *protp =3D prot;
> =20
>      /* 9. Determine the real address from the PTE */
> -
> -    *raddrp =3D ppc_hash32_pte_raddr(sr, pte, eaddr);
> -    *protp =3D prot;
> +    *raddrp =3D pte.pte1 & HPTE32_R_RPN;
> +    *raddrp &=3D TARGET_PAGE_MASK;
> +    *raddrp |=3D eaddr & ~TARGET_PAGE_MASK;
>      return true;
>  }


