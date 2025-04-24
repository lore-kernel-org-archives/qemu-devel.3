Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EBEC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kCc-0007pe-2Z; Wed, 23 Apr 2025 20:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kCa-0007pK-G7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:12:28 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kCY-0000Xr-AJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:12:28 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51eb18130f9so250463e0c.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745453544; x=1746058344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRAiO39WpHN8Z0y2Bor3AgT1sUmpQ6twK3Y2iHlmlrY=;
 b=equDsMOwwscjc5bfAQZ5M9VVtdABUmbXDqqnuisTF7J0prNxVNgmPU8zm+z2Cui4U6
 5GSX7wnMHvOndhf523l14rkSGVIfxeypCZ7A5R2WPnk2y2PInsnFOoZQ5hDOd1oKO03k
 52Av3RdPANj1EjDu/0k3SEUnGQXiiAtEdada0i/saZq/DtAZ2ojSX4C/oIK8vkOMTmlD
 p1OPRyuPlEH6xKLyZpzTRXr+bRUfnsSzx0jIAR/p+3RiwjgNisRgGLJ1iZz21MQP2MRe
 HqLTWzo/DyB7vZUU3SHNOMgCRoZ+2PH73Pirq2jr0TX8wTQfNqsHlXDDuXqKX7XGXegM
 fhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745453544; x=1746058344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRAiO39WpHN8Z0y2Bor3AgT1sUmpQ6twK3Y2iHlmlrY=;
 b=GPfYazea4e3MGU3whNmO+IpX4tYDf3LUyGQDRET/7AhUm1FFbf5DFXR6GSmeektK3B
 KRW4KSOGd6GTvQ1chga8FqfpsaTf7M3fknNrcdkmZkTVqra2J3l2ImrcQOYBH1OR+DAf
 0u/4yp68F/J49y5NM6i9aX01poHHjdoA6GTTtfMhQ0n5xjMYr7kO6W0lLUtBbhzc+KiE
 ra49jIXKFLG1w7N9mdi+aFQtneffxE673eKhJfvmw6dOG6MBOpmEt2H8meIA9nTrO7Eb
 aIUzKRPubjgyaR3r3HhZWo3JQ34uYx5jq5WSCnH74TWO6uM2sIPTDVafC5UawLQ64fPI
 ySOA==
X-Gm-Message-State: AOJu0Yz5hx+EGPbucdFKwB+Yr0PKTKs1f40eZF9Yu4c3f1yDlf7uqEHS
 O+pxWXssi2eGnNm7W7pwJPiKz4MYYr9Fcxl21Zup116AHB/PpZma8H1XqD53+SgDSteOqVlnIX+
 LVLfv9lDjpzgPjcg3oxogZ9Fy22A=
X-Gm-Gg: ASbGncsdOXlh0ZHWdopNjB2IY8Mu0NH5q2rK5HlhVWiT4gdcdqu8QKDixUGjaxaJAt9
 qxpH4kklIvEPZHPAIFlUZhSplT3qEB5efD6xH5uR3ih8u9oStNIJcua1T+9Lvtrkc7LRpVJFJyV
 TxiqQFcBJOelm5C11ayLvm+F8pPDlgRZwO4kcW1/qXsfiKHjnj7rTN
X-Google-Smtp-Source: AGHT+IFM9yu3Qkhoe5iqVZ2cqw5vzw7mUa7QlfTgrNLqbhx7bZMR7a1X9Bf25Ba12rHfunWQsCJrIwW4HVAiWijjPEo=
X-Received: by 2002:a05:6122:1353:b0:526:2210:5b64 with SMTP id
 71dfb90a1353d-52a7840b1e6mr687174e0c.9.1745453544041; Wed, 23 Apr 2025
 17:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-16-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-16-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:11:58 +1000
X-Gm-Features: ATxdqUHW2RWGogpStlk5mBJWtmSmnsNXEyBfcZJogCt8MuBtyrUgyBZyHjWr0GA
Message-ID: <CAKmqyKMhiqi9BZDaXCjsqBaW-t30cD9TzT52wXviD-T56JHgjA@mail.gmail.com>
Subject: Re: [PATCH 15/27] target/riscv: convert profile CPU models to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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
> Profile CPUs reuse the instance_init function for bare CPUs; make them
> proper subclasses instead.  Enabling a profile is now done based on the
> RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef=
,
> subclasses check that the parent class's profile is enabled through the
> parent profile mechanism.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  1 +
>  target/riscv/cpu.c | 85 +++++++++++++++++++++++++---------------------
>  2 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d247b9007a6..54dc4cc85d0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -543,6 +543,7 @@ struct ArchCPU {
>
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVCPUProfile *profile;
>      uint32_t misa_ext;
>      int priv_spec;
>      int32_t vext_spec;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 002f5a15ba2..d3d5c048d02 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1495,6 +1495,10 @@ static void riscv_cpu_init(Object *obj)
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
>
> +    if (mcc->def->profile) {
> +        mcc->def->profile->enabled =3D true;
> +    }
> +
>      env->misa_ext_mask =3D env->misa_ext =3D mcc->def->misa_ext;
>      riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
>
> @@ -2967,36 +2971,6 @@ static const Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
>  };
>
> -#if defined(TARGET_RISCV64)
> -static void rva22u64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA22U64.enabled =3D true;
> -}
> -
> -static void rva22s64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA22S64.enabled =3D true;
> -}
> -
> -static void rva23u64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA23U64.enabled =3D true;
> -}
> -
> -static void rva23s64_profile_cpu_init(Object *obj)
> -{
> -    rv64i_bare_cpu_init(obj);
> -
> -    RVA23S64.enabled =3D true;
> -}
> -#endif
> -
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -3063,6 +3037,32 @@ static void riscv_cpu_common_class_init(ObjectClas=
s *c, void *data)
>      device_class_set_props(dc, riscv_cpu_properties);
>  }
>
> +static bool profile_extends(RISCVCPUProfile *trial, RISCVCPUProfile *par=
ent)
> +{
> +    RISCVCPUProfile *curr;
> +    if (!parent) {
> +        return true;
> +    }
> +
> +    curr =3D trial;
> +    while (curr) {
> +        if (curr =3D=3D parent) {
> +            return true;
> +        }
> +        curr =3D curr->u_parent;
> +    }
> +
> +    curr =3D trial;
> +    while (curr) {
> +        if (curr =3D=3D parent) {
> +            return true;
> +        }
> +        curr =3D curr->s_parent;
> +    }
> +
> +    return false;
> +}
> +
>  static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> @@ -3077,6 +3077,11 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, void *data)
>      if (data) {
>          const RISCVCPUDef *def =3D data;
>          mcc->def->bare |=3D def->bare;
> +        if (def->profile) {
> +            assert(profile_extends(def->profile, mcc->def->profile));
> +            assert(mcc->def->bare);
> +            mcc->def->profile =3D def->profile;
> +        }
>          if (def->misa_mxl_max) {
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> @@ -3243,19 +3248,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt=
, char *nodename)
>          }),                                                 \
>      }
>
> -#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
> +#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
>      {                                                       \
>          .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_BARE_CPU,                      \
> -        .instance_init =3D (initfn),                          \
> +        .parent =3D (parent_type_name),                       \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
>               .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
>               .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
>               .cfg.max_satp_mode =3D -1,                       \
> +             __VA_ARGS__                                    \
>          }),                                                 \
>      }
>
> +#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
> +    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
> +        .profile =3D &(profile_))
> +
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU,
> @@ -3334,10 +3342,11 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>  #endif /* CONFIG_TCG */
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_c=
pu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_c=
pu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_pro=
file_cpu_init),
> -    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_pro=
file_cpu_init),
> +
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  =
RVA22U64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  =
RVA22S64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  =
RVA23U64),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  =
RVA23S64),
>  #endif /* TARGET_RISCV64 */
>  };
>
> --
> 2.49.0
>

