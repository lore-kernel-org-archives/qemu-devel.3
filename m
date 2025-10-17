Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC88CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 01:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Yrk-0003pw-TN; Thu, 16 Oct 2025 21:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Yrg-0003o1-ER
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:02:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Yrd-0003p7-21
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:02:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so2088950a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760662954; x=1761267754; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0t9muif2WopM5fct75KptOIB9KckBQUn9vfuaUZz48=;
 b=PwWErTXMYES73g0NHSvR8eJ/YowWEitZXSzoyaAXUMcRzjtKXKxaWzxTrhd2JYJKaY
 zKMdXkgQDBzaec17Vg7/vc/mq0exmM1YJHrJEzAQWEXydz8+ATbbN9nf4Ry3ML17sT+P
 rloysSa/rLNUgiUxG3tGW7aSscCsbOzQf8qEdSTeKIAHxh8YuNDwk5B2/+CkRfo9gtVS
 tmmjex1G4YD4z+fECmDs+F6YANMFileLd6fqnocGVGrVis7RzqpBGLrgEwUoqyLuvcNb
 5N9yOcFbbG4Qv/iP5w8zk4ClA6Ickm5+u1BaE+2Mj3sJWh//7UgpnoJR9MQAGHVpYxPN
 /hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760662954; x=1761267754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0t9muif2WopM5fct75KptOIB9KckBQUn9vfuaUZz48=;
 b=cFO3Wo47XqWTiK/TcUzLKqxvMjCa7uhrc1Yu6y6zeB0ac0fLb4v93XrAk58tHT6ajj
 B8iSgWMBUfbMvhXN/5pFZDBd9rafzdDxZnqlWu/3y2LRDsqs3YH2/GZaWxE1B9fvdEuq
 1KPStWJrGWriqVSVuLf+qph9DVTSmwb80BlXKlDQmpRe3o7iluOI/OarQMeDTPR4Ruba
 lT3HV/nu9Owcn6yvKDn6KxOFD1wgvid69XAiTFHNm+qZdFPtb0j+S9hmkyz1jdn7Cwil
 8EtXD9LJem7/NxJBdtbSkzdnC2GquRgCBcxO3/9m7BfBwUiDFWIjoU6rJX505EtUJfWc
 T9Ow==
X-Gm-Message-State: AOJu0YzqH+Ek/Z6KUfddRHyYj9YxzEjjXkKEOAKPiEJEKkBkSojlQPzW
 IFvbkD0ifQ36Aw/BqRAodWRhmqvPviyScMAue3OkbBUJGgO8HAeFB49llsXb72Z3kf+ZLZBz9Y/
 E/UD/WNtR4MuD7zHe8MTRZ+yyqx2v79c=
X-Gm-Gg: ASbGnctVfaaHLFahV8AJWPXtKHwbWabeJsJEQOJ8HZybQol5fFCJz0uHo2iup77HrH0
 qUWN4SRexqFTuQkld8eAjc0rNDKbxK/I3Jd27KUD1JGXxgXduQpDcv2eKgcbn8pLsZPv0+fkyck
 n/kSid+dp9vTIJmSzPlqIb9HHK4P1nQtIwHNuwlNi6I+iZ4gBnVXOhkHAiHdateD89arE6XyDOp
 Tc6dgJX88WtWv9tbzsVjCQ7eRTwFgsfIOyEcN49Xk0ngMjOPr9MlrXlqW2DJdCvJNwbiNeQ7dJi
 2RI1iIW2D55CZY5qerjSCAm3Xg==
X-Google-Smtp-Source: AGHT+IHm3ISZs/lOQWyCylMW/XaLwh4tbzXQRsnFv12FN3jnNyACbkRn9EUMPLmwK5jG+TrIp+zohhZYlzVXRRTq3kc=
X-Received: by 2002:a05:6402:278a:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-63c1f6e513fmr1558549a12.25.1760662953597; Thu, 16 Oct 2025
 18:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251014082338.87618-1-jay.chang@sifive.com>
 <20251014082338.87618-3-jay.chang@sifive.com>
In-Reply-To: <20251014082338.87618-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 11:02:07 +1000
X-Gm-Features: AS18NWC_JXI1L1otc_4APNPuzEmAwGwafBmAVpmGcAemowgcFhUfm9p59fsGH8Q
Message-ID: <CAKmqyKOxwPbJSimJH+Qx+aXP1dunQwamCWaObWMXfgA6+UJuqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/riscv: Make PMP CSRs conform to WARL
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
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, Oct 14, 2025 at 6:25=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
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
> ---
>  target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 72f1372a49..a15265c8d2 100644
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
> +            prev_addr &=3D ~((1UL << g) - 1UL);
> +            this_addr &=3D ~((1UL << g) - 1UL);
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
> +                val &=3D ~((1UL << g) - 1UL);
> +            }
> +            break;
> +        case PMP_AMATCH_NAPOT:
> +            /* Bit [g-2:0] read all one */
> +            if (g >=3D 2 && g < TARGET_LONG_BITS) {
> +                val |=3D ((1UL << (g - 1)) - 1UL);
> +            }

ULL instead of UL?

Also should we just ensure a valid value is written? Instead of
writing something invalid and then masking the read

Alistair

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

