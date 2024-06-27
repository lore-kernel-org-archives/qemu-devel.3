Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF52FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpdM-00024T-Pv; Thu, 27 Jun 2024 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMpdL-00023e-LN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMpdJ-0007gA-L9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719496672;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl99MVknD9w18cJTVaORJY5ZJ9vPE4cAgTvZIaGWhTM=;
 b=LdhFOOpdcuyKq3aQi20OxqX8SXrrr3gJe4p5urKop4s3IqPja+ExNU4aNHmeOsbpRLwyfp
 5qFYoYVL8zsPGUJymx3S9kxJ5M8N62M6NZTUaQh85n4I5LTqDs6x1in6eGijUOns8e049X
 seP3gcU3v6ndj6Tm36EQbU0qZpws3x0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-iIz0_iMSOYas3s3rjbP0GQ-1; Thu, 27 Jun 2024 09:57:48 -0400
X-MC-Unique: iIz0_iMSOYas3s3rjbP0GQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79d5bdc12c7so137615785a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496668; x=1720101468;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dl99MVknD9w18cJTVaORJY5ZJ9vPE4cAgTvZIaGWhTM=;
 b=AJH1qsUE+xoxfx2nB9Lbx6CAPqwoBTgTzuIwY9ypKlQgmh3BCjgjWJ99GltU+BEbnL
 gOltz83vF7AkUWXd1h5wYIh+mP/yqeEIe1rpS/MlfPAMosLgVae9BJQ+3gj7VuYTLDyb
 H6xmiL22fkAwI/Bihc3LulcbZubc8UssKehgwyBChLoUZtjYFoZfIheD86raV04Se6GE
 qpu7i/xnTMw4XwgbBaxk8DqfpD1xwou2TsibIN+Xja62eeVHyRoNNCr/t1VXPVd638Pp
 Yt07eZ+dC76Pl6p1V/ePjzRWYpQrpw3zsRdtLw3Jx2BqpCHhD4VAPZKbjeK9avLERfWK
 OReg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0w0G3UOs7+W9w0OXRZMVjKpJNX2/ecrGdcp8rNMt51uJiYwfUkf8KIGcuL8MdoHJw4WgI4gtaNbUXcxqugETEsTj2FXU=
X-Gm-Message-State: AOJu0YzqhlYwHyJvZbcwbsBUI7Gc6khgqr5sPcGIrgqUBkgtsDNpxdTS
 QuOhZ+R5qPVKBHa2/MwknHAmlbSeKetT16YhIzHFeD16PtqVIKLmAHzLUYld1D8qSBPE++64ZN/
 FjHJnmkHiG0FFxrGynj/ik9i+1uQRG2RhOUVMHbWydp/fHmM56dRV
X-Received: by 2002:a05:620a:4442:b0:79b:f10e:118b with SMTP id
 af79cd13be357-79bf10e13efmr1378739985a.0.1719496667921; 
 Thu, 27 Jun 2024 06:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDLLqIOgn9WDA+zh/gZQba1BA9ROQCw6bR/D4do2HluCY/MnUhuRBSOrv+VzM1guNUGUABUA==
X-Received: by 2002:a05:620a:4442:b0:79b:f10e:118b with SMTP id
 af79cd13be357-79bf10e13efmr1378738085a.0.1719496667602; 
 Thu, 27 Jun 2024 06:57:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d5c7af05asm57295985a.14.2024.06.27.06.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:57:47 -0700 (PDT)
Message-ID: <8b0b5ba0-ce28-4756-9792-761a4aabdc6d@redhat.com>
Date: Thu, 27 Jun 2024 15:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-6-eric.auger@redhat.com>
 <SJ0PR11MB67447467D606CD472F155D4492D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67447467D606CD472F155D4492D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Hi Zhenhong,

On 6/27/24 13:32, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH 5/7] virtio-iommu : Retrieve page size mask on
>> virtio_iommu_set_iommu_device()
>>
>> Retrieve the Host IOMMU Device page size mask when this latter is set.
>> This allows to get the information much sooner than when relying on
>> IOMMU MR set_page_size_mask() call, whcih happens when the IOMMU
>> MR
>> gets enabled. We introduce check_page_size_mask() helper whose code
>> is inherited from current virtio_iommu_set_page_size_mask()
>> implementation. This callback will be removed in a subsequent patch.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/virtio/virtio-iommu.c | 55
>> ++++++++++++++++++++++++++++++++++++++--
>> hw/virtio/trace-events   |  1 +
>> 2 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index b8f75d2b1a..631589735a 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -598,9 +598,39 @@ out:
>>     return ret;
>> }
>>
>> +static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t
>> new_mask,
>> +                                 Error **errp)
>> +{
>> +    uint64_t cur_mask = viommu->config.page_size_mask;
>> +
>> +    if ((cur_mask & new_mask) == 0) {
>> +        error_setg(errp, "virtio-iommu reports a page size mask 0x%"PRIx64
>> +                   " incompatible with currently supported mask 0x%"PRIx64,
>> +                   new_mask, cur_mask);
>> +        return false;
>> +    }
>> +    /*
>> +     * Once the granule is frozen we can't change the mask anymore. If by
>> +     * chance the hotplugged device supports the same granule, we can still
>> +     * accept it.
>> +     */
>> +    if (viommu->granule_frozen) {
>> +        int cur_granule = ctz64(cur_mask);
>> +
>> +        if (!(BIT_ULL(cur_granule) & new_mask)) {
>> +            error_setg(errp,
>> +                       "virtio-iommu does not support frozen granule 0x%llx",
>> +                       BIT_ULL(cur_granule));
>> +            return false;
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>> int devfn,
>>                                           HostIOMMUDevice *hiod, Error **errp)
>> {
>> +    ERRP_GUARD();
>>     VirtIOIOMMU *viommu = opaque;
>>     HostIOMMUDeviceClass *hiodc =
>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>     struct hiod_key *new_key;
>> @@ -623,8 +653,26 @@ static bool
>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>                                                 hiod->aliased_devfn,
>>                                                 host_iova_ranges, errp);
>>         if (ret) {
>> -            g_list_free_full(host_iova_ranges, g_free);
>> -            return false;
>> +            goto error;
>> +        }
>> +    }
>> +    if (hiodc->get_page_size_mask) {
>> +        uint64_t new_mask = hiodc->get_page_size_mask(hiod);
>> +
>> +        if (check_page_size_mask(viommu, new_mask, errp)) {
>> +            /*
>> +             * The default mask depends on the "granule" property. For example,
>> +             * with 4k granule, it is -(4 * KiB). When an assigned device has
>> +             * page size restrictions due to the hardware IOMMU configuration,
>> +             * apply this restriction to the mask.
>> +             */
>> +            trace_virtio_iommu_update_page_size_mask(hiod->name,
>> +                                                     viommu->config.page_size_mask,
>> +                                                     new_mask);
>> +            viommu->config.page_size_mask &= new_mask;
> This is a bit different from original logic, it may update page_size_mask after frozen.
> Will that make issue?
You're fully right. I need to replace

viommu->config.page_size_mask &= new_mask;
by
if (s->granule_frozen) {
    viommu->config.page_size_mask &= new_mask;
}    

> Except this question, for all other patches,
>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Thanks!

Eric
>
> Thanks
> Zhenzhong
>
>> +        } else {
>> +            error_prepend(errp, "%s: ", hiod->name);
>> +            goto error;
>>         }
>>     }
>>
>> @@ -637,6 +685,9 @@ static bool
>> virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>>     g_list_free_full(host_iova_ranges, g_free);
>>
>>     return true;
>> +error:
>> +    g_list_free_full(host_iova_ranges, g_free);
>> +    return false;
>> }
>>
>> static void
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 3cf84e04a7..599d855ff6 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -132,6 +132,7 @@ virtio_iommu_notify_map(const char *name,
>> uint64_t virt_start, uint64_t virt_end
>> virtio_iommu_notify_unmap(const char *name, uint64_t virt_start,
>> uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
>> virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t
>> virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64"
>> virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
>> virtio_iommu_set_page_size_mask(const char *name, uint64_t old,
>> uint64_t new) "mr=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
>> +virtio_iommu_update_page_size_mask(const char *name, uint64_t old,
>> uint64_t new) "host iommu device=%s old_mask=0x%"PRIx64"
>> new_mask=0x%"PRIx64
>> virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
>> virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
>> virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn,
>> bool on) "Device %02x:%02x.%x switching address space (iommu
>> enabled=%d)"
>> --
>> 2.41.0


