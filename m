Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C92C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzHh-0005Mc-1B; Wed, 17 Jul 2024 03:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTzHd-0005L4-Gn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTzHb-0001Lj-HW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721202060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErqzU+MeAVMUCGlNRiooH+sSNWTmSjcZqa73vQYikEk=;
 b=jF40poeiTLO30gXrIApbKh/q9bxo4ehpZ/mXEDlR/iRteKf2m4JUybI/30FL9NTT04H2r1
 pVwjkuGyPFJPMqK/R3nDwB2jAQMMQ1ql64/3B7bqEUPxoTIaSZQgEWULRVM3N+srigQ7ok
 A+QoKoaa0Dve6bmxXHSG/2EajEdqV2A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-bze6QmJqNeOdqzzBg8Bp2g-1; Wed, 17 Jul 2024 03:40:59 -0400
X-MC-Unique: bze6QmJqNeOdqzzBg8Bp2g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ef39e2so47538485e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 00:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721202058; x=1721806858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErqzU+MeAVMUCGlNRiooH+sSNWTmSjcZqa73vQYikEk=;
 b=LuOXG2zU02x4P+1hQY0/tu8J/p9KD+PoQ9oSJBq5XI9ECt08IfIcdHHMx4i3fvmgqZ
 wGJs4dWHWLty4/LAIlTTYvgKrVTqlzESH9C6UjAX5SGO4Qyc3eiiX4dEUlsJdRwvsNem
 RY3TpfkYQGg8bRcIDxIAsmSLsZjmpAY1z2rq1NGCYx6nUTeN4r74BuTzgBRYJYKuJrKU
 c2kgb8rUyV10RTPSnx7hrWuopfz2Cv1UFRtzhOih3j+XUbnp5THcbvnaXjmP+y5Ot09O
 qDo7jWhYtp2MF4NjxQLKFo6eC2+nN1UiBA1DtRuB2r0zFTzBFiM66DX1yxJ/yl+jVd9I
 gPlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAQRW0HXfrSbqgSnrNA+tHKgIaoTOelw+mKMY9zVkb0IV32MJdFHhqqfI9UaqF8mrWEgKrY5D7fHK2HGIFzCraJnrk3yo=
X-Gm-Message-State: AOJu0Yx6CfDzwT9UXVgZnQBoO6Ap4LidFyBFCWXvfGflGDRdjZwu++nh
 NZEf2hu43KxI6BRE4RnWX/Xbtl0Cu320tjdpT2HQsTqaCDoMWaR099XutukdKeTVot+zPVP6cDK
 MRwwiWC+uFNZRzDvyyvwpDlFf93VxCkwxhZKcKRa0vNCR4t/21zIg
X-Received: by 2002:a05:600c:3513:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-427c2ce8cecmr5186645e9.26.1721202057953; 
 Wed, 17 Jul 2024 00:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5C14RJhOf7GWVFcNm7qW6BsRzs1EZqD0qJwXXqUAofXhUgMu7lZZ6dEOvYUqUdTbzl5N5WA==
X-Received: by 2002:a05:600c:3513:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-427c2ce8cecmr5186465e9.26.1721202057537; 
 Wed, 17 Jul 2024 00:40:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d7c9csm194753435e9.48.2024.07.17.00.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 00:40:57 -0700 (PDT)
Message-ID: <d31d814e-ba00-4a2c-b905-d01022883b95@redhat.com>
Date: Wed, 17 Jul 2024 09:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "yanghliu@redhat.com" <yanghliu@redhat.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-4-eric.auger@redhat.com>
 <SJ0PR11MB6744D54C9B81BD1AD2BE5E1A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744D54C9B81BD1AD2BE5E1A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 7/17/24 05:06, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
>> unset_iommu_devices
>>
>> We are currently missing the deallocation of the [host_]resv_regions
>> in case of hot unplug. Also to make things more simple let's rule
>> out the case where multiple HostIOMMUDevices would be aliased and
>> attached to the same IOMMUDevice. This allows to remove the handling
>> of conflicting Host reserved regions. Anyway this is not properly
>> supported at guest kernel level. On hotunplug the reserved regions
>> are reset to the ones set by virtio-iommu property.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/virtio/virtio-iommu.c | 62 ++++++++++++++++++----------------------
>> 1 file changed, 28 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 2c54c0d976..2de41ab412 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -538,8 +538,6 @@ static int
>> virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>> {
>>     IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>>     IOMMUDevice *sdev;
>> -    GList *current_ranges;
>> -    GList *l, *tmp, *new_ranges = NULL;
>>     int ret = -EINVAL;
>>
>>     if (!sbus) {
>> @@ -553,33 +551,10 @@ static int
>> virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>>         return ret;
>>     }
>>
>> -    current_ranges = sdev->host_resv_ranges;
>> -
>> -    /* check that each new resv region is included in an existing one */
>>     if (sdev->host_resv_ranges) {
>> -        range_inverse_array(iova_ranges,
>> -                            &new_ranges,
>> -                            0, UINT64_MAX);
>> -
>> -        for (tmp = new_ranges; tmp; tmp = tmp->next) {
>> -            Range *newr = (Range *)tmp->data;
>> -            bool included = false;
>> -
>> -            for (l = current_ranges; l; l = l->next) {
>> -                Range * r = (Range *)l->data;
>> -
>> -                if (range_contains_range(r, newr)) {
>> -                    included = true;
>> -                    break;
>> -                }
>> -            }
>> -            if (!included) {
>> -                goto error;
>> -            }
>> -        }
>> -        /* all new reserved ranges are included in existing ones */
>> -        ret = 0;
>> -        goto out;
>> +        error_setg(errp, "%s virtio-iommu does not support aliased BDF",
>> +                   __func__);
>> +        return ret;
>>     }
>>
>>     range_inverse_array(iova_ranges,
>> @@ -588,14 +563,31 @@ static int
>> virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>>     rebuild_resv_regions(sdev);
>>
>>     return 0;
>> -error:
>> -    error_setg(errp, "%s Conflicting host reserved ranges set!",
>> -               __func__);
>> -out:
>> -    g_list_free_full(new_ranges, g_free);
>> -    return ret;
>> }
>>
>> +static void virtio_iommu_unset_host_iova_ranges(VirtIOIOMMU *s,
>> PCIBus *bus,
>> +                                                int devfn)
>> +{
>> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>> +    IOMMUDevice *sdev;
>> +
>> +    if (!sbus) {
>> +        return;
>> +    }
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +    if (!sdev) {
>> +        return;
>> +    }
>> +
>> +    g_list_free_full(g_steal_pointer(&sdev->host_resv_ranges), g_free);
>> +    g_list_free_full(sdev->resv_regions, g_free);
>> +    sdev->host_resv_ranges = NULL;
>> +    sdev->resv_regions = NULL;
>> +    add_prop_resv_regions(sdev);
> Is this necessary? rebuild_resv_regions() will do that again.
My goal was to reset the state that existed before the

virtio_iommu_set_host_iova_ranges() was called. prop resv regions were originally added in virtio_iommu_find_add_as. 
The next device to be hotplugged at this aliased bdf is not necessarily a VFIO device (may be a virtio one), in which case we would miss the prop resv regions.

>
> Other than that, for the whole series,
>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks!

Eric
>
> Thanks
> Zhenzhong
>
>> +}
>> +
>> +
>> static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t
>> new_mask,
>>                                  Error **errp)
>> {
>> @@ -704,6 +696,8 @@ virtio_iommu_unset_iommu_device(PCIBus *bus,
>> void *opaque, int devfn)
>>     if (!hiod) {
>>         return;
>>     }
>> +    virtio_iommu_unset_host_iova_ranges(viommu, hiod->aliased_bus,
>> +                                        hiod->aliased_devfn);
>>
>>     g_hash_table_remove(viommu->host_iommu_devices, &key);
>> }
>> --
>> 2.41.0


