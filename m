Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B590D1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3Y7-00028N-A4; Thu, 04 Dec 2025 02:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1vR3Y5-000261-89
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:14:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1vR3Y2-0005Fe-B2
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:14:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-297d4a56f97so8510565ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764832480; x=1765437280; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cMcIIw2HESLCzW1v+OL9YKg5ApFMaWn+5TsEYUQeapk=;
 b=f8pA/Vj1PWu+1HYKvYM6l4DgaWlUGqS5Z/Yl+9fY+h50kq/2mcxRfl4i1BrSFl9M3V
 TIGYgi2BI0dHn6/Wfp7Lo5QU2+tPJWC5f5RF1tWHEJVXsOBrRPqF9CyxfH1ggLMvUPYX
 3FrdUKHkV2l3Y9/EBzfuYwzPfk7xaOYMAaT6waCkrb5FpHLxuSAsn9syOnRoPbGXaibG
 gaSNRoZx83dBUgu+6RsHcYN2YwJQiqrC9Vkv31095IMw/F2ZwlcLJehKNUVx0dp4ryhY
 /Q+5+dPsYzLwGPEtaOXzOCkgswZ8vnzjESMB8s7v1s6alfLQiO5FVVwxIje6behuKoeJ
 +hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764832480; x=1765437280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cMcIIw2HESLCzW1v+OL9YKg5ApFMaWn+5TsEYUQeapk=;
 b=hf2i0R/yKNvYEptOH+UZkTet8NdZyUKlOujMQY9cYZXOr15XJlRsxr8PtUsn8Y0pSY
 j+5GREC48kfrrwpootyF43+mv1CL8co+Q5eT9FtMrFdstJMPI2f5z7eUB3L5SJ56R0ZR
 P5FBenkPI5c21n37CMvOPgM8KQqqYs6co+fu3b46OJouMwbSkN+FawPMXQt598HCAqrs
 W44zlKjvceO5WZw3D9sB0Rvn7MEN3FDS8dUHZKS4eNlXOes5eH7yCb7gZ+EWPZsPI6sT
 SWlRAk3Ndcvmvyhke50J9iAqotrZBxCmbc22RKpWl7V75oRdzlrUQ90zmJk3FOEKSkX7
 /X1A==
X-Gm-Message-State: AOJu0YzMKs4Kt4v4DYUQ1t9eiRKDVeiJYtMqTRLVRfk7RL0xwa0hvey+
 jVsf4tEcxncXdr0yvglNreHCedLGPuvKUtsOyQ6UzVrfdpVwIK5ub2/L/BvzsY7ssUA=
X-Gm-Gg: ASbGncvGLNy6+DOiKXlXu/lhCY00UTHQjeQt6cI48QfuypBapRLEMUTa5bZgQ/jQTY6
 /Bhm/mAPiSFZpmaMG4D/cvShvgGQOl0T3pYSnSjwJpGYj5RM6kxaVxR2HATgkBBRr0UMxeNMeUN
 bau3M2aAPMWo4CUtx4Gi1w10uvFbPsG2ohLEsQAwUwfmcJL8CmXSvlvzw8Us9aXcOJSuems/7YR
 Jh43nvWzATrnUi5luhraCKWSP9CTJzkIyPFmM3lgKh21+8bj0JYHzmfkW84zrkHAOA/Gvsl571s
 VErX1MVykAaa6VBquFptVfICvE04MFF5ikMpraWrBKSvoZkd7yR2CZs+WtvBo5cr6gdXdMQ7zLK
 74lXo8HZzc8gAvTYPsjjjLO77TWXIsY5yKi1SXg0IWDSsLZaXGCB+2snE1UZlvBbRu6305pxrpt
 Mt3Qyn6KG9fpktWcte3w==
X-Google-Smtp-Source: AGHT+IHpvneSqpJj5creH2NY4TTma0UnbvJO33xt8dbE0iqmcenDNGap9uzLFQo+iT7eA++Grt1k1Q==
X-Received: by 2002:a17:902:ebca:b0:295:6d30:e268 with SMTP id
 d9443c01a7336-29d684980cbmr58473695ad.59.1764832480012; 
 Wed, 03 Dec 2025 23:14:40 -0800 (PST)
Received: from sunil-laptop ([106.51.194.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29dae99ea7csm9609015ad.63.2025.12.03.23.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 23:14:39 -0800 (PST)
Date: Thu, 4 Dec 2025 12:44:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Tuan Phan <tphan@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and
 ACPI table support
Message-ID: <aTE02YA_ldsDnCrx@sunil-laptop>
References: <20251203002259.2856-1-tphan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203002259.2856-1-tphan@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Tuan,

On Tue, Dec 02, 2025 at 04:22:59PM -0800, Tuan Phan wrote:
> This patch enables TPM2 support in the RISC-V virt machine ACPI builder.
> 
> Signed-off-by: Tuan Phan <tphan@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 56 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb68339..b5bf812a9d36 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -32,6 +32,7 @@
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/platform-bus.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> @@ -39,6 +40,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "system/reset.h"
> +#include "system/tpm.h"
>  
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
> @@ -224,6 +226,41 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
>      aml_append(scope, dev);
>  }
>  
> +#ifdef CONFIG_TPM
> +static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(s->platform_bus_dev);
> +    hwaddr pbus_base = s->memmap[VIRT_PLATFORM_BUS].base;
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
> +    MemoryRegion *sbdev_mr;
> +    hwaddr tpm_base;
> +
> +    if (!sbdev) {
> +        return;
> +    }
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base != -1);
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +
> +    Aml *dev = aml_device("TPM0");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +
> +    Aml *crs = aml_resource_template();
> +    aml_append(crs,
> +               aml_memory32_fixed(tpm_base,
> +                                  (uint32_t)memory_region_size(sbdev_mr),
> +                                  AML_READ_WRITE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +#endif
> +
It looks like this logic is duplicated in several places. Would it make
sense to create a shared function for it?

Thanks,
Sunil

