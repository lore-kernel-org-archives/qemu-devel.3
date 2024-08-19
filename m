Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C3EC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftOf-0003GZ-Bx; Sun, 18 Aug 2024 23:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftOd-0003F7-VO; Sun, 18 Aug 2024 23:49:31 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftOc-00008B-1y; Sun, 18 Aug 2024 23:49:31 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4f6c136a947so1847157e0c.1; 
 Sun, 18 Aug 2024 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724039368; x=1724644168; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwBtzCi9G0pJhaq7+WsLJtVlmdz5nubla1JKtZ5OLBM=;
 b=L7Z8ipEDcnxwIljD1/4vVEbaNSwC7QBwna509DnsieR43zb6KVQLD6Aqm6XobEE9YI
 xJXzolYgiuuBr8qXEqR1+q7qMTMfNW2rWYsWQehzjgYOgZ1OsnzidywEzad5Xjs6mbSR
 VQ7FiLb4V4j3r0far8OrkFsLsYGTPL9U4qTX2LdM2XUr+nazIyhJnhd04KxVhAV/WhPy
 M/SKs+be670+t8kslgef6O3Y9TQZhpg1lDB9r9wVO8VVAP5UA/JosB4sqhtHSaRrBktO
 qcvacTVuDO9Igx8Zltq0t9mLiAVOrJDB4LuVgv/FWtFRQMktQpVeHPbZX86NLe/FfjsQ
 hfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724039368; x=1724644168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwBtzCi9G0pJhaq7+WsLJtVlmdz5nubla1JKtZ5OLBM=;
 b=bIJONMrffZlzFx30exKbulYhKw15q5o8QxLxWPrsRyO135rEHXvpIi9SbaF7ncPLlK
 0a6ROktUEKJXxwKidWyQ7LGRuzYCzi1n7q4RDvDzECR0ZQGB/9hMqFOztNVZnI6DnxoA
 xTsGlM3ihUhob7uvT3jS0RLrN46vbrlw37zEOMzqcmgYFxUYWdvRIqdRU9qy/mFNjL+s
 J/fRhb3m4fDvTHNr6l5xK6EnV36UCzYWvxsQzmBAeBxJRcu9EI+EhaAMdsvrN8ExM+rW
 R+9Jdwt3ZWYCbAEd/imHnusZo8YmjAOy2/STv1lv/SfkRnQ/W1isZHtL9MjIsAhkr//E
 zc2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ChMqpwJLVytG2+Je/SshBTwpE4buKfEbyAi8pqssotk5az6vEwsqwGMIBj5naPYJjtcDCESWWca6vPUJjjjI+8FwKmI=
X-Gm-Message-State: AOJu0YywFeTjKw5az/WXIPlpO6crin+9NeoRquwkLTi0BF2a0cHZfRHk
 Lspdo/Uv/4EZa2illgjVv6sU22izFnFl4bHopDfalXJsl7g29LCd3bTp+Qtk7NSvjjatHiT4pGz
 xf1emq3E1UYemiViuCN1baMWRqeE=
X-Google-Smtp-Source: AGHT+IEhzovxJlvpOGAYN7bikO+XoB0bnD60NYfraCcreXtVOnmmaewktFjREkWqHvgnxtWg+5SchWJne/y2JYO73qk=
X-Received: by 2002:a05:6122:7cf:b0:4f5:2276:136d with SMTP id
 71dfb90a1353d-4fc6c5e6093mr11319348e0c.1.1724039368283; Sun, 18 Aug 2024
 20:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
 <20240809081227.1588508-5-tommy.wu@sifive.com>
In-Reply-To: <20240809081227.1588508-5-tommy.wu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 13:49:02 +1000
Message-ID: <CAKmqyKPfn8P4Ky977N=DNSDuf2BK5Cv9bX8B=XwSYvptNYMoEw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] target/riscv: Add Smrnmi mnret instruction.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Fri, Aug 9, 2024 at 6:12=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrote=
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
>  target/riscv/op_helper.c                      | 46 +++++++++++++++++++
>  4 files changed, 62 insertions(+)
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
> index 25a5263573..3e26392e65 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -353,6 +353,52 @@ target_ulong helper_mret(CPURISCVState *env)
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
> +    if (!(env->priv >=3D PRV_M)) {

This should just be (env->priv !=3D PRV_M)

> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    /* Get return PC from mnepc CSR. */
> +    target_ulong retpc =3D env->mnepc;
> +    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {

What is the purpose of this check? The low bits should be zero,
unrelated to the compressed instructions

> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    }
> +
> +    /* Get previous privilege level from mnstatus CSR. */
> +    target_ulong prev_priv =3D get_field(env->mnstatus, MNSTATUS_MNPP);
> +
> +    if (riscv_cpu_cfg(env)->pmp &&
> +        !pmp_get_num_rules(env) && (prev_priv !=3D PRV_M)) {

I don't see this mentioned in:

https://github.com/riscv/riscv-isa-manual/blob/a4382e9c8e285360a88d8056c125=
3e1525552393/src/rnmi.adoc

Alistair

> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
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

