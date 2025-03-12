Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE54C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLaF-0007K2-7K; Wed, 12 Mar 2025 08:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsLaE-0007Jb-20
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsLaB-0005Yd-BI
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741783987;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAuNzg/BldTf5xbzrXz0vUIzDl2grnbUsziFphFbU7Q=;
 b=camB0ax8PPAmINnzmiyb6D7qHs4ZgcYU0x4N0XtFD2p3ytIpscSDK9XMHg+77HbmieYuwy
 en+ByKyF+fvuHC4EERdS9GwYGvmMfuKpxQLa/jaBsPKKa3PRc1ffANg9glGC0sm5YDzqIp
 rOGScHtrHzuUnugWny0sRNS4NAtBJJo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Ob3y5dVOOJmgLyNxJb0Z9g-1; Wed, 12 Mar 2025 08:53:06 -0400
X-MC-Unique: Ob3y5dVOOJmgLyNxJb0Z9g-1
X-Mimecast-MFC-AGG-ID: Ob3y5dVOOJmgLyNxJb0Z9g_1741783986
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476aa099fb3so37084401cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741783986; x=1742388786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAuNzg/BldTf5xbzrXz0vUIzDl2grnbUsziFphFbU7Q=;
 b=JMAJVBcmsOnpnn2cATrsi+D3dys6hVI1vCP3InVfkqjTmm+uK1CkrFz6Zu4brv7mPm
 psGo+G5aBQsePx+ftScww4ceuqajr0RwVEiLdNhsTRwJfX3e4hsQ6Rfth6HNytgu1sgK
 arYIvoYN2+IxZlmjU1AvuAIC/3AurUDcOdRffwE0r/WqfvrPhpbVFlko+lHbCgz1WbBB
 lN5qPT22JlVaFQnrZC+gtIbjuUJgShfwP9MVdVTem5EskKv09Imb+1f6WbSnwE+fvLo7
 HbwvEhIxajnc+e3/DDRUsBRAHoYEiNj86UyVmzbpiafUViF659JOBxHIBKh2ox2tG52K
 RZvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDcnAT3RRpr8z9WoJB4WzV5gRVCPy2EEseZioFUga9vmsrOe5ifxIEOEhHzTaBg+0NjTZpLQtpQl89@nongnu.org
X-Gm-Message-State: AOJu0YzCH5EH/NOh2jV/v77D2zkngABR+/ASs9PB3Htbxpo0jUKE01s4
 B6cxiu8FoWz8vXDLNtBKyfrBSED4Og/yWbWFse6+n4rjlLcGfeQUv7v1lRI1NHNJ7vyRCl0taQR
 FN+mdtHqDcNkSaURRw0A3otkSMjvTIHfzdyLHeGqQDjVqVi1qIved
X-Gm-Gg: ASbGnctXgSFblfnw1EdyVorL3ShvAO8OdNuxxgrRNz1cR1iYiaIf2LhYgC46VAjhkJF
 90I6o+2SXHEakLZlte1pPfQL+U26kzvMnfAMJO+WHjXN2NqjsXoSeoZoFgmvlPwzxxdaSM2b88c
 nQ8N94qI5cSSkLumKTUKH+xJaJX8zcUTmopghMIGepr958kQaaGT6WBaOMfZ2LblkB1E8+PSZz9
 WKnOQy4EvIMF9gTheB/nzZ/y/FwvnTvNnE+Yb0aUGstEUHTmFxfpBqUlJTt/mBM1XczgGMHFWqG
 uPMrilf8XLtPTFMiOU3YvsqcRAhQHO9pYJBXj2DoO55Ouxht+zViCeZS3VXiyg0=
X-Received: by 2002:a05:622a:a548:b0:476:6189:4f3d with SMTP id
 d75a77b69052e-47661895271mr181015331cf.17.1741783986123; 
 Wed, 12 Mar 2025 05:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7FwwKfqeqbUQoXJdeseRlhp9+oRJJGeJeJQ6AZxI7KHrvoaqZO9KZuSLrQDd0BgrdqyuofA==
X-Received: by 2002:a05:622a:a548:b0:476:6189:4f3d with SMTP id
 d75a77b69052e-47661895271mr181014971cf.17.1741783985747; 
 Wed, 12 Mar 2025 05:53:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476905e344esm36718901cf.46.2025.03.12.05.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 05:53:05 -0700 (PDT)
Message-ID: <c6f90782-8fbd-46d6-8334-88c6b1d42a96@redhat.com>
Date: Wed, 12 Mar 2025 13:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/20] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,


On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Implement a set_iommu_device callback:
>  -Find an existing S2 hwpt to test attach() or allocate a new one
>    (Devices behind the same physical SMMU should share an S2 HWPT.)
>  -Attach the device to the S2 hwp
>  -Allocate a viommu with the returned s2 hwpt.
>  -Allocate bypass and abort hwpt and attach bypass hwpt.
>  -and add it to its device list
>
> Also add an unset_iommu_device doing the opposite cleanup routine.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/meson.build            |   2 +-
>  hw/arm/smmuv3-accel.c         | 183 ++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events           |   4 +
>  include/hw/arm/smmuv3-accel.h |  23 +++++
>  include/system/iommufd.h      |   6 ++
>  5 files changed, 217 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index e8593363b0..dd41a86619 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -55,7 +55,7 @@ arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
>  arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> -arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
> +arm_ss.add(when: ['CONFIG_ARM_SMMUV3_ACCEL', 'CONFIG_IOMMUFD'], if_true: files('smmuv3-accel.c'))
I guess we could set from patch 3 onwards?
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_ss.add(when: 'CONFIG_XEN', if_true: files(
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 6610ebe4be..1c696649d5 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -7,6 +7,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "trace.h"
> +#include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3-accel.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -30,6 +32,185 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static bool
> +smmuv3_accel_dev_attach_viommu(SMMUv3AccelDevice *accel_dev,
> +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { 0x9ULL, 0x0ULL },
I would suggest to use defines.
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { 0x1ULL, 0x0ULL },
same
> +    };
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *s = sdev->smmu;
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
> +    SMMUS2Hwpt *s2_hwpt;
> +    SMMUViommu *viommu;
> +    uint32_t s2_hwpt_id;
> +    uint32_t viommu_id;
> +
> +    if (s_accel->viommu) {
> +        accel_dev->viommu = s_accel->viommu;
> +        return host_iommu_device_iommufd_attach_hwpt(
> +                       idev, s_accel->viommu->s2_hwpt->hwpt_id, errp);
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->ioas_id,
> +                                    IOMMU_HWPT_ALLOC_NEST_PARENT,
> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
> +                                    &s2_hwpt_id, errp)) {
> +        return false;
> +    }
> +
> +    /* Attach to S2 for MSI cookie */
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, s2_hwpt_id, errp)) {
> +        goto free_s2_hwpt;
> +    }
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                      s2_hwpt_id, &viommu_id, errp)) {
> +        goto detach_s2_hwpt;
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
> +        error_report("failed to allocate an abort pagetable");
is that error_report needed as we have the error handle already?
> +        goto free_viommu;
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(bypass_data), &bypass_data,
> +                                    &viommu->bypass_hwpt_id, errp)) {
> +        error_report("failed to allocate a bypass pagetable");
same
> +        goto free_abort_hwpt;
> +    }
> +
> +    /*
> +     * Attach the bypass STE which means S1 bypass and S2 translate.
> +     * This is to make sure that the vIOMMU object is now associated
> +     * with the device and has this STE installed in the host SMMUV3.
> +     */
> +    if (!host_iommu_device_iommufd_attach_hwpt(
> +                idev, viommu->bypass_hwpt_id, errp)) {
> +        error_report("failed to attach the bypass pagetable");
same
if you prefer you can add error "hint"
> +        goto free_bypass_hwpt;
> +    }
> +
> +    s2_hwpt = g_new0(SMMUS2Hwpt, 1);
> +    s2_hwpt->iommufd = idev->iommufd;
> +    s2_hwpt->hwpt_id = s2_hwpt_id;
> +    s2_hwpt->ioas_id = idev->ioas_id;
> +
> +    viommu->iommufd = idev->iommufd;
> +    viommu->s2_hwpt = s2_hwpt;
> +
> +    s_accel->viommu = viommu;
> +    accel_dev->viommu = viommu;
> +    return true;
> +
> +free_bypass_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, viommu->bypass_hwpt_id);
> +free_abort_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> +    g_free(viommu);
> +detach_s2_hwpt:
> +    host_iommu_device_iommufd_attach_hwpt(idev, accel_dev->idev->ioas_id, errp);
This should be detach.

Eric
> +free_s2_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, s2_hwpt_id);
> +    return false;
> +}
> +
> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    SMMUState *s = opaque;
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
> +    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_report("Device 0x%x already ha an associated idev",
> +                         smmu_get_sid(sdev));
> +            return false;
> +        } else {
> +            return true;
> +        }
> +    }
> +
> +    if (!smmuv3_accel_dev_attach_viommu(accel_dev, idev, errp)) {
> +        error_report("Unable to attach viommu");
> +        return false;
> +    }
> +
> +    accel_dev->idev = idev;
> +    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, smmu_get_sid(sdev));
> +    return true;
> +}
> +
> +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> +                                            int devfn)
> +{
> +    SMMUDevice *sdev;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUViommu *viommu;
> +    SMMUState *s = opaque;
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
> +
> +    if (!sbus) {
> +        return;
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               accel_dev->idev->ioas_id,
> +                                               NULL)) {
> +        error_report("Unable to attach dev to the default HW pagetable");
> +    }
> +
> +
> +    accel_dev->idev = NULL;
> +    QLIST_REMOVE(accel_dev, next);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
> +
> +    viommu = s_accel->viommu;
> +    if (QLIST_EMPTY(&viommu->device_list)) {
> +        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->s2_hwpt->hwpt_id);
> +        g_free(viommu->s2_hwpt);
> +        g_free(viommu);
> +        s_accel->viommu = NULL;
> +    }
> +}
>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>                                                int devfn)
>  {
> @@ -77,6 +258,8 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>          return;
>      }
>      bs->get_address_space = smmuv3_accel_find_add_as;
> +    bs->set_iommu_device = smmuv3_accel_set_iommu_device;
> +    bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
>  }
>  
>  static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 7790db780e..17960794bf 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -58,6 +58,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  smmu_reset_exit(void) ""
>  
> +#smmuv3-accel.c
> +smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
> +
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
>  strongarm_ssp_read_underrun(void) "SSP rx underrun"
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index 86c0523063..aca6838dca 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -12,16 +12,39 @@
>  #include "hw/arm/smmu-common.h"
>  #include "hw/arm/smmuv3.h"
>  #include "qom/object.h"
> +#include "system/iommufd.h"
> +
> +#include <linux/iommufd.h>
>  
>  #define TYPE_ARM_SMMUV3_ACCEL   "arm-smmuv3-accel"
>  OBJECT_DECLARE_TYPE(SMMUv3AccelState, SMMUv3AccelClass, ARM_SMMUV3_ACCEL)
>  
> +typedef struct SMMUS2Hwpt {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t hwpt_id;
> +    uint32_t ioas_id;
> +} SMMUS2Hwpt;
> +
> +typedef struct SMMUViommu {
> +    IOMMUFDBackend *iommufd;
> +    IOMMUFDViommu core;
> +    SMMUS2Hwpt *s2_hwpt;
> +    uint32_t bypass_hwpt_id;
> +    uint32_t abort_hwpt_id;
> +    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    QLIST_ENTRY(SMMUViommu) next;
> +} SMMUViommu;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUViommu *viommu;
> +    QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
>  struct SMMUv3AccelState {
>      SMMUv3State smmuv3_state;
> +    SMMUViommu *viommu;
>  };
>  
>  struct SMMUv3AccelClass {
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 53920bae5b..9c106ea078 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -37,6 +37,12 @@ struct IOMMUFDBackend {
>      /*< public >*/
>  };
>  
> +typedef struct IOMMUFDViommu {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t s2_hwpt_id;
> +    uint32_t viommu_id;
> +} IOMMUFDViommu;
> +
>  bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>  void iommufd_backend_disconnect(IOMMUFDBackend *be);
>  


