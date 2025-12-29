Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C84E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBMg-0008Ga-4X; Mon, 29 Dec 2025 06:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMd-00088y-Ow
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:39 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMc-0006a2-7j
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:39 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso1630335966b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007477; x=1767612277; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtRM1mc/ZlSVhwSxDBa2Qgm8TmxkGTqa6zsaLqwnBYQ=;
 b=iRuYPMg6OTxX1yQyt7RPTsG+rHcv9vII4dMIO3FM+mP/RtGym9MqYlIiR0R00+h1Dr
 dN7XT74Hg5fBRZ6EkytZoc8/LeQs684v9oAE+4KdStEGi2hEKqFtlnEhu1ixvjkilwuX
 wv80wzvn6GgNEkKZEqKlyToajudne5yJENl+4TonIReuZbSHVci6wOhfp06CbCbeREcy
 7BnImkTrAjkhJYfmEFBcPjgxdOTpNz8VejIECTjlPba101HmkN7klIQnPkIV8P3SmwiB
 r1O50zC0Sh8Gub6Ci4d1qzrgk8HRCeRYivhKni0UPlLsnl7K6HT38dz2Jf+rVV0kSI+g
 xVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007477; x=1767612277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dtRM1mc/ZlSVhwSxDBa2Qgm8TmxkGTqa6zsaLqwnBYQ=;
 b=vFbu9WleO+PHTxpiHs0GrpEMCn79tLHflTN23jZEFmu+/WT4xyixU3AER4pms/tzCU
 6JDsvnodiUi1rEqFmTxZwaAkkeJ7+KaFQDDqnoof3bALhp9N75ttJ9r6ATKzG4y+N0tQ
 xPhrn3cEF5HCfO5oD3T3Bz8YoHCxqXW0dNia4/YDNU56cd9bz9U5X5JFpEW/g/V8aS1C
 r8zL9Vcll5VI/oXYSgObnYiDQp5PbEeWsDIKneKzi+Pc523Gs3Z6h6Lf8enhwMpJqcAZ
 /9ofV8K6EFahLY5TT3AdO+vFEEdUZnNiHYQZMtWSLVf61AQWXgErIeV5I+4fAuk38LKv
 ngXA==
X-Gm-Message-State: AOJu0Yx8nl5EexFyUX8f7AXo/Q1qoeP3lZzcvvht0Y8Z7E/LlR9h5Aj3
 ZHak4dongSNR+syNNHhGO4zztZg7sUdPK2ZuURcQ9/ZEMFPRHSxzz+emT3Rj/aUoS0MvcAH5FM6
 nT1Ls7kqg+JneHFrGek4Sy8OI9P+snMtnqV1vDSsujhVml4LoSeu+JcoNCA==
X-Gm-Gg: AY/fxX4KxhGEmRx2vKxiPFGEwWde50xlo9n+lZsQCgbfa69dLFN9JFvG8peSUvBHOk0
 oQcaT6orRHmE+4dvLmVr4RkCGSehG7b4JmgJAM4VEd23FkvYOeGhgSda5debCURRJTJla2wjsgH
 KlFUeC6oMRS0TNjuDH8Z7MPj82gg8b1yaOMlBYqBq5AxA4yixE7X13OVVms4+hbxswo2aZnoY2c
 Gygz6xHsMhu6Bj0y7LUDIAmk2Q05si+lgmIUTQPksdqJd1Vs++OPg4iMXx1r/yyZKIglJnwVBbm
 oXDcgvs0MFiqfMB+xU9xGi54HGHeyvBFRA89hCI=
X-Google-Smtp-Source: AGHT+IGwYksX7pJM9MoMRJUKjr1ph40d0LCL6IDv9EGKT0GGy8EaXGHxmLuJ5p45pF+xEiHTxfNQ7229QvnfsiNoEs0=
X-Received: by 2002:a17:907:1c0f:b0:b83:3715:530e with SMTP id
 a640c23a62f3a-b83371556d9mr975396966b.11.1767007476587; Mon, 29 Dec 2025
 03:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20251224163005.91137-1-philmd@linaro.org>
 <20251224163005.91137-3-philmd@linaro.org>
In-Reply-To: <20251224163005.91137-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:24:10 +0200
X-Gm-Features: AQt7F2rCPNtuyyOtu9_mWJUcjXL1dbjBIPRfWBzMFJlJs_Qv21Br1-9Hjdb2K84
Message-ID: <CAAjaMXbsR1wm-0UM0KG4UzpqfKe1zTNzQdmAXdm2GKVwxZ3FbQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/tricore: Inline translator_lduw()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Wed, Dec 24, 2025 at 6:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> translator_lduw() is defined in "exec/translator.h" as:
>
>  192 static inline uint16_t
>  193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>  194 {
>  195     return translator_lduw_end(env, db, pc, MO_TE);
>  196 }
>
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since we only build the TriCore target as little-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/tricore/translate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index fbe05a93a8a..18d8726af6d 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -8422,7 +8422,8 @@ static bool insn_crosses_page(DisasContext *ctx, CP=
UTriCoreState *env)
>       * 4 bytes from the page boundary, so we cross the page if the first
>       * 16 bits indicate that this is a 32 bit insn.
>       */
> -    uint16_t insn =3D translator_lduw(env, &ctx->base, ctx->base.pc_next=
);
> +    uint16_t insn =3D translator_lduw_end(env, &ctx->base, ctx->base.pc_=
next,
> +                                        MO_LE);
>
>      return !tricore_insn_is_16bit(insn);
>  }
> @@ -8435,15 +8436,15 @@ static void tricore_tr_translate_insn(DisasContex=
tBase *dcbase, CPUState *cpu)
>      uint16_t insn_lo;
>      bool is_16bit;
>
> -    insn_lo =3D translator_lduw(env, &ctx->base, ctx->base.pc_next);
> +    insn_lo =3D translator_lduw_end(env, &ctx->base, ctx->base.pc_next, =
MO_LE);
>      is_16bit =3D tricore_insn_is_16bit(insn_lo);
>      if (is_16bit) {
>          ctx->opcode =3D insn_lo;
>          ctx->pc_succ_insn =3D ctx->base.pc_next + 2;
>          decode_16Bit_opc(ctx);
>      } else {
> -        uint32_t insn_hi =3D translator_lduw(env, &ctx->base,
> -                                           ctx->base.pc_next + 2);
> +        uint32_t insn_hi =3D translator_lduw_end(env, &ctx->base,
> +                                               ctx->base.pc_next + 2, MO=
_LE);
>          ctx->opcode =3D insn_hi << 16 | insn_lo;
>          ctx->pc_succ_insn =3D ctx->base.pc_next + 4;
>          decode_32Bit_opc(ctx);
> --
> 2.52.0
>

