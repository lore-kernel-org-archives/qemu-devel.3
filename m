Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CEFCE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 00:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smNCf-0004Ns-V1; Thu, 05 Sep 2024 20:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNCe-0004MF-8R; Thu, 05 Sep 2024 20:51:56 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNCc-0004hL-8A; Thu, 05 Sep 2024 20:51:55 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-49bd3bf3b4cso470084137.3; 
 Thu, 05 Sep 2024 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725583912; x=1726188712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++Ca1YHh4cd6vk7btEkPb+KRfVTTB6WDHiijmCgWIQI=;
 b=lKkn+Dep6kDrNMz19vrQwcL/oI3p6mqWZm9xrgAkCQMANR8xdJeZxkAGGWW4mTSM5y
 qvUiLkwp8CX4lf40Re5r4RG1Hw1R2QMQ3T/2URSwrwdtBKkxz8gMdh2FVa6GPeIFXz53
 pn1wMFGPW7agY4K8vrlyecNf5nnXfy1DPAe5iZopt8oE1KmpkaDAu4YULAtzLSj03mv4
 YQYpa0qwjClPJX+zC4s6x6W/jcQMAtxViaN0aU9TosALtCToD75FFQYLSf5ZuDd/oT/R
 QSfpOSmab2xnhRsFCdeSwoPt1IgvM2uo01oMEKUUjC5cn0HLc5yOaqhgwdpNqCZFev+n
 /jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725583912; x=1726188712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++Ca1YHh4cd6vk7btEkPb+KRfVTTB6WDHiijmCgWIQI=;
 b=ebfFcGHkkgRgBq59sXd30KF6DNG10XG5GxF3UEqF6C2RxaxRafj682/rxSRcpA8yVc
 gFaMjbMC3T8TE4JbZZM133l0bHF8kBK887lZvtg5I9DLSrBVIGLug5o+bKupFdBt/aGi
 YSyDpdLsQP05LrLQ8KPbZsvOT+wneuX9fjAJpoU3SORyGbJz1Ib0LzB6DRNB4IqLVGzV
 pPBIAnQ5r/xbzZD2dSoV9n3Oj+vjAnahtAqpui0kI1e49ZE32KDvsFUFsZ3DQz+kRi6C
 4rJzOBUrxAHBHtJCDyACJ+lp4A6mlA43qb4trialUvCb2K+3A/9+IAexnuFDpnagBuUU
 CUIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEz8DYDugTOrlYK/sencTUG4fjgX/86u5610rUQ3BMtU86U2WmrvIy1OS6AE/QHbsVWzsvX3Yr6LFL@nongnu.org
X-Gm-Message-State: AOJu0YxyR+kb77UEwRzeiTMJVO1Oes/uXgSCp891TQAS91htsbkOe7Ft
 mDWvQlaq6RH0TGcc13CeWw/toiIspj+bLcvsW2E1VjFdj8g8OIa0Yxznhio5WGMAG5ApdrKLWNp
 H03XiaErErsNq7qTS19eoK5nRXeY=
X-Google-Smtp-Source: AGHT+IHrmPuVU/gX2DCXE5sUGueGP/EtwiLGC2C2g8gz3cj9UqKe6JnUrwALga4JtOUABpAQzCaFLPrSnQyhWE40t/E=
X-Received: by 2002:a05:6102:a4c:b0:48f:b1d3:4890 with SMTP id
 ada2fe7eead31-49a5afad244mr24288665137.31.1725583912407; Thu, 05 Sep 2024
 17:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
 <20240902071358.1061693-5-tommy.wu@sifive.com>
In-Reply-To: <20240902071358.1061693-5-tommy.wu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 10:51:26 +1000
Message-ID: <CAKmqyKO9k93OLX_pxtkHcUAvC=NUNxtp6mDCb2J2ZWHMnfbNYQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] target/riscv: Add Smrnmi mnret instruction.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Mon, Sep 2, 2024 at 5:14=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrote=
:
>
> This patch adds a new instruction `mnret`. `mnret` is an M-mode-only
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
>  .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
>  target/riscv/op_helper.c                      | 49 +++++++++++++++++--
>  4 files changed, 60 insertions(+), 5 deletions(-)
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
> index bc5263a4e0..06bc20dda4 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -106,6 +106,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *=
a)
>  #endif
>  }
>
> +static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
> +{
> +#ifndef CONFIG_USER_ONLY

You will want to include a REQUIRE_SMRNMI(ctx) function here. Have a
look at REQUIRE_A_OR_ZAAMO(ctx) for an example of what it should look
like.

> +    gen_helper_mnret(cpu_pc, tcg_env);
> +    tcg_gen_exit_tb(NULL, 0); /* no chaining */
> +    ctx->base.is_jmp =3D DISAS_NORETURN;

This will need to be rebased on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

We will want to call decode_save_opc() and the other functions here

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
> index 25a5263573..6895c7596b 100644
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
> @@ -353,6 +359,39 @@ target_ulong helper_mret(CPURISCVState *env)
>      return retpc;
>  }
>
> +target_ulong helper_mnret(CPURISCVState *env)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smrnmi) {
> +        /* RNMI feature is not presented. */
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    target_ulong retpc =3D env->mnepc;
> +    target_ulong prev_priv =3D get_field(env->mnstatus, MNSTATUS_MNPP);

Variables should be declared before any other code in a function.

With a REQUIRE_SMRNMI() you can drop the check above anyway.

Alistair

> +
> +    check_ret_from_m_mode(env, retpc, prev_priv);
> +
> +    target_ulong prev_virt =3D get_field(env->mnstatus, MNSTATUS_MNPV) &=
&
> +                             (prev_priv !=3D PRV_M);
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
> 2.39.3
>

