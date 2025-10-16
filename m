Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC1CCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XBM-0007xY-PG; Thu, 16 Oct 2025 19:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XBE-0007xN-VO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:14:45 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XBC-0007np-4N
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:14:43 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so2302459a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760656480; x=1761261280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrlSni9ZedQWlOiEUbc9dD2qNgW/bi8cLd2f/HrMi0M=;
 b=eBx01hg8tX/VDitAgu4yS7vaCteIDHfedWQ3XGb2jkMEa55AShpeEkgZdlSang0I7i
 AsPdlbvbz+Gl1Ng/TaizrupZLhmoJI+sNWU1kiN3qhGWYmB3nI2TR1qVL8PSwlvwEZDc
 7y7Vhwz5lMfpS1tLJZ5bP2IeySdKVBHMoax17pAa5xGp3LzvbRFJugglj0qovRwifCaw
 vmYPiKrcQVBhmJvr/nbea+ZLXetkkmAsxj+hwyld2kfvAPG/OhGlWwXR2b3ZLUse3APg
 VibbZvDrTWiPl14F2ZWwL+TjZ+FELaCmTqrrnJKYa35SwDWT1/FaK7E8KdVBvXT3l3RO
 Q6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760656480; x=1761261280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OrlSni9ZedQWlOiEUbc9dD2qNgW/bi8cLd2f/HrMi0M=;
 b=io+2VsSiFZKT47kdM1+9wA0RTdPoegmyXhRF0Oo/1orRN/KRZ2t/BvxZEfMlgKJufy
 zjtKz2csCs5PKiO8vAyNjQJpEk2gXV5wAcBpYO00bKXrthedJJyfbOPbes6GGni/IgDI
 agYLbG4DIxronbzl1IIAkJZwwMY2A8zbgXbZMdnCZTeBi9URZtWEQa4kIoyoOhuMmg8Y
 sAeK9ve8IhJ495zLLza+z/fHmXkNOvVd5HK2ZW077SveboQVDzDKvEzU9k6v6yG8dwpa
 1DQtxR1QihxbqzRPb3kY6l+p1Frgdi+QZDL3g1lpku54dN+K14Mw5zNm7a7k6caaOzjE
 tucQ==
X-Gm-Message-State: AOJu0Yx5mg+SfljV2pztzmnp8rrYC8qClMl2NXdJh7s/oDLbLwCmKRnK
 M+5XM+sV9NSg4WK4VczJ3HE49bEZ4FLDeqkOe4fJEf30DAGZfNUnxPnOgpgPqWMHCr3k0tGOcRw
 RJRmTbp8tywjGw9FKGNhTzbM1VldoPzo=
X-Gm-Gg: ASbGnctgiwAW8M33NwwGuJrXs72Y5KvxUIWZobclbsBRHIrq5qaMgTd83viBptT1dKF
 xxWpk0IubvAGIswnu8OviSl2Bm2vF3nth7m+/7aBRmdhs4AzkqID9XrlGSsZJwFzWj+GC8spCTw
 +jEg0muWQYhGaNLZ84LE8OTyJkkDsD7SV9W0afDozxddrZPemcU1jC0UvNmUprK5hkzm2nQHJFz
 4x2kC18uYgcWqT2ichJViXqIJusbqdpfVhjd1EiYC5sbFe7Tq1Za9MpqP6DAPHZ5wa7A5pJjmAq
 GGDjNe0vhPQ4d1E=
X-Google-Smtp-Source: AGHT+IHOcy5D6rhtZOpS851JjTpZ1ekmtefeWCG/3hAGWmzsOH91Lv0pCf/8jue1ZrAH9o7PQbuGaLHToj0tiNLeWVs=
X-Received: by 2002:a05:6402:1e91:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-63c1f631cb9mr1514726a12.8.1760656479843; Thu, 16 Oct 2025
 16:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-21-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-21-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:14:13 +1000
X-Gm-Features: AS18NWAMo8kfUynyR4GeU7G_1bfqmeDccwB6kzNkEEYAeUgcmOE7EjCvCTr-yCA
Message-ID: <CAKmqyKO5guqLxMMY=BpjX_4dLySuUFkewKqQYbk01qpTbJFBwg@mail.gmail.com>
Subject: Re: [PATCH v3 20/34] target/riscv: Fix size of sw_check_code
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 15, 2025 at 6:39=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> The field only holds values of 2 and 3, fix its size to 8 bits and
> update stores from TCG.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                            | 2 +-
>  target/riscv/translate.c                      | 4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6bee15cb5e..37035a9541 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -259,7 +259,7 @@ struct CPUArchState {
>      /* env place holder for extra word 2 during unwind */
>      uint64_t excp_uw2;
>      /* sw check code for sw check exception */
> -    target_ulong sw_check_code;
> +    uint8_t sw_check_code;
>  #ifdef CONFIG_USER_ONLY
>      uint32_t elf_flags;
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 14c8f1c6a2..ca7e6c44c6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1362,8 +1362,8 @@ static void riscv_tr_translate_insn(DisasContextBas=
e *dcbase, CPUState *cpu)
>      if (ctx->fcfi_lp_expected) {
>          /* Emit after insn_start, i.e. before the op following insn_star=
t. */
>          tcg_ctx->emit_before_op =3D QTAILQ_NEXT(ctx->base.insn_start, li=
nk);
> -        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                        tcg_env, offsetof(CPURISCVState, sw_check_code))=
;
>          gen_helper_raise_exception(tcg_env,
>                        tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>          tcg_ctx->emit_before_op =3D NULL;
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 9c8c04b2dc..5efdd95f97 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -53,8 +53,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>          /*
>           * misaligned, according to spec we should raise sw check except=
ion
>           */
> -        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                        tcg_env, offsetof(CPURISCVState, sw_check_code))=
;
>          gen_helper_raise_exception(tcg_env,
>                        tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>          return true;
> @@ -66,8 +66,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>          TCGv tmp =3D tcg_temp_new();
>          tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
>          tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
> -        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> -                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                        tcg_env, offsetof(CPURISCVState, sw_check_code))=
;
>          gen_helper_raise_exception(tcg_env,
>                        tcg_constant_i32(RISCV_EXCP_SW_CHECK));
>          gen_set_label(skip);
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index fa1489037d..3f71adec35 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -40,8 +40,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspop=
chk *a)
>                         mxl_memop(ctx) | MO_ALIGN);
>      TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
>      tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
> -    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
> -                  tcg_env, offsetof(CPURISCVState, sw_check_code));
> +    tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
> +                    tcg_env, offsetof(CPURISCVState, sw_check_code));
>      gen_update_pc(ctx, 0);
>      gen_helper_raise_exception(tcg_env,
>                    tcg_constant_i32(RISCV_EXCP_SW_CHECK));
> --
> 2.51.0
>
>

