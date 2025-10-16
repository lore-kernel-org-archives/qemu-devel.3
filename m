Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135ACCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Fh0-0005xI-0U; Thu, 16 Oct 2025 00:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fgy-0005x9-TK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:34:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fgv-0005Hq-Oh
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:34:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-634a3327ff7so432827a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760589256; x=1761194056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRLvwgBtqSA0KhcthC71cJJNVIxYb8VzcMa8+i7FnRo=;
 b=ghPFwyToAtRHjMU7Yf8D+YFkfc/k0UU+Wgi5HR3dtPB/o6uhtUwowwZ6x/Bg6nOqtP
 hThlXrcT1gY21DfkJiL4LhAigZIIK1+AZRMx3bsdjpdy6BTiIlj9hTHUShLwx2LClMyS
 JCmBux6FxxtCKekMo9dzJB3mQnFTaVggoQBrlRW9GFVzqYRdJC0rphOUwMOilkWKHwd0
 IO+STQcFsgxfc2k33RbYVQ/1XUrp0TMqspWq+Z/l6zw7rANFBhNvxxcOXW2vxcvjGmpE
 ueP8xPiKOBBre4MjsjUIvye4u+cQDcXNNVrJwNbKKKP2mRHUIXHHWDk86Rv3cd9Ztih/
 ln0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760589256; x=1761194056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRLvwgBtqSA0KhcthC71cJJNVIxYb8VzcMa8+i7FnRo=;
 b=PcUSwgHsjtJupJEwIF7nt6QEuw3AzcOk702gntMTw65ixwJqXXyFHe3z2ccNOO0XzR
 QxZ3KWZBsKNW90+PBD8DmumNYUPGQ5OL5H/HqVDNqD5vaiUG/+JTn1aPI49pmA2oO06Z
 VsbbeMpuh6YSHWHWol67iouNUbYoqzy754SwsA9VwnE+f1ZorzT5SeGX9bvZQSlDzWHU
 1nEFcqPlglZ744qaLC3rL5wCLO/XOMdwJyIWRJhaAddXgm95tq3Na+sCNeIj1aWj0HL+
 yizs66Q57xTlImetM9cN4YiR/eKoQaUrIwfJMfPvOHif2DVl7L0ScaJ/HiSQmkzwKaks
 Et5g==
X-Gm-Message-State: AOJu0YyHF+CD7M4hYBdw/HZBLNBG0gGzLtgLzI+lqdifOmCIYhUDopke
 CNaixsNvRhxg6xXxT5nHGMUkyZt0E0ZOvpXLwVdpEIUMpGAC8hVvj3fguoN6sfAuI3/KjGp6zO1
 XP6wVFt0mwOuuAH5x1BWCPzgUIoUCZ3I=
X-Gm-Gg: ASbGnctL7Ddub5FgC31dJaYDhGi4MqqYGqH1S4R6XyE2AT0Hj7wSBKdYVvr0d0VYNuk
 tYE6bHGtGRN1a29yJ1r56/mmy2MAija8CAd3MyfkUKsSGQ+MpQrGxa17ZBNSdLVz3yqvMgArESz
 WdJHoS/0K61BKHz8O/ana2oWPBcTgIUMtdQcMleIDWKvMc7fR9sXN0Jiys3VaCCWzN4d0VNRlNM
 IZstxS86ypZXHRmkRkjwWM3I5osLQoQnGuWK8RNMMI20RvlWCm82h+hR3hbeyXF8FrRM+ToroF7
 iTgxyftqTKU/IgI=
X-Google-Smtp-Source: AGHT+IFKFqT0KyAnc9KmMWohFuGS+uR23Z2q0z7kRVStbqCIDRqKQdllExuMZDGmXPXvw0XPihSd16pAIHlUyfkW9qU=
X-Received: by 2002:a05:6402:3550:b0:639:fd12:65a2 with SMTP id
 4fb4d7f45d1cf-639fd1267d4mr22853916a12.15.1760589255632; Wed, 15 Oct 2025
 21:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-13-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-13-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:33:49 +1000
X-Gm-Features: AS18NWAldUI_vHkNmzeL3XAqiLhI4YnvtjyonIZu_9_RqVfjjuvE-1NcyXhxODQ
Message-ID: <CAKmqyKM=xfFb+xaQ3hS=Cdyi1XF__mNGgucBf3HMEwoL5ecvCw@mail.gmail.com>
Subject: Re: [PATCH v3 12/34] target/riscv: Fix size of pc, load_[val|res]
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

On Wed, Oct 15, 2025 at 6:35=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix to 64 bits in size and as these are mapped to TCG globals, be
> careful with host endianness when allocating globals.  Casts are
> added to logging expressions to retain the correct size for
> TARGET_RISCV32.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  6 +++---
>  target/riscv/cpu.c        |  2 +-
>  target/riscv/cpu_helper.c |  6 +++---
>  target/riscv/machine.c    |  6 +++---
>  target/riscv/translate.c  | 12 +++++++-----
>  5 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ff1562b7ff..a25c75ca64 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,9 +224,9 @@ struct CPUArchState {
>      uint8_t vxsat;
>      bool vill;
>
> -    target_ulong pc;
> -    target_ulong load_res;
> -    target_ulong load_val;
> +    uint64_t pc;
> +    uint64_t load_res;
> +    uint64_t load_val;
>
>      /* Floating-Point state */
>      uint64_t fpr[32]; /* assume both F and D extensions */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b7690ac00f..c86a64b727 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -528,7 +528,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
>          qemu_fprintf(f, " %s %d\n", "V      =3D  ", env->virt_enabled);
>      }
>  #endif
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
> +    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      {
>          static const int dump_csrs[] =3D {
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9d0683f200..5a20596f1f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -2279,9 +2279,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>      qemu_log_mask(CPU_LOG_INT,
>                    "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", =
"
> -                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=
=3D%s\n",
> -                  __func__, env->mhartid, async, cause, env->pc, tval,
> -                  riscv_cpu_get_trap_name(cause, async));
> +                  "epc:0x%"PRIx64", tval:0x"TARGET_FMT_lx", desc=3D%s\n"=
,
> +                  __func__, env->mhartid, async, cause, env->pc,
> +                  tval, riscv_cpu_get_trap_name(cause, async));
>
>      mode =3D env->priv <=3D PRV_S && cause < 64 &&
>          (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : =
PRV_M;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 440b09fc32..66ed3f6504 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -433,9 +433,9 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
>          VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
>          VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
> -        VMSTATE_UINTTL(env.pc, RISCVCPU),
> -        VMSTATE_UINTTL(env.load_res, RISCVCPU),
> -        VMSTATE_UINTTL(env.load_val, RISCVCPU),
> +        VMSTATE_UINT64(env.pc, RISCVCPU),
> +        VMSTATE_UINT64(env.load_res, RISCVCPU),
> +        VMSTATE_UINT64(env.load_val, RISCVCPU),
>          VMSTATE_UINTTL(env.frm, RISCVCPU),
>          VMSTATE_UINTTL(env.badaddr, RISCVCPU),
>          VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 98fd4b9051..6b84d0c384 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1444,6 +1444,10 @@ void riscv_translate_init(void)
>      /* 32 bits in size, no offset needed */
>      size_t vl_offset =3D offsetof(CPURISCVState, vl);
>      size_t vstart_offset =3D offsetof(CPURISCVState, vstart);
> +    /* 64 bits in size mapped to TCGv, needs offset */
> +    size_t pc_offset     =3D offsetof(CPURISCVState, pc) + field_offset;
> +    size_t res_offset    =3D offsetof(CPURISCVState, load_res) + field_o=
ffset;
> +    size_t val_offset    =3D offsetof(CPURISCVState, load_val) + field_o=
ffset;
>
>      for (i =3D 1; i < 32; i++) {
>          cpu_gpr[i] =3D tcg_global_mem_new(tcg_env,
> @@ -1459,11 +1463,9 @@ void riscv_translate_init(void)
>              offsetof(CPURISCVState, fpr[i]), riscv_fpr_regnames[i]);
>      }
>
> -    cpu_pc =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), =
"pc");
> +    cpu_pc =3D tcg_global_mem_new(tcg_env, pc_offset, "pc");
>      cpu_vl =3D tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
>      cpu_vstart =3D tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstar=
t");
> -    load_res =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_res),
> -                             "load_res");
> -    load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_val),
> -                             "load_val");
> +    load_res =3D tcg_global_mem_new(tcg_env, res_offset, "load_res");
> +    load_val =3D tcg_global_mem_new(tcg_env, val_offset, "load_val");
>  }
> --
> 2.51.0
>
>

