Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4117C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9F2-0005qT-At; Mon, 05 Aug 2024 21:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9Ey-0005m8-Oe; Mon, 05 Aug 2024 21:43:56 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9Ex-0001al-6V; Mon, 05 Aug 2024 21:43:56 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f511fddfcfso74111e0c.1; 
 Mon, 05 Aug 2024 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722908633; x=1723513433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCwzNUW0nurawMOKiZZKC6UZQNPF2S+QndNXRnACaAg=;
 b=lHpjQQqHzXQWPmPAoSsqt6n2KtoimZYloXUw/CKT2B9Vtk7QZrXbnDqqXVjwk7Ul2j
 17vU0zYjutWiLx60jwMNC7RG7PoQZobPZ3niP3Vac5/eDHBqhrD0CotWlk8O0KV4XKIV
 MBHh9ZMlIydq/K9bKoWl4o+fJzjZdVV47WeO2peooKNKr8rg2gqyN/Dc560Enu/yb8+D
 ITFWcFLtbwrAEsB9BQpOHoS8zRA7mF1w9ngNu4e+kdxF7bBkDoHOssQOfBgpZAZmJOkq
 zYzgb2E+hq/eG7oaCq6EiFOUUeZl2jpjaRQpZdtseaMirWk0WnKUkQVPgTtSBrX5jIE7
 rQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722908633; x=1723513433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCwzNUW0nurawMOKiZZKC6UZQNPF2S+QndNXRnACaAg=;
 b=hkxycumh4MM2Wvg894kn9YmzoQlqzr8O/zQVDonZAKDbDCBxxNrPsLa4iFGmZ3+PgP
 QupyRpQ0daV5M4V0J1VACboz36NaZ4cUBX86Zq8ZaMjt8cu2qmqpT5sFcGH2jqiQtFTd
 YeP9X33ficwvjWaF/ecVr3+Y8IDftOHr8gmyHXiXcrZdUvDNuTECjaTGCME/dpeGL1wh
 eqJI08Ao7+b8Ard6hXHGSQgApAabbxZs7lTB/dnNIAmTOp541C9ee83F+t4s89ameRI4
 hf/qEkRh+luz1HRlq3dSGyaMGLe+t0LU3lMrd1N1Q1pgd+IKOBtj+PPZmpBvIOCGt7cS
 yvIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNNNi0uG3hDmKorLDk5LEe7t22N//KqpxzSQc8S8fgOWX/5Vk3HD8Ofbcm9B36VrkInrntckn3lVokQQMw/IzVG8QHpFw=
X-Gm-Message-State: AOJu0Yy8YXj9yq/+U5ch6Aa13Yx5iHS08sBj+9lb2W+ffcwhMmIQWG/f
 FjjI3D0wadh3bvGE9mp8QVGO1O0BcthJbbUUcH89k5C1MoPl2BcgMjq5ZDnBkpyQ6TS8L1M0dyA
 l1Zo/U61lqYhQJoEHWgsIsqCYI48=
X-Google-Smtp-Source: AGHT+IFkOVpmv8stvAMOFtZHCazbhkbnrVClim1424hK3u2KPP3oeFfHui7QmuVAfJG0gPbi/ortNZeU2GaqHPaZwr4=
X-Received: by 2002:a05:6122:2514:b0:4f5:26c6:bf13 with SMTP id
 71dfb90a1353d-4f8a0024024mr16445498e0c.13.1722908633330; Mon, 05 Aug 2024
 18:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-9-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-9-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 11:43:27 +1000
Message-ID: <CAKmqyKPue5+OyJ4uJJzr6ZwzpNhzzTLZGWcMd+WqDyW+3vAf_g@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] target/riscv: Invoke pmu init after feature
 enable
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, Jul 24, 2024 at 9:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The dependant ISA features are enabled at the end of cpu_realize
> in finalize_features. Thus, PMU init should be invoked after that
> only. Move the init invocation to riscv_tcg_cpu_finalize_features.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b8814ab753bd..d78d5960cf30 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -898,6 +898,20 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, =
Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.pmu_mask) {
> +        riscv_pmu_init(cpu, &local_err);
> +        if (local_err !=3D NULL) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +
> +        if (cpu->cfg.ext_sscofpmf) {
> +            cpu->pmu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          riscv_pmu_timer_cb, cpu);
> +        }
> +    }
> +#endif
>  }
>
>  void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
> @@ -945,7 +959,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error=
 **errp)
>
>  #ifndef CONFIG_USER_ONLY
>      CPURISCVState *env =3D &cpu->env;
> -    Error *local_err =3D NULL;
>
>      tcg_cflags_set(CPU(cs), CF_PCREL);
>
> @@ -953,19 +966,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Erro=
r **errp)
>          riscv_timer_init(cpu);
>      }
>
> -    if (cpu->cfg.pmu_mask) {
> -        riscv_pmu_init(cpu, &local_err);
> -        if (local_err !=3D NULL) {
> -            error_propagate(errp, local_err);
> -            return false;
> -        }
> -
> -        if (cpu->cfg.ext_sscofpmf) {
> -            cpu->pmu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                          riscv_pmu_timer_cb, cpu);
> -        }
> -    }
> -
>      /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. *=
/
>      if (riscv_has_ext(env, RVH)) {
>          env->mideleg =3D MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
>
> --
> 2.34.1
>
>

