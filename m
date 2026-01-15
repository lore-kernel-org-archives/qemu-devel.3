Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE13D46634
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 23:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWJr-0004FC-Hc; Thu, 15 Jan 2026 17:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgWJl-00046K-Nk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:59:53 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgWJk-0000Tl-2f
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=04NgBVIA7fW0fvfeQBVxkrZNRIgoNO5GhDCQtUQnsxw=; b=rQWXtiDCd/2ig8Iz
 OHBoDq3R85nsorKjT0Eh3JwHc+2To/nBULVZjMw3WWmNsVKK26aOw6ClNa04tFyr7rTP0vjG8h8Z7
 qI8jF5vR3OX35ijZuWsbSSH6bjWiUUt4UEvYVJ5zrTsKClBvsRoCGYSYXDBofJcYjPW5uZNAqaJEm
 /46YlsFVK1wHseayw6YhQk/xovt7Vdz2jvET0+Fx5oQOnUppj1VI2ceaEHuVEHXo6MUEitHkSjh5x
 LxITDJ0vZl8kudy49tR43KnOYaY5PrlvhxGvHLGgX1QYvXuMLzR9L6oW/P2sLcctsFE1TCaNYV0an
 Sd3FUyBebKQHFAcVCA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vgWJf-0000000F6ru-0N7V;
 Thu, 15 Jan 2026 22:59:47 +0000
Date: Thu, 15 Jan 2026 22:59:47 +0000
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
Message-ID: <aWlxY9TWGT1aaMJz@gallifrey>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aWlso1w39cQnEh2t@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 22:48:45 up 80 days, 22:25,  2 users,  load average: 0.13, 0.04, 0.01
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
> On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > Nack.
> > 
> > This code has users, as explained in my other email:
> > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> 
> Please then rework that series and consider include the following (I
> believe I pointed out a long time ago somewhere..):
> 

> - Some form of justification of why multifd needs to be enabled for COLO.
>   For example, in your cluster deployment, using multifd can improve XXX
>   by YYY.  Please describe the use case and improvements.

That one is pretty easy; since COLO is regularly taking snapshots, the faster
the snapshoting the less overhead there is.

Lukas: Given COLO has a bunch of different features (i.e. the block
replication, the clever network comparison etc) do you know which ones
are used in the setups you are aware of?

I'd guess the tricky part of a test would be the network side; I'm
not too sure how you'd set that in a test.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

