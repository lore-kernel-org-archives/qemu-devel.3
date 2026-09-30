Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91223CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBu4u-0003Ag-6Z; Wed, 30 Sep 2026 09:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBu4V-0002sK-RN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBu4T-00027N-4s
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 09:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790773802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOl7P8Ql/AD1fju4ONIDvNjgfgjTRZbOKrSaoZl798Y=;
 b=Ij3ZBx1wyHUNBxarEfalRmTCTzucShAQ+C8DWdkHgCbnVNAufvzAqDJezCcIENPRCyG8HL
 O938Vezgm2oj46/bs1WyKi9aQigV6kepu1lt4s4c4GFtKGh5UybcYAgxG3hMQmdDbkEwdS
 K+GrSSwFdfEkez6PlkNj8IIS9RbKMRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-pAYke1hmMM-73b5VpfsOdQ-1; Wed,
 30 Sep 2026 09:09:58 -0400
X-MC-Unique: pAYke1hmMM-73b5VpfsOdQ-1
X-Mimecast-MFC-AGG-ID: pAYke1hmMM-73b5VpfsOdQ_1790773796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4B61944EB0; Wed, 30 Sep 2026 13:09:56 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22CCC30000E8; Wed, 30 Sep 2026 13:09:52 +0000 (UTC)
Date: Wed, 30 Sep 2026 14:09:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <ar0KHoufSW4glOzO@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 30, 2026 at 02:54:09PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 30/9/26 10:54, Paolo Bonzini wrote:
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify and enforce.
> > 
> > Even a simple code review task these days may result in the agent
> > suggesting code changes, or producing a useful test case to verify the
> > presence or absence of a bug.  A hardline interpretation of the policy
> > makes it hard to use AI even for tasks that are explicitly allowed.
> > 
> > On top of this, several maintainers have pointed out that contributions
> > that can be reasonably suspected to be AI-assisted or more have been
> > posted and included.  Some of these contributions are actually of very
> > high quality; it seems that the mailing list-based contribution process
> > has mostly protected QEMU from low quality patches.  A prohibition on
> > AI puts maintainers in a difficult position: on one hand the DCO process
> > lets them rely on the submitter's certification of origin, on the other
> > hand maintainers are supposed to know and implement the process policies.
> > 
> > Since the policy has been written, other projects have discussed and
> > taken their stance on AI contributions.  These vary from full prohibition
> > (though typically motivated by social reasons rather than legal, e.g.
> > for Zig) to limited use (e.g. GCC, allowing small contributions and
> > tests to use AI), to cautious experimentation.
> > 
> > This proposed policy seeks to implement the cautious experimentation
> > approach, inspired mostly by the Rust project's policy and by Software
> > Freedom Conservancy's own recommendations on LLMs and generative AI.
> > 
> > Relying on Conservancy's legal guidance allows us to focus on the
> > interaction between contributors and maintainers.  Conservancy in
> > particular provides this point to alleviate the concern that motivated
> > the policy, about whether the submitter has the legal right to contribute
> > the code and about unintentional reproduction of copyrighted code:
> > 
> >     "Copyleft Everything" remains the best viable and safest approach
> >     Certainly those who want to release FOSS under non-copyleft licenses
> >     have more to worry about when using these tools.
> > 
> > While we shouldn't treat copyleft as a silver bullet, it is effective
> > as part of a defense in depth strategy that includes, for example,
> > "de minimis" thresholds and `AGENTS.md` instructions that encourage user
> > participation in the design.
> > 
> > Therefore, the revised policy considers QEMU's copyleft to be a viable
> > approach to any unanswered legal questions about AI-generated
> > contributions and their copyright status.  This lets the policy
> > focus on the topic of what AI-assisted contributions require of
> > maintainers.
> > 
> > In that respect, the Rust project's policy combines two unusual ideas.
> > One is to hold them to a higher standard, in the spirit of using AI to
> > work "better, not faster"; the other is to require "pre-arrangement" for
> > "changes that are originally created by an LLM".  AI lowers the cost of
> > producing a patch but does nothing to lower the cost of understanding
> > and reviewing one; if anything it raises it, since a reviewer can
> > no longer assume that the submitter has reasoned through every line.
> > Pre-arrangement is an attempt to balance the shift of effort from the
> > developer to the maintainer, and the QEMU policy includes the same
> > provision.
> > 
> > Going full circle to the reason why we might need to review the
> > policy, there is the question of how to make sure policy is applied.
> > QEMU maintainers have already experimented with using AGENTS.md files;
> > subsequent patches will also try to embody the "work better, not faster"
> > mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
> > should be included in the policy, and they are indeed.  The list is short
> > and based on the Rust policy and the GStreamer AGENTS.md file.
> > 
> > Revise the policy according to the above considerations, and introduce the
> > "AI-used-for:" trailer as a record of where AI was used.  The standard is
> > slightly different from the more usual "Assisted-by"; the intention is for
> > the metadata to provide more information for reviewers to judge the result,
> > and to scope areas for which Signed-off-by cannot guarantee full control
> > of provenance.
> > 
> > In any case, use of AI does not relax any other contribution requirement:
> > authors still need to comply with the DCO (declaring that they have
> > corporate authorization to contribute, for example) and take technical
> > responsibility for their work.
> > 
> > [Commit message largely based on discussions with Daniel Berrangé,
> >   Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]
> > 
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Alex Bennée <alex.bennee@linaro.org>
> > Cc: Alistair Francis <alistair.francis@wdc.com>
> > Cc: BALATON Zoltan <balaton@eik.bme.hu>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Warner Losh <imp@bsdimp.com>
> > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   docs/devel/code-provenance.rst |  71 +----------
> >   docs/devel/index-process.rst   |   1 +
> >   docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
> >   AGENTS.md                      |  42 +++++--
> >   scripts/checkpatch.pl          |   5 +-
> >   5 files changed, 252 insertions(+), 80 deletions(-)
> >   create mode 100644 docs/devel/llm-usage.rst
> 
> 
> > +.. _ai-used-for:
> > +
> > +Commit messages for AI-assisted changes
> > +'''''''''''''''''''''''''''''''''''''''
> > +
> > +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
> > +line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
> > +is both a reminder of your DCO obligations and a guide to reviewers.  The
> > +text is one or more of ``code``, ``tests``, ``docs``, ``research``, possibly
> > +followed by an explanation in parentheses:
> > +
> > +To be able to certify the provenance of AI/LLM-generated code that you submit
> > +to QEMU, you must follow the policies outlined in this document and in
> > +QEMU's ``AGENTS.md``.  **By using 'AI-used-for', a contributor both
> > +identifies areas of the patch that involved use of AI/LLM, and also
> > +attests that their usage of AI/LLMs was in compliance with the policies
> > +outlined in this document.**
> > +
> > +.. code-block:: none
> > +
> > +     AI-used-for: tests, docs
> > +     AI-used-for: code
> > +     AI-used-for: code (refactoring)
> > +     AI-used-for: code (prototype)
> > +     AI-used-for: research

Do we really want to include that last one "research" ? In that scenario
the AI agent is not directly authoring code, so nothing in the commit can
be directly attributed to the AI.

In the current world people turn to AI instead of google search / stack
overflow, and indeed google search is effectively "AI based research".

I'm not convinced "AI-used-for: research" has any real value other than
to demonstrate how much you personally  rely on AI, and I don't think
the projects needs to care/ask about that.

> > +``AI-used-for`` should not be included for "background" usage such as
> > +autocomplete or obtaining a pre-review of the patch.

I'd be stronger and say  "AI-used-for" only be used where some part of
the patch *content* was authored by the AI.

> > +Do not include your prompts or summarize the conversation in the commit
> > +message or cover letter.  Extract any information that is relevant to the
> > +reviewer and include it in commit messages, cover letters or code comments.
> > +
> > +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
> > +trailers to indicate AI usage.  In particular, do not specify the exact
> > +AI model or tool used to create the commit.
> > +
> > +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> > +the trailer, but should be mentioned in the commit message.
> 
> I noticed a discrepancy in a method docstring and a particular use case.
> Since the method is used distinctly in various configurations (KVM, TCG,
> RISCV, ARM) I asked a LLM "using the semcode tools only and deliberately
> ignoring the method documentation, look at all the call tree and how the
> passed arguments are used and explain what is expected of this method
> to a junior engineer" then once I understood out what was wrong I could
> update the docstring in the header. No code / comment generated by the
> LLM ends in the commit / repository. IIUC this use case is compatible
> with the new policy. What trailer should I use?
> 
>   AI-used-for: research
>   AI-used-for: code (audit)
>   AI-used-for: code audit (semcode)

Personally I'd say your example should not require any AI-used-for
tag, since no code ends up in the commit.

> 
> 'semcode' is a deterministic tool, so instead my commit should contains
> '''
>   When updating foo() contract in commit fe89fe89fe89 we forgot to
>   update its documentation. Checking with the semcode tools, most
>   callers pass @arg as a mask. Update the documentation.
> 
>   AI-used-for: code audit
> '''
> 
> Would that be a good example?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


