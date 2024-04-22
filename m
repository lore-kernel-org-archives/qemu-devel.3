Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3428CC07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuZs-0003zK-52; Mon, 22 Apr 2024 10:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ryuZp-0003xq-GT
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:23:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ryuZm-0007cl-Ex
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:23:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNSCM6j8hz6K9YK;
 Mon, 22 Apr 2024 22:23:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C696E140AE5;
 Mon, 22 Apr 2024 22:23:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 15:23:17 +0100
Date: Mon, 22 Apr 2024 15:23:16 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: fan <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <20240422152316.00005e1a@Huawei.com>
In-Reply-To: <20240422130448.000057ec@huawei.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com> <ZiK7QtVxutwDys4K@debian>
 <ZiQnIkYjY3ngRLAi@memverge.com>
 <20240422130448.000057ec@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Apr 2024 13:04:48 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Sat, 20 Apr 2024 16:35:46 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Fri, Apr 19, 2024 at 11:43:14AM -0700, fan wrote:  
> > > On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:    
> > > > 
> > > > added review to all patches, will hopefully be able to add a Tested-by
> > > > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > > > 
> > > > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > > > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > > > 
> > > > The super-set release will complicate a few things but this doesn't
> > > > look like a blocker on our end, just a change to how we track bits in a
> > > > shared bit/bytemap.
> > > >     
> > > 
> > > Hi Gregory,
> > > Thanks for reviewing the patches so quickly. 
> > > 
> > > No pressure, but look forward to your MHD work. :)
> > > 
> > > Fan    
> > 
> > Starting to get into versioniong hell a bit, since the Niagara work was
> > based off of jonathan's branch and the mhd-dcd work needs some of the
> > extentions from that branch - while this branch is based on master.
> > 
> > Probably we'll need to wait for a new cxl dated branch to try and sus
> > out the pain points before we push an RFC.  I would not want to have
> > conflicting commits for something like this for example:
> > 
> > https://lore.kernel.org/qemu-devel/20230901012914.226527-2-gregory.price@memverge.com/
> > 
> > We get merge conflicts here because this is behind that patch. So
> > pushing up an RFC in this state would be mostly useless to everyone  
> 
> Subtle hint noted ;) 
> 
> I'll build a fresh tree - any remaining rebases until QEMU 9.0 should be
> straight forward anyway.   My ideal is that the NUMA GP series lands early
> in 9.1 cycle and this can go in parallel.  I'd really like to
> get this in early if possible so we can start clearing some of the other
> stuff that ended up built on top of it!

I've pushed to gitlab.com/jic23/qemu cxl-2024-04-22-draft
Its extremely lightly tested so far.

To save time, I've temporarily dropped the fm-api DCD initiate
dynamic capacity add patch as that needs non trivial updates.

I've not yet caught up with some other outstanding series, but
I will almost certainly put them on top of DCD.

Jonathan

> 
> Jonathan
> 
> > 
> > ~Gregory  
> 
> 


