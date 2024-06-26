Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8622DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMI8d-0004qY-7s; Tue, 25 Jun 2024 22:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMI8I-0004nf-Cz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:11:38 -0400
Received: from [2607:f8b0:4864:20::82b] (helo=mail-qt1-x82b.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMI7i-00045x-6U
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:11:30 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-445033fbc24so3566631cf.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719367789; x=1719972589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncdC+GPlt/ou0On6unrYjryzudy4jlqmi/TLhg4D1S8=;
 b=hKCVInZwUN0lL4v2D1LJnxx/fmBJesOwLAnfQrKZcj55IFiSj9J/QzYZIu4J+SDsbL
 bmHcX5lv0jiXUYuxjMZJ1gIhCo3LU2GvBHzJgVO3aDx1u5/QZzDzXfAh1Iu3hVw6+6jH
 ue5DmD3DozfSB1TvsXB3hxW5PPLVmUkpYR9C0sSgPArfxOR0Dv3grlpg91+ncsAuP1E0
 f+rjyD+ufBBgNJYkTV4NmaHKE1LJ+2J6lK/otXoAcZhfFuyqo27Xm3baAYvZcgn1VHhd
 66uk8bTMuNcjqkZKYPthdUfLrSlc3a05DEV7WKK0x9zEPjZKZWGWPsrix4qcawkNl6+t
 2GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719367789; x=1719972589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncdC+GPlt/ou0On6unrYjryzudy4jlqmi/TLhg4D1S8=;
 b=X696ewno41we2KBkNEHpjMK4Fu+6kuBeksWJqXluXYIFUIqTRMEQ6ZL+H6prLy0T5C
 ot5QISCzncbK0ptnQLQ451/XboH3Q2nDCczgRwigCW60j1t0xMh7rO93CUr55jxupXmi
 JJgFEhY0vjSzXri/Bn67XhZLizCWSTzcgOBVEnf3pYZreWMVLz2z+ZryT5rzMGyrPtBe
 Tx5GTHNgDXrzj1+RCxM+QN/LkEF/SMKR3YHIM5xIJkseOCzZW4p9rkLszjbrqSAs9eVZ
 dKRImG73Ploen105XX7Gm7Gglz11l4v7ZECJtk0lNcVrses2D2VFTc1T1hJpxqYujlt4
 ikdg==
X-Gm-Message-State: AOJu0Yw3oLv0hFaVl23nqYW7M4ivLgUAuXH19sZFvmaYehRUd1J4azen
 dXkHFRknoTW7SGnqMZzAEao5hiMXGDYwC0KFtNXzlCMj26xZsVND+ydsJrA2jO0QtEl5Fcb1/rK
 1VmsNS8M8FyFBGR00ZxoKGn5xLXSRa7bm
X-Google-Smtp-Source: AGHT+IH13U29zX0G2YORrlYrIZOrS6g6TJnaa0DFkUx9jaVVbsLjhxlXvYzg8TQYHHxy1w4/BONLXi8p4VXmzTY8+oo=
X-Received: by 2002:a05:6102:446:b0:48f:4396:389f with SMTP id
 ada2fe7eead31-48f52b9b30bmr8494294137.24.1719363608639; Tue, 25 Jun 2024
 18:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 10:59:42 +1000
Message-ID: <CAKmqyKPCLdtkyO+fboYSuaKboHicDP4a1f7YM_hUvmj60qMy+w@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] hw/riscv: add riscv-iommu-bits.h
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::82b
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PDS_HP_HELO_NORDNS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 6:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> This header will be used by the RISC-V IOMMU emulation to be added
> in the next patch. Due to its size it's being sent in separate for
> an easier review.
>
> One thing to notice is that this header can be replaced by the future
> Linux RISC-V IOMMU driver header, which would become a linux-header we
> would import instead of keeping our own. The Linux implementation isn't
> upstream yet so for now we'll have to manage riscv-iommu-bits.h.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>  hw/riscv/riscv-iommu-bits.h | 347 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 347 insertions(+)
>  create mode 100644 hw/riscv/riscv-iommu-bits.h
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> new file mode 100644
> index 0000000000..f29b916acb
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -0,0 +1,347 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright =C2=A9 2022-2023 Rivos Inc.
> + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> + * Copyright =C2=A9 2023 RISC-V IOMMU Task Group
> + *
> + * RISC-V IOMMU - Register Layout and Data Structures.
> + *
> + * Based on the IOMMU spec version 1.0, 3/2023
> + * https://github.com/riscv-non-isa/riscv-iommu
> + */
> +
> +#ifndef HW_RISCV_IOMMU_BITS_H
> +#define HW_RISCV_IOMMU_BITS_H
> +
> +#include "qemu/osdep.h"

We shouldn't include osdep.h in header files

Alistair

> +
> +#define RISCV_IOMMU_SPEC_DOT_VER 0x010
> +
> +#ifndef GENMASK_ULL
> +#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
> +#endif
> +
> +/*
> + * struct riscv_iommu_fq_record - Fault/Event Queue Record
> + * See section 3.2 for more info.
> + */
> +struct riscv_iommu_fq_record {
> +    uint64_t hdr;
> +    uint64_t _reserved;
> +    uint64_t iotval;
> +    uint64_t iotval2;
> +};
> +/* Header fields */
> +#define RISCV_IOMMU_FQ_HDR_CAUSE        GENMASK_ULL(11, 0)
> +#define RISCV_IOMMU_FQ_HDR_PID          GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_FQ_HDR_PV           BIT_ULL(32)
> +#define RISCV_IOMMU_FQ_HDR_TTYPE        GENMASK_ULL(39, 34)
> +#define RISCV_IOMMU_FQ_HDR_DID          GENMASK_ULL(63, 40)
> +
> +/*
> + * struct riscv_iommu_pq_record - PCIe Page Request record
> + * For more infos on the PCIe Page Request queue see chapter 3.3.
> + */
> +struct riscv_iommu_pq_record {
> +      uint64_t hdr;
> +      uint64_t payload;
> +};
> +/* Header fields */
> +#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
> +#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
> +#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
> +#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> +/* Payload fields */
> +#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> +
> +/* Common field positions */
> +#define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
> +#define RISCV_IOMMU_QUEUE_LOGSZ_FIELD   GENMASK_ULL(4, 0)
> +#define RISCV_IOMMU_QUEUE_INDEX_FIELD   GENMASK_ULL(31, 0)
> +#define RISCV_IOMMU_QUEUE_ENABLE        BIT(0)
> +#define RISCV_IOMMU_QUEUE_INTR_ENABLE   BIT(1)
> +#define RISCV_IOMMU_QUEUE_MEM_FAULT     BIT(8)
> +#define RISCV_IOMMU_QUEUE_OVERFLOW      BIT(9)
> +#define RISCV_IOMMU_QUEUE_ACTIVE        BIT(16)
> +#define RISCV_IOMMU_QUEUE_BUSY          BIT(17)
> +#define RISCV_IOMMU_ATP_PPN_FIELD       GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_ATP_MODE_FIELD      GENMASK_ULL(63, 60)
> +
> +/* 5.3 IOMMU Capabilities (64bits) */
> +#define RISCV_IOMMU_REG_CAP             0x0000
> +#define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
> +#define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
> +#define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
> +#define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
> +#define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
> +#define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
> +#define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
> +
> +/* 5.4 Features control register (32bits) */
> +#define RISCV_IOMMU_REG_FCTL            0x0008
> +#define RISCV_IOMMU_FCTL_WSI            BIT(1)
> +
> +/* 5.5 Device-directory-table pointer (64bits) */
> +#define RISCV_IOMMU_REG_DDTP            0x0010
> +#define RISCV_IOMMU_DDTP_MODE           GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_DDTP_BUSY           BIT_ULL(4)
> +#define RISCV_IOMMU_DDTP_PPN            RISCV_IOMMU_PPN_FIELD
> +
> +enum riscv_iommu_ddtp_modes {
> +    RISCV_IOMMU_DDTP_MODE_OFF =3D 0,
> +    RISCV_IOMMU_DDTP_MODE_BARE =3D 1,
> +    RISCV_IOMMU_DDTP_MODE_1LVL =3D 2,
> +    RISCV_IOMMU_DDTP_MODE_2LVL =3D 3,
> +    RISCV_IOMMU_DDTP_MODE_3LVL =3D 4,
> +    RISCV_IOMMU_DDTP_MODE_MAX =3D 4
> +};
> +
> +/* 5.6 Command Queue Base (64bits) */
> +#define RISCV_IOMMU_REG_CQB             0x0018
> +#define RISCV_IOMMU_CQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
> +#define RISCV_IOMMU_CQB_PPN             RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.7 Command Queue head (32bits) */
> +#define RISCV_IOMMU_REG_CQH             0x0020
> +
> +/* 5.8 Command Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_CQT             0x0024
> +
> +/* 5.9 Fault Queue Base (64bits) */
> +#define RISCV_IOMMU_REG_FQB             0x0028
> +#define RISCV_IOMMU_FQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
> +#define RISCV_IOMMU_FQB_PPN             RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.10 Fault Queue Head (32bits) */
> +#define RISCV_IOMMU_REG_FQH             0x0030
> +
> +/* 5.11 Fault Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_FQT             0x0034
> +
> +/* 5.12 Page Request Queue base (64bits) */
> +#define RISCV_IOMMU_REG_PQB             0x0038
> +#define RISCV_IOMMU_PQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
> +#define RISCV_IOMMU_PQB_PPN             RISCV_IOMMU_PPN_FIELD
> +
> +/* 5.13 Page Request Queue head (32bits) */
> +#define RISCV_IOMMU_REG_PQH             0x0040
> +
> +/* 5.14 Page Request Queue tail (32bits) */
> +#define RISCV_IOMMU_REG_PQT             0x0044
> +
> +/* 5.15 Command Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_CQCSR           0x0048
> +#define RISCV_IOMMU_CQCSR_CQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_CQCSR_CIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_CQCSR_CQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_CQCSR_CMD_TO        BIT(9)
> +#define RISCV_IOMMU_CQCSR_CMD_ILL       BIT(10)
> +#define RISCV_IOMMU_CQCSR_FENCE_W_IP    BIT(11)
> +#define RISCV_IOMMU_CQCSR_CQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_CQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.16 Fault Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_FQCSR           0x004C
> +#define RISCV_IOMMU_FQCSR_FQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_FQCSR_FIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_FQCSR_FQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_FQCSR_FQOF          RISCV_IOMMU_QUEUE_OVERFLOW
> +#define RISCV_IOMMU_FQCSR_FQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_FQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.17 Page Request Queue CSR (32bits) */
> +#define RISCV_IOMMU_REG_PQCSR           0x0050
> +#define RISCV_IOMMU_PQCSR_PQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_PQCSR_PIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_PQCSR_PQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
> +#define RISCV_IOMMU_PQCSR_PQOF          RISCV_IOMMU_QUEUE_OVERFLOW
> +#define RISCV_IOMMU_PQCSR_PQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_PQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +/* 5.18 Interrupt Pending Status (32bits) */
> +#define RISCV_IOMMU_REG_IPSR            0x0054
> +#define RISCV_IOMMU_IPSR_CIP            BIT(0)
> +#define RISCV_IOMMU_IPSR_FIP            BIT(1)
> +#define RISCV_IOMMU_IPSR_PIP            BIT(3)
> +
> +enum {
> +    RISCV_IOMMU_INTR_CQ,
> +    RISCV_IOMMU_INTR_FQ,
> +    RISCV_IOMMU_INTR_PM,
> +    RISCV_IOMMU_INTR_PQ,
> +    RISCV_IOMMU_INTR_COUNT
> +};
> +
> +/* 5.27 Interrupt cause to vector (64bits) */
> +#define RISCV_IOMMU_REG_IVEC            0x02F8
> +
> +/* 5.28 MSI Configuration table (32 * 64bits) */
> +#define RISCV_IOMMU_REG_MSI_CONFIG      0x0300
> +
> +#define RISCV_IOMMU_REG_SIZE           0x1000
> +
> +#define RISCV_IOMMU_DDTE_VALID          BIT_ULL(0)
> +#define RISCV_IOMMU_DDTE_PPN            RISCV_IOMMU_PPN_FIELD
> +
> +/* Struct riscv_iommu_dc - Device Context - section 2.1 */
> +struct riscv_iommu_dc {
> +      uint64_t tc;
> +      uint64_t iohgatp;
> +      uint64_t ta;
> +      uint64_t fsc;
> +      uint64_t msiptp;
> +      uint64_t msi_addr_mask;
> +      uint64_t msi_addr_pattern;
> +      uint64_t _reserved;
> +};
> +
> +/* Translation control fields */
> +#define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
> +#define RISCV_IOMMU_DC_TC_EN_PRI        BIT_ULL(2)
> +#define RISCV_IOMMU_DC_TC_T2GPA         BIT_ULL(3)
> +#define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
> +#define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
> +#define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
> +#define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
> +#define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
> +
> +/* Second-stage (aka G-stage) context fields */
> +#define RISCV_IOMMU_DC_IOHGATP_PPN      RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_IOHGATP_GSCID    GENMASK_ULL(59, 44)
> +#define RISCV_IOMMU_DC_IOHGATP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
> +
> +enum riscv_iommu_dc_iohgatp_modes {
> +    RISCV_IOMMU_DC_IOHGATP_MODE_BARE =3D 0,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 =3D 8,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 =3D 8,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 =3D 9,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 =3D 10
> +};
> +
> +/* Translation attributes fields */
> +#define RISCV_IOMMU_DC_TA_PSCID         GENMASK_ULL(31, 12)
> +
> +/* First-stage context fields */
> +#define RISCV_IOMMU_DC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_FSC_MODE         RISCV_IOMMU_ATP_MODE_FIELD
> +
> +/* Generic I/O MMU command structure - check section 3.1 */
> +struct riscv_iommu_command {
> +    uint64_t dword0;
> +    uint64_t dword1;
> +};
> +
> +#define RISCV_IOMMU_CMD_OPCODE          GENMASK_ULL(6, 0)
> +#define RISCV_IOMMU_CMD_FUNC            GENMASK_ULL(9, 7)
> +
> +#define RISCV_IOMMU_CMD_IOTINVAL_OPCODE         1
> +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA       0
> +#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA      1
> +#define RISCV_IOMMU_CMD_IOTINVAL_AV     BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOTINVAL_PSCID  GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_CMD_IOTINVAL_PSCV   BIT_ULL(32)
> +#define RISCV_IOMMU_CMD_IOTINVAL_GV     BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_IOTINVAL_GSCID  GENMASK_ULL(59, 44)
> +
> +#define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
> +#define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
> +#define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
> +
> +#define RISCV_IOMMU_CMD_IODIR_OPCODE            3
> +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT    0
> +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT    1
> +#define RISCV_IOMMU_CMD_IODIR_PID       GENMASK_ULL(31, 12)
> +#define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
> +#define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
> +
> +enum riscv_iommu_dc_fsc_atp_modes {
> +    RISCV_IOMMU_DC_FSC_MODE_BARE =3D 0,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 =3D 8,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 =3D 8,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 =3D 9,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 =3D 10,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 =3D 1,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 =3D 2,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 =3D 3
> +};
> +
> +enum riscv_iommu_fq_causes {
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT           =3D 1,
> +    RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED   =3D 4,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT             =3D 5,
> +    RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED   =3D 6,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT             =3D 7,
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S         =3D 12,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S           =3D 13,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S           =3D 15,
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS        =3D 20,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS          =3D 21,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS          =3D 23,
> +    RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED         =3D 256,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT       =3D 257,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_INVALID          =3D 258,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED    =3D 259,
> +    RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED        =3D 260,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT       =3D 261,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_INVALID          =3D 262,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED    =3D 263,
> +    RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT           =3D 264,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT       =3D 265,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_INVALID          =3D 266,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED    =3D 267,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED        =3D 268,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED        =3D 269,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED     =3D 270,
> +    RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED      =3D 271,
> +    RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR    =3D 272,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT         =3D 273,
> +    RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED         =3D 274
> +};
> +
> +/* MSI page table pointer */
> +#define RISCV_IOMMU_DC_MSIPTP_PPN       RISCV_IOMMU_ATP_PPN_FIELD
> +#define RISCV_IOMMU_DC_MSIPTP_MODE      RISCV_IOMMU_ATP_MODE_FIELD
> +#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
> +#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
> +
> +/* Translation attributes fields */
> +#define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> +
> +/* First stage context fields */
> +#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +
> +enum riscv_iommu_fq_ttypes {
> +    RISCV_IOMMU_FQ_TTYPE_NONE =3D 0,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH =3D 1,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_RD =3D 2,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_WR =3D 3,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH =3D 5,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_RD =3D 6,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_WR =3D 7,
> +    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 8,
> +};
> +
> +/* Fields on pte */
> +#define RISCV_IOMMU_MSI_PTE_V           BIT_ULL(0)
> +#define RISCV_IOMMU_MSI_PTE_M           GENMASK_ULL(2, 1)
> +
> +#define RISCV_IOMMU_MSI_PTE_M_MRIF      1
> +#define RISCV_IOMMU_MSI_PTE_M_BASIC     3
> +
> +/* When M =3D=3D 1 (MRIF mode) */
> +#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR   GENMASK_ULL(53, 7)
> +/* When M =3D=3D 3 (basic mode) */
> +#define RISCV_IOMMU_MSI_PTE_PPN         RISCV_IOMMU_PPN_FIELD
> +#define RISCV_IOMMU_MSI_PTE_C           BIT_ULL(63)
> +
> +/* Fields on mrif_info */
> +#define RISCV_IOMMU_MSI_MRIF_NID        GENMASK_ULL(9, 0)
> +#define RISCV_IOMMU_MSI_MRIF_NPPN       RISCV_IOMMU_PPN_FIELD
> +#define RISCV_IOMMU_MSI_MRIF_NID_MSB    BIT_ULL(60)
> +
> +#endif /* _RISCV_IOMMU_BITS_H_ */
> --
> 2.45.2
>
>

