Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE182C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENHD-0004zb-3G; Mon, 12 May 2025 03:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uENH4-0004xK-Mg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uENH2-0007tW-PE
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747033707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWFWtDjtAh31dU6HlJvef331d9UJAEMAEV8ilXGNQ5U=;
 b=NjU6OMp30qLC34v2njDeNp0uaDXrSKielGHnHA6JZa7WQ7NF7qU6tyobdYk25zUvoFyHFg
 Y9uTuJUquJk8lJoNio66DbCdSvLpQhoRC6+6UNZQCikM+jXPywmJ2jDq4wNQQozO9o5oVV
 NlIl+mfIowmPVJmog+rLIN7SVmyBs3k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-8od-uiPhMJGoKgt6bLALxg-1; Mon, 12 May 2025 03:08:25 -0400
X-MC-Unique: 8od-uiPhMJGoKgt6bLALxg-1
X-Mimecast-MFC-AGG-ID: 8od-uiPhMJGoKgt6bLALxg_1747033704
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso12763825e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747033704; x=1747638504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWFWtDjtAh31dU6HlJvef331d9UJAEMAEV8ilXGNQ5U=;
 b=YzJuIFg5Rvt/IFu8ZHH0RkicSTh9+mx7ha50nC05qW2q+lOXS+2EidZlKpz4VZ+q6z
 ItKVcMh3HcT2Sa3oOHlV2B8lIXrplLSUr8JD7Nxs2m22ij7LJx48YqLpnrgWwyjdxFT1
 oemvLBnAsN50bYnEjYM/w6ms7w206Tpx9i30hUgNQE5B1ZgC2DwmyoUa+ud+RG6WUU1v
 mBUcVEg2T/RWLGs+6XaYDBgQBJ746THCdmrL70Y7371S2XbztP5RYWWwmhHaTDjXlBi/
 OBmxo3OGZDskkh71IJKyNI8LcFpdyEzXLJ1lDzxJDj1FRqPPy3EiDLBVbSo2sI4PSIfp
 dr+w==
X-Gm-Message-State: AOJu0Ywy7+/omFolTEEn9ohY1pi1rTNaU6snXAFhHra9L3n9NBvAXvnN
 08l2aZeC7BT5uzVoa7IfLywO43y7sML/4MMAnDK4hEyEYUdDjsaPzoQ6c6GNvmf0S2HNl9XxBOZ
 9HeQuFOStTHPtgWW4VHV2DRTgKJFVH5ptZSIvxzcIC5BZ4OPB92m4
X-Gm-Gg: ASbGncu9WMK7s+rRKNGK03FeUPm2SbGKHU8t5+LXN1nlkxiWZigt0HTMtOI3/rCEfSc
 N26ZEmUCwroXghcvjb4zXQm5JJL1ztUmk8MYYrHcd4mb3diXn6XgcJAGMvdQOyiQuf6f2xny2OC
 6o5KBJBFtUHC4uqnbyGigNXo5l6ifRn2xR7vxctepDov1sSprnXcoW1gMRYKGesQ0ZWYsaRlUnV
 5sGhicFCKKi591//VvpLTD0hIFvFvRkU+71tDQA/j74fZuPJzV5m5iA/pL/ISO2qq4IVVT1OuzW
 XA0Bgg==
X-Received: by 2002:a05:600c:8212:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-442d6de0e29mr117275085e9.31.1747033704494; 
 Mon, 12 May 2025 00:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHOrsb9Cb3MijxOMORysBZjcYIYP4DqwcMD/cIdtn7LbBL1rur1ihgRmPwR8TH+V9MEkjX7g==
X-Received: by 2002:a05:600c:8212:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-442d6de0e29mr117274825e9.31.1747033704135; 
 Mon, 12 May 2025 00:08:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67df574sm114041015e9.11.2025.05.12.00.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 00:08:22 -0700 (PDT)
Date: Mon, 12 May 2025 03:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH v2 1/2] hw/i386/amd_iommu: Fix device setup failure when
 PT is on.
Message-ID: <20250512030604-mutt-send-email-mst@kernel.org>
References: <20250509064526.15500-1-sarunkod@amd.com>
 <20250512040537.15557-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512040537.15557-1-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 12, 2025 at 09:35:37AM +0530, Sairaj Kodilkar wrote:
> Current amd_iommu enables the iommu_nodma address space when pt_supported

Currently,

> flag is on. This causes device to bypass the IOMMU and use untranslated

devices

> address to perform DMA when guest kernel uses DMA mode, resulting in

the guest

> failure to setup the devices in the guest.

a failure

> 
> Fix the issue by always enabling amdvi_dev_as->iommu, which is explicitly
> created as an IOMMU memory region (i.e. a memory region with mr->is_iommu
> == true), and it is meant to support DMA remapping. It is relying on the
> "side effect" that VFIO will try to register notifiers for memory regions
> that are an "IOMMU" (i.e. pass the check in memory_region_is_iommu()),
> and later fail when trying to register the notifier.

what will fail? what is meant for what? confused.

> 
> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")

explain the connection with this commit pls. did it work
prior to that?

> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/amd_iommu.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5f9b95279997..df8ba5d39ada 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>      AMDVIState *s = opaque;
>      AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>      int bus_num = pci_bus_num(bus);
> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>  
>      iommu_as = s->address_spaces[bus_num];
>  
> @@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>                                              AMDVI_INT_ADDR_FIRST,
>                                              &amdvi_dev_as->iommu_ir, 1);
>  
> -        if (!x86_iommu->pt_supported) {
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      true);
> -        } else {
> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> -                                      false);
> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> -        }
> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
>      }
>      return &iommu_as[devfn]->as;
>  }
> -- 
> 2.34.1


