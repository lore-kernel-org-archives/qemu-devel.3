Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87277C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRLt-0005Ud-TA; Thu, 15 May 2025 01:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRLs-0005SO-7s
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:41:52 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRLq-00083l-8G
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:41:51 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4df6027cabcso392181137.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287708; x=1747892508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxCcDivne1C3++PJrt17pL+abrFFGhRFwyqrU0LHEWE=;
 b=gnsU/P0PZN6YDMDqGzRym5DUPmrXhLgyTq0gIIt1u6osklAqmwtgVSrae2y3Sw18AJ
 d8eO5mMEghw9CMj/02AVsvwE3PNHPzDnlLvWlBYD/vzUqy0igAolaKva0YLuVOK9rJUc
 I0nrpjjEFCZ+T0XV7CrdLUsK4nmHuaVcZBkZynCsud4Sh0moZ5qQY64ccqnfUL/Q+h0U
 cwlgaSMQt443SJY9cQnHPD3vkIiJpBpn8CSvCTBNSwg7f9ogslpgPOBs2bf3hqi5w10E
 lCRGVyvhT+K8LKg8/OdLRB+VIuZ8+VHaj9mrNHcUsuxMFgX/MVs/AAMARhFeEd7MoXFs
 ezwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287708; x=1747892508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxCcDivne1C3++PJrt17pL+abrFFGhRFwyqrU0LHEWE=;
 b=XOGZpVNga2frhFpcXyY3Z2MsQ0DjoTTJn4YZXxkRFdJaL282N3Lb2vgXR46tZmVwe+
 ZPHq9QHJuhkDy0VeCx3LOoeEyFO3TChoECmu52ywd8OPem/hPzJ3kYEX894xyJ4sxE0v
 Iazfh4NrJ4Ub8BpTf4SFPY4y+vmZNJXG+xfVK/9zj+yfzMywac/HJdqG0xabgLBrfRJL
 idX1tkhyvcqKsed7QAel1wxBIjuKwSXi6YBOGWP+0VW2dCQHJDaPpX/02hIgnedMcfeI
 cb1Rvqut0vzvQPnSw7yy0TGtGHqe1HY6BU0u3FVlUaR7rwyC5PQ5oTQGIe1njbsmyThV
 76FA==
X-Gm-Message-State: AOJu0Yxfw8gk93rx5K4NbSjWiYa8CBBD3FDAFJReLMaApn88nPCSWPmk
 GuJDd/trHufn1+tUFAeJGR8Stp2G/3/6Uyo5HNlOopod4SEfzJ4M0m2EJrbc0r7QnicfUxU9mDm
 LG7Npxf0koJaXCyEZoDHjQAvpkutzPw==
X-Gm-Gg: ASbGnctoQuKYfnasXR/8eeg4b2167eQ5h00QC/IL8Pwk3kuLrZpVevRGUuXLvk0HbZ9
 6BHDtXeRi7NBk4XNn044ptOv7yu2Q798ENea+4yiDl0COcavcRipDiJP4BbKI9pbor4XWHswGvF
 Mob2cHqWwQji6ddYsCOFhTad+mdH0bWu8+fr4FlOq5cbWNnzt7x90V1Fut6t9rdr0=
X-Google-Smtp-Source: AGHT+IHJMMnA1SoBsOj2ZgToaguJkebWgB43F6O51tkfLXK1riQEbjqm4hWIOdrEwOxCschUsmEMbynoF7K2mC9ejeQ=
X-Received: by 2002:a05:6102:3e09:b0:4bf:fb80:9429 with SMTP id
 ada2fe7eead31-4df7dc71787mr5944238137.4.1747287707945; Wed, 14 May 2025
 22:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-22-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-22-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:41:21 +1000
X-Gm-Features: AX0GCFt7jllRgqDOOUBGkoPqVEpL7allj0HifYQsr3OK1yqOD9fOhEZCf0ERX8w
Message-ID: <CAKmqyKPbQtTxGKre6dwWhgT+T57+WOqoFtFL=z5F=ge3BNWSyQ@mail.gmail.com>
Subject: Re: [PATCH 21/26] target/riscv: convert TT C906 to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
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
> index bc45815383d..dbfd8c7a348 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -499,38 +499,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
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
> @@ -3217,7 +3185,34 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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

