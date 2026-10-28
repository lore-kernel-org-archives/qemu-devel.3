Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77116606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ss8tKBTa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rt9BaywK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM43g-0003Sw-2w; Wed, 28 Oct 2026 09:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM43e-0003Sg-Hf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM43c-0000bX-VU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793195472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nt+13qME/1X5ke5/6lX5gWZQNlRov/02/r9MJgmxQK8=;
 b=Ss8tKBTa33dECwdmOQ7Mgfze0Mp21h2xCXbLPvoK0fZ5tEbQ4s9C9xvy3lYk+BWblSUFpH
 9yAC+qVZctqTnIKPyvQEDjH99FpneiDaIMW5U1DOMMzrKgt2St/YcNTXTrn7S2Hxd77a52
 cx31RklW477RRhMfrMgoCGASSvSoyWo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-gJSP4R2rOCuzoyY_2jFcHQ-1; Wed, 28 Oct 2026 09:51:10 -0400
X-MC-Unique: gJSP4R2rOCuzoyY_2jFcHQ-1
X-Mimecast-MFC-AGG-ID: gJSP4R2rOCuzoyY_2jFcHQ_1793195469
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so821789f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793195469; x=1793800269; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nt+13qME/1X5ke5/6lX5gWZQNlRov/02/r9MJgmxQK8=;
 b=rt9BaywK5wHeGHUZvJF8GPsPYH+Gdt90vyCRKcAhK+81Tnk6n3HNUc0futGCgrvBKV
 Gr6pb7i5MTmkYD2wwa1odAuB/inbdrfYUT2PNwlrDV0Ty2gx1q/Sm6SxPKdblRc98hsc
 zRAffJM9SOuIp5CuG5T23q73H6/EEnygBj3Cb2QfnXNMoFLhXnu49R7h/TX/UC9CyuQ9
 aIYoAu0fC1p7DeyZaOxY/f2kx/70MiaVGT63cgMf0nubgG2gRy9h5hzOSHdCgwDBDvH+
 aM2QrL0uY119p06jG/75VvthC/bLFtDhFOyx6Eg4fIxP05RqV8KYwb0aBchmn3v83+yr
 0S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195469; x=1793800269;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nt+13qME/1X5ke5/6lX5gWZQNlRov/02/r9MJgmxQK8=;
 b=zQiZfzPwkIL2lz/F6WUe0m2cHgXvr6r4amXQ8Dq8h9kdGSeu4YlweK8oJ23uqX/slN
 PWCCIbmRrQdsN/VHG8iewGRUgwtXXf92RZvbKLo4yaSkM4FDE8ZFEsqCFmoet6drZp0Q
 TI931/E38P3KCFfgTTMn/YZoDj8yUZUPXCbIBrSYimu2z7vT619Vf1OKVxGfrQdPUSlx
 6rFk5zKhmttLa58gcC52YukNTLhE+lAE1WkrHO6i0Gkw/APygHan17a1s/oBF8mEp2a/
 SHxrxhD7+T9ZEksy1X1OyHMsGVj1p7RyIGjx3oPSrsk0G3Mu10k+mNPRtNXnPwEzHbP7
 kxow==
X-Gm-Message-State: AFq9FYLTFfNZEcEGNN1H6ue2nqf4YSRViPmi8HU/rvFh2s16eEGtYeGG
 Owr/V66kDX5HMLrPKItUztbLUz1hb40df4YfEVBGiCNkI5Fe9T/NXl/RB3NISyq+R3tIW/pGXRt
 SK4NVWnG3H5n4RqSChHGeuZIOUfId/wvEltogWZun4NGScu8rlQAYcSmF
X-Gm-Gg: AYBFou0GSBUXrOQSiLpNVjfiOqJBPuuaJcvOgTodPLVavG1wkJuCmosU+h0R3hi0gzu
 m17W0ANV+zKkKH0GNX8ZWOidrT4vCP+6iCWPUtnv6FcZLra9F8/UkwANNHHVRjiHoyzLCu/1fHi
 uszj6rAIr2SaCOtsX2+Tb6Y4o/EOzltTXtpCM1qm+4B0t78ZH7kIKT/KG4cL4yS0Ze6VTo9op4u
 3I9EVQrJiPmW/FrFot1yj5WXqNAo4/3ByIvC4Q07p796gx0IkG9NPstFvkvQI2ApDH+zKCW0LE1
 j+XKCTJd8D8q/GZzNWn15YEWHRf03QZRw7fP2g0HHZK5gJUuMyiTk8E40X7O20ipKlG+LCKP7KS
 QZpP0HMg3dsXUrLyQyQkxZxFnBUHPar2/x0gdgA//
X-Received: by 2002:a05:600c:1913:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4a96552db88mr50908605e9.0.1793195469149; 
 Wed, 28 Oct 2026 06:51:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1913:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4a96552db88mr50908195e9.0.1793195468624; 
 Wed, 28 Oct 2026 06:51:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f150fsm43553245e9.10.2026.10.28.06.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:51:07 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:51:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Message-ID: <20261028095024-mutt-send-email-mst@kernel.org>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
 <20261028091349-mutt-send-email-mst@kernel.org>
 <c86e267518a07ddf993127c0427dce1543410b4f.camel@bull.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c86e267518a07ddf993127c0427dce1543410b4f.camel@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 01:40:24PM +0000, Clément MATHIEU--DRIF wrote:
> 
> On Wed, 2026-10-28 at 09:14 -0400, Michael S. Tsirkin wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > 
> > 
> > On Mon, Sep 21, 2026 at 05:59:23AM +0000, Clément MATHIEU--DRIF wrote:
> > 
> > > The SR-IOV PCIe capability exposes 6 regions (no ROM), each with a
> > > dedicated 32-bit configuration field. Fix the reset loop to write
> > > 32 bits instead of 64 bits and stop after PCI_SRIOV_NUM_BARS iterations.
> > > 
> > > As a side effect of this change, update PCIESriovPF::vf_bar_type
> > > to match the number of regions exposed by SR-IOV and rework the
> > > associated assert statements.
> > > 
> > > Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
> > > Signed-off-by: Clement Mathieu--Drif <[clement.mathieu--drif@bull.com](mailto:clement.mathieu--drif@bull.com)>
> > 
> > 
> > I queued another patch fixing this, yours will become a cleanup.  
> > Once my pull is merged, pls rebase and report.
> > 
> > Thanks!
> 
> Hi Michael,
> 
> Do you want version rebased on master or another ref?
> 
> cmd

pci branch in my tree will do

> > 
> > 
> > > ---
> > >  hw/pci/pcie_sriov.c         | 9 +++++----
> > >  include/hw/pci/pcie_sriov.h | 2 +-
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > > index c41ac95bee..df61f281ea 100644
> > > --- a/hw/pci/pcie_sriov.c
> > > +++ b/hw/pci/pcie_sriov.c
> > > @@ -229,8 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> > > 
> > >      assert(sriov_cap > 0);
> > >      assert(region_num >= 0);
> > > -    assert(region_num < PCI_NUM_REGIONS);
> > > -    assert(region_num != PCI_ROM_SLOT);
> > > +    assert(region_num < PCI_SRIOV_NUM_BARS);
> > > 
> > >      wmask = ~(size - 1);
> > >      addr = sriov_cap + PCI_SRIOV_BAR + region_num * 4;
> > > @@ -344,6 +343,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
> > >      dev->exp.sriov_pf.vf = vfs;
> > >      dev->exp.sriov_pf.vf_user_created = true;
> > > 
> > > +    assert(vfs[0]->io_regions[PCI_ROM_SLOT].size == 0);
> > > +
> > >      for (i = 0; i < PCI_NUM_REGIONS; i++) {
> > >          PCIIORegion *region = &vfs[0]->io_regions[i];
> > > 
> > > @@ -463,8 +464,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
> > >       */
> > >      pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
> > > 
> > > -    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
> > > -        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> > > +    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > +        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> > >                       dev->exp.sriov_pf.vf_bar_type[i]);
> > >      }
> > >  }
> > > diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> > > index b0ea6a62c7..5f81e3b1bb 100644
> > > --- a/include/hw/pci/pcie_sriov.h
> > > +++ b/include/hw/pci/pcie_sriov.h
> > > @@ -16,7 +16,7 @@
> > >  #include "hw/pci/pci.h"
> > > 
> > >  typedef struct PCIESriovPF {
> > > -    uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> > > +    uint8_t vf_bar_type[PCI_SRIOV_NUM_BARS];   /* Store type for each VF bar */
> > >      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
> > >      bool vf_user_created; /* If VFs are created by user */
> > >  } PCIESriovPF;
> > > --
> > > 2.55.0
> > 
> > 


