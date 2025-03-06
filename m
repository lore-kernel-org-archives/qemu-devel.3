Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE85C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzSV-0004yf-C3; Wed, 05 Mar 2025 19:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzST-0004yP-Dv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:51:29 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzSR-0002sT-8v
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:51:29 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f674752049so88738b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741222285; x=1741827085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmB668XGsJABkAz1MO/KxfPo239POip+zS5Q6MVm9q0=;
 b=P/iCWXt1/R6phjn4/+KbMVlGJ4XhEKKjEZGWowo9l7rKEWQrmQFF0cbeiKDiVIEZxI
 FcL4HwCZo55+LdvK224d5SrwaZvviSQLvvIQFW+Er1pYI5G+XHAaGYGSRlPIt6i+H0nM
 8ScoQxauvV/nOep/4jSHlenXIXHr10dEBUlabO1WEFp23T+Dbj+CQdhoOu4Yep+q4X0a
 T4fXuYVA7TWdFGRmfa3PryL39cCawBmlN5+LkshoCphEnPhCYMilEF3ahqwQnpK5eUqS
 +Ur3W4qURi3GEiS2V76ZnU4GnM1/L7IhQH8zxgQMZL6i+hTJpE5dPbpAHVks2mGArBqF
 M6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741222285; x=1741827085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmB668XGsJABkAz1MO/KxfPo239POip+zS5Q6MVm9q0=;
 b=UCfr3Gxf52kZk9CIk+VlfW6SwYT2CmuwOn18xipNFndXZIK8Cz+PJcttmrQ/G0u4eg
 jNzb0uG8pjfEks1U8eLtyHgHOoVcBY3mEhkyMgJm8hyyPKoNbjzbYW3bri8LDBIVdf4B
 S8CNTfhVKgZyvKu15vhYja158pTbEtO7/0Q2P+i3M3kbfbf2NNqz/i3WMalFHeefDjgP
 y3X2dF5q7RJbwPE43UVui0JdrgSEkumwg77vWqR/UIcV47aaMkb0YVLbuWwt7n6VYL+I
 O3bbDGtsiTzqU0GYQQkwNMF4N7gCUz8RDoeYIxBHshd7mQ58FHqGeKDaY6s/C/GjaQSU
 AN/w==
X-Gm-Message-State: AOJu0Yyx5cHhHXz1eQQ7x6+zI/wQwNai+UzPqjg4PTUmr4eRrgA5//tf
 d2G3zx4ApiQKDxLduR9maMBa8PsoV//vnKLoZ0VAUD1sHSEj9l28IaGJmIzEDXGTNBlfS+zGVAb
 aYe+VV9ZcsotscGF5rHQSirvRAFc2pDFalyM=
X-Gm-Gg: ASbGncv2FiPeg1bhM4HNojfBrHYLiROW+VJoEVDmFFOfoiSoFFP222S9wpW+PwxDmXy
 /gkcSpUX8ltHU0jJ6Qrf0S/4j9Y88ttuWDJAvsxgkotRsI4MH9YN3SUO8Fr78vca0vo/5njp0Su
 /Hf7Hp+JhTQNJB3x4rrSqIekpxpVUKpjQA78F9mFhM2KQ/fjTUzZfeubEe
X-Google-Smtp-Source: AGHT+IG5OWaGjD//8ehgpjBgsDd/HdDqFx9f+/WUD4yC+kauxLnAlo79BY8mzLqTzVHDKgULL4FNXuEPe/ZQEq+QkVs=
X-Received: by 2002:a05:6102:4193:b0:4be:6151:dfd8 with SMTP id
 ada2fe7eead31-4c2f673b03cmr1214405137.10.1741222274577; Wed, 05 Mar 2025
 16:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-5-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-5-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:50:48 +1000
X-Gm-Features: AQ5f1JpkbE9Op2x3Pzmx3wQhalN2sC-q6vyFscErbJ2qGq_XOcQ36I2ul3w1BGk
Message-ID: <CAKmqyKPmNouy1sUpBxUujaLC8F5cf_+N4OhSnE2WB6znFT-G9w@mail.gmail.com>
Subject: Re: [PATCH 04/22] target/riscv: store RISCVCPUDef struct directly in
 the class
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
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

On Fri, Feb 28, 2025 at 8:31=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Prepare for adding more fields to RISCVCPUDef and reading them in
> riscv_cpu_init: instead of storing the misa_mxl_max field in
> RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
> and go through it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  2 +-
>  hw/riscv/boot.c            |  2 +-
>  target/riscv/cpu.c         | 23 ++++++++++++++++++-----
>  target/riscv/gdbstub.c     |  6 +++---
>  target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
>  target/riscv/machine.c     |  6 +++---
>  target/riscv/tcg/tcg-cpu.c | 10 +++++-----
>  target/riscv/translate.c   |  2 +-
>  8 files changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 743afeb1655..a038122f80c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -547,7 +547,7 @@ struct RISCVCPUClass {
>
>      DeviceRealize parent_realize;
>      ResettablePhases parent_phases;
> -    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVCPUDef *def;
>  };
>
>  static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index c309441b7d8..13728e137c4 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -37,7 +37,7 @@
>  bool riscv_is_32bit(RISCVHartArrayState *harts)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(&harts->harts[0]);
> -    return mcc->misa_mxl_max =3D=3D MXL_RV32;
> +    return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
>  }
>
>  /*
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a71d806e35f..51acce07752 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -354,7 +354,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint3=
2_t ext)
>
>  int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
>  {
> -    return 16 << mcc->misa_mxl_max;
> +    return 16 << mcc->def->misa_mxl_max;
>  }
>
>  #ifndef CONFIG_USER_ONLY
> @@ -1054,7 +1054,7 @@ static void riscv_cpu_reset_hold(Object *obj, Reset=
Type type)
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
> -    env->misa_mxl =3D mcc->misa_mxl_max;
> +    env->misa_mxl =3D mcc->def->misa_mxl_max;
>      env->priv =3D PRV_M;
>      env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>      if (env->misa_mxl > MXL_RV32) {
> @@ -1447,7 +1447,7 @@ static void riscv_cpu_init(Object *obj)
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>      CPURISCVState *env =3D &cpu->env;
>
> -    env->misa_mxl =3D mcc->misa_mxl_max;
> +    env->misa_mxl =3D mcc->def->misa_mxl_max;
>
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> @@ -1544,7 +1544,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUCla=
ss *mcc)
>      CPUClass *cc =3D CPU_CLASS(mcc);
>
>      /* Validate that MISA_MXL is set properly. */
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>  #ifdef TARGET_RISCV64
>      case MXL_RV64:
>      case MXL_RV128:
> @@ -2957,12 +2957,24 @@ static void riscv_cpu_common_class_init(ObjectCla=
ss *c, void *data)
>      device_class_set_props(dc, riscv_cpu_properties);
>  }
>
> +static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
> +{
> +    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> +    RISCVCPUClass *pcc =3D RISCV_CPU_CLASS(object_class_get_parent(c));
> +
> +    if (pcc->def) {
> +        mcc->def =3D g_memdup2(pcc->def, sizeof(*pcc->def));
> +    } else {
> +        mcc->def =3D g_new0(RISCVCPUDef, 1);
> +    }
> +}
> +
>  static void riscv_cpu_class_init(ObjectClass *c, void *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
>      const RISCVCPUDef *def =3D data;
>
> -    mcc->misa_mxl_max =3D def->misa_mxl_max;
> +    mcc->def->misa_mxl_max =3D def->misa_mxl_max;
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> @@ -3113,6 +3125,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .abstract =3D true,
>          .class_size =3D sizeof(RISCVCPUClass),
>          .class_init =3D riscv_cpu_common_class_init,
> +        .class_base_init =3D riscv_cpu_class_base_init,
>      },
>      {
>          .name =3D TYPE_RISCV_DYNAMIC_CPU,
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 18e88f416af..1934f919c01 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -62,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>          return 0;
>      }
>
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
>          return gdb_get_reg32(mem_buf, tmp);
>      case MXL_RV64:
> @@ -82,7 +82,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t =
*mem_buf, int n)
>      int length =3D 0;
>      target_ulong tmp;
>
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
>          tmp =3D (int32_t)ldl_p(mem_buf);
>          length =3D 4;
> @@ -359,7 +359,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
e *cs)
>                                   ricsv_gen_dynamic_vector_feature(cs, cs=
->gdb_num_regs),
>                                   0);
>      }
> -    switch (mcc->misa_mxl_max) {
> +    switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
>          gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
>                                   riscv_gdb_set_virtual,
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 23ce7793594..f3ec4f33931 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1985,22 +1985,19 @@ static void kvm_cpu_accel_register_types(void)
>  }
>  type_init(kvm_cpu_accel_register_types);
>
> -static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
> -{
> -    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> -
> -#if defined(TARGET_RISCV32)
> -    mcc->misa_mxl_max =3D MXL_RV32;
> -#elif defined(TARGET_RISCV64)
> -    mcc->misa_mxl_max =3D MXL_RV64;
> -#endif
> -}
> -
>  static const TypeInfo riscv_kvm_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU_HOST,
>          .parent =3D TYPE_RISCV_CPU,
> -        .class_init =3D riscv_host_cpu_class_init,
> +#if defined(TARGET_RISCV32)
> +        .class_data =3D &((const RISCVCPUDef) {
> +            .misa_mxl_max =3D MXL_RV32,
> +        },
> +#elif defined(TARGET_RISCV64)
> +        .class_data =3D &((const RISCVCPUDef) {
> +            .misa_mxl_max =3D MXL_RV64,
> +        },
> +#endif
>      }
>  };
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index c3d8e7c4005..98d20afd04d 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -170,7 +170,7 @@ static bool rv128_needed(void *opaque)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(opaque);
>
> -    return mcc->misa_mxl_max =3D=3D MXL_RV128;
> +    return mcc->def->misa_mxl_max =3D=3D MXL_RV128;
>  }
>
>  static const VMStateDescription vmstate_rv128 =3D {
> @@ -383,8 +383,8 @@ static bool riscv_validate_misa_mxl(void *opaque, int=
 version_id)
>      uint32_t misa_mxl_saved =3D env->misa_mxl;
>
>      /* Preserve misa_mxl even if the migration stream corrupted it  */
> -    env->misa_mxl =3D mcc->misa_mxl_max;
> -    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> +    env->misa_mxl =3D mcc->def->misa_mxl_max;
> +    return misa_mxl_saved =3D=3D mcc->def->misa_mxl_max;
>  }
>
>  const VMStateDescription vmstate_riscv_cpu =3D {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index e5e01715f10..f434b2448db 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -579,7 +579,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,=
 Error **errp)
>          return;
>      }
>
> -    if (mcc->misa_mxl_max !=3D MXL_RV32 && cpu->cfg.ext_zcf) {
> +    if (mcc->def->misa_mxl_max !=3D MXL_RV32 && cpu->cfg.ext_zcf) {
>          error_setg(errp, "Zcf extension is only relevant to RV32");
>          return;
>      }
> @@ -676,7 +676,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,=
 Error **errp)
>          return;
>      }
>
> -    if (mcc->misa_mxl_max =3D=3D MXL_RV32 && cpu->cfg.ext_svukte) {
> +    if (mcc->def->misa_mxl_max =3D=3D MXL_RV32 && cpu->cfg.ext_svukte) {
>          error_setg(errp, "svukte is not supported for RV32");
>          return;
>      }
> @@ -891,7 +891,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu=
)
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
>
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max =3D=3D MXL_RV32=
) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max =3D=3D MXL=
_RV32) {
>              cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>          }
>      }
> @@ -900,7 +900,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu=
)
>      if (riscv_has_ext(env, RVC) && env->priv_ver >=3D PRIV_VERSION_1_12_=
0) {
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
>
> -        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max =3D=3D MXL_RV32=
) {
> +        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max =3D=3D MXL=
_RV32) {
>              cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>          }
>
> @@ -1024,7 +1024,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Err=
or **errp)
>          return false;
>      }
>
> -    if (mcc->misa_mxl_max >=3D MXL_RV128 && qemu_tcg_mttcg_enabled()) {
> +    if (mcc->def->misa_mxl_max >=3D MXL_RV128 && qemu_tcg_mttcg_enabled(=
)) {
>          /* Missing 128-bit aligned atomics */
>          error_setg(errp,
>                     "128-bit RISC-V currently does not work with Multi "
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 698b74f7a8f..782e724a648 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1234,7 +1234,7 @@ static void riscv_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cs)
>      ctx->cfg_vta_all_1s =3D cpu->cfg.rvv_ta_all_1s;
>      ctx->vstart_eq_zero =3D FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZER=
O);
>      ctx->vl_eq_vlmax =3D FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> -    ctx->misa_mxl_max =3D mcc->misa_mxl_max;
> +    ctx->misa_mxl_max =3D mcc->def->misa_mxl_max;
>      ctx->xl =3D FIELD_EX32(tb_flags, TB_FLAGS, XL);
>      ctx->address_xl =3D FIELD_EX32(tb_flags, TB_FLAGS, AXL);
>      ctx->cs =3D cs;
> --
> 2.48.1
>
>

