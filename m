Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53691C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJX1e-0006um-QH; Tue, 18 Jun 2024 07:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJX1c-0006rn-G6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJX1Z-00089V-1B
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718710156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QL2mCqxcTA/gR5pi/d5I9eeUirEcmK6GAkuaOzW5g9I=;
 b=Nyb4y1BAKI6aMHQ5Iroz9QJK60T6HH1DtuiNCWTgaekLqx9YocV4IGMPGOJQLkJvD405e5
 0+7F1olRRTpGVQYpdjfo6N2zUanWfNwRCwfR9gG+kNDVC622zzfy7b8v8uzrpoKo6hr4Pw
 e//jzeCawdauRyySkMM799faoGoV1W8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-byZ4hHRfNhytq8J6p958KA-1; Tue, 18 Jun 2024 07:29:15 -0400
X-MC-Unique: byZ4hHRfNhytq8J6p958KA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4218447b900so29025815e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718710154; x=1719314954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QL2mCqxcTA/gR5pi/d5I9eeUirEcmK6GAkuaOzW5g9I=;
 b=Y4QA6mLIHtFF9rplvqQRrZEm2JDxrXD9TP4MM0FzsZzVj7gX+gOC7E/xmNXZS6U2Su
 FVBVa7JCmmvH5AW8XyxqmPx5QBLfu8cpuYfUMrg84Y0aQ8xvhlN0G4yBpboPyYZQYlQn
 NifHPh8zRrd0L4kbE7rly8aDIBTRpM0So4KEWToCpQ2FWnX1NrBY+88At/Rc5k0UMVHC
 5i5vcSXip/OAgEeKL85QOpbZDJcGcojQB0CSpsWFU3zhELKAOYfvbwQuaabnUMhqg2eN
 Bz75NP51XzJmKzX2NIuez24ZWjkTbVxW0grAbYSMAe12idKEuZDxe2/2GEObGapTzjCG
 QMHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHQo6MpSn21TzcOo+tPg2UDhkLorIUiQlMeXlu9uxmjV28Ji5qsdeKbZ3KGcP7ZeM0k/nn6aUYXDF6erPXw/OV07BFHEQ=
X-Gm-Message-State: AOJu0YxEpTYOnBI5PN1aTQdjobbS4hL31yu5vmEKCc/WVtpmx6UGgRDT
 vPvTkos1msxgCRYON+N0If6tztWVacHilnpLG4PBGolN0dzfVP7lJVV8rkkfROvuNbHzL1F7Kid
 pp66or3ykzx9KbNu37ykUnaiy/JeZdLrPlVMPz8DfuOLGVoawY+MJ
X-Received: by 2002:a05:600c:1793:b0:421:da70:461a with SMTP id
 5b1f17b1804b1-4246f5c596dmr23176115e9.17.1718710154039; 
 Tue, 18 Jun 2024 04:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo4w5P3mvnOyk89WWpCxXfFwW45fZhkPdM1OsPYkjhacupQ9/T3wu3omKhFf1JWdLneOtDRg==
X-Received: by 2002:a05:600c:1793:b0:421:da70:461a with SMTP id
 5b1f17b1804b1-4246f5c596dmr23175945e9.17.1718710153675; 
 Tue, 18 Jun 2024 04:29:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef9eesm224954005e9.9.2024.06.18.04.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:29:13 -0700 (PDT)
Message-ID: <b2fb8ca4-ddd2-4034-b2f9-cc52bfe1c63b@redhat.com>
Date: Tue, 18 Jun 2024 13:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] vfio/container: Simplify vfio_container_init()
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-7-clg@redhat.com>
 <fb3d29ca-6480-48fd-9e6b-4f90031d17ae@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <fb3d29ca-6480-48fd-9e6b-4f90031d17ae@redhat.com>
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

On 6/17/24 4:25 PM, Eric Auger wrote:
> Hi Cédric,
> 
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> Assign the base container VFIOAddressSpace 'space' pointer in
>> vfio_address_space_insert().
> 
> OK I get it now. Maybe in the previous patch, say that the
> 
> vfio_address_space_insert() will be enhanced with additional initializations.



> 
>>
>> To be noted that vfio_connect_container() will assign the 'space'
>> pointer later in the execution flow. This should not have any
>> consequence.
> 
> You do not explain the motivation of that change.

Changed to:

   Assign the base container VFIOAddressSpace 'space' pointer in
   vfio_address_space_insert(). The ultimate goal is to remove
   vfio_container_init() and instead rely on an .instance_init() handler
   to perfom the initialization of VFIOContainerBase.

   To be noted that vfio_connect_container() will assign the 'space'
   pointer later in the execution flow. This should not have any
   consequence.

Thanks,

C.



> 
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-container-base.h | 1 -
>>   hw/vfio/common.c                      | 1 +
>>   hw/vfio/container-base.c              | 3 +--
>>   hw/vfio/container.c                   | 6 +++---
>>   hw/vfio/iommufd.c                     | 2 +-
>>   5 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 442c0dfc4c1774753c239c2c8360dcd1540d44fa..d505f63607ec40e6aa44aeb3e20848ac780562a1 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -87,7 +87,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>   
>>   void vfio_container_init(VFIOContainerBase *bcontainer,
>> -                         VFIOAddressSpace *space,
>>                            const VFIOIOMMUClass *ops);
>>   void vfio_container_destroy(VFIOContainerBase *bcontainer);
>>   
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 8cdf26c6f5a490cfa02bdf1087a91948709aaa33..1686a0bed23bd95467bfb00a0c39a4d966e49cae 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1512,6 +1512,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>>                                  VFIOContainerBase *bcontainer)
>>   {
>>       QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> +    bcontainer->space = space;
>>   }
>>   
>>   struct vfio_device_info *vfio_get_device_info(int fd)
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 760d9d0622b2e847ecb3368c88df772efb06043f..280f0dd2db1fc3939fe9925ce00a2c50d0e14196 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -71,11 +71,10 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                                  errp);
>>   }
>>   
>> -void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
>> +void vfio_container_init(VFIOContainerBase *bcontainer,
>>                            const VFIOIOMMUClass *ops)
>>   {
>>       bcontainer->ops = ops;
>> -    bcontainer->space = space;
>>       bcontainer->error = NULL;
>>       bcontainer->dirty_pages_supported = false;
>>       bcontainer->dma_max_mappings = 0;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 0237c216987ff64a6d11bef8688bb000d93a7f09..dc85a79cb9e62b72312f79da994c53608b6cef48 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -394,7 +394,7 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
>>   }
>>   
>>   static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>> -                           VFIOAddressSpace *space, Error **errp)
>> +                           Error **errp)
>>   {
>>       int iommu_type;
>>       const VFIOIOMMUClass *vioc;
>> @@ -432,7 +432,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>>           return false;
>>       }
>>   
>> -    vfio_container_init(&container->bcontainer, space, vioc);
>> +    vfio_container_init(&container->bcontainer, vioc);
>>       return true;
>>   }
>>   
>> @@ -614,7 +614,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       container->fd = fd;
>>       bcontainer = &container->bcontainer;
>>   
>> -    if (!vfio_set_iommu(container, group->fd, space, errp)) {
>> +    if (!vfio_set_iommu(container, group->fd, errp)) {
>>           goto free_container_exit;
>>       }
>>   
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 9f8f33e383a38827ceca0f73cb77f5ca6b123198..e5d9334142418514215528b9523f12c031792c7f 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -357,7 +357,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>       container->ioas_id = ioas_id;
>>   
>>       bcontainer = &container->bcontainer;
>> -    vfio_container_init(bcontainer, space, iommufd_vioc);
>> +    vfio_container_init(bcontainer, iommufd_vioc);
>>       vfio_address_space_insert(space, bcontainer);
>>   
>>       if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
> Thanks
> 
> Eric
> 


