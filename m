Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZsX-0001FC-0t; Wed, 05 Nov 2025 04:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGZsU-0001F0-NU
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:32:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vGZsR-000633-Pe
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:32:30 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1g8M0ZlLzHnGcR;
 Wed,  5 Nov 2025 17:32:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 276FD140278;
 Wed,  5 Nov 2025 17:32:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:32:23 +0000
Date: Wed, 5 Nov 2025 09:32:21 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
Message-ID: <20251105093221.00007b80@huawei.com>
In-Reply-To: <CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
 <CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 4 Nov 2025 16:17:07 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 28 Feb 2023 at 11:39, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
> >
> > Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> > Add him as a designated reviewer.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > --
> > Thanks to Fan for stepping up after I requested help following Ben
> > stepping down as co-maintainer. Fan base been active in testing
> > and review recently so great to have Fan on board.
> >
> > Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
> >
> > Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7ea56c6ccc..838e1a91a4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2633,6 +2633,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
> >
> >  Compute Express Link
> >  M: Jonathan Cameron <jonathan.cameron@huawei.com>
> > +R: Fan Ni <fan.ni@samsung.com>
> >  S: Supported
> >  F: hw/cxl/
> >  F: hw/mem/cxl_type3.c  
> 
> Hi; I noticed today that Fan's samsung email is now bouncing
> with "550 5.1.1 Recipient address rejected: User unknown".
> Do we have a altenate email for him, or should we remove
> his entry from the QEMU MAINTAINERS file; and if so is there
> anybody else we should add as a reviewer for CXL ?

My bad. I've had this on my todo list since Fan moved.

nifan.cxl@gmail.com
is the address Fan asked me to use.

I do plan to add a second reviewer (more welcome!) as Fan's time is
limited (not the day job any more), but wanted to let them ramp up
and review informally for a bit first.

Thanks,

Jonathan

> 
> thanks
> -- PMM


