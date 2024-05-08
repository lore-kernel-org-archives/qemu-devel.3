Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gjG-0002gs-MI; Wed, 08 May 2024 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gj9-0002gD-U6; Wed, 08 May 2024 08:48:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gj8-00014z-39; Wed, 08 May 2024 08:48:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f460e05101so652264b3a.1; 
 Wed, 08 May 2024 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715172532; x=1715777332; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvg2nEvkpKN5NbI05oLpPxNJjeUnpE8azuKEJlncLbw=;
 b=S++PPaWH6CVn1x0dimEK7lvOBq8/cmDxZ/aMqtY+jIS8peUquLJNrS1siriYm+ghoe
 v1P3SNovm8xclpUj8R3pKf/hrPgpCqDZZvM1DpzuGtJVeFmVic801bQp2hzJ62ia+prS
 R/QGpYqOAHce5cxIR6ezWSoboUIrN6HWw0c3fkXfZmdnHUADbgmeZQ/Rmm7VwCIedRp3
 UUBCetlC9F7kQMu7lF8igiBQd75BFFlPqdNLBO5nSpzOOzKDfFKIv3vhpo4PlnVwjvmB
 zDZHLOcRKR5K+AnDhsukf5ibwjBGWK/yIRb5wIrBegbVheJwqI6Lv5Yx24T5xU0qTVd+
 z/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172532; x=1715777332;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hvg2nEvkpKN5NbI05oLpPxNJjeUnpE8azuKEJlncLbw=;
 b=K+3oSmz4JztKl68GIhKvcBMPn7uaAp4BAsgECV2dMKSLJdKNIVKQloIBI5HRNm5SGX
 69q3GY1XeKw3G25tDjbxImEttPZJHeFExV9PFdLV68p9eD/TgXPVuoG+GkETp05jPU0J
 imL8H2tljlFPecAR0UwHV1ty1LID5rf4cU0hHjHRWul3lWZ2cK/hovlY8+/zPHEXbwrF
 An3o8Y3jk7bhEudZ6UwlLJB5i4K9HroO/c2u64cinjxxvS5F+rwOCqRgt7SDVpv6MD7u
 6UIkH06L8niMamec1l1buZDGjglW1CbXmMtmL0rTxcaitjtOe4exadOpusN5e5DnpkTQ
 ywBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYz38kF+4zzD6ufTIf4oxF+nvfWiXmZiXfaQQNX1pGIVAvmlB/7rT9UaAvxnJ6QOx+aP//4oVXVyaESg69FHJhVuPB0Hnf2QoIv6l2ml2F5bOd4TH2PLgvVC0=
X-Gm-Message-State: AOJu0Yy4d93ZmUpShqkRBtw7zHbyhV1ntZXYsrBxFfq4xtMEMCZGoukD
 X9xMRkObVcfbS2oJaR1OJu8jOQiyH0eW81to8tnU2nxLsWg++8eh
X-Google-Smtp-Source: AGHT+IGQ/ECp2vLwupigCra0mAw1c75d/IwpgfN24Y3MRqWyeyFNA8QkCqEWGhrJj1HD40bQLEww0w==
X-Received: by 2002:a05:6a00:2d1e:b0:6f3:ef08:747a with SMTP id
 d2e1a72fcca58-6f48e8f2b54mr8491207b3a.12.1715172531956; 
 Wed, 08 May 2024 05:48:51 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 h11-20020aa79f4b000000b006f449ed909csm9548080pfr.23.2024.05.08.05.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:48:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:48:46 +1000
Message-Id: <D149X1513YHR.32ZDIUJBISU0B@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 12/33] target/ppc/mmu_common.c: Eliminate ret from
 mmu6xx_get_physical_address()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <f6d3814523929d4277d6f5a02e3798f9651140a5.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <f6d3814523929d4277d6f5a02e3798f9651140a5.1715125376.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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
> Return directly, which is simpler than dragging a return value through
> multpile if and else blocks.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 84 +++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 45 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b2f2cee1a8..2b6252f3f9 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -389,7 +389,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      target_ulong vsid, sr, pgidx;
>      int ds, target_page_bits;
>      bool pr;
> -    int ret;
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) =
=3D=3D 0) {
> @@ -422,7 +421,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      qemu_log_mask(CPU_LOG_MMU,
>              "pte segment: key=3D%d ds %d nx %d vsid " TARGET_FMT_lx "\n"=
,
>              ctx->key, ds, ctx->nx, vsid);
> -    ret =3D -1;
>      if (!ds) {
>          /* Check if instruction fetch is allowed, if needed */
>          if (type =3D=3D ACCESS_CODE && ctx->nx) {
> @@ -439,51 +437,47 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>          /* Initialize real address with an invalid value */
>          ctx->raddr =3D (hwaddr)-1ULL;
>          /* Software TLB search */
> -        ret =3D ppc6xx_tlb_check(env, ctx, eaddr, access_type);
> -    } else {
> -        qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
> -        /* Direct-store segment : absolutely *BUGGY* for now */
> -
> -        switch (type) {
> -        case ACCESS_INT:
> -            /* Integer load/store : only access allowed */
> -            break;
> -        case ACCESS_CODE:
> -            /* No code fetch is allowed in direct-store areas */
> -            return -4;
> -        case ACCESS_FLOAT:
> -            /* Floating point load/store */
> -            return -4;
> -        case ACCESS_RES:
> -            /* lwarx, ldarx or srwcx. */
> -            return -4;
> -        case ACCESS_CACHE:
> -            /*
> -             * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
> -             *
> -             * Should make the instruction do no-op.  As it already do
> -             * no-op, it's quite easy :-)
> -             */
> -            ctx->raddr =3D eaddr;
> -            return 0;
> -        case ACCESS_EXT:
> -            /* eciwx or ecowx */
> -            return -4;
> -        default:
> -            qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not ne=
ed "
> -                          "address translation\n");
> -            return -4;
> -        }
> -        if ((access_type =3D=3D MMU_DATA_STORE || ctx->key !=3D 1) &&
> -            (access_type =3D=3D MMU_DATA_LOAD || ctx->key !=3D 0)) {
> -            ctx->raddr =3D eaddr;
> -            ret =3D 2;
> -        } else {
> -            ret =3D -2;
> -        }
> +        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
>      }
> =20
> -    return ret;
> +    /* Direct-store segment : absolutely *BUGGY* for now */
> +    qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
> +    switch (type) {
> +    case ACCESS_INT:
> +        /* Integer load/store : only access allowed */
> +        break;
> +    case ACCESS_CODE:
> +        /* No code fetch is allowed in direct-store areas */
> +        return -4;
> +    case ACCESS_FLOAT:
> +        /* Floating point load/store */
> +        return -4;
> +    case ACCESS_RES:
> +        /* lwarx, ldarx or srwcx. */
> +        return -4;
> +    case ACCESS_CACHE:
> +        /*
> +         * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
> +         *
> +         * Should make the instruction do no-op.  As it already do
> +         * no-op, it's quite easy :-)
> +         */
> +        ctx->raddr =3D eaddr;
> +        return 0;
> +    case ACCESS_EXT:
> +        /* eciwx or ecowx */
> +        return -4;
> +    default:
> +        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need a=
ddress"
> +                                   " translation\n");
> +        return -4;
> +    }
> +    if ((access_type =3D=3D MMU_DATA_STORE || ctx->key !=3D 1) &&
> +        (access_type =3D=3D MMU_DATA_LOAD || ctx->key !=3D 0)) {
> +        ctx->raddr =3D eaddr;
> +        return 2;
> +    }
> +    return -2;
>  }
> =20
>  /* Generic TLB check function for embedded PowerPC implementations */


