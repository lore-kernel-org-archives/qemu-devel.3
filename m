Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB0CF537D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 12:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ajZ-0006O3-4N; Wed, 23 Oct 2024 08:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3aj4-0006N9-BQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 08:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3aix-0004kS-8y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 08:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729687463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1y8LsVyEK5j61+YyNX4f8piQceRSKnJeLYW4F2vG7lg=;
 b=TXqUJSMjydS+pJ0jpT8mAdCVdEnB2zV/2kvdIKaZU6qyOkGB6cdZwnuTleAIt7G4MLVC5J
 8kAEBtUMUMyj6l5CUaZEiTH9eNgwyuJQgAR55y+qQysVmpOUeMMUBkaZFxfKAcEgQwHxBB
 2rueSLd4ojNlWJW1ExH4PiYsWw6tiOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-bXI9snhfNg2u1oXx3naNLQ-1; Wed, 23 Oct 2024 08:44:22 -0400
X-MC-Unique: bXI9snhfNg2u1oXx3naNLQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so35594445e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 05:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729687461; x=1730292261;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1y8LsVyEK5j61+YyNX4f8piQceRSKnJeLYW4F2vG7lg=;
 b=gwGORsO8xfdfFgcM7SqsIkA2hpTzl7JiQzd3LjRCd8ujOtMqWMjYnvRCiEr0f1Irm0
 BAxEyDXpaVEHvfBmOmnPk1rrz1fXgaXvJGiJ4C5miQVez9ubZQcL0eRb1LXmlv2rcJ9u
 o5G9HR92WLcPPay2IVwplZCdSCPygQGr/g/j9Na7gfV4hXzlUmRbW589KHLGW/5wV+Td
 EJn71v8ELBr21lAdxskiB/es4rccZUis+zP8bVnSvIIFuvHQ3GUNA3Bn3EDOPKt3hSM0
 bMjldrN4a7lM1mPmGpADX8S084R5Z55XQQqSFryLa2JHNIX2bx+OQad+5UoS/ew3azms
 iI8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs+aHtHFPSOfl10I6v6g65zqqootd6WAUFopTL74vzjU+9HmWLmjMGfGWjzIml57i5yb9AqXpL+GY7@nongnu.org
X-Gm-Message-State: AOJu0YxyoxD+sLQGY7JTO0J7Y4fI5RqZcj0XBbQFOjYKs9XobZGC4yGa
 il8dOugAu3XgxsncQSS7EjM1MkEy5Q77Moj+sVjvrLE9DsnKbB+vugqUlAzvOTCWjWokHPpAnjJ
 SHd6ZUFPKwXcTJEKmZ1iYp6+u4l+LW9iUcRYPusTaTHPf+tI3BUOD
X-Received: by 2002:a05:6000:1865:b0:37d:4ebe:164d with SMTP id
 ffacd0b85a97d-37efcf84a76mr1839256f8f.47.1729687461266; 
 Wed, 23 Oct 2024 05:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO3tZNUMflwrYgDIKG79ehu12zU1RkVwjxaGu7//olS5ThkoRAwfPeTR3oVzG2U8p0M64OsQ==
X-Received: by 2002:a05:6000:1865:b0:37d:4ebe:164d with SMTP id
 ffacd0b85a97d-37efcf84a76mr1839231f8f.47.1729687460740; 
 Wed, 23 Oct 2024 05:44:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c0e0d5sm15476925e9.31.2024.10.23.05.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 05:44:20 -0700 (PDT)
Message-ID: <d65cf179-21e6-4cda-baae-57fde73807cf@redhat.com>
Date: Wed, 23 Oct 2024 14:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/helpers: Align mmaps
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
 <20241022200830.4129598-3-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241022200830.4129598-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On 10/22/24 22:08, Alex Williamson wrote:
> Thanks to work by Peter Xu, support is introduced in Linux v6.12 to
> allow pfnmap insertions at PMD and PUD levels of the page table.  This
> means that provided a properly aligned mmap, the vfio driver is able
> to map MMIO at significantly larger intervals than PAGE_SIZE.  For
> example on x86_64 (the only architecture currently supporting huge
> pfnmaps for PUD), rather than 4KiB mappings, we can map device MMIO
> using 2MiB and even 1GiB page table entries.
> 
> Typically mmap will already provide PMD aligned mappings, so devices
> with moderately sized MMIO ranges, even GPUs with standard 256MiB BARs,
> will already take advantage of this support.  However in order to better
> support devices exposing multi-GiB MMIO, such as 3D accelerators or GPUs
> with resizable BARs enabled, we need to manually align the mmap.
> 
> There doesn't seem to be a way for userspace to easily learn about PMD
> and PUD mapping level sizes, therefore this takes the simple approach
> to align the mapping to the power-of-two size of the region, up to 1GiB,
> which is currently the maximum alignment we care about.


Couldn't we inspect /sys/kernel/mm/hugepages/ to get the sizes ?


> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/vfio/helpers.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b9e606e364a2..913796f437f8 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -27,6 +27,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/units.h"
>   #include "monitor/monitor.h"
>   
>   /*
> @@ -406,8 +407,35 @@ int vfio_region_mmap(VFIORegion *region)
>       prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
>   
>       for (i = 0; i < region->nr_mmaps; i++) {
> -        region->mmaps[i].mmap = mmap(NULL, region->mmaps[i].size, prot,
> -                                     MAP_SHARED, region->vbasedev->fd,
> +        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
> +        void *map_base, *map_align;
> +
> +        /*
> +         * Align the mmap for more efficient mapping in the kernel.  Ideally
> +         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
> +         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
> +         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
> +         * on x86_64).  Align by power-of-two size, capped at 1GiB.
> +         *
> +         * NB. qemu_memalign() and friends actually allocate memory, whereas
> +         * the region size here can exceed host memory, therefore we manually
> +         * create an oversized anonymous mapping and clean it up for alignment.
> +         */
> +        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
> +                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +        if (map_base == MAP_FAILED) {
> +            ret = -errno;
> +            goto no_mmap;
> +        }
> +
> +        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
> +        munmap(map_base, map_align - map_base);
> +        munmap(map_align + region->mmaps[i].size,
> +               align - (map_align - map_base));
> +
> +        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> +                                     MAP_SHARED | MAP_FIXED,
> +                                     region->vbasedev->fd,
>                                        region->fd_offset +
>                                        region->mmaps[i].offset);
>           if (region->mmaps[i].mmap == MAP_FAILED) {


