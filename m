Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C94C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinbM-0001Z2-3s; Tue, 27 Aug 2024 00:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinbK-0001XC-85; Tue, 27 Aug 2024 00:14:38 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinbH-0007T4-FY; Tue, 27 Aug 2024 00:14:37 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-844f07f6205so699517241.0; 
 Mon, 26 Aug 2024 21:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724732073; x=1725336873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRThoTPXKqJ5/2Omh96xk9S4odwj/TtWtCREJ+qbYWE=;
 b=P2pHs9ybmmagChCGyj09xPMNRNuuNdz077szco8+e6Bd2rn623POrfWJ4dD1IEHJhQ
 JUT/cGdcTRs6r0M3rYsO/2ncXlnD6qGKAG4daPHsm5M6XuH5J0AD2yJCYR55YH7cXrWM
 +8L0TNoR0j6drOuZhiFclGJbCUxLLkwDnuLlYrB+ScvvxCe7w3JYMjEkgRv/64makELT
 etq5ELdsr2KDzdF8HpyNkmaB3mvey8A1rEALkvpPt+jgDY+U9u/y6uAHYvjEvGLpd5ga
 Om7OBFPpukcqvXc3jFEtHEuSii4lvJoXEyyTiarUevQSYBHXtjJTESgoKuayD3VlQ0I2
 hwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724732073; x=1725336873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRThoTPXKqJ5/2Omh96xk9S4odwj/TtWtCREJ+qbYWE=;
 b=aUh7JDwks1TZIOKCSMHDWuPhKdqQfDJjv++uXhtM7sv87+flRP67u1FrDSFrJ6cA0j
 nKuH01bK9a7Z4tbvW6+SGY/1AdO5rSjsi2w6ZLrosovXnQDAKKg9lDpF7YZKkggWHedB
 ZJdROAB/Shpbev4jh6rosm3zzlyRI2zjMYgxa3Mu2/p/S7WHBRlkvuSNN2XEFPgHB20J
 dy/f44RCV7QIk7G6sYMiQaFpyz9B2Oz9LmESowxSgpbvVmZskGUfJTM3uhpGxXaYBUzj
 U2KBB7IGn/E3M+VijWRgj3AS470BR5zQrcFiuvmegc6b3jLyFNYhdsSMLh7sbziLAiEs
 7+bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXxYNmo51gzIaSF27ts2s95lq5oTViteOW2aR8kpFMrshYRlqFn3WF1WBcaZCo1vclEHhjAUQQgZd+@nongnu.org
X-Gm-Message-State: AOJu0YxlLgw5wLw2pKtxDyQaIPZRdUGGGpEZVLkbtC+zGgi1WYW3+bRm
 Z0VGXiDktxZIsS3MuYyfNYVZCV+gZzObQHDvgqj7zcDgM+HrqSPBXPLFdlVWJGtpVSi9/b5gHmc
 E1MOLCZdCBKL0Ef/3sH64eRGHs+iBb50p0d8=
X-Google-Smtp-Source: AGHT+IEikwlD3dny/prLmH2z+r3gibWfWwpwGXfk1H6O/9zfw0dNe7WPVPxvLrzTWA5VCBVqajh09d1SFA6bNESa68U=
X-Received: by 2002:a05:6102:955:b0:493:e66f:6bac with SMTP id
 ada2fe7eead31-498f457e7c6mr14610606137.11.1724732073376; Mon, 26 Aug 2024
 21:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-7-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-7-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 14:14:07 +1000
Message-ID: <CAKmqyKOXL85J9kM10cuh-JeVjU6ovy8vkMbkAj=ReE9E+xrL0A@mail.gmail.com>
Subject: Re: [PATCH v9 06/17] target/riscv: zicfilp `lpad` impl and branch
 tracking
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 1:33=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Implements setting lp expected when `jalr` is encountered and implements
> `lpad` instruction of zicfilp. `lpad` instruction is taken out of
> auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
> target of an indirect branch, cpu checks for 20 bit value in x7 upper
> with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
> sw check exception with tval =3D 2.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_user.h                 |  1 +
>  target/riscv/insn32.decode              |  5 ++-
>  target/riscv/insn_trans/trans_rvi.c.inc | 55 +++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
> index 02afad608b..e6927ff847 100644
> --- a/target/riscv/cpu_user.h
> +++ b/target/riscv/cpu_user.h
> @@ -15,5 +15,6 @@
>  #define xA6 16
>  #define xA7 17  /* syscall number for RVI ABI */
>  #define xT0 5   /* syscall number for RVE ABI */
> +#define xT2 7
>
>  #endif
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c45b8fa1d8..27108b992b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011=
 @sfence_vm
>
>  # *** RV32I Base Instruction Set ***
>  lui      ....................       ..... 0110111 @u
> -auipc    ....................       ..... 0010111 @u
> +{
> +  lpad   label:20                   00000 0010111
> +  auipc  ....................       ..... 0010111 @u
> +}
>  jal      ....................       ..... 1101111 @j
>  jalr     ............     ..... 000 ..... 1100111 @i
>  beq      ....... .....    ..... 000 ..... 1100011 @b
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 98e3806d5e..b427f3a939 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -36,6 +36,49 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
>      return true;
>  }
>
> +static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
> +{
> +    /*
> +     * fcfi_lp_expected can set only if fcfi was eanbled.
> +     * translate further only if fcfi_lp_expected set.
> +     * lpad comes from NOP space anyways, so return true if
> +     * fcfi_lp_expected is false.
> +     */
> +    if (!ctx->fcfi_lp_expected) {
> +        return true;
> +    }
> +
> +    ctx->fcfi_lp_expected =3D false;
> +    if ((ctx->base.pc_next) & 0x3) {
> +        /*
> +         * misaligned, according to spec we should raise sw check except=
ion
> +         */
> +        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        gen_helper_raise_exception(tcg_env,
> +                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
> +        return true;
> +    }
> +
> +    /* per spec, label check performed only when embedded label non-zero=
 */
> +    if (a->label !=3D 0) {
> +        TCGLabel *skip =3D gen_new_label();
> +        TCGv tmp =3D tcg_temp_new();
> +        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
> +        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                      tcg_env, offsetof(CPURISCVState, sw_check_code));
> +        gen_helper_raise_exception(tcg_env,
> +                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
> +        gen_set_label(skip);
> +    }
> +
> +    tcg_gen_st8_tl(tcg_constant_tl(0), tcg_env,
> +                  offsetof(CPURISCVState, elp));
> +
> +    return true;
> +}
> +
>  static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
>  {
>      TCGv target_pc =3D dest_gpr(ctx, a->rd);
> @@ -75,6 +118,18 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a=
)
>      gen_set_gpr(ctx, a->rd, succ_pc);
>
>      tcg_gen_mov_tl(cpu_pc, target_pc);
> +    if (ctx->fcfi_enabled) {
> +        /*
> +         * return from functions (i.e. rs1 =3D=3D xRA || rs1 =3D=3D xT0)=
 are not
> +         * tracked. zicfilp introduces sw guarded branch as well. sw gua=
rded
> +         * branch are not tracked. rs1 =3D=3D xT2 is a sw guarded branch=
.
> +         */
> +        if (a->rs1 !=3D xRA && a->rs1 !=3D xT0 && a->rs1 !=3D xT2) {
> +            tcg_gen_st8_tl(tcg_constant_tl(1),
> +                          tcg_env, offsetof(CPURISCVState, elp));
> +        }
> +    }
> +
>      lookup_and_goto_ptr(ctx);
>
>      if (misaligned) {
> --
> 2.44.0
>
>

