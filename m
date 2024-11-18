Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F67D6DDC4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 06:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCvY0-00011W-Oy; Mon, 18 Nov 2024 01:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCvXm-000100-OH; Mon, 18 Nov 2024 01:47:31 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCvXk-0006xT-F8; Mon, 18 Nov 2024 01:47:30 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50d4a333a87so609792e0c.1; 
 Sun, 17 Nov 2024 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731912447; x=1732517247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eQZ02yb1MNIjRKeXvwwGUUf+2OZnH/VXEtghB0aobo=;
 b=HTvVU7uXXseCwTkxjgLQoVFJ8DmZg/KlKcl8l+gKt6YTxw+MPpHbn7qrJBuSRgPxqO
 tkBwulGk7v22nnqGa05Y1mLH5SHB9B6mMnLOZ5TMEoU5Dg2lvEY4GFmUKh93ib4RNJci
 S0YZMmnAzwT/SrviebXm/Bc54gj4YWXG+92AJlRq6GvgVT//D+2o3dvzYVYuTKCLFgX+
 VbTkF9Kis/+InB/PcMGAXJfSwoZFmkDYRRbboPVNtUc6VdOOhjJXiN7lJtbZz68aq+SA
 CvCUxLIA9atlsib+jtz17geC9yhkzLUBUKp+HdqaqvjiLNaECNVLjLr3OIECCQALzzMG
 34JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731912447; x=1732517247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eQZ02yb1MNIjRKeXvwwGUUf+2OZnH/VXEtghB0aobo=;
 b=fE3C7SyySh5X4RoVGe8u4mQsZqUWsqaQXbVVvSCHIuB+jYLGctnYec68UbEDYo6H60
 OUQptcUtwNSkKS/BD0nSlnwUVvB4DFFBIad884ai9nHv1zWxHRO1IUrUJXaj52yVI/WA
 z/i/kiE7E58dWCVvzl4wZ+Xaje8KxajklVqtNTFWDu742nTqXSkN/S6ODak73BpNhjdg
 0WS5mpdN2KroTCwiLjB5kxBJghVBVqgWq76D6E7ahJ0V1sNXZgS6V08hc6LqFXhJZxZD
 Pmro9sHwl+R829erS0KiBhaozKHvFVMB42VKywxux39mLOGtXBNNPAZl8d7YlYD5v4WN
 2g5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY5dugpxEU4i/P0XmDr186WHljNBMuVM5A8QyFDquUkqtR51wz2HKRfjzzZm35n5NaOE8rQtwnJA5o@nongnu.org
X-Gm-Message-State: AOJu0YycBrXlP+a05H8wt1imYmTE52XLnDIhzOPBJNu4uFCa1EHrKLjv
 +Zhfdu+t2nn2pcNOLtLjqI2quaU7yOR0fLGuh9Go4R4GwV7No1IOQr+NeEbHdfPMb3EG8rebuky
 lJjTVLR9R9LFtAQwXng4gXD5Xfvg=
X-Google-Smtp-Source: AGHT+IG1Tzl88oM0zoNoMrvNobrtPWgcpymzYscwAlQNwWixW6nMeZ2D5G21DTlGEzUB5roVXuoQDRH3dLCm6s26k/c=
X-Received: by 2002:a05:6122:201b:b0:510:185:5d89 with SMTP id
 71dfb90a1353d-514781df9b6mr9241410e0c.12.1731912446956; Sun, 17 Nov 2024
 22:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20241021030358.12454-1-frank.chang@sifive.com>
 <20241021030358.12454-5-frank.chang@sifive.com>
In-Reply-To: <20241021030358.12454-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 16:47:01 +1000
Message-ID: <CAKmqyKMDhmPejWfXMrnGDymxbL6bjeZnFOX=8RGOM_EX070SFA@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] target/riscv: Add Smrnmi mnret instruction
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Tommy Wu <tommy.wu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Mon, Oct 21, 2024 at 1:05=E2=80=AFPM <frank.chang@sifive.com> wrote:
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
> index c45b8fa1d8..d320631e8c 100644
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
>  auipc    ....................       ..... 0010111 @u
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index bc5263a4e0..b51f30846d 100644
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
> +    decode_save_opc(ctx);
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
> index 25a5263573..180886f32a 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -312,24 +312,30 @@ target_ulong helper_sret(CPURISCVState *env)
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
> @@ -353,6 +359,35 @@ target_ulong helper_mret(CPURISCVState *env)
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

There should be a Zicfilp check in here as well as that sets ELP.

Alistair

