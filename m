Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HhO-0002eT-TP; Tue, 07 May 2024 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HhL-0002dQ-BN; Tue, 07 May 2024 06:05:25 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4HhJ-0002I4-GU; Tue, 07 May 2024 06:05:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so24219855ad.3; 
 Tue, 07 May 2024 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076319; x=1715681119; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x31lE0yuJIxCKumgIu+jV4IJl/nOvm3WNORaNv++ux4=;
 b=TkLPobjy+bP6XaObSA/gXrla1umIPZuELkcEzROUij0BS+6HAXCRG4eZoCt55u8nOm
 chCS2vD7Qzdxz0mRhWdjPOfprJfzonurGT9Vv+HS0ib+retPqx1bnB8RxMJrRtKyHS5V
 w3zawEl7BtJgtfv7kj1PSwrdQKZUCzIHYUgol+bFe4ydJmsoBJkRqo/TgI4ZAJvf9RKE
 cHZIA1OFFbAwab4IPMe5/49NcF9ycOWlOzt0YE2ESIr+C8SQ9Kj+UQgdFZgFKTe99iIe
 v4M9Z/UoGIxGOoWrX9yzXelaAJVHzRGJFeiRSa0i7umLx2FlP+M6Pir27ATrxChQ75NQ
 ULHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076319; x=1715681119;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x31lE0yuJIxCKumgIu+jV4IJl/nOvm3WNORaNv++ux4=;
 b=EQ7N0YEhtMIq/JiULsYdnbHtJ6DhvTbu09LJtueyjdI48Yce3v94SeG9QUy0SUCPVl
 NYm4NBEw6x5n9T/sqmj1QfeGGdJ2Kb1KT6BYOjiEjOl/Cf6JkIGe3sjuK81Y08o9mMDG
 ubDRA94euARWWV7gooqBfTmRqq9b7c62o3n74wr7sjKyin5MyJ5UWYICioEi5rP/emS4
 9ksgpJOdjQiVs/Fn9+pbp3pFHAd936cxYFlYcOqHv3h9Nv3vcz0aFoAIfTe/MX3UOwDr
 I8NMwYfxvVOvmrbpXUXSek1uEQ2dEXY1IhnWJASG6si/hm4vPZUn7oHVYajVVsnzlRk6
 P2QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyj7NHcSi5V7tjY4BR1cFl/uPJ/6g506UnjOij3XRSamxyunXMT24kHX1v5e8PQi8IvUOq46DMxJ7YPliba7mI7usfmiSLjy7eJ9BDWu0VslEqTtJnrmfcYig=
X-Gm-Message-State: AOJu0Yxk7Hza65iwrdy8uMFuht2+Hii+l1FxZWdw8vtCl463lFts4oZK
 /xSKg8RC9Vt8UUHgQW5mt96jK8/q3/25wqK9REJtdyyoO2zENlEoldRwuA==
X-Google-Smtp-Source: AGHT+IH2pbJY8ZtNwgPUfg//0km2aBO2X9I+dlSPbPdYoCLtLeJXjkVCBstwl9IHyBbze/rwu70E9w==
X-Received: by 2002:a17:902:cec3:b0:1eb:800:e888 with SMTP id
 d3-20020a170902cec300b001eb0800e888mr15882424plg.43.1715076319382; 
 Tue, 07 May 2024 03:05:19 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001e98f928d0fsm9705975plg.10.2024.05.07.03.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:05:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:05:14 +1000
Message-Id: <D13BTA1IW22O.UCZDQHVIHV8V@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 17/28] target/ppc/mmu_common.c: Fix misindented
 qemu_log_mask() calls
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <d8ec88b4c583bfbf5f084ff43067620ede3d6552.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <d8ec88b4c583bfbf5f084ff43067620ede3d6552.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> Fix several qemu_log_mask() calls that are misindented.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 42 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ebf18a751c..28847c32f2 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -297,8 +297,8 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_c=
tx_t *ctx,
>      int ret =3D -1;
>      bool ifetch =3D access_type =3D=3D MMU_INST_FETCH;
> =20
> -     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __fun=
c__,
> -             ifetch ? 'I' : 'D', virtual);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func=
__,
> +                  ifetch ? 'I' : 'D', virtual);
>      if (ifetch) {
>          BATlt =3D env->IBAT[1];
>          BATut =3D env->IBAT[0];
> @@ -312,9 +312,9 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu_c=
tx_t *ctx,
>          BEPIu =3D *BATu & 0xF0000000;
>          BEPIl =3D *BATu & 0x0FFE0000;
>          bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
> -         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BAT=
u "
> -                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func=
__,
> -                       ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
> +        qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu=
 "
> +                      TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func_=
_,
> +                      ifetch ? 'I' : 'D', i, virtual, *BATu, *BATl);
>          if ((virtual & 0xF0000000) =3D=3D BEPIu &&
>              ((virtual & 0x0FFE0000) & ~bl) =3D=3D BEPIl) {
>              /* BAT matches */
> @@ -346,12 +346,11 @@ static int ppc6xx_tlb_get_bat(CPUPPCState *env, mmu=
_ctx_t *ctx,
>                  BEPIu =3D *BATu & 0xF0000000;
>                  BEPIl =3D *BATu & 0x0FFE0000;
>                  bl =3D (*BATu & 0x00001FFC) << 15;
> -                 qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v "
> -                               TARGET_FMT_lx " BATu " TARGET_FMT_lx
> -                               " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_=
lx " "
> -                               TARGET_FMT_lx " " TARGET_FMT_lx "\n",
> -                               __func__, ifetch ? 'I' : 'D', i, virtual,
> -                               *BATu, *BATl, BEPIu, BEPIl, bl);
> +                qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_l=
x
> +                              " BATu " TARGET_FMT_lx " BATl " TARGET_FMT=
_lx
> +                              "\n\t" TARGET_FMT_lx " " TARGET_FMT_lx " "
> +                              TARGET_FMT_lx "\n", __func__, ifetch ? 'I'=
 : 'D',
> +                              i, virtual, *BATu, *BATl, BEPIu, BEPIl, bl=
);
>              }
>          }
>      }
> @@ -400,9 +399,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      hash =3D vsid ^ pgidx;
>      ctx->ptem =3D (vsid << 7) | (pgidx >> 10);
> =20
> -    qemu_log_mask(CPU_LOG_MMU,
> -            "pte segment: key=3D%d ds %d nx %d vsid " TARGET_FMT_lx "\n"=
,
> -            ctx->key, ds, ctx->nx, vsid);
> +    qemu_log_mask(CPU_LOG_MMU, "pte segment: key=3D%d ds %d nx %d vsid "
> +                  TARGET_FMT_lx "\n", ctx->key, ds, ctx->nx, vsid);
>      ret =3D -1;
>      if (!ds) {
>          /* Check if instruction fetch is allowed, if needed */
> @@ -599,9 +597,9 @@ static int mmu40x_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>              return 0;
>          }
>      }
> -     qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> -                   " =3D> " HWADDR_FMT_plx
> -                   " %d %d\n", __func__, address, raddr, ctx->prot, ret)=
;
> +    qemu_log_mask(CPU_LOG_MMU, "%s: access refused " TARGET_FMT_lx
> +                  " =3D> " HWADDR_FMT_plx " %d %d\n",
> +                  __func__, address, raddr, ctx->prot, ret);
> =20
>      return ret;
>  }
> @@ -713,11 +711,11 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t=
 *tlb, hwaddr *raddrp,
>      }
> =20
>      mask =3D ~(booke206_tlb_to_page_size(env, tlb) - 1);
> -     qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=3D0x" TARGET_FMT_lx
> -                   " PID=3D0x%x MAS1=3D0x%x MAS2=3D0x%" PRIx64 " mask=3D=
0x%"
> -                   HWADDR_PRIx " MAS7_3=3D0x%" PRIx64 " MAS8=3D0x%" PRIx=
32 "\n",
> -                   __func__, address, pid, tlb->mas1, tlb->mas2, mask,
> -                   tlb->mas7_3, tlb->mas8);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: TLB ADDR=3D0x" TARGET_FMT_lx
> +                  " PID=3D0x%x MAS1=3D0x%x MAS2=3D0x%" PRIx64 " mask=3D0=
x%"
> +                  HWADDR_PRIx " MAS7_3=3D0x%" PRIx64 " MAS8=3D0x%" PRIx3=
2 "\n",
> +                  __func__, address, pid, tlb->mas1, tlb->mas2, mask,
> +                  tlb->mas7_3, tlb->mas8);
> =20
>      /* Check PID */
>      tlb_pid =3D (tlb->mas1 & MAS1_TID_MASK) >> MAS1_TID_SHIFT;


