Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34001CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyTx-000774-Ts; Tue, 09 Sep 2025 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyTg-0006hr-HF
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:33:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyTS-0001M4-UK
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:33:41 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b00a9989633so181680666b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757424805; x=1758029605; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNxgNFfPpcR6ViM0K2MyFyM0oaG+XsB0dyvKqxqZh2E=;
 b=sVKmcCwsJVN7XEckKg/76Ia2grQCy29Lvoj9nP0s/v1MfyKLYp2NffJlzE4di1E+/h
 xTnRYl2CpmB5ZsjU9oDOgVAMKDGUxHCIv9hbC9PIVlxaaVDDcg8nxuinMLdgCcf4dQ6j
 rKhgj7WrkO+3nHRLEA+v9BQxXUkO5NL5LIvYbWRI6grQr+UfcanxrsbzVbgAyQHdtyPF
 ZuFuSItbf9/LmwC8NbrHZ79CmIlTmZjfC57j7+gd006oW4GGJxE0KsshjIdNi8kGe7Fp
 VVXbinvFDor9ZHk+35KhsvjtFKPCdZNYLagtMs6meyV4IEWZJ6XMoRShDxRlzuWtgA0N
 KmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757424805; x=1758029605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNxgNFfPpcR6ViM0K2MyFyM0oaG+XsB0dyvKqxqZh2E=;
 b=klicET5wnzTXcSSxOGthBNCi2Yy1CPONUkkGE66BVWffrMiunDnI5lnOeJQJylVFru
 Y69OqYVzrnudDpAFkp7B1c+Zc2mYauoDknnkt54QtGa4F84odm2TVtSCAgy9KLl6Fe4l
 BLU0U9qT3zCvWAqXF8ajSqxyizhcc6CqQMilY5Whf9xV2jSeTKTIBPJKI1kNB3YCZcZX
 E/gMTcrDVqovQOJZ51MF7vypS4SCxboqY2Pzwvxco81hBUg4sfb0CnHFrzsTAvulPmcV
 ++ghmSRhbArnz/2eMGfjfQGKxgcBArUot/Rbqoxy3gTOhszljK17aWsoxwY+gMVVH98I
 /igw==
X-Gm-Message-State: AOJu0YzpLx6jjBb++lxjFtQe4p9da6LeFWdoznN0u4tOJ/vWOLSCrNPO
 /1jSoBDEFMq6GPw7tQDgnLBY6EsIZdGC2oYbi41htHSSjLHipJF3EPMTwiZinzYiJwg1LeQQdkA
 eUJx48oERUl7t6aAYCzV5uF3gPDnCygvHqShVsfuz59ca70CzLoOz
X-Gm-Gg: ASbGnct94fKghzckGxxwAQ30q59yTMVSZ7HgNW8CoI3uYFSeL2ALv+NICH7CupaZmZ6
 c25tELVHmsPB/9WboQLq79BucFNNY0Cqrqsciqfsgny0V4koLpaVciBcQTRSqVLW7ICagkfyh7c
 3ixEth9veBsZFz+zgzUdwtUPb4xnCe+YYpoxoOaIv/k7DuHNrl7Q+33KLemvKKieZeyiO9lVgOR
 v1ajbx98T+Sbh/gQ6U=
X-Google-Smtp-Source: AGHT+IH6g5IVXqJdKHRIQR4oAVOvhbkY7P++yTDyvr21iNFPXfUawLRvkvVHQMlitfYLI+vekSZBLk4hcbdi945qlRY=
X-Received: by 2002:a17:907:7289:b0:b04:776a:81cb with SMTP id
 a640c23a62f3a-b04931f3609mr1770874366b.19.1757424805213; Tue, 09 Sep 2025
 06:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-56-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 14:33:11 +0100
X-Gm-Features: AS18NWDy9-Dc7VDmevQuLzCMNo56NMV3ii4rqeNVH6WE1-y8JDUP80OgEb2Zwzo
Message-ID: <CAFEAcA_1QRqHm-CsNn1SsvxiHybRDRob3fvn8U38uZorYtf0Ag@mail.gmail.com>
Subject: Re: [PATCH v4 55/84] target/arm: Emit HSTR trap exception out of line
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 30 Aug 2025 at 18:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use delay_exception_el to move the exception out of line.
> Use TCG_COND_TSTNE instead of separate AND+NE.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index c4dd3a747c..f6fdfaa551 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3033,21 +3033,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
>
>          if (maskbit != 4 && maskbit != 14) {
>              /* T4 and T14 are RES0 so never cause traps */
> -            TCGv_i32 t;
> -            DisasLabel over = gen_disas_label(s);
> +            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
> +            TCGv_i32 t =
> +                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
>
> -            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));

I almost certainly originally wrote this line with the declaration
of t and its initialization split to avoid this awkward linebreak
that you get if you put them together...

> -            tcg_gen_andi_i32(t, t, 1u << maskbit);
> -            tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
> -
> -            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
> -            /*
> -             * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
> -             * but since we're conditionally branching over it, we want
> -             * to assume continue-to-next-instruction.
> -             */
> -            s->base.is_jmp = DISAS_NEXT;
> -            set_disas_label(s, over);
> +            tcg_gen_brcondi_i32(TCG_COND_TSTNE, t, 1u << maskbit, fail);
>          }
>      }

-- PMM

