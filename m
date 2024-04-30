Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA84C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mM1-00017Z-R4; Tue, 30 Apr 2024 08:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mLz-00017F-Rs
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mLl-0007ZO-Ir
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714479162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud0XM2vA0VI3RDCIHTBNeHqQT4GBHoZWSuov7oJIvqw=;
 b=gE7DbU1BLKvoEB0cBNJ/MVLZAED4UgXnF2RZOdj1Xg4uVQY+Fp76W7Wm3qSL0ItR4tjt0f
 SXqlPA+x5ZODIouscNyML9maeANIfV6ysKT8dHOQf+5axCZfWZcpPRsupKV8TnY87u02Nn
 Q3o15natBM8q8IqSJgf6Vg8/DkEI9BI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-jKY3kss6Mk-PA6hNbiVV9w-1; Tue, 30 Apr 2024 08:12:40 -0400
X-MC-Unique: jKY3kss6Mk-PA6hNbiVV9w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2db6fbc1dedso54022391fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714479159; x=1715083959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ud0XM2vA0VI3RDCIHTBNeHqQT4GBHoZWSuov7oJIvqw=;
 b=q3YBivY0N74NeRXxRvjM1cwCFTfwjm/AlcskXGBQV0pbQUv/EbMVxLzmYATlBEQ3MJ
 GO03QCVv5kzEU99Ks4s1sJHcjZvsvTz+jeL1t+1MR95Td+UpBOOZDlajMhz26Xm1EPaM
 06c2hSh4t1THArXvBgvA+bxTfG6w8PfMI2w3AADas8EkDSDo8tljBM0HqfchjCPJpKov
 fkU7OLE+c5xTK6Vc/L/O7z1RFikTdmouM0unZ744Mx77wQ5FQuQMtF7mNb2RZ0QRv0Dz
 j26G6TZb5FBwaEjUB3R9ix4tRqYMCzfZs6JEHIN4U0KDzyqw6NbnH1HXw+yaAhgV964l
 ia8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcC+7526/9uLy+GjPWXaBQ5TMSgQSSQi4/IbRp50ABnuTFYGQckgg0tvmhaCJ+Rk8jJSwhrnOx3V3uWLT+8qKr51kHv4A=
X-Gm-Message-State: AOJu0YzKL/A3NufaMNSJHtzL0jUY319EDdUosxzYoa2q9nqBuR9d2Ndw
 0wQ1lMwT3gplm6jEg/05PVnzZjPDa8dZELuz2vFSzhCpMQEc6ZF+/ulebhvh3h3ok+9dVt7eYWp
 PSe69xY5xK5fm9XWUTk/MbMBW33jzRZKyorm+XHGUu/rpuOBWZ7h1
X-Received: by 2002:a2e:2c18:0:b0:2d8:7d1a:1118 with SMTP id
 s24-20020a2e2c18000000b002d87d1a1118mr11201198ljs.23.1714479159058; 
 Tue, 30 Apr 2024 05:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9nTIaD6Za9Jn+S5LDKdvdZdzKA2MuEH8KeCeLzCTSjcwQmXX+Eq9SXnS942q6f7qP4hsGMw==
X-Received: by 2002:a2e:2c18:0:b0:2d8:7d1a:1118 with SMTP id
 s24-20020a2e2c18000000b002d87d1a1118mr11201166ljs.23.1714479158599; 
 Tue, 30 Apr 2024 05:12:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a2e9045000000b002d85e57fa3dsm3777013ljg.104.2024.04.30.05.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 05:12:37 -0700 (PDT)
Message-ID: <47877e84-cf7d-4b51-997a-f61cd208a55c@redhat.com>
Date: Tue, 30 Apr 2024 14:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
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
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
 <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
 <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/30/24 12:06, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
>> HostIOMMUDeviceClass::check_cap() handler
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    backends/iommufd.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index d61209788a..28faec528e 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -233,6 +233,23 @@ int
>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>        return ret;
>>>    }
>>>
>>> +static int hiod_iommufd_check_cap(HostIOMMUDevice *hiod, int cap,
>> Error **errp)
>>> +{
>>> +    switch (cap) {
>>> +    case HOST_IOMMU_DEVICE_CAP_IOMMUFD:
>>> +        return 1;
>>
>> I don't understand this value.
> 
> 1 means this host iommu device is attached to IOMMUFD backend,
> or else 0 if attached to legacy backend.

Hmm, this looks hacky to me and it is not used anywhere in the patchset.
Let's reconsider when there is actually a use for it. Until then, please
drop. My feeling is that a new HostIOMMUDeviceClass handler/attributed
should be introduced instead.


Thanks,

C.



> Strictly speaking, HOST_IOMMU_DEVICE_CAP_IOMMUFD is not a
> hardware capability, I'm trying to put all(sw/hw) in CAPs checking
> framework just like KVM<->qemu CAPs does.
> 
> Thanks
> Zhenzhong
> 
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>> +    default:
>>> +        return host_iommu_device_check_cap_common(hiod, cap, errp);
>>> +    }
>>> +}
>>> +
>>> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>>> +
>>> +    hioc->check_cap = hiod_iommufd_check_cap;
>>> +};
>>> +
>>>    static const TypeInfo types[] = {
>>>        {
>>>            .name = TYPE_IOMMUFD_BACKEND,
>>> @@ -251,6 +268,7 @@ static const TypeInfo types[] = {
>>>            .parent = TYPE_HOST_IOMMU_DEVICE,
>>>            .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
>>>            .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
>>> +        .class_init = hiod_iommufd_class_init,
>>>            .abstract = true,
>>>        }
>>>    };
> 


