Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2EEC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kaS-00073K-F9; Wed, 23 Apr 2025 20:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kaJ-00072o-9J
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:37:00 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kaH-0002xs-FW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:36:59 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51eb1818d4fso561148e0c.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455016; x=1746059816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FfjZPe41xBaBP6mHNv8yKKCi7xP4IYp8Yyr/2rNCd4=;
 b=lLStTTlfaIJbiOPZTOkRtkxeIxqY+QM+osbQjIV51U3m/HgjmMN4MOIHPy+SfYmrMY
 tYV0GtGYXR41T0Jgw4E68omEO18fSHy+i/8zLdncn2zunZgDu/pJJgC9TuApTfiT+N8X
 E9QBziDo1Q2PgtYPLRIFvto3ji8jkpDWp8HM25x2Cl/YIGJsbZ3d2jr1NFoEFcAuKBvs
 8mYLaK+o3fGbDz8ozAxxHBsV9lVUVTxbWkhuSH1JfHJUyLcMD+EFn037/+kLd8ZF0oO3
 36Z4aqNRNzRkpjz+yfGXcHlpOFpyKlEcOAAQRvt5o6mQlxK3DKTuE4xw8dA85OlGQQ0X
 q71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455016; x=1746059816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FfjZPe41xBaBP6mHNv8yKKCi7xP4IYp8Yyr/2rNCd4=;
 b=tthsgTMFLo46K+fYeHT1N967zvWRSqS4YvcN6Dm61NNxqVsSwCl/VR6QemxqHGMEFD
 Tb7wyxwWPlSt8mc/hQjM8xnKqVxwVmnDoD0+IcbQrV3s0VfqfMS3xDDH7AFB0Xezayly
 ZasUdX4o+eXyEB0R6HPhMVgJCwIU7GIxFY9yZUMDu2CfGkmJRULxUtPLVprE+HsYElrq
 budxVXuIOArx14zfP2Uhlc/szyIrEehGOLQZVHJO2XDkc+8vi9gK4igBRsV3mBh3XQ28
 ehQCv0KWRl2VHN4+O5qmyyIrZPWRjU8jTPOvLr6iUAgqD+UfUKCb1oo0igNbA1KOZGbu
 3ftQ==
X-Gm-Message-State: AOJu0YyWRklFHiZvTNtQKRalCyjP62bY9AigANI5V/HDHoifZQbwk0VU
 xPoIkOJS+j2iUC55W9VR+LuBJglzf6rxTLKc+mEJHR/tjF4erRBbPdTDGQkGFQjbviswYFpMVsr
 lzZEFg/m9+cDITgO8heKc4Dsw77A=
X-Gm-Gg: ASbGncul52FDoh/ujK5ccZG4Qd5ewyQ1cxGu6j+2DZC50BW5lcSKUule5TOPGJ+z3hJ
 7MXZxlLpirfG6gJG/pKK2SN5Wwk3XyEG7BAQ6f+XMriyyyopH+GW/R/2lhgnuE6Hca2YFJbmxiL
 BSar9O6FhnHbyjO6OnYCUUCiYymYGe7p8vKs/UZTBMmy+ypqTV/mlZ
X-Google-Smtp-Source: AGHT+IEA9nftK6cH9o2q4UnFMb2LWEQYl81pMrjGBMAIdi23PEnJ06VQL67ao3LjM1zBtKy205xGsS6XCXUiNzaaVns=
X-Received: by 2002:a05:6122:2a56:b0:516:1ab2:9955 with SMTP id
 71dfb90a1353d-52a783460demr745720e0c.6.1745455016185; Wed, 23 Apr 2025
 17:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-23-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-23-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:36:30 +1000
X-Gm-Features: ATxdqUHPLmU3tBmlJyLNiTUBtEdozaEt48gCwLRq2qu_ppGW_IHdpJnpG3IkH9k
Message-ID: <CAKmqyKOwjvu6b+Xmy2R8Q8vM6=7uZdR6PiT-zVzYLBRxBAiqzA@mail.gmail.com>
Subject: Re: [PATCH 22/27] target/riscv: generalize custom CSR functionality
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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
> While at it, constify it so that the RISCVCSR array in RISCVCPUDef
> can also be const.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h    | 15 ++++++++++++---
>  target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
>  target/riscv/csr.c    |  2 +-
>  target/riscv/th_csr.c | 21 +++------------------
>  4 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 54dc4cc85d0..679f417336c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -541,6 +541,8 @@ struct ArchCPU {
>      const GPtrArray *decoders;
>  };
>
> +typedef struct RISCVCSR RISCVCSR;
> +
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
>      RISCVCPUProfile *profile;
> @@ -549,6 +551,7 @@ typedef struct RISCVCPUDef {
>      int32_t vext_spec;
>      RISCVCPUConfig cfg;
>      bool bare;
> +    const RISCVCSR *custom_csrs;
>  } RISCVCPUDef;
>
>  /**
> @@ -900,6 +903,12 @@ typedef struct {
>      uint32_t min_priv_ver;
>  } riscv_csr_operations;
>
> +struct RISCVCSR {
> +    int csrno;
> +    bool (*insertion_test)(RISCVCPU *cpu);
> +    riscv_csr_operations csr_ops;
> +};
> +
>  /* CSR function table constants */
>  enum {
>      CSR_TABLE_SIZE =3D 0x1000
> @@ -954,7 +963,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> -void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
> +void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> @@ -963,8 +972,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_valu=
e,
>
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
> -/* Implemented in th_csr.c */
> -void th_register_custom_csrs(RISCVCPU *cpu);
> +/* In th_csr.c */
> +extern const RISCVCSR th_csr_list[];
>
>  const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6f516163486..9669e9822b2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -486,6 +486,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> +#ifndef CONFIG_USER_ONLY
> +static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *cs=
r_list)
> +{
> +    for (size_t i =3D 0; csr_list[i].csr_ops.name; i++) {
> +        int csrno =3D csr_list[i].csrno;
> +        const riscv_csr_operations *csr_ops =3D &csr_list[i].csr_ops;
> +        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cp=
u)) {
> +            riscv_set_csr_ops(csrno, csr_ops);
> +        }
> +    }
> +}
> +#endif
> +
>  #if defined(TARGET_RISCV64)
>  static void rv64_thead_c906_cpu_init(Object *obj)
>  {
> @@ -512,7 +525,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> -    th_register_custom_csrs(cpu);
> +    riscv_register_custom_csrs(cpu, th_csr_list);
>  #endif
>
>      /* inherited from parent obj via riscv_cpu_init() */
> @@ -1310,6 +1323,11 @@ static void riscv_cpu_init(Object *obj)
>      if (mcc->def->vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
>          cpu->env.vext_ver =3D mcc->def->vext_spec;
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (mcc->def->custom_csrs) {
> +        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
> +    }
> +#endif
>  }
>
>  typedef struct misa_ext_info {
> @@ -2910,6 +2928,11 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, void *data)
>          mcc->def->misa_ext |=3D def->misa_ext;
>
>          riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
> +
> +        if (def->custom_csrs) {
> +            assert(!mcc->def->custom_csrs);
> +            mcc->def->custom_csrs =3D def->custom_csrs;
> +        }
>      }
>
>      if (!object_class_is_abstract(c)) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 60de716a2a5..560b45d10d0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -38,7 +38,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations =
*ops)
>      *ops =3D csr_ops[csrno & (CSR_TABLE_SIZE - 1)];
>  }
>
> -void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
> +void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops)
>  {
>      csr_ops[csrno & (CSR_TABLE_SIZE - 1)] =3D *ops;
>  }
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 969a9fe3c80..49eb7bbab5f 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -27,12 +27,6 @@
>  #define TH_SXSTATUS_MAEE        BIT(21)
>  #define TH_SXSTATUS_THEADISAEE  BIT(22)
>
> -typedef struct {
> -    int csrno;
> -    bool (*insertion_test)(RISCVCPU *cpu);
> -    riscv_csr_operations csr_ops;
> -} riscv_csr;
> -
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVS)) {
> @@ -55,20 +49,11 @@ static RISCVException read_th_sxstatus(CPURISCVState =
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static riscv_csr th_csr_list[] =3D {
> +const RISCVCSR th_csr_list[] =3D {
>      {
>          .csrno =3D CSR_TH_SXSTATUS,
>          .insertion_test =3D test_thead_mvendorid,
>          .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
> -    }
> +    },
> +    { }
>  };
> -void th_register_custom_csrs(RISCVCPU *cpu)
> -{
> -    for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
> -        int csrno =3D th_csr_list[i].csrno;
> -        riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> -        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_t=
est(cpu)) {
> -            riscv_set_csr_ops(csrno, csr_ops);
> -        }
> -    }
> -}
> --
> 2.49.0
>

