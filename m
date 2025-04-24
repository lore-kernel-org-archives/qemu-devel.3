Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6708C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kDT-0007wk-Nv; Wed, 23 Apr 2025 20:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kDS-0007wO-Hu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:13:22 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kDQ-0000Zk-P6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:13:22 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so194308241.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745453599; x=1746058399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPTfdjiTgX3cya0CAFhtnTS0YNkFMDM2Tq9t+C6tAuo=;
 b=UyqUWDN0SySQ+rQDGPM4onT6NGM7wyRxKUxTXt3zJ9ocsNCOsuKwui2bX12OVxTYRX
 W8SwlMDbus0t9fHsACgcqK5hTRaaVkDcwXWS/rQXwr7d+clw21LTtIEj5LZRghgxW5/k
 ZEhnWpkv+mz/f226m5iWA2y4T0s1TjFu2rx5fGx58dITiTdbj6spua8eM+uDEHYsEcy8
 joG+z26GwiH9u6rTM2Ku5wF81q12LDcEvV8Gl0Kr7y1RGttksxg1uV+k1y8/XYsRTi6d
 PKx0VG7FAEcw4VIvYb77OuO/WxyhtfNXqQ2o+/8b1J7pADcQdT8jDhWE8y2t2bMx/kaM
 lYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745453599; x=1746058399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPTfdjiTgX3cya0CAFhtnTS0YNkFMDM2Tq9t+C6tAuo=;
 b=hbPSqNcKOy0IR+Jri0R90ReWmMTPyPObucRKiGUEZtJ1/cZGQHSb++Br/crnqA/7nA
 Yv5t5eN9MYUUwBVjmGbBXAhrn8gl0VOaI/FTLK8Adoa65gX4qW/5IwpAe1Ke7R2W9Q7k
 2qYy8BGswKxGzA2mNkI7j8tGVtLlucwKVe7OvoS1GPI0ww2UJt6bNE1l4tbCIwjxwjCW
 pd8sqQfBNP+IyNbAqdYkltukjI/gt8qz8cPzeWotbzu5IqHorDg+Bme+1ncCXzGHJH61
 iURx8LihSSr3vyHLDITth8BMJhbLkIaSU/z4+FNwLzBHlqZjWHYz3/WqPuxe6U6GGmW8
 yIyg==
X-Gm-Message-State: AOJu0YwesDElAUR6R0KAnF7cJPuIsZW4K5vtaxXnhEMIid0GV/uzeE6G
 0Iqdw91DG/sDRTiMA16vKOuekdhCzske4u4sYn1UV1sbEzjuF60zEexkBPK89BvC4PTT82GX9gR
 +J5popTtGlKLcWZMht0Fdh92o/jWT7w==
X-Gm-Gg: ASbGncvtNhbAEXiNT3jSVm+C9abkSTcvmkr17IAIBHQFjvh8Gm1URnx57qKwJ7m/i0s
 iQJZyXcPRfWbrc1HQwmIuoKpS/dR3fcnugk/Moz25PExLgsUesGKpLtjbj1hvny4Mz0svRr1rjI
 W27QN2/wEyXaZp3vlxYTC2CQCvLU6EsRRbb2+Y3uIreRFknxDBgLNx
X-Google-Smtp-Source: AGHT+IHr3tecvSodwpYWWqFLLU5lZoOHCW9JF/qkmR6eROAjdmbhfusY1j0Ep5WlIPCZ9HGu4uM+WfSIVBSDCOs0rMM=
X-Received: by 2002:a05:6102:3ec4:b0:4c1:9328:107d with SMTP id
 ada2fe7eead31-4d38f2e774dmr957636137.24.1745453599015; Wed, 23 Apr 2025
 17:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-17-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-17-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:12:53 +1000
X-Gm-Features: ATxdqUFRS-de6ue5uXnzuDsWahox-NyeFVSnQz4elWOYEFU7CpKrFjuj_fzUIk4
Message-ID: <CAKmqyKNoSOBBQarxE=J2G9LvhtkTVZicFu_2Veu-JLN3qa2jQg@mail.gmail.com>
Subject: Re: [PATCH 16/27] target/riscv: convert bare CPU models to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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
>  target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 41 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d3d5c048d02..2ea203d97b7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -735,18 +735,6 @@ static void rv128_base_cpu_init(Object *obj)
>  }
>  #endif /* CONFIG_TCG */
>
> -static void rv64i_bare_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    riscv_cpu_set_misa_ext(env, RVI);
> -}
> -
> -static void rv64e_bare_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    riscv_cpu_set_misa_ext(env, RVE);
> -}
> -
>  #endif /* !TARGET_RISCV64 */
>
>  #if defined(TARGET_RISCV32) || \
> @@ -839,18 +827,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.pmp =3D true;
>  }
> -
> -static void rv32i_bare_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    riscv_cpu_set_misa_ext(env, RVI);
> -}
> -
> -static void rv32e_bare_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    riscv_cpu_set_misa_ext(env, RVE);
> -}
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -3222,19 +3198,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>          }),                                                 \
>      }
>
> -#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_BARE_CPU,                      \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        }),                                                 \
> -    }
> -
>  #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3319,8 +3282,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_=
nommu_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_=
u_cpu_init),
> -    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_c=
pu_init),
> -    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_c=
pu_init),
> +
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVI
> +    ),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max =3D MXL_RV32,
> +        .misa_ext =3D RVE
> +    ),
>  #endif
>
>  #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> @@ -3340,8 +3310,14 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #ifdef CONFIG_TCG
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
>  #endif /* CONFIG_TCG */
> -    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_c=
pu_init),
> -    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_c=
pu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVI
> +    ),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVE
> +    ),
>
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  =
RVA22U64),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  =
RVA22S64),
> --
> 2.49.0
>

