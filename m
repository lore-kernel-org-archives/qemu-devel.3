Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB810F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutnv-0005nI-El; Tue, 24 Feb 2026 09:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vutnr-0005n0-8U
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:54:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vutnm-0004HA-Lk
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:54:23 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL1271b3rzJ46b4;
 Tue, 24 Feb 2026 22:53:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E857340584;
 Tue, 24 Feb 2026 22:54:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 14:54:11 +0000
Date: Tue, 24 Feb 2026 14:54:10 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Igor Mammedov <imammedo@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "anisinha@redhat.com" <anisinha@redhat.com>, "Aniket
 Agashe" <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, "Zhi
 Wang" <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260224145410.00006b3a@huawei.com>
In-Reply-To: <20260224085955-mutt-send-email-mst@kernel.org>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 24 Feb 2026 09:01:30 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Feb 24, 2026 at 09:51:06AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 23, 2026 at 11:13:02AM +0000, Jonathan Cameron wrote:
> >   
> > > Ankit, can you give an example complete with table dumps please.
> > > 
> > > I'm a little unsure on where things are getting scrambled.
> > > Everything should be keyed of PXM.  Sounds like we have a bug
> > > somewhere but ordering shouldn't be relevant.  
> > 
> > I understood the issue is Linux assigns the uAPI visible NUMA node
> > numbers based on the ordering. The proximity/etc internal to the
> > kernel (I thought) was OK?
> > 
> > Then the problem is that uAPI has developed meaning based on what the
> > bare metal HW does and now there are SW stacks that are expecting
> > these platforms to have certain NUMA IDs in the Linux uAPI. Sure you
> > can argue this is bad/etc/etc but the point of QEMU is to allow
> > creating VMs that closely match real HW and in this instance real HW
> > produces an ACPI table with a certain ordering and the SW is sensitive
> > to this ordering.
> > 
> > Even if there is some Linux bug mis-parsing the ACPI, then that still
> > should be addressed from a qemu perspective by providing the ACPI
> > construction that doesn't trigger any bug so existing VM images will
> > work under qemu.
> > 
> > Thus qemu needs a way to reflect the ordering on the command line to
> > properly emulate this system and accomodate the existing VM software...
> > 
> > Jason  
> 
> Not arguing against this, but if there's a linux bug it is important
> to fix it as a 1st step. qemu work arounds for broken guests
> notwithstanding. then we can check how long the uapi has been around,
> how practical bugfix backport in linux is, and decide on whether
> a host side work around is worth it.
> 

IIRC NUMA IDs in linux aren't even consistent across architectures.
I think there are cases where the x86 code handles certain SRAT entrees
earlier than the arm64 code does (was either CPUless or memory less nodes
if my memory is right). I haven't poked this stuff for a while
though so maybe those differences got ironed out. Anyhow, relying on those
numbers being stable is optimistic at best. Longer term I'd like to
see the ACPI spec comprehend this case where lots of GIs are the same device
and hence add some way of distinguishing between them that isn't the PXM.

I'd not be against having a kernel patch that sorted at least GI only
nodes by PXM rather that order in the ACPI table (probably GP only ones
as well, though they aren't as visible anyway). It may be controversial!

With that in place it might also make sense to make qemu stop generating
them in a random order (So what this patch is doing).

Note I did a very similar thing for CXL fixed memory windows, but that
was to maintain consistency when I made the fixed memory windows devices
as before that we had them in a list built from the command line.
Without it we got breakage in the bios tests and the physical addresses
shuffled in a fashion that depending on a hash that in theory might change
at any time.

In that case I didn't have an explicit list, but instead stashed an
index parameter in the object and built temporary lists for sorting
purposes.
https://lore.kernel.org/all/20250625161926.549812-3-Jonathan.Cameron@huawei.com/

Jonathan



