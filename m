Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A15ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wYR-0002k1-AU; Wed, 01 Oct 2025 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wYN-0002iM-HV; Wed, 01 Oct 2025 09:07:32 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wY5-00026y-KR; Wed, 01 Oct 2025 09:07:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccFYt3SKQz6K5r0;
 Wed,  1 Oct 2025 21:06:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id B73C61404FE;
 Wed,  1 Oct 2025 21:06:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:06:58 +0100
Date: Wed, 1 Oct 2025 14:06:56 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 17/27] hw/arm/virt: Set PCI preserve_config for accel
 SMMUv3
Message-ID: <20251001140656.000043c6@huawei.com>
In-Reply-To: <20250929133643.38961-18-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-18-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:33 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
> to enable nested translation of MSI doorbell addresses. IORT RMR requires
> _DSM #5 to be set for the PCI host bridge so that the Guest kernel preserves
> the PCI boot configuration.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

One trivial thing inline. Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt-acpi-build.c | 8 ++++++++
>  hw/arm/virt.c            | 4 ++++
>  include/hw/arm/virt.h    | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 96830f7c4e..fd03b7f6a9 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -163,6 +163,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          .pci_native_hotplug = !acpi_pcihp,
>      };
>  
> +    /*
> +     * Accel SMMU requires RMRs for MSI 1-1 mapping, which
> +     * require _DSM for preserving PCI Boot Configurations

Early wrapping. I'd go nearer 80 chars.

> +     */
> +    if (vms->pci_preserve_config) {
> +        cfg.preserve_config = true;
> +    }
> +
>      if (vms->highmem_mmio) {
>          cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
>      }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b533b0556e..6467d7cfc8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3087,6 +3087,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>              }
>  
>              create_smmuv3_dev_dtb(vms, dev, bus);
> +            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort) &&
> +                                         !vms->pci_preserve_config) {
> +                vms->pci_preserve_config = true;
> +            }
>          }
>      }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index ea2cff05b0..00287941a9 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -180,6 +180,7 @@ struct VirtMachineState {
>      bool ns_el2_virt_timer_irq;
>      CXLState cxl_devices_state;
>      bool legacy_smmuv3_present;
> +    bool pci_preserve_config;
>  };
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


