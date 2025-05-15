Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADADC54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 04:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFQZK-0001u1-PV; Thu, 15 May 2025 00:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQZF-0001to-OT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:51:37 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQZD-0002BL-Sb
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:51:37 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4def2870995so396464137.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 21:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747284694; x=1747889494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOpfz8ZpCVXDrfyRpWknxxtujZJaQ/zd5KCOOOQn2kY=;
 b=aiLh1FAXqpwRjOuIpqEgDYDifrMPAhak8g7TqBuRO2Zbj9AL0XNy1FvWvKcqJS86yE
 cPqwX3sq0qhc6n2L51wYqwq19df5WqsaPZVVTgB1Eqm0Y6l+BADobm2cuNa/P/7q+LCV
 aPWOjpcAAoPidZgvDjwTKYJQ4CJp8HYiPJt9loyjmN4iFHgZ+AsYLApo+Az4CuXGsZgD
 cE82p3hTkzF1UODMfSroOrPGDbHy9sM1Uq704j3BhoXxXFXbGU9u+2A/fmGx9hxU66CE
 rlt5fDEE6nk+AUuNMyvpTLNXBDGrqj7BiSf+fwsEqaeUgPzyuk+1gc8dkruW2v2yPy5d
 WbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747284694; x=1747889494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOpfz8ZpCVXDrfyRpWknxxtujZJaQ/zd5KCOOOQn2kY=;
 b=M7zeb5femoUSNAIOQV34ByvQQBM/E7jaeCD0/KmlJNNduGzyYn3/au0D60ulgaVaKU
 3XUEFq14YouLDkY5qTdWaAc62I9uZcNu+UfTuc5kebOl/iuSJdcao4RqVQ1Y5cZN14Yk
 z/EVeqRE/Hwxssco3qBmMXhQAyg1DO1dceY1MLX8LCuscSoc2Se/4zXGNwygJEX/1Jol
 AY/wkcldROyDxgtnikxLjWRYJtiesf5pROY8qmF1sOkDjCLIlpHW9oAP5/3EvnO4sh9d
 HJplC1UeVYlQDAuEwAgSlSorKFH/ahFv8DS9neFbuJ/B0N0xgNgSH9vxarYyBvwwowzm
 LkRA==
X-Gm-Message-State: AOJu0Yw3IVfBWWWngIg60sK4XotKZYPDIIkLTV3XlHX7Fy1jo+MyqjdY
 wbyBDOZ3mUyqAaAO6Bc769dE1MS3wIGgRM1KAnP25U30yFxQ4ruC0+b5mNeg///ymq47MCOVI8+
 5ceIC8t3SKB/bHhmePrX05eUirvc4woH/RQ==
X-Gm-Gg: ASbGncv2FTpjukC8Oy8px8OTws9zd8zLFm2mtru0alHqn1tk55VFVd6HfZumciTqPsY
 ZITMT9PF+rUoHQ+IO8Auw4HnovFiSN/YOSMsUShc8RmI93nBnnwlQEYDWtOMYBA3A2hCSx/lLvD
 UGDQAtnmqod/VqLs4ZZgzLPa4v15x5M3Y1tuwS80KkKHokzt1iwLJMO8Lum8dfxCo=
X-Google-Smtp-Source: AGHT+IH1vCVc9aiD3LgUCuH3q5XJB+brKAeIkoReqlCgJ8wlJKCIvIJ/hb21a5daNmfpQAhkk9F6tZMRnMAWNRf78A8=
X-Received: by 2002:a67:f497:0:b0:4c3:69f:5be with SMTP id
 ada2fe7eead31-4df900d4734mr1658336137.7.1747284694183; 
 Wed, 14 May 2025 21:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-7-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-7-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 14:51:08 +1000
X-Gm-Features: AX0GCFv9z-Vqsi_JnXDuRYvtPjEJJwEZ1nGnllXExJ2fNnj8ntunpxIYEnsFc1w
Message-ID: <CAKmqyKN+wK7DL7-t=5O60XcGLX24iHDsx=M8NwWo8QWphtQOcQ@mail.gmail.com>
Subject: Re: [PATCH 06/26] target/riscv: introduce RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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
> Start putting all the CPU definitions in a struct.  Later this will repla=
ce
> instance_init functions with declarative code, for now just remove the
> ugly cast of class_data.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  4 ++++
>  target/riscv/cpu.c | 27 ++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8b23aa27740..511fc25adc0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -537,6 +537,10 @@ struct ArchCPU {
>      const GPtrArray *decoders;
>  };
>
> +typedef struct RISCVCPUDef {
> +    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +} RISCVCPUDef;
> +
>  /**
>   * RISCVCPUClass:
>   * @parent_realize: The parent class' realize handler.
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 54a996c2927..c163b2b24a2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3073,8 +3073,9 @@ static void riscv_cpu_common_class_init(ObjectClass=
 *c, const void *data)
>  static void riscv_cpu_class_init(ObjectClass *c, const void *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> +    const RISCVCPUDef *def =3D data;
>
> -    mcc->misa_mxl_max =3D (RISCVMXL)GPOINTER_TO_UINT(data);
> +    mcc->misa_mxl_max =3D def->misa_mxl_max;
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> @@ -3170,40 +3171,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt=
, char *nodename)
>  }
>  #endif
>
> -#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
> +#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D &(const RISCVCPUDef) {                \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        },                                                  \
>      }
>
> -#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
> +#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D &(const RISCVCPUDef) {                \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        },                                                  \
>      }
>
> -#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
> +#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D &(const RISCVCPUDef) {                \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        },                                                  \
>      }
>
> -#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
> +#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D &(const RISCVCPUDef) {                \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        },                                                  \
>      }
>
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
> --
> 2.49.0
>

