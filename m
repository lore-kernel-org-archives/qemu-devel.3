Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1E7C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZPnM-0002ot-FZ; Thu, 01 Aug 2024 03:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZPnJ-0002nn-Tk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:00:14 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sZPnG-0005cQ-VR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:00:13 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e0878971aa9so1438494276.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722495606; x=1723100406;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PE2yF/IDMq4m/DeSYnAqyzZd19W1t/pWFKq5VLAEMLE=;
 b=IXe3kJm5QmYVrrsUVLB2wPvOLP/cd5HWXxA5/vMGJmRci1gV2lqOk4MpiLreLMDy9s
 +HYqscQ3z7oAetiEehD+WndicvMA1goobNraMffZ61O5ZXf3qvyQJPnDXb7YpwYYkwQz
 4JZAlo7g1Xgk0y5mfbMDBS+TuRfjZH9/TlxT7793HkjFxSxeidJ7bozsHGqyF8bx0NB9
 NrrQoRzphelphZBVB1IcVsCHCoIVV3ZzXNr5t+13uEsqGr58ZG0x68XWrpgEZl+SQzDF
 h1FOG4BpR+FUwCPvUG5dHJzVpuGmAgseZSC3c3vwq6P+Kpm+4BAf6vdOczFvDdPb4xAw
 zz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722495606; x=1723100406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PE2yF/IDMq4m/DeSYnAqyzZd19W1t/pWFKq5VLAEMLE=;
 b=e8pj5aIC8yjG+SaaUbw4zb0yjRY41KbHp4eOQpXrQ1XcIG1WtLlSzfGyTv8aXjgsP9
 jfOrKTBiUnMhnHFs3tUj/tzEJpikT+4LLOdi+Z9HYSE3PKICOzzObYiwBwpg6o+OwNfp
 FuPez5AYBDyAhZYRQ+avu7WAy2px5m2QEyZvbqlsfx/zNCorKc1wZ/4x3AJUw0pGBKYG
 o2f0HnG49qmiKGkTDv6mjdivgVN900AnL0f1LHhhppGh1CYoV7N36mYZQUxqOPFWuEzk
 RnB5iWA3IsMhIt3F+HG5Ps0LryC+Rf2N5EEkN6esA31RUx7qkCEsZm3vwBZPT//9owhW
 xPTQ==
X-Gm-Message-State: AOJu0YzqkK5eoxcfIQHwUkUNi/TLqBXhA/oRw4hVL9fjgbua3VCtsilv
 K1BCdiC0lPhvXoSqEU4r9L3dkozzVtwfVmM1VDWo9+g0ATHTLnQ0JZFp+Q2AOQyTAmn8uMShN4o
 u/VKGefDH3lAYPzQ4ckpvWY5Nt2W2dDVH2xAEew==
X-Google-Smtp-Source: AGHT+IHPcaDTBIRELdXRt4An0y9A5huenk7NoTqD+jUAN4kXtSPjuB4i8BnBoohYFsxzk+Rd9Yp237nTtvT0s01NWJc=
X-Received: by 2002:a25:ef0c:0:b0:e0b:528b:1ee2 with SMTP id
 3f1490d57ef6-e0bd5ae204bmr260175276.27.1722495606482; Thu, 01 Aug 2024
 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
 <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
In-Reply-To: <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 31 Jul 2024 23:59:51 -0700
Message-ID: <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=debug@rivosinc.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 29, 2024 at 7:34=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/30/24 03:53, Deepak Gupta wrote:
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index acba90f170..c746d7df08 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -20,6 +20,7 @@
> >   #include "qemu/log.h"
> >   #include "cpu.h"
> >   #include "tcg/tcg-op.h"
> > +#include "tcg/tcg-temp-internal.h"
>
> No, this is internal to tcg, as the filename says.

Ok

>
>
> >   #include "exec/exec-all.h"
> >   #include "exec/helper-proto.h"
> >   #include "exec/helper-gen.h"
> > @@ -44,6 +45,7 @@ static TCGv load_val;
> >   /* globals for PM CSRs */
> >   static TCGv pm_mask;
> >   static TCGv pm_base;
> > +static TCGOp *cfi_lp_check;
> >
> >   /*
> >    * If an operation is being performed on less than TARGET_LONG_BITS,
> > @@ -116,6 +118,9 @@ typedef struct DisasContext {
> >       bool frm_valid;
> >       bool insn_start_updated;
> >       const GPtrArray *decoders;
> > +    /* zicfilp extension. cfi enabled or not. lp expected or not */
> > +    bool fcfi_enabled;
> > +    bool fcfi_lp_expected;
> >   } DisasContext;
> >
> >   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> > @@ -1238,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasCont=
extBase *dcbase, CPUState *cs)
> >       ctx->pm_base_enabled =3D FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_E=
NABLED);
> >       ctx->ztso =3D cpu->cfg.ext_ztso;
> >       ctx->itrigger =3D FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
> > +    ctx->fcfi_lp_expected =3D FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_E=
XPECTED);
> > +    ctx->fcfi_enabled =3D cpu_get_fcfien(env) && ctx->fcfi_lp_expected=
;
>
> This is incorrect.  You cannot check fcfien like this here; you must plac=
e it in a tb flag
> like "lp_expected".

hmm... you've suggested below to use `aarch64_tr_translate_insn` and
check if it's the first instruction.
and put the check there.
In that case I won't need FCFI_LP_EXPECTED TB flag.
Then I would rather use it as FCFI_ENABLED TB flag.

>
>
> > @@ -1245,6 +1252,39 @@ static void riscv_tr_init_disas_context(DisasCon=
textBase *dcbase, CPUState *cs)
> >
> >   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> >   {
> > +    DisasContext *ctx =3D container_of(db, DisasContext, base);
> > +
> > +    if (ctx->fcfi_lp_expected) {
> > +        /*
> > +         * Since we can't look ahead to confirm that the first
> > +         * instruction is a legal landing pad instruction, emit
> > +         * compare-and-branch sequence that will be fixed-up in
> > +         * riscv_tr_tb_stop() to either statically hit or skip an
> > +         * illegal instruction exception depending on whether the
> > +         * flag was lowered by translation of a CJLP or JLP as
> > +         * the first instruction in the block.
> > +         */
> > +        TCGv_i32 immediate;
> > +        TCGLabel *l;
> > +        l =3D gen_new_label();
> > +        immediate =3D tcg_temp_new_i32();
> > +        tcg_gen_movi_i32(immediate, 0);
> > +        cfi_lp_check =3D tcg_last_op();
> > +        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
> > +        tcg_temp_free_i32(immediate);
> > +        tcg_gen_st_tl(
> > +            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> > +            tcg_env, offsetof(CPURISCVState, sw_check_code));
> > +        generate_exception(ctx, RISCV_EXCP_SW_CHECK);
> > +        gen_set_label(l);
> > +        /*
> > +         * Despite the use of gen_exception_illegal(), the rest of
> > +         * the TB needs to be generated. The TCG optimizer will
> > +         * clean things up depending on which path ends up being
> > +         * active.
> > +         */
> > +        ctx->base.is_jmp =3D DISAS_NEXT;
> > +    }
> >   }
>
> Better to simply delay the check to the first insn load.
> See aarch64_tr_translate_insn, dc_isar_feature(aa64_bti, s).

Hmmm...
Thanks, I think it'll probably make it simpler.
Let me re-work this logic and test it out if it works.

>
>
> r~
>

