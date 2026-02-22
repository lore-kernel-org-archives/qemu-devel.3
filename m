Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12C8C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAbm-0006dT-4D; Sun, 22 Feb 2026 09:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAbd-0006d7-Ts
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuAbc-0000yb-5s
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771771122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2CvixHYiFxGT1HGlh4KsnMfZB7qT500eFCLdhvfHHe0=;
 b=F6NhvXdHxog9ocRDT8UKVjh/DrlJYJrFoG3YWOwmx5SM7DlnV9I8WFEW8UUPV4ad52h0gU
 LY61R7buk/ZgswqYWb1jT5yODsMfsLnxlGv4SQKwv9SKbTbZyHkrMahHi7wpAnFB6Kcz9p
 Ek1vjzgH4j2UAPBzXVOZaA/KITcVJkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-B9tK_TezOfikNCvgzyTJ9A-1; Sun, 22 Feb 2026 09:38:41 -0500
X-MC-Unique: B9tK_TezOfikNCvgzyTJ9A-1
X-Mimecast-MFC-AGG-ID: B9tK_TezOfikNCvgzyTJ9A_1771771120
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so4842005e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771771119; x=1772375919; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2CvixHYiFxGT1HGlh4KsnMfZB7qT500eFCLdhvfHHe0=;
 b=RWBFZuJYyDH+EgNG8P+QoSG8HjPrZush5QdZwoftDooFoevg5TLFUsSuS0nnrQ9+HH
 5JtQ1OqFnJPwZnzyVdhpu8xb4KSdxu/PUP3X4i+aSqOaSjaIIrJfENroCYH2WPwzIWdp
 8uIfi0iRYCffwxO9uqUWuM7Aq1tyIY7mIt6T7yvjTqWar+muiDBjVrcsw1ERUzCvIrJr
 GZ1KL0Gvp5w0z6t5/VST833ZpM3paF/2zWV7UB983svggkVH/jj4vYUu70odlRkTI+vK
 q8NTQTTMwC5blKH6OPJGQtMonUnbrWYf4FcCxeOlhh19CAvN+211I1Onsp4UhmDtqUMI
 LeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771771119; x=1772375919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CvixHYiFxGT1HGlh4KsnMfZB7qT500eFCLdhvfHHe0=;
 b=XAQBb4Zm3HYCSE31AgABsZeMryYa1n7WKnphByCFgs7JWyV6d93jFhRq3Tydm8wF7g
 7iDG4qucTh2Gr6XUauZFxzXRLllsLqKLkSkEbXTxmc1P/t/XC7f0MI1vhWGnVTSe3CAb
 1xqj0qVxQWHXpY8htjVAHasTTwU+ubicZy80EaZiqcoX7yv3jETZt8tgshTqTV4QSfyN
 cCTF/9xg//Zmj6ULOGdWxlqPtOauEjw+W7lds+YMLUYzgBIOraB4MxNFUN8lq1n9qQgm
 bTFpJ74vG6b6Wz1NMYhfIG/6wviRMcHQOWNFPlaL7CBRP7bvYgkstr/ARU7R/OsuFZt7
 7SNA==
X-Gm-Message-State: AOJu0Yxt9MGPpfdwKJy0nhpP2/uL584t9iutdDnyWzNJiIr91/djOxxt
 P0zbd0+EzMw6HDsXF5j703NaxuGfnna5t7lVIWkIoetlI91B7OePOyxILB2Y/QXOzVX1UNkyW7Q
 08RaSTHforYdBi2vrWnVBLBZhUdAo63xDb4j8Tx6G8bJ5zcroH3V/zQJOeoFkD42n
X-Gm-Gg: AZuq6aLwwsmMu3Iwps2Vku7S8hp5oLkFDK8uOJa778ZejdGuH8ScY6i9eTPhN9byqwX
 rkVi+EzZgh3grUrTXvZCZWqhFxvM43+Mnk9U/p2L3JF32hNVyRjoUHvTvay8beITxBtdltVmMQA
 e3mxbOLp0VV3RgownyOfeswBlDgXzRQehrdcG6oUHkx8EJAdYt8+Z8K3qvb33QKmkS6Q62yv21Q
 NcBHdvm8vcEYGy5CaKJ+z8FDn0LNlirYCb/bTydIPIZRu11i4ir86pE8XDxHNZn4c68NuC2/zA0
 NQMuQjBDDt5PydB4eQL+R226lkqO7oexS08WDk0xNCaJTYuKs/yLhfdyNmcY5mxk09mUIXKIRIp
 XPy4UfBWHQI4M8U8aToSn85D7uAU1P0pmcISvci+jMlSpgw==
X-Received: by 2002:a05:600c:5020:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-483a95fc1d3mr101790285e9.12.1771771119375; 
 Sun, 22 Feb 2026 06:38:39 -0800 (PST)
X-Received: by 2002:a05:600c:5020:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-483a95fc1d3mr101789855e9.12.1771771118870; 
 Sun, 22 Feb 2026 06:38:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f0330sm175946375e9.9.2026.02.22.06.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:38:38 -0800 (PST)
Date: Sun, 22 Feb 2026 09:38:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/9] : pnv/phb4: Update PHB4 to the latest PHB5 spec
Message-ID: <20260222092651-mutt-send-email-mst@kernel.org>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260220112141-mutt-send-email-mst@kernel.org>
 <d65ab628-99e3-47af-839c-e059207b692e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65ab628-99e3-47af-839c-e059207b692e@linux.vnet.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:35:15PM +0530, Saif Abrar wrote:
> Hello Michael,
> 
> Thanks for informing!
> 
> Trying to understand why it's breaking now? (as it must be building earlier)
> 
> Any insights will be helpful.
> 
> Regards,
> 
> Saif

I think clang rejects declarations placed directly after case labels in a switch.
clang sees this pattern:

  case PHB_PCIE_DLP_TRAIN_CTL:
      PCIHostState *pci = ...

as invalid, so it throws "expected expression"


> 
> On 20-02-2026 09:52 pm, Michael S. Tsirkin wrote:
> > On Tue, Feb 10, 2026 at 07:40:50AM -0600, Saif Abrar wrote:
> > > Hello,
> > > 
> > > Addressing the review comments for the series v2:
> > > https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03768.html
> > 
> > breaks tsan build:
> > 
> > 
> > https://gitlab.com/mstredhat/qemu/-/jobs/13201554945
> > 
> > ../hw/pci-host/pnv_phb4.c:968:9: error: expected expression
> >          PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> >          ^
> > ../hw/pci-host/pnv_phb4.c:969:43: error: use of undeclared identifier 'pci'
> >          PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> >                                            ^
> > ../hw/pci-host/pnv_phb4.c:999:9: error: use of undeclared identifier 'pci'
> >          pci = PCI_HOST_BRIDGE(phb->phb_base);
> >          ^
> > ../hw/pci-host/pnv_phb4.c:1000:32: error: use of undeclared identifier 'pci'
> >          pdev = pci_find_device(pci->bus, 0, 0);
> >                                 ^
> > 4 errors generated.
> > 
> > 
> > > This series updates the existing PHB4 model to the latest spec:
> > > "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
> > > 
> > > Updates include the following:
> > > - implemented sticky reset logic
> > > - implemented read-only, write-only, W1C and WxC logic
> > > - return all 1's on read to unimplemented registers
> > > - update PCIE registers for link status, speed and width
> > > - implement IODA PCT debug table without any functionality
> > > - update LSI Source-ID register based on small/big PHB number of interrupts
> > > 
> > > Also, a new testbench for PHB4 model is added that does XSCOM read/writes
> > > to various registers of interest and verifies the values.
> > > 
> > > Regards.
> > > 
> > > Saif Abrar (9):
> > >    qtest/phb4: Add testbench for PHB4
> > >    pnv/phb4: Add reset logic to PHB4
> > >    pnv/phb4: Implement sticky reset logic in PHB4
> > >    pnv/phb4: Implement read-only and write-only bits of registers
> > >    pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
> > >    pnv/phb4: Set link-active status in HPSTAT and LMR registers
> > >    pnv/phb4: Set link speed and width in the DLP training control register
> > >    pnv/phb4: Implement IODA PCT table
> > >    pnv/phb4: Mask off LSI Source-ID based on number of interrupts
> > > 
> > >   hw/pci-host/pnv_phb.c               |   1 +
> > >   hw/pci-host/pnv_phb4.c              | 583 +++++++++++++++++++++++++---
> > >   include/hw/pci-host/pnv_phb4.h      |  16 +-
> > >   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
> > >   tests/qtest/meson.build             |   1 +
> > >   tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
> > >   6 files changed, 837 insertions(+), 58 deletions(-)
> > >   create mode 100644 tests/qtest/pnv-phb4-test.c
> > > 
> > > -- 
> > > 2.47.3


