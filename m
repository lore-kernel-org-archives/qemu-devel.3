Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5885ECCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBkhY-0001Tu-I7; Wed, 22 Oct 2025 22:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBkhW-0001TD-0d
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:05:14 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBkhT-0001XQ-7z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:05:13 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c21467e5bso418257a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761185109; x=1761789909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sINXYw/yCEXZngIt0YFRvegA1R9R/CUvv30xEkfEXPU=;
 b=kzluCafN3T6Ouqnm1wdddGdz+vjqsgDgueJIfsIGrkGYU4yLxKecJgVlUSuP/+uzRU
 CbLiX8umCfCAs0rB3GKUnnxexlDmV45K4VDXlctXy/6A2vVZRoLpdm/eouYs3rk3QjE6
 +bFSuiIa91fughy6YwnF5twq2rEG8vEusaVvHBSrQZB4MgFV2m9+bkUKXvz8IhU8tY/+
 cfFQR6DaWvjIWv6tx5oZGwmZ7bCvnpi4lerCDlAalTXfPd3M5JDnyOYBh0AdUjT1NdN2
 apOIJHHFcHTKj0Z1QWSjHmTA3hY7c5p6Zwmmq9gRKpKbe28PFTPfyNh4yb8wizhWk0du
 yl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761185109; x=1761789909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sINXYw/yCEXZngIt0YFRvegA1R9R/CUvv30xEkfEXPU=;
 b=pZEinN1UZHLB8wArEPJugmuo1+NpDAhk/9O8O1DAB3mX9uXEb3n6agkGhbgL3GzRH8
 Kfpq72x0jRuOZ7Ve6+mSnzWGafOj6zGyrAF0xNWWfoCjCY81Lq5I0lgogSFQU0pX1vHo
 OIv3IPnEqAZEIPE/GhY9udqEQyqDerzd5VYGr/ZRSfpkGwTjUjrTLLntx4h5LJkFIva+
 bkUcFiTcexiUqFxmU+gZBQIwdMT187bjrsr/L4fPFhc2rFbAERtY6e5F1J1wKHSb8+yZ
 kYFaKkFtr/IBOWV/ZQrxXZhslv3rSoxxPiJXt9sbFBz+bQjuxEomKnI++lW5hpVdg/I9
 eZzg==
X-Gm-Message-State: AOJu0Yyfx07llm71tWIl6ctKItqB8VxgBBGjtVnr1TMCukmvSuTiXafd
 QodHTkNNp2nWWL+ncbjlS8lDI/4aOy6cx8xd0KXF9hbsdXgRRGuXu1KkCwweazW0HEcfSOq7TwS
 DsVxUCWIBA0h8VEg6IWRQ3qexHfNDvso=
X-Gm-Gg: ASbGnctYboRx7QuGVPwGqJG4pqdiLsMA4k9uZrim0SCSsLAKuyk2ICIGpSXPcwj3Vcu
 cz7LTjxXENxrFX1jr5kA0+SUB6El1zuEKAPp6Gn7O3KRggYY4ih1y1jKnswvJCdj463IIF0RMtL
 Y+ZuTmZ0jOWtfau/GPzX1oRej8mg4ddBsvdKuTQX371IJP8mwGXBbIa1ZEUuwFybZHq2TtsRSrc
 7Y/vI9T7U0Fqz0VN2awkBiUwXianmBuNsxUWzmgL1IB8ySbzxMWG2Q63nvY1WvurxQea9qntu+o
 E/budo8kafbwuXd/kV40eUnwIA==
X-Google-Smtp-Source: AGHT+IHgtpSxfyftl6n4gfZKHK/LsJmFKgSRdHs1dTHnO+NM9AqFm/lkq9JMIpQcglCUIYpnFeSkwfmRc4wO/xxArZw=
X-Received: by 2002:a05:6402:2345:b0:63e:ce0:f0ff with SMTP id
 4fb4d7f45d1cf-63e0ce0f3c2mr6970098a12.24.1761185108805; Wed, 22 Oct 2025
 19:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251022024141.42178-1-jay.chang@sifive.com>
 <20251022024141.42178-3-jay.chang@sifive.com>
In-Reply-To: <20251022024141.42178-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 12:04:42 +1000
X-Gm-Features: AS18NWAIpw8b_KjfPn5uuWaCUTQyaA79w6phVU9lBsgwBiZb6H3vn1SV7vYUb-Q
Message-ID: <CAKmqyKMa6bJeFV2YuqkDmr=j-cF7pDSLPscGuH_Xpuoz4DTAgQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: Make PMP CSRs conform to WARL
 constraints
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Oct 22, 2025 at 12:43=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> This patch ensure pmpcfg and pmpaddr comply with WARL constraints.
>
> When the PMP granularity is greater than 4 bytes, NA4 mode is not valid
> per the spec and will be silently ignored.
>
> According to the spec, changing pmpcfg.A only affects the "read" value
> of pmpaddr. When G > 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] read
> as all ones. When G > 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-1:0]
> read as all zeros. This allows software to read back the correct
> granularity value.
>
> In addition, when updating the PMP address rule in TOR mode,
> the start and end addresses of the PMP region should be aligned
> to the PMP granularity. (The current SPEC only state in TOR mode
> that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.)
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 72f1372a49..3ef62d26ad 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVState *=
env, uint8_t val)
>          g_assert_not_reached();
>      }
>  }
> +/*
> + * Calculate PMP granularity value 'g'
> + *
> + * The granularity value 'g' is defined as log2(granularity) - 2, where
> + * granularity is the minimum alignment requirement for PMP regions in b=
ytes.
> + */
> +static inline int pmp_get_granularity_g(CPURISCVState *env)
> +{
> +    return __builtin_ctz(riscv_cpu_cfg(env)->pmp_granularity >> 2);
> +}
> +
>
>  /*
>   * Count the number of active rules.
> @@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32=
_t pmp_index, uint8_t val)
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "ignoring pmpcfg write - invalid\n");
>          } else {
> +            uint8_t a_field =3D pmp_get_a_field(val);
> +            /*
> +             * When granularity g >=3D 1 (i.e., granularity > 4 bytes),
> +             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> +             */
> +            if ((riscv_cpu_cfg(env)->pmp_granularity >
> +                MIN_RISCV_PMP_GRANULARITY) && (a_field =3D=3D PMP_AMATCH=
_NA4)) {
> +                    return false;
> +            }
>              env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
>              pmp_update_rule_addr(env, pmp_index);
>              return true;
> @@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_=
t pmp_index)
>      target_ulong prev_addr =3D 0u;
>      hwaddr sa =3D 0u;
>      hwaddr ea =3D 0u;
> +    int g =3D pmp_get_granularity_g(env);
>
>      if (pmp_index >=3D 1u) {
>          prev_addr =3D env->pmp_state.pmp[pmp_index - 1].addr_reg;
> @@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32=
_t pmp_index)
>          break;
>
>      case PMP_AMATCH_TOR:
> +        /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching lo=
gic. */
> +        if (g >=3D 1) {
> +            prev_addr &=3D ~((1ULL << g) - 1ULL);
> +            this_addr &=3D ~((1ULL << g) - 1ULL);
> +        }
>          if (prev_addr >=3D this_addr) {
>              sa =3D ea =3D 0u;
>              break;
> @@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>
>  /*
>   * Handle a read from a pmpaddr CSR
> + * Change A field of pmpcfg affects the read value of pmpaddr
>   */
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>  {
> @@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, ui=
nt32_t addr_index)
>
>      if (addr_index < pmp_regions) {
>          val =3D env->pmp_state.pmp[addr_index].addr_reg;
> +        int g =3D pmp_get_granularity_g(env);
> +        switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg))=
 {
> +        case PMP_AMATCH_OFF:
> +            /* fallthrough */
> +        case PMP_AMATCH_TOR:
> +            /* Bit [g-1:0] read all zero */
> +            if (g >=3D 1 && g < TARGET_LONG_BITS) {
> +                val &=3D ~((1ULL << g) - 1ULL);
> +            }
> +            break;
> +        case PMP_AMATCH_NAPOT:
> +            /* Bit [g-2:0] read all one */
> +            if (g >=3D 2 && g < TARGET_LONG_BITS) {
> +                val |=3D ((1ULL << (g - 1)) - 1ULL);
> +            }
> +            break;
> +        default:
> +            break;
> +        }
>          trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>      } else {
>          qemu_log_mask(LOG_GUEST_ERROR,
> --
> 2.48.1
>
>

