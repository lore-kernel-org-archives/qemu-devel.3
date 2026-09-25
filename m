Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EF6C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA41L-0002C5-OM; Fri, 25 Sep 2026 07:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA41A-0002AK-6c
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 07:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA417-00055k-BU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 07:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790335380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14afMoM0V2Ub5/LaLgZg2Y9baDvvgAjAk7yLzjmc5eQ=;
 b=JuvtP+5ApkVv5YyVXm6ACIMJ8e8Z06JpUozsXn7mV6Zz4m73Z5Gs9ye2cY7poTAJ6MO2tG
 BklNx8+xOh97pZRmZnf1uyhIDaOQaci4hPg+rnuHpJeIFauxRPjF/4csiaVOa+O4kcW0rq
 jZ5mn0bx9tcJumU2x6YWKRZH/iwLT/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-Ie9dvm5EMHKk70SRypc33g-1; Fri,
 25 Sep 2026 07:22:54 -0400
X-MC-Unique: Ie9dvm5EMHKk70SRypc33g-1
X-Mimecast-MFC-AGG-ID: Ie9dvm5EMHKk70SRypc33g_1790335373
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3D6E1944DD9; Fri, 25 Sep 2026 11:22:52 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0C8433; Fri, 25 Sep 2026 11:22:49 +0000 (UTC)
Date: Fri, 25 Sep 2026 12:22:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <arZZhpR5_nPybOUo@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <arUJxE0F7Q3Cw5sk@redhat.com> <arZHWKAgr-GYvoeX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arZHWKAgr-GYvoeX@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 25, 2026 at 12:05:12PM +0200, Kevin Wolf wrote:
> Am 24.09.2026 um 13:30 hat Daniel P. Berrangé geschrieben:
> > On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > > Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > > 
> > > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > > > >> > +          with all other requirements for contribution.**  In particular,
> > > > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > > >> > +          that the author takes responsibility for the entire contents of
> > > > >> > +          the patch, certifying that their patch submission is made in
> > > > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > > >> > +          Origin (DCO) <dco>`.
> > > > >> > +
> > > > >> > +          Since a submitter cannot audit LLM output against its training
> > > > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > > >> > +          that the contributor has the legal right to submit code in general.
> > > > >> 
> > > > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > > > >> the DCO. That first sentence in particular is somewhat saying that the
> > > > >> contributor does not have to think about plagarism and thed project is ok
> > > > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > > > >> This is both not OK in its implication of the project accepting some
> > > > >> liability, and then also contradicted by the next sentence.
> > > > >> 
> > > > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > > > >> states the DCO applies to the submission as a whole, and leaves all liability
> > > > >> for infringement on the contributor.
> > > > >
> > > > > I don't think making this the individual contributor's problem is great.
> > > > > It's rather unfriendly towards contributors to expect them to certify
> > > > > something that we all know they can't honestly certify.
> > > > 
> > > > This is the current position with the DCO anyway. If the contributor has
> > > > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > > > realistically the only person that can make that judgement.
> > > 
> > > Yes, that's the current position with the DCO and the reasoning why we
> > > said LLM output is unacceptable in submissions.
> > > 
> > > The big difference is if I copy and pasted from Stack Overflow, I _know_
> > > that I did that. If the LLM effectively does it for me, I don't know
> > > that. The best I can do is check if I can find similar code elsewhere.
> > > 
> > > So while I can certify with 100% confidence that I didn't manually copy
> > > things for code that I wrote myself, I can't certify that code from
> > > other sources, including LLMs, isn't copied from elsewhere. I can only
> > > say that I didn't find any reason to suspect it's copied.
> > 
> > > > > Our current AI policy was built on the assertion that it's impossible to
> > > > > sign the DCO for AI output, and I think that's still right. A developer
> > > > > can't certify the origin of something when they don't really know where
> > > > > it comes from.
> > > > 
> > > > It's certainly possible for LLMs to replicate copyright material but by
> > > > far the biggest influence is the code *in the project* that shapes the
> > > > output. It is basically pattern matching and predicting after all.
> > > 
> > > If there is one chunk of code that violates the copyright of someone,
> > > you can't heal that just by having 1000 more chunks that are clean.
> > > 
> > > > What level of reassurance the submitter needs to be able to certify with
> > > > their DCO is up to them. We can't police it, like every other submission
> > > > we rely in the submitters good faith representation of what they have
> > > > done.
> > > 
> > > The DCO doesn't talk about levels of reassurance. It talks about hard
> > > facts, 100% confidence.
> > > 
> > > And that I can't give you with LLM generated content. I can maybe give
> > > you 99%, but never 100%.
> > 
> > I appreciate you're speaking about licensing/copyright here, but more
> > generally I think we're probably wrong in asserting that a human
> > authored contribution can ever be said to be 100% safe to QEMU with
> > a DCO signoff. It is risk mitigation, but not absolute.
> 
> Yes, and I don't think I'm claiming it can, quite the opposite. (Maybe
> Alex is with "we are insisting they are confident there is no legal risk
> in what they submit", though).
> 
> The difference is probably that you're looking at it from the project
> perspective and I'm looking at it from the contributor perspective.
> Would I be happy to sign the DCO for AI output? I would probably be
> fighting my conscience because I know that everyone (possibly including
> my manager) expects me to do that even with AI output, but at the same
> time I also can't certify something I don't know for a fact. That would
> be a quite unpleasant situation.
> 
> Our current policy is quite clear on this, and I seem to remember that
> it was even you who brought up the reasoning with "it's impossible to
> sign the DCO for AI output":
> 
>     To satisfy the DCO, the patch contributor has to fully understand
>     the copyright and license status of content they are contributing to
>     QEMU. With AI content generators, the copyright and license status
>     of the output is ill-defined with no generally accepted, settled
>     legal foundation.
> 
>     Where the training material is known, it is common for it to include
>     large volumes of material under restrictive licensing/copyright
>     terms. Even where the training material is all known to be under
>     open source licenses, it is likely to be under a variety of terms,
>     not all of which will be compatible with QEMU's licensing
>     requirements.
> 
>     How contributors could comply with DCO terms (b) or (c) for the
>     output of AI content generators commonly available today is unclear.
>     The QEMU project is not willing or able to accept the legal risks of
>     non-compliance.
> 
> What has changed so fundamentally (i.e. not just shifted in numbers)
> since then?
> 
> The commit message doesn't give any explanation. It says "but AI is so
> useful today", and I can agree with that. But it doesn't change anything
> about license status. If something is impossible, then that it would be
> useful doesn't somehow make it possible, and we shouldn't pretend that
> it does.
> 
> So either we need a reasoning why things have changed fundamentally (or
> why we now think our old reasoning has been wrong from the start) so
> that it's now okay to request contributors to sign the DCO for AI output
> when we previously officially asserted that this is impossible for them
> to do in good faith, or we need to have different standards than the DCO
> for AI output.

I would say that our original policy was intentionally simplistic
in declaring a strict ban on every use of AI, under the banner of
DCO compliance.

I would say our current policy does/should have wiggle room in it
for modest contributions that don't meet the threshold for code
to have meaningful copyright protection, either because the code
is trivial, or it is cloning a boilerplate design pattern, or
there is only one viable way to achieve the task.  We didn't get
into that nuance in the original policy, but we've discussed it
at the time, and on occassions since.

Then there's things like auto-completion, grammar/spelling help,
translation, and so on, which I also think are reasonable to use
LLM for and also reasonable to sign-off under DCO.


Wrt my message about the DCO being about risk mitigation, rather
than total risk elimination, I think there is scope for sign off
of some more significantly sized (but not unbounded) LLM based
contributions. I don't know how to express that as policy
language.

For LLMs involved in wholesale architecting of major new features,
I remain pretty uncomfortable with the idea of DCO signoff, and
also not especially happy with the proposal in this series that
it is OK if done with prior agreement with a maintainer.

That is saying implicitly that "Use of AI tools is entirely
unrestricted for anything", from a DCO signoff POV. It merely
tries to stop us being flooded, and I'm pretty doubtful that
will work out.



> > With this in mind, it is perhaps not that different to accept a little
> > bit of uncertainty in risks of LLM unknowingly copying from training
> > material or 3rd party incompatibly licensed code it happened to find
> > while walking the web ?  The key is that users need to be diligent
> > in their use of the tools, not reckless. Norms for what that means
> > are still be established - the so called "clean room" or license
> > laundering, re-impls of projects are a massively risky activity
> > but are the exception.
> 
> So basically you're saying that it's our interpretation of the DCO that
> was wrong from the beginning, and it shouldn't actually be understood as
> strict/literally as we said it should?

No, as above, our current policy was intentionally simplistic,
going beyond what we needed to declare,  to get an initial
policy in place. The intent was always to refine the policy
over time.

This series is less of a refinement, and effectively a complete
removal almost all restrictions.

We're already feeling the massive burden of reviewing chatbot output
in our issue tracker, and it is a horrible experiance. I worry about
what the effects of this new policy will be for QEMU long term on
the patch side too, since no matter what we say the intent is, I
expect it will be an excuse to bombard us with more patches than
ever before.

> Even if people generally agree that that's the case, that should be made
> explicit. With the history of our claim that it's impossible to sign the
> DCO for AI output, we can't just mention in passing that the usual
> requirements like signing the DCO apply as if that is the most natural
> and uncontroversial thing to do, when we ourselves are claiming the
> opposite today.
> 
> I think that's what Paolo tried to address with the paragraph you
> suggested to remove. While its wording isn't perfect, I do think we need
> something like it.
> 
> > > > > If we decide that we don't care as much about the legal risks any more
> > > > > and that we're willing to accept them to some extent, that should be
> > > > > explicitly reflected in the policy.
> > > > >
> > > > > It seems to me that the cleanest way to do it is to exempt correctly
> > > > > advertised (with 'AI-used-for:') AI output from the DCO requirement and
> > > > > instead add to the 'AI-used-for:' definition some relaxed version of it,
> > > > > e.g. "I have reviewed the contribution for potential licensing issues
> > > > > and haven't found a reason to doubt that I have the rights to submit
> > > > > this AI generated content under the open source license indicated in the
> > > > > file". This is something that could realistically be certified by
> > > > > contributors in good faith and also isn't just "anything goes", but of
> > > > > course it still is weaker than the DCO.
> > 
> > I like the idea of associating "AI-used-for" with an explicit
> > statement like:
> > 
> >   "By using 'AI-used-for', a contributor both identifies areas of
> >    the patch that involved use of AI/LLM, and also attests that
> >    their usage of AI/LLMs was in compliance with the policies
> >    outlined in this document"
> > 
> > 
> > Then we can add whatever guidance we want in the AI policy that
> > steers people away from LLM usage patterns that we know would
> > expose us to undesirable risk. Explicitly stating that we do
> > not want LLMs used to "clean room" / "license launder" re-impl
> > existing code is something we could include.
> 
> Sure, that could be done.
> 
> > Or guide that agents should not be given free access to live git repos
> > to reduce change of direct copying ?
> 
> I'm less sure about this one, as long as it's contained to specific
> repos (e.g. a library that QEMU uses), it could be very useful and also
> not too bad to review - and we know the licenses are compatible anyway.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


