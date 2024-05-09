Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165D4C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4zGI-0001rk-KM; Thu, 09 May 2024 04:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1s4zGD-0001rV-FW
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:36:17 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1s4zGA-0008GA-Nn
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:36:17 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3jBDxijxmuDC5AQ--.31648S2;
 Thu, 09 May 2024 16:36:01 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwBn15fbijxmX4IAAA--.1030S2;
 Thu, 09 May 2024 16:35:55 +0800 (CST)
Date: Thu, 9 May 2024 16:35:34 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <ZjyK1tI0TtbAKhmh@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508130252.00006367@Huawei.com>
X-CM-TRANSID: AQAAfwBn15fbijxmX4IAAA--.1030S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWY70+QC3QABs0
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrW8GFWkZF1ktw1xuF45Wrg_yoW8tw4fpF
 4jgFn3CrWkJr1xKryktw43Jr15Awn5Ca1DWFyfGw18Arn8Xr1DJw17Kw1agF9xC3yfAw42
 qFyDtr1qya1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: 20240508130252.00006367@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 08, 2024 at 01:02:52PM +0100, Jonathan Cameron wrote:
> 
> > [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
> > [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
> > [    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
> > [    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
> > [    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]
> > 
> > Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/
> > 
> > root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
> > [   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
> > [   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0
> 
> You need a load of kernel changes for NUMA nodes to work correctly with
> CXL memory on arm64 platforms.  I have some working code but need to tidy
> up a few corners that came up in an internal review earlier this week.
> 
> I have some travel coming up so may take a week or so to get those out.
> 
> Curiously that invalid memblk has nothing to do with the CXL fixed memory window
> Could you check if that is happening for you without the CXL patches?
> 

Thanks.

I have checked it, the problem is caused by my bios firmware file. I
change the bios file and the numa topology can works.

BTW, if it is convenient, could you help to post the link of the patches of CXL 
memory NUMA nodes on arm64 platforms?

> 
> Whilst it doesn't work yet (because of missing kernel support)
> you'll need something that looks more like the generic ports test added in 
> https://gitlab.com/jic23/qemu/-/commit/6589c527920ba22fe0923b60b58d33a8e9fd371e
> 
> Most importantly
> -numa node,nodeid=2 -object acpi-generic-port,id=gp0,pci-bus-cxl.1,node=2
> + the bits setting distances etc.  Note CXL memory does not provide SLIT like
> data at the moment, so the test above won't help you identify if it is correctly
> set up.  That's a gap in general in the kernel support. Whilst we'd love
> it if everyone moved to hmat derived information we may need to provide
> some fallback.
> 
> Jonathan
> 

Many thanks
Yuquan


