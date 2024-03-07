Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02717C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riD8n-0004zG-Ca; Thu, 07 Mar 2024 07:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riD8c-0004u6-Id
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:46:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riD8V-0002MD-4p
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:46:17 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr87p5JjBz6K9C7;
 Thu,  7 Mar 2024 20:41:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 147B3140736;
 Thu,  7 Mar 2024 20:45:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:45:56 +0000
Date: Thu, 7 Mar 2024 12:45:55 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240307124555.00001408@Huawei.com>
In-Reply-To: <Zej5EuQXytgeWGfj@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com> <Zej5EuQXytgeWGfj@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

...

> > > +    list = records;
> > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > +    while (list) {
> > > +        CXLDCExtent *ent;
> > > +        bool skip_extent = false;
> > > +
> > > +        offset = list->value->offset;
> > > +        len = list->value->len;
> > > +
> > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > +        extents[i].len = len;
> > > +        memset(extents[i].tag, 0, 0x10);
> > > +        extents[i].shared_seq = 0;
> > > +
> > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > +            /*
> > > +             *  if the extent is still pending to be added to the host,  
> > 
> > Odd spacing.
> >   
> > > +             * remove it from the pending extent list, so later when the add
> > > +             * response for the extent arrives, the device can reject the
> > > +             * extent as it is not in the pending list.
> > > +             */
> > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > +                        &extents[i]);
> > > +            if (ent) {
> > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > +                g_free(ent);
> > > +                skip_extent = true;
> > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > +                /* If the exact extent is not in the accepted list, skip */
> > > +                skip_extent = true;
> > > +            }  
> > I think we need to reject case of some extents skipped and others not.
> > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > to do two passes so we know this has happened early (or perhaps this is a later
> > patch in which case a todo here would help).  
> 
> Skip here does not mean the extent is invalid, it just means the extent
> is still pending to add, so remove them from pending list would be
> enough to reject the extent, no need to release further. That is based
> on your feedback on v4.

Ah. I'd missunderstood.

> 
> The loop here is only to collect the extents to sent to the event log. 
> But as you said, we need one pass before updating pending list.
> Actually if we do not allow the above case where extents to release is
> still in the pending to add list, we can just return here with error, no
> extra dry run needed. 
> 
> What do you think?

I think we need a way to back out extents from the pending to add list
so we can create the race where they are offered to the OS and it takes
forever to accept and by the time it does we've removed them.

> 
> >   
> > > +        
> > > +
> > > +        /* No duplicate or overlapped extents are allowed */
> > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > +                              len / block_size)) {
> > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > +            return;
> > > +        }
> > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > +
> > > +        list = list->next;
> > > +        if (!skip_extent) {
> > > +            i++;  
> > Problem is if we skip one in the middle the records will be wrong below.  
> 
> Why? Only extents passed the check will be stored in variable extents and
> processed further and i be updated. 
> For skipped ones, since i is not updated, they will be
> overwritten by following valid ones.
Ah. I'd missed the fact you store into the extent without a check on validity
but only move the index on if they were valid. Then rely on not passing a trailing
entry at the end.
If would be more readable I think if local variables were used for the parameters
until we've decided not to skip and the this ended with

        if (!skip_extent) {
            extents[i] = (DCXLDCExtentRaw) {
                .start_dpa = ...
	        ...
            };
            i++
        }
We have local len already so probably just need
uint64_t start_dpa = offset + dcd->dc.regions[rid].base;

Also maybe skip_extent_evlog or something like that to explain we are only
skipping that part. 
Helps people like me who read it completely wrong!

Jonathan

 


