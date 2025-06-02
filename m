Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8434CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0xQ-0002fe-8n; Mon, 02 Jun 2025 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uM0xM-0002eh-It
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:55:44 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uM0xK-0004QJ-NG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:55:44 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso795491766b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1748854541; x=1749459341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWK3+AbgcJu/xdiUWYmmNm78DwUqHEc8gBxDBWG3whk=;
 b=aoKjHsw/d6WVD7Fykog8RmVW6NgrKhKKA8fqA6h08eiWOgfNh+tmbWTOHV4lMLjFN9
 M9nHjncFIB38gxGQBSoXSDq10cqTsf7MBBT4hNoB+Jcf/dpJmrK8wPSdQDC0gdl54wN+
 XMi71QTrllAfDxwOxNThPMdVkpUimil2bwU+l6lMp79BQL58CdIzubYzTVMiddXaP4gD
 wGKWWI99KApyg4k5dVMYW/3sL07UNweLYwHjLPkK7iYGCVhwO2ahKY+688OI24tZPrfx
 ky2dBXQW5l6TktMwOprzV7HCbol3PSehf5tg3OSd78O8ijQUVM9WtkLQmuYy//ysKeah
 Yh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748854541; x=1749459341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWK3+AbgcJu/xdiUWYmmNm78DwUqHEc8gBxDBWG3whk=;
 b=dBZoBdYTZv08gN9Sp8CQ0pXsnbnemTDJ+5k/kt+xDjxPmShBOuTF7UslSUmAV0BSe9
 bngPpToky/TiLulouut3heAuF0SMamaqteKDGsRXc9PUONEYkzXWWktg27KSDsyQRQMr
 9YnNha+kGGLB21Zf6bUJ/BTniyR9k85QK3G3NqyjgjPFp0QPy7ARKjTZ5jENvIgfTgIw
 Vmpa834NShWrCX0V+gok2jHOfDYZEV/X/9yPyTvCAUQHHPDDTx0Kr11F4YJzQbLsOz1h
 bqDJ5jtHVbtVwbBLNZ8QrHSfYqJDhhfIG9ijfb6Gab3Vksm4OozFf/XCAzuh7QZY0F6g
 ZGhw==
X-Gm-Message-State: AOJu0YwDXNPbjcHQWwkIAMBICDO/B9FAt2+29NicbXxVvoBD00ew8j6d
 hq/UHADo08XL4mjik5qaEinYrdpwAOD81R4YElDjFrUhalVY7LHen46T027GOk6Y4TbLgiQLP1J
 hQ3XSA2oK9Es4RivSCnY98+8JoADSC6vn02M53BzCVNAaQGyiPMrx
X-Gm-Gg: ASbGncsNbj26x7kALogv87vXM3aMbOKI8BHXoycQvFcD0WSZ1YzwVlzhKagALZFAwHm
 pIwu8i/sS89Z1osnTkniZwK15iYIyRjNWt2G635cR/8Xk5+rJ4iNu+BpG8s9ZLUzZ6GLGwp16A3
 skh/anpxDxTS/rE4a42O1IDqEUNMD/vCXxZ9iuyauCJ09p4w==
X-Google-Smtp-Source: AGHT+IGxhNWeQmpawZ+A8X0Upg/q3SEkSwvEJMce2w0oXYnVdfpQaF2OxmbER+8XaMTRgA4QX13glat2Iv+AwnoSa0A=
X-Received: by 2002:a17:907:da5:b0:ad8:af1f:938d with SMTP id
 a640c23a62f3a-adb3242e54dmr1118745166b.37.1748854540643; Mon, 02 Jun 2025
 01:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250508094838.19394-1-jim.shu@sifive.com>
In-Reply-To: <20250508094838.19394-1-jim.shu@sifive.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Mon, 2 Jun 2025 16:55:31 +0800
X-Gm-Features: AX0GCFsKUwFhI8s9CZa8ycbj3DUShjCuph70W0yB0RS57UJf8r8PiuU2SKs2Ius
Message-ID: <CALw707qScdZLSbaT2pY=qb9z1Aqsy8toFbsAeK1hs+2YZb8NUw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: support atomic instruction fetch (Ziccif)
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Gentle ping on this patch.

Thanks,
Jim Shu


On Thu, May 8, 2025 at 5:48=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
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
> This commit depends on the atomic read support of translator_ld in
> the commit 6a9dfe1984b0c593fb0ddb52d4e70832e6201dd6.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/translate.c | 46 +++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 85128f997b..77edf04803 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1222,13 +1222,35 @@ const RISCVDecoder decoder_table[] =3D {
>
>  const size_t decoder_table_size =3D ARRAY_SIZE(decoder_table);
>
> -static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
> +static void decode_opc(CPURISCVState *env, DisasContext *ctx)
>  {
> +    uint32_t opcode;
> +    bool pc_is_4byte_align =3D ((ctx->base.pc_next % 4) =3D=3D 0);
> +
>      ctx->virt_inst_excp =3D false;
> -    ctx->cur_insn_len =3D insn_len(opcode);
> +    if (pc_is_4byte_align) {
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
> +    ctx->cur_insn_len =3D insn_len((uint16_t)opcode);
>      /* Check for compressed insn */
>      if (ctx->cur_insn_len =3D=3D 2) {
> -        ctx->opcode =3D opcode;
> +        ctx->opcode =3D (uint16_t)opcode;
>          /*
>           * The Zca extension is added as way to refer to instructions in=
 the C
>           * extension that do not include the floating-point loads and st=
ores
> @@ -1238,15 +1260,17 @@ static void decode_opc(CPURISCVState *env, DisasC=
ontext *ctx, uint16_t opcode)
>              return;
>          }
>      } else {
> -        uint32_t opcode32 =3D opcode;
> -        opcode32 =3D deposit32(opcode32, 16, 16,
> -                             translator_lduw(env, &ctx->base,
> -                                             ctx->base.pc_next + 2));
> -        ctx->opcode =3D opcode32;
> +        if (!pc_is_4byte_align) {
> +            /* Load last 2 bytes of instruction here */
> +            opcode =3D deposit32(opcode, 16, 16,
> +                               translator_lduw(env, &ctx->base,
> +                                               ctx->base.pc_next + 2));
> +        }
> +        ctx->opcode =3D opcode;
>
>          for (guint i =3D 0; i < ctx->decoders->len; ++i) {
>              riscv_cpu_decode_fn func =3D g_ptr_array_index(ctx->decoders=
, i);
> -            if (func(ctx, opcode32)) {
> +            if (func(ctx, opcode)) {
>                  return;
>              }
>          }
> @@ -1324,10 +1348,8 @@ static void riscv_tr_translate_insn(DisasContextBa=
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
>      /*
> --
> 2.17.1
>

