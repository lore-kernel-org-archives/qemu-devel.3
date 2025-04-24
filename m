Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EDCC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kbA-0007cI-N3; Wed, 23 Apr 2025 20:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kb7-0007aC-QE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:37:49 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kb6-0002zg-23
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:37:49 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-524038ba657so501999e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455067; x=1746059867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkjBuB8AeiCsmeJ8RMZSOxlDq9z+T77V4eYvgTWVP6w=;
 b=jfgFI2NaEF2PVUfc67iPEGwfoQvkz4EG+HfyJB3B5i6F+1ZwajRsFXGUabDW4DKij9
 324RPPmZXnSTCJWNiOtSUAc1xA1A5wx2TG90FaonfFIr6fLbHHlu+3eYAErx9id0laAR
 YFRssUCg25iAHLofvzwuh8rQAa+cFNfjaadOK7FxwOw8JSr0iyCaP673fdWiE1WkIVOF
 krOECCxOEQPzPYH+zqgRf4ALs2d6IzDYZQz1i06Z+Y8EWpDN+teonYikCnmxtshdKLUp
 J5eAI4tvTjm9ovmy5C2uFFQr2ADoyUi0x0fCxeYEHpvUluGmYaDpNhb5HswiblX0/cTG
 woyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455067; x=1746059867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkjBuB8AeiCsmeJ8RMZSOxlDq9z+T77V4eYvgTWVP6w=;
 b=dQf3TmXa0T96mdmZo50/1U/QAoTh/N2R1J66O6kPezWOJl4qeOAmREstBjiwvHMVDz
 qQj73PYr/k10H1W612YCMGVGggCpfkiXb2wxx/OfuuXI5eGbiVG2a0kkxr1/pPamsdk5
 VsvFZDJjSxQ/wYcJVlz1yxT1etLIsJhYoW0/yBhloBAsCa6RolGHdOEvJfX0H7CEPhZt
 R4Wkh3AQfS0qzQNo286zUmXuj5+rTzkrcxLIx+3MTqRXhfs4M+twvXlRtZbY15scH7T1
 NEwtv4tas83QuP94zLgVkoFhepDxDepLiX6U4gydzBTOo3c6Sd2Utg/q+lTrG4KZudN0
 184w==
X-Gm-Message-State: AOJu0Yzofs92J+JGMGYExQoJybi4Zar/Sh6h4okZk9mDGgX38B+YoxSw
 UX/dU0+QwAGOrgrCxWsxEp7IXgPPvtdqVsNmIZltIZjOjH3u5+Hvv0O4CXZfWNaNDZRAK7vHbB4
 gugyounIIXiX0nbhUYaQ1HVN5XxA=
X-Gm-Gg: ASbGnculJ87gAbjPImiHc7LcTgxGxWS11TYG+WJNUQEr2UZqejY8/87lCHThJCz4DEI
 fSWy6uYCOuAPDk3/2/kJuM3I8lXN4mGjMZGEYeWUujMr2kWNmZ/HG0xBQuGCbkM5sy+KqpPWe9U
 5cCVgVk1lV4kVjMXUshTJV/DTG8RSdjDEiWSGqGBmWjMAc25c0ojAk
X-Google-Smtp-Source: AGHT+IGJbsTvBSKHNR4Tw/8tWapU9QTujJFg4eEKXgeH2mnLFYGOIulpnITX//+Jcxl/5NSSwTvu731FAoyaqESRqUs=
X-Received: by 2002:a05:6122:2004:b0:527:b7a3:dda8 with SMTP id
 71dfb90a1353d-52a79dda3ddmr247298e0c.7.1745455066932; Wed, 23 Apr 2025
 17:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-24-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-24-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:37:21 +1000
X-Gm-Features: ATxdqUHa95z4NHnAN8xsbxzJs-Rtoh-7gpaZDXz-xVDDM1fFQlDnmf1beM4f5Gc
Message-ID: <CAKmqyKOREH8oFsFuFY+paufYcP8t3DHRoMQ5XfTseFkHmBXMFg@mail.gmail.com>
Subject: Re: [PATCH 23/27] target/riscv: convert TT C906 to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9669e9822b2..45bed28ea8a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -500,38 +500,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
, const RISCVCSR *csr_list)
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -static void rv64_thead_c906_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_11_0;
> -
> -    cpu->cfg.ext_zfa =3D true;
> -    cpu->cfg.ext_zfh =3D true;
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.ext_xtheadba =3D true;
> -    cpu->cfg.ext_xtheadbb =3D true;
> -    cpu->cfg.ext_xtheadbs =3D true;
> -    cpu->cfg.ext_xtheadcmo =3D true;
> -    cpu->cfg.ext_xtheadcondmov =3D true;
> -    cpu->cfg.ext_xtheadfmemidx =3D true;
> -    cpu->cfg.ext_xtheadmac =3D true;
> -    cpu->cfg.ext_xtheadmemidx =3D true;
> -    cpu->cfg.ext_xtheadmempair =3D true;
> -    cpu->cfg.ext_xtheadsync =3D true;
> -
> -    cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> -    riscv_register_custom_csrs(cpu, th_csr_list);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv64_veyron_v1_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -3221,7 +3189,34 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV64,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_11_0,
> +
> +        .cfg.ext_zfa =3D true,
> +        .cfg.ext_zfh =3D true,
> +        .cfg.mmu =3D true,
> +        .cfg.ext_xtheadba =3D true,
> +        .cfg.ext_xtheadbb =3D true,
> +        .cfg.ext_xtheadbs =3D true,
> +        .cfg.ext_xtheadcmo =3D true,
> +        .cfg.ext_xtheadcondmov =3D true,
> +        .cfg.ext_xtheadfmemidx =3D true,
> +        .cfg.ext_xtheadmac =3D true,
> +        .cfg.ext_xtheadmemidx =3D true,
> +        .cfg.ext_xtheadmempair =3D true,
> +        .cfg.ext_xtheadsync =3D true,
> +        .cfg.pmp =3D true,
> +
> +        .cfg.mvendorid =3D THEAD_VENDOR_ID,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV39,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs =3D th_csr_list,
> +#endif
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
> --
> 2.49.0
>

