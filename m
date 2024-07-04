Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044DCC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFT9-0007yj-17; Thu, 04 Jul 2024 01:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFT7-0007wo-3G; Thu, 04 Jul 2024 01:57:21 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFT5-0000Gs-AU; Thu, 04 Jul 2024 01:57:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7021702f3f1so187718a34.0; 
 Wed, 03 Jul 2024 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720072637; x=1720677437; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59i0Z1RvqthVz7eqDqm6HhzUn4V1bwC40kH7CPn5I/8=;
 b=LiaXcohgK2+iAoaFGjF1O13gk3kafRL8DNB4chQIsiTYJ2LlwDYmkpz9EegXgR2kQ2
 Xy3bHVrXoliZOQzT+I1NQpY4JvYInXC5hWUQz//poy9uQ9A5/Ai4me1zo0h0cLWiGoMw
 D03v+WyU07dv/OIVhrQVCOZLVjW0wqw+0uUyORxJQWDRQIqeO24SsuLUmbtLYkuDUimL
 QtQZD82l0AzcBeVkhRo/p9NooGrWtjwDqjE9kIF8uhR78dDztsixP01CbiN66d1IXbFu
 mDCehRL7dPo3/JvzMsRf2p8+NX52Fhs5rCDuR4/Nwr3H3zCDq7qVWK1JmyWRn7nFA1Kc
 mGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072637; x=1720677437;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=59i0Z1RvqthVz7eqDqm6HhzUn4V1bwC40kH7CPn5I/8=;
 b=CRwBkToqv8MpnRirN6lbeQj32LkxJU/0m/Mu6F/G+S0xF3imKv4t2X+Cqb6tIEPTNa
 5Z9Aec01X30Mfv68uthy9nVqwzXxkXeIeaJ8YsMgYDiQQaBEgw6eW7jPKF0XHyBGhEFH
 +B9/XfPuNBSwsiv2d01662G3XPj/25hnjmt/kZMBsEQHiFfXJKNq8kxeYuI/PDudhedz
 wkoj0uNLITg20Gukj5eAoINL07J1/DgOLGn3uue4fxM94l7YkOvwUgBbeqOxoyoMicL9
 VAAXdtCg3L/iAL/lhq3PIv0gyGWlQRSdJ//L6yAzcBhN5N1x6l9kf++xSMHSn4g0LvI+
 uxNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTKYqOQh7JiRyWhteqd3YRiSXWj00TXU0INBiWWNpOlmJuwmEGjdRJd8GDPb/AOVLHechJM7dAAkCHxSOwm1sID01VsR0yRDyUjvLPf4b1uiSLUPiO+9RRfA=
X-Gm-Message-State: AOJu0YzmNcgvK6bo002zeWgQokRfXZceMm4iIWf+xm5wbYKKVwiUVMlM
 NcuoYixd1cJ5ZgJrWm7EZCj8/zVMdSIDnUgu2qHC7x4gGqGkpHwV
X-Google-Smtp-Source: AGHT+IEc1UxnpkP6q00azUYbYbBlpePFa2cvo/IOz4g9fFiXzYxhqswDfT2HuUceu2uhKKUPiUc8qA==
X-Received: by 2002:a05:6870:88a7:b0:25e:1ced:744 with SMTP id
 586e51a60fabf-25e2beabb7emr626686fac.47.1720072637447; 
 Wed, 03 Jul 2024 22:57:17 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70838a9a188sm11237627b3a.131.2024.07.03.22.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 22:57:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 15:57:11 +1000
Message-Id: <D2GIUY7X4BOW.1Y1HWUMJBI8P6@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 01/43] target/ppc: Reorganise and rename
 ppc_hash32_pp_prot()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3e66168f9d3d1667b5a1d81f74cf019ecfdd9c62.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3e66168f9d3d1667b5a1d81f74cf019ecfdd9c62.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x333.google.com
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
> Reorganise ppc_hash32_pp_prot() swapping the if legs so it does not
> test for negative first and clean up to make it shorter. Also rename
> it to ppc_hash32_prot().

Rename makes sense since it's not entirely derived from pp but
also key and nx.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-hash32.c |  2 +-
>  target/ppc/mmu-hash32.h | 35 +++++++++++++----------------------
>  target/ppc/mmu_common.c |  2 +-
>  3 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index d5f2057eb1..8a446c8a7d 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -45,7 +45,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
>      key =3D !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
>      pp =3D pte.pte1 & HPTE32_R_PP;
> =20
> -    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
> +    return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
>  }
> =20
>  static target_ulong hash32_bat_size(int mmu_idx,
> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
> index f0ce6951b4..bc4eedbecc 100644
> --- a/target/ppc/mmu-hash32.h
> +++ b/target/ppc/mmu-hash32.h
> @@ -102,49 +102,40 @@ static inline void ppc_hash32_store_hpte1(PowerPCCP=
U *cpu,
>      stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte=
1);
>  }
> =20
> -static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
> +static inline int ppc_hash32_prot(bool key, int pp, bool nx)
>  {
>      int prot;
> =20
> -    if (key =3D=3D 0) {
> +    if (key) {
>          switch (pp) {
>          case 0x0:
> -        case 0x1:
> -        case 0x2:
> -            prot =3D PAGE_READ | PAGE_WRITE;
> +            prot =3D 0;
>              break;
> -
> +        case 0x1:
>          case 0x3:
>              prot =3D PAGE_READ;
>              break;
> -
> +        case 0x2:
> +            prot =3D PAGE_READ | PAGE_WRITE;
> +            break;
>          default:
> -            abort();
> +            g_assert_not_reached();
>          }
>      } else {
>          switch (pp) {
>          case 0x0:
> -            prot =3D 0;
> -            break;
> -
>          case 0x1:
> -        case 0x3:
> -            prot =3D PAGE_READ;
> -            break;
> -
>          case 0x2:
>              prot =3D PAGE_READ | PAGE_WRITE;
>              break;
> -
> +        case 0x3:
> +            prot =3D PAGE_READ;
> +            break;
>          default:
> -            abort();
> +            g_assert_not_reached();
>          }
>      }
> -    if (nx =3D=3D 0) {
> -        prot |=3D PAGE_EXEC;
> -    }
> -
> -    return prot;
> +    return nx ? prot : prot | PAGE_EXEC;
>  }
> =20
>  typedef struct {
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index e2542694f0..08c5b61f76 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -120,7 +120,7 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, targe=
t_ulong pte0,
>              }
>              /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
> -            ctx->prot =3D ppc_hash32_pp_prot(ctx->key, pp, ctx->nx);
> +            ctx->prot =3D ppc_hash32_prot(ctx->key, pp, ctx->nx);
>              if (check_prot_access_type(ctx->prot, access_type)) {
>                  /* Access granted */
>                  qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");


