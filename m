Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88AC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpKz-00022C-Bs; Tue, 02 Jul 2024 22:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpKp-0001tT-Ea; Tue, 02 Jul 2024 22:03:05 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpKm-0008IJ-Hg; Tue, 02 Jul 2024 22:03:03 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-446427c5923so1229711cf.0; 
 Tue, 02 Jul 2024 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719972179; x=1720576979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/XKWTOk08Pp5k3MB54gWRXT1YmSd8z1Ae+inYg9n4o=;
 b=GmEL1v1D6E1B2S8+o2iPSXffuNtKTpYUnDN1ArK/DWE1deExCuKGB/K9tk+JJ6VB9T
 +MN1sr7mUWckhYuYsgzsYpTL/KDx+t+TyHlPolfEkjapJbz7ixGg0GtktMtnjUdjshs0
 8ZRhe/+JDgUEoNyrTdtPPv9XbQJAS9azb69FKXeFA6R2XE/KSmLybpoZaXSdY7eEqpLy
 ZFXJ2s2KwsjrAvfxCNOo+WVwt3J2S6S5KW8uZv1zzK9AtLktT0n5qXnGd/P+52gWWMn9
 8S5AobSGzHrTupI+FEKflqpu5XNK+wsk1qi8gIuCokgUiqdLdaGczLdFIifGx8evTO7O
 O/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719972179; x=1720576979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/XKWTOk08Pp5k3MB54gWRXT1YmSd8z1Ae+inYg9n4o=;
 b=PXrLMtMB2zKcMHHeKtYAIlY04lj1+Lk+YE3ocofui/3hQvtHkDMj8/oHzWUajcADse
 s69a6stNo4c7XLEDcVCM4Pd/sWXwV3CuzVJiZwuo4fDrVFzobf1OZNkJDoNN6EyZQp8N
 H+2MdPRnNGFNly2BhZQIZR5e+XJ/LP88rCnhWvM+kzjhOyhXBs2IT0s/LpIKf7dzB1mt
 HCPp7qRHHN3A3ndKQQ/nTTVBxkWI8yPSHUPYVLrwDcBbG3YinYXxu6mQ1P7ey7a2CzMD
 0PZxovU0nQkpRrvHNRFbBeWh+SII/tGq2tpsQo3siqyvwHkzj+4xRCkdmB1VF13WvSnF
 SdxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxe0u6RLki+IPRANJ0Xjf9HTWiNvz7UVGFtT77l9jaXB1ICAzqMTe1G7R3zCV0OJxUEN2FO0EGkfC1Ih4/QIezC0COzRo=
X-Gm-Message-State: AOJu0YwMYCLTaRQ6or8NeYWRYrNwmSDjYoBFuyAb3MbO7bP0dQ5tnjct
 tmo3YmKV3UkOyOF/V9yyTh3qUYsmbsQI4suXD3kZdO2AaWws1axUU7oSz7bKX/xjCILzC9vz6G5
 GDcsHbFjMiYm6j+FwglyJGvc9u2xbNYK5
X-Google-Smtp-Source: AGHT+IF6GUgV/kXvt4ZI0gQpeZY4MoGySH07IambXFNVbR7OPb8qnqdeaGbjYkZPZ0uiXiNKn5y80wIpHbY231mBoas=
X-Received: by 2002:a05:6102:a4e:b0:48f:42a7:2c60 with SMTP id
 ada2fe7eead31-48fdf007718mr202679137.7.1719972158812; Tue, 02 Jul 2024
 19:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-3-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-3-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:02:11 +1000
Message-ID: <CAKmqyKOjmnvmCe9PvhLeowTT-nHz+pdnF4itEfEjh_C8xmiOOg@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x836.google.com
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

On Thu, Jun 27, 2024 at 9:59=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the properties for ISA extension smcntrpmf. Patches
> implementing it will follow.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4760cb2cc17f..ef50130a91e7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -1467,6 +1468,7 @@ const char *riscv_get_misa_ext_description(uint32_t=
 bit)
>  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),

Exposing the config should be at the end of the series. Implement then expo=
se

Alistair

>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fb7eebde523b..b1376beb1dab 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -74,6 +74,7 @@ struct RISCVCPUConfig {
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> +    bool ext_smcntrpmf;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
>
> --
> 2.34.1
>
>

