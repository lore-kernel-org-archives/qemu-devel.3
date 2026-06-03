Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C62DCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpnj-0002Os-Oy; Wed, 03 Jun 2026 13:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUpnh-0002ON-An
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUpnc-0001yu-PO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780509276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYPCX2FLto2Q3H30MLxyYmAT35LNA15/Lxx09rlDSPo=;
 b=eOqelNTuoWJ9wsjf0hzaCcjyzr16SBNVFef2biTZyXAvWFmlQuCm4UeidCG6xWGZ8t2yNd
 +rXHdAZ6h+1f+39Doo4e5lOdWNviORHB5tbFVzwtRwtcZo7uNVBT9N7FQ5QGnT9ZQbjhaH
 Wy8Q+uZN13sp5ltTmp6HS5HK5qB4WkI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-XH9LCuk-MUKTAQqx3B8Dww-1; Wed,
 03 Jun 2026 13:54:32 -0400
X-MC-Unique: XH9LCuk-MUKTAQqx3B8Dww-1
X-Mimecast-MFC-AGG-ID: XH9LCuk-MUKTAQqx3B8Dww_1780509271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6C881956050; Wed,  3 Jun 2026 17:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5557E1956095; Wed,  3 Jun 2026 17:54:26 +0000 (UTC)
Date: Wed, 3 Jun 2026 18:54:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <aiBqT1KfI-qowr4L@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 05:35:46PM +0200, Paolo Bonzini wrote:
> On Wed, Jun 3, 2026 at 4:59 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > @@ -288,62 +288,108 @@ content generators below.
> > >  Use of AI-generated content
> > >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > > +Risks to open source projects include maintainer burnout from an
> > > +increased number of contributions, as well as the risk to the project
> > > +from unintentional inclusion of copyrighted material in the LLM's output.
> > > +In order to mitigate these risks, the QEMU project currently allows
> > > +using AI/LLM tools to produce patches in a limited set of scenarios:
> >
> > If we're opening the door to AI assisted contribution, then IMHO we
> > need to write about both the social and technical expectations.
> >
> > Admittedly that will expand the scope of your proposal here, but
> > IMHO that's somewhat unavoidable. A significant part of the downsides
> > of AI-assisted contributions comes from bad social practices, rather
> > than merely bad technical practices.
> >
> > As a general theme, I would like us to emphasize at the start that the
> > act of collaboration & contribution in QEMU is about the interaction,
> > trust and relationships between humans, not bots.
> 
> I agree that it needs to be there somewhere.  On the other hand I'm a
> bit worried about having a treatise that no one will read -- at least
> with stuff like "writing a commit message" we can point people to it.

It doesn't have to be an especially long introduction in the context
of the AI policy doc. If we want something more verbose that could
fit elsewhere in our contribution docs. The AI policy should just
make a point that we expect to be communicating with people not
bots pretending to be people.

> > > +**Small bug fixes**
> > > +  These should be limited to 20 lines of code or less, not including
> > > +  tests.  You are still expected to :ref:`understand and explain your changes
> > > +  <write_a_meaningful_commit_message>` and the rationale behind them.
> >
> > I think the "20 lines or less" is not going a good job at expressing
> > the intent behind this point. I'd like us to emphasize between the
> > "why" of this point, as that helps contributors & reviewers make a
> > decision of whether a change is "within the spirit" or the rule of
> > not.
> 
> True but we also need a rule. The spirit is better explained elsewhere
> (and also, building consensus on spirit vs. a rule are two different
> things).

Do we have a better elsewhere in this case ?  It is a point specifically
about intent of the AI policy rule. 


> > Docs is an area I'm more wary of from the social expectation side rather
> > than the technical or legal side.  I don't feeel like "pay attention to
> > the organization and flow" really mitigates to the tendancy to production
> > of vast reams of convincing sounding slop.
> 
> Reviewers have no obligation to review.  The good thing about slop is
> that saying no takes about the same effort as the author put into the
> creation of the change.

That is true, but at the same time even if you merely say "no", being on
the receiving end of it drains you mental energy, as you still have to
pay some attention in order to decide whether to say no or not. I'm
pretty wary at a policy that is liable to unleash volumuous docs
submissions on maintainers.

Can we do this more incrementally and have a more tightly constrained
guide for docs initially and review it again at a later date if we
feel it is worth relaxing further.

> > IMHO it should not be at the discretion of individual maintainers to
> > accept large-scale AI authored changes outside these guidelines. To
> > quote the commit message rationale
> >
> >    "Therefore, it remains prudent to only permit AI assistance where
> >     the ramifications of copyright violations are at least easy to
> >     revert and unlikely to spread"
> >
> > that does not suggest we should leave it to the discretion of maintainers
> > to override the guidelines.
> 
> See my reply to Peter elsewhere in the thread. I agree with your
> concerns for both docs and discretion, but I had specific uses in mind
> that I'd like to allow.
> 
> For docs:
> - create tutorials and/or feature documentation based on functional tests

That doesn't sound too appealing to me. Reverse engineering docs
or tutorials from our functional tests is exactly the kind of
thing that feels likely to result in volumous text of marginal
value which will have a large burden on reviewers.

> - create function comments (including Rust doctests) based on a
> high-level, human-written description of the module

This feels interesting to trial.

The key difference with function comments is that you don't really
have any of the trouble with document structure & coherence. The
API docs should be comparatively smaller & easier to read & digest
and give feedback on accuracy of.

> For maintainer discretion:
> - updating patches for changes to kernel APIs, before the kernel side
> is ready for inclusion
> - creation of parsing code for Rust procedural macros based on code
> examples and/or a human-written description of the macro
> - creation of boilerplate code similar to hw/core/hotplug.c
> 
> I think all of these are potentially compelling and I would like
> people to be allowed to experiment with them or similar cases.

Those are largely in direct conflict with the intent behind only
allowing "small bug fixes". Either we accept broad contributions
like this as a project, or we don't - I don't see that as something
that is suitable for per-maintainer discretion. If it will not be
intended for merge, then the policy is irrelevant and people can
just experiment out of tree at will.

> The idea of contacting maintainers beforehand comes from the policy
> currently under discussion in the Rust project.

I presume you're looking at

  https://github.com/rust-lang/rust-forge/pull/1040/changes

What I find interesting there is that their rule that is comparable
to your "small bug fixes" rule, emphasizes it is about allowing
"trivial" chances and specifically references the idea of a threshold
for originality / copyrightability. I find that more satisfying than
talking about lines of code and bug fixes.

The talk about experimenting with LLMS for larger changes emphasizes
experimentation  and use of PRs in order to trigger the run of tools
from their review pipeline.   

That doesn't explicitly say whether such "experiments" are permissible
to be merged though. I don't know if the Rust project has specific
terminology here, but my reading of that was that people can agree
to collaborate publically on LLM work, but that does not appear to give
individual maintainers permission to waive the LLM policy rules to
merge arbitrary LLM code in the way this QEMU proposal suggests.


> > > +There is no requirement to include your prompts or summarize the
> > > +conversation in the commit message or cover letter, but you may do so
> > > +if you think it helps a reviewer judge the result.  For example:
> >
> > IMHO we should actively discourage the inclusion of prompts
> > entirely as it is the wrong information to provide.
> 
> Why? I think it helps especially in the case where we're asking for
> maintainers to apply their discretion, and for reproducibility. It may
> not be always applicable, but it can also help.
> 
> > > +**Helpful prompts**
> > > +  These describe concrete constraints or instructions, making it easy for a
> > > +  reviewer to see how the tool's output was guided:
> > > +
> > > +  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> > > +    function already has a local variable or parameter of type ``struct
> > > +    bb``, use it instead of accessing ``aa.bb``"
> > > +
> > > +  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; it
> > > +    takes the lock around the calls and forwards to ``T``"
> >
> > These examples prompts are just expressing an aspect that should
> > already have been described in prose in the commit message. We
> > don't need to classify them as "ai prompts" in a a commit message,
> > we just need the author to write a useful commit message.
> 
> The commit message does not have to contain this information. For
> example, commit 44a9d1b86c0 does not explain that it implements the
> ToMigrationState{,Shared} traits for Mutex. The commit message could
> say something like
> 
> "The implementation of the traits for types ... were created with AI.
> The prompt was: "add a simple forwarding implementation of the traits
> in rust/migration/src/migratable.rs for the array type [T; N] and for
> the interior mutable types Mutex<T> and BqlRefCell<T>. Note that
> interior mutable types only need T: ToMigrationState in order to
> implement ToMigrationStateShared".

If that is relevant info for reviewers then regardless of whether
it was written by an LLM or a human, that should have been added
to the commit message.

 "This commit adds a simple forwarding implementation of the traits
  in rust/migration/src/migratable.rs for the array type [T; N] and for
  the interior mutable types Mutex<T> and BqlRefCell<T>. Note that
  interior mutable types only need T: ToMigrationState in order to
  implement ToMigrationStateShared".

there is no reason to call out the inclusion of "LLM prompts" as
a concept here. We should be emphasizing that commit messages
should explain their intent in all cases, not something specific
to AI authored code.

> I agree that this is not a typical part of a commit message. On the
> other hand we do mention occasionally how a commit was automated, and
> this falls under that case, sort of? See for example commit
> 324b2298fea ("docs/system: convert Texinfo documentation to rST",
> 2020-03-06).



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


