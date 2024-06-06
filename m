Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE2C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9Tx-0007ha-Vj; Thu, 06 Jun 2024 05:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sF9Tw-0007h6-2D
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sF9Tt-0006ms-MX
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717666344;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkoWWMbFlbcl6ZU7QmZoRoLJByfNHv3QN21i9Ho6vHg=;
 b=fv/pYru2G7ph0T/dQCbyXbTGxDc5I6c/C8vT64YliCIv0+PR5vi9KbcMf+46d9KfJIA6Fg
 zTiimzxl8EJ0Sadz4LhCVaojdESN/8Tv/T58uUIjTZ+8cEn1H47SNPf9fi3eiwQhElhCwe
 POtHlwrdUITQd8BkLPWYc+CS/nrGPJo=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-t7ZeD0cvNAuFEudI7wUCQA-1; Thu, 06 Jun 2024 05:32:23 -0400
X-MC-Unique: t7ZeD0cvNAuFEudI7wUCQA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-df7bdb0455bso1217330276.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717666342; x=1718271142;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nkoWWMbFlbcl6ZU7QmZoRoLJByfNHv3QN21i9Ho6vHg=;
 b=wa//SPXdER50E49KDbALbA/9nFoLlIWfGc61W815sdUqj6WdzNDfinZhHGWJzWSyux
 CKDxiwdCHEEMKVEGPXgyNx99vd7BMzUsIJOD9Or5akrz927hkB0ENzklyxKQyX05Sen1
 R8q6r+f3tafnwZTJTlKY5x9VRiHIU1vw7Zo6EZ25dqAGF9lGYBxPuvJ2fVt5+mPAVg6l
 DrRgUP8sHDMgOy0zhFnYInQDflEVZGzoAoPXufYj34tQTsB7NqDC0LyAnnXdA7gJiux9
 fDUUTz2kwA22SzXNRejc8NRCMsFc/WcTzSf6naoghwdj7vVkTbeE5ikecIq21/FVNfT6
 GQIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfc3L79pBwMy55XL9M8e8FMEQ7mgfUq94VRy2N/L7DUrc1XJiM464p/YecDp/NpahCtXpEv/NGgO5YQdyDWRTBsfDCWX4=
X-Gm-Message-State: AOJu0Yz7jd3UaW9d68oUjwE3GTyCaga/HxXgzx6X9BIaADiL4npsdhzX
 OckVYP9ECttYOWHA5e/A+eK29qYzw5d76qbJGVg5LI8Zrx/tGXf5GRk4p0tItZKxtK6eC4gCCjX
 +S7Gq2J5VeeoRyTApu3dUhG0pvX0NgiCUI+kIPs4qFi6Xt4Tw1F98
X-Received: by 2002:a05:6902:2503:b0:de5:9d13:591b with SMTP id
 3f1490d57ef6-dfacac5f766mr5481556276.32.1717666342628; 
 Thu, 06 Jun 2024 02:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVS6VEHyhGnA9lyMdbUyrwqWaUmMyFU/wUONS1qnJ4UTy2Pa00ArWtfsaSbon8RHbxv0lYnA==
X-Received: by 2002:a05:6902:2503:b0:de5:9d13:591b with SMTP id
 3f1490d57ef6-dfacac5f766mr5481528276.32.1717666342247; 
 Thu, 06 Jun 2024 02:32:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44038b5ee9fsm3355761cf.82.2024.06.06.02.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:32:21 -0700 (PDT)
Message-ID: <48775516-3c3f-4c1d-a573-cf6649a66aa8@redhat.com>
Date: Thu, 6 Jun 2024 11:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <09ba18e0-9d91-4e04-b291-0412d00a108d@redhat.com>
In-Reply-To: <09ba18e0-9d91-4e04-b291-0412d00a108d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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



On 6/6/24 11:26, Eric Auger wrote:
> Hi Zhenzhong,
> On 6/3/24 08:10, Zhenzhong Duan wrote:
>> It calls iommufd_backend_get_device_info() to get host IOMMU
>> related information and translate it into HostIOMMUDeviceCaps
>> for query with .get_cap().
>>
>> Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
>> (aw_bits - 1).
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/i386/intel_iommu.h |  1 +
>>  hw/vfio/iommufd.c             | 37 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index 7fa0a695c8..7d694b0813 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
>>  #define VTD_HOST_AW_48BIT           48
>>  #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
>>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>> +#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
>>  
>>  #define DMAR_REPORT_F_INTR          (1)
>>  
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index e4a507d55c..9d2e95e20e 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/chardev_open.h"
>>  #include "pci.h"
>> +#include "hw/i386/intel_iommu_internal.h"
>>  
>>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                              ram_addr_t size, void *vaddr, bool readonly)
>> @@ -619,6 +620,41 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>  };
>>  
>> +static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>> +                                      Error **errp)
>> +{
>> +    VFIODevice *vdev = opaque;
> I think it would make sense to store vdev in hiod. This would allow to
> postpone some computations in the HostIOMMUDevice ops instead of doing
> everything in the realize.
> For instance to retrieve the usable iova_ranges I will need to access
> the base container in the associated ops.

this would need to be opaque since the agent device can be either
VFIODevice or VDPA object though

Eric
> 
> Thanks
> 
> Eric
>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>> +    enum iommu_hw_info_type type;
>> +    union {
>> +        struct iommu_hw_info_vtd vtd;
>> +    } data;
>> +
>> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>> +                                         &type, &data, sizeof(data), errp)) {
>> +        return false;
>> +    }
>> +
>> +    caps->type = type;
>> +
>> +    switch (type) {
>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>> +        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
>> +        break;
>> +    case IOMMU_HW_INFO_TYPE_NONE:
>> +        break;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>> +{
>> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>> +
>> +    hiodc->realize = hiod_iommufd_vfio_realize;
>> +};
>> +
>>  static const TypeInfo types[] = {
>>      {
>>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
>> @@ -627,6 +663,7 @@ static const TypeInfo types[] = {
>>      }, {
>>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>>          .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>> +        .class_init = hiod_iommufd_vfio_class_init,
>>      }
>>  };
>>  
> 


