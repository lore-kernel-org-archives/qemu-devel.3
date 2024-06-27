Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DFAC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 09:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMkyq-00023D-D8; Thu, 27 Jun 2024 04:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMkyp-000234-1c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMkyn-0000bI-Au
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719478784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQvSGgpEvhPJcNEwTpRwdp8KyvZM8/DnsczMr1jL3TI=;
 b=HZFjpH7v1wzKq0eBWHHoMrU58dlV7R+jZx/h7b9DYu7c7UFhpxttbgjnPM9OGe5/AIlGqj
 oYP+O9uZAeXcyoRcJKxcyWoTigAc0+u14+hVaylFSuqG+gyMzmSqUTOIy42I+++p/VVzF7
 +ihyqaHveRf5zGSKVtZQZ4dHx3BpdHM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-KvYAuVeuPYeJwMNAn5TSyw-1; Thu, 27 Jun 2024 04:59:39 -0400
X-MC-Unique: KvYAuVeuPYeJwMNAn5TSyw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b551a62a5eso76651036d6.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 01:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719478779; x=1720083579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQvSGgpEvhPJcNEwTpRwdp8KyvZM8/DnsczMr1jL3TI=;
 b=eTfkatYT/tbC4GVrIhFO1Eh3JRKMHUPRwEJcJvsCb990k4U0dXrrJIjBaEVUZJkXjh
 GF672qr3QoEoNJXWIHkOHLatY1N7k3ML0gn2stH4XhKNX9ALXENkUH+0TnsLmV96ysZh
 uQXNLrOP0OyPDv5p9GaP9xPTOKAWt8i3UQgCBV8nt5HeItfLrVNqy3ZCcwO4k61Snsds
 nDtlJMmlvjii0qsjfV9g3H8rDTPokoGDGYN12Yrl2/VTuVR7JwYR0O3+yJ8IJHiTyiO1
 9T3x+RbhLlSSk8U4DSoTZ/i7PrlWapQoCh9MKuCGRsznpOOQnpIxZrLMEq4sK3CmBsiQ
 QPCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1haX2Q2bsb03RNeoKlRqZqZzGqNz4F32vnwBnRnbyfHdPXu9fVfMKB43RCldP0d4AszpiusszU7dtE3TcHnIwPHl4uxg=
X-Gm-Message-State: AOJu0YxNEqXOIls6wN5N8c+gxO6lSsIfuKN7SO6lQy8kyIGv2TJNDcV9
 DmMbXe6tB2f+rN9vUtIawCyek2H9rCtPsVLqI8qF0f44kAhq0miTiWsDb6BKQSJEdz03CHMKEg9
 U30L/do56JuSsNoc3WCP9r3NmA8BXAc2xgGC18DoSBbVMWoVZ0sLA
X-Received: by 2002:ad4:5409:0:b0:6b5:b29:82cf with SMTP id
 6a1803df08f44-6b540aa802fmr115187316d6.48.1719478779438; 
 Thu, 27 Jun 2024 01:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Hp2AfJvCHKLVzRPsapYZYFnu65LpgzYkY0dGpRL/QrOTlgzIt2kvgJjq6/vP7EUvmrovqA==
X-Received: by 2002:ad4:5409:0:b0:6b5:b29:82cf with SMTP id
 6a1803df08f44-6b540aa802fmr115187206d6.48.1719478779110; 
 Thu, 27 Jun 2024 01:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59241b67dsm3523876d6.4.2024.06.27.01.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 01:59:38 -0700 (PDT)
Message-ID: <ca01fa7e-4218-48b5-8c85-e8f7e9e353c9@redhat.com>
Date: Thu, 27 Jun 2024 10:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
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
 <20240626082727.1278530-5-eric.auger@redhat.com>
 <SJ0PR11MB6744E5DF82073F17F2FC31D192D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744E5DF82073F17F2FC31D192D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On 6/27/24 05:06, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
>> callback
>>
>> This callback will be used to retrieve the page size mask supported
>> along a given Host IOMMU device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> include/hw/vfio/vfio-container-base.h |  7 +++++++
>> include/sysemu/host_iommu_device.h    |  8 ++++++++
>> hw/vfio/container.c                   | 10 ++++++++++
>> hw/vfio/iommufd.c                     | 11 +++++++++++
>> 4 files changed, 36 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index 45d7c40fce..62a8b60d87 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -88,6 +88,13 @@ int vfio_container_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>>
>> GList *vfio_container_get_iova_ranges(const VFIOContainerBase
>> *bcontainer);
>>
>> +static inline uint64_t
>> +vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>> +{
>> +    assert(bcontainer);
>> +    return bcontainer->pgsizes;
>> +}
>> +
>> #define TYPE_VFIO_IOMMU "vfio-iommu"
>> #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>> #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index 05c7324a0d..c1bf74ae2c 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -89,6 +89,14 @@ struct HostIOMMUDeviceClass {
>>      * @hiod: handle to the host IOMMU device
>>      */
>>     GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
>> +    /**
>> +     *
>> +     * @get_page_size_mask: Return the page size mask supported along
>> this
>> +     * @hiod Host IOMMU device
>> +     *
>> +     * @hiod: handle to the host IOMMU device
>> +     */
>> +    uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> Not sure if it's simpler to utilize existing .get_cap() to get pgsizes.
I chose to introduce a new callback because the page_mask can be U64_MAX
and get_cap is likely to return a negative value. So we could not
distinguish between an error and a full mask.

Thanks

Eric

>
> Thanks
> Zhenzhong
>
>> };
>>
>> /*
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index adeab1ac89..b5ce559a0d 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1174,6 +1174,15 @@
>> hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>>     return vfio_container_get_iova_ranges(vdev->bcontainer);
>> }
>>
>> +static uint64_t
>> +hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>> +{
>> +    VFIODevice *vdev = hiod->agent;
>> +
>> +    g_assert(vdev);
>> +    return vfio_container_get_page_size_mask(vdev->bcontainer);
>> +}
>> +
>> static void vfio_iommu_legacy_instance_init(Object *obj)
>> {
>>     VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
>> @@ -1188,6 +1197,7 @@ static void
>> hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>>     hioc->realize = hiod_legacy_vfio_realize;
>>     hioc->get_cap = hiod_legacy_vfio_get_cap;
>>     hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
>> +    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
>> };
>>
>> static const TypeInfo types[] = {
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 211e7223f1..7b5f87a148 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -652,12 +652,23 @@
>> hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>>     return vfio_container_get_iova_ranges(vdev->bcontainer);
>> }
>>
>> +static uint64_t
>> +hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>> +{
>> +    VFIODevice *vdev = hiod->agent;
>> +
>> +    g_assert(vdev);
>> +    return vfio_container_get_page_size_mask(vdev->bcontainer);
>> +}
>> +
>> +
>> static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>> {
>>     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>>
>>     hiodc->realize = hiod_iommufd_vfio_realize;
>>     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>> +    hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
>> };
>>
>> static const TypeInfo types[] = {
>> --
>> 2.41.0


