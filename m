Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31420C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByau-0003Su-FE; Mon, 05 May 2025 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uByas-0003S3-PP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uByaq-0007CG-CY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746462178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ei/ewM79grCZ9r7UJ+oPiHbDWJMr2miIOqazch/vSW8=;
 b=JulhUxa51wi1efg/ekX7T/7yBmxe4ZtR4R0d7l39r3ExrLphDkiWUyG/Li6ArJG/OvXwSt
 k3MA8rZ0DprmNNMhXrpV2xhOZiY9IXasnczS1bRyTRXdbaopSgISyU+Na4RaJ9V6AKDXEN
 FCfuze7vx1ETtVQP+Yx6L+1s1/XX5OI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-2fMe8v8AO9qXpFCIbFbvtA-1; Mon, 05 May 2025 12:22:57 -0400
X-MC-Unique: 2fMe8v8AO9qXpFCIbFbvtA-1
X-Mimecast-MFC-AGG-ID: 2fMe8v8AO9qXpFCIbFbvtA_1746462176
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so21228065e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746462176; x=1747066976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ei/ewM79grCZ9r7UJ+oPiHbDWJMr2miIOqazch/vSW8=;
 b=dfxycnCwcXgmshkzZ4UAopT5C0uJbn2/Ikb+NUzh7ZFtCGz10rgzuVQbGlsYGj3Vvz
 izAHdDtLwyECvzZioiTva+Leikkw96150Ok//wVWmXnywe4OzgDXtxpabD3ZnOXWD4GJ
 oadK6jgYp3no3bjyoMSzQWlxdaMuwxJ2oNmvgIgkraWTnUqGGdOgw1Y/slq4C/R9CvL1
 aq1AeNoGIWLMyN27n6SS9Wk47BdDyslgVfhHSKqehyEcztLUwoHfqkQ0Z2gu0wIR6wCH
 aFL8NoJDMovOHL5UI4Pcr5rGb33bn9R8mxNao9v/3m8dhCQIgaRkxSueO6/iFooxd/mf
 C/lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQrKzi8TNRfaSMjbT/TIKSji3eH9A5XxH6FD3eAU2QcFcrFcIZrJTYLGp/NwhqlbpKicg5U+VxZxpA@nongnu.org
X-Gm-Message-State: AOJu0Yx5UvctXZoJnaRLlaUIhcu83vA6NFlwjbOe3gMkAJAjIYqcyWkO
 A12Q8qZsiYX97VF1zaPq5+1l2mhdr964PpSv23Otw+5zRPiZtBufJOi/n6SRT2MnAumZCK7hw6w
 ojpJezXzimxorM0ailiCjZU3NKcJtsZsKyXutupUWC7LWae5tfDnZ
X-Gm-Gg: ASbGncvx1p692sUoufE7KzLrqn5K2yp9c0lY3wt7Y6OJ9OZwPABAWGbbHQccNyeZBZp
 SwmJj8nJE+QTpD58uMRovrgbIDGRXhTE69n1C7ExlIv0IkCPNhA3qcFt4HxjfEjsENLd7CknI3F
 s5MlIJTJFCSeZlq43WBuj3Q4QO9h7Ka+K1549Y9s3IdJAAQdJyLDb3kE1g/kudW239rwnSaNyI0
 WxM/QL2YE2Yn339fQsLuKEQ/QeEZ8THbk3BAmqx8cO4Hph63TmOm/YBz+dbJX0OBjWws8cJbKuh
 0il0h3FyedmJpOdu9WiihRoMJdd+tf/IV5esd2o1Yd8CElIyNh5hnkpllvs=
X-Received: by 2002:a05:600c:34d1:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-441c49580fbmr68136475e9.29.1746462176159; 
 Mon, 05 May 2025 09:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW/vVEB8eTjPrkllcVMer+WJe7QUROoZuaf0J3j1ibYICsvk8zDXtvMCEpFqlh3Wnpx2RTRw==
X-Received: by 2002:a05:600c:34d1:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-441c49580fbmr68136335e9.29.1746462175813; 
 Mon, 05 May 2025 09:22:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad784asm183146495e9.7.2025.05.05.09.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:22:54 -0700 (PDT)
Message-ID: <2a2f61dc-1d2f-4cb2-94f2-b8f14d218aa0@redhat.com>
Date: Mon, 5 May 2025 18:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 4/11/25 12:17 PM, Zhenzhong Duan wrote:
> The saved caps copy can be used to check dirty tracking capability.
>
> The capabilities is gotten through IOMMUFD interface, so define a
> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
> caps raw data in "include/system/iommufd.h".
>
> This is a prepare work for moving .realize() after .attach_device().
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-device.h |  1 +
>  include/system/iommufd.h      | 22 ++++++++++++++++++++++
>  hw/vfio/iommufd.c             | 10 +++++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 66797b4c92..09a7af891a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>      bool dirty_tracking; /* Protected by BQL */
>      bool iommu_dirty_tracking;
>      HostIOMMUDevice *hiod;
> +    HostIOMMUDeviceIOMMUFDCaps caps;
>      int devid;
>      IOMMUFDBackend *iommufd;
>      VFIOIOASHwpt *hwpt;
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..0f337585c9 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -18,6 +18,9 @@
>  #include "exec/hwaddr.h"
>  #include "exec/cpu-common.h"
>  #include "system/host_iommu_device.h"
> +#ifdef CONFIG_LINUX
> +#include <linux/iommufd.h>
> +#endif
>  
>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>  OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -63,4 +66,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;
> +
> +/**
> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + */
> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
> +    uint32_t type;
> +    uint64_t hw_caps;
> +    VendorCaps vendor_caps;
> +} HostIOMMUDeviceIOMMUFDCaps;
Why can't we extend the existing HostIOMMUDeviceCaps in host_iommu_device.h?

Eric
>  #endif
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48db105422..530cde6740 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -324,7 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * vfio_migration_realize() may decide to use VF dirty tracking
>       * instead.
>       */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      int ret, devfd;
>      uint32_t ioas_id;
>      Error *err = NULL;
> +    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
>      const VFIOIOMMUClass *iommufd_vioc =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>  
> @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          goto err_alloc_ioas;
>      }
>  
> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> +                                         &caps->type, &caps->vendor_caps,
> +                                         sizeof(VendorCaps), &caps->hw_caps,
> +                                         errp)) {
> +        goto err_alloc_ioas;
> +    }
> +
>      /* try to attach to an existing container in this space */
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);


