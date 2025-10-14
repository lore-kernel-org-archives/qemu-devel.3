Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B2ECCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8X9K-00088m-8w; Tue, 14 Oct 2025 01:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8X94-00087s-Vl
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:00:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8X8z-0003Ci-GR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:00:21 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso3160888a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418014; x=1761022814; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5MdkBbPtPwl0naz48mJXjzWlXXq3zhyWvXQQX/xLE8=;
 b=nlWtdiNqM8jJhRA12NBaMqtct0i3JP7veRMeBbjf3cPqNX7psVsRyCKe8sd/CqcmOz
 qtVh2vxaz2vAyZ4qmLVD3aK4LbgcKHXA92vmRB7E+dUAopLXwoiYg4/svnT+kgNsbZVa
 GutYMv5m+AF834xJiq0HaaVftRUGp5r9/IRhbkmBe3iGJ75dpypSw3N8k2ZJVSbApOB5
 mV8ASL+dXtd6qPkLmNuad/Q/D6Bp4pkCImhhMV4zhPU2I+rY8gGEU16orOXc6+Pz2f6l
 RPNa4yZHYZXO9eOg+u+W2Ycf+sJbB15zH7fwnXo+i907/NkIo0omMBoGOzoK+OwIR189
 06zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418014; x=1761022814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5MdkBbPtPwl0naz48mJXjzWlXXq3zhyWvXQQX/xLE8=;
 b=Efr5hlhSZzn7ugdyaQ2Sm76qpoeztyI9mEw1u9BKhEblpMR+RgKKtmEOu41TdeJWx6
 3k+frY5O/uD2fv7HWKaI5uRL0v9AKoeaC03G8z0nRsBhXxG4sIWzwnRpO9LsPo1iHT8t
 +wDKN4hXR1JmhyUUvwjH2ONsMZXFMo4x8BX3QS1U+SBRKRH60mhmoWU6SjNezUKS/Ir6
 ukX6BlS5zh00yyuEp7SbB2QBQ/hq/tYynm8YjFH+sIA18+qwXh4/uxtBmVF2Z173kDjY
 iNv6iOrlIaOgiys1c86ZvwrLlnc14DbnImhHA/4y6iNQjql1npeXYvz0gHIhHc6nRtjJ
 w2/Q==
X-Gm-Message-State: AOJu0YwWWO3NrNzKOuNlmB9jQrbY27Kd6txrrF1vsNjVfRMakFUQe6hG
 iAp8YQTdlj1Y2o8dS2uLA5zaFXsUW1VHmft13BwohyFA2RcC8M9mvinkPwCLp0vW50nG8IMRNEb
 7sAJ2Wfx/VUU9QiiWn5B07+hkQ1lumy4=
X-Gm-Gg: ASbGncty/SHfYnEWghFva4LNOlZpBP6tH63t1gI2VSnJOH8qNmjT6wW6gow8MilTICY
 EiBnFihIWvAdEwXFlCsx6pTvqYXwYwHh7vKslETqG0qRNVoDec2I1oHwtfBI40kEjY6sjNIC6BC
 uOlcDHfww8fAKQmdy+01E8jKofv/Rj2aPGVmIcoUf9506DyqkfAlsIFVwWIj2ZO+2AH1GWR+DAb
 0dTkynpMtJDbIAJpDj4Hn+GLA9+qXAqK7czb/0vViH8vV6gLmHrb4yh
X-Google-Smtp-Source: AGHT+IHu9pMnvTrBOYEmNzFeBGSvXFqcUM8oWI44iot5rbMOldBdYeMOWsoT9IAAEg6ccHkRcdcDt9lKs3ZnCLAeNCg=
X-Received: by 2002:a05:6402:278a:b0:639:dd8b:d327 with SMTP id
 4fb4d7f45d1cf-639dd8bd6cemr18983439a12.5.1760418013355; Mon, 13 Oct 2025
 22:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-3-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 14:59:47 +1000
X-Gm-Features: AS18NWDU7gI1lifRCZY0VmvthBDlY9SBl2boejlEDhXcdpwqY6AUWQGkqpAEZR0
Message-ID: <CAKmqyKN-NSi7ThXZiwGbGohCgHiUwnJtq+efD=DZh9run4AQrA@mail.gmail.com>
Subject: Re: [PATCH 02/13] target/riscv: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Sat, Oct 11, 2025 at 1:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Extract the implicit MO_TE definition in order to replace
> it in the next commit.
>
> Mechanical change using:
>
>   $ for n in UW UL UQ UO SW SL SQ; do \
>       sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>            $(git grep -l MO_TE$n target/hexagon); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c                      | 16 ++--
>  target/riscv/insn_trans/trans_rva.c.inc       | 44 ++++-----
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       | 22 ++---
>  target/riscv/insn_trans/trans_rvzabha.c.inc   | 20 ++---
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  8 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc     | 10 +--
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>  target/riscv/insn_trans/trans_xthead.c.inc    | 90 +++++++++----------
>  11 files changed, 113 insertions(+), 113 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 8382aa94cb2..c486f771d35 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -633,7 +633,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, ta=
rget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
>
>      return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -642,7 +642,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, ta=
rget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
>
>      return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -651,7 +651,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, tar=
get_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UQ, mmu_idx);
>
>      return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -669,7 +669,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
>
>      cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -678,7 +678,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
>
>      cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -687,7 +687,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUQ, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UQ, mmu_idx);
>
>      cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -703,7 +703,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, t=
arget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, true, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
>
>      return cpu_ldw_code_mmu(env, addr, oi, GETPC());
>  }
> @@ -712,7 +712,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, t=
arget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, true, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TEUL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
>
>      return cpu_ldl_code_mmu(env, addr, oi, ra);
>  }
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_=
trans/trans_rva.c.inc
> index 9cf3ae8019b..10e4c55efda 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -99,142 +99,142 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a=
, MemOp mop)
>  static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
> +    return gen_lr(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
>  }
>
>  static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>  {
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
> +    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
>  }
>
>  static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
>  }
>
>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
>  }
>
>  static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
>  }
>
>  static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
>  }
>
>  static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
>  }
>
>  static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL)=
;
>  }
>
>  static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL)=
;
>  }
>
>  static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL)=
;
>  }
>
>  static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESL);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL)=
;
>  }
>
>  static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
> +    return gen_lr(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
>  }
>
>  static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZALRSC(ctx);
> -    return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
> +    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
>  }
>
>  static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
>  }
>
>  static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
>  }
>
>  static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
>  }
>
>  static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
>  }
>
>  static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
>  }
>
>  static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ)=
;
>  }
>
>  static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ)=
;
>  }
>
>  static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ)=
;
>  }
>
>  static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TEUQ);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ)=
;
>  }
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_=
trans/trans_rvd.c.inc
> index 30883ea37c8..33858206788 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -42,7 +42,7 @@
>  static bool trans_fld(DisasContext *ctx, arg_fld *a)
>  {
>      TCGv addr;
> -    MemOp memop =3D MO_TEUQ;
> +    MemOp memop =3D MO_TE | MO_UQ;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> @@ -72,7 +72,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>  static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>  {
>      TCGv addr;
> -    MemOp memop =3D MO_TEUQ;
> +    MemOp memop =3D MO_TE | MO_UQ;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_=
trans/trans_rvf.c.inc
> index ed73afe0894..150e2b9a7d4 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -43,7 +43,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  {
>      TCGv_i64 dest;
>      TCGv addr;
> -    MemOp memop =3D MO_TEUL;
> +    MemOp memop =3D MO_TE | MO_UL;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> @@ -65,7 +65,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>  {
>      TCGv addr;
> -    MemOp memop =3D MO_TEUL;
> +    MemOp memop =3D MO_TE | MO_UL;
>
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index df0b555176a..8194ea5073e 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -428,24 +428,24 @@ static bool trans_lb(DisasContext *ctx, arg_lb *a)
>
>  static bool trans_lh(DisasContext *ctx, arg_lh *a)
>  {
> -    return gen_load(ctx, a, MO_TESW);
> +    return gen_load(ctx, a, MO_TE | MO_SW);
>  }
>
>  static bool trans_lw(DisasContext *ctx, arg_lw *a)
>  {
> -    return gen_load(ctx, a, MO_TESL);
> +    return gen_load(ctx, a, MO_TE | MO_SL);
>  }
>
>  static bool trans_ld(DisasContext *ctx, arg_ld *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> -    return gen_load(ctx, a, MO_TESQ);
> +    return gen_load(ctx, a, MO_TE | MO_SQ);
>  }
>
>  static bool trans_lq(DisasContext *ctx, arg_lq *a)
>  {
>      REQUIRE_128BIT(ctx);
> -    return gen_load(ctx, a, MO_TEUO);
> +    return gen_load(ctx, a, MO_TE | MO_UO);
>  }
>
>  static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
> @@ -455,19 +455,19 @@ static bool trans_lbu(DisasContext *ctx, arg_lbu *a=
)
>
>  static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
>  {
> -    return gen_load(ctx, a, MO_TEUW);
> +    return gen_load(ctx, a, MO_TE | MO_UW);
>  }
>
>  static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> -    return gen_load(ctx, a, MO_TEUL);
> +    return gen_load(ctx, a, MO_TE | MO_UL);
>  }
>
>  static bool trans_ldu(DisasContext *ctx, arg_ldu *a)
>  {
>      REQUIRE_128BIT(ctx);
> -    return gen_load(ctx, a, MO_TEUQ);
> +    return gen_load(ctx, a, MO_TE | MO_UQ);
>  }
>
>  static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
> @@ -525,24 +525,24 @@ static bool trans_sb(DisasContext *ctx, arg_sb *a)
>
>  static bool trans_sh(DisasContext *ctx, arg_sh *a)
>  {
> -    return gen_store(ctx, a, MO_TESW);
> +    return gen_store(ctx, a, MO_TE | MO_SW);
>  }
>
>  static bool trans_sw(DisasContext *ctx, arg_sw *a)
>  {
> -    return gen_store(ctx, a, MO_TESL);
> +    return gen_store(ctx, a, MO_TE | MO_SL);
>  }
>
>  static bool trans_sd(DisasContext *ctx, arg_sd *a)
>  {
>      REQUIRE_64_OR_128BIT(ctx);
> -    return gen_store(ctx, a, MO_TEUQ);
> +    return gen_store(ctx, a, MO_TE | MO_UQ);
>  }
>
>  static bool trans_sq(DisasContext *ctx, arg_sq *a)
>  {
>      REQUIRE_128BIT(ctx);
> -    return gen_store(ctx, a, MO_TEUO);
> +    return gen_store(ctx, a, MO_TE | MO_UO);
>  }
>
>  static bool trans_addd(DisasContext *ctx, arg_addd *a)
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/i=
nsn_trans/trans_rvzabha.c.inc
> index ce8edcba62a..25db42d24cd 100644
> --- a/target/riscv/insn_trans/trans_rvzabha.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
> @@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_am=
omaxu_b *a)
>  static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
>  }
>
>  static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
>  }
>
>  static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
>  }
>
>  static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
>  }
>
>  static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
>  }
>
>  static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW)=
;
>  }
>
>  static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW)=
;
>  }
>
>  static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW)=
;
>  }
>
>  static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
>  {
>      REQUIRE_ZABHA(ctx);
> -    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW)=
;
>  }
>
>  static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
> @@ -141,5 +141,5 @@ static bool trans_amocas_h(DisasContext *ctx, arg_amo=
cas_h *a)
>  {
>      REQUIRE_ZACAS(ctx);
>      REQUIRE_ZABHA(ctx);
> -    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESW);
> +    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SW);
>  }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/i=
nsn_trans/trans_rvzacas.c.inc
> index 15e688a0331..5e7c7c92b72 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -25,7 +25,7 @@
>  static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
>  {
>      REQUIRE_ZACAS(ctx);
> -    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TESL);
> +    return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_SL);
>  }
>
>  static TCGv_i64 get_gpr_pair(DisasContext *ctx, int reg_num)
> @@ -88,10 +88,10 @@ static bool trans_amocas_d(DisasContext *ctx, arg_amo=
cas_d *a)
>      REQUIRE_ZACAS(ctx);
>      switch (get_ol(ctx)) {
>      case MXL_RV32:
> -        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TEUQ);
> +        return gen_cmpxchg64(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
>      case MXL_RV64:
>      case MXL_RV128:
> -        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TEUQ);
> +        return gen_cmpxchg(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
>      default:
>          g_assert_not_reached();
>      }
> @@ -123,7 +123,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amo=
cas_q *a)
>      tcg_gen_concat_i64_i128(dest, destl, desth);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>      tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
> -                                (MO_ALIGN | MO_TEUO));
> +                                (MO_ALIGN | MO_TE | MO_UO));
>
>      tcg_gen_extr_i128_i64(destl, desth, dest);
>
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/ins=
n_trans/trans_rvzce.c.inc
> index dd15af0f54b..d1301794324 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu =
*a)
>  static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
>  {
>      REQUIRE_ZCB(ctx);
> -    return gen_load(ctx, a, MO_TEUW);
> +    return gen_load(ctx, a, MO_TE | MO_UW);
>  }
>
>  static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
>  {
>      REQUIRE_ZCB(ctx);
> -    return gen_load(ctx, a, MO_TESW);
> +    return gen_load(ctx, a, MO_TE | MO_SW);
>  }
>
>  static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
> @@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a=
)
>  static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
>  {
>      REQUIRE_ZCB(ctx);
> -    return gen_store(ctx, a, MO_TEUW);
> +    return gen_store(ctx, a, MO_TE | MO_UW);
>  }
>
>  #define X_S0    8
> @@ -175,7 +175,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, b=
ool ret, bool ret_val)
>          return false;
>      }
>
> -    MemOp memop =3D get_ol(ctx) =3D=3D MXL_RV32 ? MO_TEUL : MO_TEUQ;
> +    MemOp memop =3D get_ol(ctx) =3D=3D MXL_RV32 ? MO_TE | MO_UL : MO_TE =
| MO_UQ;
>      int reg_size =3D memop_size(memop);
>      target_ulong stack_adj =3D ROUND_UP(ctpop32(reg_bitmap) * reg_size, =
16) +
>                               a->spimm;
> @@ -228,7 +228,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_p=
ush *a)
>          return false;
>      }
>
> -    MemOp memop =3D get_ol(ctx) =3D=3D MXL_RV32 ? MO_TEUL : MO_TEUQ;
> +    MemOp memop =3D get_ol(ctx) =3D=3D MXL_RV32 ? MO_TE | MO_UL : MO_TE =
| MO_UQ;
>      int reg_size =3D memop_size(memop);
>      target_ulong stack_adj =3D ROUND_UP(ctpop32(reg_bitmap) * reg_size, =
16) +
>                               a->spimm;
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/ins=
n_trans/trans_rvzfh.c.inc
> index bece48e6009..eec478afcb0 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -57,7 +57,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>      }
>
>      dest =3D cpu_fpr[a->rd];
> -    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TEUW);
> +    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TE | MO_UW);
>      gen_nanbox_h(dest, dest);
>
>      mark_fs_dirty(ctx);
> @@ -79,7 +79,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>          t0 =3D temp;
>      }
>
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUW);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TE | MO_UW=
);
>
>      return true;
>  }
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index f4a1c12ca0b..c5555966175 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_=
amoswap_w *a)
>      src1 =3D get_address(ctx, a->rs1, 0);
>
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> -                           (MO_ALIGN | MO_TESL));
> +                           (MO_ALIGN | MO_TE | MO_SL));
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
>  }
> @@ -134,7 +134,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_=
amoswap_w *a)
>      src1 =3D get_address(ctx, a->rs1, 0);
>
>      tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> -                           (MO_ALIGN | MO_TESQ));
> +                           (MO_ALIGN | MO_TE | MO_SQ));
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
>  }
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index 22488412d4d..754cb80e221 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -379,7 +379,7 @@ static bool trans_th_flrd(DisasContext *ctx, arg_th_m=
emidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> -    return gen_fload_idx(ctx, a, MO_TEUQ, false);
> +    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, false);
>  }
>
>  static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
> @@ -387,7 +387,7 @@ static bool trans_th_flrw(DisasContext *ctx, arg_th_m=
emidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> -    return gen_fload_idx(ctx, a, MO_TEUL, false);
> +    return gen_fload_idx(ctx, a, MO_TE | MO_UL, false);
>  }
>
>  static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
> @@ -395,7 +395,7 @@ static bool trans_th_flurd(DisasContext *ctx, arg_th_=
memidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> -    return gen_fload_idx(ctx, a, MO_TEUQ, true);
> +    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, true);
>  }
>
>  static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
> @@ -403,7 +403,7 @@ static bool trans_th_flurw(DisasContext *ctx, arg_th_=
memidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> -    return gen_fload_idx(ctx, a, MO_TEUL, true);
> +    return gen_fload_idx(ctx, a, MO_TE | MO_UL, true);
>  }
>
>  static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
> @@ -411,7 +411,7 @@ static bool trans_th_fsrd(DisasContext *ctx, arg_th_m=
emidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> -    return gen_fstore_idx(ctx, a, MO_TEUQ, false);
> +    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, false);
>  }
>
>  static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
> @@ -419,7 +419,7 @@ static bool trans_th_fsrw(DisasContext *ctx, arg_th_m=
emidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> -    return gen_fstore_idx(ctx, a, MO_TEUL, false);
> +    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, false);
>  }
>
>  static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
> @@ -427,7 +427,7 @@ static bool trans_th_fsurd(DisasContext *ctx, arg_th_=
memidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVD);
> -    return gen_fstore_idx(ctx, a, MO_TEUQ, true);
> +    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, true);
>  }
>
>  static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
> @@ -435,7 +435,7 @@ static bool trans_th_fsurw(DisasContext *ctx, arg_th_=
memidx *a)
>      REQUIRE_XTHEADFMEMIDX(ctx);
>      REQUIRE_FPU;
>      REQUIRE_EXT(ctx, RVF);
> -    return gen_fstore_idx(ctx, a, MO_TEUL, true);
> +    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, true);
>  }
>
>  /* XTheadFmv */
> @@ -598,64 +598,64 @@ static bool trans_th_ldia(DisasContext *ctx, arg_th=
_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_inc(ctx, a, MO_TESQ, false);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SQ, false);
>  }
>
>  static bool trans_th_ldib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_inc(ctx, a, MO_TESQ, true);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SQ, true);
>  }
>
>  static bool trans_th_lwia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TESL, false);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SL, false);
>  }
>
>  static bool trans_th_lwib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TESL, true);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SL, true);
>  }
>
>  static bool trans_th_lwuia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_inc(ctx, a, MO_TEUL, false);
> +    return gen_load_inc(ctx, a, MO_TE | MO_UL, false);
>  }
>
>  static bool trans_th_lwuib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_inc(ctx, a, MO_TEUL, true);
> +    return gen_load_inc(ctx, a, MO_TE | MO_UL, true);
>  }
>
>  static bool trans_th_lhia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TESW, false);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SW, false);
>  }
>
>  static bool trans_th_lhib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TESW, true);
> +    return gen_load_inc(ctx, a, MO_TE | MO_SW, true);
>  }
>
>  static bool trans_th_lhuia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TEUW, false);
> +    return gen_load_inc(ctx, a, MO_TE | MO_UW, false);
>  }
>
>  static bool trans_th_lhuib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_inc(ctx, a, MO_TEUW, true);
> +    return gen_load_inc(ctx, a, MO_TE | MO_UW, true);
>  }
>
>  static bool trans_th_lbia(DisasContext *ctx, arg_th_meminc *a)
> @@ -686,38 +686,38 @@ static bool trans_th_sdia(DisasContext *ctx, arg_th=
_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_inc(ctx, a, MO_TESQ, false);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SQ, false);
>  }
>
>  static bool trans_th_sdib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_inc(ctx, a, MO_TESQ, true);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SQ, true);
>  }
>
>  static bool trans_th_swia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_inc(ctx, a, MO_TESL, false);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SL, false);
>  }
>
>  static bool trans_th_swib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_inc(ctx, a, MO_TESL, true);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SL, true);
>  }
>
>  static bool trans_th_shia(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_inc(ctx, a, MO_TESW, false);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SW, false);
>  }
>
>  static bool trans_th_shib(DisasContext *ctx, arg_th_meminc *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_inc(ctx, a, MO_TESW, true);
> +    return gen_store_inc(ctx, a, MO_TE | MO_SW, true);
>  }
>
>  static bool trans_th_sbia(DisasContext *ctx, arg_th_meminc *a)
> @@ -769,32 +769,32 @@ static bool trans_th_lrd(DisasContext *ctx, arg_th_=
memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TESQ, false);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SQ, false);
>  }
>
>  static bool trans_th_lrw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TESL, false);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SL, false);
>  }
>
>  static bool trans_th_lrwu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TEUL, false);
> +    return gen_load_idx(ctx, a, MO_TE | MO_UL, false);
>  }
>
>  static bool trans_th_lrh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TESW, false);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SW, false);
>  }
>
>  static bool trans_th_lrhu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TEUW, false);
> +    return gen_load_idx(ctx, a, MO_TE | MO_UW, false);
>  }
>
>  static bool trans_th_lrb(DisasContext *ctx, arg_th_memidx *a)
> @@ -813,19 +813,19 @@ static bool trans_th_srd(DisasContext *ctx, arg_th_=
memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_idx(ctx, a, MO_TESQ, false);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SQ, false);
>  }
>
>  static bool trans_th_srw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TESL, false);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SL, false);
>  }
>
>  static bool trans_th_srh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TESW, false);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SW, false);
>  }
>
>  static bool trans_th_srb(DisasContext *ctx, arg_th_memidx *a)
> @@ -837,32 +837,32 @@ static bool trans_th_lurd(DisasContext *ctx, arg_th=
_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TESQ, true);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SQ, true);
>  }
>
>  static bool trans_th_lurw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TESL, true);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SL, true);
>  }
>
>  static bool trans_th_lurwu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TEUL, true);
> +    return gen_load_idx(ctx, a, MO_TE | MO_UL, true);
>  }
>
>  static bool trans_th_lurh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TESW, true);
> +    return gen_load_idx(ctx, a, MO_TE | MO_SW, true);
>  }
>
>  static bool trans_th_lurhu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TEUW, true);
> +    return gen_load_idx(ctx, a, MO_TE | MO_UW, true);
>  }
>
>  static bool trans_th_lurb(DisasContext *ctx, arg_th_memidx *a)
> @@ -881,19 +881,19 @@ static bool trans_th_surd(DisasContext *ctx, arg_th=
_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_idx(ctx, a, MO_TESQ, true);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SQ, true);
>  }
>
>  static bool trans_th_surw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TESL, true);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SL, true);
>  }
>
>  static bool trans_th_surh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TESW, true);
> +    return gen_store_idx(ctx, a, MO_TE | MO_SW, true);
>  }
>
>  static bool trans_th_surb(DisasContext *ctx, arg_th_memidx *a)
> @@ -931,19 +931,19 @@ static bool trans_th_ldd(DisasContext *ctx, arg_th_=
pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TESQ, 4);
> +    return gen_loadpair_tl(ctx, a, MO_TE | MO_SQ, 4);
>  }
>
>  static bool trans_th_lwd(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TESL, 3);
> +    return gen_loadpair_tl(ctx, a, MO_TE | MO_SL, 3);
>  }
>
>  static bool trans_th_lwud(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_loadpair_tl(ctx, a, MO_TEUL, 3);
> +    return gen_loadpair_tl(ctx, a, MO_TE | MO_UL, 3);
>  }
>
>  static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp me=
mop,
> @@ -967,13 +967,13 @@ static bool trans_th_sdd(DisasContext *ctx, arg_th_=
pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_storepair_tl(ctx, a, MO_TESQ, 4);
> +    return gen_storepair_tl(ctx, a, MO_TE | MO_SQ, 4);
>  }
>
>  static bool trans_th_swd(DisasContext *ctx, arg_th_pair *a)
>  {
>      REQUIRE_XTHEADMEMPAIR(ctx);
> -    return gen_storepair_tl(ctx, a, MO_TESL, 3);
> +    return gen_storepair_tl(ctx, a, MO_TE | MO_SL, 3);
>  }
>
>  /* XTheadSync */
> --
> 2.51.0
>
>

