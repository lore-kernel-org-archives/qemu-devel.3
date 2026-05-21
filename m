Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A133CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 07:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyCA-0003iv-Ta; Thu, 21 May 2026 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPyC8-0003ij-DK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPyC3-00028r-0I
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779349903;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSAaqI5GOBvTwddHCBU2ycMCV3ceGGhVa/3VhgfQYBo=;
 b=CuT4m+g2VXMSRs2NInpOYvIM6JFtUGWFoRgEPa+hcHMR5cKR3jgGL4qN253ZB3tu4vVopF
 xLiJ5yVAAgN9KNhh2TQ5i2dp8OeZT7r8PEzxRMxpHK3so98R+YGkyrHu2g8l1IWVQd+cQA
 y9AH7Sy+WSjSQAgZj2Ef5+J5iPaMu5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-6gitc4obMiWKXJZOiHFj9Q-1; Thu,
 21 May 2026 03:51:41 -0400
X-MC-Unique: 6gitc4obMiWKXJZOiHFj9Q-1
X-Mimecast-MFC-AGG-ID: 6gitc4obMiWKXJZOiHFj9Q_1779349900
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E190A1956095; Thu, 21 May 2026 07:51:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D315E30001BE; Thu, 21 May 2026 07:51:37 +0000 (UTC)
Date: Thu, 21 May 2026 08:51:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] mailmap: Remove PhilMD redirect entries
Message-ID: <ag65hXzDXFvpRBsy@redhat.com>
References: <20260520195206.40679-1-philmd@linaro.org>
 <CAAjaMXZMKbah6TrvSA2qy7ofp-eVyvuVxyOLo=-T+VaKcJc7Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXZMKbah6TrvSA2qy7ofp-eVyvuVxyOLo=-T+VaKcJc7Hw@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 09:20:49AM +0300, Manos Pitsidianakis wrote:
> On Wed, May 20, 2026 at 10:52 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> >
> > Our ./scripts/get_maintainer.pl uses git .mailmap as a fallback:
> >
> >   $ ./scripts/get_maintainer.pl -h
> >   usage: ./scripts/get_maintainer.pl [options] patchfile
> >          ./scripts/get_maintainer.pl [options] -f file|directory
> >
> >     --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
> >     --git-since => git history to use (default: 1-year-ago)
> >     --mailmap => use .mailmap file (default: 1)
> >     ...
> >
> >   Default options:
> >     [--email --nogit --git-fallback --m --r --n --l --multiline
> >      --pattern-depth=0 --remove-duplicates --rolestats]
> >
> > (see the '--git-fallback' used as default option).
> >
> > Per gitmailmap(5) man page:
> >
> >   ... the file .mailmap [...] is used to map author and
> >   committer names and email addresses to canonical real
> >   names and email addresses.
> >
> > I added my entries in the "replace old addresses by a more recent
> > one" section for this script use case, but we have been doing a
> > good cleanup at having all files covered in MAINTAINERS, so with
> > retrospective these entries aren't needed anymore (besides, using
> > them retroactively credits all my contributions to the latest
> > employer).
> >
> 
> 
> Hey Philippe,
> 
> As I posted here
> https://lore.kernel.org/qemu-devel/3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org/T/#t
> 
> > People who wish to use git log for employer attribution reasons must
> > use --no-mailmap.
> 
> mailmap is for updating names/emails, not attribution. I do not think
> your patch is necessary.

Attribution of committers to employers is something that is very
much a loose heuristic that only works for relatively recent commits.

Beyond .mailmap, the data we have in contrib/gitdm only ever reflects
our current point-in-time understanding of employers. For cases where
we map personal email addresses to employers, we are not keeping a
historical record as people change jobs, so all historical commits
from a personal email address get associated with the newest employer.

IOW if you want to attribute accurately, you need to look at the state
of contrib/gitdm & .mailmap, as they were when the commit you want to
attribute was merged.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


