Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D72C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 12:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHjSk-0001hx-D2; Thu, 13 Jun 2024 08:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHjSi-0001hW-LE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHjSg-00066y-NC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718281309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rPaBg7HWVPZeRtnZ++AvQKlgIgzKeTurzZpcdtelKw=;
 b=co6Uv3TtRUtz1RtIKORCdj777SJ3BzzrC4pNol3Af/IJHFee5samOD0RZTKLcA43+IxcFz
 FqeZTycdv076ycotr8mBTAZ0aTUzZY/mtIlc/W/1w9UufH7EFX7KCp5oK5p/U3VDHycOdM
 BqcwIvWeOHysoW72IK0gLcmM+iLC1d0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-E3U_utRINMekBfJNvGrULw-1; Thu, 13 Jun 2024 08:21:47 -0400
X-MC-Unique: E3U_utRINMekBfJNvGrULw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f27bfa618so499017f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 05:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718281306; x=1718886106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rPaBg7HWVPZeRtnZ++AvQKlgIgzKeTurzZpcdtelKw=;
 b=V4UqIBQJ0hwQxMeAu3qCM7pLivB93aZ2VOfDvNG7C8glFLzC4IUMshBnPicuvbx8f2
 Z6fFxA+yMPU2H+A3jtXPOq5ayc3urPRGwER88/Z75SH6x7WWPDrxUhD25evyj+Hopr9X
 h0MvlU2VOfXJcvnZZCkpj810jeEs6aIiPostIbRa4WeNPDCTpfu7HfnT13wJEGRBlrzJ
 dJr7ZD+TEpRnxlGzoG9Ion+nydsuy4qRIjIEbpfXaHTFjVo3E56204JzXeSvJkIKqRf6
 POf4HgVU4SZAPnuNp1y4DhzPlVxLdhRmXPY3CKczflurYEIvOfYZZiunBE1B31fBixPF
 1Pog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz067FKBuxwCjDWlY4QKsUgPtDw14gPolSIlYLy2Ms0s76FyyXAwFJL9L93fC/V6lghkX6iDIue6Etg4vbMIVbI7lfCE0=
X-Gm-Message-State: AOJu0Yz/IwZ+yk64MqLmhnhhxWfn5NcN3aNSTUEguEuwKcdsUBaEIv8K
 fBJSI/tB0kjt5Yfp7g9+8krCtv8XcBYKDudGhFrHFUamdTVabAiy7VM+6c/bCiom15amnJFNTLe
 IxUQ33TOuOdhRe/3D/kRXqXMK4mL2vkXL6tWepMVvIQ5bk6VP69EO
X-Received: by 2002:adf:e70f:0:b0:35f:2635:5b82 with SMTP id
 ffacd0b85a97d-35fe8937a66mr3480344f8f.59.1718281306665; 
 Thu, 13 Jun 2024 05:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHss+MmvB6ZGe+17ItJ5nmRALNeRwl5q1hOCuNEl4VX9rNCdLfmTkgmChXRHOoMIU/4wQKg==
X-Received: by 2002:adf:e70f:0:b0:35f:2635:5b82 with SMTP id
 ffacd0b85a97d-35fe8937a66mr3480323f8f.59.1718281306236; 
 Thu, 13 Jun 2024 05:21:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b8bsm1624444f8f.105.2024.06.13.05.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 05:21:45 -0700 (PDT)
Message-ID: <d07b9b63-2a51-4af8-8dc1-58484ac934a4@redhat.com>
Date: Thu, 13 Jun 2024 14:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/16] vfio/container: Change VFIOContainerBase to use
 QOM
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
 <20240612130122.813935-12-clg@redhat.com>
 <SJ0PR11MB674436CD599BAA3FC4AD082892C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674436CD599BAA3FC4AD082892C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On 6/13/24 11:17 AM, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH v1 11/16] vfio/container: Change VFIOContainerBase to use
>> QOM
>>
>> VFIOContainerBase was made a QOM interface because we believed that a
>> QOM object would expose all the IOMMU backends to the QEMU machine
>> and
>> human interface. This only applies to user creatable devices or objects.
>>
>> Change the VFIOContainerBase nature from interface to object and make
>> the necessary adjustments in the VFIO_IOMMU hierarchy.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-common.h         |  4 ++++
>> include/hw/vfio/vfio-container-base.h | 12 +++---------
>> hw/vfio/container-base.c              |  4 +++-
>> hw/vfio/container.c                   |  1 +
>> hw/vfio/iommufd.c                     |  1 +
>> hw/vfio/spapr.c                       |  3 +++
>> 6 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index
>> 825d80130bd435fe50830c8ae5b7905d18104dd6..5d0b8496cf85bac8d4ea
>> 770fae04acc02d84df82 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -84,6 +84,8 @@ typedef struct VFIOContainer {
>>      QLIST_HEAD(, VFIOGroup) group_list;
>> } VFIOContainer;
>>
>> +OBJECT_DECLARE_TYPE(VFIOContainer, VFIOIOMMUClass,
>> VFIO_IOMMU_LEGACY);
> 
> What about using OBJECT_DECLARE_SIMPLE_TYPE?

Sure. Will change.

Thanks,

C.


> 
>> +
>> typedef struct VFIOHostDMAWindow {
>>      hwaddr min_iova;
>>      hwaddr max_iova;
>> @@ -99,6 +101,8 @@ typedef struct VFIOIOMMUFDContainer {
>>      uint32_t ioas_id;
>> } VFIOIOMMUFDContainer;
>>
>> +OBJECT_DECLARE_TYPE(VFIOIOMMUFDContainer, VFIOIOMMUClass,
>> VFIO_IOMMU_IOMMUFD);
> 
> Same here.
> 
>> +
>> typedef struct VFIODeviceOps VFIODeviceOps;
>>
>> typedef struct VFIODevice {
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> d505f63607ec40e6aa44aeb3e20848ac780562a1..b079b76f68975c5701a28
>> 9ce9012e912a8e44fc6 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -34,6 +34,7 @@ typedef struct VFIOAddressSpace {
>>   * This is the base object for vfio container backends
>>   */
>> typedef struct VFIOContainerBase {
>> +    Object parent;
>>      const VFIOIOMMUClass *ops;
>>      VFIOAddressSpace *space;
>>      MemoryListener listener;
>> @@ -96,17 +97,10 @@ void vfio_container_destroy(VFIOContainerBase
>> *bcontainer);
>> #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>> #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
>>
>> -/*
>> - * VFIOContainerBase is not an abstract QOM object because it felt
>> - * unnecessary to expose all the IOMMU backends to the QEMU machine
>> - * and human interface. However, we can still abstract the IOMMU
>> - * backend handlers using a QOM interface class. This provides more
>> - * flexibility when referencing the various implementations.
>> - */
>> -DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU,
>> TYPE_VFIO_IOMMU)
>> +OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass,
>> VFIO_IOMMU)
>>
>> struct VFIOIOMMUClass {
>> -    InterfaceClass parent_class;
>> +    ObjectClass parent_class;
>>
>>      /* Properties */
>>      const char *hiod_typename;
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index
>> 280f0dd2db1fc3939fe9925ce00a2c50d0e14196..98c15e174dd78df5146ee8
>> 3c05c98f3ea9c1e52c 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -102,8 +102,10 @@ void vfio_container_destroy(VFIOContainerBase
>> *bcontainer)
>> static const TypeInfo types[] = {
>>      {
>>          .name = TYPE_VFIO_IOMMU,
>> -        .parent = TYPE_INTERFACE,
>> +        .parent = TYPE_OBJECT,
>> +        .instance_size = sizeof(VFIOContainerBase),
>>          .class_size = sizeof(VFIOIOMMUClass),
>> +        .abstract = true,
>>      },
>> };
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> 983726f9514ec1106d521c9711a46a4780688ee1..f1519518d0b7efd2a6086
>> f07bc497596a5236abf 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1194,6 +1194,7 @@ static const TypeInfo types[] = {
>>      {
>>          .name = TYPE_VFIO_IOMMU_LEGACY,
>>          .parent = TYPE_VFIO_IOMMU,
>> +        .instance_size = sizeof(VFIOContainer),
>>          .class_init = vfio_iommu_legacy_class_init,
>>      }, {
>>          .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index
>> d97a4f7393791660b90e340436c6e084c0781444..80ba09b859a02bb89823
>> 460064a9f099fd98cff0 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -670,6 +670,7 @@ static const TypeInfo types[] = {
>>      {
>>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
>>          .parent = TYPE_VFIO_IOMMU,
>> +        .instance_size = sizeof(VFIOIOMMUFDContainer),
>>          .class_init = vfio_iommu_iommufd_class_init,
>>      }, {
>>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index
>> 47b040f1bcca7dd0b5cf052d941b43541e98a3c5..05a3cedc4b1703a615737
>> 30bc77fc15d44f7a9eb 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -30,6 +30,8 @@ typedef struct VFIOSpaprContainer {
>>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>> } VFIOSpaprContainer;
>>
>> +OBJECT_DECLARE_TYPE(VFIOSpaprContainer, VFIOIOMMUClass,
>> VFIO_IOMMU_SPAPR);
>
> Same here.
> 
> Thanks
> Zhenzhong
> 
>> +
>> static bool vfio_prereg_listener_skipped_section(MemoryRegionSection
>> *section)
>> {
>>      if (memory_region_is_iommu(section->mr)) {
>> @@ -548,6 +550,7 @@ static const TypeInfo types[] = {
>>      {
>>          .name = TYPE_VFIO_IOMMU_SPAPR,
>>          .parent = TYPE_VFIO_IOMMU_LEGACY,
>> +        .instance_size = sizeof(VFIOSpaprContainer),
>>          .class_init = vfio_iommu_spapr_class_init,
>>      },
>> };
>> --
>> 2.45.2
> 


