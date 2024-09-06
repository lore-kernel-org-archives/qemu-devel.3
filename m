Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB11C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRH1-0006Wy-Dq; Fri, 06 Sep 2024 01:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRGx-0006TG-Nq; Fri, 06 Sep 2024 01:12:40 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRGv-00062P-6S; Fri, 06 Sep 2024 01:12:39 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5012813249cso187518e0c.2; 
 Thu, 05 Sep 2024 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725599555; x=1726204355; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvobpZjYdbP5kgF4yeyYGDFFkpbWjXaWkzhNPyHJJUo=;
 b=XN/SaYyIp15y+9fBwbZrZFGuBUO4jyz9EORbpkeat68PtPCw2xpSYBULXKk4Ch41Uj
 z9rl6OA1spEDG1QC9HtlIBzgQdE3jSl34WrVSpCkDNuk2Dw0pjDHkmeBwDD59B4Bnk7K
 eUUceGnziGAmk8v0jMnlxX5sMzIVwc74nxG+8dQE2RlbquvBN0hU03wlC38GiQ3qE1ZA
 NnK8+qiPZ1Af9Zswf644OE3nd/FhDcoZtNyW69GOfkC5Zfk70/ueCLM8wlMh5NeuHc34
 2aiOs1apUCaBSyEeGGv65f3icNwfTweOFfew6/lIuxxUhF4Akc8tW+Y1621NRqts+9aN
 1X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725599555; x=1726204355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvobpZjYdbP5kgF4yeyYGDFFkpbWjXaWkzhNPyHJJUo=;
 b=MVpmqoALl1iGFPJIFXVoBD2/dIQ2ng0xjFKiY3Imn3sA7fbrhcueJC5kNX7ieq8dlG
 KPryCWKkMc6g0EKSDryd7QUAizG65mRDIn+H85QYjJXW+MpYjtAYpNiXgsTFkc/CvbAP
 rNqtBt+ABneKELLEVAgl5mCL++YNFu20PyPWHVbdTGkwE1YU7TXSjEXtuwKMq+0pWn2G
 CDoo0DXfgdRuw7+oTtFUs9zOqVX5AalFHF+iRa+IEQ8K1gA/Z8rWq9RysWmd0QlkHRJe
 UyCIsofa6JwItOQXxz32L+RP90N1BTIAnitDRWPSEP//LV7QPku4n/LVYvQ/OWhHeq7c
 0neA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHfgjZMu0TofYfjFJAzB+jg99hHm2xyQTcKFj8hGJ7klnsGOlGkEVxcC5gN6CH217ZVuA5QAp4YJWD@nongnu.org
X-Gm-Message-State: AOJu0YzjPlV+f62znKtNQfUI997V0+AdeN/8Zsl7f2Y5+AOl0Fiai/vC
 QEKsjIqf0madIWsbEH9mBqvIOvmJ8ZhSKr1xzIp+BsgE1n6vN6KM+4yfkJP08Bx5irUu1MsSvE+
 vKW6sLbVgSn4lKpIvLIejeWrzRCw=
X-Google-Smtp-Source: AGHT+IEg+cXUjcFnaHuURsJdLNl/o+acPZK8rf0iCL2J7evmvwzKHkzyWccLjhqGkcxTbTeiIIJbP5o4HLIyAKsfygw=
X-Received: by 2002:a05:6122:2016:b0:502:8cca:1313 with SMTP id
 71dfb90a1353d-5028cca14a9mr894581e0c.12.1725599555330; Thu, 05 Sep 2024
 22:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240826024657.262553-1-alvinga@andestech.com>
 <20240826024657.262553-3-alvinga@andestech.com>
In-Reply-To: <20240826024657.262553-3-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 15:12:09 +1000
Message-ID: <CAKmqyKNJhvFt=aLBfOqY=PjTi4oPouTs9vHp7JVP3QEFj6Aoew@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/riscv: Add textra matching condition for
 the triggers
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

