Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B327F9D0F2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCkW1-0005Xa-Rz; Tue, 14 Apr 2026 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCkW0-0005WV-E6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCkVy-0007wY-CL
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776199061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNIAR5CXwdC6CicJaH79bX0KLl27D09jlIaNXis/YcI=;
 b=e+rvZ7Vcj0lZWr4yUSBygGlhS1/7zYMexu8ZlgXxKfYqFineYP+qNMr5SqF/yam/SREOeR
 e3sI5ZelTvP1sOPE985Pza2Ezf0DfYGo0PjIzDPD+hLcQDQiiE2ytDFm3WymsCiqJVM8+9
 JkYbSWp2kdJJCfaoQ4Dog34cAqZXKKk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-d6PJkRR6PBa2prMDpayIPQ-1; Tue, 14 Apr 2026 16:37:40 -0400
X-MC-Unique: d6PJkRR6PBa2prMDpayIPQ-1
X-Mimecast-MFC-AGG-ID: d6PJkRR6PBa2prMDpayIPQ_1776199059
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acad256115so80174526d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776199059; x=1776803859; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uNIAR5CXwdC6CicJaH79bX0KLl27D09jlIaNXis/YcI=;
 b=RouCyw5IglhlTNAPq+gxRFk2l3XO6vgW1q6N4XDRk3Ztp/E6a4gH75YzD0ttWDnuhK
 OERUnRhyJu1IkiUey+ZbtRqL09Vm+iH44CtVyW8zwiW+Np08cAqdqleDd0Y9mFYNcEs3
 efOn3SZ2RcR4E7oZoarO2XKlVyrK8TJlys5lCKD15fNugyXtul7X0IANYF37gk02A36v
 Cak7RLlmS8O2Vsu9fquK2snj0B9e/XBn95DH9CCM+RygGHSmwJSSk38/AFTuZNe6mznV
 NuiabdfHmHhUhO0VCLXNbU7ZccBSOpErGjU9j4JErW6sQlyhNjBSfldgeOG0ovoSWI+k
 HULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776199059; x=1776803859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNIAR5CXwdC6CicJaH79bX0KLl27D09jlIaNXis/YcI=;
 b=SiWnLHVtVsWL8vfpXV3jP3V5FLc60U+MHMUVIbhO65wtz/bbcOS3QJ9Vm84s+f8XYL
 IgYrQVu3vfIxAHo4M1B35thjwePw6bc4J88zLvLWXdUwISFVf7QbxucMli4RKcU5YPTQ
 cOe/Jrwqzv1VZSOpZwnN3yPaYDPHtu4FHTJx2SZDHCyyXOdzwGgm1od72/TV+eW18yKu
 ZvfNoifdVJWRQOGzviwqpZLNljrikRA0w7VWmPUilOOW4emj+FUm4Hvhjf7bJ+mz6/RS
 Bob0u9udFGXv8UoIVxsTRuKeicarf0528117g/fW7zJsJFWiN8agHEHFih0xFIiiow1C
 mDAQ==
X-Gm-Message-State: AOJu0YzA4XRu87+zWdFUMILsoUxYgj/41tRG/pHb41BPgIQnhD4WlEv+
 y8C8ljO4k4sSxxvD9Z7W/k/JXEjA1ufXSk0M9VEWHrDO7C6xctjXHU6w9B9xfhu/4nUbQDQzvAA
 rwmbp3GNNjZf+cFhmkDQQLdmXGjaBqWWVQkEcEQgNDyQdOpBH6xindwQk
X-Gm-Gg: AeBDieu29DyQRtgTFq95q9+meHJlrZBNpABhFrH+jG/UZ8Tl3qP6q1Os9mx/uTOmXgH
 2oQIPvvu97umfiN7VujHI59rlD7sFnIgzu4q7GeNOwhY9vn2RrVE+zMoGm0Rq3kIkDSxPjRuQ6q
 lfmIRblTZiS+7mPdyKSIoGoWT7r7vTjsD6r2ZrEt6S0r+VsB2LgSuhlwA2aiOdKi5tGcPrcpgA+
 rM0I+ieR9hGhup67ZoBUeXUxCa/8iDEQhm7MZQPUDpyRyj6/bHeJvq2aFG6jAhoTaMTA4YLrlDu
 yK7SHYWlZXBZB6kwcuWhAejRnd/olVVJ1MKUGCJWIAzz6Db1YyayWFprP2Aj2WMGEQKnz1dSGNT
 g3GFug6bNN8had01VRQJVUgpsGxjmKXw3p/Mc1USyb9PfHIB2yLbMGUpbvw==
X-Received: by 2002:a0c:e014:0:b0:89c:5d56:bca8 with SMTP id
 6a1803df08f44-8ac861a9385mr294890216d6.16.1776199059158; 
 Tue, 14 Apr 2026 13:37:39 -0700 (PDT)
X-Received: by 2002:a0c:e014:0:b0:89c:5d56:bca8 with SMTP id
 6a1803df08f44-8ac861a9385mr294889816d6.16.1776199058678; 
 Tue, 14 Apr 2026 13:37:38 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae5f31a104sm21272596d6.10.2026.04.14.13.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:37:38 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:37:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhiyu Hu <huzy4@chinatelecom.cn>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [RFC PATCH] hw/i386/pc: split ram-below-4g at 1MB and prevent
 cross-boundary merging
Message-ID: <ad6lj9YJORoVP0OV@x1.local>
References: <20260406025828.22909-1-huzy4@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406025828.22909-1-huzy4@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 06, 2026 at 02:58:28AM +0000, Zhiyu Hu wrote:
> Split ram-below-4g into ram-below-1m and ram-1m-to-below-4g at the
> 1MB boundary in pc_memory_init().
> 
> Also prevent flatview_simplify() from merging FlatRanges across the
> 1MB boundary by adding a boundary check in can_merge(). Without this,
> PAM attribute changes below 1MB cause the below-1MB range to re-merge
> with the above-1MB range, triggering VFIO to unmap/remap the entire
> merged region and creating a transient IOMMU mapping hole for active
> device DMA (e.g. virtio-blk virtqueues) above 1MB.

This is a very VFIO specific issue.. please also copy VFIO maintainers.  I
did it here.

> 
> Signed-off-by: Zhiyu Hu <huzy4@chinatelecom.cn>
> ---
>  hw/i386/pc.c    | 30 +++++++++++++++++++++++++++---
>  system/memory.c | 13 +++++++++++++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 4b53b5be4a..4e9823e46f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -790,11 +790,35 @@ void pc_memory_init(PCMachineState *pcms,
>      /*
>       * Split single memory region and use aliases to address portions of it,
>       * done for backwards compatibility with older qemus.
> +     *
> +     * Further split the below-4g region at the 1MB boundary so that PAM
> +     * register updates (which only affect 0xC0000-0xFFFFF) do not cause
> +     * the VFIO DMA listener to unmap/remap the entire below-4g range.
> +     * This avoids a transient IOMMU mapping hole for virtqueue memory
> +     * (above 1MB) when the BIOS reconfigures PAM during early boot.
>       */
>      ram_below_4g = g_malloc(sizeof(*ram_below_4g));
> -    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
> -                             0, x86ms->below_4g_mem_size);
> -    memory_region_add_subregion(system_memory, 0, ram_below_4g);
> +    if (x86ms->below_4g_mem_size <= 0x100000) {
> +        memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g",
> +                                 machine->ram,
> +                                 0, x86ms->below_4g_mem_size);
> +        memory_region_add_subregion(system_memory, 0, ram_below_4g);
> +    } else {
> +        MemoryRegion *ram_above_1m = g_malloc(sizeof(*ram_above_1m));
> +
> +        /* 0 ~ 1MB: affected by PAM/SMRAM overlays */
> +        memory_region_init_alias(ram_below_4g, NULL, "ram-below-1m",
> +                                 machine->ram,
> +                                 0, 0x100000);
> +        memory_region_add_subregion(system_memory, 0, ram_below_4g);
> +
> +        /* 1MB ~ below_4g_mem_size: not affected by PAM updates */
> +        memory_region_init_alias(ram_above_1m, NULL, "ram-1m-to-below-4g",
> +                                 machine->ram,
> +                                 0x100000,
> +                                 x86ms->below_4g_mem_size - 0x100000);
> +        memory_region_add_subregion(system_memory, 0x100000, ram_above_1m);
> +    }
>      e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
>      if (x86ms->above_4g_mem_size > 0) {
>          ram_above_4g = g_malloc(sizeof(*ram_above_4g));
> diff --git a/system/memory.c b/system/memory.c
> index 56f3225b21..28fc12e992 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -321,6 +321,19 @@ void flatview_unref(FlatView *view)
>  
>  static bool can_merge(FlatRange *r1, FlatRange *r2)
>  {
> +    /*
> +     * Do not merge ranges across the 1MB (0x100000) boundary.
> +     * PAM/SMRAM overlays frequently change attributes below 1MB,
> +     * and merging with the large RAM region above 1MB would cause
> +     * VFIO to unmap/remap the entire merged range on every PAM
> +     * update, creating a transient IOMMU mapping hole for device
> +     * DMA (e.g. virtio-blk virtqueues) in the above-1MB region.
> +     */
> +    if (int128_lt(r1->addr.start, int128_make64(0x100000))
> +        && int128_ge(r2->addr.start, int128_make64(0x100000))) {
> +        return false;
> +    }

I do not know well on the PC layouts, but afaiu this is too hacky to
hard-code this in merge code.

Should we try memory_region_set_unmergeable()?  Btw, since the unmergeable
flag seems to work even for alias, we don't need to apply it to system_ram
(which will stop all kinds of flatrange merges.. which doesn't look very
wanted).  So maybe we can just make all PAM regions unmergeable.

Thanks,

> +
>      return int128_eq(addrrange_end(r1->addr), r2->addr.start)
>          && r1->mr == r2->mr
>          && int128_eq(int128_add(int128_make64(r1->offset_in_region),
> -- 
> 2.43.0
> 

-- 
Peter Xu


