Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B65C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2ua-0004QB-2u; Wed, 17 Jul 2024 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2uY-0004J1-7j; Wed, 17 Jul 2024 07:33:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2uW-0003xB-88; Wed, 17 Jul 2024 07:33:29 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-78964fd9f2dso4163795a12.3; 
 Wed, 17 Jul 2024 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721216006; x=1721820806; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvBypB4KdX9VPg48aEI4vYTZQhSSmRiDphqCzsM2wRE=;
 b=XSzCsXDZTmjfijEyHtae1ZT9R2uaXio+VO/x6FDshzup8xqeNrSTd7wRl2k4v9IVi3
 eFDJuL75WQGDKlAfaG6ZGC5kvRvZ4HyGwvPV7EHNOQCa61btJGPkUCW1R18Z4K2wA7uG
 m/CxUcee4i0fT+JFjyTT2vrXhPqI/GWuJuAEEdySqUZjYGqxpRjjz+dp2D2+DqEalBfH
 /pJteTs6hYYfGIifBFY62tcxJeHiGVrVFH1c5MQ+GcC2mfoyZyuhVuEJcJ0FiM1mNok+
 370sKZmnjE3k/sYVNSVO768pjBFQ79eIB/CCQhPVkpk2b7bx5DjCTRwg4qww56NRXTq/
 YWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721216006; x=1721820806;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yvBypB4KdX9VPg48aEI4vYTZQhSSmRiDphqCzsM2wRE=;
 b=Tabgc3jzuWGNhVu3AhHIpASQTc1E4YHMzM9HFNwXVZs4FjM3raNS0IyuNel7WmBOOS
 Q784kqmkSaXfx7s/Zdjh4X8fXLjCwEjX3Zm/1h66WItLAwFkS6jRNTQu3pZK3EmyFKQt
 oHVPm+0ozGPorlRUNH0Sk/nwjEjz7OlSr3oEwrInqtA0dCisx5XxaXcCC86q7qZxCbt4
 o/OhPkGtuQKJ35JxsI+Q4im2GvN79qQzog24s+S0nlwoxF5kDtj6fOqZnc1Te/kkY4Vp
 lbzUimhk9oeyd0FshccCPTw2EAIFOld53bMN0rrB7RNGZAKTe2xjmlbdObgiZQdGhkhp
 bzsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDuvtgrqpmRfKh5zYnFIyP7nR5vx54Yzd2jtQwthWjGqiXuoB1jZFzP/4tt3EQczaAkEY4KfpCFsxVisB/MV0DT1+DLw4=
X-Gm-Message-State: AOJu0YxwpARPAUnTF0K20Rfj6efO9bZ+pjoTV547GRpemLMHDwb8OuQ5
 NwYxBFtP+pnimiefbW5u04t/4bNjrxwfeQM0xxjXnq/e8L4/lYzj
X-Google-Smtp-Source: AGHT+IFb9SUzzTmDrCURhGGUhryXy8/X78A4X+cxQHRIyndpvzHiEXZT/hUsEigtQ2oakuy62b+pXg==
X-Received: by 2002:a05:6a20:1582:b0:1c0:f323:1b9d with SMTP id
 adf61e73a8af0-1c3fdcff646mr1655560637.20.1721216006005; 
 Wed, 17 Jul 2024 04:33:26 -0700 (PDT)
Received: from localhost ([1.146.100.214]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc50b59sm73260525ad.285.2024.07.17.04.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 04:33:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 21:33:20 +1000
Message-Id: <D2RS5EPS7RZF.25PF4KRH25PH6@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <balaton@eik.bme.hu>
Subject: Re: [PATCH 3/4] target/ppc: Split out helper_dbczl for 970
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
 <20240702234659.2106870-4-richard.henderson@linaro.org>
In-Reply-To: <20240702234659.2106870-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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
> We can determine at translation time whether the insn is or
> is not dbczl.  We must retain a runtime check against the
> HID5 register, but we can move that to a separate function
> that never affects other ppc models.

Looks right I think. You could go one further and have the
HID bit on 970 a hflag, but that might be overkill without
numbers...

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/helper.h     |  7 +++++--
>  target/ppc/mem_helper.c | 34 +++++++++++++++++++++-------------
>  target/ppc/translate.c  | 24 ++++++++++++++----------
>  3 files changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 76b8f25c77..afc56855ff 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -46,8 +46,11 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl=
, i32)
>  DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>  DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>  DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> -DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
> -DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
> +DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
> +#ifdef TARGET_PPC64
> +DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
> +#endif
>  DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
>  DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
>  DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 5067919ff8..d4957efd6e 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -296,26 +296,34 @@ static void dcbz_common(CPUPPCState *env, target_ul=
ong addr,
>      }
>  }
> =20
> -void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +void helper_dcbz(CPUPPCState *env, target_ulong addr)
>  {
> -    int dcbz_size =3D env->dcache_line_size;
> -
> -#if defined(TARGET_PPC64)
> -    /* Check for dcbz vs dcbzl on 970 */
> -    if (env->excp_model =3D=3D POWERPC_EXCP_970 &&
> -        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) =
=3D=3D 1) {
> -        dcbz_size =3D 32;
> -    }
> -#endif
> -
> -    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GET=
PC());
> +    dcbz_common(env, addr, env->dcache_line_size,
> +                ppc_env_mmu_index(env, false), GETPC());
>  }
> =20
> -void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +void helper_dcbzep(CPUPPCState *env, target_ulong addr)
>  {
>      dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GE=
TPC());
>  }
> =20
> +#ifdef TARGET_PPC64
> +void helper_dcbzl(CPUPPCState *env, target_ulong addr)
> +{
> +    int dcbz_size =3D env->dcache_line_size;
> +
> +    /*
> +     * The translator checked for POWERPC_EXCP_970.
> +     * All that's left is to check HID5.
> +     */
> +    if (((env->spr[SPR_970_HID5] >> 7) & 0x3) =3D=3D 1) {
> +        dcbz_size =3D 32;
> +    }
> +
> +    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GET=
PC());
> +}
> +#endif
> +
>  void helper_icbi(CPUPPCState *env, target_ulong addr)
>  {
>      addr &=3D ~(env->dcache_line_size - 1);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0bc16d7251..2664c94522 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -200,6 +200,7 @@ struct DisasContext {
>      uint32_t flags;
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
> +    powerpc_excp_t excp_model;

Should we make this TARGET_PPC64 only? I think so, I can check
it an fold that in.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

>  };
> =20
>  #define DISAS_EXIT         DISAS_TARGET_0  /* exit to main loop, pc upda=
ted */
> @@ -4445,27 +4446,29 @@ static void gen_dcblc(DisasContext *ctx)
>  /* dcbz */
>  static void gen_dcbz(DisasContext *ctx)
>  {
> -    TCGv tcgv_addr;
> -    TCGv_i32 tcgv_op;
> +    TCGv tcgv_addr =3D tcg_temp_new();
> =20
>      gen_set_access_type(ctx, ACCESS_CACHE);
> -    tcgv_addr =3D tcg_temp_new();
> -    tcgv_op =3D tcg_constant_i32(ctx->opcode & 0x03FF000);
>      gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
> +
> +#ifdef TARGET_PPC64
> +    if (ctx->excp_model =3D=3D POWERPC_EXCP_970 && !(ctx->opcode & 0x002=
00000)) {
> +        gen_helper_dcbzl(tcg_env, tcgv_addr);
> +        return;
> +    }
> +#endif
> +
> +    gen_helper_dcbz(tcg_env, tcgv_addr);
>  }
> =20
>  /* dcbzep */
>  static void gen_dcbzep(DisasContext *ctx)
>  {
> -    TCGv tcgv_addr;
> -    TCGv_i32 tcgv_op;
> +    TCGv tcgv_addr =3D tcg_temp_new();
> =20
>      gen_set_access_type(ctx, ACCESS_CACHE);
> -    tcgv_addr =3D tcg_temp_new();
> -    tcgv_op =3D tcg_constant_i32(ctx->opcode & 0x03FF000);
>      gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
> +    gen_helper_dcbzep(tcg_env, tcgv_addr);
>  }
> =20
>  /* dst / dstt */
> @@ -6480,6 +6483,7 @@ static void ppc_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
>      ctx->hv =3D (hflags >> HFLAGS_HV) & 1;
>      ctx->insns_flags =3D env->insns_flags;
>      ctx->insns_flags2 =3D env->insns_flags2;
> +    ctx->excp_model =3D env->excp_model;
>      ctx->access_type =3D -1;
>      ctx->need_access_type =3D !mmu_is_64bit(env->mmu_model);
>      ctx->le_mode =3D (hflags >> HFLAGS_LE) & 1;


