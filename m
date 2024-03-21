Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D660DC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKL0-0005BO-PN; Thu, 21 Mar 2024 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnKKz-0005B1-5e
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnKKw-0007v3-1v
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711034888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Dw9WDPSSbUWtFZK3d8b8IjjxSWAXCXeWb6gxzevr1g=;
 b=HlQsDFs3G2s1s9Z6EUJzft/gIpertcZHAfx2OZyjap2TqK1d6qw+ctF2HCYnanHCUGCeep
 C2y0OpiVSH9K3uml3qI6ehf+BbyzFpFBrkwWIZQkxAjCxlYhrSclaoP0BjswL9WtrC9KMV
 YSlZkDCqXcDQikfRG9kUlps3Wsv/vuk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-kPCiijcePLqoQ_MBp-SfwA-1; Thu, 21 Mar 2024 11:28:06 -0400
X-MC-Unique: kPCiijcePLqoQ_MBp-SfwA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c154f307c6so33204b6e.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711034886; x=1711639686;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Dw9WDPSSbUWtFZK3d8b8IjjxSWAXCXeWb6gxzevr1g=;
 b=UtXI6xGpU6tdf0xQXuujixAHYpxanPPe+PRX8wSpkenseGkUObeid0hYNMUEr0RzDp
 34c2ffzVF6OaQXg0nOSgV/79ny7tcUF8FembRUqJh5rJ+EOhSqPeZZufxX4XMEf4pM7H
 FlmcX6AT3A1dLrjICqVjwl/85tCC71v4/OAfDnhFF2+6F/q/bjYfzLyHEFbaOKXnbGJm
 DCbYNObqVJBEDwcRVkx3A15BZY9LJ/Hs+YZb5aITMnDOWdMYInEphY7hNFYeXgZ3U0O7
 KXT33Xk8eHPnR30zMLwaZxLDwZq8ULn3Qgk6j/QbjliT1l1bH36/O0N7haosdRBe37BZ
 Zg4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0yTP5ULc4bmL0neml0hcV9/wNF1dZlm2/P9rYGhh8cMboXfhgV/tzImvminJRO6hwIHaULtQDMk0fX64qFfQVnAfrdHI=
X-Gm-Message-State: AOJu0YzSVjn6/Et1kHbue6EGKXb01uie9Mmw7IwBRrOlM35lxIeGo8Zj
 uB3HwupUWRnPpt7vidmay8n9GQ+BW5ITyvefpe91TuMm6Qxo3+9WlrqO7O2fCNtnlkcWkKrUVPP
 pbN3PDta7iunf5NIhMe0m1dWrcEJOn8An9+ABE+yrIPQjbgl9boc2
X-Received: by 2002:a05:6808:17a7:b0:3c3:89e1:277e with SMTP id
 bg39-20020a05680817a700b003c389e1277emr5593145oib.3.1711034885803; 
 Thu, 21 Mar 2024 08:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1aqppYu5Zn6OPAMcG2WiZdq//iT8q/+LIViJykBrL7dS6NzVaiwIirV4NLncFTqw6DYIiFA==
X-Received: by 2002:a05:6808:17a7:b0:3c3:89e1:277e with SMTP id
 bg39-20020a05680817a700b003c389e1277emr5593116oib.3.1711034885320; 
 Thu, 21 Mar 2024 08:28:05 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cf10-20020a05622a400a00b00430ce167becsm5264654qtb.1.2024.03.21.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 08:28:05 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:28:02 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Message-ID: <ZfxSAgJECCOqtGRh@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com>
 <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 21, 2024 at 01:37:36AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Thursday, March 21, 2024 4:32 AM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>; farosas@suse.de; qemu-
> > devel@nongnu.org; hao.xiang@bytedance.com; bryan.zhang@bytedance.com; Zou,
> > Nanhai <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v5 5/7] migration/multifd: implement initialization of
> > qpl compression
> > 
> > On Wed, Mar 20, 2024 at 04:23:01PM +0000, Liu, Yuan1 wrote:
> > > let me explain here, during the decompression operation of IAA, the
> > > decompressed data can be directly output to the virtual address of the
> > > guest memory by IAA hardware.  It can avoid copying the decompressed
> > data
> > > to guest memory by CPU.
> > 
> > I see.
> > 
> > > Without -mem-prealloc, all the guest memory is not populated, and IAA
> > > hardware needs to trigger I/O page fault first and then output the
> > > decompressed data to the guest memory region.  Besides that, CPU page
> > > faults will also trigger IOTLB flush operation when IAA devices use SVM.
> > 
> > Oh so the IAA hardware already can use CPU pgtables?  Nice..
> > 
> > Why IOTLB flush is needed?  AFAIU we're only installing new pages, the
> > request can either come from a CPU access or a DMA.  In all cases there
> > should have no tearing down of an old page.  Isn't an iotlb flush only
> > needed if a tear down happens?
> 
> As far as I know, IAA hardware uses SVM technology to use the CPU's page table 
> for address translation (IOMMU scalable mode directly accesses the CPU page table).
> Therefore, when the CPU page table changes, the device's Invalidation operation needs
> to be triggered to update the IOMMU and the device's cache. 
> 
> My current kernel version is mainline 6.2. The issue I see is as follows:
> --Handle_mm_fault
>  |
>   -- wp_page_copy

This is the CoW path.  Not usual at all..

I assume this issue should only present on destination.  Then the guest
pages should be the destination of such DMAs to happen, which means these
should be write faults, and as we see here it is, otherwise it won't
trigger a CoW.

However it's not clear to me why a pre-installed zero page existed.  It
means someone read the guest pages first.

It might be interesting to know _why_ someone reads the guest pages, even
if we know they're all zeros.  If we can avoid such reads then it'll be a
hole rather than a prefaulted read on zero page, then invalidations are not
needed, and I expect that should fix the iotlb storm issue.

It'll still be good we can fix this first to not make qpl special from this
regard, so that the hope is migration submodule shouldn't rely on any
pre-config (-mem-prealloc) on guest memory behaviors to work properly.

>     |
>     -- mmu_notifier_invalidate_range
>       |
>       -- intel_invalidate_rage
>         |
>         -- qi_flush_piotlb
>         -- qi_flush_dev_iotlb_pasid

-- 
Peter Xu


