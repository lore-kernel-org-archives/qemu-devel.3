Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB9EC1EA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxiv-0005dl-Sp; Thu, 05 Feb 2026 06:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnxit-0005dH-F2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:40:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnxil-0000iP-Fs
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:40:35 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6Fcd5BrWzJ46lp;
 Thu,  5 Feb 2026 19:39:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5144540570;
 Thu,  5 Feb 2026 19:40:20 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 11:40:19 +0000
Date: Thu, 5 Feb 2026 11:40:18 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <shiju.jose@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
 <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20260205114018.000027aa@huawei.com>
In-Reply-To: <20260205031548-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
 <20251006101304.000055f8@huawei.com>
 <20251006062628-mutt-send-email-mst@kernel.org>
 <20260102152834.00003869@huawei.com>
 <20260204113526.00001040@huawei.com>
 <20260205031548-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 5 Feb 2026 03:16:15 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 04, 2026 at 11:35:44AM +0000, Jonathan Cameron wrote:
> > On Fri, 2 Jan 2026 15:28:34 +0000
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >   
> > > On Mon, 6 Oct 2025 06:26:53 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:    
> > > > > On Wed, 17 Sep 2025 15:33:27 +0100
> > > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > > >       
> > > > > > These two features have been used in testing the related EDAC RAS
> > > > > > features drivers in Linux which are now upstream. Only minor tweaks
> > > > > > from the second part of:
> > > > > > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > > > > > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > > > > > 
> > > > > > I've split that series up as the two parts were only slightly connected.
> > > > > > However there is some churn if this is applied without the other part of Shiju's posted
> > > > > > series. That was sent a few minutes ago as:
> > > > > > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > > > > > 
> > > > > > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > > > > > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > > > > > 
> > > > > > Davidlohr Bueso (1):
> > > > > >   hw/cxl: Add support for Maintenance command and Post Package Repair
> > > > > >     (PPR)
> > > > > >       
> > > > > Hi Michael,
> > > > > 
> > > > > I see you have queued some stuff up on your gitlab tree.
> > > > > Just wanted to make sure these are on the radar for possible inclusion.
> > > > > No huge rush, but I'll queue some more series up on top of these
> > > > > shortly.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > Jonathan      
> > > > 
> > > > thanks for the reminder, will queue.    
> > > Hi Michael,
> > > 
> > > Looks like you didn't do another pull request for 10.2. If these can
> > > go upstream fairly early in 11.0 that would be very helpful as we have
> > > quite a few CXL series that I think are (nearly) ready.
> > > 
> > > I resent the events series but that was mainly because I'd forgotten you'd
> > > replied to this one and so might already have both queued. Sorry about that
> > > if you have them both already.  
> > 
> > This is the second series that is (I think) ready for merge.
> > Applies cleanly on mainline + 
> > [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> > 20260119111542.788389-1-Jonathan.Cameron@huawei.com  
> 
> question is if there will be v5 of that one, now there
> are review comments?
> 
Posted.  This applies cleanly on top of that (it only involved moving 2 lines within
functions that aren't touched by anything else we have pending.

So now, based on:
[PATCH qemu v5 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/qemu-devel/20260205112350.60681-1-Jonathan.Cameron@huawei.com/

> > > 
> > > Jonathan
> > >   
> > > >     
> > > > > > Shiju Jose (2):
> > > > > >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> > > > > >     attributes in cmd_features_set_feature()
> > > > > >   hw/cxl: Add emulation for memory sparing control feature
> > > > > > 
> > > > > >  include/hw/cxl/cxl_device.h | 145 +++++++++
> > > > > >  include/hw/cxl/cxl_events.h |  47 +++
> > > > > >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> > > > > >  hw/mem/cxl_type3.c          | 169 +++++++++++
> > > > > >  4 files changed, 915 insertions(+), 12 deletions(-)
> > > > > >       
> > > > 
> > > >     
> > > 
> > >   
> 
> 


