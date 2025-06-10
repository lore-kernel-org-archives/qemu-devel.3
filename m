Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DFC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26v-0001rO-RZ; Tue, 10 Jun 2025 12:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0Fz-0004aV-2S
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:47:19 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0Fv-0007bL-RP
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:47:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGs7W4mR7z6D92b;
 Tue, 10 Jun 2025 22:46:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 96D3014025A;
 Tue, 10 Jun 2025 22:47:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 16:47:10 +0200
Date: Tue, 10 Jun 2025 15:47:08 +0100
To: Anisa Su <anisa.su887@gmail.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
 <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Message-ID: <20250610154708.000074a6@huawei.com>
In-Reply-To: <aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250520143947.00000337@huawei.com>
 <20250530152655.00007132@huawei.com>
 <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
 <aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Jun 2025 00:28:42 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Mon, Jun 02, 2025 at 05:46:57PM +0000, Anisa Su wrote:
> > On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:  
> > > On Tue, 20 May 2025 14:39:47 +0100
> > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > >   
> > > > On Thu,  8 May 2025 00:00:56 +0000
> > > > anisa.su887@gmail.com wrote:
> > > >   
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > >   
> snip 
> > > Anisa,
> > > 
> > > Ideally I'd like to get the majority of this upstream once you post
> > > a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> > > These commands are equally valid via a switch-cci (and that path to the
> > > fm owned ld_mctpcci is already upstream).
> > > 
> > > If you could send it as two series. One of which sits on upstream and
> > > doesn't include the i2c_mctp part and the other of which is applied once
> > > that support is available in my tree that would be great. I'll squash
> > > the i2c_mctp part into the patch that adds support for that in the
> > > first place.
> > > 
> > > I'll deal with rebasing needed for other command introductions etc.
> > >   
> Hi Jonathan,
> 
> I applied the v3 patches (which are based on ToT master) on your latest
> published branch cxl-2025-03-20 + Fan's patch fixing dc extent tracking
> and then edited the first patch to add the i2c_mctp stuff and rebased
> the remaining patches on top.
> 
> Would it be easier for you if I send you those?
I'm lost in the description I'm afraid.  Maybe just have a go at it and we'll
see?

Jonathan

> 
> Let me know, thanks!
> Anisa
> 
> > > There are just enough open questions in this series that I haven't done
> > > this rework directly (though I did start doing it - hence the missing
> > > include note in one of the patches).
> > > 
> > > Thanks,
> > >   
> > Sounds good, will do :)
> > 
> > Thanks,
> > Anisa  
> > > Jonathan  
> > > > 
> > > > Jonathan
> > > > 
> > > > 
> > > >   
> snip
> > > > > Anisa Su (10):
> > > > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > > > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > > > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > > > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > > > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > > > >     DC event types
> > > > >   hw/cxl_type3: Add DC Region bitmap lock
> > > > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > > > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > > > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > > > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > > > 
> > > > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > > > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > > > >  hw/mem/cxl_type3.c           |  41 ++-
> > > > >  include/hw/cxl/cxl_device.h  |  24 ++
> > > > >  include/hw/cxl/cxl_events.h  |  15 +
> > > > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > > > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > > > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > > >     
> > > > 
> > > >   
> > >   


