Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0873AC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x21aL-0000nY-AM; Thu, 03 Sep 2026 03:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x21aB-0000mQ-IW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x21a9-0007P4-D1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788419396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5qBa+u9cL4HtOS5Mn5qWyz+1I8/RGdQ7Z/pRHastVGE=;
 b=b/pLcijUsAMoVmCXEA+xj5csSHHZ+OzgjWYLE3UMNhYI364rmCQWn5GoFwEfXauDWOuRUD
 EPOO4u2PgZoITiFOm+iZ3j8l6PQ+BsbICQkcixCFf232y9AuS1Beiu/QpxnJ1X/wfboWFp
 OwGgqRy2d0Hf8t9CfdKqRXNa8vdiXFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-VM1vgb9JObqlzL24d1MSQg-1; Thu,
 03 Sep 2026 03:09:52 -0400
X-MC-Unique: VM1vgb9JObqlzL24d1MSQg-1
X-Mimecast-MFC-AGG-ID: VM1vgb9JObqlzL24d1MSQg_1788419391
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B588B180256B; Thu,  3 Sep 2026 07:09:50 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1473B3001D37; Thu,  3 Sep 2026 07:09:45 +0000 (UTC)
Message-ID: <0ea7449e-e7fb-4bd4-b1e7-d379161124e6@redhat.com>
Date: Thu, 3 Sep 2026 09:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <bonzini@gnu.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
 <CAFEAcA8Scb5DzNANczkrg72z8maWy+hAAkNEv-d0c=V2rOLK6Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8Scb5DzNANczkrg72z8maWy+hAAkNEv-d0c=V2rOLK6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/2/26 14:01, Peter Maydell wrote:
> A contributor
> who was unaware of or chose to deliberately ignore our existing
> AI policy is just as likely to be unaware of or to ignore an updated
> policy that says "yes, but only with limitations and must be
> pre-arranged for larger amounts of generated code".

Oh, they won't be unaware of it. :)  That's why I included the 
AGENTS.md, even though it's technically separate.  They'll be reminded 
every two minutes of the need to pre-arrange review, until they tell the 
LLM to shut up.

> (A contributor who deliberately ignores the policy is I hope going to
> be rare; contributors who are simply unaware of it are something that
> we can hopefully improve on by (a) having an AGENTS.md that will tell
> their LLM about it and (b) asking in case of doubt on the maintainer
> side.)

Exactly.  Also, we have contributors who are unware of it now and we 
live with it or look at it on a case-by-case basis.  People ignoring the 
policy will be the same.

> I think fundamentally my issue here is that to me it doesn't seem
> like the project has problems with "we aren't writing code fast
> enough"; the problems are more "we don't have enough code review",
> "our existing code is getting holes poked in it by automated
> bug finding" and "we have too much old code that's barely used and
> unmaintained". So an AI policy update whose major move is "allow
> more generated code" feels bad to me, because it's inevitably
> going to increase the workload on reviewers and maintainers.
> I would be much happier seeing more use of AI in the project to
> help us where we're struggling.

I agree.  The hope is to get a bit of that via better testing, and that 
"we aren't writing code fast enough" is applied to stuff that helps long 
term rather than to the itch of the day.  Whether it works or not it 
remains to be seen.

I certainly don't want an explosion of new device models and 
unreviewable qtests.

> The question I had with the Rust policy was to what extent their
> "experimentation" is actually going to be cautious experimentation,
> and how much it turns out to be "this is a back door that lets the
> people who want to write and review LLM-generated code do that anyway
> as long as the people who don't want to can mostly ignore it".
> 
> If this is really experimental then we should have some clear
> boundaries and criteria for our experimentation, covering for
> instance
> (a) when do we assess the success or failure of the experiment?
> (b) what are we looking at to decide success/failure?
> (c) what are our boundaries for what kinds of change we're willing
>      to make under this experiment and what we are not?
> (d) what is our plan for rolling back or otherwise recovering if
>      the experiment seems to have failed?

I agree these are good questions.  They don't have obvious answers but 
as a start:

(a) a year was more or less the distance between the old policy and the 
time when we started noticing AI work on the mailing list, so probably 
another 8-12 months?  Such as from November's QEMU Summit to the one in 
Sep-Nov 2027?

(b) Having to abort the experiment in advance is the obvious failure 
mode.  Everything goes unnoticed is success.  I would say that pervasive 
discussions on boundaries would be pretty bad too.  Success/failure may 
also be split across categories, say by forbidding the bugfix category.

(c) no idea.  The concept of pre-arrangement leaves this to individual 
maintainers.  As Daniel points out "different rules for different 
subsystems" is not a good thing in principle, but in the end there is 
already a large subjective element in what maintainers are willing to 
review and even from whom.

(d) worst case we could simply revert the policy, at least in effects 
though probably not in language.

I'll add (e) what are our boundaries for AI patches covering multiple 
maintainers?  The extreme case is Alex's "make QOM parenting mandatory" 
series 
(https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon.com/), 
but it's actually not the hardest---apart from being done with AI, we 
had similarly large changes in the past such as the Meson switch and 
qdev_new() refactoring.  In those cases a pre-arrangement was needed 
anyway with the community, more than with a specific sets of maintainers.

> The Rust policy makes some attempts at some of these e.g. with its
> "circuit breaker" provision and the requirement that LLM changes are
> "non-critical" ones.

I didn't include a "circuit breaker" because someone would have to 
implement it, but also because I don't expect any maintainer to be so 
eager as to flood QEMU with AI-generated work.  And we're a much smaller 
community so I hope we would be able to sort it out among ourselves.

>> +LLM-assisted and LLM-created contributions
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Use of generative AI tools for code contributions generally falls into
>> +four buckets:
>> +
>> +- "background" assistance
>> +- small LLM-assisted bugfixes
>> +- use of LLMs to help generating parts of a larger patch
> 
> I guess I'm generally OK with these (though I might add an "If in doubt
> about whether your use here is too extensive, ask" to the last one:
> "a parser" is potentially a pretty big thing to be delegating to the LLM,
> for instance, and might either be "mostly boilerplate" or to shade over
> into the "writing large parts of functional code" category).

Sure I can remove the parser example.  The initial one I had was 
"switching to a new API".  That is more representative of the intent it 
would basically put Alex's 137 patch series almost entirely under this 
section and I didn't want to do that.

I can report that the LLM was very reluctant to let me use this third 
category, and even less to let me do it without "AI-used-for".  Even for 
a one-line change to a "#define" in a 1000-line patch, it insisted that 
perhaps I should have included the trailer.  The AGENTS.md makes it very 
meticulous. :)

> I do note that even for "small bugfixes below 10 lines of code" the
> code review effort can still be pretty huge where it's touching something
> like a device model, where you have to go and find the right datasheet
> or spec and confirm whether the proposed change is really the right one
> or if it just fixes whatever the assert/crash was but in the wrong way.
> [...] Having a hundred "fix minor bug in old code" patches on the list that
> are unreviewed isn't a lot better than having a hundred issues in the
> bug tracker (indeed, it's arguably worse, since we have no tracking
> system for patches on the mailing list; at least the issues won't just
> get lost in the deluge...)

Yes, and especially when we have them submitted to "Odd fixes" areas the 
risk of maintainer DDOS is there.  But if people start submitting too 
much you *can* tell them according to the policy that you need them to 
develop e.g. a test suite.  Which yes, will *also* be more work to 
review for maintainers, but probably something that was sorely needed.

The hope is that by not placing AI-generated code in a "don't ask, don't 
tell" area we actually have tools to push back and reach an equilibrium 
that is better for the project and for the maintainers.  How it will 
work, it remains to be seen.

> I'm also more willing to allow leeway and to trust the judgement on
> LLM use for somebody who is already a regular contributor to the
> project (and so has some idea of how the codebase works and better
> ability to spot when generated code has gone off in the wrong
> direction), versus patches from somebody who hasn't contributed
> before. Is that something we want to try to encode in policy
> (e.g. with limitations on the "pre-arranged larger contribution"
> case) ?
Pre-arrangement does not mean you're forced to say yes.  Saying "I've 
never done this and I don't want to give you false hopes, so I'll 
decline" is fine.

Paolo


