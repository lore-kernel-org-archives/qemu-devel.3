Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66DAE9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBAo-00023x-NM; Mon, 29 Dec 2025 06:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBAf-00021Q-V9
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:12:18 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBAe-000580-1r
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:12:17 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso10217913a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006734; x=1767611534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqhS9oukO2CEnpA0K7Nm1NJsf4X+Tqk2sB1JDl2LTBc=;
 b=bS1Pzc3BOL3pZqPT4TN3wS0gZMukbRG0hZgEmDcyAuHYsi2s+CFP7CXWbntifyeNN1
 uDfNAWxZJIf0ziKcm4W4j7FL/+USf21Sw+uuP6hSAZM0LGno7v9wfGZ1mKw1Im6xvCXj
 XGXpieneKtWYLWDsQwBJYYJ6xMu4F9KdaOakN3hG19JWcBdV7lXBQMgeGT4CurrrHCG+
 vf2b5omDZjJZCRy1eOf3447hGYYZ7kztYM7U4+1NgIMdald5dnXp7rJfukub/ZE8L9ke
 sNvd7hYIdQmdOFJvx6eDOmE5OvWxdTokb975EDwHMDv9rwK2OB88o1o3x8J/j6lVxPee
 Iheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006734; x=1767611534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wqhS9oukO2CEnpA0K7Nm1NJsf4X+Tqk2sB1JDl2LTBc=;
 b=R6u0+T1KTUgPAX45HxWCHWlSrhS4Qm2QaImrxfaz0uxAO2uFIMlqNOp10XHurZgvrm
 vz71E0MJR/WVhRkcE0WlPnfRt4YvCAG8o7PfLrv+RSTi3Bulli0IjUZb2hjp13hEm8hZ
 d/F2GY+snt28zDm6HukG3zfN3fXeI05GVYCLCog8FV0lnpFBA/iI/JqrUCx0CTrPPM/a
 3IsIhWP/nOygPbrN9jaV8b8bsroTvbwyUtvCZ+5LWamjc56omZtH/wSTldptuIjivn77
 4/0Fgdzvl7EWfb4htwJq0GA2ZjrhFNXW9Mo6wVE+3KFdn9RFftbWgA1t4nOD4VLDUyF9
 PvPA==
X-Gm-Message-State: AOJu0YzBH9iI/K7zYl/WPInd+BVQAnv+RfL1X1urLqsQGCa8RvmUGvMs
 oqHklKVr5mRgQwJ0SOM7dUlRaKk44IoKVwLwbo6EmBDZHocWWxLted7Xu+BzWjb8bXSSxzeMSZI
 mBMkTBdB1IZO99Jc50MH0XFR10D/qBTLLqZIFO4PpgA==
X-Gm-Gg: AY/fxX5Mh9Ssvw0SvsCsNlpRaD6xiVXn2sqCNvANFugy4y+GcFDlm86yAEv3/N4DqtA
 w21IM3YVtUTGBvfjdLWnSvVPgQZI+/BLKUouaoJGkBSpqp5mP9NIZQy91m88+UVMYOW0tpBpINP
 fd/Vuit6Wz3YXdah/whR1ZmK6Oq/jTMuLw2t724wTmG9/wo3b0qu4IrL/MaYmp2OGZzu2w6a1Ly
 9pP/Vg3vyCz7dJGb9WiZUzW9DKSBXwgEU3OSJF9WUxMCXPbCIGBX6Ej+DKN8k2L/Xb5oq3FvAm6
 55k1eVwZAES33urguH1BkCZuZIas3x2IuYIr0oM=
X-Google-Smtp-Source: AGHT+IFAxVgrp3kBvSpvlcSxA6jntVx01uKp4TQunAlKLzmp5r3dx6uxx/wKt0quGEyxkTvG+2t76HKQzyGP0SMEcj8=
X-Received: by 2002:a17:907:7295:b0:b72:d56f:3468 with SMTP id
 a640c23a62f3a-b803718321fmr2809725766b.50.1767006734359; Mon, 29 Dec 2025
 03:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-8-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-8-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:11:47 +0200
X-Gm-Features: AQt7F2oUdhKKVSsRD1RnZi6dWtHJed628ur1Zi-Kdsken61B7XH9GDyisRH3L7c
Message-ID: <CAAjaMXanQqQZ4gVyqJqQJQw4077jAspEw4L_n5WOJNs1PZSCAA@mail.gmail.com>
Subject: Re: [PATCH 7/8] target/s390x: Inline translator_lduw() and
 translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Dec 24, 2025 at 6:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> translator_lduw() and translator_ldl() are defined in
> "exec/translator.h" as:
>
>   192 static inline uint16_t
>   193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   194 {
>   195     return translator_lduw_end(env, db, pc, MO_TE);
>   196 }
>
>   198 static inline uint32_t
>   199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   200 {
>   201     return translator_ldl_end(env, db, pc, MO_TE);
>   202 }
>
> Directly use the inlined form, expanding MO_TE -> MO_BE
> since we only build the S390x target as big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  target/s390x/tcg/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index db2276f1cfc..e38607ee18c 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -365,13 +365,13 @@ static void update_cc_op(DisasContext *s)
>  static inline uint64_t ld_code2(CPUS390XState *env, DisasContext *s,
>                                  uint64_t pc)
>  {
> -    return (uint64_t)translator_lduw(env, &s->base, pc);
> +    return (uint64_t) translator_lduw_end(env, &s->base, pc, MO_BE);
>  }
>
>  static inline uint64_t ld_code4(CPUS390XState *env, DisasContext *s,
>                                  uint64_t pc)
>  {
> -    return (uint64_t)(uint32_t)translator_ldl(env, &s->base, pc);
> +    return (uint64_t)(uint32_t) translator_ldl_end(env, &s->base, pc, MO=
_BE);
>  }
>
>  static int get_mem_index(DisasContext *s)
> @@ -6408,7 +6408,7 @@ static void s390x_tr_insn_start(DisasContextBase *d=
cbase, CPUState *cs)
>  static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
>                                  uint64_t pc)
>  {
> -    uint64_t insn =3D translator_lduw(env, &s->base, pc);
> +    uint64_t insn =3D translator_lduw_end(env, &s->base, pc, MO_BE);
>
>      return pc + get_ilen((insn >> 8) & 0xff);
>  }
> --
> 2.52.0
>

