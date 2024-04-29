Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98ADC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HPM-0005Nr-Hi; Sun, 28 Apr 2024 23:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HPK-0005LF-D0; Sun, 28 Apr 2024 23:10:23 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HPI-0001It-Ko; Sun, 28 Apr 2024 23:10:22 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7efd944db6dso841809241.0; 
 Sun, 28 Apr 2024 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714360219; x=1714965019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7ERBg88QALya7euywfktkZGPy2QTQi+tTZRuUWO77Q=;
 b=TgulqnmSNPvSEW8/c0y1zqwOkb1VsMOEQysOq/ohWJv7uqXR8cgOSiBjPkg0K6RRK3
 pE7yrcWWeFI6U/SkXeRgiN1DdJSHUmjRxB84WfzBMEYKZ5PXML0492g5rgtDM0+eIGtL
 /LTBBeYjUmucpIiyIsSWyLBnMnfh2hFP413jPxtbUS0j5YuPZ9JPoHp1tveHR4dpgxHE
 1NRtwuKP6vIxT7nhmhWNwsTgCyfZt3VJ0/Vz0/9+lyqN4vzmjtqcIJgfoZb+Y9pK+ABX
 /8wn1Q8HayjXkR75UniD5Am1D5uUdOaKKAVp5XWWactBcmHcEB8lN7parIK7/r3XFR/r
 UBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714360219; x=1714965019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7ERBg88QALya7euywfktkZGPy2QTQi+tTZRuUWO77Q=;
 b=m6vGD1IFe93UPwh+FZbiVdAa76O+MZLS8QbtktB4YCvjUG6BuHYCQMGnXrWvCsXD14
 NPnMjw7tRPZgmeLQX12CMopfDzd6F8nDOjk1+FRVJp1xBNOymIlJ/4Y97KFiwLjOnobu
 UU6KQMdbQVyGYlM/ADJMMKxJR1B7BzcfzmhspmHZ7awUHW5K43Koxi1yHPLWny1gifhQ
 NuOey+KCloQBwlebAI2BdBcY7y0Ro/XXBrTMX/rY6SbHM6whzqyQmq43pYzdFTFBTk15
 I5TGG84imB+dgyzq4KTZlqG5Pu4ZJE6r8kllWgPuRc2+2yV70WXluSb7W09B+b9yoRgJ
 kHDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVayj8Du8v9Xt6Jit15/W/B7Cjrnja5h3jEvFmMpBwQBbAdZaveOY9GKj9XaWZFVkO4mlYs2AwMZNqGjodiKuu9LXZ5muE=
X-Gm-Message-State: AOJu0YxVc5CHJ1m5rMxwVTAQl7fjarRZarmJy5okV6oCZj1XE5iPvPk2
 Ib4ZaPOPG+mBKoTSnytq63PWoTgrtzFSRnag03z9oCD1/JX6K5huwZBw+eoVcXqemNGdYLLtKov
 9tHbvkbJHc66vlnFtsx4vYGlpAEU=
X-Google-Smtp-Source: AGHT+IE6mqS7e1XwiECNcGlwkPXaV/HLgmqb9RsvM2ZIVBCHW3ooP6y2wo57gkvvycr+HhpiTOPCN/LaqIGVcTFDt6I=
X-Received: by 2002:a05:6122:2221:b0:4d4:20fa:eb0c with SMTP id
 bb33-20020a056122222100b004d420faeb0cmr9046235vkb.5.1714360219315; Sun, 28
 Apr 2024 20:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
 <20240416230437.1869024-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:09:53 +1000
Message-ID: <CAKmqyKNGWt=p5yhAzquvfMpJwM6OKt7NRHeebebWQa0TqhF-5g@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v3 2/2] trans_privileged.c.inc: set (m|s)tval on
 ebreak breakpoint
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Apr 17, 2024 at 9:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Privileged spec section 4.1.9 mentions:
>
> "When a trap is taken into S-mode, stval is written with
> exception-specific information to assist software in handling the trap.
> (...)
>
> If stval is written with a nonzero value when a breakpoint,
> address-misaligned, access-fault, or page-fault exception occurs on an
> instruction fetch, load, or store, then stval will contain the faulting
> virtual address."
>
> A similar text is found for mtval in section 3.1.16.
>
> Setting mtval/stval in this scenario is optional, but some softwares read
> these regs when handling ebreaks.
>
> Write 'badaddr' in all ebreak breakpoints to write the appropriate
> 'tval' during riscv_do_cpu_interrrupt().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index 620ab54eb0..bc5263a4e0 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -62,6 +62,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak =
*a)
>      if (pre =3D=3D 0x01f01013 && ebreak =3D=3D 0x00100073 && post =3D=3D=
 0x40705013) {
>          generate_exception(ctx, RISCV_EXCP_SEMIHOST);
>      } else {
> +        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
> +                      offsetof(CPURISCVState, badaddr));
>          generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
>      }
>      return true;
> --
> 2.44.0
>
>

