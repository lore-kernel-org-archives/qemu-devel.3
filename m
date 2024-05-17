Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24A0C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qS8-0002cF-KY; Fri, 17 May 2024 01:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qS7-0002aS-6X; Fri, 17 May 2024 01:48:23 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7qS5-00078s-8v; Fri, 17 May 2024 01:48:22 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b2cc8c4b8aso640959eaf.1; 
 Thu, 16 May 2024 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715924899; x=1716529699; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4PxSMcx9sJnGbr1B4/8Aeglkji748sfOJm0U1PUmCU=;
 b=MuBFoUPJUqyloYvRETI92neZRiR0g2lZKbtZw0uHh7b4uPWUW5NkInyfH/tmuMIyTL
 WhY7claxoPLIsMRURDUrZ4MHZHX+2Y04eMbR+WAS5mOWgyUKM9JEe+FLqjJ9hfE5WXHO
 luzMo9hdXUaO8op6yDwlNTeIAPjYlTjoTFHhE/G0bfQvEwYRkDSAoAg2NaGBfQfvcEzJ
 2jNVxlWTxxZJfK0r0ZCJub2OeT/9cliWK4oAf7TAKR4mL0QeGRA8mg3rgiqaHEUtPYpK
 CJfS89keQYTn0pz2n7h28VPKUDkIa/seqh6d4bL1CKTQ9qw6A0R+cRt6zBOrlN5/7/Up
 WvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715924899; x=1716529699;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r4PxSMcx9sJnGbr1B4/8Aeglkji748sfOJm0U1PUmCU=;
 b=medrRu8ALNoDV1L7LckxiSsGJz5mVWSq4J1hP14D/GmsU9zd/uJf6oy2IZC7GQNskf
 AeM+fnMQFxH+ta9V8mmQFDNrCIZCL95V5kRHRjouYOniOQ2ye7/sAsWJb0mOmyopxyQN
 NpOV+44+32KbucjMYgdTsKSCU4/9XeioxqVKQ+keavrsCzgEYuSDz0Lb3Eaikp30WsI9
 Fp/Kuqcqbz7byHK+JeJYYfg7+mWDYw4svrwqGxg2tBdtf/rEIzSODxy7RloZCaL1Pq/P
 6AyyVD2fRwteI24Gy9NnMIEfWRkxuTeuG6M5ail31uDUw+Mw5EzfNKziU2cuKcYb+aqw
 fAXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULsvgjIlW4+5OLN5qgMH4zRexsEWWU/qnbn0LI6JqOiWlQnOS8G929ru5ztVGZ/dR5r/YjbDix4gYA5f7z26NhGWRKh9THpu15471OwsEiayF7YBOC8MdYiKI=
X-Gm-Message-State: AOJu0YxnFJbM0jBYYqJVHodRIMB1/0XWK9mLmkeIJOxCtujs/+mm5/jR
 ezgpRhWmwlsGkMeO+oOy91Ykph/bd9Q1UIJ2SBPL8rtuOx29FCyY
X-Google-Smtp-Source: AGHT+IHycRSxZZH6Mwrnm6uCFr4IUb6ApkcVt9QXVLENSppDlHE77NAd7C/0XSBOWu1S7hesFLpwAw==
X-Received: by 2002:a05:6358:57a2:b0:183:645b:cfa5 with SMTP id
 e5c5f4694b2df-193bb63b523mr2469343855d.15.1715924899371; 
 Thu, 16 May 2024 22:48:19 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-64f0e60602dsm5839355a12.31.2024.05.16.22.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:48:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 15:48:13 +1000
Message-Id: <D1BOLXQYO78Y.1AVRX7YT1RMME@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v7 28/61] target/ppc/mmu_common.c: Remove
 pte_update_flags()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715555763.git.balaton@eik.bme.hu>
 <213dd134f56b35f0935305e579ab3bc8acaaa52d.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <213dd134f56b35f0935305e579ab3bc8acaaa52d.1715555763.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc30.google.com
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
> This function is used only once, its return value is ignored and one
> of its parameter is a return value from a previous call. It is better
> to inline it in the caller and remove it.

Debatable. It's definitely clunky code that could use some
love.

But without looking at details I would bet it's actually cleaner
to inline this into ppc6xx_tlb_pte_check since that is what deals
with the ptes.

Might leave this patch out for the first PR and see how things
settle.

Logic is odd too, or at least I don't really understand it or
intricacies of 6xx mmu. . Access bit is set even for access
violation? Store rejection logic I don't quite understand. Not
that I suggest changing anything in a cleanup series, but
would be nice to untangle and comment unusual cases a bit more
at least.

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 41 +++++++++++++----------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 34200d9cb1..4fb93cbf40 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -179,39 +179,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, tar=
get_ulong pte0,
>      return ret;
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
> @@ -264,7 +239,17 @@ done:
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
> +            }
> +        }
>      }
>  #if defined(DUMP_PAGE_TABLES)
>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {


