Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A59CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XCz-0003Ve-EN; Tue, 14 Oct 2025 01:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XCu-0003PF-FU
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:04:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XCq-0003bY-IV
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:04:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so9399166a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418254; x=1761023054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LS1dZrg9oTr83T3ONhqPbwQQ8nHwQ9oR62WyPW7tYYY=;
 b=Csrzcdu5JvmlHKTXpymkNQusmPNVHxT4TW6lSsk1PzjfQx3bToddFzv20ndEZXWe81
 UXMmdNWSbeEVtd80LwNF5Qh7vElCY9mG7VGLNtGHn/BOgm5D/FOzdCqEfdWygBcwNjM3
 jHm+DA4Ok8e0QDZ+sPdYnUxYG685bd8yrsKy04UIn4pZ22coP9v4uA/z1/S//7avRYuY
 Gsi0ArTzaXTKVQltLlpUu88jzEgl5x+JXkXpi9qHerEyg42sKPsTdcbTeeVnqpIq0FCh
 c2wvif/GMOZCV3ldPrGGk3S0OUk6gwtV532qtWQUL8ySLrGhMFKJg1NLqQiDQ/sl+2f5
 C7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418254; x=1761023054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LS1dZrg9oTr83T3ONhqPbwQQ8nHwQ9oR62WyPW7tYYY=;
 b=NHEx1IuSEBv9XdyN7vVAzkL7JXPRA5PUrOtirQJMTrVP1riWE+P39IqsFFA9VFokR9
 PWUE5lHkVBW/1x7dHE3k0lZKPvxyDWFXPgrZIkwA36eRNWRg7QEzX7Hdes3+cLeuu1De
 LrN8d9ykRxB2eQ06yjnZgJ+AujEVyocqPMSpBwGLMTf0oaQTaDNMjkED1k5Us4LYdC8W
 G5zDJ9vvzyP2fR9RH/IqiHu7d4VWz4EaGe7Zgm4yV5DigZITP5xEp+QVDjBXedxbUUVU
 zNSQi3mVWYHFA0vW/eAIxrR3PZud2refLda5fj2gejxR3O0HgA9AErOKLJm3zJF812CL
 B44g==
X-Gm-Message-State: AOJu0YwPBGEBYl8APlCAyRhNfu0b1mbsDl2LO7PJUCjbgNu8gFMsTKYl
 9gS5OvQfYNXWxpuLJ01paooL67gTww2V4D+HLSpLX8w3QPJegSRVFkRggSWMxkcWfy/ZYYdtbfV
 KwsvsSfsqSp0oxehFZxfeKQoQqiZdT8M=
X-Gm-Gg: ASbGnctLRCQhIyOcpUJlHV0zCSmfLEYg3XQWvfKvZhuSGMnFbP3bsd54eV7Yp70bapZ
 qJR5nnm9dcpOyoE49cumCSyz40tsoSpx66b2b4oyVBCQgBIlX4ELFNLkFdKGABzcEOtDFFkwbuP
 SMCXI1qcsyeQtyqrUu+80v4pHcCAQdXYI6mOdFBgJgEJcB0+gQ5RRNNEfvjg/AH638NPH3qacx5
 UcNlsFh8E5LohV8TZogXyLhENFncI9AZ1dUJsd/jWxw739/Rxooy24FsSc4XV9+HPRzYJN315Oj
 dA==
X-Google-Smtp-Source: AGHT+IEHCDfTj3CucOGdzq5uSFOx6mHLp7DPmYvxNV+KeqgIG9tMs85HCdWQyCMfyUOYd0wabT9USvTeJTlRHAVR/Us=
X-Received: by 2002:a50:fb0e:0:b0:637:dbfe:6787 with SMTP id
 4fb4d7f45d1cf-639d5c75d7amr15483617a12.35.1760418253734; Mon, 13 Oct 2025
 22:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-7-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-7-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:03:46 +1000
X-Gm-Features: AS18NWCYiFpbP59YJWg5suddT6XC-YVggw4ca3kHiN_b3j-RBOoqza_2e9QDxCg
Message-ID: <CAKmqyKOz79eLKUA_i1BFjJRMGdFh5qKHsyuqaSfkTWbAzKp0wQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] target/riscv: Conceal MO_TE within gen_load_idx() /
 gen_store_idx()
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Oct 11, 2025 at 1:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All callers of gen_load_idx() / gen_store_idx() set the MO_TE flag.
> Set it once in the callees.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index 7e69906e5bf..70c563664ab 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -745,6 +745,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
>      TCGv rd =3D dest_gpr(ctx, a->rd);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> +    memop |=3D MO_TE;
>      tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>      gen_set_gpr(ctx, a->rd, rd);
>
> @@ -762,6 +763,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_m=
emidx *a, MemOp memop,
>      TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, z=
ext_offs);
>
> +    memop |=3D MO_TE;
>      tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>
>      return true;
> @@ -771,32 +773,32 @@ static bool trans_th_lrd(DisasContext *ctx, arg_th_=
memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SQ, false);
> +    return gen_load_idx(ctx, a, MO_SQ, false);
>  }
>
>  static bool trans_th_lrw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SL, false);
> +    return gen_load_idx(ctx, a, MO_SL, false);
>  }
>
>  static bool trans_th_lrwu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_UL, false);
> +    return gen_load_idx(ctx, a, MO_UL, false);
>  }
>
>  static bool trans_th_lrh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SW, false);
> +    return gen_load_idx(ctx, a, MO_SW, false);
>  }
>
>  static bool trans_th_lrhu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_UW, false);
> +    return gen_load_idx(ctx, a, MO_UW, false);
>  }
>
>  static bool trans_th_lrb(DisasContext *ctx, arg_th_memidx *a)
> @@ -815,19 +817,19 @@ static bool trans_th_srd(DisasContext *ctx, arg_th_=
memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SQ, false);
> +    return gen_store_idx(ctx, a, MO_SQ, false);
>  }
>
>  static bool trans_th_srw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SL, false);
> +    return gen_store_idx(ctx, a, MO_SL, false);
>  }
>
>  static bool trans_th_srh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SW, false);
> +    return gen_store_idx(ctx, a, MO_SW, false);
>  }
>
>  static bool trans_th_srb(DisasContext *ctx, arg_th_memidx *a)
> @@ -839,32 +841,32 @@ static bool trans_th_lurd(DisasContext *ctx, arg_th=
_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SQ, true);
> +    return gen_load_idx(ctx, a, MO_SQ, true);
>  }
>
>  static bool trans_th_lurw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SL, true);
> +    return gen_load_idx(ctx, a, MO_SL, true);
>  }
>
>  static bool trans_th_lurwu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_UL, true);
> +    return gen_load_idx(ctx, a, MO_UL, true);
>  }
>
>  static bool trans_th_lurh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_SW, true);
> +    return gen_load_idx(ctx, a, MO_SW, true);
>  }
>
>  static bool trans_th_lurhu(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_load_idx(ctx, a, MO_TE | MO_UW, true);
> +    return gen_load_idx(ctx, a, MO_UW, true);
>  }
>
>  static bool trans_th_lurb(DisasContext *ctx, arg_th_memidx *a)
> @@ -883,19 +885,19 @@ static bool trans_th_surd(DisasContext *ctx, arg_th=
_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
>      REQUIRE_64BIT(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SQ, true);
> +    return gen_store_idx(ctx, a, MO_SQ, true);
>  }
>
>  static bool trans_th_surw(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SL, true);
> +    return gen_store_idx(ctx, a, MO_SL, true);
>  }
>
>  static bool trans_th_surh(DisasContext *ctx, arg_th_memidx *a)
>  {
>      REQUIRE_XTHEADMEMIDX(ctx);
> -    return gen_store_idx(ctx, a, MO_TE | MO_SW, true);
> +    return gen_store_idx(ctx, a, MO_SW, true);
>  }
>
>  static bool trans_th_surb(DisasContext *ctx, arg_th_memidx *a)
> --
> 2.51.0
>
>

