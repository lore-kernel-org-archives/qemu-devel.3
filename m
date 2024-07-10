Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AE7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRM9z-0004NL-9x; Tue, 09 Jul 2024 21:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRM9x-0004Ls-Pb; Tue, 09 Jul 2024 21:30:17 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRM9q-0001A9-F6; Tue, 09 Jul 2024 21:30:16 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-48ff6336bbbso1480593137.0; 
 Tue, 09 Jul 2024 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720575006; x=1721179806; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkZE740fe9CzYCvcGLC9OJU+e5dQNMZgF78li7LZL0E=;
 b=dhQa5LGp6PyDocxYF88JGvFc+8mC/rYH6Ir500FKLTqQd54T/2O6+MHfbRp26YHfLa
 3580Qw3y1rT+C6HicY1vVrB0DEBTNq26Bzab6Y3HK4liG7u7ysff0h+ztmxhYMNw80GN
 ruoecW1xCEp4mAYTkmM+V9MeQOH8uAHZuxMfY4l12mow0K5NayeWMMaZPWjgRpeoV/jB
 B6SOPVXFyZnspF579zOe+oK0L9RtlqrqGjrCuOWV/aBSaoP8MLFnkurWIjiCxfUBN05C
 G97vPlv8Mzay11g35RDthYqyrGFAA1aEG0CctMS/Eg4aY37JMmQiZ0mc7TkS7EOOYc3h
 MMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720575006; x=1721179806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkZE740fe9CzYCvcGLC9OJU+e5dQNMZgF78li7LZL0E=;
 b=wUJKL6kfMrrLRVsdiMykjFT/ur1GexWCQoTTyifgZP2gSCzpUcKkha/qiWe2twORAL
 GoOVYJ1VaMfjXceck0ty4n+umlrqNDIDRJG9fv6tnWMmnzvT469xBMPlnyIOQnjKtfz6
 bVWEtQcYdDtroYmEalio4drB3wPhmXhv0V2/CIjn3FGDKwzvtcTPThqkbsz7v1bne1BH
 lO4I3OKtaoIcdwFWfweELj6es2m4jWK4nJw2MeZO0425X6ejwhAaHgANBgRGjCkeoy/y
 aHDflSlNPcGKA0b6KyBNsRWlj2u4//xJSn38WThaTnXTB3FjwFqDre4bSZ/OcNBfRHmA
 oGxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQJExNADvzdDsyq99ikDAFl0/kZz0HkBiSN7GzGOVTL5YeUxrcuhqxljrA/KHXP4Y2TOpeFSF/DZ3z8tExkHsfFSWySi0=
X-Gm-Message-State: AOJu0YyK1+kb4ZEhVtGCTE/9SrVZlboHSVYt1v/YFQkgfazQeG/rDv/f
 Pu6SEJxoWnGK2th7q17fOid4XDReJj9ikQu/qYYV3IHxjq6330llCnJLWkqNOYuZ7ZoVDapSUJ4
 Xdt6MD11Xg1x0eyAIWlkRTIY8V4g=
X-Google-Smtp-Source: AGHT+IGGrz6/cNaauMBczSRCQDjCgaVttwnyAvHvxTBRQL/qu5F5oNIoOdRBWUdbLElO0xHdzMPCcgQd+PuHvZzfTHM=
X-Received: by 2002:a05:6102:54a4:b0:48f:df47:a4a5 with SMTP id
 ada2fe7eead31-490321167a1mr4674711137.11.1720575005528; Tue, 09 Jul 2024
 18:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240704040200.243892-1-alvinga@andestech.com>
 <20240704040200.243892-3-alvinga@andestech.com>
In-Reply-To: <20240704040200.243892-3-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 11:29:39 +1000
Message-ID: <CAKmqyKPzjWoP1z-gV==HoGm9eUvK4JM2-Nhtw6uuB-zF8H6NiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Add textra matching condition for the
 triggers
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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
> According to RISC-V Debug specification, the optional textra32 and
> textra64 trigger CSRs can be used to configure additional matching
> conditions for the triggers. For example, if the textra.MHSELECT field
> is set to 4 (mcontext), this trigger will only match or fire if the low
> bits of mcontext/hcontext equal textra.MHVALUE field.
>
> This commit adds the aforementioned matching condition as common trigger
> matching conditions. Currently, the only legal values of textra.MHSELECT
> are 0 (ignore) and 4 (mcontext). When textra.MHSELECT is 0, we pass the
> checking. When textra.MHSELECT is 4, we compare textra.MHVALUE with
> mcontext CSR. The remaining fields, such as textra.SBYTEMASK,
> textra.SVALUE, and textra.SSELECT, are hardwired to zero for now. Thus,
> we skip checking them here.
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/debug.h |  3 +++
>  2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index f7d8f5e320..58dd2f25ae 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -367,11 +367,72 @@ static bool trigger_priv_match(CPURISCVState *env, =
trigger_type_t type,
>      return false;
>  }
>
> +static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type=
,
> +                                 int trigger_index)
> +{
> +    target_ulong textra =3D env->tdata3[trigger_index];
> +    target_ulong mhvalue, mhselect;
> +
> +    if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
> +        /* textra checking is only applicable when type is 2, 3, 4, 5, o=
r 6 */
> +        return true;
> +    }
> +
> +    switch (riscv_cpu_mxl(env)) {
> +    case MXL_RV32:
> +        mhvalue  =3D get_field(textra, TEXTRA32_MHVALUE);
> +        mhselect =3D get_field(textra, TEXTRA32_MHSELECT);
> +        break;
> +    case MXL_RV64:
> +    case MXL_RV128:
> +        mhvalue  =3D get_field(textra, TEXTRA64_MHVALUE);
> +        mhselect =3D get_field(textra, TEXTRA64_MHSELECT);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /* Check mhvalue and mhselect. */
> +    switch (mhselect) {
> +    case MHSELECT_IGNORE:
> +        break;
> +    case MHSELECT_MCONTEXT:
> +        /* Match or fire if the low bits of mcontext/hcontext equal mhva=
lue. */
> +        if (riscv_has_ext(env, RVH)) {
> +            if (mhvalue !=3D env->mcontext) {
> +                return false;
> +            }
> +        } else {
> +            switch (riscv_cpu_mxl(env)) {
> +            case MXL_RV32:
> +                if (mhvalue !=3D (env->mcontext & MCONTEXT32)) {
> +                    return false;
> +                }
> +                break;
> +            case MXL_RV64:
> +            case MXL_RV128:
> +                if (mhvalue !=3D (env->mcontext & MCONTEXT64)) {
> +                    return false;
> +                }
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return true;
> +}
> +
>  /* Common matching conditions for all types of the triggers. */
>  static bool trigger_common_match(CPURISCVState *env, trigger_type_t type=
,
>                                   int trigger_index)
>  {
> -    return trigger_priv_match(env, type, trigger_index);
> +    return trigger_priv_match(env, type, trigger_index) &&
> +           trigger_textra_match(env, type, trigger_index);
>  }
>
>  /* type 2 trigger */
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index c347863578..f76b8f944a 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -131,6 +131,9 @@ enum {
>  #define ITRIGGER_VU           BIT(25)
>  #define ITRIGGER_VS           BIT(26)
>
> +#define MHSELECT_IGNORE       0
> +#define MHSELECT_MCONTEXT     4
> +
>  bool tdata_available(CPURISCVState *env, int tdata_index);
>
>  target_ulong tselect_csr_read(CPURISCVState *env);
> --
> 2.34.1
>
>

