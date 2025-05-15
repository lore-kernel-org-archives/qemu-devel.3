Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456ACC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFR95-0008Fz-CN; Thu, 15 May 2025 01:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFR93-0008FS-5W
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:28:37 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFR91-0006Jl-B3
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:28:36 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52d9a275c27so384364e0c.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747286913; x=1747891713; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9J+gk0eH1W8+UmdVHb5TgG5kQA9gqH5XaAOb1Wo3fIc=;
 b=GSfJMRCw2nDsStbAno8bMutCDTblyDiR0ibHZ7e5Ppzf9XOvfKXH+FuX46Og6vslnT
 LiixHyN5MAcCzqMoKQ2eepmDJtUt6wg4qJSCD1nhjvSXRW2frj05MiGjAvsMYUBWtZ5/
 MOH73pctaWJ2dU1Ws9YB5jdtPhCijwGoYhCAb1AeCJYTxepr3Pwy/WBnTexQ/RsJWUP+
 zNKYQ1yBV7lSkGXICmIQzE+OVaAgpqDQTowXStHJvLHdggGjEayQ8PJ+gAbZbZm1A8wd
 e2kQOs6zqxoq0lAj20n+neKv5rnUWB0Sx/JI7sNXCx8r9KhMPOjRuyO/7MuOEnYcOHHN
 eHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747286913; x=1747891713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9J+gk0eH1W8+UmdVHb5TgG5kQA9gqH5XaAOb1Wo3fIc=;
 b=mAIidPvBXg+v8bvIIIZ4LNC61Immw0z9laWky1sAW/DP6YJfdMfIH71oTi+rcxfcdh
 FQGgRLYabfZSsOtWejwDlqv38lzAuDLXxT5mN+7aZdTipzPDX1X/pz5fTpvgQmAbpJD8
 0oMyfidJYp881BF8cbbV/ksIKwVenTcRGB1alZXdnjH/PgO5sL1FzfY3iZk+udFEDPZE
 kVRN2hch6XkEf8b9GupVsf0+9LxskbPxH5Zjhxfg/HnGmvLPyVre38fh+AgdfkrCyHaG
 wh6K7qSF9HqkqdzhPDLEqlGqsPmvWUvOUA4COXwYMWOK8ClTOYCE0VwtRJ9b+aOtproX
 7SMw==
X-Gm-Message-State: AOJu0YzndRQyZPg0ZrxJA4owKkCBdyDWayz2r2KC1ZAcpYzJS1m46BUX
 eZ29Xck4nA+CmulMyHcJoeRse2t8MqJXEBKYZUsF25PHX0JU52zY7qRm+SY2yxA5ayk/k/xcqMA
 r/93TwNDHc2g69j3sEFXHsShIzEc=
X-Gm-Gg: ASbGncvbV42cObchQoujYLqlRlsHwuVPDDXC/r9WoFP+TLLSN7E0Gsg1XhnLgJ0kxzi
 20kpiCi88m1Rcx/lx6vMZewW0EKbxOKe5YkyIozoFzFXrz9oE2fjPxrZhyZKhXT7vk47Q4se2Al
 Fn8G+2C15OoRrTM2Iqe5Kte960u78Lu0GsP+9Y/b1mBYxmOU0JJ7FdR3AQoBemauQ=
X-Google-Smtp-Source: AGHT+IGFz3IdzSkOavr2WfgWAQbQgEpQCNVo0s0ICaqcskgcksUS2/v5xOZyEaXAwbgvJf7q6VR70PGDjfdAk6Nr/NM=
X-Received: by 2002:a05:6122:459e:b0:52a:79fd:34bd with SMTP id
 71dfb90a1353d-52d9c5c35demr6127266e0c.4.1747286912881; Wed, 14 May 2025
 22:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-13-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-13-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:28:06 +1000
X-Gm-Features: AX0GCFtTvyD0ZGxLaWORvcY9FgCRqNDQ0aeht8vuVtUbEreoP3hwX53l2bQSA-8
Message-ID: <CAKmqyKOc5CKFAy6ekW2sACgufdfP8-aDQ0=YR9p-HYWZrU+QdA@mail.gmail.com>
Subject: Re: [PATCH 12/26] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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
> index f9ba305e3ad..0330d74ab6b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -543,6 +543,7 @@ typedef struct RISCVCPUDef {
>      int priv_spec;
>      int32_t vext_spec;
>      RISCVCPUConfig cfg;
> +    bool bare;
>  } RISCVCPUDef;
>
>  /**
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7864c7e27c6..f66560442a9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1474,8 +1474,8 @@ static void riscv_cpu_init(Object *obj)
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
> @@ -1498,36 +1498,6 @@ static void riscv_cpu_init(Object *obj)
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
> @@ -3100,6 +3070,7 @@ static void riscv_cpu_class_base_init(ObjectClass *=
c, const void *data)
>
>      if (data) {
>          const RISCVCPUDef *def =3D data;
> +        mcc->def->bare |=3D def->bare;
>          if (def->misa_mxl_max) {
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> @@ -3253,6 +3224,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>          }),                                                 \
>      }
>
> +#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
> +    {                                                       \
> +        .name =3D (type_name),                                \
> +        .parent =3D (parent_type_name),                       \
> +        .abstract =3D true,                                   \
> +        .class_data =3D &(const RISCVCPUDef) {                \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
> +             __VA_ARGS__                                    \
> +        },                                                  \
> +    }
> +
>  #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
> @@ -3279,22 +3263,35 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
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

