Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B40CDD0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MmX-0006ch-NC; Tue, 22 Oct 2024 17:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3MmW-0006cQ-A2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3MmU-00089n-KW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729633866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98HpJC+X3EFeyyy8qtsQz9wcyAPQb1RPTiUvpIJu30c=;
 b=AjSTW6NWOXgCzJHW+pwSlo2mxA09nklWAJ/+mxkARrcdBgXNbTtY+OtB765uv3o07ynTwa
 D1lV71Cou/TaqEyV06FURptT21xfYs7erlT8Wrr3ZB6IbbAnuAQIqFvfkGCfq9bet1hrjw
 N+Ch87JSTVkH/R4facHfDUQiyGxaBGc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-i30gPHYpPDKzYCdKu-oVbA-1; Tue, 22 Oct 2024 17:51:04 -0400
X-MC-Unique: i30gPHYpPDKzYCdKu-oVbA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b1473a4640so60010685a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633863; x=1730238663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98HpJC+X3EFeyyy8qtsQz9wcyAPQb1RPTiUvpIJu30c=;
 b=sZxzHdWlnW07dohwwB/SpuGzdZV7bo2LXuuaWNjuamRVWtQzUFLSlrQcUkSMRqNuvU
 P3Hvs9iuW/175DJPUZBI6uSmoM9rWcv9ymxyy6GWTXVv58EmQoRVnZThUv2uwZXIYuEa
 RWEbRjhNi3vAvoFHWF/VGEsL/9Gi1p7ONUgJUNtZje2OVYQjYhkmzTXckemsPhFWT9Yq
 SNnLd7jcEzDUvKR15+MMugaaleHQxtvDmazYTpodKyW6DRQy90MUzrzfNNtBMXItTDxk
 jvLHILJ+QhXg58fp1E/zNPrUd9kgZCwkDBGsrO8k7O9tgZ9e/H91k9vW/1a0XUKsoKwo
 7U6w==
X-Gm-Message-State: AOJu0YwjiYKOYsUvfU0FBClFsxxRQn6RMq+UZSKxdfmsr/mTY9h13mgB
 FAeJHcoQl08P1pMmeEpXsEcbiCTvbESml/T6h2a42dwG7vrq1bRzsPcJgkLqYNyyPNct7jFOsmd
 XlGUq8zqww4NhUTdn3dFEa8UYqeqG9QIwONU43b3Jp7ZmHrYkckbr
X-Received: by 2002:a05:620a:2491:b0:7ac:b197:4037 with SMTP id
 af79cd13be357-7b17e1c5578mr104066585a.18.1729633862644; 
 Tue, 22 Oct 2024 14:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9N3PebbAtfnVR3KG+8sV8QsgrKXwF5eoiwN0prjYUfXwJQafM54cTIHXKJM9wxUNOrrXKbg==
X-Received: by 2002:a05:620a:2491:b0:7ac:b197:4037 with SMTP id
 af79cd13be357-7b17e1c5578mr104063685a.18.1729633862246; 
 Tue, 22 Oct 2024 14:51:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659b9415sm322933885a.3.2024.10.22.14.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 14:51:01 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:50:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH 2/2] vfio/helpers: Align mmaps
Message-ID: <ZxgeQwpCPAjBlE8T@x1n>
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
 <20241022200830.4129598-3-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022200830.4129598-3-alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Tue, Oct 22, 2024 at 02:08:29PM -0600, Alex Williamson wrote:
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
> 
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

For the longer term, maybe QEMU can provide a function to reserve a range
of mmap with some specific alignment requirement.  For example, currently
qemu_ram_mmap() does mostly the same thing (and it hides a hugetlb fix on
ppc only with 7197fb4058, which isn't a concern here).  Then the complexity
can hide in that function.  Kind of a comment for the future only.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

> ---
>  hw/vfio/helpers.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b9e606e364a2..913796f437f8 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -27,6 +27,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/units.h"
>  #include "monitor/monitor.h"
>  
>  /*
> @@ -406,8 +407,35 @@ int vfio_region_mmap(VFIORegion *region)
>      prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
>  
>      for (i = 0; i < region->nr_mmaps; i++) {
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
>                                       region->fd_offset +
>                                       region->mmaps[i].offset);
>          if (region->mmaps[i].mmap == MAP_FAILED) {
> -- 
> 2.46.2
> 

-- 
Peter Xu


