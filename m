Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D51C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 01:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXVxk-0005HD-1r; Mon, 13 Jan 2025 20:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXVxi-0005Gt-NJ; Mon, 13 Jan 2025 20:43:22 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tXVxh-000438-46; Mon, 13 Jan 2025 20:43:22 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4b10dd44c8bso1606706137.3; 
 Mon, 13 Jan 2025 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736818999; x=1737423799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjlDal6bcwHRhU3vt3NgHUgBM3T1+FFYj5QgpMimkV0=;
 b=fXkJee+qjxrIXvQqczW0ZWoVGDHvhV0hv954xmRIKtbror4lDoVNPWNxs975GE/Lvm
 nDDnOEO4DmPygw/CSj6pwRet8oR07g0yMcLndZIVQI1KoK4WjsvtSw9PGxmsMo98mVpT
 rWjixoCeSauHAVty9SsiDzoekt5w4iVw7kOXlH2BlGIZDtrNrsrBKaOacR+6Da48v1Ja
 dbcGygg2vSgbbeCBBqAINLu8rlVQPLQYKa6K1BKVwjeLH4ncOVsvGRHEKHyrQdDEbPUA
 BHUtcYNvtx9sfFPPoiTL66Pz9vU7uKGCIqJLeUxVT7VgTVXW07NFeB2dimhJUp0jgJ4v
 I9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736818999; x=1737423799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjlDal6bcwHRhU3vt3NgHUgBM3T1+FFYj5QgpMimkV0=;
 b=tSEQ1BVzwhEhx6sZmleQDDKYaN5b3xEXODozGBObA9cY+8tZ0fqpYyssXfc2B4UMTj
 EO+Rq00+ZCG01m9vUrhZWbzz4/rrwVa5yWONim3JsXPftqHYJbQMMuy3i5QKwZ4m6zm9
 ukFQu0lLNoWQv4vYwFzM0MjlVyZnrseyu//a8rkP4u7nKGLqN0MXeboqcldrNyK3w7M/
 knWJpuLji/h5m4+rWfXvcGqP7FcTmqsIjLZOUnjjV8zc7bYkV9jTlwS7EckgrhJhY/Cj
 Y3hnC4jQwzwuiA0OB/g6KZW0w3FakcEj6HdwargsTnxawgfzBvhKN3n2LYQdY4rpYYwV
 ol2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVBUU61GRdIypa/Tsze27RywYK5JzL3GHeWku98j+Gq/t8ZXARIPTjpTeuEy3o16KPsQkMvox3nQSy@nongnu.org,
 AJvYcCVr2tp3drxQT0ZsnkjsUZ1Lianbk4WHAvKqbaOuOEz+/9a6cIIevqo77N7YcKEdSXN3+leMacFpkF65DA==@nongnu.org
X-Gm-Message-State: AOJu0YwxmBC7Q2ywEt2gUGnGnPm+urU2dhiCS54H2POOpMd9ECcayVaW
 3eZgfsvHJr8GjFKOQw0Maw6VGtTWMxLWL7dcYQLwSARCVHoHka5Ab7hOmRK1nMyCIsMLdhwIGTp
 CZ7tCDj14fvCFodsjC7voru1K7tY=
X-Gm-Gg: ASbGnctMI2tyY7hMDvaRI8fy+qWmOHZwt2hPjrm6oBFgkz+JdMpPIiN68l2lAOoVWr2
 pIjVs+7HKS0WIRoFcyrjbuoDzaaMvE90TS+MnwBWbL3vxy8dH1BZocmSHCSeF7MFIDh8=
X-Google-Smtp-Source: AGHT+IH7gRyblFaz+ezwkd280L/mN+8QOQ/9dz6EagX1jpAHxdKGQCEm9gwY3kgp3ExZIQRL/ZeEdwfqSoFa+UGaR3E=
X-Received: by 2002:a05:6102:5088:b0:4b6:1991:4f4f with SMTP id
 ada2fe7eead31-4b61991542cmr16213053137.17.1736818999412; Mon, 13 Jan 2025
 17:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20250113194410.1307494-1-baturo.alexey@gmail.com>
In-Reply-To: <20250113194410.1307494-1-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2025 11:42:53 +1000
X-Gm-Features: AbW1kvblwV0R9-Qfcm9K_uV2QKwN4fk02ejz0s6CkpuQok3N8MWW9PHcL-I9qjs
Message-ID: <CAKmqyKMZgAh-ecvU+OXCAnNeqSUMwG9DSnKQpCSuMnL+FmBKXQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Support Supm and Sspm as part of Zjpm
 v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Tue, Jan 14, 2025 at 5:45=E2=80=AFAM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Rebased against alistair/riscv-to-apply.next
>
> [v1]:

I removed the lines above, as we don't want to include the changelog
or rebase notes in the commit message

> The Zjpm v1.0 spec states there should be Supm and Sspm extensions that a=
re used in profile specification.
> Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enables =
only Smnpm.
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c     | 23 +++++++++++++++++++++++
>  target/riscv/cpu_cfg.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bddf1ba75e..3d4bd157d2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -208,10 +208,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
>      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>      ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1625,6 +1627,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>      MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
> +    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
> +    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
>
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
> @@ -2781,6 +2785,24 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SUPM_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_supm),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_sspm),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_smnpm),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2799,6 +2821,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> +    &SUPM_IMPLIED, &SSPM_IMPLIED,
>      NULL
>  };
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aef896ba00..b410b1e603 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -139,6 +139,8 @@ struct RISCVCPUConfig {
>      bool ext_ssnpm;
>      bool ext_smnpm;
>      bool ext_smmpm;
> +    bool ext_sspm;
> +    bool ext_supm;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>      bool rvv_vl_half_avl;
> --
> 2.39.5
>
>

