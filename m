Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229CBC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRNk-0001dL-OZ; Thu, 15 May 2025 01:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRNh-0001a1-MH
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:43:45 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRNf-0008HC-OA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:43:45 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86fea8329cdso389364241.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287822; x=1747892622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dK8uKIJvG6t78GxY8lq5c4AEyb/lYI6INS992KZ6nGI=;
 b=i/WQ0dUEJQoonyt+uE1Hftkms5qmuYsOi67iHFyejxFxEFxVct5TDkWmiLjQQKsoaF
 BI+3D9SrCye2DNYrO63mLQWeiDFLo/GlPozJYTLC+cqBZtjLvS6oRJJ4Z9by7vbVHBp+
 eUzFuF4OamQhZa/8HY6053CAwBcvFjiCyxJtRzHScYGEv83Xl0JZdwPtzBnK+AaZ70/C
 rawrtxX/Pw2er1nbhs15YuPrEqsf3oAk/V40GASgFxJgOfnrvuuaf4fPBwspa14IityT
 OwmwbF92b9Bk/HE70k4lzRftNevWo+rn3l+E6NfEdrmyVoSCUqac5sAHlFl8fBLofgk0
 OJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287822; x=1747892622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dK8uKIJvG6t78GxY8lq5c4AEyb/lYI6INS992KZ6nGI=;
 b=FVQ3BZ3cUPVR1Q3YiDMLmAl+goZKKPU9UTGKRF/68NNEf/eWJi2N5vJv7nQCAPRAJW
 3DpXQ9Xqy1Q55uXsVpLdtyCM0lcLnP1ony0lyXxPNS1uYcnGL67Ob/7R0rNkHqwZOCG8
 oVpBW/uAfKROzYFXSHN3Hx50m+Vx12XUJkk48ddrC2H5/NpLQjY2TSDk0eu6tF6KjEFW
 3P4pVSe5U0NJ0AZl9/CEAuVyucyPsSzuH2ZaoyZgaS30/HvrOKVjqj46zl2he/ddjKp4
 pJtkjOl8ZpSwHk23L2bQt7hT+x7XzOcC8Kx8SHvqd0Cdcx/NbTmDFQJMqgjeP0+5EgQW
 Xnwg==
X-Gm-Message-State: AOJu0Yy0PXGlLoMon212UwTXX5IiD+ob7JXqmq+GjiRU2pXAD2RG0fcY
 fqrZtXyzyjY+02RISk/VAdl/3Zfo38N2JDtccnkGyCMbNgzrol0EbYYQod3MR01ubqixIwWaRkE
 Nr8Hgz9eutl3G96MXfEJRjBgs4Lk=
X-Gm-Gg: ASbGncsF65PBWhOx0sivkmr7bdHCvYGcZYRkTHADEOiTv5OBhCOP4VNQ+CkD6gWZckF
 +1TzY7/6xYMO7CBiC+JsRxpk+ks7cD4oMKX7w+iGZrZKCG18Iz4fNYLsBSH4p19xFN91kkgVHpt
 CatcQyRxow6Mf9LlIYKNWPgPgEk5uf+gBlOId1am4/pyHNXC+UL9w2UH7BEv4qOho=
X-Google-Smtp-Source: AGHT+IGAQMXBd50lMnwaQL47DUzWEmpyKj6/6cwEWpovMPjzVeNdILkp/1Rn8FayS+RcSdLlEyDJj4ptqQ1NaqYIP4M=
X-Received: by 2002:a67:e7c9:0:b0:4de:ed21:480a with SMTP id
 ada2fe7eead31-4df7ddaf6d3mr6351397137.25.1747287822474; Wed, 14 May 2025
 22:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-24-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-24-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:43:15 +1000
X-Gm-Features: AX0GCFuzMnH0_q59PWyo0m6w3U3I63XegzvyKaJDYu4ayR1tUszP1Yz37ROrJOc
Message-ID: <CAKmqyKP+ioGrrnxLpitLpTuy8SEnWjUws=HqsW_=hLDJNCVe1Q@mail.gmail.com>
Subject: Re: [PATCH 23/26] target/riscv: convert Ventana V1 to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 40 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 18b60428d14..c884e09d869 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -499,45 +499,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
, const RISCVCSR *csr_list)
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -static void rv64_veyron_v1_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
> -    env->priv_ver =3D PRIV_VERSION_1_12_0;
> -
> -    /* Enable ISA extensions */
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.ext_zicbom =3D true;
> -    cpu->cfg.cbom_blocksize =3D 64;
> -    cpu->cfg.cboz_blocksize =3D 64;
> -    cpu->cfg.ext_zicboz =3D true;
> -    cpu->cfg.ext_smaia =3D true;
> -    cpu->cfg.ext_ssaia =3D true;
> -    cpu->cfg.ext_sscofpmf =3D true;
> -    cpu->cfg.ext_sstc =3D true;
> -    cpu->cfg.ext_svinval =3D true;
> -    cpu->cfg.ext_svnapot =3D true;
> -    cpu->cfg.ext_svpbmt =3D true;
> -    cpu->cfg.ext_smstateen =3D true;
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbc =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -    cpu->cfg.ext_XVentanaCondOps =3D true;
> -
> -    cpu->cfg.mvendorid =3D VEYRON_V1_MVENDORID;
> -    cpu->cfg.marchid =3D VEYRON_V1_MARCHID;
> -    cpu->cfg.mimpid =3D VEYRON_V1_MIMPID;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
> -#endif
> -}
>
>  static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
>  {
> @@ -3207,7 +3168,41 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVS | RVU | RVH,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.mmu =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.cbom_blocksize =3D 64,
> +        .cfg.cboz_blocksize =3D 64,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_smaia =3D true,
> +        .cfg.ext_ssaia =3D true,
> +        .cfg.ext_sscofpmf =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svinval =3D true,
> +        .cfg.ext_svnapot =3D true,
> +        .cfg.ext_svpbmt =3D true,
> +        .cfg.ext_smstateen =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_XVentanaCondOps =3D true,
> +
> +        .cfg.mvendorid =3D VEYRON_V1_MVENDORID,
> +        .cfg.marchid =3D VEYRON_V1_MARCHID,
> +        .cfg.mimpid =3D VEYRON_V1_MIMPID,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV48,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> --
> 2.49.0
>

