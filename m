Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F444CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqEBU-0006ns-R4; Fri, 29 Mar 2024 11:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rqEBT-0006nP-In
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rqEBR-0000HZ-Ed
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711726219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEqtB7OyRnnmmt6WC8PW1TkLuxa+qyb0HhiAv+WKWh4=;
 b=bygZ2FDarhRyD6Z1Hv8z8MAG8T6gfxk5CpYnKjsXnTDqCuGOf22eHHeyUxrodPfAqzgXya
 n74r5xp+IEGAjpP5p+zYSXbGTaY40DNbGPaRnWPwBpQQCCsDxD1KeFdJcojop5skchwMpq
 0FqU9ZFK4ugalEiImnw/T9ho/FuXpXc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Qgrr4w0IMvCt4rap1AiQzw-1; Fri, 29 Mar 2024 11:30:17 -0400
X-MC-Unique: Qgrr4w0IMvCt4rap1AiQzw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d6c145dfd4so15061371fa.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 08:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711726216; x=1712331016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEqtB7OyRnnmmt6WC8PW1TkLuxa+qyb0HhiAv+WKWh4=;
 b=PkwmtU7zTiDRUJChNIO1QI8fp3bX3NCuDQp+U6XXvYdDCAS2x6UEIo90VVGk7BVenG
 7b5KpK9b8MXaaBd/rpJdorNgsMdFaNAmWJFTcGjLPRj99khEgLzpCevm0f+LsF1hHVem
 dyJtnkcch2c8A36W1WdcVXrv9/QJuZFgVu/AVrgWvgvJk8TnjTVw0agPYpIruSY90Kwr
 LzbHVShUuhhFSo5/dbv3F1NEW53oucrOvJ2G5bL+57TzawFRj5hLz8bLhZw1e+1rtJZ7
 4sbTe45MTBfXQ3CYzR+eqafQGixvRVT3Upglk3FON7d3XG0Z8ds0e9zBEI0GDE/8CGlW
 emJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5ehR9j8NiaoQeV3cMgdh+FKtovD8U4erldUc/eBozGOKAj7qX+678G1M6e1MKZf+Mov5WALbT32UUAE2IeO/lNKdVGlo=
X-Gm-Message-State: AOJu0YxXS2CO7wD8zU4afs0l7jeZfOXOJunrwVJk2OAVsLLCbZ0RmhLq
 kgt0Xnfcg6c0sidjaL2AItxK0YLl+hEBDFoBFPOY0UgKTTTTjABy2sWDXQcHVCL8FkAhDI40v+b
 hFlG7+SnYCt+neUk2ZlzqySghh92g5PMfwefhq4r5Z6d3CXx9SpMM
X-Received: by 2002:a05:651c:1a28:b0:2d7:18b0:4d5 with SMTP id
 by40-20020a05651c1a2800b002d718b004d5mr1432167ljb.8.1711726215914; 
 Fri, 29 Mar 2024 08:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzpmuAS8jC1lxTzKloesh1TVAnsDzlVtL2tcAT2t0F4k0zNfncevtpVTI9ASzA02klX7lo2w==
X-Received: by 2002:a05:651c:1a28:b0:2d7:18b0:4d5 with SMTP id
 by40-20020a05651c1a2800b002d718b004d5mr1432149ljb.8.1711726215495; 
 Fri, 29 Mar 2024 08:30:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bg3-20020a05600c3c8300b0041481207b23sm5822748wmb.8.2024.03.29.08.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 08:30:14 -0700 (PDT)
Message-ID: <f23012d9-5b63-43c2-9530-31cddf484fcb@redhat.com>
Date: Fri, 29 Mar 2024 16:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
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
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
 <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <41d50645-9f81-40b1-9ca5-7bb2e73d90de@redhat.com>
 <SJ0PR11MB6744F798CF55CC8FF230CE7B923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744F798CF55CC8FF230CE7B923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Hello Zhenzhong,

On 3/28/24 04:06, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
>> HostIOMMUDevice
>>
>> Hello Zhenzhong,
>>
>> On 3/19/24 12:58, Duan, Zhenzhong wrote:
>>> Hi Cédric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Sent: Tuesday, March 19, 2024 4:17 PM
>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-
>>>> devel@nongnu.org
>>>> Cc: alex.williamson@redhat.com; eric.auger@redhat.com;
>>>> peterx@redhat.com; jasowang@redhat.com; mst@redhat.com;
>>>> jgg@nvidia.com; nicolinc@nvidia.com; joao.m.martins@oracle.com; Tian,
>>>> Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Sun, Yi Y
>>>> <yi.y.sun@intel.com>; Peng, Chao P <chao.p.peng@intel.com>
>>>> Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
>>>> HostIOMMUDevice
>>>>
>>>> Hello Zhenzhong,
>>>>
>>>> On 2/28/24 04:58, Zhenzhong Duan wrote:
>>>>> HostIOMMUDevice will be inherited by two sub classes,
>>>>> legacy and iommufd currently.
>>>>>
>>>>> Introduce a helper function host_iommu_base_device_init to initialize it.
>>>>>
>>>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>     include/sysemu/host_iommu_device.h | 22
>> ++++++++++++++++++++++
>>>>>     1 file changed, 22 insertions(+)
>>>>>     create mode 100644 include/sysemu/host_iommu_device.h
>>>>>
>>>>> diff --git a/include/sysemu/host_iommu_device.h
>>>> b/include/sysemu/host_iommu_device.h
>>>>> new file mode 100644
>>>>> index 0000000000..fe80ab25fb
>>>>> --- /dev/null
>>>>> +++ b/include/sysemu/host_iommu_device.h
>>>>> @@ -0,0 +1,22 @@
>>>>> +#ifndef HOST_IOMMU_DEVICE_H
>>>>> +#define HOST_IOMMU_DEVICE_H
>>>>> +
>>>>> +typedef enum HostIOMMUDevice_Type {
>>>>> +    HID_LEGACY,
>>>>> +    HID_IOMMUFD,
>>>>> +    HID_MAX,
>>>>> +} HostIOMMUDevice_Type;
>>>>> +
>>>>> +typedef struct HostIOMMUDevice {
>>>>> +    HostIOMMUDevice_Type type;
>>>>
>>>> A type field is not a good sign and that's where QOM is useful.
>>>
>>> Yes, agree.
>>> I didn't choose QOM because in iommufd-cdev series, VFIOContainer
>> chooses not using QOM model.
>>> See the discussion:
>> https://lore.kernel.org/all/YmuFv2s5TPuw7K%2Fu@yekko/
>>> I thought HostIOMMUDevice need to follow same rule.
>>>
>>> But after further digging into this, I think it may be ok to use QOM model
>> as long as we don't expose
>>> HostIOMMUDevice in qapi/qom.json and not use USER_CREATABLE
>> interface. Your thoughts?
>>
>> yes. Can we change a bit this series to use QOM ? something like :
>>
>>      typedef struct HostIOMMUDevice {
>>          Object parent;
>>      } HostIOMMUDevice;
>>
>>      #define TYPE_HOST_IOMMU "host.iommu"
>>      OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUClass,
>> HOST_IOMMU)
>>
>>      struct HostIOMMUClass {
>>          ObjectClass parent_class;
>>
>>          int (*get_type)(HostIOMMUDevice *hiod, uint64_t *type, Error **errp);
>>          int (*get_cap)(HostIOMMUDevice *hiod, uint64_t *cap, Error **errp);
>>      };
>>
>> Inherited objects would be TYPE_HOST_IOMMU_IOMMUFD and
>> TYPE_HOST_IOMMU_LEGACY.
>> Each class implementing the handlers or not (legacy mode).
> 
> Understood, thanks for your guide.
> 
>>
>> The class handlers are introduced for the intel-iommu helper
>> vtd_check_hdev()
>> in order to avoid using iommufd routines directly. HostIOMMUDevice is
>> supposed
>> to abstract the Host IOMMU device, so we need to abstract also all the
>> interfaces to this object.
> 
> I'd like to have a minimal adjustment to class handers. Just let me know if you have strong
> preference.
> 
> Cap/ecap is intel_iommu specific, I'd like to make it a bit generic also for arm smmu usage,
> and merge get_type and get_cap into one function as they both calls ioctl(IOMMU_GET_HW_INFO),
> something like:
> get_info(HostIOMMUDevice *hiod, enum iommu_hw_info_type *type, void **data, void **len,  Error **errp);

OK. Let's see how it goes. Having more users of this new object Host
IOMMU device is important to get a better feeling of the interface.
As of today, it doesn't have not much value. The iommufd object could
be QOM linked to the vIOMMU when available and we could get the bind
devid in some other ways I suppose. Anyhow, please keep it simple and
let's explore.

Thanks,

C.



> 
> and let iommu emulater to extract content of *data. For intel_iommu, it's:
> 
> struct iommu_hw_info_vtd {
>          __u32 flags;
>          __u32 __reserved;
>          __aligned_u64 cap_reg;
>          __aligned_u64 ecap_reg;
> };
> 
>>
>> The .host_iommu_device_create() handler could be merged
>> in .attach_device()
>> possibly. Anyhow, please use now object_new() and object_unref() instead.
>> host_iommu_base_device_init() is useless IMHO.
> 
> Good idea, will do.
> 
>>
>>>
>>>>
>>>> Is vtd_check_hdev() the only use of this field ?
>>>
>>> Currently yes. virtio-iommu may have similar usage.
>>>
>>>> If so, can we simplify with a QOM interface in any way ?
>>>
>>> QOM interface is a set of callbacks, guess you mean QOM class,
>>> saying HostIOMMUDevice class, IOMMULegacyDevice class and
>> IOMMUFDDevice class?
>>
>> See above proposal. it should work fine.
>>
>> Also, I think it is better to use a IOMMUFDBackend* parameter for
>> iommufd_device_get_info() to be consistent with the other routines.
> 
> Sure, then I'd like to also rename it to iommufd_backend_get_device_info().
> 
> Thanks
> Zhenzhong
> 
>>
>> Then It would interesting to see how this applies to Eric's series.
>>
>> Thanks,
>>
>> C.
>>
>>
> 


