Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B5EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcvM-0006ho-0x; Tue, 15 Jul 2025 06:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcvB-0006Yc-6A; Tue, 15 Jul 2025 06:30:04 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcv2-0001rW-Of; Tue, 15 Jul 2025 06:30:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhFlS5b0Rz6L4tM;
 Tue, 15 Jul 2025 18:28:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 266CD140144;
 Tue, 15 Jul 2025 18:29:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 12:29:43 +0200
Date: Tue, 15 Jul 2025 11:29:41 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <20250715112941.00005348@huawei.com>
In-Reply-To: <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 14 Jul 2025 16:59:34 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Implement a set_iommu_device callback:
>  -If found an existing viommu reuse that.
>    (Devices behind the same physical SMMU should share an S2 HWPT)
>  -Else,
>     Allocate a viommu with the nested parent S2 hwpt allocated by VFIO.
>     Allocate bypass and abort hwpt.
>  -And add the dev to viommu device list
> 
> Also add an unset_iommu_device to unwind/cleanup above.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>


One questions inline plus trivial stuff.  I'm not yet up to speed with
all the iommufd stuff so this is rather superficial for now.

> +static bool
> +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { SMMU_STE_VALID, 0x0ULL },
> +    };
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *bs = sdev->smmu;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    uint32_t s2_hwpt_id = idev->hwpt_id;
> +    SMMUS2Hwpt *s2_hwpt;
> +    SMMUViommu *viommu;
> +    uint32_t viommu_id;
> +
> +    if (s_accel->viommu) {
> +        accel_dev->viommu = s_accel->viommu;
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                      s2_hwpt_id, &viommu_id, errp)) {
> +        return false;
> +    }
> +
> +    viommu = g_new0(SMMUViommu, 1);
> +    viommu->core.viommu_id = viommu_id;
> +    viommu->core.s2_hwpt_id = s2_hwpt_id;
> +    viommu->core.iommufd = idev->iommufd;
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(abort_data), &abort_data,
> +                                    &viommu->abort_hwpt_id, errp)) {
> +        goto free_viommu;
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(bypass_data), &bypass_data,
> +                                    &viommu->bypass_hwpt_id, errp)) {
> +        goto free_abort_hwpt;
> +    }
> +
> +    s2_hwpt = g_new(SMMUS2Hwpt, 1);
> +    s2_hwpt->iommufd = idev->iommufd;
> +    s2_hwpt->hwpt_id = s2_hwpt_id;
> +
> +    viommu->iommufd = idev->iommufd;
> +    viommu->s2_hwpt = s2_hwpt;
> +
> +    s_accel->viommu = viommu;
> +    accel_dev->viommu = viommu;
> +    return true;
> +
> +free_abort_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> +    g_free(viommu);

No unwinding of iommufd_backened_alloc_viommu?
Looks like we just leak it until destruction of the fd. 

Maybe add a comment for those like me who aren't all that familiar with
this stuff and see an alloc with no matching free.


> +    return false;
> +}
> +
> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_report("Device 0x%x already has an associated idev",
> +                         smmu_get_sid(sdev));
> +            return false;
> +        } else {

No need for else as other path already returned.

> +            return true;
> +        }
> +    }
> +
> +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> +        error_report("Device 0x%x: Unable to alloc viommu", smmu_get_sid(sdev));
> +        return false;
> +    }
> +
> +    accel_dev->idev = idev;
> +    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, smmu_get_sid(sdev));
> +    return true;
> +}


> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..c4537ca1d6 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  smmu_reset_exit(void) ""
>  
> +#smmuv3-accel.c
> +smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
bracket?


