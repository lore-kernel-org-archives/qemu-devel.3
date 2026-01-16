Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB7BD47CAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgXqc-0001F5-Uv; Thu, 15 Jan 2026 19:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgXqa-00018z-QA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:37:53 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgXqY-0006p6-UH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Hk5vPVHTbkZrNeRChoZf5W5jJgaWffuO+o8XC5KTg+k=; b=kCZa5zQfW4g9KEiE
 5JmSr2l8GXPevQQY4LPtzpPfGLwF5yZFksqB9OTDgfUukyA1HlwOEx61ewy1+McUldmxV6vOFo3R2
 JopWeDbvBzYlAeSR/XMbS7Sf8VIkyLsFfEaP082NZGVJz4FcSRq1ooXy1WbL5TOvm57mqHZTL3nNk
 1IkNP3quDEqwUrQSqNtQmwBVb/8Jd4kjFwph8vZOHikpF1PYgUruse/k3DrnD5dJsoC8AYWEMwZYQ
 Gfv56KKsmrlbiomLR+9uiGm5HyqXjUqIBDBaj3c5/glvNj+/YccJyjjXe84f+tg8pZialmFneMNv/
 al5DEUJJiGKyrOXEjA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vgXqU-0000000F7q9-3A5j;
 Fri, 16 Jan 2026 00:37:46 +0000
Date: Fri, 16 Jan 2026 00:37:46 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWmIWrXjxLsqwLd6@gallifrey>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aWl6ixQpHaMJhV_E@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:01:42 up 80 days, 23:37,  2 users,  load average: 0.13, 0.06, 0.02
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > > Nack.
> > > > 
> > > > This code has users, as explained in my other email:
> > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > > 
> > > Please then rework that series and consider include the following (I
> > > believe I pointed out a long time ago somewhere..):
> > > 
> > 
> > > - Some form of justification of why multifd needs to be enabled for COLO.
> > >   For example, in your cluster deployment, using multifd can improve XXX
> > >   by YYY.  Please describe the use case and improvements.
> > 
> > That one is pretty easy; since COLO is regularly taking snapshots, the faster
> > the snapshoting the less overhead there is.
> 
> Thanks for chiming in, Dave.  I can explain why I want to request for some
> numbers.
> 
> Firstly, numbers normally proves it's used in a real system.  It's at least
> being used and seriously tested.

Fair.

> Secondly, per my very limited understanding to COLO... the two VMs in most
> cases should be in-sync state already when both sides generate the same
> network packets.

(It's about a decade since I did any serious Colo, so I'll try and remember)

> Another sync (where multifd can start to take effect) is only needed when
> there're packets misalignments, but IIUC it should be rare.  I don't know
> how rare it is, it would be good if Lukas could introduce some of those
> numbers in his deployment to help us understand COLO better if we'll need
> to keep it.

In reality misalignments are actually pretty common - although it's
very workload dependent.  Any randomness in the order of execution in a multi-threaded
guest for example, or when a timer arrives etc can change the packet generation.
The migration time then becomes a latency issue before you can
transmit the mismatched packet once it's detected.

I think You still need to send a regular stream of snapshots even without
having *yet* received a packet difference.  Now, I'm trying to remember the
reasoning; for a start if you leave the difference too long the migration
snapshot gets larger (which I think needs to be stored on RAM on the dest?)
and also you increase the chances of them getting a packet difference from
randomness increases.
I seem to remember there were clever schemes to get the optimal snapshot
scheme.

> IIUC, the critical path of COLO shouldn't be migration on its own?  It
> should be when heartbeat gets lost; that normally should happen when two
> VMs are in sync.  In this path, I don't see how multifd helps..  because
> there's no migration happening, only the src recording what has changed.
> Hence I think some number with description of the measurements may help us
> understand how important multifd is to COLO.

There's more than one critical path:
  a) Time to recovery when one host fails
  b) Overhead when both hosts are happy.

> Supporting multifd will cause new COLO functions to inject into core
> migration code paths (even if not much..). I want to make sure such (new)
> complexity is justified. I also want to avoid introducing a feature only
> because "we have XXX, then let's support XXX in COLO too, maybe some day
> it'll be useful".

I can't remember where the COLO code got into the main migration paths;
is that the reception side storing the received differences somewhere else?

> After these days, I found removing code is sometimes harder than writting
> new..

Haha yes.

Dave

> Thanks,
> 
> > 
> > Lukas: Given COLO has a bunch of different features (i.e. the block
> > replication, the clever network comparison etc) do you know which ones
> > are used in the setups you are aware of?
> > 
> > I'd guess the tricky part of a test would be the network side; I'm
> > not too sure how you'd set that in a test.
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

