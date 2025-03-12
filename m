Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D0C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 18:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsQf9-0007cy-Rl; Wed, 12 Mar 2025 14:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tsQf7-0007cb-Q8
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:18:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tsQf5-0001k5-Tw
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:18:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCf1h0T7kz6M4KQ;
 Thu, 13 Mar 2025 02:15:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A1D65140736;
 Thu, 13 Mar 2025 02:18:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:18:28 +0100
Date: Wed, 12 Mar 2025 18:18:26 +0000
To: Gerd Hoffmann <kraxel@redhat.com>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>,
 <santosh.shukla@amd.com>, <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>,
 <bsd@redhat.com>, <berrange@redhat.com>, <ddutile@redhat.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250312181826.0000473d@huawei.com>
In-Reply-To: <o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250310135731.00005b1f@huawei.com>
 <o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 11 Mar 2025 09:08:06 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > As a heads up, I believe we have a similar problem with a few of the CXL IDs.
> > The root port and type 3 device both use Intel IDs that were not reserved
> > for this purpose.  VID=0x8086, DID=0x7075 and DID=0x0d93  
> 
> Essentially we have two kinds of PCI devices in qemu.
> 
>  * The ones which try to mimic existing hardware, they usually have the
>    PCI ID of the device they are emulating (and use the qemu subsystem ID).
>    The classic example is the cirrus vga.  There are also many intel
>    chipset devices for piix4 ('pc' machine type) and ich9 ('q35' machine
>    type) with intel IDs.
> 
>  * The ones which are PCI class implementations and do not need a
>    specific ID for drivers to accept them.  Most of them have a
>    PCI device ID from the 1b36 vendor ID range.
> 
> The former tend to be older devices (before hardware standardization was
> a thing, also before we got a range from 1b36 for qemu), and the latter
> tend to be newer devices.  There are also a bunch of exceptions for
> historical reasons.  The ahci emulation has a ich9 id.  xhci even has
> two variants (one mimicking a NEC host adapter, one with qemu device id).
> 
> So, in short, using the intel IDs is not necessarily a problem.  Depends
> a bit on what kind of device we are talking about.  For PCI class
> devices it usually is more useful to have a qemu ID though.

They are not valid IDs, so they may get used in future for real
hardware of an entirely different type. We don't want these to
correspond to real hardware either because the aim is to test
out corners of the spec, so we may well implement completely different
sets of features to any real implementation.

> 
> > Switch ports and switch-cci are using valid Hisilicon IDs that are for
> > emulation of these device only and are registered in our tracker
> > for these IDs so won't get 'reused'.  
> 
> That is perfectly fine.  There is no need to change IDs, although it
> makes sense to document that fact in docs/specs/pci-ids.rst

Ah. I wasn't aware of the ID space reserved for QEMU or that doc.

We can leave the HiSilicon ones alone.  I'll sort a docs patch for
the 3 of those soon.

For the Intel ones can I have a pair for the root port and the CXL
type 3 device (so 2 IDs)?  We will probably need one shortly for
the type2 emulation test device as well.

Thanks,

Jonathan


> 
> Moving them to qemu pci id range is an option too if you prefer that.
> Your choice.
> 
> take care,
>   Gerd
> 
> 


