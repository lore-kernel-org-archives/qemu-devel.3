Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B396C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOrp-0005Nd-0T; Mon, 27 Jan 2025 08:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcOrj-0005KQ-4L
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:09:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tcOrh-0001iw-GY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737983358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wTTWvJPtKVoF6iXSgvgp/3855piVuUQyBtdCJQN3lFo=;
 b=aKIs9eNZF5Vn95SziK28ys7C/CMhR1rrFH+h1c9l4Zk9ECZ4h4LvDdW4bmm5rPiZqsybfS
 T7Tz8SA2mOQ1jG+GPOHUz1b0eeuSJ5N/LJK+X0TwySHAxaDeeqwtCti93yfVAahVLefakO
 9rkxLlbGxYtbqavrhxBzj9jbZMfg4rs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-rC-jCCHQO42Fyp-unZ9S1w-1; Mon, 27 Jan 2025 08:09:16 -0500
X-MC-Unique: rC-jCCHQO42Fyp-unZ9S1w-1
X-Mimecast-MFC-AGG-ID: rC-jCCHQO42Fyp-unZ9S1w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so1723300f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737983355; x=1738588155;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wTTWvJPtKVoF6iXSgvgp/3855piVuUQyBtdCJQN3lFo=;
 b=SyjXjjW7ZTPevBjUeWK69d+lUQLYIpXiAP9MSxbzJu+2tpUR9MZDsqd6UvwNkrXpAP
 iTc1NshCzfH5Rr7srkyJ/y5sZC2w5YhpakOjJuka2Szi4CB0r0GAf3yXQjJMjwkxuWRu
 7vz2eWYOYnqBBtbVl4aqq9ITZ+JAEslifgkiWgMgDx4xAWA77hunQGvMtuJUdcDJP4P9
 M7ymVFNYR8cxg87K7RxOA6z2Usy1w9GwfBQxUjwnQJ7rx7WXiW+9XIkSsjCzahMgIM22
 2aE3jVnYq4MsTDxw2xC6ZcC8lpEfEeajA0f3rIwj9EfX4DiEemTn+T5VTzG6f+UebVV5
 O4+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfpAuyFXuJyW4luxvzhGQfMcF+qbZ/55meyF7lbRCobFO4GJfF9nVMa3EtT8u4gz+EIoywEwcn8EDA@nongnu.org
X-Gm-Message-State: AOJu0YzDHEZ90ArO+0xyfCSAAc69eUKI/1fG8xcjpGvZdQq1zaEVG9O2
 ilAvEitMvAj2MkWJwmIZv93RUeB0xfWuxEPGMtOjIdIbOXjxnRKPhRZBeNUOIl5OaaL/thjNpbO
 V8N84wtvpbtDIly3xOEjgoQb30Yu8MHcQ1T+PCo53X6mNWqeOr0uB
X-Gm-Gg: ASbGncslzNR41xas5s8GOLunUbidMENGlrTae1HILiNUwMRhvi8TBoLXeCPW6Y37f7G
 wgjDtxj8StlNfVbwV/OyVNnuOYFrPJyH8xp95Z6dzr06mfXavlxPxx+EsHmKB9AnOEg0oGek7U4
 6DRX4hdJIGrkgHDp638w0wJy+UhSq4MejQZgBptwxgkh5hvyAgbXCstvq/e+JJHXyRCpj/KG6qU
 Ag5ZF3Dp+kEwYoNr6YvY1k2gPWN5rd5lQiP6gZjfEDscN0yWbXVszL9CPr96EBzfFi9wBrUCCUW
 jFBl/oJq5HnkwsQ1EyWAWgcaodeGDdlwHdtiVQVoUVr/ZRaXisU4dsTGGkrf74QjIGqIHwRAsK+
 vc5boIZItI6EOXCnx4dBWF9fGoDorlSMe
X-Received: by 2002:a05:6000:1fab:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38bf5656e01mr32673006f8f.11.1737983355144; 
 Mon, 27 Jan 2025 05:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/EY5BnO4EoIJyCBqP2fZgoVrW97x7tX98LJwFJpLdU+gaETa5BE1lID5+v9+XINk6xxZzbg==
X-Received: by 2002:a05:6000:1fab:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38bf5656e01mr32672983f8f.11.1737983354665; 
 Mon, 27 Jan 2025 05:09:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c?
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d70bsm11339651f8f.33.2025.01.27.05.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 05:09:13 -0800 (PST)
Message-ID: <cbe2a998-dc7d-4e86-8da6-659759f1b0cd@redhat.com>
Date: Mon, 27 Jan 2025 14:09:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250124202115.349386-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24.01.25 21:21, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitate this, pin the entirety of
> guest memory into the host iommu.
> 
> Pinning for the direct mapping case is handled via vfio and its memory
> listener.  Additionally, ram discard settings are inherited from vfio:
> coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
> discards (e.g. virtio-balloon) are disabled.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 36 +++++++++++++++++++++++++++++++--
>   hw/s390x/s390-pci-inst.c        | 13 ++++++++++--
>   hw/s390x/s390-pci-vfio.c        | 15 ++++++++++----
>   hw/s390x/s390-virtio-ccw.c      |  5 +++++
>   include/hw/s390x/s390-pci-bus.h |  4 ++++
>   5 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index eead269cc2..8cf5aec1a2 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -18,6 +18,8 @@
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-kvm.h"
>   #include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -720,16 +722,44 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>                                name, iommu->pal + 1);
>       iommu->enabled = true;
> +    iommu->direct_map = false;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }
>   
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Rather
> +     * than using an iommu, create a memory region alias that maps GPA X to
> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
> +     */
> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
> +                                            iommu->pbdev->uid);
> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
> +                             0, s390_get_memory_limit(s390ms));

Hm, the memory limit can exceed  ms->ram.

Would it be possible to use get_system_memory() here, such that whatever 
is mapped into physical address space (including virtio-mem devices etc) 
would simply be aliased with an offset?

Or does that blow up elsewhere?

target/i386/kvm/kvm.c seems to do that:

memory_region_init_alias(&smram_as_mem, OBJECT(kvm_state), "mem-smram",
			 get_system_memory(), 0, ~0ull);

and target/i386/tcg/system/tcg-cpu.c

-- 
Cheers,

David / dhildenb


