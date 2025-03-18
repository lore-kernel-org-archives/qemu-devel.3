Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3677C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 23:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugOS-0002AN-Gl; Tue, 18 Mar 2025 19:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tugOP-00029s-07
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tugON-0000CR-E4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742340636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWEyUiMhkUO1RcyoRMQr+axDCrgSEbu+NVhtrKy8hDo=;
 b=XA0U0omfxU3xSslK3CmzrFytICUzFdbuyAN0LKWd0JE4g8wIaZfo6eScSjqhOGF4G5aafX
 DPv47Qo5RKKkd65Ce1CKGPzEB/GZSIouXNWrYTCs+vxXS7hVSBmyutkVE1t9kcVyV6V1cH
 6foyH5PM7w8euNzl6RzVu9ldHx0pKVI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-aAkVpC13PkiCmmi7KZVDCA-1; Tue, 18 Mar 2025 19:30:32 -0400
X-MC-Unique: aAkVpC13PkiCmmi7KZVDCA-1
X-Mimecast-MFC-AGG-ID: aAkVpC13PkiCmmi7KZVDCA_1742340632
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85b3a62e3e5so1148109539f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 16:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742340631; x=1742945431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWEyUiMhkUO1RcyoRMQr+axDCrgSEbu+NVhtrKy8hDo=;
 b=eClWtuDZQN1TCntbgQqM453G8gQQ+opa1d/w167YKfUHR4pnHzwOUooivZtTFe1+cj
 vv2HWi/WD7T6dScB5b6BQ9WEx/4Ute5NrOv+u6FpToYT/PBwpnu94uUaFtI6os6d/MPl
 X7QDnMOsVXOLvYoWspcJ0bQ6XPQhAI7Nz0dl8lWoOnlENl05hvTZrUoIhJjTvcEMLr4h
 QJ3iCw1qS5aHTNqlwr6RVvq8Ar9RR85GbdrPjB9ZA32Z3MJ23jjGmGVv5UCl4ypZvH1J
 jcmZib358CfxT+Sf1zM4E17i1ltqiwYk/BtaeZxrcbRosxD0t9ZU++cWJqZ3ppIzJ7zK
 VtpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBoAqfR3Te4V7baq2dQCxUg5KaxCwzPbO1CK91Wu+wW0rAklye4GlKP9GgZnCN6qEShxmdSK9HbQKs@nongnu.org
X-Gm-Message-State: AOJu0Yw1RzdLaI0BW2RpsQFoglnf1L2cwjmfyAyJj/Gwqf4UsHPCmyMA
 k6psydI1AvGt8ppJ/QvyVaYAD8CXphwJxhXacqCPC53RN0GwGzEVyWJCSZ0TG9Rgm1vumx12po3
 vHjO0fzrk0MU5TYJHRVGqAxdUaWclaNidoWSXEEcHdTKR3K2bISo/
X-Gm-Gg: ASbGncvZTrtQNkB7vSTpsQo+ScD0g5v94A/MWW4UOozREdlh+BXsjRqFoV1z2qJcnbU
 PjrLavUtjKX7G1nZIAbucJV4RyQ5NiNQpWKzIcJE91HPNz9HViuxOR5U/2BMVRnjOHCrysE4fPp
 5S5fKkG3ss819/xc+99Orok2ani9gLtAlSxYIEN1h0+t9Cn57P78kpivtnBbGPan0wrpf2YsW0L
 50BB6hYy+MLtvpsRXsN+fxtAvkvRBkNex+ZaRQC0Yp4z72ssafGOofBq4hHQM96ZxYpLygqVof0
 qgw3StoRn8UW6Eqt
X-Received: by 2002:a05:6e02:4504:b0:3d4:2ea4:6b8a with SMTP id
 e9e14a558f8ab-3d586bfec4fmr6530465ab.22.1742340631723; 
 Tue, 18 Mar 2025 16:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwF0HVCtcPvw24r2YD+n5rnrNdQ2Jc94BUFKg1QWRtMM5mEMUB17KSYbCFLqGSrON6Y7tmjw==
X-Received: by 2002:a05:6e02:4504:b0:3d4:2ea4:6b8a with SMTP id
 e9e14a558f8ab-3d586bfec4fmr6530345ab.22.1742340631433; 
 Tue, 18 Mar 2025 16:30:31 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263719718sm2962023173.38.2025.03.18.16.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 16:30:30 -0700 (PDT)
Message-ID: <06d916e0-d127-4425-8972-4f7dd8a7898c@redhat.com>
Date: Tue, 18 Mar 2025 19:30:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/20] hw/arm/smmuv3-accel: Allocate a vDEVICE
 object for device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-12-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250311141045.66620-12-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Shameer,

Hi,

On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Allocate and associate a vDEVICE object for the Guest device
> with the vIOMMU. This will help the kernel to do the
> vSID --> sid translation whenever required (eg: device specific
> invalidations).
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmuv3-accel.c         | 22 ++++++++++++++++++++++
>   include/hw/arm/smmuv3-accel.h |  6 ++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index d3a5cf9551..056bd23b2e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -109,6 +109,20 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>           return;
>       }
>   
> +    if (!accel_dev->vdev && accel_dev->idev) {
> +        SMMUVdev *vdev;
> +        uint32_t vdev_id;
> +        SMMUViommu *viommu = accel_dev->viommu;
> +
> +        iommufd_backend_alloc_vdev(viommu->core.iommufd, accel_dev->idev->devid,
> +                                   viommu->core.viommu_id, sid, &vdev_id,
> +                                   &error_abort);
> +        vdev = g_new0(SMMUVdev, 1);
> +        vdev->vdev_id = vdev_id;
> +        vdev->sid = sid;
> +        accel_dev->vdev = vdev;
> +    }
> +
>       ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
>       if (ret) {
>           /*
> @@ -283,6 +297,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>   static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>                                               int devfn)
>   {
> +    SMMUVdev *vdev;
>       SMMUDevice *sdev;
>       SMMUv3AccelDevice *accel_dev;
>       SMMUViommu *viommu;
> @@ -312,6 +327,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>       trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
>   
>       viommu = s_accel->viommu;
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>       if (QLIST_EMPTY(&viommu->device_list)) {
>           iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
>           iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index d6b0b1ca30..54b217ab4f 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -35,6 +35,11 @@ typedef struct SMMUViommu {
>       QLIST_ENTRY(SMMUViommu) next;
>   } SMMUViommu;
>   
> +typedef struct SMMUVdev {
> +    uint32_t vdev_id;
> +    uint32_t sid;
> +} SMMUVdev;
> +
Shouldn't this be 'IOMMUFDVdev' ... it's not an SMMU (v)dev , it's an IOMMUFD/vIOMMU vDEVICE for this SMMU


>   typedef struct SMMUS1Hwpt {
>       IOMMUFDBackend *iommufd;
>       uint32_t hwpt_id;
> @@ -45,6 +50,7 @@ typedef struct SMMUv3AccelDevice {
>       HostIOMMUDeviceIOMMUFD *idev;
>       SMMUS1Hwpt  *s1_hwpt;
>       SMMUViommu *viommu;
> +    SMMUVdev   *vdev;
>       QLIST_ENTRY(SMMUv3AccelDevice) next;
>   } SMMUv3AccelDevice;
>   


