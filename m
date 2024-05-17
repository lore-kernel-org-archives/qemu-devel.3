Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEB5C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 18:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s81wB-0007T6-W7; Fri, 17 May 2024 14:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s81w5-0007Pg-SD
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:04:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s81w1-0005WS-0s
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:04:05 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vgvvl48vPz6J7t8;
 Sat, 18 May 2024 02:03:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EBF83140AE5;
 Sat, 18 May 2024 02:03:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 19:03:57 +0100
Date: Fri, 17 May 2024 19:03:56 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <dan.williams@intel.com>
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <20240517190356.0000582a@Huawei.com>
In-Reply-To: <20240517111441.00002279@Huawei.com>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
 <ZjyK1tI0TtbAKhmh@phytium.com.cn>
 <20240510181646.000019a1@Huawei.com>
 <ZkcsS0we4XHPgBIP@phytium.com.cn>
 <20240517111441.00002279@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Fri, 17 May 2024 11:14:41 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 17 May 2024 18:07:07 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > On Fri, May 10, 2024 at 06:16:46PM +0100, Jonathan Cameron wrote:  
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/cxl-staging.git/log/?h=arm-numa-fixes
> > >     
> > Thank you :)  
> > > I've run out of time to sort out cover letters and things + just before the merge
> > > window is never a good time get anyone to pay attention to potentially controversial
> > > patches.  So for now I've thrown up a branch on kernel.org with Robert's
> > > series of fixes of related code (that's queued in the ACPI tree for the merge window)
> > > and Dan Williams (from several years ago) + my additions that 'work' (lightly tested)
> > > on qemu/arm64 with the generic port patches etc. 
> > > 
> > > I'll send out an RFC in a couple of weeks.  In meantime let me know if you
> > > run into any problems or have suggestions to improve them.
> > > 
> > > Jonathan
> > >    
> > With the latest commit(d077bf9) in the 'arm-numa-fixes', the qemu virt
> > could create a cxl region with a new numa node (node 2) just like x86.
> > At this stage(the first time to create cxl region), everything works
> > fine.
> > 
> > However, if I use below commands to delete the created cxl region:
> > 
> > `daxctl offline-memory dax0.0`
> > `cxl disable-region region0`
> > `cxl destroy-region region0`
> > 
> > and then recreate it by `cxl create-region -d decoder0.0 -t ram`, the
> > kernel could not create the numa node2 again, and the kernel will print:
> > 
> > [  589.458971] Fallback order for Node 0: 0 1
> > [  589.459136] Fallback order for Node 1: 1 0
> > [  589.459175] Fallback order for Node 2: 0 1
> > [  589.459213] Built 2 zonelists, mobility grouping on.  Total pages: 1009890
> > [  589.459284] Policy zone: Normal  
> 
> I'll see if I can figure out what is happening there.

So I know what is happening but not sure on the solution yet.
The issue is on unbind of the region there is a call to try_remove_memory()
and that calls memblock_phys_free(). That removes the reserved memblocks being used
for tracking the numa node, so when you bind a region at that HPA again, there
is no tracking information.

So far I haven't figured out why that call is there in the first place
which isn't helping me solve this.

https://elixir.bootlin.com/linux/v6.9.1/source/mm/memory_hotplug.c#L2286

Until I get this code out there, kind of hard to ask the mm folk
- for now I may just have to say it only works once and point at that
line as the problem in an RFC.

Long shot, but Dan, did you run into this when you were doing your 
[PATCH v2 08/22] memblock: Introduce a generic phys_addr_to_target_node()
stuff?  I assume that ultimately called try_remove_memory() in a remove
path somewhere and similarly to this if you try putting it back it
would be missing.  Or alternatively, any idea why what that memblock_phys_free()
is balancing with?

Jonathan




> > 
> > Meanwhile, the qemu reports that: 
> > 
> > "qemu-system-aarch64: virtio: bogus descriptor or out of resources"  
> 
> That sounds like another TCG issue, or possibly the DMA bounce buffer
> problem resurfacing.  It's not directly related to his NUMA aspect unless
> something very odd is going on.  I'm even more confused because I think
> you are not using kmem with the above commands, so we shouldn't be using
> the CXL memory for virtio.
> 
> Just to check, you aren't running with KVM I hope?  That opens a much
> bigger problem set. :(
> 
> Jonathan
> 
> 
> 
> > 
> > Many thanks
> > Yuquan
> >   
> 
> 


