Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C785C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kPF-0004Dp-RX; Wed, 23 Apr 2025 20:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kPE-0004Df-JJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:25:32 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kPB-0001wi-3k
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:25:32 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-523ffbe0dbcso473649e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745454328; x=1746059128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIWyh6m13NrYov5giqOJ5iXdrr+cRqnAvzcu00W0zl8=;
 b=AQoGHTGXsA4aIVFwknflh/qCOiFZgOjR9MPOAoz1qghe7LzjJvVnzTS8x5wksUDI6K
 twZvp0LDwwAA79juwkQVfNztZ2oKn1hADldsOb8tWyyCkcANcnepQKtWv78r9EbAQnKz
 laEnDhLwZmR8rQnyKoGKZ4OZcqdifscPtA7Z+4NV04z5464z0MIlBrRIvlJF7ZAG5+dC
 5IpmkgEjQ7rPhoiobiSU5Zq8VSvbWgcPB+/V8rQOnv+Yk1hDzzqMtLYC92X8TEgtvBhy
 GnWFXzU8530y72iCNPp9iPBkXBmv5j9W9vLDWdkmiHUiZAc2OM2g2OQ9sqghMURqZrvF
 j67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745454328; x=1746059128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIWyh6m13NrYov5giqOJ5iXdrr+cRqnAvzcu00W0zl8=;
 b=gF0engwJBaa0bJ4gT10jzlvW6Ogqby9QtrimGFDhSVZSdwfT2wcSmdDZOGDSwDEPI/
 l2jvVL1jIyJFM8WhUTiKgUEjA1QCRHlFE1SH81bGinUn1fPxx+t6pYC8AzqJyAkzI2dU
 hl8p7yvWuXn95encFYpBSRVCT0e3PLWW6lpIJH0Ia6zqOkvkFAieCc0P0gD7UjrLZ6eb
 PgU2pH1wgLjxz5Pq3IXRMY0zo/6an4l0+R134R+jNKE8by9mZmYTUp5Er/UTli9JfxiZ
 H++haG6SxJL5l5OtA82ZAXafe+hyGY4qF8pbYyzVOIKKkCpP9SxZbywNgbqYOXb9gXgq
 18Qw==
X-Gm-Message-State: AOJu0YwUU4OmOaHlYMUNzlTSwP+uHWUHO7w4ZfuWadLvjBMoLgkRy469
 KitPsGyZYM7ZI7LQBSrqroPXJ3wkDqY+dXqKvXlpvuxFi2PWjeRaBQQrli9gVNlismhJ7cNbrWP
 gEmwhgSTDizoRJbPjsN1Zfj3DkOw=
X-Gm-Gg: ASbGnct/LcJp+wOlNk9hXxFxILYmtljGoEglmjz+/Z5psOOTYIjbo9qFGHH3RRd7VG/
 Te5IAuUa1ic2X/AOva04TYx3DvN2RkFK/vSPcQXrkg202oH5NePNJepdZ5crQqtXWSfnYbDYAdg
 1AQDFg63qazuHIJqMtlFgtM4AZEcWxm6KzVJc+CPhI6JvfBt3DxFNi
X-Google-Smtp-Source: AGHT+IEa37IYFjuBSTbWVNrFDUsCCHq29lgRotuq00sj6FpjcxFHyQHUuTcp4pBpnawYaDc0ELG2wP9k7XUn6RuKgiA=
X-Received: by 2002:a05:6122:3c41:b0:526:2210:5b68 with SMTP id
 71dfb90a1353d-52a7826a153mr767929e0c.4.1745454327801; Wed, 23 Apr 2025
 17:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-21-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-21-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:25:01 +1000
X-Gm-Features: ATxdqUEXo8UW4wBpKYldFgyKYG5_qD7BCaSO6WS89w01gjzK6gM157yRkKYurTI
Message-ID: <CAKmqyKMi+0ufzVQ8CCTQpX_MMn7V3D2W87G4U+2==6_FyxwLOQ@mail.gmail.com>
Subject: Re: [PATCH 20/27] target/riscv: convert SiFive U models to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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
>  target/riscv/cpu.c     | 79 +++++++++++++++++++-----------------------
>  2 files changed, 37 insertions(+), 43 deletions(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 0f9be15e47b..1ee05eb393d 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -48,6 +48,7 @@
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51"=
)
> +#define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
>  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34"=
)
>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54"=
)
>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fe1edf3be97..6f516163486 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -441,8 +441,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>      g_assert_not_reached();
>  }
>
> -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        int satp_mode)
> +static void __attribute__((unused))
> +set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> @@ -487,23 +487,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -static void rv64_sifive_u_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -
>  static void rv64_thead_c906_cpu_init(Object *obj)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> @@ -672,27 +655,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *ob=
j)
>
>  #endif /* !TARGET_RISCV64 */
>
> -#if defined(TARGET_RISCV32) || \
> -    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> -
> -static void rv32_sifive_u_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> -    env->priv_ver =3D PRIV_VERSION_1_10_0;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
> -#endif
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -}
> -#endif
> -
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> @@ -2925,6 +2887,17 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, void *data)
>          if (def->misa_mxl_max) {
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> +
> +#ifndef CONFIG_USER_ONLY
> +            /*
> +             * Hack to simplify CPU class hierarchies that include both =
32- and
> +             * 64-bit models: reduce SV39/48/57/64 to SV32 for 32-bit mo=
dels.
> +             */
> +            if (mcc->def->misa_mxl_max =3D=3D MXL_RV32 &&
> +                !valid_vm_1_10_32[mcc->def->cfg.max_satp_mode]) {
> +                mcc->def->cfg.max_satp_mode =3D VM_1_10_SV32;
> +            }
> +#endif
>          }
>          if (def->priv_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
>              assert(def->priv_spec <=3D PRIV_VERSION_LATEST);
> @@ -3144,6 +3117,17 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.pmp =3D true
>      ),
>
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR=
_CPU,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_10_0,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV39,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true
> +    ),
> +
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3175,7 +3159,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_ext =3D RVF,  /* IMAFCU */
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_=
u_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
> +        .misa_mxl_max =3D MXL_RV32,
> +    ),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
>          .misa_mxl_max =3D MXL_RV32,
> @@ -3203,8 +3189,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
>          .misa_mxl_max =3D MXL_RV64
>      ),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
> +
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
> +        .misa_mxl_max =3D MXL_RV64,
> +    ),
> +
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
> +        .misa_mxl_max =3D MXL_RV64,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
> --
> 2.49.0
>

