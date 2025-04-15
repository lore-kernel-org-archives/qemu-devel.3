Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E35C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 15:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4iM2-00023A-OL; Tue, 15 Apr 2025 11:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4iLn-00021F-KA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:37:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4iLd-0006rt-0q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:37:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcSpd57h8z6K9By;
 Tue, 15 Apr 2025 23:32:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 561B1140144;
 Tue, 15 Apr 2025 23:37:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 17:37:08 +0200
Date: Tue, 15 Apr 2025 16:37:07 +0100
To: Fan Ni <nifan.cxl@gmail.com>
CC: Gregory Price <gourry@gourry.net>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>, <dave@stgolabs.net>, 
 <nmtadam.samsung@gmail.com>, <anisa.su887@gmail.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <20250415163707.00005091@huawei.com>
In-Reply-To: <Z_0tRwHNXD8idZl-@debian>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
 <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F> <Z_0tRwHNXD8idZl-@debian>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 14 Apr 2025 08:44:07 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Tue, Apr 08, 2025 at 11:04:20AM -0400, Gregory Price wrote:
> > On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:  
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > The RFC provides a way for FM emulation in Qemu. The goal is to provide
> > > a context where we can have more FM emulation discussions and share solutions
> > > for a reasonable FM implementation in Qemu.
> > >  
> > ... snip ...
> > 
> > Took a browse of the series, and I like this method.  It seems simple
> > and straight-forward, avoids any complex networking between the vms and
> > gives us what we want.
> > 
> > I'll wait for Jonathan's commentary, but solid prototype (bn_n)b
> > 
> > ~Gregory  
> 
> Hi Jonathan,
> 
> Any feedback for this RFC?

Immediate question is whether anything similar is done in other use cases
in QEMU?   There are vaguely similar things that work via a socket but
I'm not sure the mix of a shared buffer and a qmp based doorbell is done
elsewhere.  There is use of shared memory for inter VM comms but that uses
a socket for it's doorbell / interrupt path, not qmp.
https://www.qemu.org/docs/master/specs/ivshmem-spec.html

So without looking in that much detail yet, I'm not yet convinced this is
preferable to a socket over which we can send the mctp packets.

In general we need to also solve how to upstream the mctp support in
qemu or this is adding yet more stuff to my cxl staging tree.

+CC Markus for QMP part.

https://lore.kernel.org/all/20250408043051.430340-1-nifan.cxl@gmail.com/
is start of thread.
https://lore.kernel.org/all/20250408043051.430340-3-nifan.cxl@gmail.com/
the qmp patch adding what is more or less a doorbell pinged by a device
on a different  QEMU instance.

Jonathan

> 
> Fan


