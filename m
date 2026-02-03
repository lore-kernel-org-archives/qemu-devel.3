Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A9DE8306B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnD6V-0008NT-2M; Tue, 03 Feb 2026 04:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnD6R-0008N8-GN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnD6O-0002Te-Hq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770112420;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CD3f8c5Whe0SWPceGeKFtmjRIkIIzIhnlnMFuwBkAlg=;
 b=IjpiAwE8rStLddnMd1Fgt7wTKjhwdXBauSBJTRqD1MVV89OwZ3hCJoKVpKftn5lfpB9FlO
 1FjUGDZWOfqs3fVHyoH+CoEkb9DPjlw3ZcKaSsYNTUL40g2gp5bbK8N03RWYrm8gnFGxgN
 UwSaORiwSqDxj93OpfYSz0Z2rH7lBDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-2GamjTl4PemXDmoKmfVznw-1; Tue,
 03 Feb 2026 04:53:39 -0500
X-MC-Unique: 2GamjTl4PemXDmoKmfVznw-1
X-Mimecast-MFC-AGG-ID: 2GamjTl4PemXDmoKmfVznw_1770112418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23D0819540D6; Tue,  3 Feb 2026 09:53:38 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFE3B1800285; Tue,  3 Feb 2026 09:53:34 +0000 (UTC)
Date: Tue, 3 Feb 2026 09:53:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
Message-ID: <aYHFmr3hW_ghCvFI@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
 <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
 <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
 <CANCZdfrZnHWN62WZGAzyNo2JsnK0=LwExqQfYD6K_hRUE7dzMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfrZnHWN62WZGAzyNo2JsnK0=LwExqQfYD6K_hRUE7dzMA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 02, 2026 at 05:49:44PM -0700, Warner Losh wrote:
> On Mon, Feb 2, 2026 at 2:57 PM Warner Losh <imp@bsdimp.com> wrote:
> 
> > Just to follow up....
> >
> > On Fri, Jan 23, 2026 at 3:14 PM Warner Losh <imp@bsdimp.com> wrote:
> > So, claude looks likeit's doing a passing fair job at this work. I plan on
> > submitting
> > a patch series for one of the minor files in the coming weeks (depending on
> > how much time I can find to work on it). Any guidance you can give me up
> > front?
> >
> > Before I submit, I plan on auditing every single change to make sure claude
> > didn't introduce anything that's not in bsd-user's blitz branch. Make sure
> > the authors
> > are correct to the same level that I've been doing so far. And make sure
> > I've rewritten
> > all the commit messages.
> >
> > One question I have, should include these lines
> >     🤖 Generated with [Claude Code](https://claude.com/claude-code)
> >     Co-Authored-By: Claude <noreply@anthropic.com>
> > it is adding to the commit messages or not? Claude generated this as a
> > series of
> > commits from the blitz branch to the master branch, but didn't actually
> > generate
> > any new code or fix any bugs. I'm happy to include them if you want, but
> > also
> > am weary about setting of a knee-jerk reaction that would be unhelpful
> > since
> > it's responding to the 'slop' worries and not the merits of the current
> > work.
> >
> > Comments?
> >
> 
> To not clutter up the mailing list, here's the changes. They are identical
> to what's in the qemu-bsd-user blitz branch. I've not curated the commit
> messages yet (they are what claude produced, but there's no copyright
> issues with commit messages), but plan on doing so since glancing over them
> right now I do see a few minor issues that need to be tweaked.

snip

> Thanks in advance for any feedback you can provide.

I glanced at the commit messages, and they look like that have avoided the
usual AI trap of being insanely verbose. They tell the "what" of the code
changes, but not so much the "why", which is common with AI since it has
no such insight.

That's not a problem per-se. The 'why' is optional for any commit. It is
applicable if there was something notable about the choices made in the
implementation that the author wants to call out to reviewers.

If the 'Generated-with/Co-authored-by' bits are removed, I think the
commit messages at least are fine to submit, if you consider them
accurate.

I'll assume all the other usual things are checked, eg that code compiles
& tests pass at each commit in the series, checkpatch.pl is clean or any
failures are jusifiably ignored as non-applicable/ false positives, etc

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


