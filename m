Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C0CC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9sB-0006AV-MT; Sun, 14 Jul 2024 20:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9s8-00069K-0a; Sun, 14 Jul 2024 20:47:20 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9rv-0002zb-GY; Sun, 14 Jul 2024 20:47:19 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f2f31a9410so1409124e0c.3; 
 Sun, 14 Jul 2024 17:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721004425; x=1721609225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5gYq6JYgbbS7gVcC73Gi7pl31lJs9A3369vrE9WWmk=;
 b=HLfYHA6kgJSd21dF4V8bxWPEEYN/h9gKRCKYhoII6WE0/im6L0PNey7knpBUEyfpBO
 mCsdHBZcxsO0/T1o9LtX8D+jTP15ELZuUaOSjXThVq9r/kg5grM5dkr/JTJyKxAA2fBh
 G98xJDmxytNcopAZ/ukIIrWOngXkD/ECEn52H3b1TEyD/aXtD2zVF8d4JBrWyZ291JPv
 gHmOvyFWtlnfaCWmqyojLNNlEHAOk1YYOMqH56sm6fOeOEbYtKjsYmXuVMN0hsHKzOy8
 r8k4r0jCa/I68BPL6DvvDOboeiLGqFAYFz/GEiHgovE53+eOLvHHP9skxf+b8B1QdJFM
 nmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721004425; x=1721609225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5gYq6JYgbbS7gVcC73Gi7pl31lJs9A3369vrE9WWmk=;
 b=SMixKqVWME5X5gAYJn22YpRAc8mXg2HVMxuGpPwJN291fkI6N+gt4yuVAQ8g+p6ThO
 5aUWxCES+3ryX8w6im2nBlJwc2W2CzYnxn8h9Er5GgSaE6X9LmwuPPCU8prctW+ZOv5j
 LfX8CNWBOtOG3i4qbCWoeNdgqlQxsM7HokupZn1KMAxCOFqqdgmRNgk0TXM/hGUcq/+Z
 2GjtjbbiasF+SywJh+SQ3k+m7nF+tv8mfEQDsdc8/pbovwxakum2YdGw0dktbLnaHVZA
 odC1eRGZXtQ3B8qoD4tQq7Bc3GannPXIjvwHNIPrVZ2SSflU4zP9MkDE8eZelmsfKsjU
 zu4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1qrQIpYLKe0GRBlK8ul8wytMX6oyew+lfssEscJ+f36bT8iWEFhX6wl55Hl+LBJm9qMkwjVnN/IA9sFZ3J733scAQlSU=
X-Gm-Message-State: AOJu0YxVOCP6652kN5SkyArzkjj7cKXEwNvkyk4yAoJYQX9pi1mEv2b+
 xkJFxhBPS9bvmnaDi0DJRQZboWjZI5FneLYkJXoNE8kg0bOB9g6WelzvVTEV9ciaawZqThGZE0e
 eT0UA/AkYrGuMsJoXHO3/iiAZ9SAcdoyx
X-Google-Smtp-Source: AGHT+IG/ms7LbZsZTF1d/l0N6x+YQoTNNxy020NSJewH2fWBlxcT8J1O2bqfwgHpXnmYG3GeVFLuGxwj+izJq5Ajqcg=
X-Received: by 2002:a05:6122:16a1:b0:4e4:e90f:6749 with SMTP id
 71dfb90a1353d-4f33f2db5ebmr24600851e0c.10.1721004423316; Sun, 14 Jul 2024
 17:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
 <20240711-smcntrpmf_v7-v8-5-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-5-b7c38ae7b263@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 10:46:37 +1000
Message-ID: <CAKmqyKNveHHESghEEPbGVjG=vqnnEUNqbqJqFSLhKPd60Mqkpw@mail.gmail.com>
Subject: Re: [PATCH v8 05/13] target/riscv: Add cycle & instret privilege mode
 filtering support
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jul 12, 2024 at 8:34=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> QEMU only calculates dummy cycles and instructions, so there is no
> actual means to stop the icount in QEMU. Hence this patch merely adds
> the functionality of accessing the cfg registers, and cause no actual
> effects on the counting of cycle and instret counters.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h |  12 +++++
>  target/riscv/csr.c      | 138 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 149 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5faa817453bb..32b068f18aa5 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -926,6 +926,18 @@ typedef enum RISCVException {
>  #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>  #define MHPMEVENTH_BIT_VUINH               BIT(26)
>
> +#define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
> +                                            MHPMEVENT_BIT_SINH  | \
> +                                            MHPMEVENT_BIT_UINH  | \
> +                                            MHPMEVENT_BIT_VSINH | \
> +                                            MHPMEVENT_BIT_VUINH)
> +
> +#define MHPMEVENTH_FILTER_MASK              (MHPMEVENTH_BIT_MINH  | \
> +                                            MHPMEVENTH_BIT_SINH  | \
> +                                            MHPMEVENTH_BIT_UINH  | \
> +                                            MHPMEVENTH_BIT_VSINH | \
> +                                            MHPMEVENTH_BIT_VUINH)
> +
>  #define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
>  #define MHPMEVENT_IDX_MASK                 0xFFFFF
>  #define MHPMEVENT_SSCOF_RESVD              16
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 3ad851707e5c..b814d176cbb8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -30,7 +30,6 @@
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
>
> -
>  /* CSR function table public API */
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
>  {
> @@ -236,6 +235,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env=
, int csrno)
>      return sscofpmf(env, csrno);
>  }
>
> +static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smcntrpmf(env, csrno);
> +}
> +
>  static RISCVException any(CPURISCVState *env, int csrno)
>  {
>      return RISCV_EXCP_NONE;
> @@ -830,6 +847,111 @@ static RISCVException read_hpmcounterh(CPURISCVStat=
e *env, int csrno,
>
>  #else /* CONFIG_USER_ONLY */
>
> +static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
> +{
> +    *val =3D env->mcyclecfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
> +{
> +    uint64_t inh_avail_mask;
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        env->mcyclecfg =3D val;
> +    } else {
> +        /* Set xINH fields if priv mode supported */
> +        inh_avail_mask =3D ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MCYCLECFG_BIT_UINH=
 : 0;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MCYCLECFG_BIT_SINH=
 : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVU)) ? MCYCLECFG_BIT_VUIN=
H : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVS)) ? MCYCLECFG_BIT_VSIN=
H : 0;
> +        env->mcyclecfg =3D val & inh_avail_mask;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val =3D env->mcyclecfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
> +                                       target_ulong val)
> +{
> +    target_ulong inh_avail_mask =3D (target_ulong)(~MHPMEVENTH_FILTER_MA=
SK |
> +                                                 MCYCLECFGH_BIT_MINH);
> +
> +    /* Set xINH fields if priv mode supported */
> +    inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MCYCLECFGH_BIT_UINH : =
0;
> +    inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MCYCLECFGH_BIT_SINH : =
0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVU)) ? MCYCLECFGH_BIT_VUINH :=
 0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH :=
 0;
> +
> +    env->mcyclecfgh =3D val & inh_avail_mask;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    *val =3D env->minstretcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
> +                                        target_ulong val)
> +{
> +    uint64_t inh_avail_mask;
> +
> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        env->minstretcfg =3D val;
> +    } else {
> +        inh_avail_mask =3D ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH=
;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UI=
NH : 0;
> +        inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MINSTRETCFG_BIT_SI=
NH : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVU)) ? MINSTRETCFG_BIT_VU=
INH : 0;
> +        inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                           riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VS=
INH : 0;
> +        env->minstretcfg =3D val & inh_avail_mask;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
> +                                        target_ulong *val)
> +{
> +    *val =3D env->minstretcfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
> +                                         target_ulong val)
> +{
> +    target_ulong inh_avail_mask =3D (target_ulong)(~MHPMEVENTH_FILTER_MA=
SK |
> +                                                 MINSTRETCFGH_BIT_MINH);
> +
> +    inh_avail_mask |=3D riscv_has_ext(env, RVU) ? MINSTRETCFGH_BIT_UINH =
: 0;
> +    inh_avail_mask |=3D riscv_has_ext(env, RVS) ? MINSTRETCFGH_BIT_SINH =
: 0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVU)) ? MINSTRETCFGH_BIT_VUINH=
 : 0;
> +    inh_avail_mask |=3D (riscv_has_ext(env, RVH) &&
> +                       riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH=
 : 0;
> +
> +    env->minstretcfgh =3D val & inh_avail_mask;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>                                       target_ulong *val)
>  {
> @@ -5051,6 +5173,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                               write_mcountinhibit,
>                               .min_priv_ver =3D PRIV_VERSION_1_11_0      =
 },
>
> +    [CSR_MCYCLECFG]      =3D { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
> +                             write_mcyclecfg,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
 },
> +    [CSR_MINSTRETCFG]    =3D { "minstretcfg", smcntrpmf, read_minstretcf=
g,
> +                             write_minstretcfg,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
 },
> +
>      [CSR_MHPMEVENT3]     =3D { "mhpmevent3",     any,    read_mhpmevent,
>                               write_mhpmevent                           }=
,
>      [CSR_MHPMEVENT4]     =3D { "mhpmevent4",     any,    read_mhpmevent,
> @@ -5110,6 +5239,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_MHPMEVENT31]    =3D { "mhpmevent31",    any,    read_mhpmevent,
>                               write_mhpmevent                           }=
,
>
> +    [CSR_MCYCLECFGH]     =3D { "mcyclecfgh",   smcntrpmf_32, read_mcycle=
cfgh,
> +                             write_mcyclecfgh,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
> +    [CSR_MINSTRETCFGH]   =3D { "minstretcfgh", smcntrpmf_32, read_minstr=
etcfgh,
> +                             write_minstretcfgh,
> +                             .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
> +
>      [CSR_MHPMEVENT3H]    =3D { "mhpmevent3h",    sscofpmf_32,  read_mhpm=
eventh,
>                               write_mhpmeventh,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0      =
  },
>
> --
> 2.34.1
>
>

