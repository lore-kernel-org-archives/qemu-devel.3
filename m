Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8750EC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 00:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkBOj-00042e-4P; Mon, 17 Feb 2025 19:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkBOh-00042S-Py
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:23:35 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkBOf-0000iw-P0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:23:35 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-8641c7574a5so1911675241.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 16:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739838212; x=1740443012; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuZjw9CUWSFhNa+rEkY2Qg+58HIBrfbGM3czgcTa9g4=;
 b=jo6ocWcPa0INQ0DFQTPOoNcjsPHuHvOzG758QY1ebTZbHEGRzBE7/1qhoLcsnXFwfE
 8QA9QoCfmrqZsHn9P47/f9JVurU1r5+8wPP3q8BlS+pKi+5TKKM/Pelf1l0GQ38j875w
 S4lfuEjMe+VOUxdAIhCy+YaucMlLA99+SdZDZk1JVTQwp8qfy0J/fwqmBKIbeI/bGzuA
 1T4SFgXMaxOkfHFDrgZxu5oJyGDhxkjRZs4oYQbo8xW3WdtDPci9P9UXeb23CxLTXSPw
 4M+G+hX1TQKLFyZbsSbqlAZ55X1YFx8LGmCk2e2KrzuCRVsAOvz4gTNwKfKRMN89uj5L
 PNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739838212; x=1740443012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tuZjw9CUWSFhNa+rEkY2Qg+58HIBrfbGM3czgcTa9g4=;
 b=coiYQjpo7k6sTxq146V3jFyNn6+jzQtDgNIn235wrK6zwQDBpk2hP5nHWDaVsoBNi7
 X8hi+x6bkzbwF5I1t5O+BsvKMAjSjkNDrR7+Ux46LGlop8jw7OTw3YyZUk0VrEcdvpBb
 qZeJ4Y3yJtppTYzefIlBBnUpmYHidyXZr3P1kuEwumxLePvy5uCgX+n+bLKxkpyTnXqe
 bNFfKsCO/QyixmTYT3YjoWfVv55J0NIrCSdgRv6hHJ0F2lYDALQdfKIl1IX7ncC0uYrA
 3u+fI8nsf5KMOxVpTTaYnFz7O5hm4vMYfmT5Z/XYG+rjrIXFaTFHLCAoILPc3siLGhNN
 kZuA==
X-Gm-Message-State: AOJu0YwXrgguVVZwRFn5EDBur3y8fwrOvzAOnNsW3JKF6a4FnU2tvCbD
 cH/DLr4yliJtw0rkXgvpuotGNXIvQ1no7StZALHkBB7GG1/1j7GPrn/ku1r9kLN1frHjuYN+N5B
 CkMM4O+S26VV518DLgWIkTC91lHib+YUMMwQ=
X-Gm-Gg: ASbGncuO8INJ+0WtKIlpXDa5DZ+6rmjQ2OKlTFbBgI1klCfxsguTBJkhTWDVncqoqMj
 s2PJ05OSSaFCRRRytYRCQgGmrvA92mDCc3MZw/pg9AsYtt3wke6/lWVNihq4XuDQmAadKjM1NrX
 JFSxxVwXWvjEUfSpMUE9p3CGZclA==
X-Google-Smtp-Source: AGHT+IHdVFAisQIzq0VXEOuojRvBwE9zILB6GHzhTRtP3KtOSE6z1LCqzCA4h5Vn3YFYyG9usVdBwbb7bbkyPTKnBIU=
X-Received: by 2002:a05:6102:5129:b0:4bb:e8c5:b149 with SMTP id
 ada2fe7eead31-4bd3fc9f40cmr6242911137.7.1739838212304; Mon, 17 Feb 2025
 16:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-7-pbonzini@redhat.com>
In-Reply-To: <20250206182711.2420505-7-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2025 10:23:05 +1000
X-Gm-Features: AWEUYZkOVnPFjbbx1GWudX5U1Kb-rlWu85sAclRj0n8O0Ocl0g4E3-hgR6IeqGo
Message-ID: <CAKmqyKN2Og+uA00i8a_WMVV_885iU8uw7stoxRRS7VoGLrRONA@mail.gmail.com>
Subject: Re: [PATCH 06/22] target/riscv: add more RISCVCPUDef fields
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Fri, Feb 7, 2025 at 4:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Allow using RISCVCPUDef to replicate all the logic of custom .instance_in=
it
> functions.  To simulate inheritance, merge the child's RISCVCPUDef with
> the parent and then finally move it to the CPUState at the end of
> TYPE_RISCV_CPU's own instance_init function.
>
> STRUCT_FIELD is introduced here because I am not sure it is needed;
> it is a bit ugly and I wanted not to have it in the patch that
> introduces cpu_cfg_fields.h.inc.  I don't really understand why satp_mode
> is included in RISCVCPUConfig; therefore, the end of the series includes

I don't follow. `satp_mode` is a configurable option, hence the
inclusion in `RISCVCPUConfig`

Alistair

> a patch to move satp_mode directly in RISCVCPU, thus removing the need
> for STRUCT_FIELD; it can be moved before this one in a non-RFC posting.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/riscv/cpu.h                |  6 ++++
>  target/riscv/cpu_cfg.h            |  1 +
>  target/riscv/cpu_cfg_fields.h.inc |  6 +++-
>  target/riscv/cpu.c                | 48 ++++++++++++++++++++++++++++++-
>  4 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f757f0b6210..9b25c0c889b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -519,6 +519,12 @@ struct ArchCPU {
>
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +    uint32_t misa_ext;
> +    int priv_spec;
> +    int32_t vext_spec;
> +    int satp_mode32;
> +    int satp_mode64;
> +    RISCVCPUConfig cfg;
>  } RISCVCPUDef;
>
>  /**
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index ad02693fa66..07789a9de88 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -39,6 +39,7 @@ typedef struct {
>  struct RISCVCPUConfig {
>  #define BOOL_FIELD(x) bool x;
>  #define TYPED_FIELD(type, x) type x;
> +#define STRUCT_FIELD(type, x) type x;
>  #include "cpu_cfg_fields.h.inc"
>  };
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 56fffb5f177..cbedf0a703b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -4,6 +4,9 @@
>  #ifndef TYPED_FIELD
>  #define TYPED_FIELD(type, x)
>  #endif
> +#ifndef STRUCT_FIELD
> +#define STRUCT_FIELD(type, x)
> +#endif
>
>  BOOL_FIELD(ext_zba)
>  BOOL_FIELD(ext_zbb)
> @@ -160,8 +163,9 @@ TYPED_FIELD(uint16_t, cbop_blocksize)
>  TYPED_FIELD(uint16_t, cboz_blocksize)
>
>  #ifndef CONFIG_USER_ONLY
> -TYPED_FIELD(RISCVSATPMap, satp_mode);
> +STRUCT_FIELD(RISCVSATPMap, satp_mode)
>  #endif
>
>  #undef BOOL_FIELD
>  #undef TYPED_FIELD
> +#undef STRUCT_FIELD
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index baf4dd017b2..1d999488465 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -74,6 +74,15 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, RISCVCPUConfig *sr=
c)
> +{
> +#define BOOL_FIELD(x) dest->x |=3D src->x;
> +#define TYPED_FIELD(type, x) if (src->x) dest->x =3D src->x;
> +    /* only satp_mode, which is initialized by instance_init */
> +#define STRUCT_FIELD(type, x)
> +#include "cpu_cfg_fields.h.inc"
> +}
> +
>  #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
>      {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
>
> @@ -432,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>  }
>
>  static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +                                        int satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> @@ -1476,6 +1485,24 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
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
> +#ifndef CONFIG_USER_ONLY
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32 && mcc->def->satp_mode32 !=3D=
 RISCV_PROFILE_ATTR_UNUSED) {
> +        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode3=
2);
> +    }
> +    if (riscv_cpu_mxl(env) >=3D MXL_RV64 && mcc->def->satp_mode64 !=3D R=
ISCV_PROFILE_ATTR_UNUSED) {
> +        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode6=
4);
> +    }
> +#endif
>  }
>
>  static void riscv_bare_cpu_init(Object *obj)
> @@ -2968,6 +2995,25 @@ static void riscv_cpu_class_base_init(ObjectClass =
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
> +        if (def->satp_mode32 !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            assert(def->satp_mode32 <=3D VM_1_10_SV32);
> +            mcc->def->satp_mode32 =3D def->satp_mode32;
> +        }
> +        if (def->satp_mode64 !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +            assert(def->satp_mode64 <=3D VM_1_10_SV64);
> +            mcc->def->satp_mode64 =3D def->satp_mode64;
> +        }
> +        mcc->def->misa_ext |=3D def->misa_ext;
> +
> +        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
>      }
>
>      if (!object_class_is_abstract(c)) {
> --
> 2.48.1
>
>

