Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F23DC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJX0H-0004TS-AW; Tue, 18 Jun 2024 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJX0G-0004TI-Gl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJX0E-00081O-Uq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718710074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ebBhDRKsKAYeRnJMGyT5ncuJEKw5BwD3opjwB/Ufek=;
 b=JCdStiy6nrL6bhaC8H58/ZckcA2htnJTTtFa/UDxtTvr6RRJ/Fz7suPJlHQD8149Hxe49V
 gOPWF7JenEbt/r8FP3srxbhEPsgaK+1e3CwCVh3Cqj9CW9XPnrZDSDCQ6AoEWf/xKzEJnf
 1V8eTHmCd12cXWlDAQxyF9iE3n+IBnA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-JxmUr2IDMXmJClxczt8F5g-1; Tue, 18 Jun 2024 07:27:52 -0400
X-MC-Unique: JxmUr2IDMXmJClxczt8F5g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36279cf642cso168635f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718710071; x=1719314871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ebBhDRKsKAYeRnJMGyT5ncuJEKw5BwD3opjwB/Ufek=;
 b=WxyYjU9B8s0dUwiQH4EufWYCsE6W5fyW53b7YOiPIFzPjjQWS193hViHFRRRG/yb88
 NpMNZfnFjuj88UOz4KsJoKP+2enQMfXzFzO+9ifTrasrBqi9T/9y6hl6lucDM/weSOYu
 tU4qJF3mvQLO8GFOOyT+GkIqI8SeKxGK8xc+LvMSEL6G9aE/FO2DPXRZcRQUenkGlHGT
 qNyBDDwkrsIb0UWdr0M9lnP1UHyfGBExvByG14nDni+m2DS/ezICoNCiDiLQ5+6bK3Zg
 nr3eYqOjt7ujcBuT8W7kj/oySC0iJdNfy7fLGpaqPKJXnp6Er3bSM0GzTeAF+jVJricY
 UXGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWanYYVjUzzlajPbiCTdvg9xE/J0asRKvNcJk433cnuYZkiy32ia1WesjpHoNePJP3QQKl6zZbgDRS3UJcfArv/kYpd/iM=
X-Gm-Message-State: AOJu0YwveUi0CU/5xTfqH6jCQM+hQbRQwsx3UiidE0EEmSBuyUgJwfVp
 F3pFenDPlUMFOhD83mzamunOkHrtbbLe1F4f/fhDtrboa4gox8Xtqa6moKwtoWR/Ko+kb4LtMsN
 lq9KYyNI8kxbkqTJUmTQ3Xm9ZG6uFz6ejh7tOqINpztphnSie2nhIcmV3aL5x
X-Received: by 2002:adf:f00c:0:b0:362:a1e8:16c with SMTP id
 ffacd0b85a97d-362a1e80560mr386748f8f.2.1718710071412; 
 Tue, 18 Jun 2024 04:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO0jFcpdJTjMFl8OpRmgMNFzwAQXyz4O1fcvol90KXf8wM9UjKlPvUwJaI/zV2TEgOHsAU/g==
X-Received: by 2002:adf:f00c:0:b0:362:a1e8:16c with SMTP id
 ffacd0b85a97d-362a1e80560mr386738f8f.2.1718710071033; 
 Tue, 18 Jun 2024 04:27:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad1absm13751995f8f.62.2024.06.18.04.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:27:50 -0700 (PDT)
Message-ID: <1e91d6be-3357-4030-ac18-af241e21b30c@redhat.com>
Date: Tue, 18 Jun 2024 13:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] vfio/container: Introduce
 vfio_address_space_insert()
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-6-clg@redhat.com>
 <4dd2cb75-c6dc-426e-bb0c-87e25ea057b7@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4dd2cb75-c6dc-426e-bb0c-87e25ea057b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/17/24 4:04 PM, Eric Auger wrote:
> 
> 
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> It will ease future changes.
> Does it, really?

Changed to :

   It prepares gound for a future change initializing the 'space' pointer
   of VFIOContainerBase. The goal is to replace vfio_container_init() by
   an .instance_init() handler when VFIOContainerBase is QOMified.

Thanks,

C.


> 
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 2 ++
>>   hw/vfio/common.c              | 6 ++++++
>>   hw/vfio/container.c           | 2 +-
>>   hw/vfio/iommufd.c             | 2 +-
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c19572f90b277193491020af28e8b5587f15bfd1..825d80130bd435fe50830c8ae5b7905d18104dd6 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -206,6 +206,8 @@ typedef struct VFIODisplay {
>>   
>>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>>   void vfio_put_address_space(VFIOAddressSpace *space);
>> +void vfio_address_space_insert(VFIOAddressSpace *space,
>> +                               VFIOContainerBase *bcontainer);
>>   
>>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index f28641bad5cf4b71fcdc0a6c9d42b24c8d786248..8cdf26c6f5a490cfa02bdf1087a91948709aaa33 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1508,6 +1508,12 @@ void vfio_put_address_space(VFIOAddressSpace *space)
>>       }
>>   }
>>   
>> +void vfio_address_space_insert(VFIOAddressSpace *space,
>> +                               VFIOContainerBase *bcontainer)
>> +{
>> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> +}
>> +
>>   struct vfio_device_info *vfio_get_device_info(int fd)
>>   {
>>       struct vfio_device_info *info;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index c48749c089a67ee4d0e6b8dd975562e2938500cd..0237c216987ff64a6d11bef8688bb000d93a7f09 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -637,7 +637,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       vfio_kvm_device_add_group(group);
>>   
>>       QLIST_INIT(&container->group_list);
>> -    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> +    vfio_address_space_insert(space, bcontainer);
>>   
>>       group->container = container;
>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index e502081c2ad9eda31769176f875fef60a77e2b43..9f8f33e383a38827ceca0f73cb77f5ca6b123198 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -358,7 +358,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>   
>>       bcontainer = &container->bcontainer;
>>       vfio_container_init(bcontainer, space, iommufd_vioc);
>> -    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> +    vfio_address_space_insert(space, bcontainer);
>>   
>>       if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>           goto err_attach_container;
> 


