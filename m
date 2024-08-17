Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE0C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfHhE-00069Z-2W; Sat, 17 Aug 2024 07:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sfHhB-00067P-L0
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 07:34:09 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sfHh7-0004UG-GM
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 07:34:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b6so1229901a12.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723894443; x=1724499243; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tTMHj8loPt3rXlOj8YPgbBdaDejvMK+E2URxVicmVmM=;
 b=T4mtnDTELnrvYAYNVYGW6Gc6TDox3q+SiGSxTS1las4OSCcRm+UhvBYuXgxNFapeS/
 6ix9sYtkqVlAy0XVSpnuoxr67wICQjqrrv5g0/YgLKbBRRds5vY1wcxa+6LW1/OAzSZj
 60JESQ84GDBflc81ZS3pn3rp2TeFprlrYuDWeikx8bgNwBtiPL9W8KOwiMWbpAmrICPY
 EAhXWCiDqkJZ4I2wpjg5+JqelMoBdWyyyfJ9QqxOFxTZpFdViV20AELMNpDy86IsXIBF
 vBzdjEbEBxpTCC5z+QXStCKrnvL8PpgjI82oX6+7f/yhHXcKk0yT/d2fo63nic6yngvv
 71/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723894443; x=1724499243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTMHj8loPt3rXlOj8YPgbBdaDejvMK+E2URxVicmVmM=;
 b=GUCNb2edyC+6sHeaOqIs3gtMEzIbk4vc4zJNxtAxT62mLQw8W62WuIhEykK/Y4A+71
 Xbpvw6JqYNcH5+ipqcKR05+58cakHBNK9IeVfcd60rc/7P9PvG3Ghh9reJCcNskuqjrS
 utM9vAU5DLr0Z8vLNTu0nCi6lfVhNKTBxGuOdNWmHgiCZQK3zkDGlKTxVqoY/6J+vbd1
 mqq+0n9BTSFowTNdMKN6pDalvUMZDUHjx9IsS1fB1zQCiQx7gy3tRZp70QNG4QQHuzzK
 naznHU7erXlUQ7Gn7C2Tef05Wm9Ao1J7llxBHPrjKyWhZAWLnhQjFKR5qYZ8yMf/H9LS
 iTwQ==
X-Gm-Message-State: AOJu0Yx8YfM7jskZ4NOHCEehntJkGBE3kjZO+qVy4pTQyLX69MAu+aFJ
 tCdExGu64b3J3dIz+8xkxpOuIs6UPahD/ps7C2nCmIUMYzw5Xmq5UOxVjXrgA0s=
X-Google-Smtp-Source: AGHT+IFdx9StP/jnsmFarWJwxVSHM+C92jr6wcKIKj3KyJsW3LkMzr0bwdi79gX7LJmGRUlg0kREkQ==
X-Received: by 2002:a05:6402:2695:b0:5be:e94b:dc4b with SMTP id
 4fb4d7f45d1cf-5bee94be4e6mr480411a12.26.1723894442766; 
 Sat, 17 Aug 2024 04:34:02 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde7cd4sm3374730a12.39.2024.08.17.04.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2024 04:34:02 -0700 (PDT)
Date: Sat, 17 Aug 2024 13:34:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 Tomasz Jeznach <tjeznach@rivosinc.com>, Sebastien Boeuf <seb@rivosinc.com>
Subject: Re: [PATCH for-9.2 v6 03/12] hw/riscv: add RISC-V IOMMU base emulation
Message-ID: <20240817-08bebc0e0a1cd92c2d9aff8a@orel>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801154334.1009852-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 01, 2024 at 12:43:24PM GMT, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> international process. The latest frozen specifcation can be found at:
> 
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
> 
> Add the foundation of the device emulation for RISC-V IOMMU. It includes
> support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage (sv32x4,
> sv39x4, sv48x4, sv57x4 caps).
> 
> Other capabilities like ATS and DBG support will be added incrementally
> in the next patches.
> 
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/Kconfig            |    4 +
>  hw/riscv/meson.build        |    1 +
>  hw/riscv/riscv-iommu-bits.h |   14 +
>  hw/riscv/riscv-iommu.c      | 2017 +++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h      |  148 +++
>  hw/riscv/trace-events       |   12 +
>  hw/riscv/trace.h            |    1 +
>  include/hw/riscv/iommu.h    |   36 +
>  meson.build                 |    1 +
>  9 files changed, 2234 insertions(+)
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..f69d6e3c8e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,3 +1,6 @@
> +config RISCV_IOMMU
> +    bool
> +
>  config RISCV_NUMA
>      bool
>  
> @@ -47,6 +50,7 @@ config RISCV_VIRT
>      select SERIAL
>      select RISCV_ACLINT
>      select RISCV_APLIC
> +    select RISCV_IOMMU
>      select RISCV_IMSIC
>      select SIFIVE_PLIC
>      select SIFIVE_TEST
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093..cbc99c6e8e 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
>  
>  hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 9d9512ca71..6f1b9ab61b 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -69,6 +69,14 @@ struct riscv_iommu_pq_record {
>  /* 5.3 IOMMU Capabilities (64bits) */
>  #define RISCV_IOMMU_REG_CAP             0x0000
>  #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
> +#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
> +#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
> +#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
> +#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
> +#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> +#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
> @@ -80,7 +88,9 @@ struct riscv_iommu_pq_record {
>  
>  /* 5.4 Features control register (32bits) */
>  #define RISCV_IOMMU_REG_FCTL            0x0008
> +#define RISCV_IOMMU_FCTL_BE             BIT(0)
>  #define RISCV_IOMMU_FCTL_WSI            BIT(1)
> +#define RISCV_IOMMU_FCTL_GXL            BIT(2)
>  
>  /* 5.5 Device-directory-table pointer (64bits) */
>  #define RISCV_IOMMU_REG_DDTP            0x0010
> @@ -203,6 +213,8 @@ struct riscv_iommu_dc {
>  #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
>  #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
>  #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
> +#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
>  #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
>  #define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
>  #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
> @@ -309,9 +321,11 @@ enum riscv_iommu_fq_causes {
>  
>  /* Translation attributes fields */
>  #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> +#define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
>  
>  /* First stage context fields */
>  #define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
>  
>  enum riscv_iommu_fq_ttypes {
>      RISCV_IOMMU_FQ_TTYPE_NONE = 0,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> new file mode 100644
> index 0000000000..ebe3a53a04
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.c
> @@ -0,0 +1,2017 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2021-2023, Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +
> +#include "cpu_bits.h"
> +#include "riscv-iommu.h"
> +#include "riscv-iommu-bits.h"
> +#include "trace.h"
> +
> +#define LIMIT_CACHE_CTX               (1U << 7)
> +#define LIMIT_CACHE_IOT               (1U << 20)
> +
> +/* Physical page number coversions */
> +#define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
> +#define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
> +
> +typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> +typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
> +
> +/* Device assigned I/O address space */
> +struct RISCVIOMMUSpace {
> +    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
> +    AddressSpace iova_as;       /* IOVA address space for attached device */
> +    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> +    uint32_t devid;             /* Requester identifier, AKA device_id */
> +    bool notifier;              /* IOMMU unmap notifier enabled */
> +    QLIST_ENTRY(RISCVIOMMUSpace) list;
> +};
> +
> +/* Device translation context state. */
> +struct RISCVIOMMUContext {
> +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> +    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
> +    uint64_t __rfu:20;          /* reserved */
> +    uint64_t tc;                /* Translation Control */
> +    uint64_t ta;                /* Translation Attributes */
> +    uint64_t satp;              /* S-Stage address translation and protection */
> +    uint64_t gatp;              /* G-Stage address translation and protection */
> +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> +    uint64_t msiptp;            /* MSI redirection page table pointer */
> +};
> +
> +/* IOMMU index for transactions without process_id specified. */
> +#define RISCV_IOMMU_NOPROCID 0
> +
> +static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
> +{
> +    g_assert(vec_type < 4);
> +    return (icvec >> (vec_type * 4)) & 0x0F;
> +}
> +
> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
> +{
> +    const uint32_t fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
> +    uint32_t ipsr, icvec;
> +
> +    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> +        return;
> +    }
> +
> +    icvec = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_ICVEC);
> +    ipsr = riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
> +
> +    if (!(ipsr & (1 << vec))) {
> +        s->notify(s, riscv_iommu_get_icvec_vector(icvec, vec));
> +    }
> +}
> +
> +static void riscv_iommu_fault(RISCVIOMMUState *s,
> +                              struct riscv_iommu_fq_record *ev)
> +{
> +    uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +    uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
> +    uint32_t tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQT) & s->fq_mask;
> +    uint32_t next = (tail + 1) & s->fq_mask;
> +    uint32_t devid = get_field(ev->hdr, RISCV_IOMMU_FQ_HDR_DID);
> +
> +    trace_riscv_iommu_flt(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> +                          PCI_FUNC(devid), ev->hdr, ev->iotval);
> +
> +    if (!(ctrl & RISCV_IOMMU_FQCSR_FQON) ||
> +        !!(ctrl & (RISCV_IOMMU_FQCSR_FQOF | RISCV_IOMMU_FQCSR_FQMF))) {
> +        return;
> +    }
> +
> +    if (head == next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                              RISCV_IOMMU_FQCSR_FQOF, 0);
> +    } else {
> +        dma_addr_t addr = s->fq_addr + tail * sizeof(*ev);
> +        if (dma_memory_write(s->target_as, addr, ev, sizeof(*ev),
> +                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                                  RISCV_IOMMU_FQCSR_FQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_FQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_FQCSR_FIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_FQ);
> +    }
> +}
> +
> +static void riscv_iommu_pri(RISCVIOMMUState *s,
> +    struct riscv_iommu_pq_record *pr)
> +{
> +    uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +    uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQH) & s->pq_mask;
> +    uint32_t tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQT) & s->pq_mask;
> +    uint32_t next = (tail + 1) & s->pq_mask;
> +    uint32_t devid = get_field(pr->hdr, RISCV_IOMMU_PREQ_HDR_DID);
> +
> +    trace_riscv_iommu_pri(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> +                          PCI_FUNC(devid), pr->payload);
> +
> +    if (!(ctrl & RISCV_IOMMU_PQCSR_PQON) ||
> +        !!(ctrl & (RISCV_IOMMU_PQCSR_PQOF | RISCV_IOMMU_PQCSR_PQMF))) {
> +        return;
> +    }
> +
> +    if (head == next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                              RISCV_IOMMU_PQCSR_PQOF, 0);
> +    } else {
> +        dma_addr_t addr = s->pq_addr + tail * sizeof(*pr);
> +        if (dma_memory_write(s->target_as, addr, pr, sizeof(*pr),
> +                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                                  RISCV_IOMMU_PQCSR_PQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_PQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_PQCSR_PIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PQ);
> +    }
> +}
> +
> +/* Portable implementation of pext_u64, bit-mask extraction. */
> +static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +{
> +    uint64_t ret = 0;
> +    uint64_t rot = 1;
> +
> +    while (ext) {
> +        if (ext & 1) {
> +            if (val & 1) {
> +                ret |= rot;
> +            }
> +            rot <<= 1;
> +        }
> +        val >>= 1;
> +        ext >>= 1;
> +    }
> +
> +    return ret;
> +}
> +
> +/* Check if GPA matches MSI/MRIF pattern. */
> +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    dma_addr_t gpa)
> +{
> +    if (!s->enable_msi) {
> +        return false;
> +    }
> +
> +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=
> +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +        return false; /* Invalid MSI/MRIF mode */
> +    }
> +
> +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask) {
> +        return false; /* GPA not in MSI range defined by AIA IMSIC rules. */
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> + *
> + * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
> + * Both implementation can be merged into single helper function in future.
> + * Keeping them separate for now, as error reporting and flow specifics are
> + * sufficiently different for separate implementation.
> + *
> + * @s        : IOMMU Device State
> + * @ctx      : Translation context for device id and process address space id.
> + * @iotlb    : translation data: physical address and access mode.
> + * @return   : success or fault cause code.
> + */
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    dma_addr_t addr, base;
> +    uint64_t satp, gatp, pte;
> +    bool en_s, en_g;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc[2];
> +    /* Translation stage phase */
> +    enum {
> +        S_STAGE = 0,
> +        G_STAGE = 1,
> +    } pass;
> +
> +    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
> +    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> +
> +    /* Early check for MSI address match when IOVA == GPA */
> +    if ((iotlb->perm & IOMMU_WO) &&
> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> +        iotlb->target_as = &s->trap_as;
> +        iotlb->translated_addr = iotlb->iova;
> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +        return 0;
> +    }
> +
> +    /* Exit early for pass-through mode. */
> +    if (!(en_s || en_g)) {
> +        iotlb->translated_addr = iotlb->iova;
> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +        /* Allow R/W in pass-through mode */
> +        iotlb->perm = IOMMU_RW;
> +        return 0;
> +    }
> +
> +    /* S/G translation parameters. */
> +    for (pass = 0; pass < 2; pass++) {
> +        uint32_t sv_mode;
> +
> +        sc[pass].step = 0;
> +        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
> +            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
> +            /* 32bit mode for GXL/SXL == 1 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    = 0;
> +                sc[pass].ptidxbits = 0;
> +                sc[pass].ptesize   = 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_CAP_SV32;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 2;
> +                sc[pass].ptidxbits = 10;
> +                sc[pass].ptesize   = 4;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        } else {
> +            /* 64bit mode for GXL/SXL == 0 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    = 0;
> +                sc[pass].ptidxbits = 0;
> +                sc[pass].ptesize   = 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_CAP_SV39;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 3;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_CAP_SV48;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 4;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +                sv_mode = pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_CAP_SV57;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    = 5;
> +                sc[pass].ptidxbits = 9;
> +                sc[pass].ptesize   = 8;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        }
> +    };
> +
> +    /* S/G stages translation tables root pointers */
> +    gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    addr = (en_s && en_g) ? satp : iotlb->iova;
> +    base = en_g ? gatp : satp;
> +    pass = en_g ? G_STAGE : S_STAGE;
> +
> +    do {
> +        const unsigned widened = (pass && !sc[pass].step) ? 2 : 0;
> +        const unsigned va_bits = widened + sc[pass].ptidxbits;
> +        const unsigned va_skip = TARGET_PAGE_BITS + sc[pass].ptidxbits *
> +                                 (sc[pass].levels - 1 - sc[pass].step);
> +        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
> +        const bool ade =
> +            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
> +
> +        /* Address range check before first level lookup */
> +        if (!sc[pass].step) {
> +            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
> +            if ((addr & va_mask) != addr) {
> +                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (dma_memory_read(s->target_as, pte_addr, &pte,
> +                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
> +                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
> +        }
> +
> +        if (sc[pass].ptesize == 4) {
> +            pte = (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
> +        } else {
> +            pte = le64_to_cpu(pte);
> +        }
> +
> +        sc[pass].step++;
> +        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            break;                /* Invalid PTE */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> +            break;                /* Reserved leaf PTE flags: PTE_W */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
> +            break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            break;                /* Misaligned PPN */
> +        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
> +            break;                /* Read access check failed */
> +        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
> +            break;                /* Write access check failed */
> +        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
> +            break;                /* Access bit not set */
> +        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +            break;                /* Dirty bit not set */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            sc[pass].step = sc[pass].levels;
> +            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            /* Update address mask based on smallest translation granularity */
> +            iotlb->addr_mask &= (1ULL << va_skip) - 1;
> +            /* Continue with S-Stage translation? */
> +            if (pass && sc[0].step != sc[0].levels) {
> +                pass = S_STAGE;
> +                addr = iotlb->iova;
> +                continue;
> +            }
> +            /* Translation phase completed (GPA or SPA) */
> +            iotlb->translated_addr = base;
> +            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
> +                                                         : IOMMU_RO;
> +
> +            /* Check MSI GPA address match */
> +            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
> +                riscv_iommu_msi_check(s, ctx, base)) {
> +                /* Trap MSI writes and return GPA address. */
> +                iotlb->target_as = &s->trap_as;
> +                iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +                return 0;
> +            }
> +
> +            /* Continue with G-Stage translation? */
> +            if (!pass && en_g) {
> +                pass = G_STAGE;
> +                addr = base;
> +                base = gatp;
> +                sc[pass].step = 0;
> +                continue;
> +            }
> +
> +            return 0;
> +        }
> +
> +        if (sc[pass].step == sc[pass].levels) {
> +            break; /* Can't find leaf PTE */
> +        }
> +
> +        /* Continue with G-Stage translation? */
> +        if (!pass && en_g) {
> +            pass = G_STAGE;
> +            addr = base;
> +            base = gatp;
> +            sc[pass].step = 0;
> +        }
> +    } while (1);
> +
> +    return (iotlb->perm & IOMMU_WO) ?
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);
> +}
> +
> +static void riscv_iommu_report_fault(RISCVIOMMUState *s,
> +                                     RISCVIOMMUContext *ctx,
> +                                     uint32_t fault_type, uint32_t cause,
> +                                     bool pv,
> +                                     uint64_t iotval, uint64_t iotval2)
> +{
> +    struct riscv_iommu_fq_record ev = { 0 };
> +
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_DTF) {
> +        switch (cause) {
> +        case RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_INVALID:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED:
> +        case RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR:
> +        case RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT:
> +            break;
> +        default:
> +            /* DTF prevents reporting a fault for this given cause */
> +            return;
> +        }
> +    }
> +
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> +
> +    if (pv) {
> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->process_id);
> +    }
> +
> +    ev.iotval = iotval;
> +    ev.iotval2 = iotval2;
> +
> +    riscv_iommu_fault(s, &ev);
> +}
> +
> +/* Redirect MSI write for given GPA. */
> +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
> +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
> +    unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult res;
> +    dma_addr_t addr;
> +    uint64_t intn;
> +    uint32_t n190;
> +    uint64_t pte[2];
> +    int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +    int cause;
> +
> +    /* Interrupt File Number */
> +    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    if (intn >= 256) {
> +        /* Interrupt file number out of range */
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    /* fetch MSI PTE */
> +    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
> +    addr = addr | (intn * sizeof(pte));
> +    res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
> +            MEMTXATTRS_UNSPECIFIED);
> +    if (res != MEMTX_OK) {
> +        if (res == MEMTX_DECODE_ERROR) {
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED;
> +        } else {
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        }
> +        goto err;
> +    }
> +
> +    le64_to_cpus(&pte[0]);
> +    le64_to_cpus(&pte[1]);
> +
> +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI_PTE_C)) {
> +        /*
> +         * The spec mentions that: "If msipte.C == 1, then further
> +         * processing to interpret the PTE is implementation
> +         * defined.". We'll abort with cause = 262 for this
> +         * case too.
> +         */
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_INVALID;
> +        goto err;
> +    }
> +
> +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
> +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /* MSI Pass-through mode */
> +        addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> +        addr = addr | (gpa & TARGET_PAGE_MASK);

I'm not sure what the idea was with this (maybe a misunderstanding of how
guest interrupt files get targeted?), but we shouldn't be modifying the
result of a translation with the input to that translation. It breaks
translations where guest imsic address bits don't strictly overlap host
imsic address bits and it allows the guest to access host memory it
shouldn't. The fix is just to remove the line.

Thanks,
drew

