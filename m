Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16A1C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kMf-0002p8-Gc; Wed, 23 Apr 2025 20:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kMe-0002op-8A
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:22:52 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kMc-0001h6-Dg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:22:51 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-525da75d902so189601e0c.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745454169; x=1746058969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3acwlxHM3mDiR/C7bNGtFaucvlq1t5JqgUYJcytk5Tw=;
 b=gDWP4Or6IXY3KGoKEijgQSCDyDF4CIz2Bamywpy4FSh5ActGEOedQ5nlbUeW3j1X9C
 ujJSAeXlc9qkT2xGdJBIebiM0yZQiYOsRT6sedFKy3/001C/OGScbXh2k2nw7eWUGC8E
 otGruc7zdWGyErlkogLZiPAqmlnAzBVRYawXQtsNafHds1A4H1M8jPhh//8hDdEmgSCc
 0GfwyVnty/BDGIEMU5tLKHluYwHQH9n7loge1qX1sl1aTLp5kugZdyLXXPABhyk/Y0y2
 Fn2ta0lSDfGyh5VBMNzJh7kJkKKqQuowaO/jLOhuESAilwKSqUFH7gEVS/zg4zQBGmwK
 Db3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745454169; x=1746058969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3acwlxHM3mDiR/C7bNGtFaucvlq1t5JqgUYJcytk5Tw=;
 b=jNlmFGaVTPIflWxqSAhyh4YNXZtZYCkvb6wbimtGyey8gUoM9OKrUNhhIJckzYAxcm
 1PwtW1UUjmzPKMbICmj6TXM/kAFgb6C4+7kwektZlsMiU1SW3niNrF9Qyc2gr8GFHvzP
 1ogxgZorbTP5RTP3hVpHssYbDED0bTmVofNIqfBxBhR68dnw8L0FlWKYkY/C9mzk2hzo
 BZeCjchVNKd6dE5jU7GovDeYbN0PnMPsT3t4t+CJYjtewFg3BAi+t278k9Z6he/W7lJ/
 va18Utdb0OnuPk1rLqAdTpWOfcM4jaPbo5oumACyfIq6s6nLd+LtbwckRt8DTvackOeh
 6OeQ==
X-Gm-Message-State: AOJu0YxITwAOj78vVXPOXrUxBhf1DsOyK8uZgwk7c0IKjySgFHtiJDOC
 yTch6SDESogNTHKOEtILVHrCJJU3j+17Xur4JzWcPPqQaFivqdT6UEClX0pfndASxk9ziqrK+mn
 j9DM6NIHhvFhVIe6Vn8WOK7b7QVRBHQ==
X-Gm-Gg: ASbGncvwa0uZn9CnzwcTbTMLwHizuJ5SujWyz0ed3r54Ti5ywwkdIsy4f62xrvTlh0+
 ZAFEdEYLuNFQEJzULoXldtaOY2LI2zAh9BqKsk6QeaAqo2MHNnjXxC+q4zLwRmUfMDqMaDG8RP5
 bzPwCcw70Wero4EGbJ075h32z1lAJu0oIQAi3awvDuWwwZ5XhsxvHx
X-Google-Smtp-Source: AGHT+IEKq1jGp7AOg21Kq7KYaMLMIs3KlYaNtx8KGFGZnUO5vLPYCNuNypPW2zo3iTpMG2bC347Up1O6+67o6820tyc=
X-Received: by 2002:a05:6122:2202:b0:52a:673b:5584 with SMTP id
 71dfb90a1353d-52a78089930mr720735e0c.0.1745454169176; Wed, 23 Apr 2025
 17:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-19-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-19-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:22:22 +1000
X-Gm-Features: ATxdqUFSAW4bTFO2Ge5ZKqQfZtzf0je_VBWDpF2IqxgqdMoPSYLNZL8yydWjwzc
Message-ID: <CAKmqyKNTp209Q0FMaAFRdzQjvHCGCgGOxh7+R3UULKHKjjjPGg@mail.gmail.com>
Subject: Re: [PATCH 18/27] target/riscv: convert SiFive E CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 74 ++++++++++++------------------------------
>  2 files changed, 21 insertions(+), 54 deletions(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4cfdb74891e..0f9be15e47b 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -44,6 +44,7 @@
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
> +#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73c815d22e9..e72ebdf206a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -504,23 +504,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.pmp =3D true;
>  }
>
> -static void rv64_sifive_e_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv64_thead_c906_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -709,23 +692,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
>      cpu->cfg.pmp =3D true;
>  }
>
> -static void rv32_sifive_e_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv32_ibex_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -747,23 +713,6 @@ static void rv32_ibex_cpu_init(Object *obj)
>      cpu->cfg.ext_zbc =3D true;
>      cpu->cfg.ext_zbs =3D true;
>  }
> -
> -static void rv32_imafcu_nommu_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -3208,6 +3157,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #endif
>      ),
>
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR=
_CPU,
> +        .misa_ext =3D RVI | RVM | RVA | RVC | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_10_0,
> +        .cfg.max_satp_mode =3D VM_1_10_MBARE,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true
> +    ),
> +
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3216,8 +3174,14 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      ),
>
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_=
nommu_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV32
> +    ),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVF,  /* IMAFCU */
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_=
u_cpu_init),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
> @@ -3243,7 +3207,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV64,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
> +        .misa_mxl_max =3D MXL_RV64
> +    ),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
> --
> 2.49.0
>

