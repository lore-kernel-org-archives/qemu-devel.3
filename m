Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036E7F357D9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvys-0002lq-R1; Tue, 24 Feb 2026 12:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuvyq-0002la-Qq
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:13:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuvyo-0006xQ-CB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:13:52 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL46l4pxqzHnGhH;
 Wed, 25 Feb 2026 01:13:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id F0CD240569;
 Wed, 25 Feb 2026 01:13:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 17:13:42 +0000
Date: Tue, 24 Feb 2026 17:13:40 +0000
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Ankit Agrawal
 <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Vikram Sethi
 <vsethi@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "anisinha@redhat.com"
 <anisinha@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260224171340.00006613@huawei.com>
In-Reply-To: <20260224164116.00003fc0@huawei.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
 <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <aZ28qvehl7Lleo2a@nvidia.com>
 <SA1PR12MB71991611FEAA1B2D6A5171DFB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260224164116.00003fc0@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
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

On Tue, 24 Feb 2026 16:41:16 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> On Tue, 24 Feb 2026 16:22:56 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
> 
> > >> Now the kernel parse it in the sequence of their occurrence. A jumbled up
> > >> sequence thus results in a jumbled up assignment.    
> > >
> > > But what is the actual failure mode here? So the numa IDs are all in a
> > > weird order, what goes wrong from that?    
> > 
> > This interferes with the ability to replicate the numa distance topology
> > on host in the VM through qemu command line.
> > 
> > E.g. consider a NUMA system with 2 sockets each with a GPU.
> > 0,1 are the node ids for the sysmem on socket 0,1 respectively and
> > 2,3 are the node ids for the GPU memory on socket 0,1 respectively
> > dist(0,2) = X
> > dist(0,3) = Y
> > 
> > If we try to replicate this for the VM by passing qemu arguments with
> > 4 numa nodes and assign numa distances similar to host, and for the
> > sake of example qemu mixes up by putting GI for 3 over 2. The SLIT
> > which sets up the distances do it considering the original order in the
> > qemu command line.
> > https://github.com/qemu/qemu/blob/stable-10.2/hw/acpi/aml-build.c#L2040
> > 
> > This would lead to a different numa config in terms of distance within
> > the VM that the one intended through the qemu command line.  
> 
> This is the case where I'd like to see an example of the tables before
> and after your patch.  If the SLIT is not correctly created wrt to PXMs
> (rather than the order of the commands) then we indeed have a QEMU bug that
> needs fixing.  However, I'm confused as SLIT should also not be ordered
> by command line if the say the command line was:
> 
>        -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=3 \
>        -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=4 \
>        -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=6 \
>        -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
>        -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=2 \
>        -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
>        -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
>        -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> 
> and numa stuff was something like
>        -numa dist,src=3,dst=0,val=100
>        -numa dist,src=4,dst=0,val=200
>        -numa dist,src=5,dst=0,val=300
>        -numa dist,src=6,dst=0,val=100
>        -numa dist,src=7,dst=0,val=200
>        -numa dist,src=8,dst=0,val=300
>        -numa dist,src=9,dst=0,val=100
> 
> Then it should be matching src numbers here to node in the GIs whatever the order.

I had a mess around and it seems SLIT is stable to ordering of the nodes (based
on a very minimal test so I may well be missing something!), but because the
/sys/bus/node/devices/nodeX/distance is reordered by the PXM to kernel numa
node mapping (which as you've observed is first come first served in parsing
for GIs in new nodes), you will see that apparently reordering to reflect the
kernel numa node order.

How do you associate the resulting numa node with a particular resource on your
GPU?  That mapping should also be by PXM and as a result I would expect to see it
refer to the appropriate entry after PXM to node translation in the kernel
whatever order stuff under /sys/bus/nodes/devices/nodeX ends up in.

For extra fun I put my CPUs and memory on different nodes and that always ends
up mapped to the first node in Linux (assuming they are all on one node) with
appropriate reordering of the nodeX/distance entries.

Jonathan


> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > Thanks
> > Ankit Agrawal  
> 
> 


