Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B2CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 17:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsnce-0000md-TE; Fri, 05 Apr 2024 13:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsncd-0000mN-6k
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:45:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsncZ-0005Fe-7E
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:45:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB5SL2x8xz688jH;
 Sat,  6 Apr 2024 01:43:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B977B141548;
 Sat,  6 Apr 2024 01:44:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:44:53 +0100
Date: Fri, 5 Apr 2024 18:44:52 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240405184452.00007986@Huawei.com>
In-Reply-To: <ZhAh0Qmv2/VTe1wT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <Zg2c+YauNGqhFfTW@memverge.com>
 <20240405132719.00005859@Huawei.com>
 <ZhAh0Qmv2/VTe1wT@memverge.com>
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

On Fri, 5 Apr 2024 12:07:45 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Apr 05, 2024 at 01:27:19PM +0100, Jonathan Cameron wrote:
> > On Wed, 3 Apr 2024 14:16:25 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> > 
> > A few follow up comments.
> >   
> > >   
> > > > +        error_setg(errp, "no valid extents to send to process");
> > > > +        return;
> > > > +    }
> > > > +    
> > > 
> > > I'm looking at adding the MHD extensions around this point, e.g.:
> > > 
> > > /* If MHD cannot allocate requested extents, the cmd fails */
> > > if (type == DC_EVENT_ADD_CAPACITY && dcd->mhd_dcd_extents_allocate &&
> > >     num_extents != dcd->mhd_dcd_extents_allocate(...))
> > > 	return;
> > > 
> > > where mhd_dcd_extents_allocate checks the MHD block bitmap and tags
> > > for correctness (shared // no double-allocations, etc). On success,
> > > it garuantees proper ownership.
> > > 
> > > the release path would then be done in the release response path from
> > > the host, as opposed to the release event injection.  
> > 
> > I think it would be polite to check if the QMP command on release
> > for whether it is asking something plausible - makes for an easier
> > to user QMP interface.  I guess it's not strictly required though.
> > What races are there on release?  
> 
> The only real critical section, barring force-release beign supported,
> is when you clear the bits in the device allowing new requests to swipe
> those blocks. The appropriate place appears to be after the host kernel
> has responded to the release extent request.

Agreed you can't release till then, but you can check if it's going to 
work.  I think that's worth doing for ease of use reasons.

> 
> Also need to handle the case of multiple add-requests contending for the
> same region, but that's just an "oops failed to get all the bits, roll
> back" scenario - easy to handle.
> 
> Could go coarse-grained to just lock access to the bitmap entirely while
> operating on it, or be fancy and use atomics to go lockless. The latter
> code already exists in the Niagara model for reference.

I'm fine either way, though I'd just use a lock in initial version()

> 
> > We aren't support force release
> > for now, and for anything else, it's host specific (unlike add where
> > the extra rules kick in).   AS such I 'think' a check at command
> > time will be valid as long as the host hasn't done an async
> > release of capacity between that and the event record.  That
> > is a race we always have and the host should at most log it and
> > not release capacity twice.
> >  
> 
> Borrowing from the Ira's flow chart, here are the pieces I believe are
> needed to implement MHD support for DCD.
> 
> Orchestrator      FM         Device       Host Kernel    Host User
> 
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->A--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<--Accept--B<--Accept --|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |             |     ... snip ...       |              |
>     |             |           |            |              |
>     |-- Remove -->|--Release->C---Release->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<-Release--D<--Release--|              |
>     |             |  Extent   |   Extent   |              |
>     |             |           |            |              |
> 
> 1. (A) Upon Device Receiving Add Capacity Request
>    a. the device sanity checks the request against local mappings
>    b. the mhd hook is called to sanity check against global mappings
>    c. the mhd bitmap is updated, marking the capacity owned by that head
> 
>    function: qmp_cxl_process_dynamic_capacity
> 
> 2. (B) Upon Device Receiving Add Dynamic Capacity Response
>    a. accepted extents are compared to the original request
>    b. not accepted extents are cleared from the bitmap (local and MHD)
>    (Note: My understanding is that for now each request = 1 extent)

Yeah but that is a restriction I think we need to solve soon.

> 
>    function: cmd_dcd_add_dyn_cap_rsp
> 
> 3. (C) Upon Device receiving Release Dynamic Capacity Request
>    a. check for a pending release request. If exists, error.

Not sure that's necessary - can queue as long as the head
can track if the bits are in a pending release state.

>    b. check that the bits in the MHD bitmap are actually set
Good.
> 
>    function: qmp_cxl_process_dynamic_capacity
> 
> 4. (D) Upon Device receiving Release Dynamic Capacity Response
>    a. clear the bits in the mhd bitmap
>    b. remove the pending request from the pending list
> 
>    function: cmd_dcd_release_dyn_cap
> 
> Something to note: The MHD bitmap is essentially the same as the
> existing DCD extent bitmap - except that it is located in a shared
> region of memory (mmap file, shm, whatever - pick one).

I think you will ideally also have a per head one to track head access
to the things offered by the mhd.

> 
> Maybe it's worth abstracting out the bitmap twiddling to make that
> backable by a file mmap'd SHARED and use atomics to twiddle the bits?
> 
> That would be about 90% of the way to MH-DCD.

> 
> Maybe flock() could be used for coarse locking on the a shared bitmap
> in the short term?  This mitigates your concern of using shm.h as
> the coordination piece, though i'm not sure how portable flock() is.
Sounds nice, but you are wondering into that pesky userspace stuff
where I'd have to google a lot to understand :)

Jonathan

> 
> ~Gregory


