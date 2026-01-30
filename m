Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF59E6BF09
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnfA-0007kc-0W; Fri, 30 Jan 2026 07:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vlnf6-0007kP-Af
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:31:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vlnf2-0005SJ-Gz
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:31:44 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2b2J5BZBzHnH4l;
 Fri, 30 Jan 2026 20:30:32 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E12740565;
 Fri, 30 Jan 2026 20:31:24 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Jan
 2026 12:31:23 +0000
Date: Fri, 30 Jan 2026 12:31:22 +0000
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
 <krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <arpit.sysdev@gmail.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20260130123122.0000105e@huawei.com>
In-Reply-To: <20260130120350.n7ngrvla5mfkwllo@test-PowerEdge-R740xd>
References: <CGME20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4@epcas5p2.samsung.com>
 <20250916080736.1266083-1-arpit1.kumar@samsung.com>
 <20260127152350.00006447@huawei.com>
 <20260130120350.n7ngrvla5mfkwllo@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Fri, 30 Jan 2026 17:33:50 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 27/01/26 03:23PM, Jonathan Cameron wrote:
> >On Tue, 16 Sep 2025 13:37:34 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> This patch series refactor existing support for Identify Switch Device
> >> and Get Physical Port State by utilizing physical ports (USP & DSP)
> >> information stored during enumeration.  
> >
> >Hi Arpit.
> >
> >So I came back to this series to try and tweak it into being in a state
> >for upstreaming.  I made some fairly heavy changes (to push the
> >data down to the individual ports where to me it more logically sits)
> >but it became apparent to me during this that there is a fundamental
> >problem.  This stuff isn't static because it needs to reflect port
> >retraining and hotplug events etc.  If we want to store cached
> >data we are going to have to deal with updating it from a significant
> >number of different places. The perst one you have covered in patch 2
> >is an example but there are others.
> >
> >Now we definitely can do the generation in a neater way, but I've
> >come to the conclusion that caching it really doesn't make sense.
> >
> >Maybe we can do that for the USP, but definitely not DSPs.
> >
> >Given I did a bunch of refactoring I might as well share it even though
> >I'm currently thinking it might not be worth doing:
> >
> >From 40a8a36f22a6eb053c965231a698c8054d417049 Mon Sep 17 00:00:00 2001
> >From: Arpit Kumar <arpit1.kumar@samsung.com>
> >Date: Tue, 16 Sep 2025 13:37:35 +0530
> >Subject: [PATCH] hw/cxl: Refactored Identify Switch Device & Get Physical Port
> > State
> >
> >Store the physical port info for the USP on reset but refresh
> >it on demand for the DSPs as they are hotplug capable.
> >
> >Enables common data to be used for both of:
> >* Identify Switch Device (Opcode 5100h)
> >* Get Physical Port State (Opcode 5101h) physical switch FM-API command set.
> >
> >Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> >Co-developed: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> >---
> >Added a Co-dev as I have modified this a lot from Arpit's v4.
> >v5:
> >- Create a new header to avoid importing all of cxl_device.h into
> >the upstream port emulation.
> >- Move the call that caches state to the cxl_upstream_port reset
> >  to ensure downstream ports are in place before it is called.
> >  Also will make it available from whatever CCI.  If we ever support
> >  multiple VCS switches this will need to move an appropriate structure
> >  representing whole switch information. With only one USP that is
> >  a reasonable place to put full switch info.
> >- Downstream ports have more dynamic state (as devices can be
> >  hotplugged below them).  As such, only fill in the data at time
> >  of request.  
> 
> Hi Jonathan,
> Thanks for the update! The changes look good to me. I do concede that
> it requires more dynamic approach. This would help in future command 
> support like multiple VCS, MLD etc. I intially refrained from making changes
> to individual ports but it does logically fits there and would
> optimize the command support.

My current thinking is this major refactor is justified. There isn't
a strong reason not to do what the original code does and built it directly
in the command handler.

I'm preparing some cleanup of that though, such as using the defines
you added so it is more obvious what values are set.

The Physical Port Controls stuff can then drop in on top of that.

Once all that is in place we can reconsider if a refactor like the
one in the code below is worth doing.

We might also need a few more updates to keep track of things like flit
mode control patches.

Anyhow, I'll throw something together in the next day or two to share.

Jonathan




