Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61274C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4FV-000253-Ej; Thu, 05 Jun 2025 02:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN4FQ-00024O-Qm; Thu, 05 Jun 2025 02:38:44 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN4FN-0005oD-Ep; Thu, 05 Jun 2025 02:38:43 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-87eb12acff8so232605241.0; 
 Wed, 04 Jun 2025 23:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749105519; x=1749710319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+YhJIO3IX3TvQwCAZ4mL2wxwLvnXnSV6D0Y9Aoy/nw=;
 b=cpltbXYo+f4uCLAzVBiVv6CN3AsMIyg886oqm+6RTXR6YSW6xnoEKOs66PJ2xbZ1W2
 6pOuvQFslrRn2H5z3zwEMGNH0B1R9/y05vJ+fk+MoFt2A5XVxYrxQaknw41NhGVKscrv
 9Dw2uZhbUd+X2cnuxdmGanKECVCgL54fS6T2Mg7r2/0hSH3HSdHEUA+2BkMRsh2h47eb
 Ahp2IBxXfdVILAlCU9Osw79bmo0ixJmxqqHl5axuEK9kSTt8ym3TromNmfPfa7PcVMWY
 X+HhY84mb6cBqUgNMsGxaMR7iSgqbxsZB+rLqeuIuVwCHe5X21I+seLlD4LdrRW7vvH7
 8g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749105519; x=1749710319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+YhJIO3IX3TvQwCAZ4mL2wxwLvnXnSV6D0Y9Aoy/nw=;
 b=Tc96/vlPN3DDznxrGgG5GBifQRbosPISJmKrlEH4aHtMjtVXQhyD89cZWV4zZNyrza
 EA7K93D0/u3lg4soqiexZUovvGMzWkSw+/iURVoKQEAz0YyXC7Aclr+woRDcdSXdl536
 D1a/M2wgewv24GPjfNKrMGiPDUyTreWjqyHUqto6RL1mmnGLKqZuXbte1xPzQo9j6bVW
 /eyDbouAANfsT/u18ShOdfe5KfEoG0bS1/TSWktRVRVLbZG5yfKPyQrF86D6YaG9KxHO
 P354XFI7Oag8pThrP85m/xir7JQeYCynqODgjXLIkqk96W0tPruDqYzerxYROytOlM/v
 xT5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIjG7OweoqelmJsMqyiH3Se/gP3zBRsYphTd5D54aL3axIGI+bxDKC3/hE4O4WtatOs2ww/ebiTmlS@nongnu.org
X-Gm-Message-State: AOJu0Yx1vSRU1RXkAuCWRKrMqTSCyhWZbL7LMOUX3yrvfl/vo8mUB81J
 umaiv78Q+OHCNZ2I/7bwjEJQL49w92UfR0mcM65sfd8Ri9Gj0vqpRuGE+PYjcIMMor1C6sI8FOU
 cOvqDGOCEz7W6chkqrErLwPU6nEfbzHo=
X-Gm-Gg: ASbGncuSEJTaRcF6fBnbsG7Wvtb0rbrwgwS4yjE2CpgzbaJchO17e9I/gSr9M8pMNBM
 1S9hNgMUuDnlwQhKOXGPUesNlu/vfjXSwuLf4oLt2ACC03uZA4KwOmMgiZvrg4JhcdQ83Chajyy
 lcGj7TWwWwljM6IPoEHjSfDyIb1L+iHfeK55MP/G0Qi2IOJ65Kf+PJRar8QO78h7xgcwSmSiTNG
 LpK0e2052hu
X-Google-Smtp-Source: AGHT+IHpfrC+lVFheFbgA05K5M5pe9tfIUxW8k07GLiXzPgcwcoWIMG3VFyAZLFoRiy0D3Xw+av4vqeAUSM+cudZq2c=
X-Received: by 2002:a05:6102:4406:b0:4e6:e126:6238 with SMTP id
 ada2fe7eead31-4e746ce24bcmr4708558137.3.1749105519333; Wed, 04 Jun 2025
 23:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250508094838.19394-1-jim.shu@sifive.com>
In-Reply-To: <20250508094838.19394-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 16:38:12 +1000
X-Gm-Features: AX0GCFvEhTjOrgvU-IZF-0Gpr8sisOP1c4cdCei5fTlw9ZdSZDfdnYon-p6u7Ho
Message-ID: <CAKmqyKNzoPCfE6jAf1EYgDv6goW1yaxup_ZZ7FV97p13Gfo2vQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: support atomic instruction fetch (Ziccif)
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Thu, May 8, 2025 at 7:49=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
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

Thanks!

Applied to riscv-to-apply.next

Alistair

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
>

