Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B41D13C0F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkMxs-0005cR-SH; Mon, 26 Jan 2026 08:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkMxo-0005a1-EN
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkMxl-0002Fv-RC
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769435340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jT/1ag8r0s0FyyrEs8TQeJKhCBLySdz3qMIl4CuKhLE=;
 b=HYc+f7s5I6+3MERdPrw4/FRTe0SS6gUYZtWCnWBOGJ7uuBbrf38yFq11t+GJHSqiIi2mIB
 vEABVreoE4M/ZqXLhRJyq4NgJFizaA3oKxywHtNVCKHswYJvS55LyoOR1wnyeEP+smcsD/
 GMcwDcZb3wL8XdPMpjhE5l83LutxGDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-9AI-icS7M7SqK4p1qONE5g-1; Mon, 26 Jan 2026 08:48:59 -0500
X-MC-Unique: 9AI-icS7M7SqK4p1qONE5g-1
X-Mimecast-MFC-AGG-ID: 9AI-icS7M7SqK4p1qONE5g_1769435338
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee8808ffbso34090865e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 05:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769435338; x=1770040138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jT/1ag8r0s0FyyrEs8TQeJKhCBLySdz3qMIl4CuKhLE=;
 b=rY/3YM7cZN/m5uYSjn5y6YJf5mCUjJ1GVkWbu6+RJhfKgEbQP9QE88hxR2JYpV2xJK
 50dFpNoP2aygGXnA6o9CM61ARf6+iJyC6C5frqoEjcZMcTGXIFBxO7mKSHYp0pWBxdfL
 cWD8p+Fn3Nq6jYL8OjNhKbRDfsEhxe1Q+mBd7CcZ51FuDkr17hQCxhISwYJJRihOWcBm
 6pkwUL1Qh2UjmaqAaxyxrWC/iWzl9Iu7QOhTiN0NpbsbSsCPk4eqfZtgI/zcNqG/92P9
 D41Dn729KrfMIz5L2QAAGovY6zrA3UcAEE/PeDjD7BgtwnrvMNa3ztUtmjIk9h6z5Cfz
 3gng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMaaQfq4K96wImbchEw1FftjToBquuCB7zX4uEPV4x14WL3bOIQ2h6qzUC9thF0+16CtmjMnOFIOQf@nongnu.org
X-Gm-Message-State: AOJu0Yw+LhDBI4MoRMiGNv8UIyO5znrStlAqJB8RGtoyQyULiZvuDqAh
 wf5JLQLoO2rWUxLvZBBCeAQJD1DEIMK6FpWpp5cVqB96orQg+Fpsezz7uM3W1liepIrYFGisoD+
 axFSjzIH8djsXsFp6Uzh5QCrkiYAF3f9j0pOsVGfggsY+pCIPdbSWKe9o
X-Gm-Gg: AZuq6aJjCMDG1G/XJxANWjELgTMhJwXhetny/eF6Mrhdrw6uhDj6RL4F4yc/W2GbOQm
 NZm00NpaE1hPgGFbsTzwbRSRgMdkCeQ6AEWeJxdGqxrocp+0UVASE3Lp4fLsRM2AErHPppmTgwD
 WEd0oKTQc1CeY4r6t30pTnE3nG4RziFHCpQRnWSW8Ooi1buaX7USg8bjFTMXo7kPfVE2eiFLKwI
 XquoefOS0uvBuBZcxK13F7v7wgu1Q0BRRBpFZOZ2LBFwW+VXaJ5acEg9OCyMPfXpRyo2tyDQ/YQ
 XW+mREglyy/siyIyYnBOIZBPd5f6245LJEAXmXRH3naVVKwiCluR6RwCvrr+3xTCUTsu8qfJRLN
 V2L71ov2jpPZmAbsUuWBgQE1IF5xZFjM2eEKIhITB9pF7FjI08doLIcbi0g==
X-Received: by 2002:a05:600c:83cf:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4805eebe79amr58506675e9.3.1769435338276; 
 Mon, 26 Jan 2026 05:48:58 -0800 (PST)
X-Received: by 2002:a05:600c:83cf:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4805eebe79amr58506285e9.3.1769435337779; 
 Mon, 26 Jan 2026 05:48:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d627871sm104096215e9.6.2026.01.26.05.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 05:48:57 -0800 (PST)
Message-ID: <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
Date: Mon, 26 Jan 2026 14:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
> 64 KB pages:
>  - Page0: guest accessible control/status registers for all VCMDQs
>  - Page1: configuration registers (queue GPA/size) that must be trapped
>           by the VMM and translated before programming the HW queue.
>
> This patch implements the Page0 handling in QEMU. Using the vintf offset
> returned by IOMMUFD during VIOMMU allocation, QEMU maps Page0 into
> guest physical address space and exposes it via two guest MMIO windows:
>  - 0x10000 :VCMDQ register
>  - 0x30000 :VINTF register
>
> The mapping is lazily initialized on first read/write.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.h |  5 ++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 899325877e..d8858322dc 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -13,14 +13,74 @@
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
> +{
> +    SMMUv3State *smmu = cmdqv->smmu;
> +    SMMUv3AccelState *s_accel = smmu->s_accel;
> +    IOMMUFDViommu *viommu;
> +    char *name;
> +
> +    if (!s_accel) {
> +        return true;
> +    }
> +
> +    viommu = &s_accel->viommu;
> +    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
> +                                     VCMDQ_REG_PAGE_SIZE,
> +                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
> +                                     &cmdqv->vcmdq_page0, errp)) {
> +        cmdqv->vcmdq_page0 = NULL;
> +        return false;
> +    }
> +
> +    name = g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv->mmio_cmdqv));
> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, 0x10000, cmdqv->vcmdq_page0);
> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x10000,
> +                                        &cmdqv->mmio_vcmdq_page, 1);
> +    g_free(name);
> +
> +    name = g_strdup_printf("%s vintf", memory_region_name(&cmdqv->mmio_cmdqv));
> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
> +                                      name, 0x10000, cmdqv->vcmdq_page0);
I don't get why we need/have 2 RAM devices pointing to the same @ptr
= cmdqv->vcmdq_page0. Is 0x10000 ~ VCMDQ_REG_PAGE_SIZE?

The names of the MRs are quite confusing: If my understanding is correct
we have;

cmdqv->mmio_cmdqv (0x50000 sized) which as the container for the 2 subregions.
Then within that one we have 2 subregions, one at offset 0x10000 (mmio_vcmdq_page
), one at offset 0x30000 (cmdqv->mmio_vintf_page).

I have difficulties to link that with the commit message

"Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
64 KB pages:
 - Page0: guest accessible control/status registers for all VCMDQs
 - Page1:configuration registers  ../.."
Those 2 pages, are they part of  mmio_vcmdq_page?

Then you talk about 0x30000 :VINTF register I guess this is the second cmdqv->mmio_vintf_page

Well I am confused at this stage of the reading.

Also without any spec, this is difficult to understand. Is there any public doc?



> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
> +                                        &cmdqv->mmio_vintf_page, 1);
> +    g_free(name);
> +
> +    return true;
> +}
> +
>  static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    Error *local_err = NULL;
> +
> +    if (!cmdqv->vcmdq_page0) {
> +        tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +    }
> +
>      return 0;
>  }
>  
>  static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>                                   unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    Error *local_err = NULL;
> +
> +    if (!cmdqv->vcmdq_page0) {
> +        tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            local_err = NULL;
> +        }
> +    }
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 9bc72b24d9..ccdf0651be 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -19,8 +19,13 @@ typedef struct Tegra241CMDQV {
>      SMMUv3State *smmu;
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
> +    MemoryRegion mmio_vcmdq_page;
please also use _mr suffix as in the rest of the code
> +    MemoryRegion mmio_vintf_page;
> +    void *vcmdq_page0;
>  } Tegra241CMDQV;
>  
> +#define VCMDQ_REG_PAGE_SIZE 0x10000
> +
>  #ifdef CONFIG_TEGRA241_CMDQV
>  bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                                   uint32_t *out_viommu_id, Error **errp);
Thanks

Eric


