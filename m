Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A5C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4DoK-00067T-NR; Mon, 14 Apr 2025 03:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4DoE-000671-JN
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:00:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4DoC-00051m-Au
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:00:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e6167d0536so7395394a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744614041; x=1745218841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsprGB0p78/ZOMCi5ouYqfNYnUmPeBUAiryS/OH5eBo=;
 b=GT07cs7c2gWeCYViZ532X2fubY1NOrmOM/SFzQhdAurxRVe/XAvaKniKrIJaWLJYzl
 Q9wzG54IPTNi2LDDketASn71QdgfHCPjYZykCi7o460C8Rc0B6NoyOPJJoeBv62786Mq
 7/Ch3FzA84yiDVAttGuM4FcGWwCbsEkVWQOplDIc/v9ku0+gvXAFLTPzX/I8fHtQ9LE4
 csD9zhn4ldnOwQ2709O5jhGRdKcRRPPO9BdGsQ56z3Tu4gtct7SZ8xtHvsH75JhzQbeh
 cc56hYumuN4ZmHLbudR4GSQo5SitNSUsoUQb5Ny0dAr3v6VS5BB3EQYbbV/q2nL9RYzO
 XMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744614041; x=1745218841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsprGB0p78/ZOMCi5ouYqfNYnUmPeBUAiryS/OH5eBo=;
 b=t+dUGhkJhFTkK18OR1ApqheeuLv5PG77bc0lmYDAmipjyU5G4vXTI4BzsnAwgGoQSF
 G7Bv6zYoVvtTAoNAac6Qhn/XWl0KQLSfggb6EPewzPaHB6m89ctLGd6Fshdu/+BqHrWB
 dNHPHKR2+GmXRiq5JqfVdxCxRKK5dzl/ihlqTQZKIH1n0FMNMY+JksEUflvH0vLnYkSF
 hTRBsiO7KIIfgOY4POvDTc9/BfpJU9TP+JP0ZH2RYJwsTZimC07J+SVTQQt6WoMPRaRh
 MrD28BLfT3HCV/mKVEqsULn91/XzxSfdBLU+JIdMDlh0HkK6sqfqdG/sp1Pkc+v1CRue
 iB6w==
X-Gm-Message-State: AOJu0Yw8xcHKh26zFGei0fmcJtY1HsCT3sukFefKCYNZYLLcgLyan8uv
 Gtz7sHSI7WwRkFwdUbmKTpWa+zVPu1W/L5shSj86v34j/QRdKyqnlS9L9EB65Yv/UZBU+vx4oNg
 tiPYwNipyYhNEBZzmGOltmxqTRs168n0BoS2ZvA==
X-Gm-Gg: ASbGncsi6XMpoAmYQiRiQjDjHc4ozijfwCAREq8haL9MrvL2mfO3yBwqta71uPPRGaw
 NV7cZ8mvD7NWZNMtcVju4ofv3/dcByIKQKnUc1vywxEl6RTmUcmJFxzTKQioAcoLv502BHPtgEv
 mXJz7r0eteIj/mlGXi0V8OWHfFMMUBQ+tW+to=
X-Google-Smtp-Source: AGHT+IGdjp+et4tLvvPclGjBRg4xt2XDbvBrRaa/vzl4dGgDnihRGN7S+EhkvokwN2FgC/MPmGTo+ZLdGgKwq41Sq1o=
X-Received: by 2002:a17:907:972a:b0:ac6:f4c1:b797 with SMTP id
 a640c23a62f3a-acad349c39cmr899407266b.19.1744614040363; Mon, 14 Apr 2025
 00:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240607101403.1109-1-jim.shu@sifive.com>
 <CAKmqyKN4EwPHP0d=kBnk8DL9oZcr6gx_+VBveno947+2z6Cj=A@mail.gmail.com>
In-Reply-To: <CAKmqyKN4EwPHP0d=kBnk8DL9oZcr6gx_+VBveno947+2z6Cj=A@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Mon, 14 Apr 2025 15:00:33 +0800
X-Gm-Features: ATxdqUFIfvXg_W7vCJcwb8XJ0H4mewdS6depOw8Knnr98-eedlpqWDbxGSODNo8
Message-ID: <CALw707qY064+iTVZ+gzvtZuiQDBnKsMRN3WPzbhx+=mddKaFMg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: support atomic instruction fetch (Ziccif)
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52b.google.com
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

Hi Richard,
Thank you very much for adding atomic support to translator_ld(). It
has been a big help.

Hi Alistair,
I can rebase the Ziccif patch when Richard's patch has been merged.


Jim Shu

On Fri, Apr 4, 2025 at 12:41=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, Jun 7, 2024 at 8:15=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote=
:
> >
> > Support 4-byte atomic instruction fetch when instruction is natural
> > aligned.
> >
> > Current implementation is not atomic because it loads instruction twice
> > for first and last 2 bytes. We load 4 bytes at once to keep the
> > atomicity. This instruction preload method only applys when instruction
> > is 4-byte aligned. If instruction is unaligned, it could be across page=
s
> > so that preload will trigger additional page fault.
> >
> > We encounter this issue when doing pressure test of enabling & disablin=
g
> > Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
> > modification and execution of instruction, so non-atomic instruction
> > fetch will cause the race condition. We may fetch the wrong instruction
> > which is the mixing of 2 instructions.
> >
> > Also, RISC-V Profile wants to provide this feature by HW. RVA20U64
> > Ziccif protects the atomicity of instruction fetch when it is
> > natural aligned.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
>
> Once https://patchwork.kernel.org/project/qemu-devel/list/?series=3D94533=
3
> (specifically https://patchwork.kernel.org/project/qemu-devel/patch/20250=
318213209.2579218-12-richard.henderson@linaro.org/)
> is merged this should be good to go in as well.
>
> Alistair
>
> > ---
> >  target/riscv/translate.c | 45 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index 0569224e53..2be8ef63e6 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -1133,13 +1133,37 @@ const RISCVDecoder decoder_table[] =3D {
> >
> >  const size_t decoder_table_size =3D ARRAY_SIZE(decoder_table);
> >
> > -static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t=
 opcode)
> > +static void decode_opc(CPURISCVState *env, DisasContext *ctx)
> >  {
> >      ctx->virt_inst_excp =3D false;
> > +
> > +    uint32_t opcode;
> > +    bool is_4byte_align =3D false;
> > +
> > +    if ((ctx->base.pc_next % 4) =3D=3D 0) {
> > +        /*
> > +         * Load 4 bytes at once to make instruction fetch atomically.
> > +         *
> > +         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn'=
t be
> > +         * across pages. We could preload 4 bytes instruction no matte=
r
> > +         * real one is 2 or 4 bytes. Instruction preload wouldn't trig=
ger
> > +         * additional page fault.
> > +         */
> > +        opcode =3D translator_ldl(env, &ctx->base, ctx->base.pc_next);
> > +        is_4byte_align =3D true;
> > +    } else {
> > +        /*
> > +         * For unaligned pc, instruction preload may trigger additiona=
l
> > +         * page fault so we only load 2 bytes here.
> > +         */
> > +        opcode =3D (uint32_t) translator_lduw(env, &ctx->base, ctx->ba=
se.pc_next);
> > +    }
> > +    ctx->ol =3D ctx->xl;
> > +
> >      ctx->cur_insn_len =3D insn_len(opcode);
> >      /* Check for compressed insn */
> >      if (ctx->cur_insn_len =3D=3D 2) {
> > -        ctx->opcode =3D opcode;
> > +        ctx->opcode =3D (uint16_t)opcode;
> >          /*
> >           * The Zca extension is added as way to refer to instructions =
in the C
> >           * extension that do not include the floating-point loads and =
stores
> > @@ -1149,15 +1173,16 @@ static void decode_opc(CPURISCVState *env, Disa=
sContext *ctx, uint16_t opcode)
> >              return;
> >          }
> >      } else {
> > -        uint32_t opcode32 =3D opcode;
> > -        opcode32 =3D deposit32(opcode32, 16, 16,
> > -                             translator_lduw(env, &ctx->base,
> > -                                             ctx->base.pc_next + 2));
> > -        ctx->opcode =3D opcode32;
> > +        if (!is_4byte_align) {
> > +            /* Load last 2 bytes of instruction here */
> > +            opcode =3D deposit32(opcode, 16, 16,
> > +                               translator_lduw(env, &ctx->base,
> > +                                               ctx->base.pc_next + 2))=
;
> > +        }
> >
> >          for (guint i =3D 0; i < ctx->decoders->len; ++i) {
> >              riscv_cpu_decode_fn func =3D g_ptr_array_index(ctx->decode=
rs, i);
> > -            if (func(ctx, opcode32)) {
> > +            if (func(ctx, opcode)) {
> >                  return;
> >              }
> >          }
> > @@ -1226,10 +1251,8 @@ static void riscv_tr_translate_insn(DisasContext=
Base *dcbase, CPUState *cpu)
> >  {
> >      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> >      CPURISCVState *env =3D cpu_env(cpu);
> > -    uint16_t opcode16 =3D translator_lduw(env, &ctx->base, ctx->base.p=
c_next);
> >
> > -    ctx->ol =3D ctx->xl;
> > -    decode_opc(env, ctx, opcode16);
> > +    decode_opc(env, ctx);
> >      ctx->base.pc_next +=3D ctx->cur_insn_len;
> >
> >      /* Only the first insn within a TB is allowed to cross a page boun=
dary. */
> > --
> > 2.17.1
> >
> >

