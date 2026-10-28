Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D93606A33D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYJU3ceH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n4Zkzq3g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4VW-0001p8-3g; Wed, 28 Oct 2026 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM4VT-0001nE-8N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM4VR-00036p-F8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793197195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LdTjhqAKcFbPUYNDvTylW0Yrfn1ToujO76auFsc/JY=;
 b=JYJU3ceH5AeYZd7h7cP0RtHRUzBdMdyE5dSRiTTkqLPsC0F8AVcPpnebyywuXl74NnJLai
 j/lBpd44L2PjW9IRV5uieufhgfuyzzZu5ZRIuWhFbDHn0nPzC6FNSNoIFnJg+m6URPgthX
 AFxiZtld+XVw9/0BniSLI+cHMrp0Q5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-XyqrHgR1NiyR195El8wnqg-1; Wed, 28 Oct 2026 10:19:47 -0400
X-MC-Unique: XyqrHgR1NiyR195El8wnqg-1
X-Mimecast-MFC-AGG-ID: XyqrHgR1NiyR195El8wnqg_1793197186
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so811121f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793197186; x=1793801986; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+LdTjhqAKcFbPUYNDvTylW0Yrfn1ToujO76auFsc/JY=;
 b=n4Zkzq3gDhLGrVD6s3MeM/sQMn+PVj1+H+LtOl18GQ4eVHbwbabNCa7CmWDsV0u2fC
 G15XANiRBReVp6TBP8vd/BsdRIKjAMpY2swGVwHi0aCKXQ32Fz2+gv6jTiYS84JETtk7
 iKbmA9ej3T9R8HNRvzzmkFz/cex6Md2x7ulUEe/zf8aiVgG60Btegg68TxB2e7PVkXsM
 a12T4V3BPckC3RomqEPe8Ge1XkLLU1te+Ea0JG+R5g2+9TaqTRW6QqwJ85SvIuSqR95w
 kiRYkLZjS/1nS/45SUVyk/YrVw2MF9VC4d71X78Hc/LkwcZ+sJEfBrAS+fE9mJxJnvWc
 sWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197186; x=1793801986;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+LdTjhqAKcFbPUYNDvTylW0Yrfn1ToujO76auFsc/JY=;
 b=AnxTU7Z2fUW/nKzdFOsMquh5ETCf58OBF1bji2pRGgo+V8VCLxL9B+yE2Djh8fgz5j
 7Ajw5Lbmxcz37lFiy4suqwz5U8W5dcCsI3X5NCmhsCT8O+dn3uWE+nDRQTg0F+JB1Pto
 ylrxXBsllmuO4RzADh3AmCmHWCtczUN6woLLYzEfUP+Vgyvtbz7Lld5ifvcZoPpAOTgt
 kHnXFJk1YBTcV9kfAdk4uSqpvqJmtbg6MQeNW8RWyBVBTmIBiERJN/GPhKgQn8IGeTLG
 qJmV418ucR1RGRnH4x5GStrZFbA/kHBeGW09IZzEEK8asabE3dYJcFumus7umYbhG352
 wrew==
X-Gm-Message-State: AFq9FYK6cviuoDN3OXfiZm2HS0eXsSRG7WeTHKRd295sfGee/w/G/FOF
 3oTBo3YJcHHiWZf0J3ugBjq3bHstlEnrg8/zT6WHDkK4HRe4VAGHIPxaNjxLcybOlGyeWIpj0pb
 /fjo+mVHuUb2W+SvPVw07NtYnMvE5UEZPsnh++nCAwCIWUlJgP5KJ8VQp
X-Gm-Gg: AYBFou1IX/MeW4oxChbjBy8dTWnJaUWjJFaBI/KCGCzt6/SEAFyJVfuqr+EuuLBm8Av
 fmIW15QDbfO2ce6pZEpmhMlt7S0V0g0EG/ouFsxVHwuwoemkpDkWW9DyjIfSG2QY8yknB6Cs8gc
 xqB83KStRSPKiYYZQq0JlWHt3HMZRCvhcLV5YEpb5hW1Y92BgQPfEHxGBT8N7Kfch0bAsqkRAHW
 bTYUM7EV+16ni2WBt6ODjFruKbp2VHV2ijO+FAXC5agKj/x8mkvVAwroYPs8tPRE2vsYpHqlFoJ
 lz3FczcTDoAw+/rxdRD2/ZTAsLCOuyHdubVp0zkE7DeKQ75b7w4pz4XaqHWWtmYTmbbe32J1S7M
 AbqGBSciIWDUbPi+Hpx7q50PusDMTHw6KcLRjiSAk
X-Received: by 2002:a05:6000:2d82:b0:48e:4a8a:e17f with SMTP id
 ffacd0b85a97d-48e5d319faemr4571027f8f.4.1793197186033; 
 Wed, 28 Oct 2026 07:19:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2d82:b0:48e:4a8a:e17f with SMTP id
 ffacd0b85a97d-48e5d319faemr4570943f8f.4.1793197185297; 
 Wed, 28 Oct 2026 07:19:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm27941407f8f.14.2026.10.28.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:19:44 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:19:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Message-ID: <20261028101858-mutt-send-email-mst@kernel.org>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
 <20261028091349-mutt-send-email-mst@kernel.org>
 <c86e267518a07ddf993127c0427dce1543410b4f.camel@bull.com>
 <20261028095024-mutt-send-email-mst@kernel.org>
 <843ada23fc5c54c2fe70fc0f569241a43635b6b0.camel@bull.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <843ada23fc5c54c2fe70fc0f569241a43635b6b0.camel@bull.com>
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

On Wed, Oct 28, 2026 at 02:12:43PM +0000, Clément MATHIEU--DRIF wrote:
> 
> On Wed, 2026-10-28 at 09:51 -0400, Michael S. Tsirkin wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > 
> > 
> > On Wed, Oct 28, 2026 at 01:40:24PM +0000, Clément MATHIEU--DRIF wrote:
> > 
> > 
> > > On Wed, 2026-10-28 at 09:14 -0400, Michael S. Tsirkin wrote:
> > > 
> > > > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > > > 
> > > > 
> > > > On Mon, Sep 21, 2026 at 05:59:23AM +0000, Clément MATHIEU--DRIF wrote:
> > > > 
> > > > 
> > > > > The SR-IOV PCIe capability exposes 6 regions (no ROM), each with a
> > > > > dedicated 32-bit configuration field. Fix the reset loop to write
> > > > > 32 bits instead of 64 bits and stop after PCI_SRIOV_NUM_BARS iterations.
> > > > > 
> > > > > As a side effect of this change, update PCIESriovPF::vf_bar_type
> > > > > to match the number of regions exposed by SR-IOV and rework the
> > > > > associated assert statements.
> > > > > 
> > > > > Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
> > > > > Signed-off-by: Clement Mathieu--Drif <[[clement.mathieu--drif@bull.com](mailto:clement.mathieu--drif@bull.com)](mailto:[clement.mathieu--drif@bull.com](mailto:clement.mathieu--drif@bull.com))>
> > > > 
> > > > 
> > > > 
> > > > I queued another patch fixing this, yours will become a cleanup.
> > > > Once my pull is merged, pls rebase and report.
> > > > 
> > > > Thanks!
> > > 
> > > 
> > > Hi Michael,
> > > 
> > > Do you want version rebased on master or another ref?
> > > 
> > > cmd
> > 
> > 
> > pci branch in my tree will do
> 
> You already put the patch in the branch.
> 
> I'm ok with the remaining changes if we update the commit message to:
> 
> ```
> pcie_sriov: Rework the assert statements checking region numbers  
> 
> pcie_sriov_pf_init_vf_bar: PCI_ROM_SLOT is already out of the SR-IOV regions.  
> pcie_sriov_pf_init_from_user_created_vfs: ROM region must never have a non-zero size.
> ```

Pls revert and post the corrected version, I will replace mine with that
one.

> > 
> > 
> > 
> > > > 
> > > > 
> > > > 
> > > > > ---
> > > > >  hw/pci/pcie_sriov.c         | 9 +++++----
> > > > >  include/hw/pci/pcie_sriov.h | 2 +-
> > > > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > > > > index c41ac95bee..df61f281ea 100644
> > > > > --- a/hw/pci/pcie_sriov.c
> > > > > +++ b/hw/pci/pcie_sriov.c
> > > > > @@ -229,8 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
> > > > > 
> > > > >      assert(sriov_cap > 0);
> > > > >      assert(region_num >= 0);
> > > > > -    assert(region_num < PCI_NUM_REGIONS);
> > > > > -    assert(region_num != PCI_ROM_SLOT);
> > > > > +    assert(region_num < PCI_SRIOV_NUM_BARS);
> > > > > 
> > > > >      wmask = ~(size - 1);
> > > > >      addr = sriov_cap + PCI_SRIOV_BAR + region_num * 4;
> > > > > @@ -344,6 +343,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
> > > > >      dev->exp.sriov_pf.vf = vfs;
> > > > >      dev->exp.sriov_pf.vf_user_created = true;
> > > > > 
> > > > > +    assert(vfs[0]->io_regions[PCI_ROM_SLOT].size == 0);
> > > > > +
> > > > >      for (i = 0; i < PCI_NUM_REGIONS; i++) {
> > > > >          PCIIORegion *region = &vfs[0]->io_regions[i];
> > > > > 
> > > > > @@ -463,8 +464,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
> > > > >       */
> > > > >      pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
> > > > > 
> > > > > -    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
> > > > > -        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> > > > > +    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > > > +        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> > > > >                       dev->exp.sriov_pf.vf_bar_type[i]);
> > > > >      }
> > > > >  }
> > > > > diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> > > > > index b0ea6a62c7..5f81e3b1bb 100644
> > > > > --- a/include/hw/pci/pcie_sriov.h
> > > > > +++ b/include/hw/pci/pcie_sriov.h
> > > > > @@ -16,7 +16,7 @@
> > > > >  #include "hw/pci/pci.h"
> > > > > 
> > > > >  typedef struct PCIESriovPF {
> > > > > -    uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> > > > > +    uint8_t vf_bar_type[PCI_SRIOV_NUM_BARS];   /* Store type for each VF bar */
> > > > >      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
> > > > >      bool vf_user_created; /* If VFs are created by user */
> > > > >  } PCIESriovPF;
> > > > > --
> > > > > 2.55.0
> > > > 
> > > > 
> > > > 
> > >
> > 
> > 


