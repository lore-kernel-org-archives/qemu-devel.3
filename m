Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2x3-0006Mc-DK; Wed, 17 Jul 2024 07:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2x1-0006GH-R0; Wed, 17 Jul 2024 07:36:04 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2wm-0005Vn-U7; Wed, 17 Jul 2024 07:36:03 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-75e7e110e89so3969889a12.3; 
 Wed, 17 Jul 2024 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721216145; x=1721820945; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxwjvhupHTFvXt2fcYxRLV+FFlyJbwu5pkPFP6+GVdg=;
 b=huItcS3lnVhJaHC3HINOXwES9o4xYOHLKa1cTWd1lwPYLEOfY9odoIXeYdwmaff9lL
 JNv2BECyO19kfAiWVJ8+3dU2gIzaI8LMgOj8uN29DeYF6EuKigXjZMAEilTV3l0TfC81
 jAu47gRSMU6J70hZkQW6AN3x1fYiinWpBimMT4Tr4i68m5A73uVdUB51vQwBX3cnMsIy
 zLEtB3Q3cmjQoMU0YqLN4jndn0QpXy32zaU5//9kkbqSjAUM0EqFNzmFrkMlUVAV8022
 5zt8tSyEEl6Rt2p9ATqwF4upsNSbkC6JRr5cKRyDmipOtJbIVlrsL8DMlo6z3x5qOscE
 d7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721216145; x=1721820945;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mxwjvhupHTFvXt2fcYxRLV+FFlyJbwu5pkPFP6+GVdg=;
 b=Pb17XSwsVkYn4EhoEC7vtNUBvQ4JKGYDD27cg5CoE2/JsaLs3yESYvJyNiNxzb725c
 h8VAjKcdfUrSI+TOTaVjcFMbzxt1clSXpq0/Pd4thiPZM3RRqjh629jIsqZHB7O44h6m
 fPo2sQVpH7/2Lh+auU0mAchNrgYQytAqAUU2S5mDVVCZDQF7f3+yOJR5in2SZQzz/ZTm
 RAWjSNcN3kVoYUKGEsBrQ/xbKHHVDE0nk/8PnzQXuVxMdvQQbMH1//gCjvpioDhtfcpN
 8w7cSy///ugNb8RS8xVE3qAK/yUr0bNBUgf0hTY0Z9Dh47XtaVlgtfHkMDYuv+KSFAaZ
 bDSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Uh+vVdike5WbzQnPeBBTUYSnZYGG5LNCJ9WknTvmINL81ur5PXV/XLW7tFA5Xp/opUI0bY3WrW0Pmmfy8gUkgibnmgE=
X-Gm-Message-State: AOJu0Yy2aCeWLEzg9tG3/q3b056nX5uzQeUifXogo8qhAbhYjcvSCeXP
 9yaQRubVtXexkqW1VZJ20bc2+LVsC+xbEWFi+Dr3sPi5XCT7XLUV
X-Google-Smtp-Source: AGHT+IF6GT5d8Iziis77RIhDy6APH/3AjTL0a8dkRKCcrRSE6n6IDvL9/0izupEuQ7hinxc7+FGsaw==
X-Received: by 2002:a05:6a20:841e:b0:1c2:8c32:1392 with SMTP id
 adf61e73a8af0-1c3fdcf886emr1915360637.22.1721216144694; 
 Wed, 17 Jul 2024 04:35:44 -0700 (PDT)
Received: from localhost ([1.146.100.214]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedbdb745sm7936318a91.7.2024.07.17.04.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 04:35:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 21:35:39 +1000
Message-Id: <D2RS76KLGA7S.3HDYESG57OUYU@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <balaton@eik.bme.hu>
Subject: Re: [PATCH 4/4] target/ppc: Merge helper_{dcbz,dcbzep}
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
 <20240702234659.2106870-5-richard.henderson@linaro.org>
In-Reply-To: <20240702234659.2106870-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

On Wed Jul 3, 2024 at 9:46 AM AEST, Richard Henderson wrote:
> Merge the two and pass the mmu_idx directly from translation.
> Swap the argument order in dcbz_common to avoid extra swaps.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/helper.h     |  3 +--
>  target/ppc/mem_helper.c | 14 ++++----------
>  target/ppc/translate.c  |  4 ++--
>  3 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index afc56855ff..4fa089cbf9 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl,=
 i32)
>  DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>  DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>  DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> -DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
> -DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
>  #ifdef TARGET_PPC64
>  DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
>  #endif
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index d4957efd6e..24bae3b80c 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,7 +271,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr,=
 uint32_t nb,
>  }
> =20
>  static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
> +                        int mmu_idx, int dcbz_size, uintptr_t retaddr)
>  {
>      target_ulong mask =3D ~(target_ulong)(dcbz_size - 1);
>      void *haddr;
> @@ -296,15 +296,9 @@ static void dcbz_common(CPUPPCState *env, target_ulo=
ng addr,
>      }
>  }
> =20
> -void helper_dcbz(CPUPPCState *env, target_ulong addr)
> +void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
>  {
> -    dcbz_common(env, addr, env->dcache_line_size,
> -                ppc_env_mmu_index(env, false), GETPC());
> -}
> -
> -void helper_dcbzep(CPUPPCState *env, target_ulong addr)
> -{
> -    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GE=
TPC());
> +    dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
>  }
> =20
>  #ifdef TARGET_PPC64
> @@ -320,7 +314,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr=
)
>          dcbz_size =3D 32;
>      }
> =20
> -    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GET=
PC());
> +    dcbz_common(env, addr, ppc_env_mmu_index(env, false), dcbz_size, GET=
PC());
>  }
>  #endif
> =20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2664c94522..285734065b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4458,7 +4458,7 @@ static void gen_dcbz(DisasContext *ctx)
>      }
>  #endif
> =20
> -    gen_helper_dcbz(tcg_env, tcgv_addr);
> +    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
>  }
> =20
>  /* dcbzep */
> @@ -4468,7 +4468,7 @@ static void gen_dcbzep(DisasContext *ctx)
> =20
>      gen_set_access_type(ctx, ACCESS_CACHE);
>      gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbzep(tcg_env, tcgv_addr);
> +    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_ST=
ORE));
>  }
> =20
>  /* dst / dstt */


