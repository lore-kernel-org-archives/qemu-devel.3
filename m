Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46CFD3C90B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 12:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t289q-0000VE-19; Sat, 19 Oct 2024 08:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1t289n-0000V2-UV
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 08:02:07 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1t289l-0004Tk-Qg
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 08:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=15+E2/4D8TTX44zPU0C9/hTB26XdYnmlS72gleti4Xs=; b=fqvyTZ4kbIFSTf2c
 fB0dWUMRdvt8SXWqaw86CxJECXz60qgFLoJNxM633v5WHdw+a0wVs0N5N8ql1+3WOmClL4ggh33cP
 Q9ac8IYpWj4bBTPDfvBGKQUdkcEG8Z5jxmfWutK/sKZzop9lDq/qF5WQ1c25Mq2r36rN7CC9Q9qoB
 hqJBgDx/FGDtqZL5XUTFFnTTZtLRmse8vqjjnPlNmDbTVVZyileTdEq9lEfjfaF1fYUiiMvJemzFy
 MPr4mmywrKWtoxOJ1iWF7hg+i6KaMqVCsmPKOzpLfpcHTz6g1iQoVAo/yW8QVkqimWrSFHixejz4W
 xaYt5310qI3Eouhiag==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1t289h-00CHcM-1a;
 Sat, 19 Oct 2024 12:02:01 +0000
Date: Sat, 19 Oct 2024 12:02:01 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] sockets: Remove deadcode
Message-ID: <ZxOfuby9HY_nHqoB@gallifrey>
References: <20240918232633.463861-1-dave@treblig.org>
 <ZuwVLemC3hVirWGZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuwVLemC3hVirWGZ@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:01:01 up 163 days, 23:15,  1 user,  load average: 0.05, 0.08, 0.03
User-Agent: Mutt/2.2.12 (2023-09-09)
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Sep 19, 2024 at 12:26:33AM +0100, dave@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > 
> > socket_remote_address hasn't been used since it was added in
> >   17c55decec ("sockets: add helpers for creating SocketAddress from a socket")
> > 
> > inet_connect hasn't been used since 2017's
> >   8ecc2f9eab ("sheepdog: Use SocketAddress and socket_connect()")
> 
> Excellent ! The more of sockets.h we can remove the better.
> 
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  include/qemu/sockets.h | 16 ----------------
> >  util/qemu-sockets.c    | 35 -----------------------------------
> >  2 files changed, 51 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> and queued.

Hi Dan,
  Just checking, I noticed this one and the crypto patch haven't made
it to master yet.

Dave

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

