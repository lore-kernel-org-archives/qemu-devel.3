Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C485C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Wag-0003jo-M3; Thu, 02 May 2024 09:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s2Wae-0003iO-S3
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:35:13 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1s2Wac-000728-UP
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=rMUY+93PZ8AA50zQydFuICCr3tjRx5Z5hTfWdhnZ/XU=; b=rjfC2aauanow7VXV
 VFhYn0dLFQm5udzAqhl71msX0/jk3s1opRyu+ZmnSAgbwta+TmiBWsSH+NjgUgSKKG+TN/p4cqDva
 jBY0cdXJVWJmqbgiGp83Vbz6EU4nQIDbmeZROtkBXcwc0veMfu9qtrK/8UtgXkD8mAxPtCQinCFiI
 OnyC0tMS2eysmec3Rb/XCn+kgGuBGnC8kdh75LCoPLNUv3n8wOJVkvNbo4UU4OgDmM9DsqJ7wdYmV
 zkL5we3/X6eOHO9xY8TGws6eTnOkyIgDfYen1JrBFk/hEGKKpKnxcVJKnVCOoNFbzdJjpr55xElIL
 Wupc/8gHcK8CQsWaYA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1s2WaY-004GxU-2X;
 Thu, 02 May 2024 13:35:06 +0000
Date: Thu, 2 May 2024 13:35:06 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 devel@lists.libvirt.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/6] migration: Remove 'blk/-b' option from migrate
 commands
Message-ID: <ZjOWiu6kfxXcxhNB@gallifrey>
References: <20240430142737.29066-1-farosas@suse.de>
 <20240430142737.29066-4-farosas@suse.de>
 <87y18s77ma.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y18s77ma.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 13:34:18 up 120 days, 16:24,  2 users,  load average: 0.00, 0.00,
 0.00
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

* Markus Armbruster (armbru@redhat.com) wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > The block migration is considered obsolete and has been deprecated in
> > 8.2. Remove the migrate command option that enables it. This only
> > affects the QMP and HMP commands, the feature can still be accessed by
> > setting the migration 'block' capability. The whole feature will be
> > removed in a future patch.
> >
> > Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
> > option is deprecated.").
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> [...]
> 
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 7978302949..ebca2cdced 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -909,21 +909,17 @@ ERST
> >  
> >      {
> >          .name       = "migrate",
> > -        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
> > -        .params     = "[-d] [-b] [-r] uri",
> > +        .args_type  = "detach:-d,resume:-r,uri:s",
> > +        .params     = "[-d] [-r] uri",
> >          .help       = "migrate to URI (using -d to not wait for completion)"
> > -		      "\n\t\t\t -b for migration without shared storage with"
> > -		      " full copy of disk\n\t\t\t -r to resume a paused migration",
> > +		      "\n\t\t\t -r to resume a paused migration",
> >          .cmd        = hmp_migrate,
> >      },
> >  
> >  
> >  SRST
> > -``migrate [-d] [-b]`` *uri*
> > +``migrate [-d]`` *uri*
> >    Migrate to *uri* (using -d to not wait for completion).
> > -
> > -  ``-b``
> > -    for migration with full copy of disk
> >  ERST
> 
> Not this patch's fault, but here goes anyway: -r is undocumented here.

Probably one for Peter I guess.

Dave

> >  
> >      {
> 
> [...]
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

