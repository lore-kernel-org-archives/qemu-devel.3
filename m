Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E67C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28PN-0003TJ-59; Tue, 08 Apr 2025 08:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u28PL-0003Sr-48
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u28PJ-0004SC-DB
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744116623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=plTiCJPGlRlRek26AyeSoLRH+aderwTBJ/4Teuk9GDg=;
 b=GbUx7xsdUJFbCA8WvL1FuKqR/oYKDsNVyiML51bjKJTZCDYlM2YSyMvDmCRp6dhoONPIKq
 DiWRgLLJub0bJS2/qa5J2wa89Kf2OqPxka/XX9gkSUmIIpPMik5QLwNvTeWsFDjzcII7aw
 Ad2fApXHrQxq3+DgzMrOqbqQVcquXKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-cRPVWg5CMB6XGoqAR85xZQ-1; Tue, 08 Apr 2025 08:50:22 -0400
X-MC-Unique: cRPVWg5CMB6XGoqAR85xZQ-1
X-Mimecast-MFC-AGG-ID: cRPVWg5CMB6XGoqAR85xZQ_1744116621
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so17830405e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 05:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744116621; x=1744721421;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plTiCJPGlRlRek26AyeSoLRH+aderwTBJ/4Teuk9GDg=;
 b=mV+31l3qE1fmqOiK12RaeTA/wehNfbZ9MY0uFqGUVc9BV7Xba2zXaegqEvyTPFbqzq
 Xg7+Qa8GgZiWgstidFsObpvfXeLn3GssTg12JZVc18oDcirz4DqJ5NkHQb3WalrsEmXD
 Gs+/sS0OieJo0Ux8MexWcJ+4XMctjit2F5VVGB2lLthpPfHSwYvicuFJn2lU/0Qd0Ws7
 ZV7oNqth3c95lcavKi6kS9zTxsQ8E5mw/D7M+KKjBoLtLJFCoIKL0V7BfoIBEs05j/9W
 nmcYDMyb0nqvfXx7+0sD0IhShvPmkDwIQaVaQyPheYjOCNfHm6UGH4byD8re6FY9J7I5
 yWbQ==
X-Gm-Message-State: AOJu0Ywx8F4h79a2n0y0LGXPToGVc+Toq08A0LPIjuMdPLVK2/E3zuC9
 aPvb9TXEys3iEBZHCm3793SYt20n/m/jDk9Ishg4BjYMNmQs2orc3RtZwjNHqhO+T5DgMxI0crI
 25qolQ4W2etzJKsTK08zFmDf2ePE0GELu2GzFGU00YjkrA9+6AJHk
X-Gm-Gg: ASbGncui72ZZKbI0aGJydaRRwUhSd9TIuUfTvBXJ5CLQYUyxkemg7iJlnAyE72uipfT
 4eEf4Ilmp6/kHYDDV1rb3t+/CRi4MyCdj/haYJDQfVWlegRYmvnaOq0/aZKlLmpa9Lwsk7ddGX5
 oILrKwo7kNnnSf3tnFwd9Fzv0bsEvMJ4sqMYFBdnLYAFWIkQZLTl371vSuGkr1J27LyHF32kJqB
 oXisia0gBqeJs6Z3ZC7BqUtR4L0d3UsCm2N/JXxWKTbbubfCRZMnbg+LtUUirej0c1+joCXYQ7l
 mr73p3jJkW1bZ7qYQ8OSSESHgma66ANOaKvqsN8yPSZiRsc+zPNFUA==
X-Received: by 2002:a05:600c:b97:b0:43d:94:cfe6 with SMTP id
 5b1f17b1804b1-43ecf8cfcd0mr183802255e9.16.1744116620855; 
 Tue, 08 Apr 2025 05:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCHhiQDrqh60Y8ML4O96Q19oy1anDv9YKrnel5eWEHZBXgkQ0JNDrC+a04M0xCV3xnDvf8Lw==
X-Received: by 2002:a05:600c:b97:b0:43d:94:cfe6 with SMTP id
 5b1f17b1804b1-43ecf8cfcd0mr183801935e9.16.1744116620408; 
 Tue, 08 Apr 2025 05:50:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663060sm165287275e9.14.2025.04.08.05.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:50:19 -0700 (PDT)
Message-ID: <8a689ae0-c7fd-40a4-a524-7048d4e5f709@redhat.com>
Date: Tue, 8 Apr 2025 14:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
 <20250408124042.2695955-2-amachhiw@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250408124042.2695955-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/8/25 14:40, Amit Machhiwal wrote:
> Introduce an Error ** parameter to vfio_spapr_create_window() to enable
> structured error reporting. This allows the function to propagate
> detailed errors back to callers.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> --->   hw/vfio/spapr.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 1a5d1611f2cd..dd9207679dbe 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -230,9 +230,9 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -static int vfio_spapr_create_window(VFIOContainer *container,
> +static bool vfio_spapr_create_window(VFIOContainer *container,
>                                       MemoryRegionSection *section,
> -                                    hwaddr *pgsize)
> +                                    hwaddr *pgsize, Error **errp)
>   {
>       int ret = 0;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -252,11 +252,11 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>       pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
>       pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>       if (!pagesize) {
> -        error_report("Host doesn't support page size 0x%"PRIx64
> -                     ", the supported mask is 0x%lx",
> -                     memory_region_iommu_get_min_page_size(iommu_mr),
> -                     bcontainer->pgsizes);
> -        return -EINVAL;
> +        error_setg_errno(errp, EINVAL, "Host doesn't support page size 0x%"PRIx64
> +                         ", the supported mask is 0x%lx",
> +                         memory_region_iommu_get_min_page_size(iommu_mr),
> +                         bcontainer->pgsizes);
> +        return false;
>       }
>   
>       /*
> @@ -302,17 +302,17 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>           }
>       }
>       if (ret) {
> -        error_report("Failed to create a window, ret = %d (%m)", ret);
> -        return -errno;
> +        error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
> +        return false;
>       }
>   
>       if (create.start_addr != section->offset_within_address_space) {
>           vfio_spapr_remove_window(container, create.start_addr);
>   
> -        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
> -                     section->offset_within_address_space,
> -                     (uint64_t)create.start_addr);
> -        return -EINVAL;
> +        error_setg_errno(errp, EINVAL, "Host doesn't support DMA window at %"HWADDR_PRIx
> +                         ", must be %"PRIx64, section->offset_within_address_space,
> +                         (uint64_t)create.start_addr);
> +        return false;
>       }
>       trace_vfio_spapr_create_window(create.page_shift,
>                                      create.levels,
> @@ -320,7 +320,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>                                      create.start_addr);
>       *pgsize = pagesize;
>   
> -    return 0;
> +    return true;
>   }
>   
>   static bool
> @@ -377,9 +377,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>           }
>       }
>   
> -    ret = vfio_spapr_create_window(container, section, &pgsize);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> +    ret = vfio_spapr_create_window(container, section, &pgsize, errp);
> +    if (!ret) {
>           return false;
>       }
>   

ret is not needed. Minor.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



