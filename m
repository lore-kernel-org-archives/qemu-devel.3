Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F410ACF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 19:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srNDL-000752-3F; Thu, 19 Sep 2024 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srNDJ-0006xc-2Y
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:53:17 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srNDG-0007bp-Ev
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=J+Jwb6JmIZ5IqyXlZPjXhlGp4JMFWGE+9kKyeshWdME=; b=RHeH2VS2n+RZOcy7
 NI/nOt29uveCXoyxMtOK8HJlvvFpUauq93SmJ9KzMX0kE4zSTtnr28lLpH7F2GdRfo452Q1OT789m
 FErwnPyOX8uqLWnpZXjfSvuJO2qktQTZ4FcH3Z87rEkw80taO5MICS6hjXVYlN58Cezmjddoklv00
 w4UNXhxM37GO3bsv/soyGs7V+aq7dXQMUDtZ2/USBIfQadJGt59g85NhitGVi8wVFOx6PjXLzbYHO
 AZzjt5oXH61i+y9D3YlcZofaBJqgM69cy+dbSfeJuG7VpxuXoB50bmTr50RFxCGxkVksYp8nlshft
 mbqAjTXndWabXH62yw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1srNDB-006TKR-24;
 Thu, 19 Sep 2024 19:53:09 +0000
Date: Thu, 19 Sep 2024 19:53:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH] q35: Remove unused mch_mcfg_base
Message-ID: <ZuyBJfigS6jnUN6c@gallifrey>
References: <20240918005132.187517-1-dave@treblig.org>
 <A4D1CDE0-9424-44EB-8E50-46FB84BAA509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <A4D1CDE0-9424-44EB-8E50-46FB84BAA509@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:51:09 up 134 days,  7:05,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Bernhard Beschow (shentey@gmail.com) wrote:
> 
> 
> Am 18. September 2024 00:51:32 UTC schrieb dave@treblig.org:
> >From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >
> >mch_mcfg_base has been unused since it was added by
> >  6f1426ab0f ("ich9: APIs for pc guest info")
> >back in 2013.
> 
> Indeed.
> 
> >
> >Remove it.
> >
> >Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Thanks!

> I'm curious: How do you detect such unused code?

I've got a very hacky script that looks for symbols that
are defined but nothing else uses; it generates a lot of
false positives so takes a lot of handholding to find
real cases.
See: https://lore.kernel.org/lkml/ZugliLgw5VFb9yau@gallifrey/

Dave

> >---
> > hw/pci-host/q35.c         | 10 ----------
> > include/hw/pci-host/q35.h |  2 --
> > 2 files changed, 12 deletions(-)
> >
> >diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> >index d5a657a02a..f3e713318e 100644
> >--- a/hw/pci-host/q35.c
> >+++ b/hw/pci-host/q35.c
> >@@ -662,16 +662,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
> >                                    OBJECT(&mch->smram));
> > }
> > 
> >-uint64_t mch_mcfg_base(void)
> >-{
> >-    bool ambiguous;
> >-    Object *o = object_resolve_path_type("", TYPE_MCH_PCI_DEVICE, &ambiguous);
> >-    if (!o) {
> >-        return 0;
> >-    }
> >-    return MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT;
> >-}
> >-
> > static Property mch_props[] = {
> >     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
> >                        16),
> >diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> >index 22fadfa3ed..ddafc3f2e3 100644
> >--- a/include/hw/pci-host/q35.h
> >+++ b/include/hw/pci-host/q35.h
> >@@ -181,8 +181,6 @@ struct Q35PCIHost {
> > #define MCH_PCIE_DEV                           1
> > #define MCH_PCIE_FUNC                          0
> > 
> >-uint64_t mch_mcfg_base(void);
> >-
> > /*
> >  * Arbitrary but unique BNF number for IOAPIC device.
> >  *
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

