Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD0FC04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjG5-0002OH-Ry; Tue, 16 Apr 2024 09:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwjFu-00027E-Lo
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwjFo-0001nC-Dv
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713275622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SruzmuCz9ab5PjZSebP+Here1pfTlCM8lvBkspnwglU=;
 b=LXbFQG/RzHpR1bKlDvnL/zjIUfvSGWk31iKyVn45VPw2NZ6V9XW96rc0Si9lfQeChvsRbX
 /hyi7fW+Muh1UdKbsuqlY0M64Uj7NooQioLzCqBuW6S3w1Q1CSYTv63YDp7UuvT3LFZBbh
 E0/74loh6CCqA4acmS12r4qN1TF8dXs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-pk3_wOLeO26wPIxw5t2Ukg-1; Tue, 16 Apr 2024 09:53:41 -0400
X-MC-Unique: pk3_wOLeO26wPIxw5t2Ukg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69b81cb0865so20780836d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275620; x=1713880420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SruzmuCz9ab5PjZSebP+Here1pfTlCM8lvBkspnwglU=;
 b=NlEGUlzbfbUPZbr+aVmagWG3MMg51oaV5UPTB+CX9POU5OqqlyOv+QPhiJjeQzLoA+
 lQKxHKnZRdMbvJgYj6huqs1+oIOMxzYBZuhv+4mT63R3+eZP2lGb0kzv2GqmBupDJP4M
 6GV8Vr/0osFpmpsu1oy0kM0kWEJmekboJVzq9yf3L64wmPMIvy0rM53tf44r1O3gdeKL
 qah+c+ekwwCArmY5J/eXTcCuXfAe6EI6DRm9A9vx+wjqkjm/ZmwMkepvrzR9fBarqHXq
 K1Oh7AwU/pfZOHg0tU+5bRoPPrNakuIk9Bz5Yp26+PLRQoKoFUnjGcxdQ6San1Es9M3k
 IdCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmGZusSmk7f3yiiFJgySxbeQAdlRLAGromSkxP5qHDIzycd3aNaebPsC8ek0/DzlkAc0HQOR+PuCuCdXTM2BefEOsrRt0=
X-Gm-Message-State: AOJu0YxorZEOO9O0Vq2Z95zG1DCx8bFkGdVxUBJJNmKKZbFsbvCYhbTb
 BGyppqjuyMg/uHeYe4e4ReCDxABOO7f3jpxzEHdbO3UtOCa7XmE8mJOul/BSvXcymhOqHWrKqQO
 j0g5PG0wNPSO0DzV8RIcr3xUKV5dvFmkErT+0kf+vZ6UX6WGMTxuB
X-Received: by 2002:a05:6214:3b81:b0:699:2e62:4115 with SMTP id
 nf1-20020a0562143b8100b006992e624115mr14887536qvb.23.1713275620733; 
 Tue, 16 Apr 2024 06:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIEs99b1QgHzDks/nNVLwSsN+sq5sNORYehypergDTw6JjnAR7gKLiZ1AfrrKX4rbJirjTQ==
X-Received: by 2002:a05:6214:3b81:b0:699:2e62:4115 with SMTP id
 nf1-20020a0562143b8100b006992e624115mr14887514qvb.23.1713275620357; 
 Tue, 16 Apr 2024 06:53:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 d7-20020ad450a7000000b0069b26d7f061sm7427889qvq.99.2024.04.16.06.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:53:39 -0700 (PDT)
Message-ID: <a46d4d57-0d6c-4ba3-887b-bc167a25434a@redhat.com>
Date: Tue, 16 Apr 2024 15:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9869ac57-56c6-41b7-a2c6-d42a5ba475ee@redhat.com>
 <SJ0PR11MB67448DE106AEE894D080D3F492082@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67448DE106AEE894D080D3F492082@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hello,

On 4/16/24 05:41, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
>>
>> On 4/8/24 10:12, Zhenzhong Duan wrote:
>>> HIODLegacyVFIO represents a host IOMMU device under VFIO legacy
>>> container backend.
>>>
>>> It includes a link to VFIODevice.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h | 11 +++++++++++
>>>    hw/vfio/container.c           | 11 ++++++++++-
>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index b9da6c08ef..f30772f534 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -31,6 +31,7 @@
>>>    #endif
>>>    #include "sysemu/sysemu.h"
>>>    #include "hw/vfio/vfio-container-base.h"
>>> +#include "sysemu/host_iommu_device.h"
>>>
>>>    #define VFIO_MSG_PREFIX "vfio %s: "
>>>
>>> @@ -147,6 +148,16 @@ typedef struct VFIOGroup {
>>>        bool ram_block_discard_allowed;
>>>    } VFIOGroup;
>>>
>>> +#define TYPE_HIOD_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-
>> vfio"
>>
>> I would prefer to keep the prefix TYPE_HOST_IOMMU_DEVICE.
> 
> Will do.
> 
>>
>>> +OBJECT_DECLARE_SIMPLE_TYPE(HIODLegacyVFIO, HIOD_LEGACY_VFIO)
>>> +
>>> +/* Abstraction of VFIO legacy host IOMMU device */
>>> +struct HIODLegacyVFIO {
>>
>> same here
> 
> Should I do the same for all the HostIOMMUDevice and HostIOMMUDeviceClass sub-structures?

I would for type names. The main reason is for naming consistency, which is
useful for grep and code analysis.

> 
> The reason I used 'HIOD' abbreviation is some function names become extremely long
> and exceed 80 characters. E.g.:
> 
> @@ -1148,9 +1148,9 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>       vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>   };
> 
> -static int hiod_legacy_vfio_get_host_iommu_info(HostIOMMUDevice *hiod,
> -                                                void *data, uint32_t len,
> -                                                Error **errp)
> +static int host_iommu_device_legacy_vfio_get_host_iommu_info(HostIOMMUDevice *hiod,
> +                                                             void *data, uint32_t len,
> +                                                             Error **errp)
>   {
>       VFIODevice *vbasedev = HIOD_LEGACY_VFIO(hiod)->vdev;
>       /* iova_ranges is a sorted list */
> @@ -1173,7 +1173,7 @@ static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>   {
>       HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> 
> -    hioc->get_host_iommu_info = hiod_legacy_vfio_get_host_iommu_info;
> +    hioc->get_host_iommu_info = host_iommu_device_legacy_vfio_get_host_iommu_info;
>   };
> 
> I didn't find other way to make it meet the 80 chars limitation. Any suggestions on this?

Try :

@@ -1177,7 +1177,8 @@ static void hiod_legacy_vfio_class_init(
  {
      HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
  
-    hioc->get_host_iommu_info = hiod_legacy_vfio_get_host_iommu_info;
+    hioc->get_host_iommu_info =
+        host_iommu_device_legacy_vfio_get_host_iommu_info;
  };
  
  static const TypeInfo types[] = {

That said, I agree that 'host_iommu_device_legacy_vfio' routine prefix
could be shortened to 'hiod_legacy_vfio'.


Thanks,

C.



> 
>>
>>> +    /*< private >*/
>>> +    HostIOMMUDevice parent;
>>> +    VFIODevice *vdev;
>>
>> It seems to me that the back pointer should be on the container instead.
>> Looks more correct conceptually.
> 
> Yes, that makes sense for legacy VFIO, as iova_ranges, pgsizes etc are all saved in bcontainer.
> 
>>
>>
>>> +};
>>> +
>>>    typedef struct VFIODMABuf {
>>>        QemuDmaBuf buf;
>>>        uint32_t pos_x, pos_y, pos_updates;
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 77bdec276e..44018ef085 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -1143,12 +1143,21 @@ static void
>> vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>>>        vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>>>    };
>>>
>>> +static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +};
>>
>> Is it preferable to introduce routines when they are actually useful.
>> Please drop the .class_init definition.
> 
> Sure.
> 
> Thanks
> Zhenzhong
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>> +
>>>    static const TypeInfo types[] = {
>>>        {
>>>            .name = TYPE_VFIO_IOMMU_LEGACY,
>>>            .parent = TYPE_VFIO_IOMMU,
>>>            .class_init = vfio_iommu_legacy_class_init,
>>> -    },
>>> +    }, {
>>> +        .name = TYPE_HIOD_LEGACY_VFIO,
>>> +        .parent = TYPE_HOST_IOMMU_DEVICE,
>>> +        .instance_size = sizeof(HIODLegacyVFIO),
>>> +        .class_init = hiod_legacy_vfio_class_init,
>>> +    }
>>>    };
>>>
>>>    DEFINE_TYPES(types)
> 


