Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69915CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPFR-00051O-PA; Thu, 05 Sep 2024 23:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPFJ-00050I-Dl; Thu, 05 Sep 2024 23:02:50 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPFH-00043q-Gn; Thu, 05 Sep 2024 23:02:49 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-50108b3749aso461457e0c.2; 
 Thu, 05 Sep 2024 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725591766; x=1726196566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNSclVpTiR8Njj8/kD+KfBtRX2a2WbWdcqVJozq4MLw=;
 b=C5HU4VgzYGeOxrZbZEqWJ812oYsBNEp/Zs7EDMOrAuz8GbJeHVnziut1nc2+PM4nVZ
 bR9JPpDQqsd9Gg6epwPDveMQLeCiQ5B0JDOVZ0xejHC1nEyAhAwDzUp3JydoL5ZaoIab
 vqF3HH796Z4oVyDFryUSZJBMrS3+kifG/S4WqpH+BQrAYdEqSF4zcKbkXQIJM8tXKO08
 kZTcyJr8yaWCRL0T4lvxUdT/fZcHunuCGFaaK5bt8dAABnkS69x312HB2YHxoErHMNOL
 9qVvopH7MSrCLekeR0qW7erivwGO4RmZGW01r00lNBCq7zHaEcX136o0iMdK2s/6nnFh
 tegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725591766; x=1726196566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNSclVpTiR8Njj8/kD+KfBtRX2a2WbWdcqVJozq4MLw=;
 b=WhZRXJUOrYWwFijbwHByGXRGZIXJiG5Bw6GVSnb4TAKKV6CQTT5PtqpYVI0kEYLAxO
 lhYLS80E9rfbtI+L3pGoIyzK4V4t4Nf1iMRi8WC07Skvl4whtsx7HNNMRGrbtQUb4NTC
 Dkz8uMXTrsOjl7XCLsE/ECZAJSIwW5FClU1wcBpzPs6nlhcMG/cSgVYuEGu5lU8T/cZa
 tnMzGr0PL1guSFFR/eikiVnCTiuSIJ8wMPNcwYwf8s6gF5kd08xER3CrXjqjXZMzwYD7
 Wh6/Tfvvv/qlbHjnS5znOQbdGoMIzWXhKbxQR1k0Bv2Q4YndC6uasQjXg9mclT2jYeDk
 IM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBRXkCn35TlLu/OmHT8vsdXfnwe7OsrAjZh+MYWGuW3/FF/l0w7mykGM7O27ArQXdtShOlG8EZ4eWW@nongnu.org
X-Gm-Message-State: AOJu0YxDgnimjeiJkPUYO8B7dgqX6acg0KbrUGdLttr+XiLyCfqP6Gzs
 AqQ140rU3D8HVNMEpKNdCm4zdAKbmUkq1cNm67u+nysNSXBiHkG6dmkgFVSETueU5fTj7DAErhb
 Y8ybslXipRfSNvWhY3M3+k8jcpyRDwtnG
X-Google-Smtp-Source: AGHT+IEvYtFVyoDBKaZ8e8MNPaJevMjv1a5wBXXUzNfZrZaYzUvvK6lX0I+hx/JEDTUK0uaPjIBM+oBWEZJqzQj571M=
X-Received: by 2002:a05:6122:92a:b0:4f6:a7f7:164d with SMTP id
 71dfb90a1353d-50221423548mr1402187e0c.8.1725591765766; Thu, 05 Sep 2024
 20:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-10-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-10-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:02:19 +1000
Message-ID: <CAKmqyKMZhGKTDv5g1HxUTz-Ry9BGa4wptvZaGQATWJ+TqA5wGA@mail.gmail.com>
Subject: Re: [PATCH 06/11 v2] target/riscv: Update CSR xtvec in CLIC mode
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 20, 2024 at 2:15=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> From: Ian Brockbank <ian.brockbank@cirrus.com>
>
> The new CLIC interrupt-handling mode is encoded as a new state in the
> existing WARL xtvec register, where the low two bits of are 11.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> ---
>  target/riscv/cpu.h      |  2 ++
>  target/riscv/cpu_bits.h |  2 ++
>  target/riscv/csr.c      | 63 ++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 12aa8cf6b1..05a014db03 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -283,11 +283,13 @@ struct CPUArchState {
>      target_ulong medeleg;
>
>      target_ulong stvec;
> +    target_ulong stvt; /* clic-spec */
>      target_ulong sepc;
>      target_ulong scause;
>      target_ulong sintthresh; /* clic-spec */
>
>      target_ulong mtvec;
> +    target_ulong mtvt; /* clic-spec */
>      target_ulong mepc;
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 0ed44ec0a8..279a6f889b 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -153,6 +153,7 @@
>  #define CSR_MIE             0x304
>  #define CSR_MTVEC           0x305
>  #define CSR_MCOUNTEREN      0x306
> +#define CSR_MTVT            0x307 /* clic-spec-draft */
>
>  /* 32-bit only */
>  #define CSR_MSTATUSH        0x310
> @@ -192,6 +193,7 @@
>  #define CSR_SIE             0x104
>  #define CSR_STVEC           0x105
>  #define CSR_SCOUNTEREN      0x106
> +#define CSR_STVT            0x107 /* clic-spec-draft */
>
>  /* Supervisor Configuration CSRs */
>  #define CSR_SENVCFG         0x10A
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 276ef7856e..be0071fd25 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2170,9 +2170,23 @@ static RISCVException read_mtvec(CPURISCVState *en=
v, int csrno,
>  static RISCVException write_mtvec(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
> -    if ((val & 3) < 2) {
> +    /*
> +     * bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 3 =3D CLIC,
> +     * others reserved

You aren't checking if the CLIC extension (smclic) is enabled though.

You need to guard these changes with a smclic extension check

Alistair

> +     */
> +    target_ulong mode =3D get_field(val, XTVEC_MODE);
> +    target_ulong fullmode =3D val & XTVEC_FULL_MODE;
> +    if (mode <=3D XTVEC_CLINT_VECTORED) {
>          env->mtvec =3D val;
> +    } else if (XTVEC_CLIC =3D=3D fullmode && env->clic) {
> +        /*
> +         * CLIC mode hardwires xtvec bits 2-5 to zero.
> +         * Layout:
> +         *   XLEN-1:6   base (WARL)
> +         *   5:2        submode (WARL)  - 0000 for CLIC
> +         *   1:0        mode (WARL)     - 11 for CLIC
> +         */
> +        env->mtvec =3D (val & XTVEC_NBASE) | XTVEC_CLIC;
>      } else {
>          qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: reserved mode not supported=
\n");
>      }
> @@ -2271,6 +2285,18 @@ static RISCVException write_mcounteren(CPURISCVSta=
te *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static int read_mtvt(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->mtvt;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mtvt(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mtvt =3D val & XTVEC_NBASE;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /* Machine Trap Handling */
>  static RISCVException read_mscratch_i128(CPURISCVState *env, int csrno,
>                                           Int128 *val)
> @@ -3122,9 +3148,24 @@ static RISCVException read_stvec(CPURISCVState *en=
v, int csrno,
>  static RISCVException write_stvec(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
> -    if ((val & 3) < 2) {
> +    /*
> +     * bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 3 =3D CLIC,
> +     * others reserved
> +     */
> +    target_ulong mode =3D val & XTVEC_MODE;
> +    target_ulong fullmode =3D val & XTVEC_FULL_MODE;
> +    if (mode <=3D XTVEC_CLINT_VECTORED) {
>          env->stvec =3D val;
> +    } else if (XTVEC_CLIC =3D=3D fullmode && env->clic) {
> +        /*
> +         * If only CLIC mode is supported, writes to bit 1 are also igno=
red and
> +         * it is always set to one. CLIC mode hardwires xtvec bits 2-5 t=
o zero.
> +         * Layout:
> +         *   XLEN-1:6   base (WARL)
> +         *   5:2        submode (WARL)  - 0000 for CLIC
> +         *   1:0        mode (WARL)     - 11 for CLIC
> +         */
> +        env->stvec =3D (val & XTVEC_NBASE) | XTVEC_CLIC;
>      } else {
>          qemu_log_mask(LOG_UNIMP, "CSR_STVEC: reserved mode not supported=
\n");
>      }
> @@ -3149,6 +3190,18 @@ static RISCVException write_scounteren(CPURISCVSta=
te *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static int read_stvt(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->stvt;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_stvt(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->stvt =3D val & XTVEC_NBASE;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /* Supervisor Trap Handling */
>  static RISCVException read_sscratch_i128(CPURISCVState *env, int csrno,
>                                           Int128 *val)
> @@ -5666,11 +5719,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
>                               write_mhpmcounterh                         =
},
>
>      /* Machine Mode Core Level Interrupt Controller */
> +    [CSR_MTVT]           =3D { "mtvt",       clic,  read_mtvt, write_mtv=
t },
>      [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus     =
  },
>      [CSR_MINTTHRESH]     =3D { "mintthresh", clic,  read_mintthresh,
>                               write_mintthresh },
>
>      /* Supervisor Mode Core Level Interrupt Controller */
> +    [CSR_STVT]           =3D { "stvt",       clic,  read_stvt, write_stv=
t },
>      [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus     =
  },
>      [CSR_SINTTHRESH]     =3D { "sintthresh", clic,  read_sintthresh,
>                               write_sintthresh },
> --
> 2.46.0.windows.1
> This message and any attachments may contain privileged and confidential =
information that is intended solely for the person(s) to whom it is address=
ed. If you are not an intended recipient you must not: read; copy; distribu=
te; discuss; take any action in or make any reliance upon the contents of t=
his message; nor open or read any attachment. If you have received this mes=
sage in error, please notify us as soon as possible on the following teleph=
one number and destroy this message including any attachments. Thank you. C=
irrus Logic International (UK) Ltd and Cirrus Logic International Semicondu=
ctor Ltd are companies registered in Scotland, with registered numbers SC08=
9839 and SC495735 respectively. Our registered office is at 7B Nightingale =
Way, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cir=
rus.com
>

