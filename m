Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D16C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFpp-00043H-Pk; Thu, 04 Jul 2024 02:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFpm-000426-7u; Thu, 04 Jul 2024 02:20:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFpk-0007tW-CN; Thu, 04 Jul 2024 02:20:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7066c799382so211942b3a.3; 
 Wed, 03 Jul 2024 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074042; x=1720678842; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gv50ANTbR1SgSYBiJC3uWBfK+qv8YSp1D/PlLAybUwU=;
 b=MvaLwgudjlFlWi8AilhIS8nknnrbubQde5yOlcz8B76VXUNfL8qlMF9TgzMJn+WedL
 sGvMD74jRrF7OQxEMkDHnf840ZG6Gs10UdaNFVkSWRuw/lT5ikbBWFrgTwq3zMBdBscj
 Sd3pUK6M2roMiNaSx6s2UPZEp9cG5WYjNLX/3E5XcwnrDXwlnJWGrq+Y5a3kLeF1tpEy
 kGwM1U0jRRpQPNXi+Hhklj/9ZwPLA2Te1HCs8o0HSeWIBuibI9/5vMIJkN4N304DdNdV
 4sOb1+4NQLVQHGwPXuzi6YhMO1OTnCvhlzqZJ/hVGBC/Pib6ubvxGQIRN/cSkvP1TRwX
 eqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074042; x=1720678842;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gv50ANTbR1SgSYBiJC3uWBfK+qv8YSp1D/PlLAybUwU=;
 b=BSPE1FvxHY5k4whbMBmsK6Be5oHfzef5GrdhU5lWEUbjB5eHvp9gMCy6iIg2+lmTxK
 UZRMexnn9pbxwHTDOFypQDhMdbDxe67F+UfkpnnLCHooydFzwKjAKlqeKp6YKL6PRjWN
 xJQTTvo4r2aoEsEztBcXbbAWZ3NWpm/XTqPID60o44oG0J/FSbWiSJjN5IdQetSf0ohi
 eNKmuDM7zVQEZHT2pMSCmiy+mwf6lqDuAZk55pqSbNaY1+ALFUl5l6FJ5CpCrrO0fz0D
 kRosx5hCzIwNft37o7Rl4tN/j+hGVZkg5CRBgwPyoYE5zpZkNDwdOZNEz0Hkx62zA/Zv
 jIRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb8ZDoA+XTANB3Yf+4m0A98P45gGUbhEzo6q296kMq+0qonmOA6hTQYAoI3ufL3IzMh3Z3jhDLsrGNWaEzmpMl6Vd976bfSNZuS4ddHwDnCz/RVTrOjcWo3VM=
X-Gm-Message-State: AOJu0YxwD2i0ucztIic56P9Eg9hQ8SNyHATDEvFhf2USEz5phhmCv3rd
 gQ/YANc6vCi1kUK81bn7UDyL296f63qPKEqSGfcT4+wMBcLLViRy
X-Google-Smtp-Source: AGHT+IEzLwbW82lrvico/HXJ23a7iVk6+uywg/vfNv3O+E8geAMGiEEHI/dmM+bUlBPdXuZmq9EBuA==
X-Received: by 2002:a05:6a21:3384:b0:1be:e01d:b1c5 with SMTP id
 adf61e73a8af0-1c0cc7552e4mr669620637.4.1720074042236; 
 Wed, 03 Jul 2024 23:20:42 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb01f6f02asm40597955ad.279.2024.07.03.23.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:20:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:20:36 +1000
Message-Id: <D2GJCVQOTZDD.2LV9K1YJQB2BA@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 16/43] target/ppc/mmu_common.c: Inline and remove
 ppc6xx_tlb_pte_check()
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <67350d0b2e2773d02536ba9cce812361ff1b5a16.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <67350d0b2e2773d02536ba9cce812361ff1b5a16.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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
> This function is only called once and we can make the caller simpler
> by inlining it.

I'm inclined to agree. Splitting into function can be nice,
but translating return values here is pretty horrible.

I think it looks right.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 71 +++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 49 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b2993e8563..784e833ff2 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -91,33 +91,6 @@ int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong e=
addr,
>      return nr;
>  }
> =20
> -static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
> -                                target_ulong pte1, int pteh,
> -                                MMUAccessType access_type, bool nx)
> -{
> -    /* Check validity and table match */
> -    if (!pte_is_valid(pte0) || ((pte0 >> 6) & 1) !=3D pteh ||
> -        (pte0 & PTE_PTEM_MASK) !=3D ctx->ptem) {
> -        return -1;
> -    }
> -    /* all matches should have equal RPN, WIMG & PP */
> -    if (ctx->raddr !=3D (hwaddr)-1ULL &&
> -        (ctx->raddr & PTE_CHECK_MASK) !=3D (pte1 & PTE_CHECK_MASK)) {
> -        qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
> -        return -3;
> -    }
> -    /* Keep the matching PTE information */
> -    ctx->raddr =3D pte1;
> -    ctx->prot =3D ppc_hash32_prot(ctx->key, pte1 & HPTE32_R_PP, nx);
> -    if (check_prot_access_type(ctx->prot, access_type)) {
> -        qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
> -        return 0;
> -    } else {
> -        qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> -        return -2;
> -    }
> -}
> -
>  /* Software driven TLB helpers */
> =20
>  static int ppc6xx_tlb_check(CPUPPCState *env,
> @@ -149,32 +122,32 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>                        tlb->EPN, eaddr, tlb->pte1,
>                        access_type =3D=3D MMU_DATA_STORE ? 'S' : 'L',
>                        access_type =3D=3D MMU_INST_FETCH ? 'I' : 'D');
> -        switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
> -                                     0, access_type, nx)) {
> -        case -2:
> -            /* Access violation */
> -            ret =3D -2;
> -            best =3D nr;
> -            break;
> -        case -1: /* No match */
> -        case -3: /* TLB inconsistency */
> -        default:
> -            break;
> -        case 0:
> -            /* access granted */
> -            /*
> -             * XXX: we should go on looping to check all TLBs
> -             *      consistency but we can speed-up the whole thing as
> -             *      the result would be undefined if TLBs are not
> -             *      consistent.
> -             */
> +        /* Check validity and table match */
> +        if (!pte_is_valid(tlb->pte0) || ((tlb->pte0 >> 6) & 1) !=3D 0 ||
> +            (tlb->pte0 & PTE_PTEM_MASK) !=3D ctx->ptem) {
> +            continue;
> +        }
> +        /* all matches should have equal RPN, WIMG & PP */
> +        if (ctx->raddr !=3D (hwaddr)-1ULL &&
> +            (ctx->raddr & PTE_CHECK_MASK) !=3D (tlb->pte1 & PTE_CHECK_MA=
SK)) {
> +            qemu_log_mask(CPU_LOG_MMU, "Bad RPN/WIMG/PP\n");
> +            /* TLB inconsistency */
> +            continue;
> +        }
> +        /* Keep the matching PTE information */
> +        best =3D nr;
> +        ctx->raddr =3D tlb->pte1;
> +        ctx->prot =3D ppc_hash32_prot(ctx->key, tlb->pte1 & HPTE32_R_PP,=
 nx);
> +        if (check_prot_access_type(ctx->prot, access_type)) {
> +            qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>              ret =3D 0;
> -            best =3D nr;
> -            goto done;
> +            break;
> +        } else {
> +            qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
> +            ret =3D -2;
>          }
>      }
>      if (best !=3D -1) {
> -done:
>          qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
>                        " prot=3D%01x ret=3D%d\n",
>                        ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);


