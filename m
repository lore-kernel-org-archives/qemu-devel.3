Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53614C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1nK-0004N4-31; Fri, 14 Jun 2024 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI1nH-0004M8-I2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI1nF-0005yj-2E
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718351775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqBRG+wW+5VhbP/NWpa9NbzE0goGCigFoBLsRnZnWDE=;
 b=FoDD7wA+B2M9/0BCXToDzWNzC7Dn0HWBiM2rusaCPEK2ySCfRcsuKIbeaHYktTRQzpfSqz
 /UjZVGAqXwV6Wh75OA6L0a5D3cmguz0euvhQW8GOgjzbm0G0NnCaTPEwfrBXIcLrCekdru
 VF2MG/XLWDsuj3dF+/rgHM4oAATkQCU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-BjBJodjBPUi2urh_HFEvAQ-1; Fri, 14 Jun 2024 03:56:14 -0400
X-MC-Unique: BjBJodjBPUi2urh_HFEvAQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421811b92bcso11876235e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 00:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718351773; x=1718956573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gqBRG+wW+5VhbP/NWpa9NbzE0goGCigFoBLsRnZnWDE=;
 b=SeeTQcSY7ZwTlEIPSfNukTyh3IQGXBkTYMS/OvanMHpb6TPiMs2Jkm4+/+dMixrOiF
 guhFkUz7+tKZqAoZhiHKU5V5EAwYmY+Y5Sxd0Gk/KYW/la2kKEePnD+KTjq6uQXVZjyk
 C8q6II2Nx51WNet+q0tpkEnN27AQv2xxAG0HwbyhwMp+T5GW/KGnrsYJrF/rdsSN+39U
 IY21aJuoo1Bko00z+IDzf6e76vZe7A1TOczGVh+f8IOroF5hQhFVJT7LQ8NJuObrbGHM
 mAURf6o8/R7hhi8NvMNdEGLIOi05aez7JakW+gie8NiKWnrW3bZnazOyIwbsUYWtA1bP
 wLoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxUCEUScNtQU2XHhj3l7mhR80mOqcVvoS1xf5g06BYhx1A8eFUCl2QKKwR+4niSHT14jitUjSlcvk94kbUrEEoOm+3vW4=
X-Gm-Message-State: AOJu0YxyWc3EYdK8HwJYZJHTF7MsuB8QkPf3SuthZ4xYZbf1mKOrjy/N
 eZjy9F9GuOiTC59ZTEJvS7jKT96phaya1QIxRDRgai4aKU7MR4wpOvq+raXFPM7iG0o36ITuAdf
 F9Hx1PYLhNsFuNwTM3GBCcg9I4yuZJUt35zpe6avoN0jzM0O3QaZm
X-Received: by 2002:a05:600c:35c1:b0:422:4fcd:d4b9 with SMTP id
 5b1f17b1804b1-42305e710d0mr7768855e9.29.1718351772806; 
 Fri, 14 Jun 2024 00:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGScQFWk4asNIVKangcFg1D3GxduzCvnzwcAiA/zxRdGJrcznSGRsCidY3eCwzUzL5MGSqn9A==
X-Received: by 2002:a05:600c:35c1:b0:422:4fcd:d4b9 with SMTP id
 5b1f17b1804b1-42305e710d0mr7768725e9.29.1718351772407; 
 Fri, 14 Jun 2024 00:56:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602ee95sm51293605e9.13.2024.06.14.00.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 00:56:11 -0700 (PDT)
Message-ID: <c66c9f2a-2259-4f2f-afb7-3fad718cc8f2@redhat.com>
Date: Fri, 14 Jun 2024 09:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-5-eric.auger@redhat.com>
 <SJ0PR11MB6744A08077F63B0E4535D97292C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <107a70a8-b75f-48bb-8df2-7d779b7e889a@redhat.com>
 <SJ0PR11MB67442EC0B322352072F228B392C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67442EC0B322352072F228B392C22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/14/24 05:05, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
>>
>>
>>
>> On 6/13/24 12:00, Duan, Zhenzhong wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
>>>>
>>>> Compute the host reserved regions in virtio_iommu_set_iommu_device().
>>>> The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
>>>> The virtio_iommu_set_host_iova_ranges() helper turns usable regions
>>>> into complementary reserved regions while testing the inclusion
>>>> into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
>>>> implementation of virtio_iommu_set_iova_ranges() which will be
>>>> removed in subsequent patches. rebuild_resv_regions() is just moved.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> - added g_assert(!sdev->probe_done)
>>>> ---
>>>> hw/virtio/virtio-iommu.c | 146 ++++++++++++++++++++++++++++++----
>> ----
>>>> -
>>>> 1 file changed, 112 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index db842555c8..04474ebd74 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -498,12 +498,109 @@ get_host_iommu_device(VirtIOIOMMU
>>>> *viommu, PCIBus *bus, int devfn) {
>>>>     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>>>> }
>>>>
>>>> +/**
>>>> + * rebuild_resv_regions: rebuild resv regions with both the
>>>> + * info of host resv ranges and property set resv ranges
>>>> + */
>>>> +static int rebuild_resv_regions(IOMMUDevice *sdev)
>>>> +{
>>>> +    GList *l;
>>>> +    int i = 0;
>>>> +
>>>> +    /* free the existing list and rebuild it from scratch */
>>>> +    g_list_free_full(sdev->resv_regions, g_free);
>>>> +    sdev->resv_regions = NULL;
>>>> +
>>>> +    /* First add host reserved regions if any, all tagged as RESERVED */
>>>> +    for (l = sdev->host_resv_ranges; l; l = l->next) {
>>>> +        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>>>> +        Range *r = (Range *)l->data;
>>>> +
>>>> +        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>>>> +        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>>>> +        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions,
>> reg);
>>>> +        trace_virtio_iommu_host_resv_regions(sdev-
>>>>> iommu_mr.parent_obj.name, i,
>>>> +                                             range_lob(&reg->range),
>>>> +                                             range_upb(&reg->range));
>>>> +        i++;
>>>> +    }
>>>> +    /*
>>>> +     * then add higher priority reserved regions set by the machine
>>>> +     * through properties
>>>> +     */
>>>> +    add_prop_resv_regions(sdev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus
>>>> *bus,
>>>> +                                             int devfn, GList *iova_ranges,
>>>> +                                             Error **errp)
>>>> +{
>>>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>>> Here the bus/devfn parameters are real device BDF not aliased one,
>>> But used to index s->as_by_busptr which expect aliased bus/devfn.
>>>
>>> Do we need a translation of bus/devfn?
>> Hum that's a good point actually. I need to further study that. that's
>> not easy to translate, is it?
> Yes, may need a path to call into pci_device_get_iommu_bus_devfn().
> Maybe a new HostIOMMUDevice callback.
>
>> Now I am not totally sure why we don't use the alias as well for
>> HostIOMMUDevices or at least store the aliased bdf.
> Because we need to store HostIOMMUDevice in vIOMMU in real bdf granularity,
> Not aliased bdf granularity. Virtual vtd calls VFIO device uAPI on real device not
> the aliased device, i.e., VFIO_DEVICE_[ATTACH|DETACH]_IOMMUFD_PT.
>
> I also have a question, could we define host_resv_ranges in VirtioHostIOMMUDevice
> to avoid translation?
well reserved iova regions are rather associated to iommu groups
(associated to the concept of alias bdfs), no? Also potentially emulated
devices could expose some.

Eric
>
> Thanks
> Zhenzhong
>
>> Thanks
>>
>> Eric
>>> Thanks
>>> Zhenzhong
>>>
>>>> +    IOMMUDevice *sdev;
>>>> +    GList *current_ranges;
>>>> +    GList *l, *tmp, *new_ranges = NULL;
>>>> +    int ret = -EINVAL;
>>>> +
>>>> +    if (!sbus) {
>>>> +        error_report("%s no sbus", __func__);
>>>> +    }
>>>> +
>>>> +    sdev = sbus->pbdev[devfn];
>>>> +
>>>> +    current_ranges = sdev->host_resv_ranges;
>>>> +
>>>> +    g_assert(!sdev->probe_done);
>>>> +
>>>> +    /* check that each new resv region is included in an existing one */
>>>> +    if (sdev->host_resv_ranges) {
>>>> +        range_inverse_array(iova_ranges,
>>>> +                            &new_ranges,
>>>> +                            0, UINT64_MAX);
>>>> +
>>>> +        for (tmp = new_ranges; tmp; tmp = tmp->next) {
>>>> +            Range *newr = (Range *)tmp->data;
>>>> +            bool included = false;
>>>> +
>>>> +            for (l = current_ranges; l; l = l->next) {
>>>> +                Range * r = (Range *)l->data;
>>>> +
>>>> +                if (range_contains_range(r, newr)) {
>>>> +                    included = true;
>>>> +                    break;
>>>> +                }
>>>> +            }
>>>> +            if (!included) {
>>>> +                goto error;
>>>> +            }
>>>> +        }
>>>> +        /* all new reserved ranges are included in existing ones */
>>>> +        ret = 0;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    range_inverse_array(iova_ranges,
>>>> +                        &sdev->host_resv_ranges,
>>>> +                        0, UINT64_MAX);
>>>> +    rebuild_resv_regions(sdev);
>>>> +
>>>> +    return 0;
>>>> +error:
>>>> +    error_setg(errp, "%s Conflicting host reserved ranges set!",
>>>> +               __func__);
>>>> +out:
>>>> +    g_list_free_full(new_ranges, g_free);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>>>> int devfn,
>>>>                                           HostIOMMUDevice *hiod, Error **errp)
>>>> {
>>>>     VirtIOIOMMU *viommu = opaque;
>>>>     VirtioHostIOMMUDevice *vhiod;
>>>> +    HostIOMMUDeviceClass *hiodc =
>>>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>     struct hiod_key *new_key;
>>>> +    GList *host_iova_ranges = NULL;
>>>>
>>>>     assert(hiod);
>>>>
>>>> @@ -513,6 +610,20 @@ static bool
>>>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>>>         return false;
>>>>     }
>>>>
>>>> +    if (hiodc->get_iova_ranges) {
>>>> +        int ret;
>>>> +        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
>>>> +        if (!host_iova_ranges) {
>>>> +            return true; /* some old kernels may not support that capability
>> */
>>>> +        }
>>>> +        ret = virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
>>>> +                                                host_iova_ranges, errp);
>>>> +        if (ret) {
>>>> +            g_list_free_full(host_iova_ranges, g_free);
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>>     vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
>>>>     vhiod->bus = bus;
>>>>     vhiod->devfn = (uint8_t)devfn;
>>>> @@ -525,6 +636,7 @@ static bool
>>>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>>>
>>>>     object_ref(hiod);
>>>>     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>>>> +    g_list_free_full(host_iova_ranges, g_free);
>>>>
>>>>     return true;
>>>> }
>>>> @@ -1246,40 +1358,6 @@ static int
>>>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>>>     return 0;
>>>> }
>>>>
>>>> -/**
>>>> - * rebuild_resv_regions: rebuild resv regions with both the
>>>> - * info of host resv ranges and property set resv ranges
>>>> - */
>>>> -static int rebuild_resv_regions(IOMMUDevice *sdev)
>>>> -{
>>>> -    GList *l;
>>>> -    int i = 0;
>>>> -
>>>> -    /* free the existing list and rebuild it from scratch */
>>>> -    g_list_free_full(sdev->resv_regions, g_free);
>>>> -    sdev->resv_regions = NULL;
>>>> -
>>>> -    /* First add host reserved regions if any, all tagged as RESERVED */
>>>> -    for (l = sdev->host_resv_ranges; l; l = l->next) {
>>>> -        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>>>> -        Range *r = (Range *)l->data;
>>>> -
>>>> -        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>>>> -        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>>>> -        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions,
>> reg);
>>>> -        trace_virtio_iommu_host_resv_regions(sdev-
>>>>> iommu_mr.parent_obj.name, i,
>>>> -                                             range_lob(&reg->range),
>>>> -                                             range_upb(&reg->range));
>>>> -        i++;
>>>> -    }
>>>> -    /*
>>>> -     * then add higher priority reserved regions set by the machine
>>>> -     * through properties
>>>> -     */
>>>> -    add_prop_resv_regions(sdev);
>>>> -    return 0;
>>>> -}
>>>> -
>>>> /**
>>>>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>>>>  *
>>>> --
>>>> 2.41.0


