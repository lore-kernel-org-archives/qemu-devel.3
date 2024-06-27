Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E53AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjOx-0001Fr-Io; Thu, 27 Jun 2024 03:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sMjOt-0001FI-BY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:18:35 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sMjOd-00072B-84
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:18:34 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52cdd893e5cso5713240e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719472695; x=1720077495; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuhJ9bxWM37Y0RFLvqK4WEUkZFkFc9DIgt5LKGlvjPI=;
 b=negQC/bwpoSw1M8AMksLSDPRawRKP8GTgzYeNxgCFTGUjrq+M3DZVkHxNj7+Mh1F8E
 agknMqMEuQY4UnMnGMp9GqhKJ63757HmhyF5K11PGvqdcSHFEPfjaIEqQUKsP5CE3Uh3
 Ic/BEL99lAh8xZHcI8Z4kn/xjsnFYqeFosw//1LudMpAa4zySEvX9qFGWTlQsWCsI3oz
 u8kgAY1/qCWqHzPpzQYtpewV0k1NMqOvoKcEveNF+GiDJLijkyCJZzm9eSig6JchoufB
 BHMBQ6dIllKx2ruKMMRlPnyOw3bWdRneTdHHQMwNxksedqMl3v+d55hfoUTH/TvRAsUP
 ZnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719472695; x=1720077495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuhJ9bxWM37Y0RFLvqK4WEUkZFkFc9DIgt5LKGlvjPI=;
 b=dMbYDMAnOhIWrs6tVQGIJ0TPpvBk0DZ9aQjMah4mvT9OCE73PcE0ZmgrA/IDlVJOdV
 UUVGXZyJHhUSmZXb/nkos8KwlJiywoLF5jMkYnka1v9RP7kwv4InfNAwCgVW4zvRJPxr
 d3ayUEr7MUxGDHHZ+XdzshyicW4hceRnhEZhlcZOfk1yrXwCOI18725kym6C7RsCPeSq
 PYFeslpQcLOrLHLnojMF218ROy5e1FEsvQKYYxQd28Bf7aLYhzUvqD4vIqlNfgYTv9jB
 wxwbqt9qJ9u7kbW3Qm4iFQhsAQjJjiz7w5YfYuFKNOW1H9GEcQU2EYTIR9kj6aZb20qi
 YA4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCaJjdEBnI5ssIVid28poovKUlRAW7VghJ/ChDJ6T4mBJj+Vzmx2ys+KmZMQfHn9PXQ3h2zikpiqrtqk5DJmMWcQbVLko=
X-Gm-Message-State: AOJu0YyLDsR7yyM29y05sBihSACb+y3sxtMTyLXc/3flcDtAa/zZuc0S
 o0K6Fo/QK1PO84Z4buCEWSdDQ0sP8Kx72aE0wsxMdUxNfxBBIx/rFkqOjv2IuC4qBARcO5qFOMC
 76DLDzjxGSKQROqz0IX5fPAWJE5KOXsRLD4M4qnCdxp9NBfGlCfNuCTU3eWqXAqdHVsmmR1YUxs
 mrSqUQ2vzF90MKur/tMd3hsX/c0bVIAs8kCII2Hm08+Q==
X-Google-Smtp-Source: AGHT+IFPgs+La/j78IZWXjvStMUrrog8wLhh2WB7de9cSWE+3nZbBkOD6o2aRec25V0MW3dJ80eCNQ==
X-Received: by 2002:a05:6512:10c7:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-52ce185d33amr12320143e87.50.1719472694857; 
 Thu, 27 Jun 2024 00:18:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e712a75c0sm104000e87.45.2024.06.27.00.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 00:18:14 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-52ce674da85so4568416e87.2; 
 Thu, 27 Jun 2024 00:18:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUM5CIahKcROBo82Gh6MjgHXuvQJ8Xq64M9EHxBKpStIP7nphl03awtbRA0+wmJ9/FXupLhKpiid63B6V41rI0K8iKcdt+XlQNgNHiSlajkQE2cC7EFreel2QPFIg==
X-Received: by 2002:a05:6512:3054:b0:52d:215b:9028 with SMTP id
 2adb3069b0e04-52d215b914dmr5829301e87.60.1719472694089; Thu, 27 Jun 2024
 00:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-3-me@deliversmonkey.space>
In-Reply-To: <20240511101053.1875596-3-me@deliversmonkey.space>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 27 Jun 2024 15:18:02 +0800
X-Gmail-Original-Message-ID: <CANzO1D2A+Er2zQeLoTXGHx_GH613yDycdrdw0cgghhBu-MarYg@mail.gmail.com>
Message-ID: <CANzO1D2A+Er2zQeLoTXGHx_GH613yDycdrdw0cgghhBu-MarYg@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Alexey Baturo <baturo.alexey@gmail.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h      |  8 ++++++++
>  target/riscv/cpu_bits.h |  3 +++
>  target/riscv/cpu_cfg.h  |  3 +++
>  target/riscv/csr.c      | 11 +++++++++++
>  target/riscv/machine.c  | 10 +++++++---
>  target/riscv/pmp.c      | 13 ++++++++++---
>  target/riscv/pmp.h      | 11 ++++++-----
>  7 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 232521bb87..52b6ba73c8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -121,6 +121,14 @@ typedef enum {
>      EXT_STATUS_DIRTY,
>  } RISCVExtStatus;
>
> +/* Enum holds PMM field values for Zjpm v0.8 extension */
> +typedef enum {
> +    PMM_FIELD_DISABLED =3D 0,
> +    PMM_FIELD_RESERVED =3D 1,
> +    PMM_FIELD_PMLEN7   =3D 2,
> +    PMM_FIELD_PMLEN16  =3D 3,
> +} RISCVPmPmm;
> +
>  #define MMU_USER_IDX 3
>
>  #define MAX_RISCV_PMPS (16)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index da16ba236a..13ce2218d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -708,6 +708,7 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_PMM                        (3ULL << 32)
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
> @@ -721,11 +722,13 @@ typedef enum RISCVException {
>  #define SENVCFG_CBIE                       MENVCFG_CBIE
>  #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_PMM                        MENVCFG_PMM
>
>  #define HENVCFG_FIOM                       MENVCFG_FIOM
>  #define HENVCFG_CBIE                       MENVCFG_CBIE
>  #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>  #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_PMM                        MENVCFG_PMM
>  #define HENVCFG_ADUE                       MENVCFG_ADUE
>  #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>  #define HENVCFG_STCE                       MENVCFG_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..9ecdc792c5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -120,6 +120,9 @@ struct RISCVCPUConfig {
>      bool ext_ssaia;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
> +    bool ext_ssnpm;
> +    bool ext_smnpm;
> +    bool ext_smmpm;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4b2c932564..45b548eb0b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -530,6 +530,9 @@ static RISCVException have_mseccfg(CPURISCVState *env=
, int csrno)
>      if (riscv_cpu_cfg(env)->ext_zkr) {
>          return RISCV_EXCP_NONE;
>      }
> +    if (riscv_cpu_cfg(env)->ext_smmpm) {
> +        return RISCV_EXCP_NONE;
> +    }
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> @@ -2083,6 +2086,10 @@ static RISCVException write_menvcfg(CPURISCVState =
*env, int csrno,
>                  (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>      }
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & MENVCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D MENVCFG_PMM;
> +    }
>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
>
>      return RISCV_EXCP_NONE;
> @@ -2127,6 +2134,10 @@ static RISCVException write_senvcfg(CPURISCVState =
*env, int csrno,
>                                      target_ulong val)
>  {
>      uint64_t mask =3D SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENV=
CFG_CBZE;
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & SENVCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D SENVCFG_PMM;
> +    }
>      RISCVException ret;
>
>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 64ab66e332..bbbb28f373 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -152,15 +152,19 @@ static const VMStateDescription vmstate_vector =3D =
{
>
>  static bool pointermasking_needed(void *opaque)
>  {
> -    return false;
> +    RISCVCPU *cpu =3D opaque;
> +    return cpu->cfg.ext_ssnpm || cpu->cfg.ext_smnpm || cpu->cfg.ext_smmp=
m;
>  }
>
>  static const VMStateDescription vmstate_pointermasking =3D {
>      .name =3D "cpu/pointer_masking",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D pointermasking_needed,
>      .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.senvcfg, RISCVCPU),
> +        VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a76b611a0..7ddb9dbf0b 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -574,6 +574,12 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, ui=
nt32_t addr_index)
>  void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>  {
>      int i;
> +    uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
> +
> +    /* Update PMM field only if the value is valid according to Zjpm v0.=
8 */
> +    if (((val & MSECCFG_PMM) >> 32) !=3D PMM_FIELD_RESERVED) {
> +        mask |=3D MSECCFG_PMM;
> +    }
>
>      trace_mseccfg_csr_write(env->mhartid, val);
>
> @@ -589,12 +595,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_u=
long val)
>
>      if (riscv_cpu_cfg(env)->ext_smepmp) {
>          /* Sticky bits */
> -        val |=3D (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
> -        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
> +        val |=3D (env->mseccfg & mask);
> +        if ((val ^ env->mseccfg) & mask) {
>              tlb_flush(env_cpu(env));
>          }
>      } else {
> -        val &=3D ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
> +        mask |=3D MSECCFG_RLB;
> +        val &=3D ~(mask);
>      }
>
>      env->mseccfg =3D val;
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index f5c10ce85c..ccff0eb9b6 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -40,11 +40,12 @@ typedef enum {
>  } pmp_am_t;
>
>  typedef enum {
> -    MSECCFG_MML   =3D 1 << 0,
> -    MSECCFG_MMWP  =3D 1 << 1,
> -    MSECCFG_RLB   =3D 1 << 2,
> -    MSECCFG_USEED =3D 1 << 8,
> -    MSECCFG_SSEED =3D 1 << 9
> +    MSECCFG_MML       =3D 1 << 0,
> +    MSECCFG_MMWP      =3D 1 << 1,
> +    MSECCFG_RLB       =3D 1 << 2,
> +    MSECCFG_USEED     =3D 1 << 8,
> +    MSECCFG_SSEED     =3D 1 << 9,
> +    MSECCFG_PMM       =3D 3UL << 32,

Should use '3ULL' to left shift bits more than 31 bits.
Otherwise, it would generate the error:
"error: left shift count >=3D width of type [-Werror=3Dshift-count-overflow=
]"

Regards,
Frank Chang

>  } mseccfg_field_t;
>
>  typedef struct {
> --
> 2.34.1
>
>

