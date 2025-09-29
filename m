Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6066CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32FN-00036P-Qs; Sun, 28 Sep 2025 21:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32FL-00035X-AC
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:00:07 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32FC-00065D-Dx
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:00:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b00a9989633so760579266b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759107592; x=1759712392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZQS4dIQjF2GGCBk2EsJATpMfBo17XlNBvV7MDnwow0=;
 b=TnlG4KLotL5POopkY7dOHs0JGAJrBdCNKgQlt6PieSTRLm/Uxg7h2MACAenHZ6FgBS
 /oeIl0WDE4b5OoMCfakSBtYsH4+8fH3sNRNop6qdxIJ5P9ti7LG5kp9xQplgmy4smtHz
 ObI1InrpA2YZ7q8h9nvRpEEgmUND7iLsNCwpl4yIRyfw+oFp5bUXP0iR/NdcrQNMZgZB
 OOHN9BYxW44NQoHP1iIa1iWyy9H4zn77rh5Ie7vok8aq9y99cKp10fE700FwkdW5KoGi
 l3xofWYex5xVJsjB66Lo1SBLcd0m8DRV+bP9vM2mOUkiyzyzqw733kAeld6g6W4c/Gl1
 SqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759107592; x=1759712392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZQS4dIQjF2GGCBk2EsJATpMfBo17XlNBvV7MDnwow0=;
 b=eNzfjo1C661/ds3SIP+Yz/5JKk4V6GE4y9l58rhl48QZcY7r6B6+6PpBDtxL53eGWS
 r5EIjynpJrFL3ajhw7mqAkvdk7jGS8Tq8xwzCN928tYX6oXwchAWlEdch11rZF3L7O86
 kXHZ9chs3MLvWbnl8CF8goeIuO1v8CZCn18v5mIWHjw80GRiy0ilnQ99/Iy6h7OrUOW3
 5PUISKpoBG/dndOU/eMlGohfwYM4tfxC20h9E+RyMf2gJGVfKnca8q/+430nWRZbo4C7
 qEZmOiNlagoZmvnryq4xmlKmGs2hrSCWvNOtAItW4pzfKeBRljg1/GrIF6m7NLmviSPv
 9jwg==
X-Gm-Message-State: AOJu0Yyle1B9thu47Z59LSk2YwZ0HwDn6KnMckNQx+SY2uSkjWwNq84o
 mcR/pF5TY6DDq+JjsTkJ2miuMXpeovorrUqFWTHDtOWHmBqRDXk0zc0zvFiy1LEFelWyqRuSB8t
 da7fkmMakrZp6bHZ/thvb/KptNLXNqc4=
X-Gm-Gg: ASbGncvwZhe0Or6nh5FI0iTK35RdcPYzwcmJcskXessWLY9QImEZRjOp5t1fDnT/TAj
 furk6KYu9wCtxhYuKO4xssOfgCAjZBxPffW9E4hljzXDz4Ce2qB9ADlwS9Zim4UB9GR0CYTudwP
 EyNJ74dytEyh6CRvU4il8Cxmng3P7KjZuapD3SSi8JLe0O2H+O/UTmPkX5dnubwVEXGXXCQ0dwQ
 IolfcHs2keKwPhkbt4tv7K6rQf1JmE5SWkOiWyEfAr8oT+GrpGJrKUBQws=
X-Google-Smtp-Source: AGHT+IH5FYkwNsCw/ZadaCFkBx6TXOCDX/oMJ1/b+kg/ziBEJSvsh82bKXpOnZsbpLcO3PCoGxirRLYVkhwOMtbQBcA=
X-Received: by 2002:a17:906:c14b:b0:b2e:7614:d92d with SMTP id
 a640c23a62f3a-b3a08b7bc8dmr835347966b.0.1759107592277; Sun, 28 Sep 2025
 17:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250923090729.1887406-1-max.chou@sifive.com>
 <20250923090729.1887406-3-max.chou@sifive.com>
In-Reply-To: <20250923090729.1887406-3-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:59:25 +1000
X-Gm-Features: AS18NWB1Lr5IaTeF2iFmGyQgVxl6EekwIJhP2CaIOVH9dfBKB8hm3chsZ6UIaOE
Message-ID: <CAKmqyKNw17kgo8XJrb0F=NjaPA3J40TBEr_cnagEdcr4NT-NKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: rvv: Modify minimum VLEN according
 to enabled vector extensions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Tue, Sep 23, 2025 at 7:08=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the RISC-V unprivileged specification, the VLEN should be gr=
eater
> or equal to the ELEN. This commit modifies the minimum VLEN based on the =
vector
> extensions and introduces a check rule for VLEN and ELEN.
>
>   Extension     Minimum VLEN
> * V                      128
> * Zve64[d|f|x]            64
> * Zve32[f|x]              32
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a6f60f55ceb..02d99bb0ae9 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -416,12 +416,21 @@ static void riscv_cpu_validate_misa_priv(CPURISCVSt=
ate *env, Error **errp)
>  static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg=
,
>                                   Error **errp)
>  {
> +    uint32_t min_vlen;
>      uint32_t vlen =3D cfg->vlenb << 3;
>
> -    if (vlen > RV_VLEN_MAX || vlen < 128) {
> +    if (riscv_has_ext(env, RVV)) {
> +        min_vlen =3D 128;
> +    } else if (cfg->ext_zve64x) {
> +        min_vlen =3D 64;
> +    } else if (cfg->ext_zve32x) {
> +        min_vlen =3D 32;
> +    }
> +
> +    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
>          error_setg(errp,
>                     "Vector extension implementation only supports VLEN "
> -                   "in the range [128, %d]", RV_VLEN_MAX);
> +                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
>          return;
>      }
>
> @@ -431,6 +440,12 @@ static void riscv_cpu_validate_v(CPURISCVState *env,=
 RISCVCPUConfig *cfg,
>                     "in the range [8, 64]");
>          return;
>      }
> +
> +    if (vlen < cfg->elen) {
> +        error_setg(errp, "Vector extension implementation requires VLEN =
"
> +                         "to be greater than or equal to ELEN");
> +        return;
> +    }
>  }
>
>  static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
> --
> 2.43.0
>
>

