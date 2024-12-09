Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6126FE77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKktC-0000EH-LU; Mon, 09 Dec 2024 16:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKktB-0000DO-CA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKkt8-0005ae-A7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733778111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i6clBvHR5Whm3ZU/rPeGIOnTcU2VsgSjP63LbfcGTFs=;
 b=gxrH+l8k9ZmTKlu8Ts/jxwUzzncC6TfWi/xMfl1Z9VG3TghNb52nggd241Je5kDn3TV+8J
 iInL/Q9K9nJkh5bho0Le7KsM81i2u0uDadYA05dtKB39Zh3XCw2estIXPGMq5Huqri5sCY
 xDa/pZQ44DnkBvDY04dZ9XLapHsg6Nw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-_p4_zzw1NnqI2XGcWexwDg-1; Mon, 09 Dec 2024 16:01:50 -0500
X-MC-Unique: _p4_zzw1NnqI2XGcWexwDg-1
X-Mimecast-MFC-AGG-ID: _p4_zzw1NnqI2XGcWexwDg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434e9e1b4d7so14201005e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778109; x=1734382909;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i6clBvHR5Whm3ZU/rPeGIOnTcU2VsgSjP63LbfcGTFs=;
 b=nCTwSPraRdf5CjAwNqDzj0Xk+S2bt9/PLidMiYMSOaSQ+hj3xPiZEYUkHMqAQzY+8N
 9gTCWYXjPWElHYMUgM0mM+pmkgpLxegJUOI7hLT8+JebsufXnC7jrc4y8bd7JDjFHZ18
 n6jui1k0VwtseCxo9xaoVEGIHUolwr4AnZN5LO+ESdntGuKErmROUH5v9Kbu6RQXUkIE
 I9FwBMOfqyT89nFI1SBspqVOdrX26fDi9VSgirgVEXo2fLv3ft899dKx7jU7Wo0K7tlt
 KYwbhdTs38Y7WHC5rRTsrtTLamqGMbiCY9T1qoa18NQs/fjA5fwK2iF81FzgGPiCEXkZ
 5Ukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGFrCmauU4HNLyxdTYFFPknYoyDVX6HRw/iI3HS1AL5IbJsFTWcOs4VSxE8ktsQ/u/CnB43GlEaK1B@nongnu.org
X-Gm-Message-State: AOJu0Yy2hfEOmkiiAYKByf38jh59ONeTjgvgt08Y0OJTHz+T2j3GbUcB
 ivWzCz3Xi5I33i/JPjVwdtnfxQBYNGt+Wnm6oKn+c4eAURT1odvHQNPFOY6y7D4HyMPTAxJR9MC
 KaIdMJy4mUBIN8xZOgyCiIdeva+YoI7mbaKG1z1mWskrD2OVfXthlhTCTPi/Q
X-Gm-Gg: ASbGncug/kRDximHgLf+NY771PoqREk0ICUdeNb3aFwDgcnuGPDDS9XcF0hjwsMEJkp
 9pyBzfgAnKV+aii+3r5+hKZw6QZKPzew0ulsSvh7UOgjnqGw/1ILI7MisrqxikWX3S1tw35eePr
 VJ8l2a9mbrgSESW1XYK/aV4A3DXfHUR37PpId/a52Cj04B9Du+7oO6sgYRc8RhDkcGbP6Do2MC3
 3aM3OXy7ABX994uMWslGPoYUypf6GAQ4M4ONFYEx/gQdRB2CmtyAvpnhGxafFslf0DVs/2rStfz
 cJpTRnW6iK3s1A92LjKqpSFM068Y7rXKDwCdO55p55rvdQM2W3SfvRHCqCo0129gT9xQjD6zLnR
 vgiQLng==
X-Received: by 2002:a05:600c:5799:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-434dded7708mr107088175e9.24.1733778108023; 
 Mon, 09 Dec 2024 13:01:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDMgagaVYiZSqmu+ovF/FzTtyahO1tw63aRx0ChAswS6mZpTEN+4/jLj5FRDE3btdIzZBpdg==
X-Received: by 2002:a05:600c:5799:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-434dded7708mr107087785e9.24.1733778107539; 
 Mon, 09 Dec 2024 13:01:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65?
 (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de.
 [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f0a7e6e1sm86712525e9.36.2024.12.09.13.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:01:46 -0800 (PST)
Message-ID: <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
Date: Mon, 9 Dec 2024 22:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241209192927.107503-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 09.12.24 20:29, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitiate this, pin the entirety of
> guest memory into the host iommu.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 23 ++++++++++++++++++
>   hw/s390x/s390-pci-inst.c        | 42 +++++++++++++++++++++++++++++++--
>   include/hw/s390x/s390-pci-bus.h |  2 ++
>   3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 40b2567aa7..8d4224e032 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -18,6 +18,7 @@
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-kvm.h"
>   #include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -720,6 +721,27 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>                                name, iommu->pal + 1);
>       iommu->enabled = true;
> +    iommu->direct_map = false;
> +    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
> +    g_free(name);
> +}
> +
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Because
> +     * the mappings are contiguous we are not restricted to individual 4K
> +     * mappings via vfio, so let's not worry about the DMA limit when
> +     * calculating the range.
> +     */
> +    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
> +    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
> +                             TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> +                             name, iommu->pba + ms->ram_size);
> +    iommu->enabled = true;
> +    iommu->direct_map = true;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }
> @@ -727,6 +749,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
>   {
>       iommu->enabled = false;
> +    iommu->direct_map = false;
>       g_hash_table_remove_all(iommu->iotlb);
>       memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
>       object_unparent(OBJECT(&iommu->iommu_mr));
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 41655082da..f4d8fe8fe8 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -16,6 +16,7 @@
>   #include "exec/memory.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/hw_accel.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> @@ -990,6 +991,33 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +static void s390_pci_setup_stage2_map(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint64_t remain = ms->ram_size, start = iommu->pba, mask, size, curr = 0;
> +    uint64_t end = start + remain - 1;
> +    IOMMUTLBEvent event = {
> +        .type = IOMMU_NOTIFIER_MAP,
> +        .entry = {
> +            .target_as = &address_space_memory,
> +            .translated_addr = 0,
> +            .perm = IOMMU_RW,
> +        },
> +    };
> +
> +    while (remain >= TARGET_PAGE_SIZE) {
> +        mask = dma_aligned_pow2_mask(start, end, 64);
> +        size = mask + 1;
> +        event.entry.iova = start;
> +        event.entry.addr_mask = mask;
> +        event.entry.translated_addr = curr;
> +        memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
> +        start += size;
> +        curr += size;
> +        remain -= size;
> +    }
> +}

Hi,

Trying to wrap my head around that ... you mention that "pin the 
entirety of guest memory".

Do you mean that we will actually end up longterm pinning all guest RAM 
in the kernel, similar to what vfio ends up doing?

In that case, it would be incompatible with virtio-balloon (and without 
modifications with upcoming virtio-mem). Is there already a mechanism in 
place to handle that -- a call  to ram_block_discard_disable() -- or 
even a way to support coordinated discarding of RAM (e.g., virtio-mem + 
vfio)?

-- 
Cheers,

David / dhildenb


