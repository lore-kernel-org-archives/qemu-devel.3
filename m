Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64905CE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 02:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smOy0-0003os-Fx; Thu, 05 Sep 2024 22:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smOxy-0003nz-Vz; Thu, 05 Sep 2024 22:44:55 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smOxx-0001k7-4j; Thu, 05 Sep 2024 22:44:54 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-49bc42bec6dso473015137.0; 
 Thu, 05 Sep 2024 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725590691; x=1726195491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUT9NO6rTjbp9gKZfO0iOXuxso7AXZjOtWiwnRGHHms=;
 b=Pr06fdLaDEZmThkz/xWNbgKUm9UKgp/ipWeYnmqMNS3detvqLcsFf01QgFZ8JNawR3
 4sx8VtGEnKIQRvjg7MclHfqFqQa0Xy7MN72yw2j1BPwClMBodHRYlc3A4tP4DRLFTs26
 a7yOFxqX0NTzVAuup2e6V+cXRp7bVRqrX8JL9hxLP0oia8XVwb5Y2vQakVV/7XBFbb3A
 y7+PpJQpPbBaeIeR6mwIl1cy0bDGxQpn8T4dfReXTO0F2LUIqQB8hBTj4n5uj8fz9Nil
 bMvYwBI+FxtT821Qh+K9Z+lkTzAMGFqd4txa70ataXsFkPKep3dibAPBH5a/iN03Q+H8
 a0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725590691; x=1726195491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUT9NO6rTjbp9gKZfO0iOXuxso7AXZjOtWiwnRGHHms=;
 b=SyRtrQOcoJZP1z28vGxcN8FkGGvXFKbRsOt2eBtkJHCfz/M7pJHtv6UO+i36yP+gXc
 koYZcDptWwoCEjp7Y+QnoG+t0LKGAr/ao5Ho3wTRwu/nlZyLw86Vb/PdPfDjMg7n9BNF
 ez/MnFVR5b0r+lPRFoGm9MBZmq04BP8RbR/SsJCT8k9tJeMYlvxgHS7LwqjeXMM9OkHR
 PuuTHkDbHlM4ylVxaxebAytYIAZ+ouVAcNbDXkgXYsLPhoz7n4p/VTW7McSpYjP1AGrF
 r7x+Eip/8ZZy7+6pKPFsYBhBDCy4wUWOj1ixOATcLyy9H98WDZ274/KEMcJFpoEqjiZ9
 E9vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJTkYIT7n41SPr86RanTnktSjDq0To66TvwPi2A8cnXvBFDBlakRGMnT0EAnLmild0ykccrFcaR8kZ@nongnu.org
X-Gm-Message-State: AOJu0YytyaENuNQ9KL8X3JYuvfBQCnjMQy0RNotDMkr4j3KaQL50zH9h
 6GzKKKmcvLTJxg0L/dDDvOKfUx2xepxwk2NSasgegxyVbqopiWd2looV6GvGoz9qLHglutFfEwb
 CKh4wVtBRr7DW3m/x9K5MtWYzO/s=
X-Google-Smtp-Source: AGHT+IFufQhLaMklGmqiFn51RvAYjPqnH+taXTzF2LRDVqNMDI9sqH8YaJVGCAYTPwSYXFzrQASr9UqIPVRF2Yjly1o=
X-Received: by 2002:a05:6102:3e82:b0:493:eebc:d77d with SMTP id
 ada2fe7eead31-49bde18b6a2mr1418721137.15.1725590691425; Thu, 05 Sep 2024
 19:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-3-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-3-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 12:44:25 +1000
Message-ID: <CAKmqyKP6DTHq=6Tv3F7DPzjiyXdJhUdr0isNokZPCFgstQV4gQ@mail.gmail.com>
Subject: Re: [PATCH 01/11 v2] target/riscv: Add CLIC CSR mintstatus
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Tue, Aug 20, 2024 at 2:11=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> From: Ian Brockbank <ian.brockbank@cirrus.com>
>
> CSR mintstatus holds the active interrupt level for each supported
> privilege mode. sintstatus, and user, uintstatus, provide restricted
> views of mintstatus.
>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

> ---
>  target/riscv/cpu.h      |  3 +++
>  target/riscv/cpu_bits.h | 11 +++++++++++
>  target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1619c3acb6..95303f50d3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -259,6 +259,7 @@ struct CPUArchState {
>      bool software_seip;
>
>      uint64_t miclaim;
> +    uint64_t mintstatus; /* clic-spec */
>
>      uint64_t mie;
>      uint64_t mideleg;
> @@ -461,6 +462,8 @@ struct CPUArchState {
>      QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
>      bool vstime_irq;
>
> +    void *clic;       /* clic interrupt controller */
> +
>      hwaddr kernel_addr;
>      hwaddr fdt_addr;
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 32b068f18a..2e65495b54 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -165,6 +165,7 @@
>  #define CSR_MCAUSE          0x342
>  #define CSR_MTVAL           0x343
>  #define CSR_MIP             0x344
> +#define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */
>
>  /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
>  #define CSR_MISELECT        0x350
> @@ -206,6 +207,7 @@
>  #define CSR_SCAUSE          0x142
>  #define CSR_STVAL           0x143
>  #define CSR_SIP             0x144
> +#define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */
>
>  /* Sstc supervisor CSRs */
>  #define CSR_STIMECMP        0x14D
> @@ -733,6 +735,15 @@ typedef enum RISCVException {
>  #define SIP_SEIP                           MIP_SEIP
>  #define SIP_LCOFIP                         MIP_LCOFIP
>
> +/* mintstatus */
> +#define MINTSTATUS_MIL                     0xff000000 /* mil[31:24] */
> +#define MINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
> +#define MINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
> +
> +/* sintstatus */
> +#define SINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
> +#define SINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
> +
>  /* MIE masks */
>  #define MIE_SEIE                           (1 << IRQ_S_EXT)
>  #define MIE_UEIE                           (1 << IRQ_U_EXT)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea3560342c..f9ed7b9079 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -578,6 +578,16 @@ static RISCVException debug(CPURISCVState *env, int =
csrno)
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> +
> +static int clic(CPURISCVState *env, int csrno)
> +{
> +    if (env->clic) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>  #endif
>
>  static RISCVException seed(CPURISCVState *env, int csrno)
> @@ -2887,6 +2897,12 @@ static RISCVException rmw_mviph(CPURISCVState *env=
, int csrno,
>      return ret;
>  }
>
> +static int read_mintstatus(CPURISCVState *env, int csrno, target_ulong *=
val)
> +{
> +    *val =3D env->mintstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /* Supervisor Trap Setup */
>  static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                          Int128 *val)
> @@ -3298,6 +3314,14 @@ static RISCVException rmw_siph(CPURISCVState *env,=
 int csrno,
>      return ret;
>  }
>
> +static int read_sintstatus(CPURISCVState *env, int csrno, target_ulong *=
val)
> +{
> +    /* sintstatus is a filtered view of mintstatus with the PRV_M remove=
d */
> +    target_ulong mask =3D SINTSTATUS_SIL | SINTSTATUS_UIL;
> +    *val =3D env->mintstatus & mask;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  /* Supervisor Protection and Translation */
>  static RISCVException read_satp(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
> @@ -5594,6 +5618,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                               write_mhpmcounterh                         =
},
>      [CSR_MHPMCOUNTER31H] =3D { "mhpmcounter31h", mctr32,  read_hpmcounte=
rh,
>                               write_mhpmcounterh                         =
},
> +
> +    /* Machine Mode Core Level Interrupt Controller */
> +    [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus     =
  },
> +
> +    /* Supervisor Mode Core Level Interrupt Controller */
> +    [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus     =
  },
> +
>      [CSR_SCOUNTOVF]      =3D { "scountovf", sscofpmf,  read_scountovf,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0 },
>
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

It looks like some patch mangling is going on here

Alistair

