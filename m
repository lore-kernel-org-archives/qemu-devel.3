Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A9C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x7h-0002Hc-Da; Thu, 09 May 2024 02:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x7c-0002DX-2l; Thu, 09 May 2024 02:19:17 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x7X-0001HS-3t; Thu, 09 May 2024 02:19:15 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-23f29557e5dso329006fac.3; 
 Wed, 08 May 2024 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235548; x=1715840348; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7CrfJrUjC2Xp0513hjQp9P/dZKoqoLLSsluxs0GrPc=;
 b=kPkpYV58xAroAYpJ2EP6s7jQdhtPFXCizM4rVvH65NJoBGirmDt1gpo2UWWz/a96Bc
 v6p1tsGhc8+BBDJw7hmbFwKApyn8vXFuydoLaeWk726dJVEXUfGcHheD1HHMLSV9gO4g
 Grlcqkx3TXrhaPRn3xZaYJfAJkRdt2jA1GWkGzhgxjtWslvE7eWg31OmZkRqUsfZ7N3s
 9CiNf2sTZathN5kn91iXO3+/a8qeuqOvzh3ysU2ukEl0nR0E0ps9YePtDKuljfYf4aEe
 kYO0R1OKnBYUELnR1r0LYTgFWdy4+iGhLVpGbj4DHx1dlpT1V4ldO1zixt2WSua9u+G7
 LDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235548; x=1715840348;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l7CrfJrUjC2Xp0513hjQp9P/dZKoqoLLSsluxs0GrPc=;
 b=dA8Q/cHp8uEGrHpw9LzmXLZR8iHDReKCZ1xnbtqDvpSOTR63jS11tmUiarDXd8lUM9
 YYmHWkEtoZMojiv6KTx2/KfcWbnvP6kAVYCeT6FLWX7ykzH1SoCmiijo91GdFnY3qsKO
 fyjKKIhW6sC4SiX9tEdPpqriVGUn/OHVpi87+uQWzi7UfnfFOIwU5Q4FCa0bY3bdce1+
 m5C/6aYUVVg//jHCxYQpDZI/mJ6/thVHBZjtc9BWeWkdUd7tu4jKbFPHO2ltuJ4tvg7Y
 Kq72REOJO/N2EvRw6gXZUpeJ/nEy96L9g7X7AioIyG2TGZ4hH79q7ekvHDoF4ryhm/HN
 yFgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWec+mn9HKNgPzs5PcW9InBLQumRLXO9mUXfFqIRZs0oFba5RThfncdAP1zFNxElwxb91PTThaqo5OA2RXmh/CpMdN9pqbdgyHbsiEBZ4jtjkLNTo0C1N2wGXI=
X-Gm-Message-State: AOJu0YwPw8Ccq1OuYlzWCX+aBBmX4yHibamoAPyGlAAlMR2nIotsQ/7A
 fMYDXTadvhflbIcWOwqOoRheg8VPuHlmLGQfMFs4QE+LjP2aA8Ph
X-Google-Smtp-Source: AGHT+IF0h8n5SUFplWY3P3y4i6Xqzxep4jgmm1HarE06F5+37DZLXtWIiMwWk/jJ090fzvZdKJYdjg==
X-Received: by 2002:a05:6870:ac0d:b0:239:8ebb:564f with SMTP id
 586e51a60fabf-24098a6de18mr5527869fac.32.1715235548402; 
 Wed, 08 May 2024 23:19:08 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2ba4sm571016b3a.168.2024.05.08.23.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:19:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:19:03 +1000
Message-Id: <D14W96PLF424.HOLH7WO5DVRW@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 27/33] target/ppc/mmu_common.c: Simplify
 ppc_booke_xlate() part 2
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <a190459619957cfc6ea1c3972ac7b99defebc506.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <a190459619957cfc6ea1c3972ac7b99defebc506.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu May 9, 2024 at 9:36 AM AEST, BALATON Zoltan wrote:
> Merge the code fetch and data access cases in a common switch.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 52 ++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 32 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index bb49721004..1d56dca8ba 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1195,45 +1195,33 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vadd=
r eaddr,
> =20
>      log_cpu_state_mask(CPU_LOG_MMU, cs, 0);
>      env->error_code =3D 0;
> -    if (ret =3D=3D -1) {
> +    switch (ret) {
> +    case -1:
> +        /* No matches in page tables or TLB */
>          if (env->mmu_model =3D=3D POWERPC_MMU_BOOKE206) {
>              booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_id=
x);
>          }
> -    }
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        switch (ret) {
> -        case -1:
> -            /* No matches in page tables or TLB */
> -            cs->exception_index =3D POWERPC_EXCP_ITLB;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
> -        case -2:
> -            /* Access rights violation */
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            break;
> -        case -3:
> -            /* No execute protection violation */
> -            cs->exception_index =3D POWERPC_EXCP_ISI;
> -            env->spr[SPR_BOOKE_ESR] =3D 0;
> -            break;
> -        }
> -    } else {
> -        switch (ret) {
> -        case -1:
> -            /* No matches in page tables or TLB */
> -            cs->exception_index =3D POWERPC_EXCP_DTLB;
> -            env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> -            env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
> -        case -2:
> -            /* Access rights violation */
> -            cs->exception_index =3D POWERPC_EXCP_DSI;
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ITLB : POWERPC_EXCP_DTLB;
> +        env->spr[SPR_BOOKE_DEAR] =3D eaddr;
> +        env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_type=
);
> +        break;
> +    case -2:
> +        /* Access rights violation */
> +        cs->exception_index =3D (access_type =3D=3D MMU_INST_FETCH) ?
> +                              POWERPC_EXCP_ISI : POWERPC_EXCP_DSI;
> +        if (access_type !=3D MMU_INST_FETCH) {
>              env->spr[SPR_BOOKE_DEAR] =3D eaddr;
>              env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx, access_=
type);
> -            break;
>          }
> +        break;
> +    case -3:
> +        /* No execute protection violation */
> +        cs->exception_index =3D POWERPC_EXCP_ISI;
> +        env->spr[SPR_BOOKE_ESR] =3D 0;
> +        break;
>      }
> +
>      return false;
>  }
> =20


