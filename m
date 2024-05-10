Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06DCC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Trk-0007QL-KG; Fri, 10 May 2024 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s5Tri-0007MX-B9
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:17:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s5Trf-0001aA-C5
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:17:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vbb7n4lDtz67pJF;
 Sat, 11 May 2024 01:13:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 65ED0140B30;
 Sat, 11 May 2024 01:16:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 May
 2024 18:16:47 +0100
Date: Fri, 10 May 2024 18:16:46 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <20240508130252.00006367@huawei.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <20240510181646.000019a1@Huawei.com>
In-Reply-To: <ZjyK1tI0TtbAKhmh@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
 <ZjyK1tI0TtbAKhmh@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 9 May 2024 16:35:34 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On Wed, May 08, 2024 at 01:02:52PM +0100, Jonathan Cameron wrote:
> >   
> > > [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
> > > [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
> > > [    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
> > > [    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
> > > [    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
> > > [    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]
> > > 
> > > Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/
> > > 
> > > root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
> > > [   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
> > > [   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0  
> > 
> > You need a load of kernel changes for NUMA nodes to work correctly with
> > CXL memory on arm64 platforms.  I have some working code but need to tidy
> > up a few corners that came up in an internal review earlier this week.
> > 
> > I have some travel coming up so may take a week or so to get those out.
> > 
> > Curiously that invalid memblk has nothing to do with the CXL fixed memory window
> > Could you check if that is happening for you without the CXL patches?
> >   
> 
> Thanks.
> 
> I have checked it, the problem is caused by my bios firmware file. I
> change the bios file and the numa topology can works.
> 
> BTW, if it is convenient, could you help to post the link of the patches of CXL 
> memory NUMA nodes on arm64 platforms?

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/cxl-staging.git/log/?h=arm-numa-fixes

I've run out of time to sort out cover letters and things + just before the merge
window is never a good time get anyone to pay attention to potentially controversial
patches.  So for now I've thrown up a branch on kernel.org with Robert's
series of fixes of related code (that's queued in the ACPI tree for the merge window)
and Dan Williams (from several years ago) + my additions that 'work' (lightly tested)
on qemu/arm64 with the generic port patches etc. 

I'll send out an RFC in a couple of weeks.  In meantime let me know if you
run into any problems or have suggestions to improve them.

Jonathan

p.s. Apparently my computer is in the future. (-28 minutes and counting!)
> 
> > 
> > Whilst it doesn't work yet (because of missing kernel support)
> > you'll need something that looks more like the generic ports test added in 
> > https://gitlab.com/jic23/qemu/-/commit/6589c527920ba22fe0923b60b58d33a8e9fd371e
> > 
> > Most importantly
> > -numa node,nodeid=2 -object acpi-generic-port,id=gp0,pci-bus-cxl.1,node=2
> > + the bits setting distances etc.  Note CXL memory does not provide SLIT like
> > data at the moment, so the test above won't help you identify if it is correctly
> > set up.  That's a gap in general in the kernel support. Whilst we'd love
> > it if everyone moved to hmat derived information we may need to provide
> > some fallback.
> > 
> > Jonathan
> >   
> 
> Many thanks
> Yuquan
> 


