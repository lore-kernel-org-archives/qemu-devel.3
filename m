Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D2C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mAl-0005Uy-2f; Tue, 30 Apr 2024 08:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mAd-0005Pz-KU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mAb-0005Hd-Vj
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714478473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5PEPN8p9RoMorNGIsS96jkDCIi8kixvdWvyJ6qnGLQ=;
 b=PH37LV+NxF8QcMH5a9R2n8Uw8bRDgplFL7BZNj/zyVpO1OpcpSRq8uYawfN3N9l+TpRHLK
 sXgM5uv3hNgoK4/dI1AMOlHuvnIleSRCwVaD/b+8gY4SoeLhdsq1wfP//Nh6rz0MW0e9Tz
 TvydErqDkNpl1sLXvGP8cjdZ4+qx504=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-4S5ZoZD3N1mZvrP570rnow-1; Tue, 30 Apr 2024 08:01:11 -0400
X-MC-Unique: 4S5ZoZD3N1mZvrP570rnow-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-439ff4e2cf0so71735641cf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714478471; x=1715083271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u5PEPN8p9RoMorNGIsS96jkDCIi8kixvdWvyJ6qnGLQ=;
 b=PwVb67YRtXGOtloMwylfc7iRaj12TJqAcbpINjcbiTIFjzCwYVq0Mjw5nlhXI4YhUA
 vZeR9S79B+NpXBIfKxAcwtnQKYhQmnLQP4DuAcbi9PXGxWmUrTqm6nAqLo8XLfpOQ85N
 LSOP75kh2zcSFIiB9hLPIC9KxDBY9L5Yc2mVI2jGne+Cw7wmKQK8Rf1guAU0oPdZy4K6
 HOu5Q/ux+qmcxwmNdMZM+WuuHcvASv8D5YmDFQ0IPQZsHdZM2zFs8Ei6sHJ/bPV2tr59
 MeYRDimWKdzGraPohaLu/LRT2YUBmneu2CcPaw1otqcWxCaw8fP2mhNoWxAsAwYoyIPS
 yZhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUteXFjhIOwkFdiz3ZAVejZXz5jDfw9Bvf1ARvvapUWXiQiicZpwnOElT51C2SvUxpxqoCzZuvtO4hKTjh03OcTogH16gE=
X-Gm-Message-State: AOJu0Yy0ke8Hn1gnJjgwYvGNfWKe+Vd7z6qEXGrBpGcVJ8jdabfuKZJ+
 PTsaA030a6YC+mQ2F2INIrqQpQOUePsG1t1ELb2e3xOirXD5flkW3RnEMncqaumPVgNiXRB+exU
 oeJn73k4+yWEPd6FoYSHETF4urBBTm7hprpPLbGLS0LB41ycB/MXU
X-Received: by 2002:ac8:5805:0:b0:43a:c0c7:a223 with SMTP id
 g5-20020ac85805000000b0043ac0c7a223mr2590661qtg.48.1714478470970; 
 Tue, 30 Apr 2024 05:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7BUN5mFkeVoa69TqaWk5CSlZ6xWB3PhCDrLyKM1CInqK/zn1EsHyXXg4JMNCw/1QNFmlEnA==
X-Received: by 2002:ac8:5805:0:b0:43a:c0c7:a223 with SMTP id
 g5-20020ac85805000000b0043ac0c7a223mr2590619qtg.48.1714478470400; 
 Tue, 30 Apr 2024 05:01:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o2-20020ac872c2000000b00439bb9c454bsm7883506qtp.56.2024.04.30.05.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 05:01:09 -0700 (PDT)
Message-ID: <60b835fe-3e69-4ade-b25f-a2649d6cdaa9@redhat.com>
Date: Tue, 30 Apr 2024 14:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-6-zhenzhong.duan@intel.com>
 <1495f7b1-d3f3-4bd9-93de-34767cfa5b26@redhat.com>
 <SJ0PR11MB6744A11C683EA4242EADB730921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744A11C683EA4242EADB730921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/24 11:55, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 05/19] backends/host_iommu_device: Introduce
>> HostIOMMUDeviceCaps
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> HostIOMMUDeviceCaps's elements map to the host IOMMU's capabilities.
>>> Different platform IOMMU can support different elements.
>>>
>>> Currently only two elements, type and aw_bits, type hints the host
>>> platform IOMMU type, i.e., INTEL vtd, ARM smmu, etc; aw_bits hints
>>> host IOMMU address width.
>>>
>>> Introduce .check_cap() handler to check if
>> HOST_IOMMU_DEVICE_CAP_XXX
>>> is supported.
>>>
>>> Introduce a HostIOMMUDevice API host_iommu_device_check_cap()
>> which
>>> is a wrapper of .check_cap().
>>>
>>> Introduce a HostIOMMUDevice API
>> host_iommu_device_check_cap_common()
>>> to check common capabalities of different host platform IOMMUs.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/sysemu/host_iommu_device.h | 44
>> ++++++++++++++++++++++++++++++
>>>    backends/host_iommu_device.c       | 29 ++++++++++++++++++++
>>>    2 files changed, 73 insertions(+)
>>>
>>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>>> index 2b58a94d62..12b6afb463 100644
>>> --- a/include/sysemu/host_iommu_device.h
>>> +++ b/include/sysemu/host_iommu_device.h
>>> @@ -14,12 +14,27 @@
>>>
>>>    #include "qom/object.h"
>>>    #include "qapi/error.h"
>>> +#include "linux/iommufd.h"
>>> +
>>> +/**
>>> + * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>>> + *
>>> + * @type: host platform IOMMU type.
>>> + *
>>> + * @aw_bits: host IOMMU address width. 0xff if no limitation.
>>> + */
>>> +typedef struct HostIOMMUDeviceCaps {
>>> +    enum iommu_hw_info_type type;
>>> +    uint8_t aw_bits;
>>> +} HostIOMMUDeviceCaps;
>>>
>>>    #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>>>    OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass,
>> HOST_IOMMU_DEVICE)
>>>
>>>    struct HostIOMMUDevice {
>>>        Object parent_obj;
>>> +
>>> +    HostIOMMUDeviceCaps caps;
>>>    };
>>>
>>>    /**
>>> @@ -47,5 +62,34 @@ struct HostIOMMUDeviceClass {
>>>         * Returns: true on success, false on failure.
>>>         */
>>>        bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
>>> +    /**
>>> +     * @check_cap: check if a host IOMMU device capability is supported.
>>> +     *
>>> +     * Optional callback, if not implemented, hint not supporting query
>>> +     * of @cap.
>>> +     *
>>> +     * @hiod: pointer to a host IOMMU device instance.
>>> +     *
>>> +     * @cap: capability to check.
>>> +     *
>>> +     * @errp: pass an Error out when fails to query capability.
>>> +     *
>>> +     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
>>> +     * 1 or some positive value for some special @cap,
>>> +     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
>>> +     */
>>> +    int (*check_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>>>    };
>>> +
>>> +/*
>>> + * Host IOMMU device capability list.
>>> + */
>>> +#define HOST_IOMMU_DEVICE_CAP_IOMMUFD       0
>>> +#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    1
>>> +#define HOST_IOMMU_DEVICE_CAP_AW_BITS       2
>>> +
>>> +
>>> +int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap,
>> Error **errp);
>>> +int host_iommu_device_check_cap_common(HostIOMMUDevice *hiod,
>> int cap,
>>> +                                       Error **errp);
>>>    #endif
>>> diff --git a/backends/host_iommu_device.c
>> b/backends/host_iommu_device.c
>>> index 41f2fdce20..b97d008cc7 100644
>>> --- a/backends/host_iommu_device.c
>>> +++ b/backends/host_iommu_device.c
>>> @@ -28,3 +28,32 @@ static void host_iommu_device_init(Object *obj)
>>>    static void host_iommu_device_finalize(Object *obj)
>>>    {
>>>    }
>>> +
>>> +/* Wrapper of HostIOMMUDeviceClass:check_cap */
>>> +int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap,
>> Error **errp)
>>
>> Since we have an 'Error **errp', we could return a bool instead,
>> unless this is a 'get_cap' routine ?
> 
> Maybe better to name it host_iommu_device_get_cap()?
> Because not all results are bool, some are integer, i.e., aw_bits.

LGTM.


Thanks,

C.




