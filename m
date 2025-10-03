Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA712CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 00:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4TKU-0000rs-P1; Thu, 02 Oct 2025 20:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4TKR-0000qv-4z
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 20:07:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4TKJ-0000wZ-Id
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 20:07:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-62fc89cd68bso2960071a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759450023; x=1760054823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EG7EheDey1Z3Dli+TuosVHpYmaDZ9Ip0c3fvUIYV72w=;
 b=hLMtZlA9RgkWRIJjMXC8cqq4y+113TV2OUHdzK8BCQSJ/KVhiI98AT38itZPQeH7Ts
 U5sqey8jcUhgfrIvyHrT8LQUjzJehmBqJTtDBP+kSyQkpodnDc2oInJM3DEebV7+//HL
 418aMIdk09onabqmLp2IAF0dzfQ0xiKWJzR4Xl0mRyrKPFMjQQKxSt8bRKQuV1Ktxapy
 ThCgiAOmnXJKvIV1EuH43KPW1lmwCPzyip4vCaZfJzW8OlPA8e2AZWncpKCsdRQdsMSF
 ZkUi8RPLyPLMoi9CvZsqS11XqaqPljdny5XY0yXKmumQOuo/gV6/Vwpj5mjwDftttstl
 NU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759450023; x=1760054823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG7EheDey1Z3Dli+TuosVHpYmaDZ9Ip0c3fvUIYV72w=;
 b=RfiCGFUV46xNjd97Blz550IDLxU51fz+42eIKdGtvNQK84T8M8dIhrid1sO7UyCU7h
 U+m4U9aqpdWNOqo3FMzndN0gOm6DYS04MbeOPNwqYmpeYuwU6Q0yaRXvPy8e3KngvH6a
 YnW2t5LivIhFhWcvcV5ex5+NBiojcL4J3mBp8TW4haNW1U5n5q7+tO0QI6zGekSU3Yb6
 REeP6vcZhQUw5cMZlLoAKuXezjU5j9HXNndpZO1jyZWsEGIkO7ii2kztIyy+8vX2xiI+
 5X0LEfhupCIpCAjKnulw+k58OKeZc60V+hpr6f2H8MnmZNv8MeKJr08eMkp5s9mTvRNq
 0awg==
X-Gm-Message-State: AOJu0YwWIGlT/fmfWK+twf9J88fkEwep01kXLuvKQDqihEOWnURKAvHC
 v1OxqXdhTghYfY5YdWxe9uh6+ot3+GhohdsdeANZs1TRiPzI+GlsB9EUAv8QYsj33G2fDbQODTE
 2UjFdVesC2E3hamBgJxsE2GNnDNTOZyQ=
X-Gm-Gg: ASbGnctMrfrSQDf2g62s6ZQhAnTWTELr0+1/NWp5hQxKvq7jM6iAWf21Y5WZlGnugKF
 t6Zq53A4WEHHwymmrFsn9Dxar6CvzychqoXWevPEf/cZ1beGi97+xpfUYszWSQgEKNAmzNg+5xI
 H5xqt23pmtNE0KoK6ZyH1waYwU1vadQ9SHTneXS5ycxMhQ/0EUF8o3SVnlr9mOwQvuPvV8tNUR3
 tYaDmPBgHI+v14S/cjgLnG6Wg+Xh6eog+RoX30IPFJyqC5RABq9gsQVKUD2eg==
X-Google-Smtp-Source: AGHT+IFaQYI+jstoeZ/i6XO0bcR75r7kDwn+MXK9w0p26QqK67r99LJMbOZLie6ctKgxtujfdUZzBAR1yTlPZX2qMqY=
X-Received: by 2002:a17:907:1c8c:b0:b47:d628:f002 with SMTP id
 a640c23a62f3a-b49c1275feamr143459366b.13.1759450022525; Thu, 02 Oct 2025
 17:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-8-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-8-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 10:06:36 +1000
X-Gm-Features: AS18NWAKHnjrsqYgG11Cn-ED06YxsiBgnRNiqrxBiAnBCq8qEOs22IxkwM5NwMg
Message-ID: <CAKmqyKOc5GDBthAdLKURL9u70+Q3B5oF1QMLmUstAD97ke724w@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] target/riscv: Combine minstretcfg and
 minstretcfgh
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Wed, Oct 1, 2025 at 5:31=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the privileged specification,
> minstretcfg is a 64-bit register and minstretcfgh refers to the top
> 32 bits of this register when XLEN =3D=3D 32.  No real advantage is
> gained by keeping them separate, and combining them allows for slight
> simplification.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  3 +--
>  target/riscv/csr.c | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 60f7611c00..d8f0818b08 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -420,8 +420,7 @@ struct CPUArchState {
>
>      /* PMU cycle & instret privilege mode filtering */
>      uint64_t mcyclecfg;
> -    target_ulong minstretcfg;
> -    target_ulong minstretcfgh;
> +    uint64_t minstretcfg;
>
>      /* PMU counter state */
>      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 77d0bd7bca..83f6526723 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1115,7 +1115,8 @@ static RISCVException write_mcyclecfgh(CPURISCVStat=
e *env, int csrno,
>  static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>  {
> -    *val =3D env->minstretcfg;
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +    *val =3D extract64(env->minstretcfg, 0, rv32 ? 32 : 64);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1142,7 +1143,7 @@ static RISCVException write_minstretcfg(CPURISCVSta=
te *env, int csrno,
>  static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
>                                          target_ulong *val)
>  {
> -    *val =3D env->minstretcfgh;
> +    *val =3D extract64(env->minstretcfg, 32, 32);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1159,7 +1160,8 @@ static RISCVException write_minstretcfgh(CPURISCVSt=
ate *env, int csrno,
>      inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
>                         riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH=
 : 0;
>
> -    env->minstretcfgh =3D val & inh_avail_mask;
> +    env->minstretcfg =3D deposit64(env->minstretcfg, 32, 32,
> +                                 val & inh_avail_mask);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -1249,8 +1251,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counter=
s_val(CPURISCVState *env,
>      if (counter_idx =3D=3D 0) {
>          cfg_val =3D env->mcyclecfg;
>      } else if (counter_idx =3D=3D 2) {
> -        cfg_val =3D rv32 ? ((uint64_t)env->minstretcfgh << 32) :
> -                  env->minstretcfg;
> +        cfg_val =3D env->minstretcfg;
>      } else {
>          cfg_val =3D env->mhpmevent_val[counter_idx];
>          cfg_val &=3D MHPMEVENT_FILTER_MASK;
> @@ -1572,12 +1573,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, in=
t cfg_index, target_ulong *val,
>          }
>          break;
>      case 2:          /* INSTRETCFGH */
> +        cfgh =3D extract64(env->minstretcfg, 32, 32);
>          if (wr_mask) {
>              wr_mask &=3D ~MINSTRETCFGH_BIT_MINH;
> -            env->minstretcfgh =3D (new_val & wr_mask) |
> -                                (env->minstretcfgh & ~wr_mask);
> +            cfgh =3D (new_val & wr_mask) | (cfgh & ~wr_mask);
> +            env->minstretcfg =3D deposit64(env->minstretcfg, 32, 32, cfg=
h);
>          } else {
> -            *val =3D env->minstretcfgh;
> +            *val =3D cfgh;
>          }
>          break;
>      default:
> --
> 2.51.0
>
>

