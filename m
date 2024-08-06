Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AB3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8H0-0004ir-PW; Mon, 05 Aug 2024 20:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8Gy-0004h1-13; Mon, 05 Aug 2024 20:41:56 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8Gw-0002QR-8w; Mon, 05 Aug 2024 20:41:55 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49297ff2594so95203137.1; 
 Mon, 05 Aug 2024 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722904912; x=1723509712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bGtD9j+t3TwRF8skuG4l0WO/UwGRtBBTsFtsq8FWtE=;
 b=OlkG+/tFAworCyjBxCgdKFYj4rgUPcxKsR0DoiJK2uRAaTRDVtVh0FSmJYZdgFdwNX
 ZoCasQLZAkfE5vsJK0U7qXixGscwbXAYxyUbNmJN60F4azvBdcKhjEHxhmEVYlTKqzQA
 lwiTJONK2k8N0L0XxRPyp+eatAsObFKPzQVAGkN9zd5Y4JRCyd2/NmIE/aXoH4eG+uNE
 9qgATYrRN1Fjzd4bdORNEYXg0PM/P78VaZ/pB3V0W4may0b4AmWYkbpzTIIxhiFMN4CD
 iWotUQ3VqYls/ipFjl0W+AMDhxQvU8sGM40H4nw6BwQZwqouNRtYWoyXmlBa1xVKuFAK
 jb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722904912; x=1723509712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bGtD9j+t3TwRF8skuG4l0WO/UwGRtBBTsFtsq8FWtE=;
 b=lHuiw2hujzvdNQz3vbUYadenv88bVqbaNO3Ngfb+Iz8owMOjRfjqIh01e4TJ7XlGxS
 TyxBqVZMzENlBWeSO2ZYex9xj99iXDnS0Q9UZ+emJkmXUuDHiO7SMnSn1+QkycMTyoAh
 8tVZafcyqgQi6NfYYPt7krxP0QuozogRZMNDi/JY8nYwphSFwXAa41/kd9/YkJRHdUES
 3sG8jfaUhpb5T1c6p+VsS/mj31KFdkpTi1zmM8e2UrAE4xHg69yDXSlnDG1qciuqCjxO
 F2q3P2+vCvWvZRreJjmxPNsWa35BO84FaDdoWlqMGfqatUGA6iBNzDWJU0JDiJy4IWPW
 EWcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuuyAWR1fPr8ZDDQgckskmMDXsjJ9CUVa8/gw2no7dG1gkMTCKLGUuTb6woGUIorQ3OpVGMKrU9jFlKVxtlGY1aPqBbKA=
X-Gm-Message-State: AOJu0Yx19NZSv6U6k3qVC+wnitRh7GBU381ijHq7Oz+QBlYZN/BnYAmv
 /ENZ8tae8nHs3GpsoCX9HTe3gSAzjNaoWzod01R0cXiRFfiorGGBH5ZHqV2qn9CGV5o6a0PDReQ
 D09wejQQhCAGr/760GrBXYfm1w5g=
X-Google-Smtp-Source: AGHT+IE1U49BCn2yL2c0Wwk/iMe7UHk9x99Rdtopc1si3TaMrgfUefKIAOuw8/zoW7b3yezT/04Q1oY8GoZTYY1gs0Q=
X-Received: by 2002:a05:6102:442a:b0:48f:49c2:ff77 with SMTP id
 ada2fe7eead31-4945be09c5cmr16258878137.16.1722904912101; Mon, 05 Aug 2024
 17:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-6-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-6-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 10:41:25 +1000
Message-ID: <CAKmqyKOdXCtg=_pfEisgLb2WKZiBYBbXKv_2sk7XXOa9F2Y3jw@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] target/riscv: Add select value range check for
 counter delegation
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Wed, Jul 24, 2024 at 9:31=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds checks in ops performed on xireg and xireg2-xireg6 so that the
> counter delegation function will receive a valid xiselect value with the
> proper extensions enabled.
>
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4ae3931f0ada..da27ba1b7580 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2120,6 +2120,11 @@ static bool xiselect_aia_range(target_ulong isel)
>             (ISELECT_IMSIC_FIRST <=3D isel && isel <=3D ISELECT_IMSIC_LAS=
T);
>  }
>
> +static bool xiselect_cd_range(target_ulong isel)
> +{
> +    return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);
> +}
> +
>  static int rmw_iprio(target_ulong xlen,
>                       target_ulong iselect, uint8_t *iprio,
>                       target_ulong *val, target_ulong new_val,
> @@ -2245,6 +2250,17 @@ done:
>      return RISCV_EXCP_NONE;
>  }
>
> +static int rmw_xireg_cd(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    /* TODO: Implement the functionality later */
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /*
>   * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
>   *
> @@ -2256,7 +2272,25 @@ static int rmw_xireg_csrind(CPURISCVState *env, in=
t csrno,
>                                target_ulong isel, target_ulong *val,
>                                target_ulong new_val, target_ulong wr_mask=
)
>  {
> -    return -EINVAL;
> +    int ret =3D -EINVAL;
> +    bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;
> +
> +    if (xiselect_cd_range(isel)) {
> +        ret =3D rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> +    } else {
> +        /*
> +         * As per the specification, access to unimplented region is und=
efined
> +         * but recommendation is to raise illegal instruction exception.
> +         */
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (ret) {
> +        return (env->virt_enabled && virt) ?
> +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_IN=
ST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
>  }
>
>  static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
>
> --
> 2.34.1
>
>

