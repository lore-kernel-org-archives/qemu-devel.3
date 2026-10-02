Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A93CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCedh-00026r-PY; Fri, 02 Oct 2026 10:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCedf-00026T-Oc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCedd-0004Qu-Qt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790952808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3QRQy3iI5/5IPtACg4wY10aCRW+6u1TuSfC7Eq23xBw=;
 b=jBI4OgiqzNHEf6Zy9hRvDWb9wGFrghjog/rP9W63HE5gG3zi7Cqwd8Xhh1sEZT4NNGk3Vu
 UNGm29Ep8qBrOUdho0+erfixmMxGThgfDtjqq7Y1OkEsr4RzzkQHHEAaYVi4H+PyNrMvQT
 nUVKeJaTPZ8ymN0wzWT2sdUTyiR1JU8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-8_u8yLIoNzaw76XQ7Jp7KQ-1; Fri,
 02 Oct 2026 10:53:25 -0400
X-MC-Unique: 8_u8yLIoNzaw76XQ7Jp7KQ-1
X-Mimecast-MFC-AGG-ID: 8_u8yLIoNzaw76XQ7Jp7KQ_1790952803
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89DD318009C0; Fri,  2 Oct 2026 14:53:22 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81795180056E; Fri,  2 Oct 2026 14:53:19 +0000 (UTC)
Date: Fri, 2 Oct 2026 15:53:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <ar_FXE5rzVqKcTc4@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 01, 2026 at 01:21:43PM +0100, Peter Maydell wrote:
> On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > +LLM-assisted and LLM-created contributions
> > +''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Use of generative AI can be classified in the following four buckets:
> > +
> > +- "background" assistance, such as completion and code review.  This does
> > +  not need disclosure.
> > +
> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> > +  are allowed with disclosure.  Splitting a submission in multiple parts
> > +  is **not** a valid way to bypass this rule; repeated, frequent posting
> > +  of such fixes must follow the rule for full contributions.
> > +
> > +- use of LLMs to help generating parts of a larger patch---test cases,
> > +  adaptations of existing code, boilerplate code for a new API, a tool to
> > +  help performing mechanical changes, etc.  These are generally allowed;
> > +  disclosure is highly recommended for non-trivial, functional code.
> 
> I think we can get or have consensus on these first three buckets...
> 
> > +- large, heavily LLM-assisted contributions where LLMs write large parts
> > +  of functional code.  These are only allowed if *pre-arranged*,
> > +  *high-quality* and *well-tested*.
> > +
> > +The last case (*"LLM-created contribution"*) is the one that requires
> > +a more careful approach.  In particular:
> > +
> > +- "Pre-arranged" means that a maintainer has communicated ahead of time,
> > +  for example on `IRC or the QEMU mailing
> > +  list <https://www.qemu.org/contribute/>`__, that they are willing
> > +  to review an LLM-created contribution.
> > +
> > +- "High-quality" means that the contributor must apply the same judgment
> > +  that would be applied to other code changes.  Contributors must invest
> > +  substantial time reviewing their contributions, curating them, and
> > +  understanding them in depth.
> > +
> > +- "Well-tested" means the LLM-created contributions will be held to a
> > +  higher standard than human-created ones, because LLMs make it easier
> > +  to write tests.  There are no exceptions for "writing the tests seems
> > +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
> 
> ...but I think fundamentally I am not in favour of having this
> fourth category of permitted uses. It seems even to have lost the
> idea of it being an "experimental" approach in this revision of the
> series. The first three categories are fine, and I have no particular
> problem with our relaxing our current policy to explicitly permit them.

I suggested previously to remove the "experimental" tag, because it
felt rather misleading wrt what the policy was actually proposing to
permit in practice.


When we're saying that a maintainer and contributor can agree to
use AI for *anything* and will merge it, then that work has ceased
to be for "experiments". It is a fully accepted use case for writing
and merging code. All the policy is doing at that point is attempting
to rate-limit work by requiring prior agreement to use AI.


> Our problem as a project does not seem to be on the "writing
> code" side of things, but has always been on the "code review"
> side. This policy relaxation makes it much easier to write more
> code. Even when there's a "pre-arranged reviewer" that isn't
> necessarily helpful -- if you're one of the primary maintainers
> for an area of QEMU then the fact that somebody else is reviewing
> it doesn't make a big AI-generated code infusion any more palatable.

Yes, that is my concern with anything that ends up spreading outside
the bounds of a single subsystem & its maintainer(s).


> I look at our issue tracker where we see AI assisted contributions
> that run the whole range from "an human making intelligent use of
> the tool to provide high-quality bug reports with good analysis"
> through to "absolute slop dumped on us with no apparent human
> thought or intervention". I don't really want to expand that
> from our issue tracker to our code review and codebase, please.

One of the problems I have with the AI contribs in the bug tracker
is that the quality/accuracy is just about high enough that I am
not comfortable rejecting (closing) most of the bugs, as there's
usually some nugget of a real problem in there. At the same time
the quality is not high enough to make it pleasant to deal with
the issues, which is amplified by the volume of bugs.

I expect the same thing will happen with code. The patches will be
good enough, such that you'll have a really hard time to justify
rejecting them outright. They can even be as good as an initial
patch from a human. The difference is that when you point out all
the mistakes to the human, they'll remember most of it and not
make the same mistakes again in future contributions. For bots,
it is a potluck whether your feedback has any effect long time
on future contributions. So we'll end up suffering through the
review of the work regardless.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


