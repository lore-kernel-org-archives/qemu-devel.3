Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC75C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRFg-0003ar-Ko; Thu, 15 May 2025 01:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRFe-0003aP-MW
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:35:26 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRFc-00076E-LY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:35:26 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-878440ee153so137885241.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287323; x=1747892123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAkC+rNgBl1xc6R1HpkgyTigwnjZa0cLvNCt5jKyD5o=;
 b=QlQzf0xfl3JM3HylpbZ2xB+J3SpRAvaVwkZCvthIVl3Erg5N11GQicW4H1N0CNb/wF
 8LJQe8T1sd0gQFLKbIEOpp/KHEuEAQFj1b9TE3uGMGz6IuS8yOrafydABK9s7hFXj5w+
 nv//XODnEAPuPoHrDnATbh51KHZKdi5FGjiu8yj7jPsqDtFlExTa1SjjCLgU5Lm5ibMC
 IVbLJJMcQutHHLGyYxHEDPX1fCnZLWZeftZRXEMgih+HjzUE0z8vsnPC6LK7pCrcG3yB
 2UWGvyrGUU8kidg2z8Bts5tJ0QcaNhl/WepYx1zszUcd7V8ffTN6uDdIY4LrMCJaawvy
 tayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287323; x=1747892123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAkC+rNgBl1xc6R1HpkgyTigwnjZa0cLvNCt5jKyD5o=;
 b=cOlan885oGpiWj+Yu4DfKCmTF62e4WTgWowgSIHW8oXG+drPjuCp3LCr20fYet0mCu
 bT0VwkaTQbE0MBbMqwobMVAkfFyv6vhTzY8uMYsWfL8e3pIxN4Whwdm/7aa+Gj3l6PdA
 8JwELfns9OmPDYswpxFR1weDSjGJA2MMfvand88yGr6wiYEO9oAbMTeZAxL3FlbElSjg
 O1p7k3DCjnXc2bYlj32KQcEdidVS3m7JFYQ3kMpZUEVlamtD6TRZPNmHjBTkj/QMJ9XF
 lSht/wyOvU70Dy9kqIA5prcuum4Kk+xYfqOPD4CEjUYg9LQcU7SCJGbtOt9o4oqs5jU0
 FSrA==
X-Gm-Message-State: AOJu0Yw4inH0Q6UdZhpaSOfIJpfoSTs40vIgv+Jb8mSJIPC7XL2Mxea6
 4BwOWYD1Bejc7hkOSj2tT7o8UtzjX75XixzuhAx6jeSw+nILdZUysbM7J3PXu51wMCi02jndNdH
 rXeaNUnpdedU71VoBroOxHXDZUdOkXw==
X-Gm-Gg: ASbGnct85XCURySQ/9pytoOcxK96A2MHXrotuqy6o2y4ET7imEA8rQP+pMkP7uhfOdY
 Vyo500NqV4gEn9ApHFPdjtwALExCl3MSbTIDex0cAhm0TfxZHPT0kNBiIqbtQdGCmxVint2/grj
 BnPdvrM2cCl4zLUH2eBUoA0swFoUYEHXtl5A91q+UQl2yU8PkfbEJtl+ttq41ZY34=
X-Google-Smtp-Source: AGHT+IH9kOaQ4blrTvREFXhKydzI3b1XA9NWZJJ/qWwjnNiaPrHN4RuUQmXrCbbMFJ3Mnmuk0QMDGZJgrSWjcXK0DvQ=
X-Received: by 2002:a05:6102:1586:b0:4c1:992c:b95d with SMTP id
 ada2fe7eead31-4df7dda93e6mr5952293137.17.1747287322895; Wed, 14 May 2025
 22:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-19-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-19-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:34:56 +1000
X-Gm-Features: AX0GCFs_1EqEqf9lcF12ty5aDu7AdbLYfhFLBN7cRf7RDM0MRe_ZgS8ku6lHvjk
Message-ID: <CAKmqyKPVpBxEJFgVb5PXAaRBd83-Yc-1M4ZtGsfjX6+wdLshMA@mail.gmail.com>
Subject: Re: [PATCH 18/26] target/riscv: convert SiFive U models to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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
> index 661b2384d82..171f27fdd87 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -440,8 +440,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
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
> @@ -486,23 +486,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
> @@ -671,27 +654,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *ob=
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
> @@ -2921,6 +2883,17 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, const void *data)
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
> @@ -3140,6 +3113,17 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
> @@ -3171,7 +3155,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
> @@ -3199,8 +3185,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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

