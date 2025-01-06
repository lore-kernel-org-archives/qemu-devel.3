Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2638CE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 04:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUeUy-0007yl-Fn; Sun, 05 Jan 2025 23:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUeUw-0007yC-DE; Sun, 05 Jan 2025 23:13:50 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUeUt-0004g7-Jq; Sun, 05 Jan 2025 23:13:49 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5188c6f260cso4588002e0c.1; 
 Sun, 05 Jan 2025 20:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736136826; x=1736741626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4w7KYziDFPcQIZYM2D8sP/CfovUPDh1hoaCnUNYqNH4=;
 b=hO29b4xf6Hk75+uvKbLjtdcaqxHxJMHdBwUrrCRU1j7fNLLKp1cwL5wHY5verMCSMc
 QrfB/EDF7fk5oSH4NpK5pJ9+IfvP2uU96N/ApgmBlv3FZvSM2udHiOL0Au1LW4qiJAoe
 zMnZuPR2nfluP3Nq9M2TyAFcMK32p3athyu4dpdyRr2aM+Fv4xK079EXbf3Hl7tlyPw4
 EtvWLGar9lT9Z+PJoF4e9h2acx8chwUVwNG0VPjhVsqtAvK4GTmf4skVwosWsXvHW6MP
 Z+4JDLt1kABGo3eUxAy5GyTRvoQis6DcRIa2VEvEUhyhQavIKlNxieaf26CvsRaaw3KB
 bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736136826; x=1736741626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4w7KYziDFPcQIZYM2D8sP/CfovUPDh1hoaCnUNYqNH4=;
 b=vsPIq53p29P64yQFS85nsJu2F3iZfrTm6/728zbcfoz7SGSNmLZusHBJPc9326xiHD
 TsVyWX47R1KZ2CJQa5MEbmRvsVJEUoQt/a0FiAp3W73OIkm+5XmzL4Zztd+8Jc64259j
 PcMk/EWaneCwjpufxyiBJHfKeGX0aJRfYeynAW7UWMm5z7d7rXa9An3WhbilNR48qPdk
 vZ/FuUeu2zVaZO1tJoZ3ggQzsNu+ArPicNCWE6R5lBCI5Q3y8YbqzPb0jHDSfMcg6/jQ
 ZVoxjeBGJ30I5yT/M+gX1XzW4qy7LJRn4DNAxfT9L2LqXSVeLRN2xhJmlXjntcz8r+08
 1Lgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV980qDjsZWaqQLFH4hKXrsYpCLCXHtc4B/MgctZJsLDuec6W+oUQjsiaD/4joq7fLsoHp0n8GPWhTp@nongnu.org
X-Gm-Message-State: AOJu0YwPcJnAgDQDuYGVeEZdBF1eM/PXVz69dAXRGsqdDTwFF25oHbab
 oOH57MFptzzkgckmj5XkvQGiPGI1kL49nEed9o0jzzKeamhDt25D/iX8+cKSCbE3iaezY4jZQvR
 xYPExGPqeX/+7bZl2pSGXLtD+qvI=
X-Gm-Gg: ASbGncvQ2GLeg8yh/SqvBN2dQW7ETJZlX3j9sH7D5nGNn+XxIY0hdqqWqLOQXM27fYo
 PoiFpvMO1xoiID474PF0iybcC8nw30tVuSTP60sv9rQxP/v7G+iXX/HH90KugykptfCo=
X-Google-Smtp-Source: AGHT+IEedT6QYUYEQO3a2ARsXA2fJlxbbWk3deZnLV3TTslz3wk8qfw3UceQmJU2YkTPgQryu1Q80r9FGd/MYX1FreY=
X-Received: by 2002:a05:6122:2a44:b0:518:81aa:899b with SMTP id
 71dfb90a1353d-51b75c6fb79mr36919024e0c.6.1736136826010; Sun, 05 Jan 2025
 20:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20241231032654.133039-1-frank.chang@sifive.com>
 <20241231032654.133039-5-frank.chang@sifive.com>
In-Reply-To: <20241231032654.133039-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 14:13:20 +1000
Message-ID: <CAKmqyKNk0mdgu1g+WEYzeY-c8GvZY0jVdbNoUU34PyFEi540nA@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] target/riscv: Add Smrnmi mnret instruction
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Tue, Dec 31, 2024 at 1:28=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Tommy Wu <tommy.wu@sifive.com>
>
> This patch adds a new instruction 'mnret'. 'mnret' is an M-mode-only
> instruction that uses the values in `mnepc` and `mnstatus` to return to t=
he
> program counter, privilege mode, and virtualization mode of the
> interrupted context.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 ++
>  .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++++++
>  target/riscv/op_helper.c                      | 45 ++++++++++++++++---
>  4 files changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 451261ce5a..16ea240d26 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl=
)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(sret, tl, env)
>  DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(mnret, tl, env)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e9139ec1b9..942c434c6e 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 1110011
>  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>  sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>
> +# *** NMI ***
> +mnret       0111000    00010 00000 000 00000 1110011
> +
>  # *** RV32I Base Instruction Set ***
>  lui      ....................       ..... 0110111 @u
>  {
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index ecd3b8b2c9..73f940d406 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -18,6 +18,12 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#define REQUIRE_SMRNMI(ctx) do {     \
> +    if (!ctx->cfg_ptr->ext_smrnmi) { \
> +        return false;                \
> +    }                                \
> +} while (0)
> +
>  static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
>  {
>      /* always generates U-level ECALL, fixed in do_interrupt handler */
> @@ -106,6 +112,20 @@ static bool trans_mret(DisasContext *ctx, arg_mret *=
a)
>  #endif
>  }
>
> +static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMRNMI(ctx);
> +    decode_save_opc(ctx, 0);
> +    gen_helper_mnret(cpu_pc, tcg_env);
> +    tcg_gen_exit_tb(NULL, 0); /* no chaining */
> +    ctx->base.is_jmp =3D DISAS_NORETURN;
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>  static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>  {
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..63ec53e992 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -321,24 +321,30 @@ target_ulong helper_sret(CPURISCVState *env)
>      return retpc;
>  }
>
> -target_ulong helper_mret(CPURISCVState *env)
> +static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc=
,
> +                                  target_ulong prev_priv)
>  {
>      if (!(env->priv >=3D PRV_M)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    target_ulong retpc =3D env->mepc;
>      if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> -    uint64_t mstatus =3D env->mstatus;
> -    target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
> -
>      if (riscv_cpu_cfg(env)->pmp &&
>          !pmp_get_num_rules(env) && (prev_priv !=3D PRV_M)) {
>          riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC()=
);
>      }
> +}
> +
> +target_ulong helper_mret(CPURISCVState *env)
> +{
> +    target_ulong retpc =3D env->mepc;
> +    uint64_t mstatus =3D env->mstatus;
> +    target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
> +
> +    check_ret_from_m_mode(env, retpc, prev_priv);
>
>      target_ulong prev_virt =3D get_field(env->mstatus, MSTATUS_MPV) &&
>                               (prev_priv !=3D PRV_M);
> @@ -370,6 +376,35 @@ target_ulong helper_mret(CPURISCVState *env)
>      return retpc;
>  }
>
> +target_ulong helper_mnret(CPURISCVState *env)
> +{
> +    target_ulong retpc =3D env->mnepc;
> +    target_ulong prev_priv =3D get_field(env->mnstatus, MNSTATUS_MNPP);
> +    target_ulong prev_virt;
> +
> +    check_ret_from_m_mode(env, retpc, prev_priv);
> +
> +    prev_virt =3D get_field(env->mnstatus, MNSTATUS_MNPV) &&
> +                (prev_priv !=3D PRV_M);
> +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, true);
> +
> +    /*
> +     * If MNRET changes the privilege mode to a mode
> +     * less privileged than M, it also sets mstatus.MPRV to 0.
> +     */
> +    if (prev_priv < PRV_M) {
> +        env->mstatus =3D set_field(env->mstatus, MSTATUS_MPRV, false);
> +    }
> +
> +    if (riscv_has_ext(env, RVH) && prev_virt) {
> +        riscv_cpu_swap_hypervisor_regs(env);
> +    }
> +
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
> +
> +    return retpc;
> +}
> +
>  void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> --
> 2.34.1
>
>

