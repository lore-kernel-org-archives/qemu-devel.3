Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77599C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRB1-00014T-NP; Thu, 15 May 2025 01:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRAz-00010Z-JZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:30:37 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRAx-0006fq-Mf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:30:37 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4def06b6f87so181013137.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287034; x=1747891834; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5hA8LkXQ28EQdII89lAsVru4Yjh8W2w9Qm2GmoNVlI=;
 b=Xe7vYg6G0mpnoYZ/EHzj2Up5YRfylW8Ari9Nyw6yi3uIIvekfWRisDFt2vj4erfDko
 P6Y+cnJu1xusouULWNLG01wh7xXXmTyCTZmXtUJ+jQ8uaB4iCYxpvU0nn0+rlUseA6Gi
 U1F/bQl7tqKqe27ARPYM3hou+PGonuGNQy2nw1Let/zrHN7UgjmMuDJz2SiaqJ+NoafD
 AYL2WcJ9xVUq2ql5f/CfKe5KLimsO4JC9GmeL89uv7/+MqzJoFPA5cR+2WW1ocirKGga
 PBowTcMXFbSx2ed0d/FJ4mbCz/yKrkjmMew8c3f+PMCQPvfK0VFJukz62jSZlYvIiSpu
 PMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287034; x=1747891834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5hA8LkXQ28EQdII89lAsVru4Yjh8W2w9Qm2GmoNVlI=;
 b=D8A9HjSO+OrUoSseVULgoCtZNxyvTxXX7NEmgzsPG1wJYlveJSPa2y6nCgVtj0dm3z
 aJ2d3scIaK6tyOfucmAb/QhdM5RSbWY8aiP7T2y9+M1FHxmmqQuwTCd/7TzSG40sMYtX
 rZjCWQjkiUHl04DU8HrK2PyjEcQ7jVl/Cwt3LGwRbifNdvCNZxcZCj7KmwQ7tAuBA0RH
 ehSxk0foF8C3wiv0ZRQaGoZX8QdRUNMJE6eL4W299f6RiqF4TxMxKfUFkfhaH7YiTiyS
 PYcmIoUfFBynwwuXxLIXT873S2qwc8yXjUNEx5Ql9ioyItS/CoYtVxSLK8fkmta0m0RX
 ejpw==
X-Gm-Message-State: AOJu0Yy3EybM8sS3KD591z4v0Kks56qHw6+a7/O2OkjWzcVziarCNdWd
 pvOCTtjTjzKcZZSCTGnuBiYBm9dYowOTmblnIun2/XCSl49xNJ0IdkXf9qosQJxU/yct3WTJ2Ur
 gF2By8jc7PeudAbd4Yrd+IE+mj0E=
X-Gm-Gg: ASbGncteR3i8RH710K4N26mqGK6D4AILtMeC6bKOJJN0lnkHEu8FlDfThyqNFdtWuPZ
 B97Vy7ioPTTBP2Ypcoa1YybO2L+Z2+Himohed7sAdcFfvS9WaDyHWHkHwHRPkHAwPkRLk/3T9ab
 fXWW/yVVyiglulxiixaQD8CEu2atp098/I7RFMNAGL3F/xtqXk3aZt7D8GwEYrN8c=
X-Google-Smtp-Source: AGHT+IExC9NFtyXK6CuWKg4MgN+4qPTCP/LGZpUiCuOC2w9r2VnKoXQyj7HUYRNnhV0hPFuzE8h4CdZNK/J6qBGmmkY=
X-Received: by 2002:a05:6102:4b8c:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4df95676493mr892787137.19.1747287034245; Wed, 14 May 2025
 22:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-15-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-15-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:30:08 +1000
X-Gm-Features: AX0GCFsHmX1wetSmWbzRfB9CxBSuzhgoEliLpfey7n1-0_bxpXXLIGWlworwXSk
Message-ID: <CAKmqyKMyeVCETOC7j5R5F=3sZVLeAAg5vpsHfAwCR6g7QbvqWA@mail.gmail.com>
Subject: Re: [PATCH 14/26] target/riscv: convert bare CPU models to RISCVCPUDef
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
>  target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 41 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 06c612afba7..af5b4af4814 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -732,18 +732,6 @@ static void rv128_base_cpu_init(Object *obj)
>  }
>  #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
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
> @@ -836,18 +824,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
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
> @@ -3216,19 +3192,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>          }),                                                 \
>      }
>
> -#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_BARE_CPU,                      \
> -        .instance_init =3D (initfn),                          \
> -        .class_data =3D &(const RISCVCPUDef) {                \
> -             .misa_mxl_max =3D (misa_mxl_max_),               \
> -             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> -             .cfg.max_satp_mode =3D -1,                       \
> -        },                                                  \
> -    }
> -
>  #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3313,8 +3276,15 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
> @@ -3334,8 +3304,14 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
>  #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
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

