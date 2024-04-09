Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF585CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruE3v-0004zF-Vk; Tue, 09 Apr 2024 12:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ruE3t-0004z4-HJ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:11:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ruE3o-0002S8-QD
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:11:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VDW683WQXz67DpL;
 Wed, 10 Apr 2024 00:06:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 88DDD1400CA;
 Wed, 10 Apr 2024 00:10:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 17:10:54 +0100
Date: Tue, 9 Apr 2024 17:10:53 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240409171053.00003f2d@Huawei.com>
In-Reply-To: <ZhA+U9b/IVq1V6LT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <Zg2c+YauNGqhFfTW@memverge.com>
 <20240405132719.00005859@Huawei.com>
 <ZhAh0Qmv2/VTe1wT@memverge.com>
 <20240405184452.00007986@Huawei.com>
 <ZhA+U9b/IVq1V6LT@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Fri, 5 Apr 2024 14:09:23 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Apr 05, 2024 at 06:44:52PM +0100, Jonathan Cameron wrote:
> > On Fri, 5 Apr 2024 12:07:45 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> >   
> > > 3. (C) Upon Device receiving Release Dynamic Capacity Request
> > >    a. check for a pending release request. If exists, error.  
> > 
> > Not sure that's necessary - can queue as long as the head
> > can track if the bits are in a pending release state.
> >   
> 
> Yeah probably it's fine to just queue the event and everything
> downstream just handles it.
> 
> > >    b. check that the bits in the MHD bitmap are actually set  
> > Good.  
> > > 
> > >    function: qmp_cxl_process_dynamic_capacity
> > > 
> > > 4. (D) Upon Device receiving Release Dynamic Capacity Response
> > >    a. clear the bits in the mhd bitmap
> > >    b. remove the pending request from the pending list
> > > 
> > >    function: cmd_dcd_release_dyn_cap
> > > 
> > > Something to note: The MHD bitmap is essentially the same as the
> > > existing DCD extent bitmap - except that it is located in a shared
> > > region of memory (mmap file, shm, whatever - pick one).  
> > 
> > I think you will ideally also have a per head one to track head access
> > to the things offered by the mhd.
> >   
> 
> Generally I try not to duplicate state, reduces consistency problems.
> 
> You do still need a shared memory state and a per-head state to capture
> per-head data, but the allocation bitmap is really device-global state.

There is a separation between 'offered' to a head and 'accepted on that head'.
Sure you could track all outstanding offers (if you let more than one be
outstanding) at the shared memory, just seemed easier to do that in the
per head element.


> 
> Either way you have a race condition when checking the bitmap during a
> memory access in the process of adding/releasing capacity - but that's
> more an indication of bad host behavior than it is of a bug in the
> implementatio of the emulated device. Probably we don't need to
> read-lock the bitmap (for access validation), only write-lock.
> 
> My preference, for what it's worth, would be to have a single bitmap
> and have it be anonymous-memory for Single-head and file-backed for
> for Multi-head.  I'll have to work out the locking mechanism.
I'll go with maybe until I see the code :)

J
> 
> ~Gregory


