Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF0C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 04:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u75Xw-0001VP-So; Tue, 22 Apr 2025 00:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u75Xt-0001V1-8L
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 00:47:46 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u75Xr-0003bx-C4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 00:47:45 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-523f670ca99so1635516e0c.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745297262; x=1745902062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7xibW3IHT5q+doaRkpEeD+DURwEpf18Z0jUqqkKPxw=;
 b=TCvzAfDztun0MeM3VdsIICfccAFge7LpvfsGN2SAqbozBGXfEhEwYs7LPNgKPp5MEO
 UEAphceM7LoH8pziRg0H7f6f9XG3yqDQnshshR7G7LmrG9LRVbRjQuKGBVF01gkCWX1U
 wfx3b7CmrarFWl8IjrmivJ06q4uweD29WP1Q5Fp1vnOWtma1cTlu0IeLVEeCHoft1Nxa
 z2fwsGX16nX3q3b5tlNKFMO4dD+nj3AOnxPixzAsv1mIhUlrABb4sYYBeUtMFXB39yms
 6j1mMnlsgEsLDWPkIAJ7g+qgRJXnxg/FQEt9QC0cAyug3QqFzNyjxqfYFjDA/VImHAo+
 ag/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745297262; x=1745902062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7xibW3IHT5q+doaRkpEeD+DURwEpf18Z0jUqqkKPxw=;
 b=wq+yl+WM6+n4gghdxoKaGclV7BCUPVECABmYiFXm2o0XAIQemNPDxvmpU4MlqcROkc
 JPcLhRdkGY+y714sqvZsQtjcMGqpQMyaGEet+zTAh+5llpSrBk6inadBcWivsuikuoo/
 EbcC79ptOS4YAYtcVTorTfKzLN8B/FOMWBAuRB1o0pHDx0C/PFOgP7PV0uHGe/0paSnz
 zTn77BWLU3JLnp2DbS2C0kpskf05pw7gDX5inLbQXPnEo6x31DDYt21rK4pOkTzdbfu8
 caT/EGk1qZ8VsQoG+FSIsoacp7LNd9O9ljXyRczsZDx75zxrszK2qXGdO/pJSLU0R0j0
 tNYA==
X-Gm-Message-State: AOJu0YxYYBoefoCjT5oI2LBkuKaAdx8rJ5San8BoUbFxAHKzi2yDlQpI
 KzDZR2l+SI7WxJFOpIkGXNOdOGuONHqTCYhtHQ8LKOyG5jfdh+Sw8ClidRaYp5ZCOnZCh6dOqaq
 fOgKEH5fx22a1225hcLK2xPjfrJQ=
X-Gm-Gg: ASbGncsBxZdt2tqRRqjbbdDy/mKZLyf1Li5uqLLJAnx0LKXGvROULilAG9qMj3+hXvJ
 OktVYlWlHVe6jAK2mGpvBGAKZpg+CYPZlCafu583QUO+8sqvQC2rWVMCJq/zMio87K8nYc2qjqv
 Xa1k3BODJlid9GUyURpWso5pj5tyzFpAVr4WPS8Y5GGyjIjx/9BkWR
X-Google-Smtp-Source: AGHT+IFtRGpHkfpMITlaw0hR4aAO2wl2/ATHzoUTg2kBgYW4aC+/0kAZPbA9KAB/fa9yO65jwuWHCiHcJ/epLS7t4fE=
X-Received: by 2002:a05:6102:664:b0:4c4:e3fe:4af9 with SMTP id
 ada2fe7eead31-4cb80142668mr8598892137.12.1745297261791; Mon, 21 Apr 2025
 21:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-14-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-14-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Apr 2025 14:47:15 +1000
X-Gm-Features: ATxdqUEK4pcnWjPfqlUs3OEpxdWzqoSngQ0uPZOE2Y0mAMJwZUBRabE--S0SxMg
Message-ID: <CAKmqyKPoFuBbm904quti0bt2Rg+96+GHzGRcC7rv+pEEc_0Cqg@mail.gmail.com>
Subject: Re: [PATCH 13/27] target/riscv: add more RISCVCPUDef fields
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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
> index 9bbfdcf6758..acaa49b979c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -543,6 +543,10 @@ struct ArchCPU {
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
> index 2c2a6a4b44a..620641fbed6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -74,6 +74,13 @@ bool riscv_cpu_option_set(const char *optname)
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
> @@ -435,7 +442,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>  }
>
>  static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +                                        int satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> @@ -1487,6 +1494,16 @@ static void riscv_cpu_init(Object *obj)
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
> @@ -3093,6 +3110,17 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, void *data)
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
> @@ -3199,6 +3227,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          }),                                                 \
>      }
>
> @@ -3209,6 +3240,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          }),                                                 \
>      }
>
> @@ -3219,6 +3253,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          }),                                                 \
>      }
>
> @@ -3229,6 +3266,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .instance_init =3D (initfn),                          \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
> +             .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,        \
> +             .cfg.max_satp_mode =3D -1,                       \
>          }),                                                 \
>      }
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index d7e6970a670..02bcb72cbb3 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -2004,10 +2004,16 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] =
=3D {
>  #if defined(TARGET_RISCV32)
>          .class_data =3D &((const RISCVCPUDef) {
>              .misa_mxl_max =3D MXL_RV32,
> +            .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .vext_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> +            .cfg.max_satp_mode =3D -1,
>          },
>  #elif defined(TARGET_RISCV64)
>          .class_data =3D &((const RISCVCPUDef) {
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

