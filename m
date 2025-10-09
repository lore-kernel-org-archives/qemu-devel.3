Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD1BCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pzJ-0007n4-3P; Thu, 09 Oct 2025 08:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6pzF-0007mC-7f
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6pzB-0004UP-7a
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760013784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/vmtdZcdvLK513x17z5yo895Ry80XRNN/mc17JxcCw0=;
 b=cfprJgYiD/2MvnJ3sx9V7S1XVMyvz/+AxTVX9xQuHg98OyaThIwn+dvM36VflGo2gzHc82
 bygNaG2hovfmka+SPs5Wpuoy685E60Hxvcf60ykJZZBzvl563dwClivexWF7QQVuQvIUsE
 GfRXrnb2s2FlnGxcOkvqqQwsbL3msVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-GL2VzCa5PvmVUCRW-yisVg-1; Thu, 09 Oct 2025 08:43:03 -0400
X-MC-Unique: GL2VzCa5PvmVUCRW-yisVg-1
X-Mimecast-MFC-AGG-ID: GL2VzCa5PvmVUCRW-yisVg_1760013782
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e36f9c651so6280935e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 05:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760013782; x=1760618582;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vmtdZcdvLK513x17z5yo895Ry80XRNN/mc17JxcCw0=;
 b=DMPx4fv1Cwn+3AbXAzUdv3Rw6sVPSZ/JXgwNIAfJoeq67lWDXLe2cUPNv4LvxlDeY8
 kGx6tVvfhcaQMO2ZTjCqWnIxKTTF/wYbJo4HZKAAe/ah4LMzybF6LK1C6oABTwRYJeem
 bj2yh7i0nHP5jrjmswGgKzgdyUC2jbQ8/K95qNG9QWCD6SnSw0q/ezzT8SykffWThLWw
 4C/akdbzJ2ScpYpk5ka2P1P0OymYEZKTqm5Fp0TfScnlnS1dCQM6GlHDShU4tZmg+R0O
 HPXsKc4fjswQO7cDl+kLDmJOg/rR2xCCr0Mda0v40jTu88AfiTlPA0kohupJbsJPw/AB
 grYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoYrIE/KCrAx9OaBBUTKAgGZ8V+6zydOy0eaewV0o0RBcjmjxvydXFOttngv2w8dk0iBPM3glVxubx@nongnu.org
X-Gm-Message-State: AOJu0YyRfkxacR4R0RHH5tWSPo+QMGXyWlaBU1pRAKt8zCKJh5Bmc6wc
 Na+appBK5c0DKAXDwxs/ZoD+8xaOgaXkxmaVihTM26GkH7pOzvhAyTGmAtnE8vY69cFZxqlx5hb
 Pywh+rYIk8MPUJ99iJAPg9QIerC2Soz9VTrdwVhzZDFtKjQrghn/ugVHI
X-Gm-Gg: ASbGncuGRMjq6GqrvIHP6fFlkjSZTPApS+PSmRUVdPIGFV6t2pvCrrIwTZZw9S6NZJX
 4g2lsSHsNWSbHMM+EHWgJQHUbA06yC4v89SMv74OkATyiFsELjDE53aR8Yz+sCFRYMRZn9pT/7P
 v4d4aM+/0xcpHtX5wAmomurAJtNBxjmWxufKTqTD4QQ7dzNGZqmluPDBs2pvHYNUJcm7qBhEJQn
 DM1ZXr/208hw8IMG0a3ESgVarrJNw8YeujR3yDyzZ41pRcDjjqg+hJ6fYR1gmvXPPFb74n7rR8s
 d3HtIB+qRpgsdti/RoeU63dhbq8SI9oZfartxacGDYR3Pw9qclW/UgHsFt8nnT8Bdni1pokLDKN
 CM7lDeTOO
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr48824755e9.2.1760013782272; 
 Thu, 09 Oct 2025 05:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXzK/HE9cCbGAQ/m3+wtG4/uww/876VMCWo1V/qwaiUvtOmxqjRYkdw/2nvMmTIT+I/8bwRQ==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr48824455e9.2.1760013781848; 
 Thu, 09 Oct 2025 05:43:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c0e35dsm85051235e9.8.2025.10.09.05.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 05:43:01 -0700 (PDT)
Message-ID: <835d840f-ad65-4f09-8d5c-051e32641ace@redhat.com>
Date: Thu, 9 Oct 2025 14:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <IA3PR11MB9136EAD2D625ED90DD89A13492EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136EAD2D625ED90DD89A13492EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Zhenzhong, Joao,

On 10/9/25 12:20, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>
>> On 9/22/25 07:49, Duan, Zhenzhong wrote:
>>> Hi Joao,
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>>
>>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the
>> last
>>>> dirty
>>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>>> query without issue because unmap will tear down the mapping anyway.
>>>>>
>>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based
>> on
>>>>> the scenario.
>>>>>
>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>> ---
>>>>>    hw/vfio/vfio-iommufd.h   | 1 +
>>>>>    include/system/iommufd.h | 2 +-
>>>>>    backends/iommufd.c       | 5 +++--
>>>>>    hw/vfio/iommufd.c        | 6 +++++-
>>>>>    backends/trace-events    | 2 +-
>>>>>    5 files changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>>> index 07ea0f4304..e0af241c75 100644
>>>>> --- a/hw/vfio/vfio-iommufd.h
>>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>>        VFIOContainerBase bcontainer;
>>>>>        IOMMUFDBackend *be;
>>>>>        uint32_t ioas_id;
>>>>> +    uint64_t dirty_tracking_flags;
>>>>>        QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>    } VFIOIOMMUFDContainer;
>>>>>
>>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>>> index c9c72ffc45..63898e7b0d 100644
>>>>> --- a/include/system/iommufd.h
>>>>> +++ b/include/system/iommufd.h
>>>>> @@ -64,7 +64,7 @@ bool
>>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>>> hwpt_id,
>>>>>    bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>> uint32_t hwpt_id,
>>>>>                                          uint64_t iova,
>> ram_addr_t
>>>> size,
>>>>>                                          uint64_t page_size,
>>>> uint64_t *data,
>>>>> -                                      Error **errp);
>>>>> +                                      uint64_t flags, Error
>>>> **errp);
>>>>>    bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>>> uint32_t id,
>>>>>                                          uint32_t data_type,
>>>> uint32_t entry_len,
>>>>>                                          uint32_t *entry_num,
>> void
>>>> *data,
>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>>> --- a/backends/iommufd.c
>>>>> +++ b/backends/iommufd.c
>>>>> @@ -361,7 +361,7 @@ bool
>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>                                          uint32_t hwpt_id,
>>>>>                                          uint64_t iova,
>> ram_addr_t
>>>> size,
>>>>>                                          uint64_t page_size,
>>>> uint64_t *data,
>>>>> -                                      Error **errp)
>>>>> +                                      uint64_t flags, Error
>> **errp)
>>>>>    {
>>>>>        int ret;
>>>>>        struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>>>> @@ -371,11 +371,12 @@ bool
>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>            .length = size,
>>>>>            .page_size = page_size,
>>>>>            .data = (uintptr_t)data,
>>>>> +        .flags = flags,
>>>>>        };
>>>>>
>>>>>        ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>>> &get_dirty_bitmap);
>>>>>        trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id,
>> iova,
>>>> size,
>>>>> -                                           page_size, ret ?
>> errno :
>>>> 0);
>>>>> +                                           flags, page_size,
>> ret ?
>>>> errno : 0);
>>>>>        if (ret) {
>>>>>            error_setg_errno(errp, errno,
>>>>>                             "IOMMU_HWPT_GET_DIRTY_BITMAP
>>>> (iova: 0x%"HWADDR_PRIx
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index 0057488ce9..c897aa6b17 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>>> VFIOContainerBase *bcontainer,
>>>>>                                      hwaddr iova, ram_addr_t
>> size,
>>>>>                                      IOMMUTLBEntry *iotlb)
>>>>>    {
>>>>> -    const VFIOIOMMUFDContainer *container =
>>>>> +    VFIOIOMMUFDContainer *container =
>>>>>            container_of(bcontainer, VFIOIOMMUFDContainer,
>>>> bcontainer);
>>>>>        bool need_dirty_sync = false;
>>>>>        Error *local_err = NULL;
>>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>>> VFIOContainerBase *bcontainer,
>>>>>        if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer))
>> {
>>>>>            if
>>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>>                bcontainer->dirty_pages_supported) {
>>>>> +            container->dirty_tracking_flags =
>>>>> +
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>>                ret = vfio_container_query_dirty_bitmap(bcontainer,
>> iova,
>>>> size,
>>>>>
>>>> iotlb->translated_addr,
>>>>>
>>>> &local_err);
>>>>> +            container->dirty_tracking_flags = 0;
>>>>
>>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags too,
>> like
>>>> the
>>>> original patches? This is a little unnecssary odd style to pass a flag via
>>>> container structure rather and then clearing.
>>>
>>> Just want to be simpler, original patch introduced a new parameter to
>> almost all
>>> variants of *_query_dirty_bitmap() while the flags parameter is only used by
>>> IOMMUFD backend when doing unmap_bitmap. Currently we already have
>> three
>>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need the
>> flag.
>>>
>>> I take container->dirty_tracking_flags as a notification mechanism, so set it
>> before
>>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe clearing
>> it in
>>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>>
>>>>
>>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH
>> for
>>>> generic
>>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>>> container
>>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>>> could just
>>>> ignore the flag, while IOMMUFD translates it to
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>>
>>> I did port original patch
>> https://github.com/yiliu1765/qemu/commit/99f83595d79d2e4170c9e456cf1
>> a7b9521bd4f80
>>> But it looks complex to have 'flags' parameter everywhere.
>> I think I would prefer like Joao to avoid caching information if possible
>> but I haven't check closely the mess it would introduce in the code. Let
>> me check.
> 
> Kindly ping. Just in case you have further comments on this.
Regarding the whole series,

* [1/5] vfio/iommufd: Add framework code to support getting dirty bitmap before unmap

   Needs refactoring. iommufd_cdev_unmap_one() seems superfluous now ?

* [2/5] vfio/iommufd: Query dirty bitmap before DMA unmap

   Looks OK.

   In an extra patch, could we rename 'vfio_dma_unmap_bitmap()' to
   'vfio_legacy_dma_unmap_get_dirty_bitmap()' ? Helps (me) remember
   what it does.

* [3/5] vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support

   Sorry, I lost track of the discussion between you and Joao regarding
   the new '->dirty_tracking_flags' attribute.

   I'd prefer adding a 'backend_flag' parameter, even if it’s currently
   only used by IOMMUFD. Since we’re not going to redefine all possible
   IOMMU backend flags, we can treat it as an opaque parameter for
   the upper container layer and document it as such.

   Is that ok for you ? A bit more churn for you but Joao did provide
   some parts.

* [4/5] intel_iommu: Optimize unmap_bitmap during migration

   Ack by Clément may be ?

* [5/5] vfio/migration: Allow live migration with vIOMMU without VFs
   using device dirty tracking

   ok.


Thanks,

C.


