Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA2EC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 04:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Ys7-0008Ag-PJ; Fri, 04 Apr 2025 00:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Ys5-0008AJ-Vi; Fri, 04 Apr 2025 00:41:38 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0Ys4-0005ML-6i; Fri, 04 Apr 2025 00:41:37 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso769690241.2; 
 Thu, 03 Apr 2025 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743741694; x=1744346494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4UdtbtLUxvFSxPl6L3AVlYcdszBUWtCmPHWPS5yH5U=;
 b=d0WOASFyGUUisYjasC0Ho+s/c7MRgaw3C98DzCGrxeQs0qvuzUQhWJPPfXz8JuqKL/
 1EgEUct1yan8jcQIFnpMM2tLumwzPWOlSoKd7K/4xeE93BL8ySqc9bXJeG9pLp3Hbw5M
 bLCFh62JzT9He94wZs8SzbXccuCSI+h0PudrE4nMxHgtu77iB/q3NPD9ZKvfSnTLLF68
 bfvnbHH21gCegRC7wLyNjQOczxRhB0eTXMcNh7rT7RF5MX8qfJrNZF6XH2zgnDIckrno
 y6A9+fsAAdu/EDh+ok5wuRpRYVttjbTXKhBYc50FnHHC0PJ6AOaGO6HJ2+ScJZ1AIPzk
 ynoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743741694; x=1744346494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4UdtbtLUxvFSxPl6L3AVlYcdszBUWtCmPHWPS5yH5U=;
 b=kFLfGUlHzenqBAYPhhacHsqf/7mKqJ/HWgZwKmkmERWZBJiK+lsc5rUXCx9KWXJMZQ
 27qOu57PHbap7/6ZxVgyHlSBQFawLTGMhl+Pn/ZJAZGeYR+BOml1F3faiPB5o1GZxmb5
 mq/kiUPNBRs52S2Fi/irN36flsDdPBpJc84oybgFjDXvNxffdAVWRdonRL2UqMdehmD4
 JlkH4fgLLtzKE+fYKuQvFZLcEQYUN/BUlUSh19pUcAbw2V1+ZlD5sBMQtDcuc7vMbp0C
 0bNH2B391Iekeh48yHun8Shr7iMUHRCO8NoAHb9FfkL5AS29cSYi6U0RYMXwqJLifAXZ
 wEBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSfu/qhHqA+or0I0CMTloevAwTppz82mOGLyRCLWqZ/l1YFnQA6KCpSPHsB48y22ZhApwcCTRkA9C@nongnu.org
X-Gm-Message-State: AOJu0Yz9EuTgcRcEMJelKx9hcTqnOcugfJxubqWlDilyqEiv8TmCHhHO
 8/wTaF8vknRsrxP6ER6WqVar4aRAn6xH736vTNSitCRh1zJrZR52+nr22LxTmwFy1gFSx1DJoKz
 tz6X8+ZQwhjFpXvrruYuxYnClvcY=
X-Gm-Gg: ASbGnctXeggki6ugSJvPs1/Fk7oaLxjXMLjbjFJoWJ89cUYvMnfvc/FG6e0UV8JLMwi
 +WH7qDxy3699d4mUaq3ImmZ6B3DVwOVWe4JftrLcQ3N3INovyTa8tIg5a0BLnAgJGQ6lNXTcdz/
 RP7LoLpRXCnXCO69YBGd3prR2jgpEDFBsldJ1WKh6aNXg3hVKFBm97Kvpi
X-Google-Smtp-Source: AGHT+IHFX8AQ58FOCheXW7gCG4upm8oazZcOtR2qVEHi3UrKlG0543soPu72e4RbqNesgXYdwX4L3YoTzgB2xIAK9dc=
X-Received: by 2002:a05:6102:3f93:b0:4c5:78ae:1e3a with SMTP id
 ada2fe7eead31-4c8554b42f7mr1584716137.23.1743741693793; Thu, 03 Apr 2025
 21:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240607101403.1109-1-jim.shu@sifive.com>
In-Reply-To: <20240607101403.1109-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 14:41:07 +1000
X-Gm-Features: ATxdqUGRI6CCesvZH3Heq_aXnqbI7Wr6vl7YPQdkxhGXAEAILJPO3xROYzrzIyk
Message-ID: <CAKmqyKN4EwPHP0d=kBnk8DL9oZcr6gx_+VBveno947+2z6Cj=A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: support atomic instruction fetch (Ziccif)
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Jun 7, 2024 at 8:15=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Support 4-byte atomic instruction fetch when instruction is natural
> aligned.
>
> Current implementation is not atomic because it loads instruction twice
> for first and last 2 bytes. We load 4 bytes at once to keep the
> atomicity. This instruction preload method only applys when instruction
> is 4-byte aligned. If instruction is unaligned, it could be across pages
> so that preload will trigger additional page fault.
>
> We encounter this issue when doing pressure test of enabling & disabling
> Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
> modification and execution of instruction, so non-atomic instruction
> fetch will cause the race condition. We may fetch the wrong instruction
> which is the mixing of 2 instructions.
>
> Also, RISC-V Profile wants to provide this feature by HW. RVA20U64
> Ziccif protects the atomicity of instruction fetch when it is
> natural aligned.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Once https://patchwork.kernel.org/project/qemu-devel/list/?series=3D945333
(specifically https://patchwork.kernel.org/project/qemu-devel/patch/2025031=
8213209.2579218-12-richard.henderson@linaro.org/)
is merged this should be good to go in as well.

Alistair

> ---
>  target/riscv/translate.c | 45 ++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 0569224e53..2be8ef63e6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1133,13 +1133,37 @@ const RISCVDecoder decoder_table[] =3D {
>
>  const size_t decoder_table_size =3D ARRAY_SIZE(decoder_table);
>
> -static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
> +static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>  {
>      ctx->virt_inst_excp =3D false;
> +
> +    uint32_t opcode;
> +    bool is_4byte_align =3D false;
> +
> +    if ((ctx->base.pc_next % 4) =3D=3D 0) {
> +        /*
> +         * Load 4 bytes at once to make instruction fetch atomically.
> +         *
> +         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn't =
be
> +         * across pages. We could preload 4 bytes instruction no matter
> +         * real one is 2 or 4 bytes. Instruction preload wouldn't trigge=
r
> +         * additional page fault.
> +         */
> +        opcode =3D translator_ldl(env, &ctx->base, ctx->base.pc_next);
> +        is_4byte_align =3D true;
> +    } else {
> +        /*
> +         * For unaligned pc, instruction preload may trigger additional
> +         * page fault so we only load 2 bytes here.
> +         */
> +        opcode =3D (uint32_t) translator_lduw(env, &ctx->base, ctx->base=
.pc_next);
> +    }
> +    ctx->ol =3D ctx->xl;
> +
>      ctx->cur_insn_len =3D insn_len(opcode);
>      /* Check for compressed insn */
>      if (ctx->cur_insn_len =3D=3D 2) {
> -        ctx->opcode =3D opcode;
> +        ctx->opcode =3D (uint16_t)opcode;
>          /*
>           * The Zca extension is added as way to refer to instructions in=
 the C
>           * extension that do not include the floating-point loads and st=
ores
> @@ -1149,15 +1173,16 @@ static void decode_opc(CPURISCVState *env, DisasC=
ontext *ctx, uint16_t opcode)
>              return;
>          }
>      } else {
> -        uint32_t opcode32 =3D opcode;
> -        opcode32 =3D deposit32(opcode32, 16, 16,
> -                             translator_lduw(env, &ctx->base,
> -                                             ctx->base.pc_next + 2));
> -        ctx->opcode =3D opcode32;
> +        if (!is_4byte_align) {
> +            /* Load last 2 bytes of instruction here */
> +            opcode =3D deposit32(opcode, 16, 16,
> +                               translator_lduw(env, &ctx->base,
> +                                               ctx->base.pc_next + 2));
> +        }
>
>          for (guint i =3D 0; i < ctx->decoders->len; ++i) {
>              riscv_cpu_decode_fn func =3D g_ptr_array_index(ctx->decoders=
, i);
> -            if (func(ctx, opcode32)) {
> +            if (func(ctx, opcode)) {
>                  return;
>              }
>          }
> @@ -1226,10 +1251,8 @@ static void riscv_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPURISCVState *env =3D cpu_env(cpu);
> -    uint16_t opcode16 =3D translator_lduw(env, &ctx->base, ctx->base.pc_=
next);
>
> -    ctx->ol =3D ctx->xl;
> -    decode_opc(env, ctx, opcode16);
> +    decode_opc(env, ctx);
>      ctx->base.pc_next +=3D ctx->cur_insn_len;
>
>      /* Only the first insn within a TB is allowed to cross a page bounda=
ry. */
> --
> 2.17.1
>
>

