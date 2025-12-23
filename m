Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53144E6B272
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 11:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY0xS-00024F-M9; Tue, 23 Dec 2025 06:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vY0xO-000240-BL
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:53:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vY0xM-0007vc-6J
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:53:38 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dbD0L6855zHnGj5;
 Tue, 23 Dec 2025 19:52:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id C1EFC40539;
 Tue, 23 Dec 2025 19:53:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 11:53:27 +0000
Date: Tue, 23 Dec 2025 11:53:25 +0000
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Davidlohr Bueso
 <dave@stgolabs.net>, <ira.weiny@intel.com>, <alucerop@amd.com>,
 <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251223115325.00000a36@huawei.com>
In-Reply-To: <20251217135930.00004616@huawei.com>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251216011211.anwnw25ot6n3euhq@offworld>
 <20251217135930.00004616@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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

On Wed, 17 Dec 2025 13:59:30 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Mon, 15 Dec 2025 17:12:11 -0800
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > ping? If there are no further issues, could this be picked up into
> > your jic23 tree?
> > 
> > Thanks,
> > Davidlohr
> >   
> Hi Davidlohr,
> 
> I'm just waiting on the 10.2 release before bringing my tree up to
> date and reposting the various series that I consider ready which
> didn't get merged in 10.2.
> 
> Then I'll figure out where in the tree to push these in.  I might
> do the leg work for that before the release, but given that should
> happen shortly I'll not push a tree out on gitlab until after that.
> 
> Jonathan
> 
Hi Davidlohr,

Seems the release has been tagged, so I've just rebased and pushed
out a draft tree as cxl-2025-12-23-draft
Draft because it is very very lightly tested so far.

On that I've merged in these patches with a few tweaks + added the
table test updates.  If you get a minute to take a look please do.

It's behind a couple of left over series from earlier cycles but my
intent is to post it for reviews prior to merge shortly.  That
may not include in the restrictions control qapi as I think that interface
may need more thought.  For now I've added a patch that just enables
BI always for CFMWSes.

Jonathan
 

