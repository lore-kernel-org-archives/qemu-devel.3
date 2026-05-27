Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6854CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBtr-0002Jo-MT; Wed, 27 May 2026 06:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSBtm-0002JW-DI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSBtj-000391-Va
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779879242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpBkGNPbCCITitsLclmtV3ZXE7qV/scPCH4S2ZWrQV8=;
 b=YVlN11EtIHWq6sKjM2Uf+0VCFCzc2YGVgBW88H85YTVG/vnWHb759tzB6FGSIyacVaKQBz
 JtFuTd5GUCwIUHs4/34IFpc7yZNlvLZJnN0N0dsym1dWG1bjaFz6PYpfBQ2inGZ+A3QVPd
 K5UUMvsTS3PPSZGret8yvt8KgurPn4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-l1-sRvOYNRenq0plmkGxYw-1; Wed,
 27 May 2026 06:53:57 -0400
X-MC-Unique: l1-sRvOYNRenq0plmkGxYw-1
X-Mimecast-MFC-AGG-ID: l1-sRvOYNRenq0plmkGxYw_1779879236
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DFDC1956088; Wed, 27 May 2026 10:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.98])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A991687; Wed, 27 May 2026 10:53:54 +0000 (UTC)
Date: Wed, 27 May 2026 12:53:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahbNQJlv736Ajlkz@redhat.com>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.05.2026 um 12:01 hat Paolo Bonzini geschrieben:
> On 5/27/26 10:41, Kevin Wolf wrote:
> > Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> > > The QEMU Project currently may accept limited uses of AI that produce
> > > high quality patches that are limited in the creative content added.
> > > While maintainers will ultimately decide, changes like the following
> > > fall within this policy
> > > 1. Fixing obvious warnings in the obvious ways suggested by the tool
> > > 2. Tree wide API changes, and other similar mechanical changes done
> > >     today with perl/python/sed/coccinelle
> > 
> > As I said in the paragraph you quoted below, I don't think we should
> > encourage using AI for tasks that a deterministic tool could do.
> 
> In some cases such a tool does not exist.

Then it's not a task that a deterministic tool could do.

Of course, you can always write a new tool that does the exact thing you
want to change. But that's not what I was talking about here, I was
really talking about existing common tools.

> Much to my surprise, there is no tool to do static type inference on
> Python code, but AI is very good at doing it.

I think this is a special case that has a different balance anyway. When
reviewing such a patch, I would skim the change for the general approach
and if I like it, but checking for consistency and completeness is
something I would use mypy for - that is, a deterministic tool that can
verify the change. So I'd still use one, just at a different time.

(It actually also might be a rare instance where someone (TM) should
actually write the tool because it would be generally useful.)

> > Letting AI perform the change directly instead may be an acceptable
> > shortcut for a one-man hobby project that nobody else will ever look at,
> > but in the context of a community project like QEMU in which your
> > changes have to be reviewed and understood by others, it matters a lot
> > that the output of the tool is reproducible. Otherwise, you're creating
> > unnecessary work for others, and that isn't acceptable.
> 
> When applicable, going through coccinelle (with the aid of AI if needed! is
> indeed a good middle ground as it helps reviewers for large changes. If you
> have many slightly different but easily separated changes (e.g. you can
> split the patch by struct field), it may make things worse.
> 
> Its also worth noting that in other cases even sed or coccinelle, while
> deterministic, cannot produce 100% of the patch.

Agreed, it's all a case of "if possible, prefer this", not "you have to
do this 100% of the time".

> > So maybe we should even explicitly mention a recommendation like the
> > following:
> > 
> >      If you can use a deterministic tool, don't use AI instead. If you
> >      don't know how to use the deterministic tool, use the AI to tell you
> >      how to use it instead of trying to replace it.
> 
> I like it.
> 
> > > 3. Limited, small changes to fix bugs or add a small new feature whose
> > >     scope is less than about 100 lines and the originator can explain
> > >     them all or the meta issues about the patch.
> > 
> > Not sure if mentioning a number of lines is wise. 100 lines can be
> > mostly boilerplate and simple sequential code or they can be a deeply
> > nested complex algorithm.
> 
> I'd put the threshold at 20-50 at most.
> 
> > I think I would see more use in a tag like (better name welcome):
> > 
> >     AI-used-for: [code|tests|docs|commit message]...
> 
> I like this *a lot*.  No need for free advertisement, but some traceability
> is useful.
> 
> For tools such as sed or coccinelle, having the exact script in the patch or
> commit message useful.  Plus, the execution of the script more or lesss
> delimits the commit by itself (or 90%+ of it).  For LLMs it's a bit less
> clear cut because separating docs makes little sense.  And the exact model
> is pointless, it will be obsolete in 6 months and provide no useful
> information.
> 
> So, something like:
> 
> ------------------- 8< -------------------
> Use of AI-generated content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The QEMU project currently allows using AI/LLM tools to produce patches in
> scenarios with limited creative content:
> 
> Mechanical changes
>   If you can use a deterministic tool or a script, don't use AI instead.
>   If you don't know how to do the change deterministically, you may
>   ask the AI for help, rather than having it stand in for the tools.
> 
> Small bug fixes
>   These should be limited to 20 lines of code or less, not including
>   tests.  You are still expected to understand and explain your changes
>   and the rationale behind them.

I agree with "not including tests". But I think this would be more
consistent if we also add new tests (that come without a small bug fix
at the same time; either because the problem is already fixed or because
the fix is too complex to qualify) as another allowed category.

(To be honest, I'm a bit biased here because allowing tests is my single
biggest wish from an AI policy update.)

> These boundaries do not apply to other uses of AI, such as researching
> APIs or algorithms, static analysis, or debugging, provided their output
> is not included in contributions.  Larger uses of AI are allowed as an
> experiment, but they should be agreed upon with the maintainer prior to
> submission.
> 
> Use of AI does not remove the need for authors to comply with all other
> requirements for contribution.  In particular, the "Signed-off-by"
> label in a patch submission is a statement that the author takes
> responsibility for the entire contents of the patch, certifying that
> their patch submission is made in accordance with the rules of the
> `Developer's Certificate of Origin (DCO) <dco>`.
> 
> Commit messages for AI-assisted changes
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> When AI/LLM tools produce or substantively shape your patch, add an
> ``AI-used-for:`` trailer.  The text of the trailer could be one or more of
> ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> explanation in parentheses::

Include a category for commit messages, or are we expecting that commit
messages are always written by a human? If so, that should be explicit.

>     AI-used-for: tests, docs
>     AI-used-for: code
>     AI-used-for: code (refactoring)
>     AI-used-for: code (prototype)
>     AI-used-for: research
> 
> The trailer is intended as a clarification of your DCO obligations as well
> as to guide reviewers.  It is not intended for minimal presence such as
> autocomplete or asking for a pre-review of the patch, and it does not remove
> your responsibility to understand the changes that you are submitting.
> 
> Include the prompt in the commit message if it helps a reviewer judge the
> result:
> 
> * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> function already has a local variable or parameter of type ``struct bb``,
> use it instead of accessing ``aa.bb``."
> 
> * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
> forwarding the member functions to ``T`` while taking the lock around the
> calls".
> 
> * no: "write user-facing documentation for the new tool"
> 
> * no: "write testcases for the new functions"
> 
> Deterministic tooling (sed, coccinelle, formatters) is out of scope for the
> trailer, but should be mentioned in the commit message.

Apart from the above comments, this looks good to me.

Kevin


