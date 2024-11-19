Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766ACD60D1A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 04:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDFfn-0002Bg-OY; Mon, 18 Nov 2024 23:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDFfm-0002BB-8v; Mon, 18 Nov 2024 23:17:06 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDFfi-0006Zz-GU; Mon, 18 Nov 2024 23:17:05 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-85714347e80so191928241.3; 
 Mon, 18 Nov 2024 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731989820; x=1732594620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+rRvpcDX6DHNcdyedOmuGF8y+bQv5/TxDPGLp2QwOE=;
 b=IVbWsyozz5ruBf/npr/7/j9jasASzlwWNblkcVyg3PN09v0Kdxu+sjw20XgS8+8b7X
 D6T8WGUprQNrfL5Mna+dM3jH3vRZOEMYsXJkiQ38M4rq4HWTrWinz2DE3XK0r2e+wDpZ
 OKsq+w+pHacY1nCoWnVqE4JQQBu0KptVRarkkJ2HZU2m+0D6WCgmIf3eg5Id2PfbwhBh
 qL53pypzLIYsyh8Tcv80hCLQfkNeVOLCHSvKJDnLmJy3o6vfnE1LSx4/OsaTNBKjBR/q
 dc0QHnVJW4Otf/S3P6qwpJ6+evR25FMlYU+DGqCYnxOPpgv2CobQCjLutk1LLb4l016a
 +kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731989820; x=1732594620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+rRvpcDX6DHNcdyedOmuGF8y+bQv5/TxDPGLp2QwOE=;
 b=cvQHtgEdhikV9X6jG2PC6gLSfbINgrqyfWPseysOBcpthTvCCaeuB85CRug5m6dpUQ
 2myIge3gFLdozyySmj+FkdfJVW/fanxcoKnNlYlLycRR3v8sE8oIgU11mrq+lXXKy3vC
 L4tNScJVoZNns1iT/pfo+7izdntTnx+Fh1QKkcRRSvtBPN9SyX2jlGpE6Wt6JsdMUkgH
 DkVJjhNypLjeN5zLmXC8N0Mi3Ka2kokhL4Q//FBY3RBBECYPV+iLmGxXGl5iGWrqeend
 7S6dAUYM+GG5v4a6cSZm3LyCEUMmgX+J/k7i6Q6aA4v5JJmOWVsBfr191wFsbTbkOLH0
 ajJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsn+/nY8ftyu/S5y9IVuxBYyc8ObhVhd1gH1YmtKfzQrEjP9n21G++slh6KXhvp2aSq3qPuMBRvXsX@nongnu.org
X-Gm-Message-State: AOJu0YxpILm2o9C/ZgrBtlpXANqqcQtvVxmfhHf4b7QonMMOcTiGybgl
 q4UUt7rPL4C1EC6ENxf+W+JT3sB00xj1nj03BdKscjxoYg+R75D8WcFFK6/YybSYCwt59in8IgB
 N+Dyb7PJ/wJ461bL9Wan/PQdQJ0Y=
X-Google-Smtp-Source: AGHT+IEqrhMhZ+41+eucD495hZJ5Ed3fgJgm/zcL5CZV21GKxcTTNe6nLUlvOrn+ug1IowV2u+txS4WhLxOqvs9iKbU=
X-Received: by 2002:a05:6102:dc6:b0:4a4:7161:609 with SMTP id
 ada2fe7eead31-4ad6318e521mr13017329137.20.1731989820197; Mon, 18 Nov 2024
 20:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-2-cleger@rivosinc.com>
In-Reply-To: <20241114091332.108811-2-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 14:16:34 +1000
Message-ID: <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Thu, Nov 14, 2024 at 7:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> With the current implementation, if we had the current scenario:
> - set bit x in menvcfg
> - set bit x in henvcfg
> - clear bit x in menvcfg
> then, the internal variable env->henvcfg would still contain bit x due
> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> missing update of henvcfg upon menvcfg update.
> This can lead to some wrong interpretation of the context. In order to
> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
> menvcfg and fix the mask computation used in write_henvcfg() that is
> used to mesk env->menvcfg value (which could still lead to some stale
> bits). The same mechanism is also applied for henvcfgh writing.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b84b436151..73ac4d5449 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *e=
nv, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>  {
> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>      }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *=
env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> +                                    target_ulong val);
>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>  {
> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState =
*env, int csrno,
>      uint64_t valh =3D (uint64_t)val << 32;
>
>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *=
env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENV=
CFG_CBZE;
> +    uint64_t henvcfg_mask =3D mask, menvcfg_mask;
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> @@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCVState=
 *env, int csrno,
>      }
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG=
_ADUE);
> +        /*
> +         * Since henvcfg depends on a menvcfg subset, we want to clear a=
ll the
> +         * menvcfg supported feature (whatever their state is) before en=
abling
> +         * some new one using the provided value. Not doing so would res=
ult in
> +         * keeping stale menvcfg bits in henvcfg value if a bit was enab=
led in
> +         * menvcfg and then disabled before updating henvcfg for instanc=
e.
> +         */
> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> +        mask |=3D env->menvcfg & menvcfg_mask;
> +        henvcfg_mask |=3D menvcfg_mask;
>      }
>
> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> +    /*
> +     * 'henvcfg_mask' contains all supported bits (both in henvcfg and m=
envcfg
> +     * common bits) and 'mask' contains henvcfg exclusive bits as well a=
s
> +     * menvcfg enabled bits only.
> +     */
> +    env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (val & mask);

Won't `env->henvcfg & ~henvcfg_mask` still contain the stale data?
`henvcfg_mask` isn't based on the current value of `env->menvcfg`

Alistair

>
>      return RISCV_EXCP_NONE;
>  }
> @@ -2469,8 +2490,13 @@ static RISCVException read_henvcfgh(CPURISCVState =
*env, int csrno,
>  static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>  {
> -    uint64_t mask =3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +    /*
> +     * Same comment than the one in write_henvcfg() applies here, we wan=
t to
> +     * clear all previous menvcfg bits before enabling some new one to a=
void
> +     * stale menvcfg bits in henvcfg.
> +     */
> +    uint64_t henvcfg_mask =3D (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_AD=
UE);
> +    uint64_t mask =3D env->menvcfg & henvcfg_mask;
>      uint64_t valh =3D (uint64_t)val << 32;
>      RISCVException ret;
>
> @@ -2479,7 +2505,11 @@ static RISCVException write_henvcfgh(CPURISCVState=
 *env, int csrno,
>          return ret;
>      }
>
> -    env->henvcfg =3D (env->henvcfg & ~mask) | (valh & mask);
> +    /*
> +     * 'henvcfg_mask' contains all menvcfg supported bits and 'mask' con=
tains
> +     * menvcfg enabled bits only.
> +     */
> +    env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (valh & mask);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.45.2
>
>

