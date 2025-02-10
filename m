Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CBC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV9b-0008VN-DD; Mon, 10 Feb 2025 09:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1thV9U-0008UL-Mr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1thV9S-0003Hs-VL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=evF202mqWnnMNYEWNlPDPYKUevieY3ts4NV1nPJV8HU=;
 b=L4Oo/z/IlQ5PCfbnu11bgFSPSTLfbefChml/qmf/VxxrXLJBgGbNPhCqHW2LtEykMzzeEJ
 ZX5cydTjGIGWLHgP+ZDTFiqCsAWBcIMTRFNJwfV890l0PFP6ldv35v8KgbHWtaGgiXUTDP
 lwsmVZYyrkqYfNDhSP31zwWBc+vtZTk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-w1E6Tqx7PbukRno8qioD0A-1; Mon, 10 Feb 2025 09:52:39 -0500
X-MC-Unique: w1E6Tqx7PbukRno8qioD0A-1
X-Mimecast-MFC-AGG-ID: w1E6Tqx7PbukRno8qioD0A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso3291235e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199158; x=1739803958;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=evF202mqWnnMNYEWNlPDPYKUevieY3ts4NV1nPJV8HU=;
 b=juy2XqsyeJRWnhMHCT17zdebpF3p5pWG3WTM8C45/NACrsb+j2X6yIrizKaixpm+eY
 Kq7k4qfnCn2vbviSPM70AT/i3RSQEMxVmnUHRpdR55NjymMGaxquoC0C6HIHw8qn6orB
 t04ICNGQcpWZkt6GsXTLarxLm+Z/8nR/jEj00XRGQE5Td/jcGnERdUuykP0FRHcoDuME
 8Jbf4ZrVKIFmHI8rK3IhDcNyC9ezyZd8SXERMOukGX+g6iGf/RA0DT5IhzVxH4wrDwHe
 cyHUo3EOMrQAwRWVTLNCyiVyvk7SJ1pK4E6yvcGLKj0ejnHcjwga7ANqwzSPPbng0MU4
 MCrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDXhJMaRNtPtA983bCIbIIpu3Xsm5FbsdxvaPTdtBl5A7wa4MKKVtrWmweWOMRkphcZFnpdDgXmKey@nongnu.org
X-Gm-Message-State: AOJu0YzS2dPeLidpmtsh8/hpM/8whQWhsVYtQBzdOHSfLTfGRJOAfXGo
 60JGcnfzo+sykEWA/s4XeCi8WOyPAclJUnidWvGUe9QRS7DHb1qjh9gBuILQwy+KmgqDUdJ2UPT
 0rV8N9iGtX1+8f1UmxqrNoN64E/uJLfpH1fHgUBjXedskfCj8myAq
X-Gm-Gg: ASbGncsMGuFbbtfgtRQeZgcTJR2WZ0j0vYBQsUqtj8QmabZURCXf0/OxplfslH2oTEa
 mJwMfSzvkOb//Bprxi5W44hLV6kgEA0Sq3rMQP76PnVpB76bjLfsZ0Ftsgm66OxKu5NFiJ9xLab
 bU6AxmJHEoINtDAbUFqM/aL6biiCwEj+U16AqQXJP489JX7SSgCJFnKYYxuW5WtfigtWgXnS8Wa
 nKEP8+TOEFFgPU3FIZBZcsBWX5iiYaGNYodHQoNOYQ5X7/gG7jVfko/r7S5l3uov6iTnd+ImXsN
 68ABu8hDmnTCC2fqF5BF7itdgVyuxOgzBXg=
X-Received: by 2002:a05:600c:1e23:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-439248c2c07mr143048085e9.0.1739199158635; 
 Mon, 10 Feb 2025 06:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEti4YTYhIVN24q6eMkfStjt/5bWDAdCiwSUu6iYhG3QxN7ANHy90mqlaAIm/0qtD5lnemlyA==
X-Received: by 2002:a05:600c:1e23:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-439248c2c07mr143047845e9.0.1739199158282; 
 Mon, 10 Feb 2025 06:52:38 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6c7f.dip0.t-ipconnect.de. [91.12.108.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439429c0790sm39989215e9.2.2025.02.10.06.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:52:37 -0800 (PST)
Message-ID: <5201950c-b0dd-4efa-a991-4e682c705682@redhat.com>
Date: Mon, 10 Feb 2025 15:52:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20250207205613.474092-1-mjrosato@linux.ibm.com>
 <20250207205613.474092-2-mjrosato@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250207205613.474092-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 07.02.25 21:56, Matthew Rosato wrote:
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
>   hw/s390x/s390-pci-bus.c         | 38 +++++++++++++++++++++++++++++++--
>   hw/s390x/s390-pci-inst.c        | 13 +++++++++--
>   hw/s390x/s390-pci-vfio.c        | 23 ++++++++++++++++----
>   hw/s390x/s390-virtio-ccw.c      |  5 +++++
>   include/hw/s390x/s390-pci-bus.h |  4 ++++
>   5 files changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index eead269cc2..81e5843c81 100644
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
> @@ -720,16 +722,45 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>                                name, iommu->pal + 1);
>       iommu->enabled = true;
> +    iommu->direct_map = false;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }
>   
> +void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Rather
> +     * than using an iommu, create a memory region alias that maps GPA X to
> +     * IOVA X + SDMA.  VFIO will handle pinning via its memory listener.
> +     */
> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
> +                                            iommu->pbdev->uid);

Empty line.

> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name,
> +                             get_system_memory(), 0,
> +                             s390_get_memory_limit(s390ms));
> +    iommu->enabled = true;
 > +    iommu->direct_map = true;


You could dynamically allocate the dm_mr instead, and use that as 
indication if the direct mapping is active. Whatever you prefer.


Nothing else jumped at me, thanks!

-- 
Cheers,

David / dhildenb


