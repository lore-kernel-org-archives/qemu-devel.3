Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC8DCE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 00:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smMrE-00007z-IN; Thu, 05 Sep 2024 20:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMr7-000068-H6; Thu, 05 Sep 2024 20:29:42 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMr5-0001ob-TQ; Thu, 05 Sep 2024 20:29:41 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-500fcf0b32fso406392e0c.1; 
 Thu, 05 Sep 2024 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725582577; x=1726187377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7vAtmon/mL88bSIJ+XyyXpK/UiBVfFfyxQejcp03sA=;
 b=DrayNzFJZZJdtd8aEiNZfateF4d4h1+AwqOS9ZtSggqYetmrexBrrfm4Q0OTHH6kgD
 neN98kXsfcFXxj+RBZrAlVKgE1JSSQi2oOMHfZoM9+0C100DXQCOmkhAMvrbCtuJg7DP
 MsN+vmioh2m3nS73hhVIp8zRvqC/7h4DOi/mFcIPYxlfzjtU8/zgQLWQPRXw3YDvd2KT
 F9kRFdFEX8FEf8D+9NWwNgKKar4TiRnnGRgmmZ1lnTOIyZB+rrwelTO9QSmNZFhgVreV
 LnwVu5T9HCp1AzBvnGnR78T+eZtW40rNag1IChtlIcKmJJrXK1fl0aY34cohmWW4CbCJ
 qMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725582577; x=1726187377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7vAtmon/mL88bSIJ+XyyXpK/UiBVfFfyxQejcp03sA=;
 b=AmO/FHvKMtp76um7hh6FX/QzTh6ZTozdODmN2/xVGtmC7/wMNvaNcCCoXNTLsd//BT
 73NHULc08hP7A1syB7cNoDoNHX8VGjCmtyWyKqj0qVYET3c5kZsLiIy313HIERJOld5v
 /mtiCi0Ywn+Kiv9CSDQFkE5OqGTOhpoQ4vzPYsDceb8t+vL+RU5YVH7eixdw3BJ9qt1R
 pzKKFqgVCtoIjBh9cqnWib0RV3z2lC/tDzObFm6YUcWa0YUrpcbRdIYDuskeTUcdF9Zg
 cesyBBiGw3pa5uvMifdZsx1Fw6ti+6s5ZUZ4kVJhofHsc8/OEVNL7MrQMdpocAZAC1Dm
 YRhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYt8TouSXAZP4UgyhaRK8x8kcLK8KP9Uim9xaJLDN2/aMc8nOJ27f6a/7A3p/UH5v/2rEx2Xsour8C@nongnu.org
X-Gm-Message-State: AOJu0Yyb00XMlvADEZHJkFwocjiL8I9/S677aB8ioxDwx0cGyBaRqFYV
 Gh1hafVl8A+bsAK2A/qk9Zlk110SlYudrWfAMplm0QtJRlCPOpt7kUTNB7BzIhdzqgr8ESqcXEg
 pYZi+BG6m4UvHznaFIEqWeOsJCTk=
X-Google-Smtp-Source: AGHT+IG9FdAr4kPRL+7odJr26vCQ9oMmD2EQZvaprkcUUCwd/x5TvUyVLWJkj2qegZixUKM3Pinl92UJEJvYU2Ix44I=
X-Received: by 2002:a05:6122:3295:b0:4fe:bce9:8f4f with SMTP id
 71dfb90a1353d-502143c98a9mr918973e0c.9.1725582577095; Thu, 05 Sep 2024
 17:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240826024657.262553-1-alvinga@andestech.com>
 <20240826024657.262553-3-alvinga@andestech.com>
In-Reply-To: <20240826024657.262553-3-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 10:29:11 +1000
Message-ID: <CAKmqyKOV=Acs4M0Yo-kQCJkJci7rZkgMb7nUe8Bxfvmry_gc+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/riscv: Add textra matching condition for
 the triggers
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 26, 2024 at 12:48=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:

Your From is still wrong

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
> ---
>  target/riscv/debug.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/debug.h |  3 +++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index d6b4a06144..c79b51af30 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -364,11 +364,54 @@ static bool trigger_priv_match(CPURISCVState *env, =
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

Shouldn't this be false?

Alistair

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
> +        /* Match if the low bits of mcontext/hcontext equal mhvalue. */
> +        if (mhvalue !=3D env->mcontext) {
> +            return false;
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

