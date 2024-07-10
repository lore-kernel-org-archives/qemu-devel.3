Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4730CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRM37-0006ZA-Pb; Tue, 09 Jul 2024 21:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRM36-0006WS-0h; Tue, 09 Jul 2024 21:23:12 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRM33-0008DK-6p; Tue, 09 Jul 2024 21:23:11 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4f30734057bso1320916e0c.1; 
 Tue, 09 Jul 2024 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720574587; x=1721179387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Xrd4p8Y+akYBwheuMphxlpq4Me0VUKha0gDAkc0ivw=;
 b=N2JpRptZ2dlOKrEMV9g8wf7KslqMTX8I7pUKLbuAqf7mAeDmopH7TLR4/FK8cAuV2B
 ojRSR+Py5oJhd1ohJKM2cjPc/J0gDrbeHgtSvTVBTlqMXkL7c1VjQbu6eBrwGVUwAgfH
 2VhR7CiXiMY1NPelNIQbTwqOYy3VLMniT7QdAIyVt8Cio3P+toXgE/BDsU/kljRIBQ9X
 Xkz48NaZE+BNeZVkjIOrarfCEazKHz0WikvU0OWI+I104SAopjSqsGpzcnfV+83XGJuR
 tA+2lPFG8VubYq9+CyRfX2wBhGAZHEPZ2OU5v+5CrK9NrfkwMiHszfQatDtQZ6+6XCO+
 cQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720574587; x=1721179387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Xrd4p8Y+akYBwheuMphxlpq4Me0VUKha0gDAkc0ivw=;
 b=IiAd+yOzqPMJKKldDf0OlC6xw2dEx8z5obgljMcfh9ZPgw2d0oqD+odKS99WsXOrEq
 f5g6N3KlD5OnihfM5aeKYlfKyyJsKddNuZPzH7PHr0AhS3oAMCTAgA7q77VCZYyJ2izF
 OhzMXF3YJ9DaoCE9T5lspEIagGr1n0/cx0CXQPw2v4CA+nfy/Nj26KwPX95o25VvCDrD
 kMbCHTyL9DPIDqH/uU5Jw9RqJ9M0DhPts9b0JM+hO8dnoicjDtEAdwMbmKA3mddpj0mZ
 y/KUrgcHNrSA0bsZdqhlkxdcKR/zpGGQHphjsSqlfwxSbpkbMHwUsUxcQt06MpYtYsdr
 I9Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTcULLgGoqTbrbt6MIAJMqvMmQR5vcZjxfun/K/MrgabYuYdJruqpQB7uUjLKHad92gwdlJFKzwyLxOmMq5KqA6T7jGEg=
X-Gm-Message-State: AOJu0YwZNAu0HxIIC6g6x0/o7U5EL9+jiuDHT8LF1ASh4DAlgKJN1svA
 P74nCjSQpVE2MALnvOLbiQt7Hw/5WeWrMH9gqB5HtWAYNYwxxHlCnJJDxeZ6BRRhzvv8mxvNv+0
 ZBJlP7C3MgDJLuTIqcrqvuBRVt+s=
X-Google-Smtp-Source: AGHT+IEtodRdvzkUhb11+B4xafn/3fqJqIiHNr8kBu7PEOGamvBlUvPNLT0G2Gpxdtb5Z/928jXegvyscZ8OE8Rvm3g=
X-Received: by 2002:a05:6122:8c5:b0:4ec:f8e4:e0bf with SMTP id
 71dfb90a1353d-4f33f1799damr5427188e0c.2.1720574587370; Tue, 09 Jul 2024
 18:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240704040200.243892-1-alvinga@andestech.com>
 <20240704040200.243892-2-alvinga@andestech.com>
In-Reply-To: <20240704040200.243892-2-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 11:22:41 +1000
Message-ID: <CAKmqyKPPUYBY9i5RiusZcs0SdvMqL-27j2kK6xyJEfr21bsNEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Preliminary textra trigger CSR writting
 support
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Thu, Jul 4, 2024 at 2:03=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.o=
rg> wrote:
>
> This commit allows program to write textra trigger CSR for type 2, 3, 6
> triggers. In this preliminary patch, the textra.MHVALUE and the
> textra.MHSELECT fields are allowed to be configured. Other fields, such
> as textra.SBYTEMASK, textra.SVALUE, and textra.SSELECT, are hardwired to
> zero for now.
>
> For textra.MHSELECT field, the only legal values are 0 (ignore) and 4
> (mcontext). Writing 1~3 into textra.MHSELECT will be changed to 0, and
> writing 5~7 into textra.MHSELECT will be changed to 4. This behavior is
> aligned to RISC-V SPIKE simulator.
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>  target/riscv/cpu_bits.h | 10 +++++
>  target/riscv/debug.c    | 81 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 85 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c257c5ed7d..0530b4f9f4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -906,6 +906,16 @@ typedef enum RISCVException {
>  #define JVT_BASE                           (~0x3F)
>
>  /* Debug Sdtrig CSR masks */
> +#define TEXTRA32_MHVALUE                   0xFC000000
> +#define TEXTRA32_MHSELECT                  0x03800000
> +#define TEXTRA32_SBYTEMASK                 0x000C0000
> +#define TEXTRA32_SVALUE                    0x0003FFFC
> +#define TEXTRA32_SSELECT                   0x00000003
> +#define TEXTRA64_MHVALUE                   0xFFF8000000000000ULL
> +#define TEXTRA64_MHSELECT                  0x0007000000000000ULL
> +#define TEXTRA64_SBYTEMASK                 0x000000F000000000ULL
> +#define TEXTRA64_SVALUE                    0x00000003FFFFFFFCULL
> +#define TEXTRA64_SSELECT                   0x0000000000000003ULL
>  #define MCONTEXT32                         0x0000003F
>  #define MCONTEXT64                         0x0000000000001FFFULL
>  #define MCONTEXT32_HCONTEXT                0x0000007F
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 0b5099ff9a..f7d8f5e320 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -217,6 +217,69 @@ static inline void warn_always_zero_bit(target_ulong=
 val, target_ulong mask,
>      }
>  }
>
> +static target_ulong textra_validate(CPURISCVState *env, target_ulong tda=
ta3)
> +{
> +    target_ulong mhvalue, mhselect;
> +    target_ulong mhselect_new;
> +    target_ulong textra;
> +    const uint32_t mhselect_no_rvh[8] =3D { 0, 0, 0, 0, 4, 4, 4, 4 };
> +
> +    switch (riscv_cpu_mxl(env)) {
> +    case MXL_RV32:
> +        mhvalue  =3D get_field(tdata3, TEXTRA32_MHVALUE);
> +        mhselect =3D get_field(tdata3, TEXTRA32_MHSELECT);
> +        /* Validate unimplemented (always zero) bits */
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
> +                             "sbytemask");
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
> +                             "svalue");
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
> +                             "sselect");
> +        break;
> +    case MXL_RV64:
> +    case MXL_RV128:
> +        mhvalue  =3D get_field(tdata3, TEXTRA64_MHVALUE);
> +        mhselect =3D get_field(tdata3, TEXTRA64_MHSELECT);
> +        /* Validate unimplemented (always zero) bits */
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
> +                             "sbytemask");
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
> +                             "svalue");
> +        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
> +                             "sselect");
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* Validate mhselect. */
> +    mhselect_new =3D mhselect_no_rvh[mhselect];

I don't follow, we don't check if the H extension is supported.

The spec states: "mhselect and sselect may only support 0 (ignore)" so
it sounds like we either support non or all of them (but that isn't
clear).

Either way we should at least log that we don't support
mcontext_select and vmid_select if the Hypervisor extension is enabled

> +
> +    /* Write legal values into textra */
> +    textra =3D 0;
> +    switch (riscv_cpu_mxl(env)) {
> +    case MXL_RV32:
> +        textra =3D set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
> +        textra =3D set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
> +        break;
> +    case MXL_RV64:
> +    case MXL_RV128:
> +        textra =3D set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
> +        textra =3D set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (textra !=3D tdata3) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "different value 0x" TARGET_FMT_lx " write to tdat=
a3\n",
> +                      textra);
> +    }
> +
> +    return textra;
> +}
> +
>  static void do_trigger_action(CPURISCVState *env, target_ulong trigger_i=
ndex)
>  {
>      trigger_action_t action =3D get_trigger_action(env, trigger_index);
> @@ -441,8 +504,10 @@ static void type2_reg_write(CPURISCVState *env, targ=
et_ulong index,
>          }
>          break;
>      case TDATA3:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "tdata3 is not supported for type 2 trigger\n");
> +        new_val =3D textra_validate(env, val);
> +        if (new_val !=3D env->tdata3[index]) {
> +            env->tdata3[index] =3D new_val;

You don't need the if() you can just have a single line

env->tdata3[index] =3D textra_validate(env, val);

Alistair

> +        }
>          break;
>      default:
>          g_assert_not_reached();
> @@ -558,8 +623,10 @@ static void type6_reg_write(CPURISCVState *env, targ=
et_ulong index,
>          }
>          break;
>      case TDATA3:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "tdata3 is not supported for type 6 trigger\n");
> +        new_val =3D textra_validate(env, val);
> +        if (new_val !=3D env->tdata3[index]) {
> +            env->tdata3[index] =3D new_val;
> +        }
>          break;
>      default:
>          g_assert_not_reached();
> @@ -741,8 +808,10 @@ static void itrigger_reg_write(CPURISCVState *env, t=
arget_ulong index,
>                        "tdata2 is not supported for icount trigger\n");
>          break;
>      case TDATA3:
> -        qemu_log_mask(LOG_UNIMP,
> -                      "tdata3 is not supported for icount trigger\n");
> +        new_val =3D textra_validate(env, val);
> +        if (new_val !=3D env->tdata3[index]) {
> +            env->tdata3[index] =3D new_val;
> +        }
>          break;
>      default:
>          g_assert_not_reached();
> --
> 2.34.1
>
>

