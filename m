Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E6D72379
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFTs-0000yb-Ky; Fri, 23 Jan 2026 06:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFTq-0000xA-GQ; Fri, 23 Jan 2026 06:37:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFTo-0005eH-Vg; Fri, 23 Jan 2026 06:37:34 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyG9d0lrTzHnHJC;
 Fri, 23 Jan 2026 19:36:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A447D40571;
 Fri, 23 Jan 2026 19:37:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 11:37:29 +0000
Date: Fri, 23 Jan 2026 11:37:28 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <clg@redhat.com>,
 <alex@shazbot.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: Re: [PATCH v8 18/37] hw/arm/virt: Set msi-gpa property
Message-ID: <20260123113728.000057af@huawei.com>
In-Reply-To: <20260121175248.87649-19-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <20260121175248.87649-19-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 17:52:23 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Set the MSI doorbell GPA property for accelerated SMMUv3 devices for use
> by KVM MSI setup. Also, since any meaningful use of vfio-pci devices with
> an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
> those are specified when accel=on is selected.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Formatting issue I think. With that fixed up
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4badc1a734..1bbc5d94db 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3061,6 +3061,26 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>              object_property_set_link(OBJECT(dev), "secure-memory",
>                                       OBJECT(vms->secure_sysmem), NULL);
>          }
> +        if (object_property_find(OBJECT(dev), "accel") &&
> +            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +            hwaddr db_start = 0;
> +
> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
> +                error_setg(errp, "SMMUv3 accel=on requires KVM with "
> +                           "kernel-irqchip=on support");
> +                    return;
What happened here width indent?

> +            }
> +
> +            if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
> +                /* GITS_TRANSLATER page + offset */
> +                db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
> +            } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
> +                /* MSI_SETSPI_NS page + offset */
> +                db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
> +            }
> +            object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
> +                                     &error_abort);
> +        }
>      }
>  }
>  


