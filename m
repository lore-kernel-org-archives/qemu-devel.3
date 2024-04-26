Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F1CC19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0O0L-00035g-Ql; Fri, 26 Apr 2024 12:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s0O0G-00031M-Bg
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:00:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s0O0D-0000ur-Rw
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:00:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQy7F0ds9z6D8rB;
 Fri, 26 Apr 2024 23:58:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9AF8D140516;
 Sat, 27 Apr 2024 00:00:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:00:42 +0100
Date: Fri, 26 Apr 2024 17:00:41 +0100
To: Ira Weiny <ira.weiny@intel.com>
CC: Markus Armbruster <armbru@redhat.com>, fan <nifan.cxl@gmail.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240426170041.000055fd@Huawei.com>
In-Reply-To: <662a934b2757c_fa7d3294fc@iweiny-mobl.notmuch>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org> <ZilDz3X5hmda5oNr@debian>
 <87plue9en1.fsf@pond.sub.org>
 <662a934b2757c_fa7d3294fc@iweiny-mobl.notmuch>
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

On Thu, 25 Apr 2024 10:30:51 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Markus Armbruster wrote:
> > fan <nifan.cxl@gmail.com> writes:
> >   
> > > On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:  
> > >> nifan.cxl@gmail.com writes:
> > >>   
> > >> > From: Fan Ni <fan.ni@samsung.com>
> > >> >
> > >> > Since fabric manager emulation is not supported yet, the change implements
> > >> > the functions to add/release dynamic capacity extents as QMP interfaces.  
> > >> 
> > >> Will fabric manager emulation obsolete these commands?  
> > >
> > > If in the future, fabric manager emulation supports commands for dynamic capacity
> > > extent add/release, it is possible we do not need the commands.
> > > But it seems not to happen soon, we need the qmp commands for the
> > > end-to-end test with kernel DCD support.  
> > 
> > I asked because if the commands are temporary testing aids, they should
> > probably be declared unstable.  Even if they are permanent testing aids,
> > unstable might be the right choice.  This is for the CXL maintainers to
> > decide.
> > 
> > What does "unstable" mean?  docs/devel/qapi-code-gen.rst: "Interfaces so
> > marked may be withdrawn or changed incompatibly in future releases."
> > 
> > Management applications need stable interfaces.  Libvirt developers
> > generally refuse to touch anything in QMP that's declared unstable.
> > 
> > Human users and their ad hoc scripts appreciate stability, but they
> > don't need it nearly as much as management applications do.
> > 
> > A stability promise increases the maintenance burden.  By how much is
> > unclear.  In other words, by promising stability, the maintainers take
> > on risk.  Are the CXL maintainers happy to accept the risk here?
> >   
> 
> Ah...  All great points.
> 
> Outside of CXL development I don't think there is a strong need for them
> to be stable.  I would like to see more than ad hoc scripts use them
> though.  So I don't think they are going to be changed without some
> thought though.

These align closely with the data that comes from the fabric management
API in the CXL spec.  So I don't see a big maintenance burden problem
in having these as stable interfaces.  Whilst they aren't doing quite
the same job as the FM-API (which will be emulated such that it is
visible to the guest as that aids some other types of testing) that
interface defines the limits on what we can tell the device to do.

So yes, risk for these is minimal and I'm happy to accept that.
It'll be a while before we need libvirt to use them but I do
expect to see that happen. (subject to some guessing on a future
virtualization stack!)

Jonathan



> 
> Ira
> 
> [snip]


