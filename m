Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF67DEED628
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 16:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbi7j-0000LQ-P0; Fri, 02 Jan 2026 11:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vbi7e-0000In-FK
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:35:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vbi7b-0003YD-6J
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 11:35:30 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djTmf2TRdzJ467L;
 Sat,  3 Jan 2026 00:34:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 1430540086;
 Sat,  3 Jan 2026 00:35:22 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 16:35:21 +0000
Date: Fri, 2 Jan 2026 16:35:19 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <ira.weiny@intel.com>,
 <alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20260102163519.00005de4@huawei.com>
In-Reply-To: <20251230182330.upui2kkymnlylkh2@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251216011211.anwnw25ot6n3euhq@offworld>
 <20251217135930.00004616@huawei.com>
 <20251223115325.00000a36@huawei.com>
 <20251230182330.upui2kkymnlylkh2@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 30 Dec 2025 10:23:30 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 23 Dec 2025, Jonathan Cameron wrote:
> 
> >On Wed, 17 Dec 2025 13:59:30 +0000
> >Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >
> >Seems the release has been tagged, so I've just rebased and pushed
> >out a draft tree as cxl-2025-12-23-draft
> >Draft because it is very very lightly tested so far.  
> 
> Thank you for picking this up, 'draft' is fine with me :)
> However, I am not seeing this new branch in your tree(?)

Hi Davidlohr,

Happy new year.

Hmm. Could have sworn I pushed i out... Guess messed that up :(

Note there is a stray change in there for an unrelated tests
tree that I've tidied up in my local tree.

I'll push a new tree out next week but assuming this series
isn't otherwise messed up by me, I'd like to email this out as
something I think is ready to merge before I do that. 

If you spot anything bad with this I might shuffle things around
to put the physical port commands set ahead of it.

Jonathan



> 
> >
> >On that I've merged in these patches with a few tweaks + added the
> >table test updates.  If you get a minute to take a look please do.
> >
> >It's behind a couple of left over series from earlier cycles but my
> >intent is to post it for reviews prior to merge shortly.  That
> >may not include in the restrictions control qapi as I think that interface
> >may need more thought.  For now I've added a patch that just enables
> >BI always for CFMWSes.  
> 
> Makes sense.
> 
> Thanks,
> Davidlohr
> 


