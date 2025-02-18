Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B49AC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkL7W-0006e4-DD; Tue, 18 Feb 2025 05:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tkL7U-0006de-HF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tkL7S-00023G-Gm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739875585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A959PzUSW5eOj4GPBGmEAK66kpWU43NeHWzF7rtp1Gs=;
 b=MRkd/s/dQONJNuMuGsbrnMXddur7rCUMvXVCSLQ5Kn0oc4Pu/+B9mCXQFw2U7qJtoDwx3J
 SVgv5mGr6xdO8uUGKQpflURxrAWpFcmXtHKcrvboP5N1OcUJCfuknZeXhEH/VJfzZa7X0k
 EPR6blFhiKVLjAPtL0FM4rp5eG2Qirg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-HQ2_TKLsONSp5DvHAnZzGw-1; Tue, 18 Feb 2025 05:46:24 -0500
X-MC-Unique: HQ2_TKLsONSp5DvHAnZzGw-1
X-Mimecast-MFC-AGG-ID: HQ2_TKLsONSp5DvHAnZzGw_1739875583
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso42582815e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739875583; x=1740480383;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A959PzUSW5eOj4GPBGmEAK66kpWU43NeHWzF7rtp1Gs=;
 b=R6+yYHn+AMqu16H0fIRu6vZnL3Sougdw7x7oYiqfpXLk8QibE+wDf3t959Vkrjhn60
 g1CMn4tpn73it+mA1VUoC9NcE/mO4WfTc2CBHMvPpoBmOz4pIiWUCm0jySr3DxRdRR/0
 QGR7ZASMhtFodkwGLsKJ19ebTucFvjC/svYayEj879mG8se26d/FBIVn8SmXDXhdQ0dG
 TDkud5UMtL5OuC9aQyMIsbuNaCN/ZvRyRuaZ+zTEEsWNKXKvTD1CUec5i+CjO/AwZPtK
 5VjHz2cyybX9bcynn8dQ9hpSodXD86eWvCqjOWIUz7VbFJHA6W9vLupHMtAMR8dgoqGq
 egCg==
X-Gm-Message-State: AOJu0YwLYV3mGKA7TJWjFgvfba5GG+0V+FmDyX0lunkgTemHy/09rLPb
 NWDvNMJLBztZhURigSCesFPQ984RzcLzNK8+GnlD6pT8W4oVtwzazFuKIvvVbITyV+tyUDCar5A
 4NrIwfE6RXok0SpdgLkp/YDV6K+q/qyMWlEgzBrcFOm5sr59aalgm
X-Gm-Gg: ASbGncskGd5W/GLNOo+u2ehyZ+vXbvihc3QdqlX0sk78yleVPoo93PbABx6NY5bhhRO
 iuv7qCNnYESalSLlvnXVPf6no3qK0Eq42OZelurdWJNFUTSDljZvm7AL69J/53IFuCAkblokFNF
 RxNThf2of9B+Xm75juMDF4ldnG2H+v68rAJ/wlqrHyBZhv4t7kfQ0SoPwXF20whkV4bh/b23Z8r
 Up91czqZLOETyhaQkEWobhKa5L0Q0LFkVtwqlDo9MbqNrbCSd0Q4cJP7Apm4bePFSevXAwc2yUq
 1Qw/hDE6mC5BuTpUkIQEexIp1NAV/wJcMC2NYpzTECtStX8Y5l276zFVJ2NHjakrFm9gc8QiTPD
 EUrCsc5JnxMyB4Le012KWMmGiOq2TQuW2
X-Received: by 2002:a05:600c:4fce:b0:439:3d5c:8c19 with SMTP id
 5b1f17b1804b1-4396e717094mr111636995e9.24.1739875582853; 
 Tue, 18 Feb 2025 02:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1lG5mvmi5WhUs2+rkljpLbWUkz7DNrDKjsDhndt8X1Ma6VZxi9Bg1HMZYm3jRH0V2pJSmMQ==
X-Received: by 2002:a05:600c:4fce:b0:439:3d5c:8c19 with SMTP id
 5b1f17b1804b1-4396e717094mr111636515e9.24.1739875582280; 
 Tue, 18 Feb 2025 02:46:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af?
 (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de.
 [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43959d3d5f3sm178381635e9.0.2025.02.18.02.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 02:46:21 -0800 (PST)
Message-ID: <c33e4daf-0eb6-4e8c-8df7-be33c2807c6d@redhat.com>
Date: Tue, 18 Feb 2025 11:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] memory: Change
 memory_region_set_ram_discard_manager() to return the result
To: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250217081833.21568-1-chenyi.qiang@intel.com>
 <20250217081833.21568-3-chenyi.qiang@intel.com>
 <10029ca9-a239-4d3f-9999-e1059bc17d85@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <10029ca9-a239-4d3f-9999-e1059bc17d85@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.02.25 10:19, Alexey Kardashevskiy wrote:
> 
> 
> On 17/2/25 19:18, Chenyi Qiang wrote:
>> Modify memory_region_set_ram_discard_manager() to return false if a
>> RamDiscardManager is already set in the MemoryRegion. The caller must
>> handle this failure, such as having virtio-mem undo its actions and fail
>> the realize() process. Opportunistically move the call earlier to avoid
>> complex error handling.
>>
>> This change is beneficial when introducing a new RamDiscardManager
>> instance besides virtio-mem. After
>> ram_block_coordinated_discard_require(true) unlocks all
>> RamDiscardManager instances, only one instance is allowed to be set for
>> a MemoryRegion at present.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>> Changes in v2:
>>       - newly added.
>> ---
>>    hw/virtio/virtio-mem.c | 30 +++++++++++++++++-------------
>>    include/exec/memory.h  |  6 +++---
>>    system/memory.c        | 11 ++++++++---
>>    3 files changed, 28 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index 21f16e4912..ef818a2cdf 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -1074,6 +1074,18 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>>                            vmem->block_size;
>>        vmem->bitmap = bitmap_new(vmem->bitmap_size);
>>    
>> +    /*
>> +     * Set ourselves as RamDiscardManager before the plug handler maps the
>> +     * memory region and exposes it via an address space.
>> +     */
>> +    if (memory_region_set_ram_discard_manager(&vmem->memdev->mr,
>> +                                              RAM_DISCARD_MANAGER(vmem))) {
>> +        error_setg(errp, "Failed to set RamDiscardManager");
>> +        g_free(vmem->bitmap);
>> +        ram_block_coordinated_discard_require(false);
>> +        return;
>> +    }
> 
> Looks like this can move before vmem->bitmap is allocated (or even
> before ram_block_coordinated_discard_require(true)?). Then you can drop
> g_free() and avoid having a stale pointer in vmem->bitmap (not that it
> matters here though).
> 
>> +
>>        virtio_init(vdev, VIRTIO_ID_MEM, sizeof(struct virtio_mem_config));
>>        vmem->vq = virtio_add_queue(vdev, 128, virtio_mem_handle_request);
>>    vmem->bitmap
>> @@ -1124,13 +1136,6 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>>        vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
>>        vmem->system_reset->vmem = vmem;
>>        qemu_register_resettable(obj);
>> -
>> -    /*
>> -     * Set ourselves as RamDiscardManager before the plug handler maps the
>> -     * memory region and exposes it via an address space.
>> -     */
>> -    memory_region_set_ram_discard_manager(&vmem->memdev->mr,
>> -                                          RAM_DISCARD_MANAGER(vmem));
>>    }
>>    
>>    static void virtio_mem_device_unrealize(DeviceState *dev)
>> @@ -1138,12 +1143,6 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
>>        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>        VirtIOMEM *vmem = VIRTIO_MEM(dev);
>>    
>> -    /*
>> -     * The unplug handler unmapped the memory region, it cannot be
>> -     * found via an address space anymore. Unset ourselves.
>> -     */
>> -    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
>> -
>>        qemu_unregister_resettable(OBJECT(vmem->system_reset));
>>        object_unref(OBJECT(vmem->system_reset));
>>    
>> @@ -1155,6 +1154,11 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
>>        host_memory_backend_set_mapped(vmem->memdev, false);
>>        virtio_del_queue(vdev, 0);
>>        virtio_cleanup(vdev);
>> +    /*
>> +     * The unplug handler unmapped the memory region, it cannot be
>> +     * found via an address space anymore. Unset ourselves.
>> +     */
>> +    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
>>        g_free(vmem->bitmap);
>>        ram_block_coordinated_discard_require(false);
>>    }
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 3bebc43d59..390477b588 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2487,13 +2487,13 @@ static inline bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
>>     *
>>     * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
>>     * that does not cover RAM, or a #MemoryRegion that already has a
>> - * #RamDiscardManager assigned.
>> + * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
>>     *
>>     * @mr: the #MemoryRegion
>>     * @rdm: #RamDiscardManager to set
>>     */
>> -void memory_region_set_ram_discard_manager(MemoryRegion *mr,
>> -                                           RamDiscardManager *rdm);
>> +int memory_region_set_ram_discard_manager(MemoryRegion *mr,
>> +                                          RamDiscardManager *rdm);
>>    
>>    /**
>>     * memory_region_find: translate an address/size relative to a
>> diff --git a/system/memory.c b/system/memory.c
>> index b17b5538ff..297a3dbcd4 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2115,12 +2115,17 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
>>        return mr->rdm;
>>    }
>>    
>> -void memory_region_set_ram_discard_manager(MemoryRegion *mr,
>> -                                           RamDiscardManager *rdm)
>> +int memory_region_set_ram_discard_manager(MemoryRegion *mr,
>> +                                          RamDiscardManager *rdm)
>>    {
>>        g_assert(memory_region_is_ram(mr));
>> -    g_assert(!rdm || !mr->rdm);
>> +    if (mr->rdm && rdm != NULL) {
> 
> Drop "!= NULL".
> 
>> +        return -1;
> 
> -EBUSY?
> 
>> +    }
>> +
>> +    /* !rdm || !mr->rdm */
> 
> See, like here - no "!= NULL" :) (and the comment is useless). Thanks,
> 
> 
>>        mr->rdm = rdm;
>> +    return 0;
>>    }
>>    
>>    uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
> 


Agreed to all, with that it LGTM, thanks!

-- 
Cheers,

David / dhildenb


