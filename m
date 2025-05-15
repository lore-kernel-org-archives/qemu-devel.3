Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040F0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFQhx-0005LB-EM; Thu, 15 May 2025 01:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQhu-0005L2-Df
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:00:34 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFQhs-0003Il-3F
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:00:34 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4df4ef9c59dso161455137.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747285228; x=1747890028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQSo5nIGfXd6GYLtseNoZXNwiIdBF08VihUpVX26G2Q=;
 b=UadCcTIyT5hP2vacfnRJj9ULNgEBE9NaiOInq5H+sB6WUBC5LuiirVKYzd+gZ15rsE
 QqXK9F3aK0sKJEG7UxvZD//hjZI1o3MwWqVRruO0z6wv0mDa7vJILSpO7zc0VPPahKYG
 U+5u6jYzbvUDY/cLRCp2dLxZkxYhEllxA4s7rXNv2SFHs8KBrajCqYe65sHsLSIBrgAR
 c42i8AnfmNqWYjOJ9aZZytWm3GWvCE6vzJ74AUjWmcHxs8ZxIbCBP2hx1j4SfhxHWM4k
 xIMmQVppHXNd0e6w+brqIXr1g1iPq2n6HhH8an0s1U24axoNVzKoCraYGTef+OUoQNXh
 ZhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747285228; x=1747890028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQSo5nIGfXd6GYLtseNoZXNwiIdBF08VihUpVX26G2Q=;
 b=cgjl50w+W3cm5V5grdHJkk0V7EiFuub+YcyqQEsBtltKQBBTZyrhykez4MESWB7Ocb
 6AMeiAneim2T28yaVFblIyk5EtwKd95TysD9MFUVP/7fszjNFkNeEE0JI7uejuGnPcgq
 Xr6DvnJfgkzaqF/GJCrH79kmc4UQrPPDxlo/UvoC2WFmhSlOQ/vx+hhmrlR14zQLbj6F
 50YznOFzoUKgcojN+Nk5tyHd1lFyFRC4ta8wA8cnwd+s2J2LIz0DoYy+ItLW6JekkGSO
 AVvTJi8ChfyZCE8kzY7aqMDL/AFedxT/p4zgsfNUnBCysy1PkXYgQIvPA8d/6/ApHQxD
 CFWg==
X-Gm-Message-State: AOJu0YwGzfwJDLXNfgmZu95Fedd9xshN4rJA0znpnss5PYldoLQPZs5t
 QdzMbTZSWzzfguQEnXVva8/J2i/R2WmenSiTrn7jWaighvFxrugI/S9bitgvTxnGPg853zhEZq4
 C3LeScpMalRQmdX2uRSihr7kMuZ4=
X-Gm-Gg: ASbGncvLnfh+DD2ikWYtbiTlBzUOmlt9PiI3xx57yTizLzowzGKm1uY2NPcg+DDfRFe
 7WUZ8Q4om704Pn5VqeSiP2ZOaKWGy6nmvqBlMQD/gZEtPoSgHJNTAn0119/V9dmnjY3nJTB5QYG
 76ni+fiBgjaH9/HF/LH30QBxGGavSfS+6xXbLiD4Qd9gebDUjhF2bVHFEYNJ9RocE=
X-Google-Smtp-Source: AGHT+IFw24xGigf0nOYKgfQGOrqcuNb9jLn6Zm6t6rXObsgnrra1/b+q0vilMgvvpsUlJh8iVql0xzsRV4SUGFpWX1Y=
X-Received: by 2002:a05:6102:1501:b0:4df:920a:e1eb with SMTP id
 ada2fe7eead31-4df920ae3cdmr1526892137.7.1747285228286; Wed, 14 May 2025
 22:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-12-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-12-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:00:02 +1000
X-Gm-Features: AX0GCFuqTH_9BMuHFBPvgJsvXfxO7vpw4Lv9Ar0PV_bjYC7nzko65aEG36sD9dU
Message-ID: <CAKmqyKOGmFGKeM7PWfaxF2D=YhHUosrsdT5d-CCXxiejS2_+KA@mail.gmail.com>
Subject: Re: [PATCH 11/26] target/riscv: add more RISCVCPUDef fields
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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
> Allow using RISCVCPUDef to replicate all the logic of custom .instance_in=
it
> functions.  To simulate inheritance, merge the child's RISCVCPUDef with
> the parent and then finally move it to the CPUState at the end of
> TYPE_RISCV_CPU's own instance_init function.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  4 ++++
>  target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++++++++-
>  target/riscv/kvm/kvm-cpu.c |  6 ++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7edefc80d73..f9ba305e3ad 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -539,6 +539,10 @@ struct ArchCPU {
>
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    uint32_t misa_ext;
> +    int priv_spec;
> +    int32_t vext_spec;
> +    RISCVCPUConfig cfg;
>  } RISCVCPUDef;
>
>  /**
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ddade8a4370..7864c7e27c6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,13 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConf=
ig *src)
> +{
> +#define BOOL_FIELD(x) dest->x |=3D src->x;
> +#define TYPED_FIELD(type, x, default_) if (src->x !=3D default_) dest->x=
 =3D src->x;
> +#include "cpu_cfg_fields.h.inc"
> +}
> +
>  #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
>      {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
>
> @@ -434,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>  }
>
>  static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +                                        int satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> @@ -1479,6 +1486,16 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cboz_blocksize =3D 64;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode =3D -1;
> +
> +    env->misa_ext_mask =3D env->misa_ext =3D mcc->def->misa_ext;
> +    riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
> +
> +    if (mcc->def->priv_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +        cpu->env.priv_ver =3D mcc->def->priv_spec;
> +    }
> +    if (mcc->def->vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +        cpu->env.vext_ver =3D mcc->def->vext_spec;
> +    }
>  }
>
>  static void riscv_bare_cpu_init(Object *obj)
> @@ -3087,6 +3104,17 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, const void *data)
>              assert(def->misa_mxl_max <=3D MXL_RV128);
>              mcc->def->misa_mxl_max =3D def->misa_mxl_max;
>          }
> +        if (def->priv_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            assert(def->priv_spec <=3D PRIV_VERSION_LATEST);
> +            mcc->def->priv_spec =3D def->priv_spec;
> +        }
> +        if (def->vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            assert(def->vext_spec !=3D 0);
> +            mcc->def->vext_spec =3D def->vext_spec;
> +        }
> +        mcc->def->misa_ext |=3D def->misa_ext;
> +
> +        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
>      }
>
>      if (!object_class_is_abstract(c)) {
> @@ -3193,6 +3221,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D &(const RISCVCPUDef) {                \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          },                                                  \
>      }
>
> @@ -3203,6 +3234,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D &(const RISCVCPUDef) {                \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          },                                                  \
>      }
>
> @@ -3213,6 +3247,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D &(const RISCVCPUDef) {                \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          },                                                  \
>      }
>
> @@ -3223,6 +3260,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D &(const RISCVCPUDef) {                \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          },                                                  \
>      }
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cd82b29567c..03f9b36f0c3 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -2004,10 +2004,16 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] =
=3D {
>  #if defined(TARGET_RISCV32)
>          .class_data =3D &(const RISCVCPUDef) {
>              .misa_mxl_max =3D MXL_RV32,
> +            .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .cfg.max_satp_mode =3D -1,
>          },
>  #elif defined(TARGET_RISCV64)
>          .class_data =3D &(const RISCVCPUDef) {
>              .misa_mxl_max =3D MXL_RV64,
> +            .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .cfg.max_satp_mode =3D -1,
>          },
>  #endif
>      }
> --
> 2.49.0
>

