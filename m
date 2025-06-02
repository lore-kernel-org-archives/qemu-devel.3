Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D631CC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 21:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMCRA-0000pS-8c; Mon, 02 Jun 2025 17:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMCR3-0000oD-VM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMCQv-0004Og-Om
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748898656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OzQhT/qXyjZ2tB40NxqOTXT2Lyi6oiwytVUne15HM9g=;
 b=i7KOcwzB7dVN5NLkkr8ldLQMBwsnpZY/eim/j0TCFNh7M9KiOsTesQCSVGZ7A9/DEHR5Bc
 +R6LA/LIFDT7c534JrT1C39CV5uZbKnD5hiUX0rrsd+amFm2SdIZ6UQtUPEdyZ3czC1s/U
 zu8gEciqt6W+tdSGXTUA/5HIaTsreUE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-dH5B7glQMkOFLqmQEoFAdQ-1; Mon, 02 Jun 2025 17:10:54 -0400
X-MC-Unique: dH5B7glQMkOFLqmQEoFAdQ-1
X-Mimecast-MFC-AGG-ID: dH5B7glQMkOFLqmQEoFAdQ_1748898654
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so29776055e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 14:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748898653; x=1749503453;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OzQhT/qXyjZ2tB40NxqOTXT2Lyi6oiwytVUne15HM9g=;
 b=wJGVSrCupIH+Y4BfkYPIAvIKW+UpnKkEhu3B8qzP0mnL55qV/zwiMSQ9TygfSbRXcT
 esrPc/3pnXtRgXDkpnJqzn9q/nu+qaVatXCck/j79z3piT2YTSMOYU6FSjkGFDaq39c3
 ZKgEN+YeceY58Y5sVrAqdxCwCBg7CgJFx9xr/ToPOwwZujV1ojizVXcqdS3bLd4pzCMP
 H1TyPw8RRtTgYuNTSuPtnzhWzUrTsHfJlv6gem9WNeMSHl1lNEY7gYPvYLWhR0w0bjUI
 f7DjB0pDqMsH6id8pvVmNyNTrK88jTZrXZEWTRgzT5EiX8zWc+BHdwSSn9LO7a6CKb4g
 8aBQ==
X-Gm-Message-State: AOJu0YzBPL201tOCb7XIP/ab7dNktkH1FjUHVXTIoUMu2t0L7oGwBLg7
 LfvvYTsd5BydiP4X8DRiNmONEuXWP8+wYC132iN+7uixGiGCPbga7VIKnlWAoxLzLkk3fjzTs07
 zGvcc0hPBMqTagUXV2mOPXL2lKvooy9PGZcidC8R6dm+Mbp42wEnJXzII
X-Gm-Gg: ASbGncssRP2lSZXxWpLpYEXZDKxOBAfpABSyOrC9xNzbgn8SLCXeJGXE7CCZ8dIE+Vu
 ZJIZ8SwNLtrWfwADlwe/TDouuKsYWXbOtEnTt7AlOWDTAj4JxYdsyNCCdemotcEJHZF7aBDO3ev
 oJtJvY3ulbjrdvL/NfTZMJjGNN73N9vF3OsYfVXnHKUmNTlsd7UIt1urFRHL7T6cm+KSVYX/IRP
 hekng0qHTk7ZIyfvyDWP8U4QTVIVlHzFsapmVqdvlGWzk+qS7WDVWwkEvlgTbGaW4NCo4VPQn1e
 YJp4Vj829tgE3s91pg2UQdr1pyalSLxIXzKtTKEICoBE1VlINjQOv3YlMXWHIAsJdv4nfH68CFu
 IkhijjAXmsE05+WHFjFzGKZggSifcaZ5vCzqDlsM=
X-Received: by 2002:a05:600c:5294:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-450d883b9admr121721445e9.13.1748898653530; 
 Mon, 02 Jun 2025 14:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn3HgJukX8eJRxBQZddzjAWn8SPEFrZCYlCmhbjON02y2UdyFHpnwRUCVi40uKvOcZ82Auhw==
X-Received: by 2002:a05:600c:5294:b0:43c:f513:958a with SMTP id
 5b1f17b1804b1-450d883b9admr121721315e9.13.1748898653137; 
 Mon, 02 Jun 2025 14:10:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e?
 (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de.
 [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb00ccsm136512135e9.17.2025.06.02.14.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 14:10:52 -0700 (PDT)
Message-ID: <2278c8cb-a547-4f8d-a8fb-cce38fa3b5f2@redhat.com>
Date: Mon, 2 Jun 2025 23:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] ram-block-attributes: Introduce RamBlockAttributes
 to manage RAMBlock with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250530083256.105186-1-chenyi.qiang@intel.com>
 <20250530083256.105186-5-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250530083256.105186-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 30.05.25 10:32, Chenyi Qiang wrote:
> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
> discard") highlighted that subsystems like VFIO may disable RAM block
> discard. However, guest_memfd relies on discard operations for page
> conversion between private and shared memory, potentially leading to
> the stale IOMMU mapping issue when assigning hardware devices to
> confidential VMs via shared memory. To address this and allow shared
> device assignement, it is crucial to ensure the VFIO system refreshes
> its IOMMU mappings.
> 
> RamDiscardManager is an existing interface (used by virtio-mem) to
> adjust VFIO mappings in relation to VM page assignment. Effectively page
> conversion is similar to hot-removing a page in one mode and adding it
> back in the other. Therefore, similar actions are required for page
> conversion events. Introduce the RamDiscardManager to guest_memfd to
> facilitate this process.
> 
> Since guest_memfd is not an object, it cannot directly implement the
> RamDiscardManager interface. Implementing it in HostMemoryBackend is
> not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
> have a memory backend while others do not. Notably, virtual BIOS
> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
> backend.
> 
> To manage RAMBlocks with guest_memfd, define a new object named
> RamBlockAttributes to implement the RamDiscardManager interface. This
> object can store the guest_memfd information such as bitmap for shared
> memory and the registered listeners for event notification. In the
> context of RamDiscardManager, shared state is analogous to populated, and
> private state is signified as discarded. To notify the conversion events,
> a new state_change() helper is exported for the users to notify the
> listeners like VFIO, so that VFIO can dynamically DMA map/unmap the
> shared mapping.
> 
> Note that the memory state is tracked at the host page size granularity,
> as the minimum conversion size can be one page per request and VFIO
> expects the DMA mapping for a specific iova to be mapped and unmapped
> with the same granularity. Confidential VMs may perform partial
> conversions, such as conversions on small regions within larger ones.
> To prevent such invalid cases and until DMA mapping cut operation
> support is available, all operations are performed with 4K granularity.
> 
> In addition, memory conversion failures cause QEMU to quit instead of
> resuming the guest or retrying the operation at present. It would be
> future work to add more error handling or rollback mechanisms once
> conversion failures are allowed. For example, in-place conversion of
> guest_memfd could retry the unmap operation during the conversion from
> shared to private. For now, keep the complex error handling out of the
> picture as it is not required.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v6:
>      - Change the object type name from RamBlockAttribute to
>        RamBlockAttributes. (David)
>      - Save the associated RAMBlock instead MemoryRegion in
>        RamBlockAttributes. (David)
>      - Squash the state_change() helper introduction in this commit as
>        well as the mixture conversion case handling. (David)
>      - Change the block_size type from int to size_t and some cleanup in
>        validation check. (Alexey)
>      - Add a tracepoint to track the state changes. (Alexey)
> 
> Changes in v5:
>      - Revert to use RamDiscardManager interface instead of introducing
>        new hierarchy of class to manage private/shared state, and keep
>        using the new name of RamBlockAttribute compared with the
>        MemoryAttributeManager in v3.
>      - Use *simple* version of object_define and object_declare since the
>        state_change() function is changed as an exported function instead
>        of a virtual function in later patch.
>      - Move the introduction of RamBlockAttribute field to this patch and
>        rename it to ram_shared. (Alexey)
>      - call the exit() when register/unregister failed. (Zhao)
>      - Add the ram-block-attribute.c to Memory API related part in
>        MAINTAINERS.
> 
> Changes in v4:
>      - Change the name from memory-attribute-manager to
>        ram-block-attribute.
>      - Implement the newly-introduced PrivateSharedManager instead of
>        RamDiscardManager and change related commit message.
>      - Define the new object in ramblock.h instead of adding a new file.
> ---
>   MAINTAINERS                   |   1 +
>   include/system/ramblock.h     |  21 ++
>   system/meson.build            |   1 +
>   system/ram-block-attributes.c | 480 ++++++++++++++++++++++++++++++++++
>   system/trace-events           |   3 +
>   5 files changed, 506 insertions(+)
>   create mode 100644 system/ram-block-attributes.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dacd6d004..8ec39aa7f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3149,6 +3149,7 @@ F: system/memory.c
>   F: system/memory_mapping.c
>   F: system/physmem.c
>   F: system/memory-internal.h
> +F: system/ram-block-attributes.c
>   F: scripts/coccinelle/memory-region-housekeeping.cocci
>   
>   Memory devices
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index d8a116ba99..1bab9e2dac 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -22,6 +22,10 @@
>   #include "exec/cpu-common.h"
>   #include "qemu/rcu.h"
>   #include "exec/ramlist.h"
> +#include "system/hostmem.h"
> +
> +#define TYPE_RAM_BLOCK_ATTRIBUTES "ram-block-attributes"
> +OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttributes, RAM_BLOCK_ATTRIBUTES)
>   
>   struct RAMBlock {
>       struct rcu_head rcu;
> @@ -91,4 +95,21 @@ struct RAMBlock {
>       ram_addr_t postcopy_length;
>   };
>   
> +struct RamBlockAttributes {
> +    Object parent;
> +
> +    RAMBlock *ram_block;
> +
> +    /* 1-setting of the bitmap represents ram is populated (shared) */
> +    unsigned bitmap_size;
> +    unsigned long *bitmap;

So, initially, all memory starts out as private, correct?

I guess this mimics what kvm_set_phys_mem() ends up doing, when it does 
the kvm_set_memory_attributes_private() call.

So there is a short period of inconsistency, between creating the 
RAMBlock and mapping it into the PA space.

It might be wroth spelling that out / documenting it somewhere.

-- 
Cheers,

David / dhildenb


