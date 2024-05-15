Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE6BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HUJ-0007fY-50; Wed, 15 May 2024 12:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HUG-0007fB-J7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7HUE-0002Af-Pc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715790493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNPAp2jQ4Hox/+G1WaD0mBQq2fbmFwBTpixtfoNPcd4=;
 b=BHfseDBmo6GQkbbGWoLC/pACUabKZ85kLVMMvtdtl6YVpApS3tNePXFki843ndNPIggZ9I
 Bg2ywRIG+jmt969iNIucce2FuNOFjBnnylguY+jc/9aXnWE5IQvIYbP2czP2oBu9D3z7sG
 n8MhVNUslVEvtTgAoQhf3DEwKrJ7mAw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-7M1UgawhO4ekgIhiGy8pXQ-1; Wed, 15 May 2024 12:28:11 -0400
X-MC-Unique: 7M1UgawhO4ekgIhiGy8pXQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792e7b1d6a7so349819785a.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715790491; x=1716395291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNPAp2jQ4Hox/+G1WaD0mBQq2fbmFwBTpixtfoNPcd4=;
 b=TxQzOV2nK5oBQM5UuLhsNacEeP5wCLpiieHpi/8dUu9/hN9L5mqetM8AV6F90ykW4C
 bl5iNUTgJPsGTGpFqH2cP7hp9WeE/QM1EGeTdH1N03oI5aeeW84kHz0nqgODpnmM6UkB
 hh1DkQbpdX9724ZvYui6ckgMEg7wQHD7i6+xdrIP3tt2NcJKSi3oOGqKORq/lpcjD8KI
 8rvreAVZDznkPKeup17n0Q/lfuP0Xrnw5z3ltnk7Xpe0Xwrjo4C1b2HVAF0vfLT6eVYz
 EoNB7LYxp3bskExiYTFGwMfV+wZquOT3MNpgnl3Mb2uhuxVaAOQAaooLVA+ckdMMPj+M
 rzcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG1zBYAIv+1WsbUIX2BRjTy3yjAiOkJtjQBXDY9+aVdmFDJdtTCeutb9LpEbMRD8bXXFcIyexlVLhzOP7nptmmkxfxamo=
X-Gm-Message-State: AOJu0Yy2R6kArBUh+pC3NC4rvGD92tXuGRG7hVLlseigm1IA8BWe8Hms
 11bEnut2ubjoS+Y9qb8G3MEF0CNFTjlcit4S8ZZhCJ79c67weL5ulbopfkFTZescrj9HyRjDnYP
 WUTwdBUJ7YNvf04MHm9pqeu5vyEziOGoNlIx23EP8R6uXlGBEBlqw
X-Received: by 2002:a05:620a:2693:b0:792:bd20:422b with SMTP id
 af79cd13be357-792c759ae06mr2101164685a.26.1715790490686; 
 Wed, 15 May 2024 09:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi1R9h4HGbDHeldrj4UgknDGJKSoyhxpWlwvXARfMaB18PCBYDURorBDpTATJUxJo7K0OzOw==
X-Received: by 2002:a05:620a:2693:b0:792:bd20:422b with SMTP id
 af79cd13be357-792c759ae06mr2101162285a.26.1715790490336; 
 Wed, 15 May 2024 09:28:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e19256258sm42068441cf.49.2024.05.15.09.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:28:09 -0700 (PDT)
Message-ID: <d2f7fa18-a27d-454a-955f-f512be6e0d86@redhat.com>
Date: Wed, 15 May 2024 18:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] vfio: Make VFIOIOMMUClass::attach_device() and
 its wrapper return bool
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-4-zhenzhong.duan@intel.com>
 <a41fe2df-62dd-4d65-ba00-45ca888dedbf@redhat.com>
 <SJ0PR11MB67441AFCCDC343645A408B3192E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67441AFCCDC343645A408B3192E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On 5/7/24 09:34, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 03/11] vfio: Make VFIOIOMMUClass::attach_device()
>> and its wrapper return bool
>>
>> On 5/7/24 08:42, Zhenzhong Duan wrote:
>>> Make VFIOIOMMUClass::attach_device() and its wrapper function
>>> vfio_attach_device() return bool.
>>>
>>> This is to follow the coding standand to return bool if 'Error **'
>>> is used to pass error.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h         |  4 ++--
>>>    include/hw/vfio/vfio-container-base.h |  4 ++--
>>>    hw/vfio/ap.c                          |  6 ++----
>>>    hw/vfio/ccw.c                         |  6 ++----
>>>    hw/vfio/common.c                      |  4 ++--
>>>    hw/vfio/container.c                   | 14 +++++++-------
>>>    hw/vfio/iommufd.c                     | 11 +++++------
>>>    hw/vfio/pci.c                         |  5 ++---
>>>    hw/vfio/platform.c                    |  7 +++----
>>>    9 files changed, 27 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index b9da6c08ef..a7b6fc8f46 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -198,8 +198,8 @@ void vfio_region_exit(VFIORegion *region);
>>>    void vfio_region_finalize(VFIORegion *region);
>>>    void vfio_reset_handler(void *opaque);
>>>    struct vfio_device_info *vfio_get_device_info(int fd);
>>> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> -                       AddressSpace *as, Error **errp);
>>> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                        AddressSpace *as, Error **errp);
>>>    void vfio_detach_device(VFIODevice *vbasedev);
>>>
>>>    int vfio_kvm_device_add_fd(int fd, Error **errp);
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> index 3582d5f97a..c839cfd9cb 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -118,8 +118,8 @@ struct VFIOIOMMUClass {
>>>        int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>>>                         hwaddr iova, ram_addr_t size,
>>>                         IOMMUTLBEntry *iotlb);
>>> -    int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>> -                         AddressSpace *as, Error **errp);
>>> +    bool (*attach_device)(const char *name, VFIODevice *vbasedev,
>>> +                          AddressSpace *as, Error **errp);
>>>        void (*detach_device)(VFIODevice *vbasedev);
>>>        /* migration feature */
>>>        int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 7c4caa5938..d50600b702 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -156,7 +156,6 @@ static void
>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>>    static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>    {
>>>        ERRP_GUARD();
>>> -    int ret;
>>>        Error *err = NULL;
>>>        VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>>        VFIODevice *vbasedev = &vapdev->vdev;
>>> @@ -165,9 +164,8 @@ static void vfio_ap_realize(DeviceState *dev, Error
>> **errp)
>>>            return;
>>>        }
>>>
>>> -    ret = vfio_attach_device(vbasedev->name, vbasedev,
>>> -                             &address_space_memory, errp);
>>> -    if (ret) {
>>> +    if (!vfio_attach_device(vbasedev->name, vbasedev,
>>> +                            &address_space_memory, errp)) {
>>>            goto error;
>>>        }
>>>
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index 90e4a53437..782bd4bed7 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -580,7 +580,6 @@ static void vfio_ccw_realize(DeviceState *dev,
>> Error **errp)
>>>        S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>>>        VFIODevice *vbasedev = &vcdev->vdev;
>>>        Error *err = NULL;
>>> -    int ret;
>>>
>>>        /* Call the class init function for subchannel. */
>>>        if (cdc->realize) {
>>> @@ -594,9 +593,8 @@ static void vfio_ccw_realize(DeviceState *dev,
>> Error **errp)
>>>            return;
>>>        }
>>>
>>> -    ret = vfio_attach_device(cdev->mdevid, vbasedev,
>>> -                             &address_space_memory, errp);
>>> -    if (ret) {
>>> +    if (!vfio_attach_device(cdev->mdevid, vbasedev,
>>> +                            &address_space_memory, errp)) {
>>>            goto out_attach_dev_err;
>>>        }
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 8f9cbdc026..890d30910e 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1492,8 +1492,8 @@ retry:
>>>        return info;
>>>    }
>>>
>>> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> -                       AddressSpace *as, Error **errp)
>>> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                        AddressSpace *as, Error **errp)
>>>    {
>>>        const VFIOIOMMUClass *ops =
>>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>
>> This is still broken. No need to resend. I will update the code.
> 
> I put this series before preq v4, so you don't see that change.
> See https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_nesting_rfcv2_preq_v4_has_vfio_cleanup/
> 
> That change is in https://github.com/yiliu1765/qemu/commit/0bec499456a9aa5a079ed2335ce1581d79e2850d

OK looks good.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


