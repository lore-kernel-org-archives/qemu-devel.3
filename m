Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D95CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPXL-0003mA-O3; Tue, 02 Dec 2025 07:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQPXE-0003fJ-Mc; Tue, 02 Dec 2025 07:31:12 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vQPX5-0003y5-Cg; Tue, 02 Dec 2025 07:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=eY93VA5WO1sOJnUzA2osW+b10UqCH17GYRpcQ5jA0Ds=; b=JtxEceRTUfDXAC4a
 d+9e2gOT1jevt1NM6MiLnnjkkVHhgsIvGbsYC32B2ix1LYYfEEPV8xN2/aBs3Vw1RpGfquTT3Jzd7
 EgcXOb8xDgNz1ety/8k8swUidGt+b8PzGTi+2cjFmIfmX88LjCJoN2zLwWbRYmepJIpkjZBs7tpKu
 l31PuDnLtQCnPvLnXnuMp0urc8cmGHmbvvisde0REhLpL8XFvjombA5+o5Lf7PVleZ2PdivIpBtCF
 vJoBkmGLiriTECnAkl4xfMTTAScP0nzKu38Pa+wxq47/n/ara5Fg7qVaq0Y6al7caA/MZzYGIzmD8
 WvroKVkGRDlA63oFwA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vQPWy-00000007d5a-2v0z;
 Tue, 02 Dec 2025 12:30:56 +0000
Date: Tue, 2 Dec 2025 12:30:56 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 jak@jak-linux.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu-options.hx: Replace deprecated -M example
Message-ID: <aS7cACznSygGM2Xc@gallifrey>
References: <20251202005740.299524-1-dave@treblig.org>
 <95dd7914-8e58-42e7-9988-cd7822f17bca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <95dd7914-8e58-42e7-9988-cd7822f17bca@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 12:28:13 up 36 days, 12:04,  2 users,  load average: 0.07, 0.02, 0.00
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Thomas Huth (thuth@redhat.com) wrote:
> On 02/12/2025 01.57, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > The -M option was deprecated by -machine in 2011 by 80f52a669
> > and isn't actually documented in the manpage, but is still used in
> > one of the examples.  Replace it by -machine.
> > -M still gets used all over the place in other docs, and I'm
> > not sure I realised it was deprecated until Julian pointed out it
> > wasn't actually documented.
> 
> -M is not mentioned in docs/about/deprecated.rst, so no, it's not officially
> deprecated. And I think it's a nice short hand feature for an option that is
> used very often, so I also don't think that we should ever remove it. Thus I
> think it would be better to simply add it back to qemu-options.hx instead.

Fair enough; I wasn't too sure which way this would go - I'm pretty
sure I'd always used -M, but there again I saw libvirt used -machine
now, and I'd frequently confused -m and -M so it did make some sense
to move away from it.

I'll cut another patch adding -M back.

Dave

>  Thomas
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

