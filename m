Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B5C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByT1-0007Sk-8z; Mon, 05 May 2025 12:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBySy-0007Rc-3Y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBySv-0005yx-RQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746461688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auYh6TCnzqXQHJ162cziIEDW3yNR7XzTwCsT2IHigpw=;
 b=K/2XSdMCdfJdnbIiRx4CvTISCyvZCCGChgj/L/NN7CKVSGeArVZRRnp+BcKOt9WH/94Il4
 7agc5LxvHVG4eLpOUnIRF+5EsIKDTSM/Hgsp91GccUuyCkeMC10pbvo7v+QrHhvEslWT9a
 P1+7K+t9IwpNfh5DZDkJnp/bcqCZdCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-9IionTGuO8G4y4KGQCWvUg-1; Mon, 05 May 2025 12:14:47 -0400
X-MC-Unique: 9IionTGuO8G4y4KGQCWvUg-1
X-Mimecast-MFC-AGG-ID: 9IionTGuO8G4y4KGQCWvUg_1746461686
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so26365435e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461686; x=1747066486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auYh6TCnzqXQHJ162cziIEDW3yNR7XzTwCsT2IHigpw=;
 b=bmWx151wG5sxNpyQKfoBI7nSLiYhhrzsTMZ4ibZ8R0hkeGvtXXjT7CK3/uViWiFLNn
 /O+8992bxiyUcAlkgwcR5cuzexMbODblNAZyd9TmMVdfp3IHqX1grODaJS7afV058HsW
 ya4gZiuYzWhG15U/e0FW3b6QmUcUd/cy9xfMtpVtchZz1yI7/jogFxWTbU3bLRwNkdci
 wO0ogwSf/1p9rEfcSnIurvHPuU3I2NeSfi4uznJylsLen9UdTFvBbJGH2Ip0nFP1hxDO
 P5LDylFwLgxe31XTHoIj0zspBXCnu4hLdZ6phwbOGgxQBGyK9gdH+DcEexxqyNQOSNh+
 qK8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK0NQZ3dGrAJIXCFOMsQKk6gCY2w/sT0O8aaNRYwsm+pwdK3bhZEM+Atfxgf5e84fuXh3EBhLC7hd4@nongnu.org
X-Gm-Message-State: AOJu0YzICoYa4V3jCfwOXcHsNbWMQxhJMDeUryPlg8ZEdbjwKilvnvJO
 DbeNCN0w7om/d4I0sTRYXpSFWm5fVohcsiV2wVhUBqCZT+DrWDskC8eF8gyYowaj0ldLoRIdx7g
 y6Uau1zMXL5+xEPt94yfOnJDNu/Gn6lMHjyy7kyHaNPDJ6p77Qafr
X-Gm-Gg: ASbGncseuIz2VammYv9UvO6gqVc+tYif1WIn9Nn63Jh9F4qLAExKGvOVExdRa+hj8ys
 BVB4EaaZbgg/q//9QqRr1dhhFn4fB+rWef2vGh240ugAShXkj5w4MQasFZ44RJ6z17qy/5S5kmh
 DST9QZN8WsaG249uj/PABj7m7rftEo9fTe3cVxvF9Ouy8rXWOywE2RqFUXHXwzYTcc6bOyveKEJ
 WlWdCkciK4q2yC+vYYA3o9K3PN11Gs8JBuJjqVI7s5Smqj1NWzskjrcKFPFsSuYomO8+4z3NP/7
 uCDCYzQ+4ruTrmCntWcCMrDtFgMTUeUvxSzaT/AxJXk0VB5VT15uMr7CBzI=
X-Received: by 2002:a05:600c:3494:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-441c48aa314mr77234145e9.4.1746461686195; 
 Mon, 05 May 2025 09:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+qKxY6qQTfdmnSBz9OwiHHFeonEqC8c3J3eIYNidhgbVpFuRhIzNpvLbofSUT8b1/dS6zg==
X-Received: by 2002:a05:600c:3494:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-441c48aa314mr77233885e9.4.1746461685822; 
 Mon, 05 May 2025 09:14:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a65sm182769135e9.32.2025.05.05.09.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:14:44 -0700 (PDT)
Message-ID: <e3882849-c769-4081-9872-7651d7092520@redhat.com>
Date: Mon, 5 May 2025 18:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
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

Hi Zhenzhong,

On 4/11/25 1:28 PM, Cédric Le Goater wrote:
> On 4/11/25 12:17, Zhenzhong Duan wrote:
>> The saved caps copy can be used to check dirty tracking capability.
>>
>> The capabilities is gotten through IOMMUFD interface, so define a
>> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
>> caps raw data in "include/system/iommufd.h".
>>
>> This is a prepare work for moving .realize() after .attach_device().
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-device.h |  1 +
>>   include/system/iommufd.h      | 22 ++++++++++++++++++++++
>>   hw/vfio/iommufd.c             | 10 +++++++++-
>>   3 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h
>> b/include/hw/vfio/vfio-device.h
>> index 66797b4c92..09a7af891a 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>>       bool dirty_tracking; /* Protected by BQL */
>>       bool iommu_dirty_tracking;
>>       HostIOMMUDevice *hiod;
>> +    HostIOMMUDeviceIOMMUFDCaps caps;
>
> IMO, these capabilities belong to HostIOMMUDevice and not VFIODevice.
I do agree with Cédric that it looks a wrong place to put this caps. I
feel this somehow breaks the abstraction layering.

Now "[PATCH v2 0/5] vfio: Move realize after attach_dev" has landed, I
think it would help if you could respin with a clear functional goal
such as the one targeted in[PATCH v2 0/5] Check host IOMMU compatilibity
with vIOMMU
<https://lore.kernel.org/all/20240408084404.1111628-1-zhenzhong.duan@intel.com/>

Thanks

Eric
>
> I would simply call iommufd_backend_get_device_info() twice where
> needed :
> iommufd_cdev_autodomains_get() and  hiod_iommufd_vfio_realize()
>
>
> Thanks,
>
> C.
>
>
>
>>       int devid;
>>       IOMMUFDBackend *iommufd;
>>       VFIOIOASHwpt *hwpt;
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75bfbf..0f337585c9 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -18,6 +18,9 @@
>>   #include "exec/hwaddr.h"
>>   #include "exec/cpu-common.h"
>>   #include "system/host_iommu_device.h"
>> +#ifdef CONFIG_LINUX
>> +#include <linux/iommufd.h>
>> +#endif
>>     #define TYPE_IOMMUFD_BACKEND "iommufd"
>>   OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass,
>> IOMMUFD_BACKEND)
>> @@ -63,4 +66,23 @@ bool
>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                         Error **errp);
>>     #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE
>> "-iommufd"
>> +
>> +typedef union VendorCaps {
>> +    struct iommu_hw_info_vtd vtd;
>> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
>> +} VendorCaps;
>> +
>> +/**
>> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device
>> capabilities.
>> + *
>> + * @type: host platform IOMMU type.
>> + *
>> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
>> represents
>> + *           the @out_capabilities value returned from
>> IOMMU_GET_HW_INFO ioctl)
>> + */
>> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
>> +    uint32_t type;
>> +    uint64_t hw_caps;
>> +    VendorCaps vendor_caps;
>> +} HostIOMMUDeviceIOMMUFDCaps;
>>   #endif
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 48db105422..530cde6740 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -324,7 +324,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>        * vfio_migration_realize() may decide to use VF dirty tracking
>>        * instead.
>>        */
>> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>           flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>       }
>>   @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char
>> *name, VFIODevice *vbasedev,
>>       int ret, devfd;
>>       uint32_t ioas_id;
>>       Error *err = NULL;
>> +    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
>>       const VFIOIOMMUClass *iommufd_vioc =
>>          
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>   @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char
>> *name, VFIODevice *vbasedev,
>>           goto err_alloc_ioas;
>>       }
>>   +    if (!iommufd_backend_get_device_info(vbasedev->iommufd,
>> vbasedev->devid,
>> +                                         &caps->type,
>> &caps->vendor_caps,
>> +                                         sizeof(VendorCaps),
>> &caps->hw_caps,
>> +                                         errp)) {
>> +        goto err_alloc_ioas;
>> +    }
>> +
>>       /* try to attach to an existing container in this space */
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOIOMMUFDContainer,
>> bcontainer);
>


