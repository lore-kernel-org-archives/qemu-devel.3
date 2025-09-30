Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F6CCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bDD-00020F-FY; Tue, 30 Sep 2025 10:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3bD8-0001ze-TQ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3bD0-0001yA-JO
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759241996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cVk2FzvtR31+Hr0YatdRXJl9Hy+P2D9jYEJhmSQB6Y=;
 b=ewiXdwFQTiKmsiT+Dbm43Xz+PMq0sLje4hK4sS+CQiL0yKOd5QLhPBpaXhuUt2x7tSkMFs
 FKbeAZBPAMVoE1vFF6Cp092JqGM0mEkriJqKlR+1MJydSoS3yHXmhXg6mk13OfrBDBNcbg
 4okAhN/13OC1CvQNWrRqcl7o/QTtEjc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-hK9q1PBnPz2eVintkBpRoQ-1; Tue, 30 Sep 2025 10:19:55 -0400
X-MC-Unique: hK9q1PBnPz2eVintkBpRoQ-1
X-Mimecast-MFC-AGG-ID: hK9q1PBnPz2eVintkBpRoQ_1759241994
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so14824685e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759241994; x=1759846794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cVk2FzvtR31+Hr0YatdRXJl9Hy+P2D9jYEJhmSQB6Y=;
 b=Qg6EDMMWW3vl3kZ/w0dCQ6rw8U60lLzxbrT8kGmUeReDMRFnnnXe17bqNU8nAdzNzA
 Ax601dAiuR2fLw4tEiqtlhNwvl5tOijjMSKLYlSxWIrqCgPOvjude+AA5Y39APTxYeUd
 BERwNZJfYKE6i3GsjvcNHnMQtr+cAv9McNZEm8l4EUAw7+eHlTgFI/JMtCvlp0jCem3C
 zWw/BGWnth8iX8F6yePjQjes5gRl2Agyjde08LXxQHZpGUuiwfKvCkAoMX4EGU39ptfb
 yBJPsTmER9h/A9MhzktAqqXtSBw0pIJsgX1GEH/R96XoyyAV6BWNxGGvJaUVN1ydadiP
 9eIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtX+mDSoTxS8BLtsTuFJLhl0WRsII8VLyWfgqLJ3l6gDkUIUia3tm9Oc5pJFj5LqyM4wnsVnXWyE9g@nongnu.org
X-Gm-Message-State: AOJu0YyRo5saiJdkMpyS7LgH3UeXHiQoclXwR6Kv+WXrbUp1E9GC3BWo
 DRcDZ2UWdi4AQzeneaD4/JqasvQ97YSAlKfVvWKKqzzXqRGx/ti2cSTS2hiL1mhH6MYDYY1gf5b
 QToRVLP86PnKbgkAq6j0W8MwolMATTzODwg5o92zclwkH/jR803fbPmHP
X-Gm-Gg: ASbGncvPGtjRj892BKbLwz7C3T5ni8aFSkKCWn9GP9mWpyvq6861trjh/tCzPfO/0M5
 1lV6Ot3oX+sOWgtCDMWjkT/ko8ukclGNJDmfEbBMDf+CQYMbydQI0ag5nyK5J18HWJX7IxFtlfB
 k5ReWMaMSVcpYLWPTM5BlvukLsfVY5RUNH+WwbbidfMYjWHmSaI+2/Q1H5+z7Yu/N7dh70T97HZ
 WTuBvBpqU28Ua5DC9lTPIcc/yMb0ALyvzsn0CI8JrWQyHSFhQPff+J0VfeCKvzPUrky4KKxFdFe
 juCWDlu4TZwddJbS9EVvVDFCi1b+C3OAJjbLx9P+8S/58o3TXUVV6Rqxp3WqBYiEGyW1hAkIVWe
 0lL1zc+RcfcDJQmB1
X-Received: by 2002:a05:600c:348a:b0:46e:3dc3:b645 with SMTP id
 5b1f17b1804b1-46e61260525mr541085e9.3.1759241993791; 
 Tue, 30 Sep 2025 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeg5gQEr81g1Z/iCBrZPa27X83BsM9k7jgWvRorHsWzPhJLv6S7maNq7wSmEgGBHfLMShPvA==
X-Received: by 2002:a05:600c:348a:b0:46e:3dc3:b645 with SMTP id
 5b1f17b1804b1-46e61260525mr540925e9.3.1759241993403; 
 Tue, 30 Sep 2025 07:19:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f77cbfsm62442955e9.18.2025.09.30.07.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:19:52 -0700 (PDT)
Message-ID: <64b489b6-f544-436a-ad25-f85c2a891fce@redhat.com>
Date: Tue, 30 Sep 2025 16:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/22] vfio/iommufd: Force creating nesting parent HWPT
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250918085803.796942-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_flags() to get if vIOMMU supports
> VIOMMU_FLAG_WANT_NESTING_PARENT.
>
> If yes, create a nesting parent HWPT and add it to the container's hwpt_list,
> letting this parent HWPT cover the entire second stage mappings (GPA=>HPA).
>
> This allows a VFIO passthrough device to directly attach to this default HWPT
> and then to use the system address space and its listener.
>
> Introduce a vfio_device_get_viommu_flags_want_nesting() helper to facilitate
> this implementation.
>
> It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
> call, if something else related to the VFIO device or vIOMMU isn't compatible.
>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/vfio/vfio-device.h |  2 ++
>  hw/vfio/device.c              | 12 ++++++++++++
>  hw/vfio/iommufd.c             |  9 +++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index e7e6243e2d..a964091135 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>  
>  void vfio_device_unprepare(VFIODevice *vbasedev);
>  
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +
>  int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                  struct vfio_region_info **info);
>  int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 08f12ac31f..620cc78b77 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -23,6 +23,7 @@
>  
>  #include "hw/vfio/vfio-device.h"
>  #include "hw/vfio/pci.h"
> +#include "hw/iommu.h"
>  #include "hw/hw.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> @@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>      vbasedev->bcontainer = NULL;
>  }
>  
> +bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(&vdev->parent_obj) &
> +                  VIOMMU_FLAG_WANT_NESTING_PARENT);
> +    }
> +    return false;
> +}
> +
>  /*
>   * Traditional ioctl() based io
>   */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8c27222f75..f1684a39b7 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -379,6 +379,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> +    /*
> +     * If vIOMMU requests VFIO's cooperation to create nesting parent HWPT,
> +     * force to create it so that it could be reused by vIOMMU to create
> +     * nested HWPT.
> +     */
> +    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +    }
> +
>      if (cpr_is_incoming()) {
>          hwpt_id = vbasedev->cpr.hwpt_id;
>          goto skip_alloc;


