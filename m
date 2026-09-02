Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF42C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nX5-0004j4-Qu; Wed, 02 Sep 2026 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1nX4-0004iu-SG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1nX0-0002b3-P1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788365385;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vF9J1uQMBAoSh05bacVbtBzz8u0feGoBKL70yKE81no=;
 b=aTqbhmZgAZ4uESW6RW8UyR4eBCd1PwCsmmMHlYkHq4Mstse6GZI+oTTwHYcLBS2qVON2df
 L+ojDvOBlciVIQzU8lfOX+BCjn2kL89cUf6Tjl+S6fBXHwp2tfxvqVHR2+kI9zq1HpL5bV
 q7LrBGX55FcY2VCVs4izAqcSAKbj4M0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-GNLg7-WyOSebn5CmdrIsSw-1; Wed,
 02 Sep 2026 12:09:39 -0400
X-MC-Unique: GNLg7-WyOSebn5CmdrIsSw-1
X-Mimecast-MFC-AGG-ID: GNLg7-WyOSebn5CmdrIsSw_1788365378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9EF319539AC; Wed,  2 Sep 2026 16:09:37 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D214F1955F02; Wed,  2 Sep 2026 16:09:33 +0000 (UTC)
Date: Wed, 2 Sep 2026 17:09:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
Message-ID: <aphKOs7k92Pue40q@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901161422.314581-2-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Tue, Sep 01, 2026 at 06:14:19PM +0200, Paolo Bonzini wrote:
> On top of this, several maintainers have pointed out that contributions
> that can be reasonably suspected to be AI-assisted or more have been
> posted and included.

I tend to view this problem as a consequence of our failure to provide
an AGENTS.md file describing our policy, rather than fully attributed
to the policy itself being wrong.  We were naive in thinking that a
page buried in our docs was sufficient to make people & and agents
aware of our policy.

>                        Some of these contributions are actually of very
> high quality; it seems that the mailing list-based contribution process
> has mostly protected QEMU from low quality patches.  A prohibition on
> AI puts maintainers in a difficult position: on one hand the DCO process
> lets them rely on the submitter's certification of origin, on the other
> hand maintainers are supposed to know and implement the process policies.

One area I've felt is awkward with the AI policy (vs other policies
maintainers enforce) is that when maintainers raise the question of AI
usage, we're effectively critiquing the actions & behaviour of the
contributor during development, rather than critiquing the content of
submission itself.

It leads us to be distrustful of contributors, and is a dynamic that
risks becoming quite unpleasant for all involved.

It was/is less difficult when AI generated code was clearly slop as
we knew the answer to "was this done by AI" was "yes" ahead of time.
When code submissions are higher quality, the answer to "was this
done by AI" is a game of roulette and will come across badly.

We need to strivee to keep maintainers out of the policing job, 
avoiding the need to actively question the behaviour of contributors
and get back to focusing on the content. The introduction of AGENTS.md
file is definitely key and fixes the failing of our existing policy
implementation.

> Since the policy has been written, other projects have discussed and
> taken their stance on AI contributions.  These vary from full prohibition
> (though typically motivated by social reasons rather than legal, e.g.
> for Zig) to limited use (e.g. GCC, allowing small contributions and
> tests to use AI), to cautious experimentation.
> 
> This proposed policy seeks to implement the cautious experimentation
> approach, inspired mostly by the Rust project's policy and by Software
> Freedom Conservancy's own recommendations on LLMs and generative AI.

IMHO the "cautious experimentation" phrasing is effectively
marketing words for a policy that is "AI for anything".

The main distinguishing feature there is that we're asking
contributors not to drown us in AI generated code without
prior discussion.


The "limited use" scenario from GCC is meaningfully different
as it is attempting to limit the legal liability by restricting
the scope of work to things that are unlikely to meet the
threshold for copyright / licensing / legal concerns.

> Conservancy in particular provides this point to alleviate the concern
> that motivated the policy, about whether the submitter has the legal
> right to contribute the code and about unintentional reproduction of
> copyrighted code:
> 
>    "Copyleft Everything" remains the best viable and safest approach
>    Certainly those who want to release FOSS under non-copyleft licenses
>    have more to worry about when using these tools.

I'm trying to understand the rationale behind that statement,
and found that part of their recommendations very weak.

My best interpretation is that it is trying to give reassurance
that if the AI output were to be deemed a derived work of part
of the training material, then projects are safer if they are
Copyleft.

At a simplistic level if the training material were a mix of only
GPLv2 and BSD code, then if an agent contributed to a GPLv2 project
then it is ok even if deemed a derived work, but not OK if the
agent contributed to a BSD project.

That rationalization only works if the set of training material
licenses forms a linear progression of restrictions with copyleft
(GPL) at one end. The real training materials is such a jumble
of licenses that there's no "root" and there are a huge set of
copyleft variants.

Even the GPL has plain GPL vs LGPL vs AGPL, and v2-only vs
v2-or-later vs v3-only. Even before the days of AI this was
a compliance minefield when sharing code between projects
under different variants, and QEMU has long suffered the
GPL-v2-only restriction from some of our pieces and the
complexity it adds when refactoring & keeping track of
code licenses.

> Therefore, the revised policy considers QEMU's copyleft to be a viable
> approach to any unanswered legal questions about AI-generated
> contributions and their copyright status.

Copyleft is desirable for very many reasons, but I'm struggling
to see that recommendations eliminates any legal questions about
AI contributions, as compared to other licenses.


> In that respect, the Rust project's policy combines two unusual ideas.
> One is to hold them to a higher standard, in the spirit of using AI to
> work "better, not faster"; the other is to require "pre-arrangement" for
> "changes that are originally created by an LLM".  AI lowers the cost of
> producing a patch but does nothing to lower the cost of understanding
> and reviewing one; if anything it raises it, since a reviewer can
> no longer assume that the submitter has reasoned through every line.
> Pre-arrangement is an attempt to balance the shift of effort from the
> developer to the maintainer, and the QEMU policy includes the same
> provision.

My concern with "pre-arrangement" is how we end up applying the
rule in practice and whether the community dynamics that result
from that are positive or negative ?

My own historical experiences with communities or processes where
contributions requires pre-arrangement or scheduling were really
quite negative. It frequently kills opportunistic or spontaneous
work, and can result in a closed club which is hard to newcomers
to break into.

At the same time, QEMU has a long standing capacity problem
before AI arrived, which leads to frequent disappointment with
contributions languishing without review. The various schduling
efforts some projects have adopted are an effort to give
contributors some predictability, like they would have in a
traditional closed source, top down managed software project.
That just doesn't feel like the typical spirit of OSS to me.


I also conceptually dislike a policy which will lead to a situation
where different rules will apply to different subsystems, depending
on the preferences of individual maintainers. Work is also not
always  easily contained to subsystems, prerequisite refactoring
can quickly spread it tentacles out.

Consider hypothetically a net subsystem maintainer agrees to
use of AI for generating a large piece of code, and something in
that work requires a change to QOM or QDev or QAPI. This quickly
ends up exposing multiple other maintainers to TODO items from
the AI generated contribution. 

So again, IMHO, "cautious experimentation" with "pre-arrangement"
is effectively "AI for anything" and all maintainers exposed to
varying levels, but contributors need to get into a club first.

> Revise the policy according to the above considerations, and introduce the
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is for
> the metadata to provide more information for reviewers to judge the result.
> 
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.

When agents output are involved the DCO just rubber stamp exercise,
as there's no practical way any contributor can understand whether
there are legal concerns with the code the agent spat out unless it
is so short as to not meet the threshold for copyright.

If that is going to be our interpretation of the DCO lets be explicit
about that, rather than pretending it is a meaningful statement for
the AI authored components.

> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project limits the way
> +in which use of the output of generative AI can be included
> +in contributions to QEMU.

I don't think the policy is mitigating the legal risk. Rather it
is accepting that few people seem to care about the legal risks
anymore, in favour of supposed "efficiency" wins.

Practically this is just trying to limit who can use AI, by
requiring them to ask permission first.

> +Prohibited use of AI
> +''''''''''''''''''''
> +
> +The following items **MUST** be written by humans:

This is enumerating three concrete examples, of a more
general concept of "The QEMU community is a collaboration
between humans".  IOW, we don't want AITM (AI In The Middle)
for our communications. Can we say this explicitly

"The QEMU community is a collaboration between humans
 and thus communications must NOT be directed through
 an AI agents facade. This implies that the following
 items MUST be written by humans:"

> +
> +- cover letters and commit messages
> +
> +- responses to reviewer comments
> +
> +- issue descriptions or comments
> +
> +Light copy editing of human-written text with an AI is allowed.
> +
> +Repeated violations of this rule may be treated as a :ref:`code_of_conduct`
> +violation.
> +
> +An exception is made for issues for defects detected by specialized
> +tooling, including fuzzers and LLM-assisted defect detection. Such issues
> +must be reviewed by a human before creation, must be created by a human
> +and communication with maintainers must be done by a human, but including
> +the verbatim tool output in the issue description is explicitly allowed.

This exception is likely inescapable, but it is also effectively a
backdoor that exposes all maintainers to AI output in their INBOX.

The requirement for "human verifications" may mitigate the worst
excesses, but the limitations of that rule are very apparent when
reading the AI assisted bug reports. The contributor may have done
a sanity-check but you're still wading through reports many pages
long, and especially the generated qtests can rarely be explained
by the contributors.

> +- use of LLMs to help generating parts of a larger patch---a test case, a
> +  parser, boilerplate code for a new API, a tool to help performing
> +  mechanical changes, etc. These are generally allowed, but disclosure
> +  is recommended.

I don't think disclosure should be optional here, most especially for
tests cases it needs to be mandatory IMHO.


> +Commit messages for AI-assisted changes
> +'''''''''''''''''''''''''''''''''''''''
> +
> +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
> +line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
> +satisfies your disclosure obligations and is also a guide to reviewers.  The
> +text is one or more of ``code``, ``tests``, ``docs``, ``analysis``, possibly
> +followed by an explanation in parentheses:
> +
> +.. code-block:: none
> +
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: analysis
> +
> +``AI-used-for`` should not be included for "background" usage such as
> +autocomplete or obtaining a pre-review of the patch.  It can be included
> +however even if not required by the policy.
> +
> +There is no requirement to include your prompts or summarize the
> +conversation in the commit message or cover letter.

I would be stronger and say we explicitly do NOT want the prompts
or conversation history. If there was info in the prompts that is
relevant to the reviewer, then include that info as natural language
in the commit message, not a cut+paste of the prompts.

> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
> +trailers to indicate AI usage.  In particular, it is not necessary to
> +specify the exact AI model or tool used to create the commit.

This says they're not required, but also doesn't forbid them,
which leaves rather a gray zone. If we don't want to require
them (which I think is correct, as this is just free advertizing
for largely commercial tools), then IMHO its preferable to make
checkpatch.pl explicitly reject them.

> +There is not a consensus within the QEMU project---and likely never will
> +be---about when/how/where it is acceptable to use AI-based tools.  Many
> +members of the QEMU project and community find value in AI; many others
> +feel that its negative impact on society and the climate are severe enough
> +that no use is acceptable.  Still others are working out their opinion.
> +
> +In accordance with Software Freedom Conservancy's recommendations:
> +
> +- the project seeks to both support those contributors who outright reject
> +  generative AI systems, and to not shun those who choose to use them;
> +
> +- we consider QEMU's copyleft to be a viable approach to the unanswered
> +  legal questions about AI-generated contributions and their copyright
> +  status;

This (and SFC's recommendations) comes across as trying to
square-the-circle.

Effectively the policy is saying that we have no choice but to accept
them, despite reservations people might have (legal or social or
environmental), as they've become too commonplace in the industry to
decline.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


