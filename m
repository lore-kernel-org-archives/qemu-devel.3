Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D3CCCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 04:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Fj0-0007VI-Gi; Thu, 16 Oct 2025 00:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fiz-0007VA-Cd
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:36:25 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Fiw-0005e0-FZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 00:36:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63bd822b007so383497a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760589380; x=1761194180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XD113YcLp4ED5QFz0XO5vu3fnp3HvT1r3siZoH3c+g8=;
 b=g1l+6Iy+0J7l6wiwmnsmXg9rfbHQSKkMQKHcmYtcZURpLMk9tbi4hZZlzlRvVlSt1e
 lvQolkWnIa+q5LFXjVJLIUahmEEN64fXU/2TvVkfui6OfluMhpGMOILMT8XQrxTTvoF/
 yyNV+3pe0IxaEvTsQWqogl6SvTdDV2qBvy+q0pp9MZpjPVJM88BClPTnFRtwhkmCjCNN
 Tora+tVTqrj7pLZC8X+Wjfdern018shca7nGR7jBs6jgJHelMuiGUlZsTub+T81b7cud
 wzHB5E/6mUaq3to9F+7XK3/lC7Xz4bTDQ48ztmTbJdQ/JHG1aENKzDoajfw1kdXEXg96
 IOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760589380; x=1761194180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XD113YcLp4ED5QFz0XO5vu3fnp3HvT1r3siZoH3c+g8=;
 b=SAYnnndEhCN8i4x59lI7YNPoQgyO0Yb14trpaNVBjbzh5SQHx/S03qZfKDz60vFnAg
 SUj8H+zPQh9uMrabXP1Uk1vvwcCkXnYxdj+9q6p0ueHqPFMFVm+upagMzgDD1jQ3qpjZ
 ZLlfX9+WGLuOCIwArt0suDl8LxESVeNxlnUTEzgSFaNRDamcs5zt9humhR4ysGogbd/Q
 izZJfntsJeD6QJzGJsDueUpst+dgDgssCuTiDeruudcFdxDmB+WFelyc6HB4RPr6B6WA
 tSbstmzBu/woCX9eoyVamEViQTSWbftbkPK7mwBA+h4nhZ12vU3H1rpJtcDQxvzdGFkq
 FN9A==
X-Gm-Message-State: AOJu0YwpinoBNnnyKQPfPMLZaYVjD+ZIz6JrmOEUGQAIWF13Situ4nHv
 iS19OGbUvcdBmgbzwAtB0IDIE3dIaAYhkDocYmebBXsmN8g7EneRVjTrE/9fNQjB3d/IB4UlkYz
 ubceMznqdzJKcqilT0mGHdwIKjzJdGR4=
X-Gm-Gg: ASbGncvsIrZveYOzPgZOtveE4HlPBrTht8/LPFz90QwuQS3jGaV7yXLEdX+QwZYVZho
 p5UiEpoicmrlPSrUqWCfwX2mNfv9or91s6ztzQ9mBuhqqrCW9Qa26gs2cpNmzcC41Nnk3566gxB
 npQkQEGb60yeh/DTLaYod2c2tE61/O9jgLZ80OTg0Tn58+D+FqVpyeRurDdHiTHwxaR2iLK5p0X
 6Oyj8wxuMty4OiCkxpWaHEbbrp/4kX4o1r6TKeEruE22Y/+smGH+dLa6K7OVI9ZDHarxWsd+jNy
 989XGe+RgzTk40E=
X-Google-Smtp-Source: AGHT+IElZkAi8MegEry3IGes3oDGY2D/qJx0QRdwCGLcvcWXcf1tP7grIIaAeq1pg126rZ4mWHj0AaPVcmtb3c21OI8=
X-Received: by 2002:a05:6402:2707:b0:638:df2f:b8fb with SMTP id
 4fb4d7f45d1cf-639d5c2dbaemr29091959a12.19.1760589380496; Wed, 15 Oct 2025
 21:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-15-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-15-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 14:35:53 +1000
X-Gm-Features: AS18NWCdovnA2oC0t05nM-5Usih5RjzLDCE67zD3hv9BiiDrug18M2756VBlzYo
Message-ID: <CAKmqyKPHrsjfHBPc-GMr6eZaceoCO-AN6q_xFghUn0Qmv5sMgA@mail.gmail.com>
Subject: Re: [PATCH v3 14/34] target/riscv: Fix size of badaddr and bins
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Oct 15, 2025 at 6:34=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix these fields to 64 bits as they cannot be made smaller. Also make
> sure stores to these fields from TCG are 64 bits in size to avoid
> incorrect values on big endian hosts.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                             | 4 ++--
>  target/riscv/machine.c                         | 2 +-
>  target/riscv/translate.c                       | 6 ++++--
>  target/riscv/insn_trans/trans_privileged.c.inc | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f2378d0b67..8c93030b1c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -233,8 +233,8 @@ struct CPUArchState {
>      uint8_t frm;
>      float_status fp_status;
>
> -    target_ulong badaddr;
> -    target_ulong bins;
> +    uint64_t badaddr;
> +    uint64_t bins;
>
>      target_ulong guest_phys_fault_addr;
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 07995fb303..b047321073 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -437,7 +437,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINT64(env.load_res, RISCVCPU),
>          VMSTATE_UINT64(env.load_val, RISCVCPU),
>          VMSTATE_UINT8(env.frm, RISCVCPU),
> -        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
> +        VMSTATE_UINT64(env.badaddr, RISCVCPU),
>          VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
>          VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>          VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6b84d0c384..2770c06413 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -253,7 +253,7 @@ static void generate_exception(DisasContext *ctx, RIS=
CVException excp)
>
>  static void gen_exception_illegal(DisasContext *ctx)
>  {
> -    tcg_gen_st_i32(tcg_constant_i32(ctx->opcode), tcg_env,
> +    tcg_gen_st_i64(tcg_constant_i64(ctx->opcode), tcg_env,
>                     offsetof(CPURISCVState, bins));
>      if (ctx->virt_inst_excp) {
>          generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
> @@ -264,7 +264,9 @@ static void gen_exception_illegal(DisasContext *ctx)
>
>  static void gen_exception_inst_addr_mis(DisasContext *ctx, TCGv target)
>  {
> -    tcg_gen_st_tl(target, tcg_env, offsetof(CPURISCVState, badaddr));
> +    TCGv_i64 ext =3D tcg_temp_new_i64();
> +    tcg_gen_extu_tl_i64(ext, target);
> +    tcg_gen_st_i64(ext, tcg_env, offsetof(CPURISCVState, badaddr));
>      generate_exception(ctx, RISCV_EXCP_INST_ADDR_MIS);
>  }
>
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..a8eaccef67 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -68,7 +68,7 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak =
*a)
>      if (pre =3D=3D 0x01f01013 && ebreak =3D=3D 0x00100073 && post =3D=3D=
 0x40705013) {
>          generate_exception(ctx, RISCV_EXCP_SEMIHOST);
>      } else {
> -        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
> +        tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
>                        offsetof(CPURISCVState, badaddr));
>          generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
>      }
> --
> 2.51.0
>
>

