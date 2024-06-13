Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75901C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgLC-0002Vm-B9; Thu, 13 Jun 2024 05:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHgL4-000237-Ui
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHgL2-0001Om-7I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718269303;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJVZfkhG9mnB+EQvHCextvksduin0wd1sdbwyILHm9o=;
 b=KTwvRGA5vDnuOOiqVjHNRaNWQZBB2YwPNV5jnBcyRRDigx4etAiM4eymYxFODI6i+Wg+iI
 sWZo3gy4Ap4hMluqMrBLBTS5GjeHbqI5Y+e4GVEJhWQCRYVhxTWh2Xm1ibqkYiI3k/J8o3
 uoTJLttiN2fLvpK4SXk5PtsgsVFrnXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-TxBwVHZMNteZ1w3gCpXZzw-1; Thu, 13 Jun 2024 05:01:34 -0400
X-MC-Unique: TxBwVHZMNteZ1w3gCpXZzw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42135f60020so6259945e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 02:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718269293; x=1718874093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJVZfkhG9mnB+EQvHCextvksduin0wd1sdbwyILHm9o=;
 b=oMXnAWJQxUMh4KpaO1P1I085ILDjuqPogvhhG/lacWpm0osbG3MGBzVLlGV6T5OMvg
 0omKTQfZDh7ULuMI6K2rT4qRWDXbOv0LiAbwl8JaOfoNz2i5igUJXG7DhaTQ4PYmTRDw
 gOyERdMqPFlkL3BOO0DGT18RHMv0mfmuS5NINl3orUBnewQEzXb/IQeXK5Ql6kr3mng0
 mmfjcEA3BgtmTs8BPl8c0PKgoRsBRu9zQMp6cW6RLZCW8b+yqfSp39W1pDPbAPZfPHfr
 0r/S+q/u3To3IdS+LiCxun4iowXwsIS8REWx2cKnY1hg88icDX+tUvYCwYIMPEsKkICq
 AV0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP2Eoth8rjz5SN6QTcPque/jYPqiddzWWpUczpXZOAoa3j/I79ZNauKFxWxX8pJ354r7cs/Gv3LDPJzRRZEVadPKAdzCE=
X-Gm-Message-State: AOJu0Yy25YONKXHS3q71wnWMwyAWsMlLbJ734IV6zMuapw1PuuhIXgjG
 z6S6e85j9RDrpkvXOu4984DzawXaW/Z2O0Ul7754e1y9wWiee5haPpiaTRrUjCCBKrbwN3GsV6U
 3ra6UpsbFgIiSanHerEzbivrWMKimIBC3xzI7+v+Eu1jTWEFtO1Ns
X-Received: by 2002:a05:600c:190d:b0:421:82ed:28d1 with SMTP id
 5b1f17b1804b1-422867c02f1mr33853795e9.41.1718269293425; 
 Thu, 13 Jun 2024 02:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHrbCp7FjH4X4fnYF59iw7M7tfeBRE24/HTHJpI8/YTwZO9LULjwk6s11JyVvqv1wqyAW96A==
X-Received: by 2002:a05:600c:190d:b0:421:82ed:28d1 with SMTP id
 5b1f17b1804b1-422867c02f1mr33853245e9.41.1718269292598; 
 Thu, 13 Jun 2024 02:01:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602e0c2sm15839145e9.14.2024.06.13.02.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 02:01:32 -0700 (PDT)
Message-ID: <ec20948e-16de-48e6-be8b-dffa9395bb8a@redhat.com>
Date: Thu, 13 Jun 2024 11:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-5-eric.auger@redhat.com>
 <SJ0PR11MB674461B49A34599D0166D74E92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674461B49A34599D0166D74E92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Hi Zhenzhong,

On 6/11/24 05:25, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
>>
>> Compute the host reserved regions in virtio_iommu_set_iommu_device().
>> The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
>> The virtio_iommu_set_host_iova_ranges() helper turns usable regions
>> into complementary reserved regions while testing the inclusion
>> into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
>> implementation of virtio_iommu_set_iova_ranges() which will be	
>> removed in subsequent patches. rebuild_resv_regions() is just moved.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/virtio/virtio-iommu.c | 151 ++++++++++++++++++++++++++++++--------
>> -
>> 1 file changed, 117 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 0680a357f0..33e9682b83 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -494,12 +494,114 @@ get_host_iommu_device(VirtIOIOMMU
>> *viommu, PCIBus *bus, int devfn) {
>>     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>> }
>>
>> +/**
>> + * rebuild_resv_regions: rebuild resv regions with both the
>> + * info of host resv ranges and property set resv ranges
>> + */
>> +static int rebuild_resv_regions(IOMMUDevice *sdev)
>> +{
>> +    GList *l;
>> +    int i = 0;
>> +
>> +    /* free the existing list and rebuild it from scratch */
>> +    g_list_free_full(sdev->resv_regions, g_free);
>> +    sdev->resv_regions = NULL;
>> +
>> +    /* First add host reserved regions if any, all tagged as RESERVED */
>> +    for (l = sdev->host_resv_ranges; l; l = l->next) {
>> +        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>> +        Range *r = (Range *)l->data;
>> +
>> +        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>> +        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>> +        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
>> +        trace_virtio_iommu_host_resv_regions(sdev-
>>> iommu_mr.parent_obj.name, i,
>> +                                             range_lob(&reg->range),
>> +                                             range_upb(&reg->range));
>> +        i++;
>> +    }
>> +    /*
>> +     * then add higher priority reserved regions set by the machine
>> +     * through properties
>> +     */
>> +    add_prop_resv_regions(sdev);
>> +    return 0;
>> +}
>> +
>> +static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus
>> *bus,
>> +                                             int devfn, GList *iova_ranges,
>> +                                             Error **errp)
>> +{
>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>> +    IOMMUDevice *sdev;
>> +    GList *current_ranges;
>> +    GList *l, *tmp, *new_ranges = NULL;
>> +    int ret = -EINVAL;
>> +
>> +    if (!sbus) {
>> +        error_report("%s no sbus", __func__);
>> +    }
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +
>> +    current_ranges = sdev->host_resv_ranges;
>> +
>> +    if (sdev->probe_done) {
> Will this still happen with new interface?
no this shouldn't. Replaced by a g_assert(!sdev->probe_done) to make
sure the i/f is used properly.
>
>> +        error_setg(errp,
>> +                   "%s: Notified about new host reserved regions after probe",
>> +                   __func__);
>> +        goto out;
>> +    }
>> +
>> +    /* check that each new resv region is included in an existing one */
>> +    if (sdev->host_resv_ranges) {
> Same here.
To me this one can still happen in case several devices belong to the
same group.
>
>> +        range_inverse_array(iova_ranges,
>> +                            &new_ranges,
>> +                            0, UINT64_MAX);
>> +
>> +        for (tmp = new_ranges; tmp; tmp = tmp->next) {
>> +            Range *newr = (Range *)tmp->data;
>> +            bool included = false;
>> +
>> +            for (l = current_ranges; l; l = l->next) {
>> +                Range * r = (Range *)l->data;
>> +
>> +                if (range_contains_range(r, newr)) {
>> +                    included = true;
>> +                    break;
>> +                }
>> +            }
>> +            if (!included) {
>> +                goto error;
>> +            }
>> +        }
>> +        /* all new reserved ranges are included in existing ones */
>> +        ret = 0;
>> +        goto out;
>> +    }
>> +
>> +    range_inverse_array(iova_ranges,
>> +                        &sdev->host_resv_ranges,
>> +                        0, UINT64_MAX);
>> +    rebuild_resv_regions(sdev);
>> +
>> +    return 0;
>> +error:
>> +    error_setg(errp, "%s Conflicting host reserved ranges set!",
>> +               __func__);
>> +out:
>> +    g_list_free_full(new_ranges, g_free);
>> +    return ret;
>> +}
>> +
>> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>> int devfn,
>>                                           HostIOMMUDevice *hiod, Error **errp)
>> {
>>     VirtIOIOMMU *viommu = opaque;
>>     VirtioHostIOMMUDevice *vhiod;
>> +    HostIOMMUDeviceClass *hiodc =
>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>     struct hiod_key *new_key;
>> +    GList *host_iova_ranges = NULL;
> g_autoptr(GList)?
are you sure this frees all the elements of the list? As of now I would
be tempted to leave the code as is.

Thanks

Eric
>
> Thanks
> Zhenzhong
>
>>     assert(hiod);
>>
>> @@ -509,6 +611,20 @@ static bool
>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>         return false;
>>     }
>>
>> +    if (hiodc->get_iova_ranges) {
>> +        int ret;
>> +        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
>> +        if (!host_iova_ranges) {
>> +            return true; /* some old kernels may not support that capability */
>> +        }
>> +        ret = virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
>> +                                                host_iova_ranges, errp);
>> +        if (ret) {
>> +            g_list_free_full(host_iova_ranges, g_free);
>> +            return false;
>> +        }
>> +    }
>> +
>>     vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
>>     vhiod->bus = bus;
>>     vhiod->devfn = (uint8_t)devfn;
>> @@ -521,6 +637,7 @@ static bool
>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>
>>     object_ref(hiod);
>>     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>> +    g_list_free_full(host_iova_ranges, g_free);
>>
>>     return true;
>> }
>> @@ -1243,40 +1360,6 @@ static int
>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>     return 0;
>> }
>>
>> -/**
>> - * rebuild_resv_regions: rebuild resv regions with both the
>> - * info of host resv ranges and property set resv ranges
>> - */
>> -static int rebuild_resv_regions(IOMMUDevice *sdev)
>> -{
>> -    GList *l;
>> -    int i = 0;
>> -
>> -    /* free the existing list and rebuild it from scratch */
>> -    g_list_free_full(sdev->resv_regions, g_free);
>> -    sdev->resv_regions = NULL;
>> -
>> -    /* First add host reserved regions if any, all tagged as RESERVED */
>> -    for (l = sdev->host_resv_ranges; l; l = l->next) {
>> -        ReservedRegion *reg = g_new0(ReservedRegion, 1);
>> -        Range *r = (Range *)l->data;
>> -
>> -        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>> -        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>> -        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
>> -        trace_virtio_iommu_host_resv_regions(sdev-
>>> iommu_mr.parent_obj.name, i,
>> -                                             range_lob(&reg->range),
>> -                                             range_upb(&reg->range));
>> -        i++;
>> -    }
>> -    /*
>> -     * then add higher priority reserved regions set by the machine
>> -     * through properties
>> -     */
>> -    add_prop_resv_regions(sdev);
>> -    return 0;
>> -}
>> -
>> /**
>>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>>  *
>> --
>> 2.41.0


