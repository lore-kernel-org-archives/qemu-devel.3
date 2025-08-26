Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE35BCA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvvU-0003EA-86; Tue, 26 Aug 2025 11:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uqvvQ-0003DY-On
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uqvvL-0003da-GA
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756223358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnAw/Dtiq2M0v56dg1IIzRHeysoBF0QQldpC31nZcQo=;
 b=YoBykQX72mZnrUgqPb01gRv7RSGOhuxag6Pa4NKd5bYSsAWpXh4t4GP/GkaBr1xpRoakXc
 idfEFYOmUmWeA3pvCfDG3gUC4g9a+RHw4LRMaCcq0xWlRP2A9DO7RTpTls0AeB2IevS6j8
 XppHZuFG7UG1xPV/dcgYJH3shK7lPQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-_GCsfY8nOO6L3de2yfG8nA-1; Tue, 26 Aug 2025 11:49:16 -0400
X-MC-Unique: _GCsfY8nOO6L3de2yfG8nA-1
X-Mimecast-MFC-AGG-ID: _GCsfY8nOO6L3de2yfG8nA_1756223355
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b612dbc28so14654285e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756223355; x=1756828155;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tnAw/Dtiq2M0v56dg1IIzRHeysoBF0QQldpC31nZcQo=;
 b=g0OfdtThxN9u0dveEmmDDxCBeYmb7WH59LUT+AlVYdzgZtgsDK4vFVgiFDKFoBZpWJ
 NQM5cQpzTO7Ecw6UCwnXIJ/7aErZhSHK8VGMatOob0xj14ARhlo90lu3cXS5lz3J2PBK
 /EocjieiHLJrjNVeItXE5vaFhib672bY4ehHU4gSgjjMfNVwmRPUcZ6tmebf14MWRipU
 myO6ZCLvBbuDa0h8yeqGOdDt9jkKK/H0afW1YaAODI1ZEaoW8KbTYozM12Y7t/knQpwI
 IzywB0TmZiVk6fbNyjecY/U3fhOlVMjDyzw/FYECq5k7WdwmcVY9olH6Kq3Wp6H2D8MM
 2ROw==
X-Gm-Message-State: AOJu0YxRzq0EWPovswdVJfy5yF9sg6wabh7dH9ufyeLCQGO6VFPvPYkt
 VrJ68KRo1WiBfKXuc4YHqEgIoJSzjsvYpFxwLk4Ui219PbA9EiUKNTI7d1hH53dllSIW3U4+bu8
 2q5bIDiSYU4qDNlQhGJKnsmqtgwguBP213K5Q2GmpxmXPN0DGq5Vgd1yH
X-Gm-Gg: ASbGncvN2hLfhQSmtC1nFKAbtsg0HdWDnuazd3X7IfljuZHhttdYpY+E4Al6SAvPkvd
 lyPPnpP7D1djXGWiV/4Vryjd5eRs/6yEBieO2fHZ0ji9hWcRbU0Pj3qtnr+JSqMDFcctB2xg5pa
 9mCoffMrwvsu5POMh7jL1kdos5YYwVrc5d54B6o0CpO7LywqOLTgpxqJMgFR3PVhrbEsW6047R5
 fh35pgQ7McEuxg2tnA0gL4FmjIJwxfHgLGpFT5t8pj3lUDUEmMRe6UbOe2mbIR+Bf9CCyPuPu1b
 BdjS2lRrb0p1NYuyHFYJ0p8PKrNH6s4=
X-Received: by 2002:a05:600c:46d3:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-45b517d2733mr124123575e9.29.1756223355413; 
 Tue, 26 Aug 2025 08:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtd4QHwNqK+KCUJDfWt0qhH9oHrFBPu1LUpT4pFXRN3hbOp2qIS+YqrhrgD2gK/hjU0vL6Rw==
X-Received: by 2002:a05:600c:46d3:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-45b517d2733mr124123355e9.29.1756223354916; 
 Tue, 26 Aug 2025 08:49:14 -0700 (PDT)
Received: from redhat.com ([185.137.39.227]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5753503esm154595765e9.1.2025.08.26.08.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 08:49:14 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:49:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "sriram.yagnaraman@ericsson.com" <sriram.yagnaraman@ericsson.com>,
 DAMIEN BERGAMINI <damien.bergamini@eviden.com>
Subject: Re: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Message-ID: <20250826114836-mutt-send-email-mst@kernel.org>
References: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
 <8eaba1a296152a4750ac581172fa6ba150d5c8c3.camel@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eaba1a296152a4750ac581172fa6ba150d5c8c3.camel@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL=0.141, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Aug 26, 2025 at 03:11:58PM +0000, CLEMENT MATHIEU--DRIF wrote:
> Hi all,
> 
> Kindly ping,  
> do you think we could have a look at this issue after the release of 10.1?
> 
> Thanks  
> \>cmd

indeed.

> On Wed, 2025-08-20 at 08:41 +0000, CLEMENT MATHIEU--DRIF wrote:
> > From: Damien Bergamini <[damien.bergamini@eviden.com](mailto:damien.bergamini@eviden.com)>
> > 
> > Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as  
> > pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be  
> > called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be  
> > known when the VF realize function calls pcie_sriov_vf_register_bar().
> > 
> > This breaks the memory regions of the VFs (for instance with igbvf):
> > 
> > $ lspci  
> > ...  
> >     Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=16K]  
> >     Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=16K]
> > 
> > $ info mtree  
> > ...  
> > address-space: pci_bridge_pci_mem  
> >   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci  
> >     0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio  
> >     0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix
> > 
> > and causes MMIO accesses to fail:
> > 
> >     Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rejected  
> >     Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: rejected
> > 
> > To fix this, a type parameter is added to pcie_sriov_vf_register_bar()  
> > to indicate the BAR type. It should be set to the same value as in the  
> > pcie_sriov_pf_init_vf_bar() call.
> > 
> > Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")  
> > Signed-off-by: Damien Bergamini <[damien.bergamini@eviden.com](mailto:damien.bergamini@eviden.com)>  
> > Signed-off-by: Clement Mathieu--Drif <[clement.mathieu--drif@eviden.com](mailto:clement.mathieu--drif@eviden.com)>  
> > ---  
> >  docs/pcie_sriov.txt         | 2 +-  
> >  hw/net/igbvf.c              | 8 ++++++--  
> >  hw/nvme/ctrl.c              | 4 +++-  
> >  hw/pci/pci.c                | 3 ---  
> >  hw/pci/pcie_sriov.c         | 6 ++----  
> >  include/hw/pci/pcie_sriov.h | 2 +-  
> >  6 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt  
> > index ab2142807f..77d618b36f 100644  
> > --- a/docs/pcie_sriov.txt  
> > +++ b/docs/pcie_sriov.txt  
> > @@ -83,7 +83,7 @@ setting up a BAR for a VF.  
> >        pcie_ari_init(d, 0x100);  
> >        ...  
> >        memory_region_init(mr, ... )  
> > -      pcie_sriov_vf_register_bar(d, bar_nr, mr);  
> > +      pcie_sriov_vf_register_bar(d, bar_nr, bar_type, mr);  
> >        ...  
> >     }  
> >    
> > diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c  
> > index 31d72c4977..88dd8fb516 100644  
> > --- a/hw/net/igbvf.c  
> > +++ b/hw/net/igbvf.c  
> > @@ -251,10 +251,14 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)  
> >    
> >      memory_region_init_io(&s->mmio, OBJECT(dev), &mmio_ops, s, "igbvf-mmio",  
> >          IGBVF_MMIO_SIZE);  
> > -    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX, &s->mmio);  
> > +    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX,  
> > +                               PCI_BASE_ADDRESS_MEM_TYPE_64 |  
> > +                               PCI_BASE_ADDRESS_MEM_PREFETCH, &s->mmio);  
> >    
> >      memory_region_init(&s->msix, OBJECT(dev), "igbvf-msix", IGBVF_MSIX_SIZE);  
> > -    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX, &s->msix);  
> > +    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX,  
> > +                               PCI_BASE_ADDRESS_MEM_TYPE_64 |  
> > +                               PCI_BASE_ADDRESS_MEM_PREFETCH, &s->msix);  
> >    
> >      ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,  
> >          &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);  
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c  
> > index f5ee6bf260..35a82d2037 100644  
> > --- a/hw/nvme/ctrl.c  
> > +++ b/hw/nvme/ctrl.c  
> > @@ -8709,7 +8709,9 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)  
> >          memory_region_add_subregion(&n->bar0, 0, &n->iomem);  
> >    
> >          if (pci_is_vf(pci_dev)) {  
> > -            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);  
> > +            pcie_sriov_vf_register_bar(pci_dev, 0,  
> > +                                       PCI_BASE_ADDRESS_SPACE_MEMORY |  
> > +                                       PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);  
> >          } else {  
> >              pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |  
> >                               PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);  
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c  
> > index c70b5ceeba..4fe2626f9e 100644  
> > --- a/hw/pci/pci.c  
> > +++ b/hw/pci/pci.c  
> > @@ -1490,9 +1490,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,  
> >                          : pci_get_bus(pci_dev)->address_space_mem;  
> >    
> >      if (pci_is_vf(pci_dev)) {  
> > -        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;  
> > -        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);  
> > -  
> >          r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);  
> >          if (r->addr != PCI_BAR_UNMAPPED) {  
> >              memory_region_add_subregion_overlap(r->address_space,  
> > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c  
> > index 8a4bf0d6f7..eedce6be1d 100644  
> > --- a/hw/pci/pcie_sriov.c  
> > +++ b/hw/pci/pcie_sriov.c  
> > @@ -242,13 +242,11 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,  
> >      dev->exp.sriov_pf.vf_bar_type[region_num] = type;  
> >  }  
> >    
> > +/* `type` must match the type passed to pcie_sriov_pf_init_vf_bar() */  
> >  void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,  
> > -                                MemoryRegion *memory)  
> > +                                uint8_t type, MemoryRegion *memory)  
> >  {  
> > -    uint8_t type;  
> > -  
> >      assert(dev->exp.sriov_vf.pf);  
> > -    type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];  
> >    
> >      return pci_register_bar(dev, region_num, type, memory);  
> >  }  
> > diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h  
> > index aeaa38cf34..b67449f8ba 100644  
> > --- a/include/hw/pci/pcie_sriov.h  
> > +++ b/include/hw/pci/pcie_sriov.h  
> > @@ -39,7 +39,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,  
> >    
> >  /* Instantiate a bar for a VF */  
> >  void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,  
> > -                                MemoryRegion *memory);  
> > +                                uint8_t type, MemoryRegion *memory);  
> >    
> >  /**  
> >   * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created


