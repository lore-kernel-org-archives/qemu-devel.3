Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C119C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbcAm-0007Vs-F0; Wed, 07 Aug 2024 04:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sbcAl-0007QC-1J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:37:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sbcAh-0001Es-NY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:37:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc692abba4so15344475ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723019846; x=1723624646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxI+agVjy4dkMl1/wurh3hh+ub3s3x1szMn5jY9PVac=;
 b=PHEUS8mwrC77Ho5nbWQJdbD8T4/VxzbKL1QoQWLRx4FFW2Yl3rZwMthhYuxKYV2LLW
 D1xJ4KQsh1LJiHPzo9KLjq9XUQIMfC9V/8t69r2nSP6jq6sq/xjP/BYPhRGRlS+Hxak+
 H5NgbHE0lSJLqr5qn7B+YIucgVPueoBcfloAqnSTEQ1rx0QLFj27KKgUJ2uvyfBfsTcj
 eVKACNuH6htrLpENV81kaueTLK8Ufoff5U5ktrdGn8Xjn1tM9jkmFPz+BFQZHr3evtLA
 Po7UECx/m/5G/+O4hqS+qf5hZbMyQ8q0BhF1qyQQHrlCUuJIz1R0DOv8iuLxDQDfflNH
 l2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723019846; x=1723624646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxI+agVjy4dkMl1/wurh3hh+ub3s3x1szMn5jY9PVac=;
 b=lXYV3cXf6mo+4Fq4Oc8LDiFx5jGk/Gp2G4bIwNdEaNgO4pISvjZbsLpvgzbJi8ZOi7
 HcvkbsdePtYV7QfCIEy6dh10U322LMCY+MB3Q1tIXicVQLdd2OEkyxIST/Q6RDXTL3n+
 HfbU9z8dtfxWG7Xs7auKXU1+E6IK4SBUetLC3GF2bRbJ+N507UbXHjYgVStgLfNkBisr
 UXpSDfGZAHO6QxooapR0e7WfZQKsdWJcSgdTydFQvXJDzmyYBneYEYgPq8qKpc7ySNtt
 Q0/4U19xUuLSUeqSwYWiFZHKjGY55tN5Jl8B22NnoPBMtXKc5A+ndArAWvLf75Oy9VjH
 CcqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQq3Ecw8G4ZJvc9B6rg2H3IftqJIKDD4XyiqPzhl6KQqsgbch7GXxco/XDNKmzOyq6kn3MX46vTlbrolkNzIJkRvCOkNQ=
X-Gm-Message-State: AOJu0YzWryPAFuCqJn9s0ByjzugyBokRqSjT+2tCEaBqQyjyLNsjDRG3
 JHsmzKZiUbRo/WFb8hADh+zXFmbJhhCbjZxMMJHK7BIXjnODtVbvPY8ksyRvDUA=
X-Google-Smtp-Source: AGHT+IGXHjZRF5SCkAlkUTBlni00hxUqs7AWhPZOFfPf9RhaAQQpi8cUilkas3UzB5toWrzKex4MGw==
X-Received: by 2002:a17:903:1207:b0:1fd:66fd:4dae with SMTP id
 d9443c01a7336-1ff57262a3fmr199142465ad.3.1723019845675; 
 Wed, 07 Aug 2024 01:37:25 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19e68sm100753975ad.45.2024.08.07.01.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 01:37:25 -0700 (PDT)
Message-ID: <db816417-103d-4d81-b9f8-3e6ddfffa61d@sifive.com>
Date: Wed, 7 Aug 2024 16:37:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v6 02/12] hw/riscv: add riscv-iommu-bits.h
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, ajones@ventanamicro.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240801154334.1009852-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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


On 2024/8/1 下午 11:43, Daniel Henrique Barboza wrote:
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
> Reviewed-by: Jason Chien <jason.chien@sifive.com>
> ---
>   hw/riscv/riscv-iommu-bits.h | 345 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 345 insertions(+)
>   create mode 100644 hw/riscv/riscv-iommu-bits.h
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> new file mode 100644
> index 0000000000..9d9512ca71
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -0,0 +1,345 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright Â© 2022-2023 Rivos Inc.
> + * Copyright Â© 2023 FORTH-ICS/CARV
> + * Copyright Â© 2023 RISC-V IOMMU Task Group
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
> +    RISCV_IOMMU_DDTP_MODE_OFF = 0,
> +    RISCV_IOMMU_DDTP_MODE_BARE = 1,
> +    RISCV_IOMMU_DDTP_MODE_1LVL = 2,
> +    RISCV_IOMMU_DDTP_MODE_2LVL = 3,
> +    RISCV_IOMMU_DDTP_MODE_3LVL = 4,
> +    RISCV_IOMMU_DDTP_MODE_MAX = 4
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
> +#define RISCV_IOMMU_REG_ICVEC            0x02F8
The number is misaligned.
> +
> +/* 5.28 MSI Configuration table (32 * 64bits) */
> +#define RISCV_IOMMU_REG_MSI_CONFIG      0x0300
> +
> +#define RISCV_IOMMU_REG_SIZE            0x1000
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
> +    RISCV_IOMMU_DC_IOHGATP_MODE_BARE = 0,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 = 8,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 = 8,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 = 9,
> +    RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 = 10
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
> +    RISCV_IOMMU_DC_FSC_MODE_BARE = 0,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 = 8,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 = 8,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 = 9,
> +    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 = 10,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 = 1,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 = 2,
> +    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 = 3
> +};
> +
> +enum riscv_iommu_fq_causes {
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT           = 1,
> +    RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED   = 4,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT             = 5,
> +    RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED   = 6,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT             = 7,
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S         = 12,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S           = 13,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S           = 15,
> +    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS        = 20,
> +    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS          = 21,
> +    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS          = 23,
> +    RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED         = 256,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT       = 257,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_INVALID          = 258,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED    = 259,
> +    RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED        = 260,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT       = 261,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_INVALID          = 262,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED    = 263,
> +    RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT           = 264,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT       = 265,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_INVALID          = 266,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED    = 267,
> +    RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED        = 268,
> +    RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED        = 269,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED     = 270,
> +    RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED      = 271,
> +    RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR    = 272,
> +    RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT         = 273,
> +    RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED         = 274
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
> +    RISCV_IOMMU_FQ_TTYPE_NONE = 0,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH = 1,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_RD = 2,
> +    RISCV_IOMMU_FQ_TTYPE_UADDR_WR = 3,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
> +    RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
> +    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 8,
> +};
> +
> +/* Fields on pte */
> +#define RISCV_IOMMU_MSI_PTE_V           BIT_ULL(0)
> +#define RISCV_IOMMU_MSI_PTE_M           GENMASK_ULL(2, 1)
> +
> +#define RISCV_IOMMU_MSI_PTE_M_MRIF      1
> +#define RISCV_IOMMU_MSI_PTE_M_BASIC     3
> +
> +/* When M == 1 (MRIF mode) */
> +#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR   GENMASK_ULL(53, 7)
> +/* When M == 3 (basic mode) */
> +#define RISCV_IOMMU_MSI_PTE_PPN         RISCV_IOMMU_PPN_FIELD
> +#define RISCV_IOMMU_MSI_PTE_C           BIT_ULL(63)
> +
> +/* Fields on mrif_info */
> +#define RISCV_IOMMU_MSI_MRIF_NID        GENMASK_ULL(9, 0)
> +#define RISCV_IOMMU_MSI_MRIF_NPPN       RISCV_IOMMU_PPN_FIELD
> +#define RISCV_IOMMU_MSI_MRIF_NID_MSB    BIT_ULL(60)
> +
> +#endif /* _RISCV_IOMMU_BITS_H_ */

