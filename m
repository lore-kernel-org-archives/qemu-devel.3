Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C356EA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuTv1-0001tx-AC; Mon, 23 Feb 2026 06:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuTuk-0001q1-Jq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:15:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuTuF-0005Vr-K7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:15:36 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKJ964PQszHnGhH;
 Mon, 23 Feb 2026 19:12:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7177D40539;
 Mon, 23 Feb 2026 19:13:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Feb
 2026 11:13:03 +0000
Date: Mon, 23 Feb 2026 11:13:02 +0000
To: Igor Mammedov <imammedo@redhat.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>, 
 "alex@shazbot.org" <alex@shazbot.org>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260223111302.00000081@huawei.com>
In-Reply-To: <20260223104411.57a815fa@imammedo>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

On Mon, 23 Feb 2026 10:44:11 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 23 Feb 2026 07:49:51 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
> 
> > >> During creation of the VM's SRAT table, the generic initiator entries
> > >> are added. Currently the order in the entries are not controllable from
> > >> the qemu command. This is due to the fact that the code queries the
> > >> object tree which may not be in the order objects were inserted.
> > >>
> > >> As a fix the patch maintains a GPtrArray of generic initiator objects
> > >> that preserves their insertion order. Objects are automatically added
> > >> to the array when initialized and removed when finalized. When building
> > >> the SRAT table, objects are processed in the order they were first
> > >> inserted.    
> > >
> > > so question would be, why does it matter?
> > > Is ther a requirement in spec for SRAT entries being put in a particular order?    
> > 
> > Hi Igor, reposting my response. I'll make this information as part of the next
> > version if and when I refresh.
> > 
> > VM's Linux kernel parses the generic initiator (GI) structures present in the SRAT
> > table sequentially in the order of their occurrence and assigns a numa node
> > id when a new proximity domain (that is part of the GI structure) is encountered.
> > A jumbled up entries in the VM's SRAT consequently results in the jumbled up
> > sequence on numa nodes v/s the ones intended to be assigned through the
> > qemu command line. This messes up the internode numa distances assignment
> > through the qemu command line as the VM's view of the corresponding nodes
> > is entirely different.  
> 
> Assuming that QEMU CLI is correctly defined, above looks very much like a linux
> kernel bug.
> 
> Aka: if kernel is not mapping proximity ID to its internal node ids correctly
> and then links them with something else entirely, it's kernel in wrong
> and not ACPI tables QEMU provides.
> 
> IMHO it should be fixed on kernel side. (unless you find statement in spec
> that mandates the particular ordering in SRAT)
> 
Ankit, can you give an example complete with table dumps please.

I'm a little unsure on where things are getting scrambled.  Everything should be
keyed of PXM.   Sounds like we have a bug somewhere but ordering shouldn't be relevant.

Jonathan

> 


