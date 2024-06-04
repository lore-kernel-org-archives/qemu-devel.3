Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82703C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQbs-0006vi-VZ; Tue, 04 Jun 2024 05:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEQbr-0006tw-BY
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEQbn-0001rm-P7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717493854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSAjU+J2IbvB9SwYgUKhF63zhcxfXEG353X1cQVNztc=;
 b=TeOh38aij3kObj/hAJifa/yYivGPLehKABOuPr8KgRJbtNXvFr54Y8DccFHpz1j2E8K+4m
 K9bthMdZauKHEt0tijQZEKvYmBML4KdHIrnhTvFqYv/a5hkXXwsNT1vFdM9u7wLyWGncVj
 RJyWdo8Ysb4CIaTxueoozOE69jhC9IA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-HutQ9dBWN8-J9S7yIf_GRQ-1; Tue, 04 Jun 2024 05:37:31 -0400
X-MC-Unique: HutQ9dBWN8-J9S7yIf_GRQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212a20c447so30009255e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717493850; x=1718098650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSAjU+J2IbvB9SwYgUKhF63zhcxfXEG353X1cQVNztc=;
 b=CgsYNH/EflNDwNegCh/w+AUIbAlUs+fKBk6ubBlanwvmeX3eH9ZXNVkbd1Fi0DYGeS
 p3Ae9Yjq9tozqFA75StTiIaj032afHuVKXtQTX2F+HMY9u1wRn06Q35Dj1NOkfvWY4ZE
 h8qdjTDWrfZJ6PomlDk1OQ8ujUZ0dUuK7UvH81wSb2aZyqv+LSBGIqeencqZ6mLTeK4O
 SkywcChH0IUZSuIltNdN4CcY2IL69/jaJSZ6uVzRcPb0D4qV3PLzdnm0cE9gRnzShk8S
 mSTVigqpz+wVMEqNQ/TJ+RZ2uV3cNiHRPpDfwmW6dW+Ejt4eHHIHpOw1XGcVR1e5Gc7L
 Hbmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYY7oRNcFAm2iUIUqNRzw0hN3W7B4P1Wuc2pBmuqwYywNLqzwy1NNzXl3+FUp9XkNT/Wr7mnFw2HpI2X/5Stj9/5xmlKY=
X-Gm-Message-State: AOJu0YwmsLWWJem+czK9WgRafmY/Wk8t7Rl0SMm5KruMO8s3hjS+e9TN
 BZUWrWXf4jgiIR9kD0S/T4M2AhldBVjoPHuinexhd3K6/8yYG2xTq3zQ+Fm6SZaQ0xhGYzXdZIc
 d2yThAQmu7RMt/5VlHC7NbQFGqW+GHiZem2D42PAjm2JeGRzsFw8O
X-Received: by 2002:a05:600c:a46:b0:421:2b13:e9cf with SMTP id
 5b1f17b1804b1-4212e0c1440mr108195055e9.36.1717493850667; 
 Tue, 04 Jun 2024 02:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhTppKXKt0qbu6nE63uk7u6BrRmkQI1RWxMAksvpJyJm/Te9yp0avMWpyydPQAFOgT9okGiA==
X-Received: by 2002:a05:600c:a46:b0:421:2b13:e9cf with SMTP id
 5b1f17b1804b1-4212e0c1440mr108194875e9.36.1717493850269; 
 Tue, 04 Jun 2024 02:37:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214beb5c9asm13929885e9.7.2024.06.04.02.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 02:37:29 -0700 (PDT)
Message-ID: <c21bd141-96fe-475a-a645-8dc392ff2450@redhat.com>
Date: Tue, 4 Jun 2024 11:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
 <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
 <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
 <SJ0PR11MB6744B71456C0686F70F023C892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <175f9e2d-8ade-4e44-a7bd-d8c7a4c85378@redhat.com>
 <SJ0PR11MB67444BA9CD463A744C9A616292F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67444BA9CD463A744C9A616292F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/4/24 10:46, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
>> HostIOMMUDeviceClass::get_cap() handler
>>
>>
>>
>> On 6/4/24 05:23, Duan, Zhenzhong wrote:
>>> Hi Cédric, Eric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH v6 11/19] backends/iommufd: Implement
>>>> HostIOMMUDeviceClass::get_cap() handler
>>>>
>>>> On 6/3/24 13:32, Eric Auger wrote:
>>>>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>>>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> ---
>>>>>>   backends/iommufd.c | 23 +++++++++++++++++++++++
>>>>>>   1 file changed, 23 insertions(+)
>>>>>>
>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>> index c7e969d6f7..f2f7a762a0 100644
>>>>>> --- a/backends/iommufd.c
>>>>>> +++ b/backends/iommufd.c
>>>>>> @@ -230,6 +230,28 @@ bool
>>>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>>>>>       return true;
>>>>>>   }
>>>>>>
>>>>>> +static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap,
>>>> Error **errp)
>>>>>> +{
>>>>>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>>>> +
>>>>>> +    switch (cap) {
>>>>>> +    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>>>>>> +        return caps->type;
>>>>>> +    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>>>>> +        return caps->aw_bits;
>>>>>> +    default:
>>>>>> +        error_setg(errp, "Not support get cap %x", cap);
>>>>> can't you add details about the faulting HostIOMMUDevice by tracing
>> the
>>>>> devid for instance?
>>>> yes.
>>> devid isn't added to make this series simpler.
>>> It's added in nesting series,
>> https://github.com/yiliu1765/qemu/commit/5333b1a0ae03b3c5119b46a1
>> af786d199f103889
>>> Do you want to add devid in this series for tracing purpose or adding trace
>> in nesting series is fine for you?
>>
>> what would be nice is to get a common way to identify a HostIOMMUDevice,
>> can't we use the name of the VFIO/VDPA device? devid does not exist on
>> legacy container. At least a kind of wrapper may be relevant to extract
>> the name.
> Getting name directly is not easy, we can save a copy in .realize(), like below:

sounds good + dealloc

Eric
>
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -33,6 +33,7 @@ OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
>  struct HostIOMMUDevice {
>      Object parent_obj;
>
> +    char *name;
>      HostIOMMUDeviceCaps caps;
>  };
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index f2f7a762a0..84fefbc9ee 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -240,7 +240,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>          return caps->aw_bits;
>      default:
> -        error_setg(errp, "Not support get cap %x", cap);
> +        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
>      }
>  }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a830426647..e78538efec 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1152,6 +1152,7 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      } else {
>          hiod->caps.aw_bits = 0xff;
>      }
> +    hiod->name = g_strdup(vdev->name);
>
>      return true;
>  }
> @@ -1165,7 +1166,7 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>          return caps->aw_bits;
>      default:
> -        error_setg(errp, "Not support get cap %x", cap);
> +        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
>      }
>  }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8fd8d52bc2..2df3aed47f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -637,6 +637,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>          return false;
>      }
>
> +    hiod->name = g_strdup(vdev->name);
>      caps->type = type;


