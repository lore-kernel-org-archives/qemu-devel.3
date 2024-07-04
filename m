Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C9C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFyi-0002bp-Tm; Thu, 04 Jul 2024 02:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFyg-0002V7-FH; Thu, 04 Jul 2024 02:29:58 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFyb-0005v0-N9; Thu, 04 Jul 2024 02:29:58 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d562882f4cso179585b6e.3; 
 Wed, 03 Jul 2024 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720074589; x=1720679389; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKtWIS09A0aISSqGDsi3vPvEVYzkO5o8jndQWgV8jno=;
 b=ljmpzl4EDwxl55VQRq/oesUlPimM1XzpKyNQR43UVzUqCTCq3J5skY+v6wL4Oxctpe
 RWVYhw4r8rB8sYfSHbqWpmoStF9W83hD7f7TnSPHup75EzJ4HB3zq1uAAyxXdElvQ9MF
 kGYhJgyjInkv2eawBXG9vigCrMHzwG/ms4KrZ3hJ7c9WNxm/Epf2GBiJPfgkHXdL/0I0
 4DPqkk9TIhFsSxH7AU1WeISlsC9jpsM4fT1tZppIYytpS/t+CAskNYHbGB0JI/9R8ttx
 0hmBG/ribAmTRmoD3Ah3fBaV+Om6IaWvvcCCgKo1WZK3a78ap9c7b4/RW3yJrHnSLY7F
 blrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074589; x=1720679389;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fKtWIS09A0aISSqGDsi3vPvEVYzkO5o8jndQWgV8jno=;
 b=Yxt1vZNPZ1aD4NDdqvtkvVDRm0RB4CHlRellnCuSMKvOo6KALlKXnjnC3eMckItdbm
 ZhWiqsaAj2JPl/50SPgioDz4nd47GrUrg3fQa0rTOBFH2LgpLwL7YqgFkx6Re+E08ZEV
 kuuTMhfp3aCjyKxe4WDGDT+TzkkUAjd/IZAY5wkIHNPdltcTKgsUyfEmZFllq/MuOu5w
 ludVc1AaOjYpXTBOF6X3trmlmU+OzWo7lx1nybxfX4mQeKi9VmaurHA7lBLx1qkPqxTg
 p0yHOZB722pxVZpa4CK/NBwdX75hemJdJ7OJdPAAvLWQweWqO4/zC+F9XQ22QEuE4y70
 yWew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUR8mFDZJEFZ334gIJ1DWAcG1ivYNEHcV4he09OSM1YgQCiVNzRvE1K8Idrd1apevio6RR5JVegYppP+eYRt0+VgeCYCeX1KdDgkXISLWwTA3B+IiRNyh7xi0=
X-Gm-Message-State: AOJu0YwT1vqaD/43AWOqunX6D0PtCHl8a0nBEIOsOx2LIees702YDvE1
 4gDZH+3Q3JeoR8l5K/PicHhZlqBW3Oj1/a0ahq3oReKBE0hxIPJE
X-Google-Smtp-Source: AGHT+IGs44u0LMWXMjDDyZ8q2CvIyg+9Gel6QyT/XMiQFu9jaODfy+aGJqg4r2gWtu+h7sU/Hujeyw==
X-Received: by 2002:a05:6808:3090:b0:3d5:6410:7dbb with SMTP id
 5614622812f47-3d914c54adamr893841b6e.14.1720074588807; 
 Wed, 03 Jul 2024 23:29:48 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708043b76a5sm11840571b3a.149.2024.07.03.23.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:29:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:29:43 +1000
Message-Id: <D2GJJUUJHE5D.22LIBE6YC5B9T@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 20/43] target/ppc/mmu_common.c: Init variable in
 function that relies on it
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <fc23244334aa4e70e0ad0cdb04265b8257104948.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <fc23244334aa4e70e0ad0cdb04265b8257104948.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> The ppc6xx_tlb_check() relies on the caller to initialise raddr field
> in ctx. Move this init from the only caller into the function.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 1ed2f45ac7..fe321ab49c 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -102,6 +102,8 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
>      int nr, best, way, ret;
>      bool is_code =3D (access_type =3D=3D MMU_INST_FETCH);
> =20
> +    /* Initialize real address with an invalid value */
> +    ctx->raddr =3D (hwaddr)-1ULL;
>      best =3D -1;
>      ret =3D -1; /* No TLB found */
>      for (way =3D 0; way < env->nb_ways; way++) {
> @@ -340,8 +342,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>                        ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu)=
, hash);
>          *hashp =3D hash;
> =20
> -        /* Initialize real address with an invalid value */
> -        ctx->raddr =3D (hwaddr)-1ULL;
>          /* Software TLB search */
>          return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
>      }


