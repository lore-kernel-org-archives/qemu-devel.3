Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9282CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Nx-0006XD-Qe; Tue, 12 Mar 2024 08:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rk1Nt-0006UI-VX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:37:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rk1Np-0007Gk-JC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:37:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TvCnw0HlWz6J9sP;
 Tue, 12 Mar 2024 20:37:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id CC34C1400C9;
 Tue, 12 Mar 2024 20:37:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 12 Mar
 2024 12:37:25 +0000
Date: Tue, 12 Mar 2024 12:37:23 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240312123723.0000420d@Huawei.com>
In-Reply-To: <ZevnKbzBOy_9sjeg@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com> <Zej5EuQXytgeWGfj@debian>
 <20240307124555.00001408@Huawei.com> <ZevnKbzBOy_9sjeg@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 20:35:53 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Thu, Mar 07, 2024 at 12:45:55PM +0000, Jonathan Cameron wrote:
> > ...
> >   
> > > > > +    list = records;
> > > > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > > > +    while (list) {
> > > > > +        CXLDCExtent *ent;
> > > > > +        bool skip_extent = false;
> > > > > +
> > > > > +        offset = list->value->offset;
> > > > > +        len = list->value->len;
> > > > > +
> > > > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > > > +        extents[i].len = len;
> > > > > +        memset(extents[i].tag, 0, 0x10);
> > > > > +        extents[i].shared_seq = 0;
> > > > > +
> > > > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > > > +            /*
> > > > > +             *  if the extent is still pending to be added to the host,    
> > > > 
> > > > Odd spacing.
> > > >     
> > > > > +             * remove it from the pending extent list, so later when the add
> > > > > +             * response for the extent arrives, the device can reject the
> > > > > +             * extent as it is not in the pending list.
> > > > > +             */
> > > > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > > > +                        &extents[i]);
> > > > > +            if (ent) {
> > > > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > > > +                g_free(ent);
> > > > > +                skip_extent = true;
> > > > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > > > +                /* If the exact extent is not in the accepted list, skip */
> > > > > +                skip_extent = true;
> > > > > +            }    
> > > > I think we need to reject case of some extents skipped and others not.
> > > > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > > > to do two passes so we know this has happened early (or perhaps this is a later
> > > > patch in which case a todo here would help).    
> > > 
> > > Skip here does not mean the extent is invalid, it just means the extent
> > > is still pending to add, so remove them from pending list would be
> > > enough to reject the extent, no need to release further. That is based
> > > on your feedback on v4.  
> > 
> > Ah. I'd missunderstood.  
> 
> Hi Jonathan,
> 
> I think we should not allow to release extents that are still pending to
> add. 
> If we allow it, there is a case that will not work.
> Let's see the following case (time order):
> 1. Send request to add extent A to host; (A --> pending list)
> 2. Send request to release A from the host; (Delete A from pending list,
> hoping the following add response for A will fail as there is not a matched
> extent in the pending list).

Definitely not allow the host to release something it hasn't accepted.
Should allow QMP to release such entrees though (and same for fmapi when
we get there). Any such requested from host should be treated as whatever
it says to do if you release an extent that you don't have.

> 3. Host send response to the device for the add request, however, for
> some reason, it does not accept any of it, so updated list is empty,
> spec allows it. Based on the spec, we need to drop the extent at the
> head of the event log. Now we have problem. Since extent A is already
> dropped from the list, we either cannot drop as the list is empty, which
> is not the worst. If we have more extents in the list, we may drop the
> one following A, which is for another request. If this happens, all the
> following extents will be acked incorrectly as the order has been
> shifted.
>  
> Does the above reasoning make sense to you?
Absolutely.  I got confused here on who was doing release.
Host definitely can't release stuff it hasn't successfully accepted.

Jonathan

> 
> Fan
> 
> >   
> > > 
> > > The loop here is only to collect the extents to sent to the event log. 
> > > But as you said, we need one pass before updating pending list.
> > > Actually if we do not allow the above case where extents to release is
> > > still in the pending to add list, we can just return here with error, no
> > > extra dry run needed. 
> > > 
> > > What do you think?  
> > 
> > I think we need a way to back out extents from the pending to add list
> > so we can create the race where they are offered to the OS and it takes
> > forever to accept and by the time it does we've removed them.
> >   
> > >   
> > > >     
> > > > > +        
> > > > > +
> > > > > +        /* No duplicate or overlapped extents are allowed */
> > > > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > > > +                              len / block_size)) {
> > > > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > > > +            return;
> > > > > +        }
> > > > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > > > +
> > > > > +        list = list->next;
> > > > > +        if (!skip_extent) {
> > > > > +            i++;    
> > > > Problem is if we skip one in the middle the records will be wrong below.    
> > > 
> > > Why? Only extents passed the check will be stored in variable extents and
> > > processed further and i be updated. 
> > > For skipped ones, since i is not updated, they will be
> > > overwritten by following valid ones.  
> > Ah. I'd missed the fact you store into the extent without a check on validity
> > but only move the index on if they were valid. Then rely on not passing a trailing
> > entry at the end.
> > If would be more readable I think if local variables were used for the parameters
> > until we've decided not to skip and the this ended with
> > 
> >         if (!skip_extent) {
> >             extents[i] = (DCXLDCExtentRaw) {
> >                 .start_dpa = ...
> > 	        ...
> >             };
> >             i++
> >         }
> > We have local len already so probably just need
> > uint64_t start_dpa = offset + dcd->dc.regions[rid].base;
> > 
> > Also maybe skip_extent_evlog or something like that to explain we are only
> > skipping that part. 
> > Helps people like me who read it completely wrong!
> > 
> > Jonathan
> > 
> >  
> >   


