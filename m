Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C0C982F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8dOF-00017p-Fo; Mon, 21 Sep 2026 08:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8dNg-0000pr-KO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8dNe-0003rj-49
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789994659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieiJte86dJPr4H5nWBZJAfk2w7Y4dzXFX1S0YuFeB1w=;
 b=RaUxqD/eJXLsWeV9vwxKhcHy+ow0oOSaFig+Swl1n6wms6QydDXsWVJBTSg3PrDTU3waCp
 5bDXtl32B5T1JR6jpBmN7sDNPjpcVBb3vACyHARkmG0eCHiZYte2KbR0pQT7qF0gODfFtk
 byAaue57CczLUo2SYvBG5e31Zpq9Cas=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Mt_EcyUgMrqVoNYEQDOhKA-1; Mon,
 21 Sep 2026 08:44:17 -0400
X-MC-Unique: Mt_EcyUgMrqVoNYEQDOhKA-1
X-Mimecast-MFC-AGG-ID: Mt_EcyUgMrqVoNYEQDOhKA_1789994656
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F2F1955EA0; Mon, 21 Sep 2026 12:44:15 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8B29300106B; Mon, 21 Sep 2026 12:44:12 +0000 (UTC)
Date: Mon, 21 Sep 2026 13:44:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
Message-ID: <arEmmePx36txCWCS@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-4-pbonzini@redhat.com>
 <878q4v0wle.fsf@draig.linaro.org> <arEQ0knroQ3NDDBA@redhat.com>
 <CABgObfanWMyrLnBzM=_c6HgKFXO9Stu5WR6YU6dpSCLjS6Nr2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfanWMyrLnBzM=_c6HgKFXO9Stu5WR6YU6dpSCLjS6Nr2A@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 21, 2026 at 02:12:32PM +0200, Paolo Bonzini wrote:
> Il lun 21 set 2026, 13:11 Daniel P. Berrangé <berrange@redhat.com> ha
> scritto:
> 
> > > > +### No automated posting
> > > > +
> > > > +Agents **must not** use any API, CLI, or web UI automation to:
> > > > +
> > > > +- Interact on the QEMU mailing lists
> > > > +- Create, edit, or close **issues ("work items")**
> > > > +- Post **comments** on merge requests, issues or commits
> > > > +- Open or update **merge requests (MRs)**.  QEMU does not use merge
> > requests anyway.
> > > > +
> > >
> > > Are we considering project agents (such as the stsquad-bot) exempt from
> > > this policy? I'm not sure what a normal agent can do via the API as it
> > > wouldn't have the project level access the stsquad-bot needs.
> >
> > At least a user's agent can likely bulk file work items without elevated
> > access privs, as we've seen by the several slop-bombs we've had.
> >
> > I'd add a footnote for that along the lines of:
> >
> >  'Official project agents whose code is maintained under
> > gitlab.com/qemu-project
> >   may be exempted from one or more of these rules, at the discretion of
> > the QEMU
> >   project maintainer(s)'
> >
> 
> Sure.
> 
> > > +### No AI-written text must reach maintainers
> > > > +
> > > > +These rules apply when publishing AI-assisted work to GitLab or the
> > mailing list:
> > > > +
> > > > +- **AI-written cover letters and commit messages are banned**.  These
> > are
> > > > +  easy to recognize and waste reviewers' time.
> > > > +- **AI-generated responses to reviewer comments are banned**. This
> > undermines
> > > > +  the human-to-human interaction fundamental to code review.
> > > > +- **AI-written issue ("work item") descriptions or comments are
> > banned**. These
> > > > +  are verbose and waste triagers' time.
> > > > +  - An exception is made for issues for defects detected by automated
> > or
> > > > +    semi-automated tooling, including fuzzers and LLM-assisted defect
> > > > +    detection.  Such issues must be reviewed by a human before
> > creation,
> > > > +    must be created by a human and communication with maintainers must
> > > > +    be done by a human, but including the verbatim tool output in the
> > > > +    issue description is explicitly allowed.
> >
> > I kind of want to eliminate this exception. IMHO from the bugs we're
> > getting, I think human's are often putting very little effort into
> > reviewing the tools output, such that it is largely a box ticking
> > exercise to claim they've reviewed it.
> >
> > If we removed the exception, and required humans to write up the
> > finding of the fuzzer/detect detection in human language, that
> > may do a better job of getting people to engage in more critical
> > thinking rather than rubber stamping the tool output.
> >
> > It would limit the ability of people bulk file 50+ tickets in a day.
> >
> 
> I think that's the problem, namely not realizing there's someone on the
> other side.
> 
> LLM write-ups are essentially the same as patents, they look like English
> but they're not; and the verbosity of the write-ups is sometimes a curse
> and sometimes a blessing. There is a tension between having a simple
> description of the issue and an unopinionated one. The fix is not always
> trivially obvious, and sometimes the "executive summary" from the LLM
> points in the wrong direction—I have no expectation that human reporters
> will be any better at not misleading me.

The difference though is that when I put effort into responding to
a wrong executive summary written by the human, it is still potentially
a reasonable use of my time as they might learn something from the
exchange.

Responding to a wrong executive summary from the bot sucks the will to
live as you know it won't improve things next time around.


> In fact I'd rather like us to introduce an explicit rule that a person/
> > tool must not file more than about 5 tickets in a single day, without
> > prior approval from maintainers, so we don't get bombarded at such a
> > high rate.
> >
> 
> Sure, that's a good idea. Even 5 per month...

I wouldn't want to limit organically found bugs quite that low, but
for automated bug discovery we need to stem the flow, and set a
stronger expectation for the contributor writing a patch and taking
responsibility to submit it via qemu-devel.

Ideally we would get people sending patches directly to the list
without the bug tracker at all, except for security bugs - which
needs the security classification work:

  https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg03555.html

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


