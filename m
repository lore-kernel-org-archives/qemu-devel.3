Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FBAC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nys-0004d9-5U; Tue, 14 May 2024 04:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6nyX-0004br-RR
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6nyU-00088K-4L
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715677048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIIPyu82OG2zp3cmolu7CNKPHImQELLTOywKUH97cEU=;
 b=HUk6F0vVthGVQfKnycMtSsA2+SqPB6aDfpEtHGOYXxkg3iy7YnS2JUt11ViJqnk06OQ2Ma
 Z5W/nfh7Y93Ue20A/Aje6W4CvCQiTjF0rYYxfV6kfm0091vgqkjuU20JDE9LZJxKx1B+Rr
 9WItkrFAo+cj8Dien+EFYSyFSODAHGc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-DE6_No9GMo-apWmbeTrIGg-1; Tue, 14 May 2024 04:57:17 -0400
X-MC-Unique: DE6_No9GMo-apWmbeTrIGg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c998fbbac5so5355103b6e.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 01:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715677036; x=1716281836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PIIPyu82OG2zp3cmolu7CNKPHImQELLTOywKUH97cEU=;
 b=n7jJYisWD+P9BZo59aL9txMpdEZQIJ3W7vuDkkpLObBC552zUyrh10pWXZfc9EY70j
 MvAkpaDg8AGuyoAcBQhqmdxy82pYkdodxAtjElYONDIgI2xSnbAtjNVNAjEt0bnAAmgY
 0DkyoQMIuKJRhKFV5AW9NCTyhAo8dfj6VaqEYS3Skb9EPWaJL+YLXSgCVrMo19U8ufkR
 oOc/XddnaeGH+qUb6X3Ser7uXwybCwGeQmVyTLlk7qSD/kbzVZ0ByUsYjZ9gMntkdgm0
 zkCxFRcjvTuNKT8jnzC01cmBSZwGVDOYUkl54DBPXQbUQc/5Gva5pxPcUZj2hMG3OIQL
 DVMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuxdL0rT4e1IymN9W2kRkad5jFLB1/2dB30ijvsDstmP5q5RODJOFIO/LJC70HaSqwojGsXU2BTVUZ4iPeyOCe5cxTdpw=
X-Gm-Message-State: AOJu0YwbIObkpC+UUxsPd3uW6sdDiROXiLTqlxe1vQWiFJG2NYI0ViHb
 Wq5BIqJZOMfskEG8N6k+xwKvJHNNWR+U09AP/x38jFDmkrWIznkmdp5UwkIq8SLgigFjAKubtVA
 a1ZTq0zXEdlDqsjTrs3JKADE909QRt/n3bpB6LRYB8aZnl2wFq3/A
X-Received: by 2002:a05:6808:1415:b0:3c9:92ba:fd0a with SMTP id
 5614622812f47-3c9970ce727mr14954591b6e.38.1715677035743; 
 Tue, 14 May 2024 01:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjoeRiDATw+A27Sep6W+tK53v3+xQORzfAPE5YOrDkyWt2d0hZgxz8k6pGfs8GPq+ga+cuug==
X-Received: by 2002:a05:6808:1415:b0:3c9:92ba:fd0a with SMTP id
 5614622812f47-3c9970ce727mr14954567b6e.38.1715677034970; 
 Tue, 14 May 2024 01:57:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a3af8sm543252985a.63.2024.05.14.01.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 01:57:14 -0700 (PDT)
Message-ID: <57318f0e-2446-4843-9c99-cc6e74916165@redhat.com>
Date: Tue, 14 May 2024 10:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] memory: Add Error** argument to
 memory_get_xlat_addr()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-8-clg@redhat.com>
 <608bf953-3a75-4edf-8b82-3fa53f7f2dbb@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <608bf953-3a75-4edf-8b82-3fa53f7f2dbb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On 5/13/24 15:44, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Let the callers do the reporting. This will be useful in
>> vfio_iommu_map_dirty_notify().
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/exec/memory.h  | 15 ++++++++++++++-
>>   hw/vfio/common.c       | 13 +++++++++----
>>   hw/virtio/vhost-vdpa.c |  5 ++++-
>>   system/memory.c        | 10 +++++-----
>>   4 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index dadb5cd65ab58b4868fcae06b4e301f0ecb0c1d2..2c45051b7b419c48b4e14c25f4d16a99ccd23996 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -774,9 +774,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>>   void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>                                                RamDiscardListener *rdl);
>>
>> +/**
>> + * memory_get_xlat_addr: Extract addresses from a TLB entry
>> + *
>> + * @iotlb: pointer to an #IOMMUTLBEntry
>> + * @vaddr: virtual addressf
> 
> Nit: s/addressf/address

Fixed.


Thanks,

C.


> 
> Thanks.
> 
>> + * @ram_addr: RAM address
>> + * @read_only: indicates if writes are allowed
>> + * @mr_has_discard_manager: indicates memory is controlled by a
>> + *                          RamDiscardManager
>> + * @errp: pointer to Error*, to store an error if it happens.
>> + *
>> + * Return: true on success, else false setting @errp with error.
>> + */
>>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                             ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager);
>> +                          bool *mr_has_discard_manager, Error **errp);
>>
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b929bb0b7ac60dcef34c0d5a098d5d91f75501dd..da748563eb33843e93631a5240759964f33162f2 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -253,12 +253,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>
>>   /* Called with rcu_read_lock held.  */
>>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                               ram_addr_t *ram_addr, bool *read_only)
>> +                               ram_addr_t *ram_addr, bool *read_only,
>> +                               Error **errp)
>>   {
>>       bool ret, mr_has_discard_manager;
>>
>>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager);
>> +                               &mr_has_discard_manager, errp);
>>       if (ret && mr_has_discard_manager) {
>>           /*
>>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>> @@ -288,6 +289,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>>       void *vaddr;
>>       int ret;
>> +    Error *local_err = NULL;
>>
>>       trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>>                                   iova, iova + iotlb->addr_mask);
>> @@ -304,7 +306,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>>
>> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
>> +            error_report_err(local_err);
>>               goto out;
>>           }
>>           /*
>> @@ -1213,6 +1216,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>>       ram_addr_t translated_addr;
>> +    Error *local_err = NULL;
>>       int ret = -EINVAL;
>>
>>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>> @@ -1224,7 +1228,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>
>>       rcu_read_lock();
>> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> +        error_report_err(local_err);
>>           goto out_lock;
>>       }
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index e827b9175fc61f1ef419e48d90a440b00449312a..ed99ab87457d8f31b98ace960713f48d47b27102 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -208,6 +208,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       void *vaddr;
>>       int ret;
>>       Int128 llend;
>> +    Error *local_err = NULL;
>>
>>       if (iotlb->target_as != &address_space_memory) {
>>           error_report("Wrong target AS \"%s\", only system memory is allowed",
>> @@ -227,7 +228,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>>
>> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
>> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> +                                  &local_err)) {
>> +            error_report_err(local_err);
>>               return;
>>           }
>>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>> diff --git a/system/memory.c b/system/memory.c
>> index 49f1cb2c3835f78f5f948531cbbf13adc706f1ad..e2b9f0aa9ea7326a5bedde28b8c777cf86bc253e 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2179,7 +2179,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>   /* Called with rcu_read_lock held.  */
>>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                             ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager)
>> +                          bool *mr_has_discard_manager, Error **errp)
>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>> @@ -2197,7 +2197,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>       mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
>>                                    &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>>       if (!memory_region_is_ram(mr)) {
>> -        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
>> +        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
>>           return false;
>>       } else if (memory_region_has_ram_discard_manager(mr)) {
>>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
>> @@ -2216,8 +2216,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>            * were already restored before IOMMUs are restored.
>>            */
>>           if (!ram_discard_manager_is_populated(rdm, &tmp)) {
>> -            error_report("iommu map to discarded memory (e.g., unplugged via"
>> -                         " virtio-mem): %" HWADDR_PRIx "",
>> +            error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
>> +                         " via virtio-mem): %" HWADDR_PRIx "",
>>                            iotlb->translated_addr);
>>               return false;
>>           }
>> @@ -2228,7 +2228,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>        * check that it did not truncate too much.
>>        */
>>       if (len & iotlb->addr_mask) {
>> -        error_report("iommu has granularity incompatible with target AS");
>> +        error_setg(errp, "iommu has granularity incompatible with target AS");
>>           return false;
>>       }
>>
>> -- 
>> 2.45.0
>>
> 


