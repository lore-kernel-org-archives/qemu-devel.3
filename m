Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B357C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8mi-0001oF-Rm; Tue, 25 Mar 2025 14:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx8mg-0001na-RP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx8mb-0006Z5-CG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742926424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnz5aAzqCbDu49ihoMjBaIrCPsQZ4jrPyT6C29wS+zg=;
 b=edRf9a3eTcfN1N2EC+ncIJYhPFOxBc6mFONh/S1Muhfd4mjGcZP+bXGSdhDzgio5hhQOFo
 Q5KRcnRAMj+UPpEe7SX95lKQwSNLma8Rw1nzMU157PTP6+zPajgiTF9ePR28mgRwuO4gsO
 LnKDbOY7VtodYKbKhRcHUp48qj+huIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-G3MeSpPRMmextcAmYAP-cA-1; Tue, 25 Mar 2025 14:13:43 -0400
X-MC-Unique: G3MeSpPRMmextcAmYAP-cA-1
X-Mimecast-MFC-AGG-ID: G3MeSpPRMmextcAmYAP-cA_1742926422
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so2793524f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742926422; x=1743531222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnz5aAzqCbDu49ihoMjBaIrCPsQZ4jrPyT6C29wS+zg=;
 b=hTDWToe0N35lWiuPzyipYtta56lpLCknYRBoVI30xSwYd0AY082bvPFtuF3CseF41R
 /numQ8HcrTfdy4WtRiKj4066OPo/VEHCDX4/tzWT8K9aDUukKWvdT0bc2ZZyADxrKG01
 aZHyXzDUq/k7t+Ui2Wk630FPO7dh+i6pI2qbanEPauZKNfxMaiDws6L9HK4GtNTSBh57
 eBT8OeU8LqqBR/DVLYqRKkhTJPZuxZJ9X0Mj5cCQJwtEhnrERZicvuEuTeYTrFjbDtsl
 KGauv5wJD0xo8FDrw0860qm/7dHCvcDZO5V2nDYxnoP83Z5GqRjTK3yy7zWNkpN82XIp
 5lqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb2YA0M917wag4Q8PuTHkOIQWuuaL4Td50RwhOa+Fs+gVkTlD34/LODFb0daV7GHirw9lB7YXZdjhH@nongnu.org
X-Gm-Message-State: AOJu0YwVhVEc+zzFQHpQceO4fNR96zjkCtPQJigJUcgWGTluCFiDStac
 qUiIPU13tsdEjRkZ2v1TgtxIln+fV2yBwU/02G6aoHMT9z7eEzMJ5TIsq9fpsrYVaHKtAVfFC+S
 ZhNzMus9d7/5tni3R3KeVF44mWmnaF1+BcajOsrXEQw7gZ4pLgk7Q
X-Gm-Gg: ASbGncsNAPmygiWi726crlOcgkkRxsppIwf+hm7qXCeen9eaKBqKY5AORZsjgpyMn6q
 p//O3ObMgomqOef/itkpsYYCKtpKleFgqi5SLkfMZuknpVg5hfxtRANiBlHBzNMrUnOIfZElfY6
 nxHlUlbAHv0I5dCiguffe2ril8XnbKK7ja71fleKDWznX+xI6rYYj4OH+tTV6zFTqdmkUfZhrb2
 kk+Ot+RSZ7BUQF1aFhKQXk65RUtOg1AO/KbQeeuPcb3PKam77PMjkgw0UhPrHbqgX6/xk2FYnUh
 TlkCX0dPvVKoh4CZogvaE98mKatqD91r6ki2V1JenBIcJgYBvoi4Lh6IfPMxJyQ=
X-Received: by 2002:a05:6000:4014:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-3997f959577mr13572492f8f.49.1742926422188; 
 Tue, 25 Mar 2025 11:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpg1uC/IAMmEck1fOVgy5cPOJXCmALgg8YvYfMe5lIu9KntrCoK8N+2VVWfIe7vCgu4/BJyg==
X-Received: by 2002:a05:6000:4014:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-3997f959577mr13572464f8f.49.1742926421723; 
 Tue, 25 Mar 2025 11:13:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957efsm14592800f8f.14.2025.03.25.11.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:13:40 -0700 (PDT)
Message-ID: <34b9caa1-d4cc-4183-971a-a4c54bb76bde@redhat.com>
Date: Tue, 25 Mar 2025 19:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/20] hw/arm/smmuv3-accel: Allocate a vDEVICE
 object for device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-12-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-12-shameerali.kolothum.thodi@huawei.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Allocate and associate a vDEVICE object for the Guest device
> with the vIOMMU. This will help the kernel to do the
> vSID --> sid translation whenever required (eg: device specific
s/sid/SID
> invalidations).
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c         | 22 ++++++++++++++++++++++
>  include/hw/arm/smmuv3-accel.h |  6 ++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index d3a5cf9551..056bd23b2e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -109,6 +109,20 @@ void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>          return;
>      }
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
nit: no need to use 0 variant if you set all fields
> +        vdev->vdev_id = vdev_id;
> +        vdev->sid = sid;
> +        accel_dev->vdev = vdev;
> +    }
> +
>      ret = smmu_find_ste(sdev->smmu, sid, &ste, &event);
>      if (ret) {
>          /*
> @@ -283,6 +297,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>  static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>                                              int devfn)
>  {
> +    SMMUVdev *vdev;
>      SMMUDevice *sdev;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUViommu *viommu;
> @@ -312,6 +327,13 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
>  
>      viommu = s_accel->viommu;
> +    vdev = accel_dev->vdev;
> +    if (vdev) {
> +        iommufd_backend_free_id(viommu->iommufd, vdev->vdev_id);
> +        g_free(vdev);
> +        accel_dev->vdev = NULL;
> +    }
> +
>      if (QLIST_EMPTY(&viommu->device_list)) {
>          iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
>          iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index d6b0b1ca30..54b217ab4f 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -35,6 +35,11 @@ typedef struct SMMUViommu {
>      QLIST_ENTRY(SMMUViommu) next;
>  } SMMUViommu;
>  
> +typedef struct SMMUVdev {
> +    uint32_t vdev_id;
> +    uint32_t sid;
> +} SMMUVdev;
> +
>  typedef struct SMMUS1Hwpt {
>      IOMMUFDBackend *iommufd;
>      uint32_t hwpt_id;
> @@ -45,6 +50,7 @@ typedef struct SMMUv3AccelDevice {
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
> +    SMMUVdev   *vdev;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  


