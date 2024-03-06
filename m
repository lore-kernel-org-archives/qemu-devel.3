Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB0AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsjQ-0004Iz-QR; Wed, 06 Mar 2024 09:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhsj4-0004EK-Mk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:58:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhsj0-0008GX-Eb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:58:34 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqb691fKtz6K62Z;
 Wed,  6 Mar 2024 22:53:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 79DFD140DDC;
 Wed,  6 Mar 2024 22:58:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 14:58:23 +0000
Date: Wed, 6 Mar 2024 14:58:23 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240306145823.000028ee@Huawei.com>
In-Reply-To: <ZeFR_Z9nInhyf-W_@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
 <20240226180417.00004dc4@Huawei.com> <Zd00YhCejwN6NuU6@debian>
 <20240227103909.00002a92@Huawei.com> <ZeFR_Z9nInhyf-W_@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

> > > I cannot find anything specific to this in the specification either.
> > > Since we have already detected the case where the extent range across
> > > multiple regions, the only case we need to capture here is one/multiple
> > > portions of an extents getting released and causing extent overflow.
> > > I think we can handle it after we introduce the bitmaps (PATCH 10) which
> > > indicates DPA ranges mapped by valid extents in the device.
> > > 
> > > With that, The release workflow would be
> > > 
> > > 1) detecting malformed extent lists; if passed
> > > 2) do cxl_detect_extent_overflow {
> > >     delta = 0;
> > >     make a copy of the bitmap as bitmap_copy;
> > >     for each extent in the updated_extent_list; do
> > >         if (extent range not fully set in the bitmap_copy)
> > >             return error;
> > >         else {
> > >             if gap at the front based on the bitmap_copy:
> > >                 delta += 1;
> > >             if gap at the end based on the bitmap_copy:
> > >                 delta += 1;
> > >             delta -= 1;
> > >             // NOTE: current_extent_count will not be updated in the
> > >             // loop since delta will track the whole loop
> > >             if (delta + current_extent_count > max_extent_count)
> > >                 return resource exhausted;
> > >             update bitmap_copy to clear the range covered by the extent
> > >             under consideration;
> > >         }
> > >     done
> > > 
> > > }; if pass
> > > 3. do real release: in the pass, we will not need to detect extent
> > > errors;
> > > 
> > > Does the above solution sound reasonable? If so, do we want to go this
> > > way? do we need to introduce the bitmap earlier in the series?  
> > 
> > Yes, something along these lines should work nicely.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> I updated the code based on your feedback and now we can process extent
> release request more flexible.

Excellent!

> We can now support superset release (actually it can do even more,
> as long as the DPA range is coverd by accepted extents, we can release).
> 
> I have run following tests and the code works as expected,
> 1. Add multiple extents, and removing them one by one, passed;
> 2. Superset release: add multiple extents with continuous DPA ranges, and
>    remove all of them with a single release request with an extent covering the
>    whole DPA range, passed;
> 3. Partial extent release: add a large extent and release only part of it,
>    passed;
> 4. Partial+superset release: add multiple extents,and release it with some
>    leftover with one request with an extent. For example, add extents [0-128M]
>    and [128M-256M], release [64M-256M]. Passed;
> 5. Release extent not aligned to block size, failed as expected;
> 6. Extents have overlaps, fail the request as expected;
> 7. Extent has uncovered DPA range, skip the extent as expected;
> 
> The only limitation is that for superset release case, if we find
> part of its DPA range is still pending to add, while the other is
> accepted, we reject it through QMP interface.

I think that is a reasonable limitation as we don't expect people
to do that crazy on QMP side.   Maybe long term we'll want a
'release all' type command (I'm thinking virtualized device usecases)
but we can deal with that later.

> 
> The latest code is https://github.com/moking/qemu/tree/dcd-v5.
> 
> The main changes are in the last three commits. 
> Btw, in the last commit, I introduce new QMP interfaces to print out
> accepted and pending-to-add list in the device to a file "/tmp/qmp.txt",
> do we want it? If yes, I can polish it a little bit, otherwise I will
> keep it for my own test purpose.
Ah. I missed this mail and replied directly.  That needs a rethink
as the thread has concluded I think. I'll carry it on my tree, but not
look to upstream it.
> 
> I will test more and send out v5 if the above looks reasonable to you.
> 
Sorry for slow reply - I'm a bit behind with mailing lists.
Great you sent it out in the meantime.

Jonathan

