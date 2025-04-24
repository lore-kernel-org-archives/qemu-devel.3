Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB5DC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kpB-0008M7-28; Wed, 23 Apr 2025 20:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7knO-0005y3-S4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:31 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7knM-0004cQ-VS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:30 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86fbc8717fcso215289241.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455827; x=1746060627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzJ4VjTv7UiCNY59yEfApfr/zsUNaMfb/CiTUZSZjfg=;
 b=W5DWSvbk5RCCotgJryrs3U6aulGilAMLBvDv73HTVEZ/Fm8gLQfqu/ZQhgXN8uZ22b
 vps2Razzpl4Q81gO7Fu4W5PPkhkz9sU5siSA0jKZdLX7/2IXlZhD2X+9oTxXrTeqM7oj
 9rE1xeZ+vVH2AF8GDkQZsELg2ceAE0kLr/1xLL9NlM7CwXdpWGNT144jBP8QPl/CDLmX
 K6DzpTwDFdwDXCdyCODAX+0s1lqkEdvdcSab9cmrRwBAROdTcixONCWV04+uGCOITgcp
 JsYinSOHeOuGns7c+kaYZZk/NbUpBHOUBhOerfVrwBWYXsiflr3TsY3sbE/YpD+qwYOd
 trlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455827; x=1746060627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzJ4VjTv7UiCNY59yEfApfr/zsUNaMfb/CiTUZSZjfg=;
 b=cwLpiPhjEGfv9ua3dNmMolp7VwH/GhoBMCnKlDIb/E4VMpX0bt3KzrxjQ8sMr+/VV/
 KSc066IBgrmcTBbf2WfsJ89BpfLm5fZ/ww2P6g5SkI8+Ovf1S9hlf7ZjTAl08r2+BWMs
 UF5/1A45OBdcn0W1os3kCHz1iDYMFu4wZCZhDGiDuHoqmNLwSq07CrQ5psSlEaHxmDdk
 QqwaGRJkaQyQ9PT7W+blotmu/UJ37ifElFwZWRmWX1mnw5F5BQ1I3M6w+zzy5cFsAPoo
 MLca2nk7Y2TuaVMyfssIPconB76CXnejUaYbwwgE+dcjPBuZuzB3Kqr0GqjDui/va4R1
 bXMQ==
X-Gm-Message-State: AOJu0YzTycRbuHNKr8FhLi442SiwOS8S3Iqoq1TbdtZOXkzgSRV97GTf
 T0psZQCmVj9nIcpz6bscezFRZz3zp0DaOIBctZwzcSlPHQ4hZOe1bGtHwlgfVe+QIUUy3azwv0a
 Y02Ks2JCr0Add7SCILG261hHQfH+XTg==
X-Gm-Gg: ASbGncuWmUQOIRBzs2I1nVcsSDlkvHQkgOdx1ISgWdh49X+w19bZtkawf1TNxJLc/XL
 3g0srJdV0IahCZXdiC0CrOPn+EnbdW0WdMhEFIIC5ynUxql7aUyiscIdJoNq1BJPxcX08Cbd1sl
 p69bW2EzKXW6Y9ksUgHgQuHP38L+oC6jfawaFEqvN3qkHDhWxz5X8p
X-Google-Smtp-Source: AGHT+IHZrQBx0gHn/f/tNjv3S/6Bc7Ylg6B81DqowEy6PDMyWJWoBeRfNwlXFmb5s9UWreUpPTZHOmqlU0tL5+VHNSk=
X-Received: by 2002:a05:6102:e0d:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4d38eef3e42mr1009481137.19.1745455827183; Wed, 23 Apr 2025
 17:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-15-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-15-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:50:01 +1000
X-Gm-Features: ATxdqUGUiH_Gzx9w6f7f3o8p2h3_vrV9w8HZhCnXu8hIHC7i6dM0yA12syFRpFw
Message-ID: <CAKmqyKMvhAZ18R+n4Vg4_f4Gr_P3o-VFnNt1e0eFwEuQNZ7jow@mail.gmail.com>
Subject: Re: [PATCH 14/27] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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
> Start from the top of the hierarchy: dynamic and vendor CPUs are just
> markers, whereas bare CPUs can have their instance_init function
> replaced by RISCVCPUDef.
>
> The only difference is that the maximum supported SATP mode has to
> be specified separately for 32-bit and 64-bit modes.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  1 +
>  target/riscv/cpu.c | 93 ++++++++++++++++++++++------------------------
>  2 files changed, 46 insertions(+), 48 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index acaa49b979c..d247b9007a6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -547,6 +547,7 @@ typedef struct RISCVCPUDef {
>      int priv_spec;
>      int32_t vext_spec;
>      RISCVCPUConfig cfg;
> +    bool bare;
>  } RISCVCPUDef;
>
>  /**
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 620641fbed6..002f5a15ba2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1482,8 +1482,8 @@ static void riscv_cpu_init(Object *obj)
>       * for all CPUs. Each accelerator will decide what to do when
>       * users disable them.
>       */
> -    RISCV_CPU(obj)->cfg.ext_zicntr =3D true;
> -    RISCV_CPU(obj)->cfg.ext_zihpm =3D true;
> +    RISCV_CPU(obj)->cfg.ext_zicntr =3D !mcc->def->bare;
> +    RISCV_CPU(obj)->cfg.ext_zihpm =3D !mcc->def->bare;
>
>      /* Default values for non-bool cpu properties */
>      cpu->cfg.pmu_mask =3D MAKE_64BIT_MASK(3, 16);
> @@ -1506,36 +1506,6 @@ static void riscv_cpu_init(Object *obj)
>      }
>  }
>
> -static void riscv_bare_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    /*
> -     * Bare CPUs do not inherit the timer and performance
> -     * counters from the parent class (see riscv_cpu_init()
> -     * for info on why the parent enables them).
> -     *
> -     * Users have to explicitly enable these counters for
> -     * bare CPUs.
> -     */
> -    cpu->cfg.ext_zicntr =3D false;
> -    cpu->cfg.ext_zihpm =3D false;
> -
> -    /* Set to QEMU's first supported priv version */
> -    cpu->env.priv_ver =3D PRIV_VERSION_1_10_0;
> -
> -    /*
> -     * Support all available satp_mode settings. The default
> -     * value will be set to MBARE if the user doesn't set
> -     * satp_mode manually (see set_satp_mode_default()).
> -     */
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj),
> -        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> -        VM_1_10_SV32 : VM_1_10_SV57);
> -#endif
> -}
> -
>  typedef struct misa_ext_info {
>      const char *name;
>      const char *description;
> @@ -3106,6 +3076,7 @@ static void riscv_cpu_class_base_init(ObjectClass *=
c, void *data)
>
>      if (data) {
>          const RISCVCPUDef *def =3D data;
> +        mcc->def->bare |=3D def->bare;
>          if (def->misa_mxl_max) {
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> @@ -3259,6 +3230,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>          }),                                                 \
>      }
>
> +#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
> +    {                                                       \
> +        .name =3D (type_name),                                \
> +        .parent =3D (parent_type_name),                       \
> +        .abstract =3D true,                                   \
> +        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
> +             __VA_ARGS__                                    \
> +        }),                                                 \
> +    }
> +
>  #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3285,22 +3269,35 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
>          .class_init =3D riscv_cpu_common_class_init,
>          .class_base_init =3D riscv_cpu_class_base_init,
>      },
> -    {
> -        .name =3D TYPE_RISCV_DYNAMIC_CPU,
> -        .parent =3D TYPE_RISCV_CPU,
> -        .abstract =3D true,
> -    },
> -    {
> -        .name =3D TYPE_RISCV_VENDOR_CPU,
> -        .parent =3D TYPE_RISCV_CPU,
> -        .abstract =3D true,
> -    },
> -    {
> -        .name =3D TYPE_RISCV_BARE_CPU,
> -        .parent =3D TYPE_RISCV_CPU,
> -        .instance_init =3D riscv_bare_cpu_init,
> -        .abstract =3D true,
> -    },
> +
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
> +    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
> +        /*
> +         * Bare CPUs do not inherit the timer and performance
> +         * counters from the parent class (see riscv_cpu_init()
> +         * for info on why the parent enables them).
> +         *
> +         * Users have to explicitly enable these counters for
> +         * bare CPUs.
> +         */
> +        .bare =3D true,
> +
> +        /* Set to QEMU's first supported priv version */
> +        .priv_spec =3D PRIV_VERSION_1_10_0,
> +
> +        /*
> +         * Support all available satp_mode settings. By default
> +         * only MBARE will be available if the user doesn't enable
> +         * a mode manually (see riscv_cpu_satp_mode_finalize()).
> +         */
> +#ifdef TARGET_RISCV32
> +        .cfg.max_satp_mode =3D VM_1_10_SV32,
> +#else
> +        .cfg.max_satp_mode =3D VM_1_10_SV57,
> +#endif
> +    ),
> +
>  #if defined(TARGET_RISCV32)
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cp=
u_init),
>  #elif defined(TARGET_RISCV64)
> --
> 2.49.0
>

