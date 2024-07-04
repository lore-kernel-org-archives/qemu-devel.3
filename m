Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2F9C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFiW-0004C2-1Z; Thu, 04 Jul 2024 02:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFiT-00049M-Un; Thu, 04 Jul 2024 02:13:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFiR-0003zx-62; Thu, 04 Jul 2024 02:13:13 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9de13d6baso1581625ad.2; 
 Wed, 03 Jul 2024 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073588; x=1720678388; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y14ngGbTSWuZhQGfn0SptHhCij8BbkiytVh0oFN/oJ0=;
 b=d02HOnPzT9MkaBl9ELY1roVxtNPJxrLk3psaKoUAz90lFVEYrSpt2xVrvUSp2n0Gnb
 b+R9VcXb29gxpubzkdvgNaodNrzBfA0KATajhe1j/hxhllH8iGGPp90/yyAAOGYWOmYj
 QQk6gOT3LLQG2JUoUwfMuVJeiMo0mMCN7Xcfj8r0IrJe36Vq2FkgVRQFAxKn321rkA7j
 NSMLg8gEdrr8+amCZLU6Eei+8uHI4DZbkSQwMDv2Qs4/Df2groptnnCNXqp8f0zUtxQc
 DX4YyAdK5ufSra04x6OA0VBdlO8GYdu7U069t1LEIcvv7wW6mOhS9+hkW1yEP2LEQQW+
 Ta/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073588; x=1720678388;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y14ngGbTSWuZhQGfn0SptHhCij8BbkiytVh0oFN/oJ0=;
 b=qpU2rJIezgSjKqQIAnh9WT8gye65sy8wP760S7O/xempSSdM1OaMCiPn7fAl3VmD9+
 lATBg+IthBixn3qF+5e9CNtxRODsrqgRTLVBsZ3f/c1NlyVbglq4ARWXM0ivPE0Zu04o
 GS90U5WNWCip12uW/kwp2QpmMQC7QtTqX4+OwJNKnvWy5OlQLnFjoSAFMU0XOi8h5Q+j
 eIs56xwtziIdh1S5gLdW/Rv4M+THARDNbk6HRbkmbAFBTo7yegO/vwGSlu442SKxvirM
 z8ajmqwn6wkKFjLDS/yMyNyEARtI8903DDk6LVvntTfYQKnNRgHQpMSTsdQEuR1CKM/X
 HopA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV1oqNQG/8ntljsSOSaqEuIM6cwbXgwesrwTY2XpGc5Kw+Ze6+Em/6wcrP9Tul3GNp6FMHOYL1NjSi+IKP/j6XUOZHfX5FkEVl4026SPnC5XT3DymysoXGTmc=
X-Gm-Message-State: AOJu0Yxyp5caMbiTjEG89C//G55hp9kFL8twkZCMbt5n5/qjAS6/sDTH
 hHhVSGFfxHlSmcRWbZDD8lyuGlI/b5fOWJhJvQ7HkJPfe8rwH5y8
X-Google-Smtp-Source: AGHT+IHH6/d9V4AHqkY8RUuiLy8jNepJ/rXmeNmwXTKjevbHgfH8o3etsgRh9WDchZ2+lUQaprmOaw==
X-Received: by 2002:a17:902:f688:b0:1f9:d1f7:3fe5 with SMTP id
 d9443c01a7336-1fb33e8995fmr5466785ad.34.1720073588172; 
 Wed, 03 Jul 2024 23:13:08 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1cc46b7esm21639795ad.231.2024.07.03.23.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:13:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:13:02 +1000
Message-Id: <D2GJ736YGATJ.2B6B20NSYPM4K@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 11/43] target/ppc/mmu_common.c: Remove pte_update_flags()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <87df776b2534cc0ad2523d17c99453edb5de3459.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <87df776b2534cc0ad2523d17c99453edb5de3459.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
> This function is used only once, its return value is ignored and one
> of its parameter is a return value from a previous call. It is better
> to inline it in the caller and remove it.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 41 +++++++++++++----------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index e3537c63c0..c4902b7632 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -119,39 +119,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>      }
>  }
> =20
> -static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
> -                            int ret, MMUAccessType access_type)
> -{
> -    int store =3D 0;
> -
> -    /* Update page flags */
> -    if (!(*pte1p & 0x00000100)) {
> -        /* Update accessed flag */
> -        *pte1p |=3D 0x00000100;
> -        store =3D 1;
> -    }
> -    if (!(*pte1p & 0x00000080)) {
> -        if (access_type =3D=3D MMU_DATA_STORE && ret =3D=3D 0) {
> -            /* Update changed flag */
> -            *pte1p |=3D 0x00000080;
> -            store =3D 1;
> -        } else {
> -            /* Force page fault for first write access */
> -            ctx->prot &=3D ~PAGE_WRITE;
> -        }
> -    }
> -
> -    return store;
> -}
> -
>  /* Software driven TLB helpers */
> =20
>  static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
>                              target_ulong eaddr, MMUAccessType access_typ=
e)
>  {
>      ppc6xx_tlb_t *tlb;
> -    int nr, best, way;
> -    int ret;
> +    target_ulong *pte1p;
> +    int nr, best, way, ret;
> =20
>      best =3D -1;
>      ret =3D -1; /* No TLB found */
> @@ -204,7 +179,17 @@ done:
>                        " prot=3D%01x ret=3D%d\n",
>                        ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
>          /* Update page flags */
> -        pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_typ=
e);
> +        pte1p =3D &env->tlb.tlb6[best].pte1;
> +        *pte1p |=3D 0x00000100; /* Update accessed flag */
> +        if (!(*pte1p & 0x00000080)) {
> +            if (access_type =3D=3D MMU_DATA_STORE && ret =3D=3D 0) {
> +                /* Update changed flag */
> +                *pte1p |=3D 0x00000080;
> +            } else {
> +                /* Force page fault for first write access */
> +                ctx->prot &=3D ~PAGE_WRITE;

Out of curiosity, I guess this unusual part is because ctx->prot can get
PAGE_WRITE set in the bat lookup, then it has to be cleared if the PTE
does not have changed bit?

> +            }
> +        }
>      }

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>  #if defined(DUMP_PAGE_TABLES)
>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {


