Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FFA606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FuO/zPUh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQUW-0006WP-3T; Tue, 17 Nov 2026 16:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTQUU-0006WF-Cy
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTQUQ-0005k6-Lr
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794949998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvZFBEp+FUN5GS4NNRC+AKPSJyQVY0ytPYSDThFLdPk=;
 b=FuO/zPUhloP6cIR20skc4rqmQcDmyx5ZX03U6r+V4s+sRNYGXPS/TQFBFO0Bk5T8WWiW2Y
 O39Ck1gUGSEDfdMqIa1EivYAXdEDiQt0G933aoVxYLLb4YF5s4vKMzcrhggUkvno3Ke/S3
 TqZAb+5MrFcGkPOuTapV+UyKLoNmDVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-R1jUHSBkNuq5Upt6Sh1kaw-1; Tue,
 17 Nov 2026 16:13:13 -0500
X-MC-Unique: R1jUHSBkNuq5Upt6Sh1kaw-1
X-Mimecast-MFC-AGG-ID: R1jUHSBkNuq5Upt6Sh1kaw_1794949991
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78B311956046; Tue, 17 Nov 2026 21:13:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828271801977; Tue, 17 Nov 2026 21:13:07 +0000 (UTC)
Date: Tue, 17 Nov 2026 22:13:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <avzDYfG-cPiWaCZ6@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <avy4mkin-orpwskO@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avy4mkin-orpwskO@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 17.11.2026 um 21:40 hat Eric Blake geschrieben:
> [Chiming in late]
> 
> On Wed, Sep 30, 2026 at 10:54:30AM +0200, Paolo Bonzini wrote:
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify and enforce.
> 
> That ban is still impacting contributions today:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg03382.html
> https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg03845.html

And at least those of Christian's patches that I merged are a good
example of how AI-assisted doesn't automatically mean bad quality. These
patches were great, some of them better than the average human-only
patch. I assume that he still spent significant time on these patches
and didn't just send out the first thing AI gave him - which is how AI
should be used.

I also have two or three local tests that I created with AI because I
had a use for them, but never sent them upstream because of the policy.

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
> >  Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]
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
> >  docs/devel/code-provenance.rst |  71 +----------
> >  docs/devel/index-process.rst   |   1 +
> >  docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
> >  AGENTS.md                      |  42 +++++--
> >  scripts/checkpatch.pl          |   5 +-
> >  5 files changed, 252 insertions(+), 80 deletions(-)
> >  create mode 100644 docs/devel/llm-usage.rst
> 
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index 65b8f232a08..7403961378e 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -128,6 +128,10 @@ that are commonly used during QEMU development:
> >     suggestions for how to change a patch, it is good practice to credit them
> >     by including a ``Suggested-by`` tag.
> >  
> > + * **AI-used-for**: when AI/LLM tools were used to produce the patch, this tag
> > +   discloses what they were used for.  See :ref:`llm-usage` for the cases in
> > +   which it is required.
> > +
> 
> > +++ b/docs/devel/llm-usage.rst
> > @@ -0,0 +1,213 @@
> > +.. _llm-usage:
> > +
> > +Use of AI-generated content
> > +===========================
> > +
> > +.. warning::
> > +
> > +   Please read the below policy before using AI to contribute code or
> > +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> > +   Llama, and similar tools.
> 
> ...
> 
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
> I see lots of discussion about whether to stop here (and s/four/three/
> above), and leaving off the fourth bullet (or splitting it to a
> separate patch for later) appeals to me personally. But I can also go
> along with the final bullet if that is what the consensus lands on.

If the consensus is that the legal arguments for the current policy
aren't relevant any more, I'd like to have some policy update merged
rather sooner than later. Without this concern, I think I'm mostly in
the "it's just a tool" camp.

I don't mind the fourth point and don't expect practical problems from
it, but if some people do have concerns that would take months to
resolve, I'd prefer to do without it for now and allow at least the
uncontentious cases without waiting.

> > +
> > +- large, heavily LLM-assisted contributions where LLMs write large parts
> > +  of functional code.  These are only allowed if *pre-arranged*,
> > +  *high-quality* and *well-tested*.

Kevin


