Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47500C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUk6v-00070D-2E; Fri, 19 Jul 2024 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUk6l-0006xS-92; Fri, 19 Jul 2024 05:40:59 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUk6i-0002ns-SW; Fri, 19 Jul 2024 05:40:58 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4926a6b53adso574301137.3; 
 Fri, 19 Jul 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721382055; x=1721986855; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2Bij+u2g75WBBk/3OPkycO0Nid0NoL+X5Qub91rJ9c=;
 b=VvYfTbKZqhAhSquX3geLYdldfqw7dNbeaFc/3XU0yOqm8UkqRjmH+gOEyYB8/uIHa6
 JtYoJVjFgus/7CMW8HdraDdwejN2c8g81oFvhsmnahLkp7nEsZSt5fzFMQ1/nbW62qdq
 VYpN6I+Nsp1dTSBZt/W/8L6HwGGkWNyw4AsUdIogN0JJ+QfETrmY8BlJ2+6TtNSLc0Md
 6KIgqg3qCnanq7fNClLs941y2HlqsJvXmPjx0+N6Cnz88qRFg/lsW4I2UdJG8/1rJ0wT
 5hr6ZXhEY+k71cji435h5DBgQZEPL258VpmfyqombMJicdkzRnn+58ZH71twna3ka84z
 Z2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721382055; x=1721986855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2Bij+u2g75WBBk/3OPkycO0Nid0NoL+X5Qub91rJ9c=;
 b=R//jyNf346/bCHCpq96qsqPDM5txrGyGNQS/LZJUJAk+RmMCgEoOo22FcpTu0i3nMU
 7Eh30W7VcGxP8Fzz0yGWkWE+jeb3BUnNkDXse2m7ZrOtS0GiBn36MIhqYkksJcf/FCGm
 LjcB3gfY/JCH62I2YSh5uW2q/pBAUREqeX7yaKS34gmvZnEMlELBTjjfI4qGnPDMZGZf
 d2TaHML98e+o57W+7OIde+bpbAWLauDmsgbf+wrgjMustJEjUsy3stgyhhOt9YQc1Bip
 s8y1/qZQ5RFJHN1DMX3YWFuz8mVoVNL8WfZrbbxBziQlQ8/JGTtAa3pbB82EXnn3ol2U
 //Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYDeqT0nKF+L7p6ZLgCB5Ih8zvEBvSbhzCd9Ja1rylpcgJ+Woo/GiBPH2OOL3rF9tQeEpgqFT1X1LG1FbFPpWn9dWT3xI=
X-Gm-Message-State: AOJu0YwLXgFDGsGhuGRzBhJFyZFSiCmtKjxJDdp0BKJBJDfdgROG7SBU
 9Ej20NgXY/90x+DsA6HLNWZ66XZjBmC21hfYtg+Jc63mlXjBrILVvFTANMYVcdwJgUjQyNhxZDf
 6sjUawj1jkUrD1dXy55N4bUkRmdI=
X-Google-Smtp-Source: AGHT+IHxTw8lHWd7KgLkF5UV8NloSVCwTdzkc479vBHE2SGt23jm1oUTOQISYqGS2tjnMTobDF+Zg5/ruIGdlzmcsas=
X-Received: by 2002:a05:6102:5799:b0:48f:d683:f46e with SMTP id
 ada2fe7eead31-4915990dde7mr9026015137.22.1721382054877; Fri, 19 Jul 2024
 02:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240710100010.814934-1-alvinga@andestech.com>
 <20240710100010.814934-2-alvinga@andestech.com>
In-Reply-To: <20240710100010.814934-2-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jul 2024 19:40:28 +1000
Message-ID: <CAKmqyKPPt2o8emeWKYQjYdpw4V652eLfpsaay52ZyMLLgzS=6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Preliminary textra trigger CSR
 writting support
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Wed, Jul 10, 2024 at 8:01=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.=
org> wrote:
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
>  target/riscv/cpu_bits.h | 10 ++++++
>  target/riscv/debug.c    | 75 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 79 insertions(+), 6 deletions(-)
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
> index 0b5099ff9a..139b722a7e 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -217,6 +217,72 @@ static inline void warn_always_zero_bit(target_ulong=
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
> +    if (mhselect !=3D mhselect_new) {
> +        qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\=
n");
> +    }
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

You don't need this, you have already reported on all of the possible
differences

With the above removed

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

