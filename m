Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67402606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHSN4nmS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRJmV-0001wX-4S; Wed, 11 Nov 2026 20:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xRJmP-0001ou-Kn
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 20:39:09 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xRJmN-00031V-3D
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 20:39:08 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F3CA430AD;
 Thu, 12 Nov 2026 01:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D947B1F00A05;
 Thu, 12 Nov 2026 01:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794447542;
 bh=16JpmqODOB+1SVzd752/EGAX8QY6db3MkqO4sF9Yyrg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dHSN4nmSoR2Sr+rl4ADaFFEPyc2jnye/1yl4Orq0iSkS/EJQ+u8RB7CHpyPQF0L6X
 OMdMCRzjTeE805wKcivzoOxa7j8h2wGARXIToatdFtz/rlTpIEKecMecjzbhxDW71Y
 ryoFen/8f+WpPIlNK2TXbNiuzAR+D6VEj7bax1R1VfTEi6kVoZkeTJ0MQu44WioIpQ
 2xiVFBPqZmz1fiB9mHAJwXX5pnTBKR+30DReue1LlSjr5oxoMqDFCBBFe58cfe+I78
 sfelFHvmz/dpZyJGV0OQkfq9iUAmWv61TEnsWjp1mVL67KYX9OQo/G0/mlvZC0aJLx
 c906uqOwREA+A==
Date: Thu, 12 Nov 2026 01:38:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 2/4] hw/pci: add IDE + TEE capability to PCIe root port
Message-ID: <20261112013854.5a3cfb6b@jic23-hlaptop>
In-Reply-To: <auxtI9xz2y3tWfl8@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org>
 <20261104192709.3b260e06@jic23-hlaptop>
 <auxtI9xz2y3tWfl8@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 11:48:51 +0000
Jim MacArthur <jim.macarthur@linaro.org> wrote:

> On Wed, Nov 04, 2026 at 07:27:09PM +0000, Jonathan Cameron wrote:
> > On Thu, 29 Oct 2026 15:05:11 +0000
> > Jim MacArthur <jim.macarthur@linaro.org> wrote:
> >   
> > > From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > 
> > > Adds the TEE flag in the legacy config space, and the IDE
> > > (Integrity & Data Encryption) extended capability. These
> > > will be present when rme-cap=on is specified for the
> > > pcie-root-port device.
> > > 
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > Signed-off-by: Jim MacArthur <Jim MacArthur@linaro.org>
> > > ---
> > >  hw/pci-bridge/gen_pcie_root_port.c | 21 ++++++++++++++++++++-
> > >  hw/pci/pcie.c                      | 19 +++++++++++++++++++
> > >  include/hw/pci/pcie.h              |  3 +++
> > >  include/hw/pci/pcie_regs.h         |  4 ++++
> > >  4 files changed, 46 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > > index 5434d693d9..ab8087da87 100644
> > > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > > @@ -26,13 +26,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
> > >  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> > >  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> > >          (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> > > -
> > > +#define GEN_PCIE_ROOT_PORT_ACS_END \
> > > +        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)  
> > 
> > Can't you figure this out from root port class acs offset?
> > 
> > Or if you want it in a fixed place follow that pattern and stash it
> > in the root class during dev_rp_dev_class_init.
> >   
> 
> There seems to be quite a lot of cases where we're arranging capabilities in
> sequential order in memory, but hard-coding the locations. I would rather all
> of this be replaced with a dynamic pointer which records the next capability
> offset, and it looks like there are attempts to do this with, e.g.
> pcie_insert_capability, but that has a lot of caveats and only gets used once.
> 
> I'll have another think about this, and in the meantime if anyone knows a good
> reason why we do hardcode this, that would be useful.

I also thought about trying to fix this in the past along the lines you describe
but never spent the time to actually do it!

So as far as I'm concerned it would be welcome. I think we would need some
test cases though to check we aren't breaking migration by accidentally moving
stuff around in a new qemu version.

> 
> > > +
> > > +    if (grp->rme_caps) {  
> > Not arm specific. Can't see any harm in using a generic config name
> > for this.  Actually I'm not seeing a reason not to always include
> > the ide cap. Maybe less so for setting up tee.  Haven't really thought about
> > that.
> >   
> 
> Good point, IDE/TEE could be separate named options quite easily. There might
> be more Arm RME things included later, but that can be a third option.
> 
> Thanks for the review,
> 
> Jim


