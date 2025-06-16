Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64117C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 11:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR7bb-0005SI-Np; Mon, 16 Jun 2025 07:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uR7bW-0005RP-MN; Mon, 16 Jun 2025 07:02:20 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uR7bU-0002NL-UI; Mon, 16 Jun 2025 07:02:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLRrz6NfNz6M4bK;
 Mon, 16 Jun 2025 19:01:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EAFF71402F5;
 Mon, 16 Jun 2025 19:02:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 13:02:11 +0200
Date: Mon, 16 Jun 2025 12:02:09 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <imammedo@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 5/7] hw/arm/virt: Add an SMMU_IO_LEN macro
Message-ID: <20250616120209.00004015@huawei.com>
In-Reply-To: <20250613144449.60156-6-shameerali.kolothum.thodi@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Jun 2025 15:44:47 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> This is useful as the subsequent support for new SMMUv3 dev will also
> use the same.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Donald Dutile <ddutile@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 71b923f786..eeace4754d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -146,6 +146,9 @@ static void arm_virt_compat_set(MachineClass *mc)
>  #define LEGACY_RAMLIMIT_GB 255
>  #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>  
> +/* MMIO region size for SMMUv3 */
> +#define SMMU_IO_LEN 0x20000
> +
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
>   * 128MB..256MB is used for miscellaneous device I/O.
> @@ -177,7 +180,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_UART1] =              { 0x09040000, 0x00001000 },
> -    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },

This bit is fine.

>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
> @@ -1447,7 +1450,6 @@ static void create_smmu(const VirtMachineState *vms,
>      int irq =  vms->irqmap[VIRT_SMMU];
>      int i;
>      hwaddr base = vms->memmap[VIRT_SMMU].base;
> -    hwaddr size = vms->memmap[VIRT_SMMU].size;
>      DeviceState *dev;
>  
>      if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
> @@ -1467,7 +1469,7 @@ static void create_smmu(const VirtMachineState *vms,
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                             qdev_get_gpio_in(vms->gic, irq + i));
>      }
> -    create_smmuv3_dt_bindings(vms, base, size, irq);
> +    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);

This seems a little odd.  I guess it may make sense later, but for all other
cases we only use the macros to define the base_memmap.

Perhaps delay this change until it is more obvious why?


>  }
>  
>  static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)


