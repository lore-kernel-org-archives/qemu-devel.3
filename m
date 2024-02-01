Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28305C47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 00:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKzg-0006BM-3o; Wed, 31 Jan 2024 19:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKze-0006B8-8Q; Wed, 31 Jan 2024 19:31:50 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKzc-0008BP-IT; Wed, 31 Jan 2024 19:31:50 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-46b0ca27b74so183430137.3; 
 Wed, 31 Jan 2024 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706747506; x=1707352306; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej3CrOAb5pbgtZV45uqiWSOXBE9l8GrGiS152Hc+6uU=;
 b=Y5h6SMiGBNZvAkoHp+yLUBK4ZSDoOtDE71ttypG20aJwYy5rDfIUtVQRTedzbqwKm0
 VWBLlg0C7iqB1cZ3oEmNOSIfncfv5ZSMzqZDdT/5dJx8ZW+h0+NJmXMAzJm1pAEKEEOl
 5xrggNAZ26kepcboIQkyNKjPnmVLFxfL0s5a9+bLv4Ed2DUmDcBd5OJUQDlD3SUTjj+u
 uuPjsp/d5x3kqHQcO9yJcLJbFfP7UbncLiGLdUmycyrj7ZntIcpRgzqVsBdFoJInro2m
 EmOrN5wCaZT3oGMWJAYZOOEJqElKn1uTayx8TWlE4dw1X5/EVulYwsln6KPjbczDP35b
 E5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706747506; x=1707352306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej3CrOAb5pbgtZV45uqiWSOXBE9l8GrGiS152Hc+6uU=;
 b=pB3y0QFB1quINKdu0eMXYaacLHCY1o7ncbcwOsWJo9mlyHySW0c3uRmnZjcK7m4dm4
 PCml7zinQ7QY+6PQofFMtpaP2v8SNKqTxbPdFfNoMsTn/J8MAHFkERPKw1H6jMCM0j8P
 GWZQJAq5+L78vaTfH/+TLWd8G11POG9PscEB2LB0qlRIMOt7VOs8SrZpPpKdsmJxeN/I
 Iq+G/sHwH0I42j0yDMUVlVGu4dhoG865kA3enaA74xbuSZdzXnp24KXdfwjHy3VuTwFp
 6ILw3AWHu/EZ3/g1vL1U6sXXk5xoxP+2iFXWvrulcQAI6zofusUNCTm1MBnFHBTmhPNV
 dxAg==
X-Gm-Message-State: AOJu0YzfmWCutSnh9PlY8VX0H7pIusATPb3VBkauCODO39qMZXuisIsV
 g3icreiyM6IARwOXyx5JdiXdEwQiykYg2bSd/bUB9KF6/PGxdwVq5myIehN/a7e0Bp+54ue+Lc8
 RrQTGmf426dkjX6RCmXxiHAocZB4=
X-Google-Smtp-Source: AGHT+IHVCz+CCl6TCQxf1KeurGCKhXLLBbhxXO/5PU20TgY1HNQCl2+dSPCI4Ko7+XhdqQp1vgiPK3NRwdwPiFFC6FQ=
X-Received: by 2002:a05:6102:374a:b0:46c:eb69:2684 with SMTP id
 u10-20020a056102374a00b0046ceb692684mr693588vst.16.1706747505850; Wed, 31 Jan
 2024 16:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20240129192207.2946870-1-me@deliversmonkey.space>
 <20240129192207.2946870-4-me@deliversmonkey.space>
In-Reply-To: <20240129192207.2946870-4-me@deliversmonkey.space>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 10:31:19 +1000
Message-ID: <CAKmqyKNNcCeuZrcP=2T+0JwFWKynQ+o6_96dwhBdCt-sd4djDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue, Jan 30, 2024 at 5:24=E2=80=AFAM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        |  4 +++
>  target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c9bed5c9fc..1c8979c1c8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -671,6 +671,10 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu,=
 target_ulong vtype)
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags);
>
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm);
> +
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
>                             target_ulong new_value, target_ulong write_ma=
sk);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index a3d477d226..9640e4c2c5 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -139,6 +139,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr =
*pc,
>      *pflags =3D flags;
>  }
>
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> +{
> +    int pmm =3D 0;
> +#ifndef CONFIG_USER_ONLY
> +    int priv_mode =3D cpu_address_mode(env);
> +    /* Get current PMM field */
> +    switch (priv_mode) {
> +    case PRV_M:
> +        pmm =3D riscv_cpu_cfg(env)->ext_smmpm ?
> +                  get_field(env->mseccfg, MSECCFG_PMM) : PMM_FIELD_DISAB=
LED;
> +        break;
> +    case PRV_S:
> +        pmm =3D riscv_cpu_cfg(env)->ext_smnpm ?
> +                  get_field(env->menvcfg, MENVCFG_PMM) : PMM_FIELD_DISAB=
LED;
> +        break;
> +    case PRV_U:
> +        pmm =3D riscv_cpu_cfg(env)->ext_ssnpm ?
> +                  get_field(env->senvcfg, SENVCFG_PMM) : PMM_FIELD_DISAB=
LED;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +    return pmm;
> +}
> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +    bool virt_mem_en =3D false;
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode =3D 0;
> +    int priv_mode =3D cpu_address_mode(env);
> +    /* Get current PMM field */
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +    }
> +    virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D P=
RV_M));
> +#endif
> +    return virt_mem_en;
> +}
> +
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  /*
> --
> 2.34.1
>
>

