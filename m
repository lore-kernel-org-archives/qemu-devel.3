Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21899C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24KQ-0002SA-FX; Thu, 03 Sep 2026 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24KN-0002Rh-SU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24KL-0008GT-JM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788429948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cSWIy3H/p8HRM70uBEDytr3YlP0yQAe+Giov/6l9Njg=;
 b=gvTD4RUBn5t6N8y9TMo++7aMaVADJDyIgVNhmx7TqobrXE4R47GM2haJMlPVY1oxK6ZGNc
 xdj+eWZ+XfklQQDZNyrpf2AbpVUi2sN4GAR01QwEz3MjPw1/FGFKlYzEkJbv1We1pODyNp
 98vWin8v8F1QTL7hTy6MidKYjwxoJL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-qKcabEk6OTmUHerf8XOukA-1; Thu,
 03 Sep 2026 06:05:45 -0400
X-MC-Unique: qKcabEk6OTmUHerf8XOukA-1
X-Mimecast-MFC-AGG-ID: qKcabEk6OTmUHerf8XOukA_1788429944
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89705190FFA7; Thu,  3 Sep 2026 10:05:43 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47AF91955F0D; Thu,  3 Sep 2026 10:05:39 +0000 (UTC)
Message-ID: <67db7357-c1b9-4391-9b03-fdcc1fbb257f@redhat.com>
Date: Thu, 3 Sep 2026 12:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <bonzini@gnu.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com> <aphKOs7k92Pue40q@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aphKOs7k92Pue40q@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/2/26 18:09, Daniel P. Berrangé wrote:
> On Tue, Sep 01, 2026 at 06:14:19PM +0200, Paolo Bonzini wrote:
>> On top of this, several maintainers have pointed out that contributions
>> that can be reasonably suspected to be AI-assisted or more have been
>> posted and included.
> 
> I tend to view this problem as a consequence of our failure to provide
> an AGENTS.md file describing our policy, rather than fully attributed
> to the policy itself being wrong.  We were naive in thinking that a
> page buried in our docs was sufficient to make people & and agents
> aware of our policy.

It is also giving a measure of what people find AI to be useful for, in 
the context of QEMU.  Certainly an underestimation of how much they 
would use it if the policy was changed, but it's something.

>> Since the policy has been written, other projects have discussed and
>> taken their stance on AI contributions.  These vary from full prohibition
>> (though typically motivated by social reasons rather than legal, e.g.
>> for Zig) to limited use (e.g. GCC, allowing small contributions and
>> tests to use AI), to cautious experimentation.
>>
>> This proposed policy seeks to implement the cautious experimentation
>> approach, inspired mostly by the Rust project's policy and by Software
>> Freedom Conservancy's own recommendations on LLMs and generative AI.
> 
> IMHO the "cautious experimentation" phrasing is effectively
> marketing words for a policy that is "AI for anything".

I don't think it is.  Any policy builds on trust of the maintainers, and 
we know the community is not going to vibe code a rewrite of QEMU in Rust.

There are multiple axes, and this policy+AGENTS.md combo is not the most 
liberal on any axis.  For example GStreamer has a stricter AGENTS.md but 
basically no policy; that's more "AI for anything" than this proposal is.

Yes, it's intentionally leaving out any legal risks unlike the GCC 
policy.  I'm trusting Conservancy on that - they do not just have 
lawyers, they are in some sense "our" lawyers and I don't think they 
wrote their recommendations lightly.

> The "limited use" scenario from GCC is meaningfully different
> as it is attempting to limit the legal liability by restricting
> the scope of work to things that are unlikely to meet the
> threshold for copyright / licensing / legal concerns.

>> Conservancy in particular provides this point to alleviate the concern
>> that motivated the policy, about whether the submitter has the legal
>> right to contribute the code and about unintentional reproduction of
>> copyrighted code:
>>
>>     "Copyleft Everything" remains the best viable and safest approach
>>     Certainly those who want to release FOSS under non-copyleft licenses
>>     have more to worry about when using these tools.
> 
> My best interpretation is that it is trying to give reassurance
> that if the AI output were to be deemed a derived work of part
> of the training material, then projects are safer if they are
> Copyleft. [...]
> 
> That rationalization only works if the set of training material
> licenses forms a linear progression of restrictions with copyleft
> (GPL) at one end. The real training materials is such a jumble
> of licenses that there's no "root" and there are a huge set of
> copyleft variants. [...] Even the GPL has plain GPL vs LGPL vs
> AGPL, and v2-only vs v2-or-later vs v3-only. Even before the
> days of AI this was a compliance minefield

"Most viable and safest" is certainly not a 100% guarantee.  IANAL but 
what you want is the legal equivalent of the swiss cheese model where 
copyleft is only one of several mitigating factors.  These include the 
fact that there are a lot of QEMU forks in training materials, as you 
pointed out when discussing mechanical changes; the AGENTS.md 
instructions to involve the user in the design; "de minimis" and fair 
use exceptions (you probably don't want to get there but they exist); 
and so on.

> My concern with "pre-arrangement" is how we end up applying the
> rule in practice and whether the community dynamics that result
> from that are positive or negative ?
> 
> My own historical experiences with communities or processes where
> contributions requires pre-arrangement or scheduling were really
> quite negative. It frequently kills opportunistic or spontaneous
> work, and can result in a closed club which is hard to newcomers
> to break into.

I don't think putting pre-arrangement in an AI policy is saying anything 
new, it only makes it explicit in the area of highest risk.

Personal example: I did feel bad for including *my* implementation of 
AVX over the previous two, just because my employer didn't need one at a 
time and the review effort would have been massive (higher than writing 
my own when Red Hat did want one).

Pre-arrangement would have helped, and *now* I could say "hey, ask the 
AI to sketch a new x86 decoder with this and this characteristic, and 
let's see where that takes us".

Now *I* wouldn't use AI today to rewrite the x86 decoder either, but 
pre-arrangement can change not just the balance but also the dynamic 
between maintainer and contributor.  Maintainers have *a lot* more power 
to ask for changes if the effort to do them is comparably lower. 
Ideally that filters for AI users that are curious and interested in 
learning the underlying choices.

Of course, maybe I am wrong.

> I also conceptually dislike a policy which will lead to a situation
> where different rules will apply to different subsystems, depending
> on the preferences of individual maintainers. Work is also not
> always easily contained to subsystems, prerequisite refactoring
> can quickly spread it tentacles out.
> 
> Consider hypothetically a net subsystem maintainer agrees to
> use of AI for generating a large piece of code, and something in
> that work requires a change to QOM or QDev or QAPI. This quickly
> ends up exposing multiple other maintainers to TODO items from
> the AI generated contribution.

Indeed, it's not hypothetical even - see my reply to Peter about Alex's 
qdev/QOM refactoring.  But those large cases have *already* been done 
with pre-arrangement and one maintainer vouching for them, so we have a 
precedent.

> So again, IMHO, "cautious experimentation" with "pre-arrangement"
> is effectively "AI for anything" and all maintainers exposed to
> varying levels, but contributors need to get into a club first.

It's a possible outcome, it's not the only one though (or if it is, the 
club already exists and does not even include all maintainers---which is 
a problem in and of itself).

>> In any case, use of AI does not relax any other contribution requirement:
>> authors still comply with the DCO and take responsibility for the whole
>> patch via Signed-off-by.
> 
> When agents output are involved the DCO just rubber stamp exercise,
> as there's no practical way any contributor can understand whether
> there are legal concerns with the code the agent spat out unless it
> is so short as to not meet the threshold for copyright.

It still acknowledges the fact that, for example, the person's employer 
does not forbid him for contributing to QEMU.  And while it's weaker, 
AI-user-for + Signed-off-by protects QEMU more than "don't ask, don't tell".

[I won't rehash the same arguments below; I understand why you made them 
in the context of both the cover letter and the actual text]

>> +The following items **MUST** be written by humans:
> 
> This is enumerating three concrete examples, of a more
> general concept of "The QEMU community is a collaboration
> between humans".  IOW, we don't want AITM (AI In The Middle)
> for our communications. Can we say this explicitly
> 
> "The QEMU community is a collaboration between humans
>   and thus communications must NOT be directed through
>   an AI agents facade. This implies that the following
>   items MUST be written by humans:"

Sure.

>> +- use of LLMs to help generating parts of a larger patch---a test case, a
>> +  parser, boilerplate code for a new API, a tool to help performing
>> +  mechanical changes, etc. These are generally allowed, but disclosure
>> +  is recommended.
> 
> I don't think disclosure should be optional here, most especially for
> tests cases it needs to be mandatory IMHO.

What about "disclosure is highly recommended for non-trivial, functional 
code"?  The idea here was to avoid lowering the AI-used-for SNR and avoid

AI-used-for: code (turning CSV data into an array)

>> +There is no requirement to include your prompts or summarize the
>> +conversation in the commit message or cover letter.
> 
> I would be stronger and say we explicitly do NOT want the prompts
> or conversation history. If there was info in the prompts that is
> relevant to the reviewer, then include that info as natural language
> in the commit message, not a cut+paste of the prompts.
> 
>> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
>> +trailers to indicate AI usage.  In particular, it is not necessary to
>> +specify the exact AI model or tool used to create the commit.
> 
> This says they're not required, but also doesn't forbid them,
> which leaves rather a gray zone. If we don't want to require
> them (which I think is correct, as this is just free advertizing
> for largely commercial tools), then IMHO its preferable to make
> checkpatch.pl explicitly reject them.

Sure.

> This (and SFC's recommendations) comes across as trying to
> square-the-circle.
> 
> Effectively the policy is saying that we have no choice but to accept
> them, despite reservations people might have (legal or social or
> environmental), as they've become too commonplace in the industry to
> decline.
I think this is a bit oversimplifying, but I can't deny that there's a 
kernel of truth in there.

Paolo


