Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76776C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 09:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2SCo-0003cz-KH; Wed, 09 Apr 2025 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2SCd-0003RE-3q
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2SCb-0006K1-Ae
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744192713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bJjTxSLryGUpm7YdqWZ9Ki1bXxQUhRgUe5Z4s4xcRys=;
 b=BdMVVb92HwiCZ/BSDWPSadS6dUYoaRg7LbG2VV6j015WLxmr1WFryKrDDhJko2wawTY3wg
 EjPM/CVAhTmlr45LI4L8rLye2E6I502B4n1csN+6PZEl/ucDO3NXem4i/xbkjZmdIm5KZR
 cXBGMcMB5od5CtIGTdEMpWUOF524DFo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-wyZF1AoKPEayFnPIl1Gw1Q-1; Wed, 09 Apr 2025 05:58:32 -0400
X-MC-Unique: wyZF1AoKPEayFnPIl1Gw1Q-1
X-Mimecast-MFC-AGG-ID: wyZF1AoKPEayFnPIl1Gw1Q_1744192712
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3914bc0cc4aso3348670f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 02:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744192711; x=1744797511;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJjTxSLryGUpm7YdqWZ9Ki1bXxQUhRgUe5Z4s4xcRys=;
 b=vsxDjXH8mh9iaW2orQu2bj+RUBF5tnDoGRMnSNTouMXKXlsKGaP0x/q9jwhRprF0jT
 DJsxpyMejiou3YbH0rzU77mGNS0eH1CnBiGNdCr+63MBsqh1DuMZiY9HyetfsJBeweDL
 dMq0c01rCosr6YpPLHemhAHab0nfWNvCgiZr8vRL1wzskz039UOmaUP7ymm4mArtvR7A
 5V5R1pikIz9WwDwOcIuezFr8zpmSry9F4ih8d3dBQXvsZWpJBGsUfjCPSW6iKAcqHcsa
 Hr4BhQPY70jpTFSIfE2x1wkAxrzCC8gzI5V7o19NuY7+fw6HT9b3p/kdn2D/zXHD+5cf
 2QLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoJD/RV8kzB4p9pE74jHhY72CPai1iNp4A/oxjWu1R99wQNsQQeoQaD978ZN57z8Qcik5/6zgfs+iy@nongnu.org
X-Gm-Message-State: AOJu0YysVuJxQGEc9PloYUPKIOmumvvt4MbQ768nNH7jLEH8oJyfcxDR
 h4l0YWhP/mpK91z+SBUwtD7ylJoGkpT6IOQHHqa5Yw78fkOYLTit5vXtFx/XEBCQmgQAR0MWy53
 +6yW6qr+vPMKGTpMimX6cuqv8t5S9AxXIAzu3anbCnK9AieWIMcfO
X-Gm-Gg: ASbGncteL2NRCFw5nDMiylKKEjLaa58ZjxMkKa7AQLJiETrEf4m/3Vhdrow00Foxk4W
 RfCMnaF0tXJpP0lpDFkamFZmGn1pQ59K903I6X0lxGhBhuQlurHUawqP7w8IuihgR48BWZX+4IE
 moonxbvV9mX2/GltZneD4WcRlBeC1TrPuKE4hJ8Lzf67rpnUx7kKplBAPqQoXfZ+IZNpUc2r8yN
 kY3lJToZcWcd/z6Fi2kwBIV6w6XIdR9p9OJqK5EqGMhS/M+Fc3+xdQ4hMxdv/Gsx56WM3T9mD7G
 CfmQewU4f3j5iZsQXIylSX2TJhD8VSCdKxLxmHU8PG6xegusVg==
X-Received: by 2002:a05:6000:40df:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-39d87cd02f5mr2090975f8f.46.1744192711621; 
 Wed, 09 Apr 2025 02:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiTo47Xtcs3k4BQC7hfsL8zpPup3F+n0eV9Xo3IV6qGI6eAAaNOVOBnIc9fZw9UIcZCd0hAw==
X-Received: by 2002:a05:6000:40df:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-39d87cd02f5mr2090950f8f.46.1744192711238; 
 Wed, 09 Apr 2025 02:58:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a273fsm10864335e9.9.2025.04.09.02.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 02:58:30 -0700 (PDT)
Message-ID: <00adc783-723a-4d5b-b3f9-d3b8d191b07a@redhat.com>
Date: Wed, 9 Apr 2025 11:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
 <084cbb65-f3c3-4f18-ae3a-88f20480d2ff@redhat.com>
 <16fc9fa0-2b88-4029-ad0b-cedc279c956c@redhat.com>
 <SJ0PR11MB674476F80FEFA6A5AD1DAA0A92B42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB674476F80FEFA6A5AD1DAA0A92B42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/9/25 10:27, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
>> callback
>>
>> On 4/7/25 13:19, Cédric Le Goater wrote:
>>> On 2/19/25 09:22, Zhenzhong Duan wrote:
>>>> Currently we have realize() callback which is called before attachment.
>>>> But there are still some elements e.g., hwpt_id is not ready before
>>>> attachment. So we need a realize_late() callback to further initialize
>>>> them.
>>>
>>> The relation between objects HostIOMMUDevice and VFIOIOMMU is starting
>>> to look too complex for me.
> 
> Agree.
> 
>>>
>>> I think it makes sense to realize HostIOMMUDevice after the device
>>> is attached. Can't we move :
>>>
>>>           hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>           vbasedev->hiod = hiod;
>>>
>>> under ->attach_device() and also the call :
>>>
>>>       if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>
>>> later in the ->attach_device() patch ?
>>>
>>> hiod_legacy_vfio_realize() doesn't do much. We might need to rework
>>> hiod_iommufd_vfio_realize() which queries the iommufd hw caps, later
>>> used by intel-iommu.
>>
>> The only dependency I see on the IOMMUFD HostIOMMUDevice when attaching
>> the device to the container is in iommufd_cdev_autodomains_get(). The
>> flags for IOMMU_HWPT_ALLOC depends on the HW capability of the IOMMFD
>> backend and we rely on hiod_iommufd_vfio_realize() to have done the
>> query on the iommufd kernel device before.
>>
>> Since this is not a hot path, I don't think it is a problem to add
>> a redundant call to iommufd_backend_get_device_info() in
>> iommufd_cdev_autodomains_get() and avoid the IOMMUFD HostIOMMUDevice
>> dependency. With that we can move the HostIOMMUDevice creation and
>> realize sequence at the end of the device attach sequence.
> 
> Yes.
> 
>>
>> I think this makes the code cleaner when it comes to using the
>> vbasedev->hiod pointer too.
>>
>>> Anyway, it is good time to cleanup our interfaces before adding more.
> 
> OK, let me think about this further and write some patches to move .realize() after .attach_device().
> will be based on vfio-next.

I just updated the vfio-next branch with what should be in the next PR
for QEMU 10.1.

> 
>>
>> On that topic, I think
>>
>>     iommufd_cdev_attach_ioas_hwpt
>>     iommufd_cdev_detach_ioas_hwpt
>>
>> belong to IOMMUFD backend.
> 
> They are operation on VFIODevice, backends/iommufd.c are for operation on IOMMUFDBackend,
> Do we need to move iommufd_cdev_attach/detach_ioas_hwpt to backends/iommufd.c which is VFIODevice agnostic?

My mistake. I was confused with

   int iommufd = vbasedev->iommufd->fd

and thought we could simply replace 'VFIODevice *' parameter with a
'IOMMUFDBackend *be' parameter but this is not the case.

Thanks,

C.


