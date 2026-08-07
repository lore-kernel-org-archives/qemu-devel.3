Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC81C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsPWj-000703-3d; Fri, 07 Aug 2026 14:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsPWh-0006ze-MD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 14:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsPWe-0007Zm-O7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 14:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786128155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EKgH6I3op1Q7s1asWU1DGMgzgZDakdAdxnYnJYdkCm4=;
 b=HAeZg5TKVDLdpAXnnTpZcTd97x4Z+uZZokaBmWWS//onB5X3TNcVRKVIhJ5UE9rSCFa3Yy
 HEOABmlbm4ajxhkx3cgw+te6t8IcXBgjFT4zVL03eKY572gXHbXxsp+v+Ts1h1Uw5rzLPG
 XPqEt34876Unn1N6ZdSUB5RSrL+uczA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-a5vr7TBxN-2BL_HdoZjYpA-1; Fri,
 07 Aug 2026 14:42:27 -0400
X-MC-Unique: a5vr7TBxN-2BL_HdoZjYpA-1
X-Mimecast-MFC-AGG-ID: a5vr7TBxN-2BL_HdoZjYpA_1786128145
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FAF91955F7A; Fri,  7 Aug 2026 18:42:25 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71E201800347; Fri,  7 Aug 2026 18:42:19 +0000 (UTC)
Message-ID: <be6325a1-8a4f-4ecf-8045-a56ec66dcd42@redhat.com>
Date: Fri, 7 Aug 2026 20:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: GCC, Conservancy and Rust AI documents (was Re: [PATCH v2]
 docs/devel: relax policy on AI-generated contributions)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
 <anXuqbBXERqn4lPu@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <anXuqbBXERqn4lPu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/7/26 16:41, Daniel P. Berrangé wrote:
> None the less that is an interesting benchmark.
> 
> A key challenge we've always had in these discussions is how
> to draw a line on what "legally signicant" means in practice.
> 
> The fact that the GNU project has used the "15 lines" rule
> for copyright assignment is quite a useful benchmark to take
> in to account precisely because they've used that for years
> (presumably decades?).

True, but it's only superficially the same that they've used.  The GNU 
"15 lines rule", as defined at 
https://www.gnu.org/prep/maintain/html_node/Legally-Significant.html, is 
that "what counts is the total contribution of the person; it is 
irrelevant which parts of it were contributed when"; whereas the GCC AI 
policy treats each contribution from LLMs as independent.

Presumably this is because they consider the likelihood of copyright 
infringement to be independent across LLM outputs, but it's nevertheless 
a different rule.  If so, their reasoning is similar to the one 
discussed earlier in the thread, and they simply picked the same 
threshold that was already in place.

> IME, it is by writing docs for a feature, that you come to learn about
> the flaws / gaps in the thing that is implemented, which feeds back to
> improve the code.  Generating docs you're just going get text that
> reflects the state of the code without the learning & improvement
> experiance.
> 
> I don't think we should have an exception for tests either. If we
> have code in the tests directory that is generalized to become
> part of the broader codebase, we shouldn't have to think about the
> history of whether the tests code was AI generated.

No one is going to agree 100% with everyone else; the only possible 
equilibrium is going to be the current "no AI for code generation" 
policy.  The problem with it is that it is hard both to comply with and 
to enforce.  Contribution to a community is based on some kind of honor 
system, but the reality of LLM operation makes it very hard to use them 
even for tasks that are considered acceptable.  In that sense, the 
policy hinders the honor system instead of helping it.

For example, our policy says that you can use AI for review.  You get a 
review like this (it's Linux but you get the idea):

    kvm_put_kvm() now runs under sev_mirror_lock.  The put is inside the
    critical section [...] If that's the last reference it drags all of
    kvm_destroy_vm() under the mutex.  It's easy to keep it a leaf:

	mutex_lock(&sev_mirror_lock);
	sev->enc_context_owner = NULL;
	mutex_unlock(&sev_mirror_lock);
	kvm_put_kvm(owner_kvm);

    Should I apply the change?

Am I supposed to say no and swap the last two lines myself?  This case 
is probably fine, but where do I draw the line?

In other cases, during review the LLM will sometimes write testcases 
even without asking.  Recently, one model came up with this 
exponential-time testcase while I was trying to understand some Meson code:

    project('t', 'c')
    pkg = import('pkgconfig')
    l0 = static_library('l0', 'x.c', install: true)
    l1 = static_library('l1', 'x.c', link_with: l0, install: true)
    l2 = static_library('l2', 'x.c', link_with: [l1, l0], install: true)
    l3 = static_library('l3', 'x.c', link_with: [l2, l1], install: true)
    l4 = static_library('l4', 'x.c', link_with: [l3, l2], install: true)
    l5 = static_library('l5', 'x.c', link_with: [l4, l3], install: true)
    # ...
    pkg.generate(l22, filebase: 'top')

If I decide that this is a good regression test, how do I (in the 
context of a policy like QEMU's) even rewrite a testcase like this for 
inclusion?  Do I have to rewrite it as a loop:

    project('t', 'c')
    pkg = import('pkgconfig')
    a = static_library('l0', 'x.c', install: true)
    b = static_library('l1', 'x.c', link_with: a, install: true)
    foreach i : range(2, 23)
      t = a
      a = b
      b = static_library(f'l@i@', 'x.c', link_with: [t,a], install: true)
    endforeach
    pkg.generate(b, filebase: 'top')

?  Is this actually an improvement?  Maybe in a test the repetitive text 
is actually clearer.  If I decide the loop shape is worse, or in cases 
where there simply isn't another way to write it, the current policy 
doesn't even let me be honest.

"Use it only for study or review" is a fig leaf.  We *won't* be able to 
catch all AI contributions, whether to code, tests or documentation.  A 
no-agents/no-copy-and-paste policy is clearly enforceable because the 
LLMs' (unbearable) mannerisms jump out instantly.  But if we're talking 
about AI code written by someone who already knows what they want to 
get, who knows the surroundings and has a design in their mind that 
informs the discussion with the LLM, the result is practically (or 
completely) indistinguishable from human-written code; the requirement 
to split the change into logically independent patches alone imposes a 
large amount of human-like structure.

So, the no-AI policy is an equilibrium only because it's stable, not 
because it's good.  I would like to point out two recently released 
documents, one more philosophical and one more practical, hoping that 
this can help finding an alternative.

The first is Conservancy's own recommendations for generative AI 
(https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html). 
  While I believe we wouldn't follow all of them (for example the 
recommendation to treat chat logs as artifacts to be conserved is not 
practical), there are some useful points to consider, with respect to 
the copyright infringement risks that drove the current policy and to 
the general recommended attitude on both ends:

   The FOSS community should support, not just tolerate, those who
   outright reject LLM-gen-AI systems.  [...]  FOSS projects should not
   shun contributors who choose to use LLM-gen-AI systems.

   Before submission, FOSS Contributors must invest substantial time
   reviewing LLM-gen-AI -assisted and/or -generated contributions.

   “Copyleft Everything” remains the best viable and safest approach
   Certainly those who want to release FOSS under non-copyleft licenses
   have more to worry about when using these tools.  [...]

   When LLM-gen-AI systems (including proprietary ones) can massively
   accelerate FOSS improvements, use of such tools is an appropriate
   strategic compromise [...]

Second, the Rust project came up with a different way to approach the 
issue: require disclosure of LLM-assisted changes and hold them to a 
higher bar.  The policy is summarized as follows 
(https://blog.rust-lang.org/inside-rust/2026/08/05/rust-langrust-is-adopting-an-llm-policy/):

   It's fine to use LLMs to answer questions, analyze, distill, refine,
   check, suggest, review. But not to create. [...]

   Pre-arranged, non-critical, high-quality, well-tested, and well-
   reviewed code changes that are originally created by an LLM are
   allowed, with disclosure.

I would replace "are originally created by an LLM" with "include 
substantial amounts of code written by an LLM" (maybe GCC's 15 line of 
code threshold?), but that's it.

I understand that this may not be a particularly popular position in the 
QEMU community, and that is completely different from what even I wrote 
last June.  But these two are new and recent developments, and it 
happens that I find them to strike the right middle ground.

Thanks,

Paolo


