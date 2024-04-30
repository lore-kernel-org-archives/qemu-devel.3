Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA30AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mOv-0002gD-Fg; Tue, 30 Apr 2024 08:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mOj-0002bB-Sr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mOg-0007r4-TB
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714479345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4v595rZg2XxHllqWyjNJv89TVARlrrOv96avZypDAoI=;
 b=QQZ08xG8/l77QSUJxhVETaauHpxFna2r2wX5lKSjkihcDzoKgOI3cb2tjroC12tmB7JUNE
 Pp4XX8vpRV4O82zDhyF3AZRvVcwwLM7dnAafpEj9xLtxo3+3PFHpEn/yGW8H1K4oBOME4v
 JUdKjP3dw/CIYetNPeT683bWAAfUBjA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-8me35XRFO2KXWH77PAN_kA-1; Tue, 30 Apr 2024 08:15:44 -0400
X-MC-Unique: 8me35XRFO2KXWH77PAN_kA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51d6630a5ebso2123496e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714479343; x=1715084143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4v595rZg2XxHllqWyjNJv89TVARlrrOv96avZypDAoI=;
 b=nQL7TTBTK7zsfqUSWvu9BQRGmIEuizyeBnbL8VFOGiUA/+Gd5Mj6MhQBeFmaPndjrI
 o9lwqPr/cG+MhbZmZUl40BHWqxPeIDbo4uMBckJrvY8kMy4U0JHIeRWvR1g/p6ao+rGc
 v5u3oOu2KGbQIcfrEl+IUUFtSLQ4L5lDMdmRGhU7LL41/cjNv5gcpiZ+Rl4TadGap6Y7
 t8aOZp9QAK93vzKrbPTryd4QkPO+C211oFS9fhDPxTmViCYMrFDoqUMhiVi2CmMMtaoh
 2EV8yIkHvd1VdSm3xaSioH7vvOnVTtds5UjWd2794v3ign5et6pGniEavTUPBnXX3vy9
 1wdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHh0LbZ+L+0ZIsACvHHAIwsHXy+shiqs2QysounkX68TUIirm0fJPeqbTOPt38sG55G6PGB6m84wDjHLOC8Y+5Z5B+qbY=
X-Gm-Message-State: AOJu0Yy7yhUyUef5mTrDFXJSviTZoAlO98rn0ws09V19R0aMKQNmzhnA
 eBBLrpOzXG6gtqz9C6pLxauTBqlnmSbUJHiQSyix4Uo/SofqPHKfzIxh21X+To7BFsXmQi66AYK
 FSMPZdw0+LQy3dfwuXoQ13aFbGzomonbPGCC2VHUJwsdY7Hgmo+XG
X-Received: by 2002:a05:6512:448:b0:519:6e94:9b4d with SMTP id
 y8-20020a056512044800b005196e949b4dmr9213475lfk.48.1714479342827; 
 Tue, 30 Apr 2024 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhR3wPdEKNC/weyH/1Oad3jgUfDynTqQP/sAlZRsSF+8QdgnKVfRGF/U/MNBXs+FgXGTGdHQ==
X-Received: by 2002:a05:6512:448:b0:519:6e94:9b4d with SMTP id
 y8-20020a056512044800b005196e949b4dmr9213456lfk.48.1714479342467; 
 Tue, 30 Apr 2024 05:15:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a056402100400b005720caa01easm9598710edu.69.2024.04.30.05.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 05:15:41 -0700 (PDT)
Message-ID: <cd129c89-c21d-450b-ab5e-61745cdd165b@redhat.com>
Date: Tue, 30 Apr 2024 14:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/19] vfio: Create host IOMMU device instance
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
 <20240429065046.3688701-14-zhenzhong.duan@intel.com>
 <0ca17106-a529-4d54-989f-9b9b47c6b8a7@redhat.com>
 <SJ0PR11MB6744AA5CBB630EB00AFCC04A921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744AA5CBB630EB00AFCC04A921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 4/30/24 12:16, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 13/19] vfio: Create host IOMMU device instance
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> Create host IOMMU device instance in vfio_attach_device() and call
>>> .realize() to initialize it further.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h |  1 +
>>>    hw/vfio/common.c              | 18 +++++++++++++++++-
>>>    2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index 0943add3bc..b204b93a55 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -126,6 +126,7 @@ typedef struct VFIODevice {
>>>        OnOffAuto pre_copy_dirty_page_tracking;
>>>        bool dirty_pages_supported;
>>>        bool dirty_tracking;
>>> +    HostIOMMUDevice *hiod;
>>>        int devid;
>>>        IOMMUFDBackend *iommufd;
>>>    } VFIODevice;
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 8f9cbdc026..0be8b70ebd 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1497,6 +1497,8 @@ int vfio_attach_device(char *name, VFIODevice
>> *vbasedev,
>>>    {
>>>        const VFIOIOMMUClass *ops =
>>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>> +    HostIOMMUDevice *hiod;
>>> +    int ret;
>>>
>>>        if (vbasedev->iommufd) {
>>>            ops =
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUF
>> D));
>>> @@ -1504,7 +1506,20 @@ int vfio_attach_device(char *name,
>> VFIODevice *vbasedev,
>>>
>>>        assert(ops);
>>>
>>> -    return ops->attach_device(name, vbasedev, as, errp);
>>> +    ret = ops->attach_device(name, vbasedev, as, errp);
>>> +    if (ret < 0) {
>>> +        return ret;
>>
>>
>> hmm, I wonder if we should change the return value of vfio_attach_device()
>> to be a bool.
> 
> I see, also VFIOIOMMUClass:: setup and VFIOIOMMUClass::add_window.
> I can add cleanup patches to fix them if you have no other plan.

Yes please. I don't have plans for changes in that area. The only pending
patches are from the series "[v4] migration: Improve error reporting" [*].

Thanks,

C.


[*] https://lore.kernel.org/qemu-devel/20240306133441.2351700-1-clg@redhat.com/



