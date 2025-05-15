Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0769C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRCH-0001iA-JB; Thu, 15 May 2025 01:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRCE-0001hz-PB
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:31:55 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRCC-0006lk-Tu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:31:54 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4def2473a58so141945137.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287111; x=1747891911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCCZFJW5pOuUG2XuA7UP44j8o4vDbsnGHimml3Wnl1w=;
 b=Nl3tJ5GD0YpT9KMGqPh6hCwWrRRmUYNfucyvu112GqxY2n/9bM8PZcb6fWpMWj3QFU
 zCfLCfsOPHuLNfq9dfMySxykZnPGdeaB/D5XnEptbM2YzUAAZt0ZFoovGcC0wLsU4lXk
 j7HaiTEVnimtuIGxrgn+F5lNko3eqS86FRlssmZYzaDULzrY+PPgWUyoGsODY7F5Jv9P
 szHR+uUcdqws/1YkT1yEKl7n9njUsx8igOFX4wmOZqlZ2Q3kBOgeACfMADPjSy3bnWOi
 r+ASy2g+MFbATB0L6msBr7sNBGZZXACgF+rdDQdMCM9bX+Z4fojWsuH/5AWXgtFayJnk
 Bz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287111; x=1747891911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCCZFJW5pOuUG2XuA7UP44j8o4vDbsnGHimml3Wnl1w=;
 b=TEw5NMOjpPlZtsFXopt8vIy9zZKqode6xKAXyNGQ05bOsxgLzNrzR0A7nd5GN0BDZN
 2/f807JdTWZ3gpVJkOb6hq/Pjl30/gzWkKxsDLFeka+HkwPmqGZpbae65Sh0ROGrn2vf
 gGn45LN8xF5DPgEvW89WeUMp/x1Or+JaULwpwwgXB7BLzzA1c7hNqPfCEgI6t2AiKJGW
 eVSzcwEdiHMBFrpQWuh6lmwnlbd9WCXE7HPHXHOgNgykUQwRNaWhHWr9OmIjwcdd1FGr
 /DblEhiyBmSVB3oqIIPmxyn6iujGFyt6NOdWwttpd5ZRbLriwaS6CM2CsHaD9GlBd6fq
 XpWA==
X-Gm-Message-State: AOJu0Yx/Qv9tqm/11obVCuNbgFrZ7mQuxqTEK0lyG5FkVkh2r6uxDFKk
 B0VNn2xSYXl0D9AR6xNjjKzxZv58LTi5TETum5sUCxxkjLBfZ9/z/vHObYl0BHNX9OJJPP/Ys1p
 PkiPP+Xsp4y8IfJmEcuIqf2L2QY3dRw==
X-Gm-Gg: ASbGnctIknQvbyNbP8QyosXZPEy+8D8xxaPYbQgVjNmBMKCkJ6c+8KDmu3aO5OkM6sh
 7Eevnmpdi6iSlGuneeNJFcQP78DeJ9cTQ2RvN8UaZlzbC2FyP9O2TJ5tu7KNecuLw4EeAeDAGxw
 lfW9/jgK4RXtAxrV1ISbAjrB00ed1yJecIXOSzT8+xCBWP5CSfurRrky0ZVQadrRhQs3YrvEe2L
 A==
X-Google-Smtp-Source: AGHT+IHQSZkPLLT9oDP8ODKvvpzz5yLc2guTT0WIUyAn8GHp0ZKUJ8etw5FE5WEL0P5bPoLqoEF1OmuF3MndlYLsNXI=
X-Received: by 2002:a05:6102:3ca0:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4df9541b0eemr810085137.7.1747287111384; Wed, 14 May 2025
 22:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-16-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-16-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:31:25 +1000
X-Gm-Features: AX0GCFss5QH0J30_uifGD8wDkaFWYFXFQgsT__h8XTw8OXfAKZzBpDigGzh8dw4
Message-ID: <CAKmqyKNkfSFS409e0hBP17obT=ohkrG7U2bNgAYSa=zxujN4mA@mail.gmail.com>
Subject: Re: [PATCH 15/26] target/riscv: convert dynamic CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Mon, May 12, 2025 at 7:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 113 +++++++++++++--------------------------------
>  1 file changed, 31 insertions(+), 82 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index af5b4af4814..b4f6e34eac7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -485,38 +485,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> -static void riscv_max_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj),
> -        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> -        VM_1_10_SV32 : VM_1_10_SV57);
> -#endif
> -}
> -
>  #if defined(TARGET_RISCV64)
> -static void rv64_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -#endif
> -}
> -
>  static void rv64_sifive_u_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -717,41 +686,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *o=
bj)
>  #endif
>  }
>
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -static void rv128_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> -}
> -#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
> -
>  #endif /* !TARGET_RISCV64 */
>
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>
> -static void rv32_base_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    CPURISCVState *env =3D &cpu->env;
> -
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.pmp =3D true;
> -
> -    /* Set latest version of privileged specification */
> -    env->priv_ver =3D PRIV_VERSION_LATEST;
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
> -#endif
> -}
> -
>  static void rv32_sifive_u_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -3166,19 +3105,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>  }
>  #endif
>
> -#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D &(const RISCVCPUDef) {                \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        },                                                  \
> -    }
> -
>  #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3235,7 +3161,12 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .class_base_init =3D riscv_cpu_class_base_init,
>      },
>
> -    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true,
> +        .priv_spec =3D PRIV_VERSION_LATEST,
> +    ),
> +
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
>          /*
> @@ -3263,15 +3194,23 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
>  #if defined(TARGET_RISCV32)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cp=
u_init),
> +        .misa_mxl_max =3D MXL_RV32,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
>  #elif defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cp=
u_init),
> +        .misa_mxl_max =3D MXL_RV64,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
>  #endif
> +    ),
>
>  #if defined(TARGET_RISCV32) || \
>      (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
> +        .misa_mxl_max =3D MXL_RV32,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_=
nommu_cpu_init),
> @@ -3288,11 +3227,18 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif
>
>  #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
> +        .misa_mxl_max =3D MXL_RV32,
> +    ),
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cp=
u_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +        .misa_mxl_max =3D MXL_RV64,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_=
u_cpu_init),
> @@ -3302,8 +3248,11 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
> -#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +        .misa_mxl_max =3D MXL_RV128,
> +    ),
> +#endif /* CONFIG_TCG */
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
>          .misa_mxl_max =3D MXL_RV64,
>          .misa_ext =3D RVI
> --
> 2.49.0
>

