Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3162BC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpqP-0004HE-Hk; Tue, 11 Aug 2026 13:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtpqM-0004Gc-IB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtpqK-0000gz-4c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786467646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUKJGJppZutoKo1N55OeZZDsFSX+r+ruaIHLPxn9KcI=;
 b=HDWIqWBNGaB5NTc6S6loEeqFDA4IohzCs8oySjY+kjmGLzUL1cOS377YX56mp+ARj2ay6Z
 b6PaDkIkx84g0R08y0pai866hA2mwzqaevlTfGHe2GcVCVFX+rUevhvZAUbYMF70cLJUi9
 NFRcV4Syw8CTejJ2IZXks1T28xmuNbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-XdABOJeEOEC5Z_jQp98Opw-1; Tue,
 11 Aug 2026 13:00:41 -0400
X-MC-Unique: XdABOJeEOEC5Z_jQp98Opw-1
X-Mimecast-MFC-AGG-ID: XdABOJeEOEC5Z_jQp98Opw_1786467639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4650195606A; Tue, 11 Aug 2026 17:00:38 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65AAD180034C; Tue, 11 Aug 2026 17:00:35 +0000 (UTC)
Date: Tue, 11 Aug 2026 18:00:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: GCC, Conservancy and Rust AI documents (was Re: [PATCH v2]
 docs/devel: relax policy on AI-generated contributions)
Message-ID: <antVML3r_It14_Jk@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
 <anXuqbBXERqn4lPu@redhat.com>
 <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Fri, Aug 07, 2026 at 08:42:17PM +0200, Paolo Bonzini wrote:
> On 8/7/26 16:41, Daniel P. Berrangé wrote:
> > None the less that is an interesting benchmark.
> > 
> > A key challenge we've always had in these discussions is how
> > to draw a line on what "legally signicant" means in practice.
> > 
> > The fact that the GNU project has used the "15 lines" rule
> > for copyright assignment is quite a useful benchmark to take
> > in to account precisely because they've used that for years
> > (presumably decades?).
> 
> True, but it's only superficially the same that they've used.  The GNU "15
> lines rule", as defined at
> https://www.gnu.org/prep/maintain/html_node/Legally-Significant.html, is
> that "what counts is the total contribution of the person; it is irrelevant
> which parts of it were contributed when"; whereas the GCC AI policy treats
> each contribution from LLMs as independent.

I'm unclear whether that's total contribution over time & eternity, or
total contribution at a point in time.

eg difference between a person sending

 a. 1 patch  in all time that is 15 lines of code
 b. 5 patches in one day each of which are 15 lines of code
 c. 5 patches spread over 10 years each of which is 15 lines of code

IIUC, the GCC AI policy allows all three, but the the GNU copyright
assignment policy allows (a), definitely NOT (b), and possibly not (c) ?

> Presumably this is because they consider the likelihood of copyright
> infringement to be independent across LLM outputs, but it's nevertheless a
> different rule.  If so, their reasoning is similar to the one discussed
> earlier in the thread, and they simply picked the same threshold that was
> already in place.

Also the context is different. I would think the purpose of the copyright
assignment exception is to facilitate trivial bug fixes from random one
time only contributors, while capturing anyone who is likely to be a
repeat contributor.

> > IME, it is by writing docs for a feature, that you come to learn about
> > the flaws / gaps in the thing that is implemented, which feeds back to
> > improve the code.  Generating docs you're just going get text that
> > reflects the state of the code without the learning & improvement
> > experiance.
> > 
> > I don't think we should have an exception for tests either. If we
> > have code in the tests directory that is generalized to become
> > part of the broader codebase, we shouldn't have to think about the
> > history of whether the tests code was AI generated.
> 
> No one is going to agree 100% with everyone else; the only possible
> equilibrium is going to be the current "no AI for code generation" policy.
> The problem with it is that it is hard both to comply with and to enforce.

Enforce, I'm not very bothered with. OSS has always relied on the honesty
of contributors as there is never any practical way to enforce non-technical
constraints.

We should assume honest contributors as the baseline. If there are malicious
people, no rules will ever solve that - they just have to be dealt with as
special cases

So the practicality of compliance is what matters.

> Contribution to a community is based on some kind of honor system, but the
> reality of LLM operation makes it very hard to use them even for tasks that
> are considered acceptable.  In that sense, the policy hinders the honor
> system instead of helping it.
> 
> For example, our policy says that you can use AI for review.  You get a
> review like this (it's Linux but you get the idea):
> 
>    kvm_put_kvm() now runs under sev_mirror_lock.  The put is inside the
>    critical section [...] If that's the last reference it drags all of
>    kvm_destroy_vm() under the mutex.  It's easy to keep it a leaf:
> 
> 	mutex_lock(&sev_mirror_lock);
> 	sev->enc_context_owner = NULL;
> 	mutex_unlock(&sev_mirror_lock);
> 	kvm_put_kvm(owner_kvm);
> 
>    Should I apply the change?

Even with our current AI policy that forbids all contributors, personally
I consider it still leaves (unwritten) scope for the contributor to take
AI output *if* the person can be confident in asserting the output did
NOT meet the threshold for copyrightability/originality.

IOW, I consider the current AI policy only bans contributions which meet
the threshold for copyright. We left that unsaid as we didn't want to
have to then explicitly define where that threshold lies.

> Am I supposed to say no and swap the last two lines myself?  This case is
> probably fine, but where do I draw the line?

Yes, drawing the lines is precisely the hard bit.

The unwritten "leave it to the discretion of the contributor" is our
current unsatisfactory answer.

The "15 lines of code" guide is the suggested alternate unsatisfactory
answer.

By issuing explicit guidance in policy we put a little more liability
onto the project by blessing a specific interpretation.

> In other cases, during review the LLM will sometimes write testcases even
> without asking.  Recently, one model came up with this exponential-time
> testcase while I was trying to understand some Meson code:
> 
>    project('t', 'c')
>    pkg = import('pkgconfig')
>    l0 = static_library('l0', 'x.c', install: true)
>    l1 = static_library('l1', 'x.c', link_with: l0, install: true)
>    l2 = static_library('l2', 'x.c', link_with: [l1, l0], install: true)
>    l3 = static_library('l3', 'x.c', link_with: [l2, l1], install: true)
>    l4 = static_library('l4', 'x.c', link_with: [l3, l2], install: true)
>    l5 = static_library('l5', 'x.c', link_with: [l4, l3], install: true)
>    # ...
>    pkg.generate(l22, filebase: 'top')
> 
> If I decide that this is a good regression test, how do I (in the context of
> a policy like QEMU's) even rewrite a testcase like this for inclusion?  Do I
> have to rewrite it as a loop:

We see this with many security disclosures coming with giant test cases.
Most of these I would consider to be copyrightable and thus forbidden
by our currwent policy, and likely also forbidden by the "15 lines of
code" policy since they are often much longer than 15 lines.

IMHO users have to accept that they cannot use these LLM code outputs
in most / many cases, with our current policy and this new proposed
policy.

If the tool is incapable of complying with our legal policy, this doesn't
mean we should just change policy to accept whatever, it implies the tool
is not satisfactory to use as is.

>    project('t', 'c')
>    pkg = import('pkgconfig')
>    a = static_library('l0', 'x.c', install: true)
>    b = static_library('l1', 'x.c', link_with: a, install: true)
>    foreach i : range(2, 23)
>      t = a
>      a = b
>      b = static_library(f'l@i@', 'x.c', link_with: [t,a], install: true)
>    endforeach
>    pkg.generate(b, filebase: 'top')
> 
> ?  Is this actually an improvement?  Maybe in a test the repetitive text is
> actually clearer.  If I decide the loop shape is worse, or in cases where
> there simply isn't another way to write it, the current policy doesn't even
> let me be honest.

It is arguably still a derived work of the LLM output, just one that has
been deliberately obfuscating its origins for malicious compliance with
the policy. This isn't a unique problem to LLMs though. It is the dilema
people have always faced when finding useful code snippets (on StackOverflow
or 3rd party project repos) and then using that as a starting point for
a QEMU contribution. There's always the incentive to obfuscate the origins
in this manner and have to hope people don't take that path.

> "Use it only for study or review" is a fig leaf.  We *won't* be able to
> catch all AI contributions, whether to code, tests or documentation.  A
> no-agents/no-copy-and-paste policy is clearly enforceable because the LLMs'
> (unbearable) mannerisms jump out instantly.  But if we're talking about AI
> code written by someone who already knows what they want to get, who knows
> the surroundings and has a design in their mind that informs the discussion
> with the LLM, the result is practically (or completely) indistinguishable
> from human-written code; the requirement to split the change into logically
> independent patches alone imposes a large amount of human-like structure.

A significant problem with our AI policy is that we still do not have an
AGENTS.md file commited to give more detailed/explicit guidance to the
agents.

If we really don't want our contributors to face this dilema, we should
look at an AGENTS.md file that strongly instructs/insists that the agents
do NOT generate code snippets, or to strictly limit them to short snippets
or psuedo-code, not exact complete end-to-end programs / test files... or
whatever constraint we feel is the best tradeoff in this area.

AGENTS.md is by no means foolproof, but it ought to be a significant
improvement over having none at all.

> The first is Conservancy's own recommendations for generative AI (https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html).
> While I believe we wouldn't follow all of them (for example the
> recommendation to treat chat logs as artifacts to be conserved is not
> practical), there are some useful points to consider, with respect to the

More than impractical, I'd class the "chat logs preservation" point as
inappropriate to request of contributors. It is like asking to see
the contributors' full "git reflog" - way too invasive.

> copyright infringement risks that drove the current policy and to the
> general recommended attitude on both ends:
> 
>   The FOSS community should support, not just tolerate, those who
>   outright reject LLM-gen-AI systems.  [...]  FOSS projects should not
>   shun contributors who choose to use LLM-gen-AI systems.

The biggest challenge I see is in regards to our long term pipeline
of future contributors, an increasing number of whom will have never
known a world without assistance from LLM agents.

>   Before submission, FOSS Contributors must invest substantial time
>   reviewing LLM-gen-AI -assisted and/or -generated contributions.
> 
>   “Copyleft Everything” remains the best viable and safest approach
>   Certainly those who want to release FOSS under non-copyleft licenses
>   have more to worry about when using these tools.  [...]
> 
>   When LLM-gen-AI systems (including proprietary ones) can massively
>   accelerate FOSS improvements, use of such tools is an appropriate
>   strategic compromise [...]
> 
> Second, the Rust project came up with a different way to approach the issue:
> require disclosure of LLM-assisted changes and hold them to a higher bar.
> The policy is summarized as follows (https://blog.rust-lang.org/inside-rust/2026/08/05/rust-langrust-is-adopting-an-llm-policy/):
> 
>   It's fine to use LLMs to answer questions, analyze, distill, refine,
>   check, suggest, review. But not to create. [...]
> 
>   Pre-arranged, non-critical, high-quality, well-tested, and well-
>   reviewed code changes that are originally created by an LLM are
>   allowed, with disclosure.

I find the Rust policy quite interesting as it is more expansive beyond
just code contribution questions. In particular it specifically emphasizes
that collaboration is between humans.

  "No one except the author is required to read LLM output unless
   they choose to: LLM output isn't allowed in public docs, PR
   descriptions, or Github comments unless it's clearly marked;
   reviewers aren't required to look at LLM PRs if they don't want
   to."

At the same time I find the Rust policy there somewhat at odds with
itself. "reviewers aren't required to read LLM output" is nice in
theory, but at the same time explicitly allows them. This feels like
it splits the community in half. If you're working in a bug wrangler
role and don't want to read LLM output how do you practically keep
doing your bug wrangler job without leaving an ever increasing mountain
of bugs ignored ?

A while back we added the note to the bug template that contributors
are required to assert that they have analysed any AI output and
independently reproduced the findings. On the positive side we've
had had 100's of bugs/securit disclosures which openly admit they
come from an LLM, with a 1 sentence disclosure that the submitter
confirmed the output.

On the negative side, I'm increasingly of the opinion that a significant
subset of these acknowledgements are either lies or meaningless. I feel
like either the LLM is simply adding the boilerplate "I've reviewed
the LLM output" message itself, or the author has reviewed it but failed
to but what the LLM said was beyond their capabilities and so haven't
actually identified the that the LLM was simply wrong. This doesn't
feel easily solvable.

> I would replace "are originally created by an LLM" with "include substantial
> amounts of code written by an LLM" (maybe GCC's 15 line of code threshold?),
> but that's it.
> 
> I understand that this may not be a particularly popular position in the
> QEMU community, and that is completely different from what even I wrote last
> June.  But these two are new and recent developments, and it happens that I
> find them to strike the right middle ground.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


