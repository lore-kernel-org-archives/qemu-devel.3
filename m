Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8994C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9her-0005ZB-5h; Thu, 24 Sep 2026 07:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9heo-0005Xw-1V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9hek-0007WY-TT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790249424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaJK2teTX6gkYBvcAulx5yQ8jqhPtL477O6xi1MuYHc=;
 b=PNQQILoetDZfzD78mhpR71KiJDsxLd3D53GJAP4/NnUZrPWZYDdUpzOHB3+rae+a4jsZBQ
 pe7xFyhvh7AMY4DoZ4Kscr+xFC4DVU4TAUheqbB5KFGlCQuGsHGTAQF/urpefWtyWB6Rmk
 XmLA996v8Th6Wisb2998t+8JCusQEaA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-RFvXc2JmORq8Sxb4Lpy1lw-1; Thu,
 24 Sep 2026 07:30:21 -0400
X-MC-Unique: RFvXc2JmORq8Sxb4Lpy1lw-1
X-Mimecast-MFC-AGG-ID: RFvXc2JmORq8Sxb4Lpy1lw_1790249418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE1D9180121A; Thu, 24 Sep 2026 11:30:17 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACDC51955F74; Thu, 24 Sep 2026 11:30:14 +0000 (UTC)
Date: Thu, 24 Sep 2026 12:30:12 +0100
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
Message-ID: <arUJxE0F7Q3Cw5sk@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arT_kefzEhqg8-FB@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > Kevin Wolf <kwolf@redhat.com> writes:
> > 
> > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > >> > +          with all other requirements for contribution.**  In particular,
> > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > >> > +          that the author takes responsibility for the entire contents of
> > >> > +          the patch, certifying that their patch submission is made in
> > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > >> > +          Origin (DCO) <dco>`.
> > >> > +
> > >> > +          Since a submitter cannot audit LLM output against its training
> > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > >> > +          that the contributor has the legal right to submit code in general.
> > >> 
> > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > >> the DCO. That first sentence in particular is somewhat saying that the
> > >> contributor does not have to think about plagarism and thed project is ok
> > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > >> This is both not OK in its implication of the project accepting some
> > >> liability, and then also contradicted by the next sentence.
> > >> 
> > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > >> states the DCO applies to the submission as a whole, and leaves all liability
> > >> for infringement on the contributor.
> > >
> > > I don't think making this the individual contributor's problem is great.
> > > It's rather unfriendly towards contributors to expect them to certify
> > > something that we all know they can't honestly certify.
> > 
> > This is the current position with the DCO anyway. If the contributor has
> > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > realistically the only person that can make that judgement.
> 
> Yes, that's the current position with the DCO and the reasoning why we
> said LLM output is unacceptable in submissions.
> 
> The big difference is if I copy and pasted from Stack Overflow, I _know_
> that I did that. If the LLM effectively does it for me, I don't know
> that. The best I can do is check if I can find similar code elsewhere.
> 
> So while I can certify with 100% confidence that I didn't manually copy
> things for code that I wrote myself, I can't certify that code from
> other sources, including LLMs, isn't copied from elsewhere. I can only
> say that I didn't find any reason to suspect it's copied.

> > > Our current AI policy was built on the assertion that it's impossible to
> > > sign the DCO for AI output, and I think that's still right. A developer
> > > can't certify the origin of something when they don't really know where
> > > it comes from.
> > 
> > It's certainly possible for LLMs to replicate copyright material but by
> > far the biggest influence is the code *in the project* that shapes the
> > output. It is basically pattern matching and predicting after all.
> 
> If there is one chunk of code that violates the copyright of someone,
> you can't heal that just by having 1000 more chunks that are clean.
> 
> > What level of reassurance the submitter needs to be able to certify with
> > their DCO is up to them. We can't police it, like every other submission
> > we rely in the submitters good faith representation of what they have
> > done.
> 
> The DCO doesn't talk about levels of reassurance. It talks about hard
> facts, 100% confidence.
> 
> And that I can't give you with LLM generated content. I can maybe give
> you 99%, but never 100%.

I appreciate you're speaking about licensing/copyright here, but more
generally I think we're probably wrong in asserting that a human
authored contribution can ever be said to be 100% safe to QEMU with
a DCO signoff. It is risk mitigation, but not absolute.
 
From a copyright POV, if we write the code ourselves we can have
confidence we didn't copy it and thus licensing is likely OK (unless
you inadvertantly memorized some previous code you saw and reproduced
it too closely), but there are other legal aspects. Trademarks are
one risk, since we reference lots of vendor's hardware features, but
in practice this very rarely arises as a problem for projects, beyond
the obvious areas like project name, logo, and other visible branding
aspects. Software patents are the really big hidden trap that anyone
could unintentionally fall foul of at any time and have caused high
profile problems for projects periodically.

If someone knows their employer has a patent that is likely to be
restrictive for possible use in QEMU, then they shouldn't sign off
or contribute code implementing something covered by the patent
without the employer granting unrestricted use. We're certainly
not expecting people to do searches for 3rd party patents though,
so the DCO is not a 100% guarantee of risk elimination to QEMU.

We tolerate that risk because there is no practical action that a
contributor can take to mitigate. Further many large tech companies
have thus formed defensive pacts to de-fang the risk.


With this in mind, it is perhaps not that different to accept a little
bit of uncertainty in risks of LLM unknowingly copying from training
material or 3rd party incompatibly licensed code it happened to find
while walking the web ?  The key is that users need to be diligent
in their use of the tools, not reckless. Norms for what that means
are still be established - the so called "clean room" or license
laundering, re-impls of projects are a massively risky activity
but are the exception.



> > > If we decide that we don't care as much about the legal risks any more
> > > and that we're willing to accept them to some extent, that should be
> > > explicitly reflected in the policy.
> > >
> > > It seems to me that the cleanest way to do it is to exempt correctly
> > > advertised (with 'AI-used-for:') AI output from the DCO requirement and
> > > instead add to the 'AI-used-for:' definition some relaxed version of it,
> > > e.g. "I have reviewed the contribution for potential licensing issues
> > > and haven't found a reason to doubt that I have the rights to submit
> > > this AI generated content under the open source license indicated in the
> > > file". This is something that could realistically be certified by
> > > contributors in good faith and also isn't just "anything goes", but of
> > > course it still is weaker than the DCO.

I like the idea of associating "AI-used-for" with an explicit
statement like:

  "By using 'AI-used-for', a contributor both identifies areas of
   the patch that involved use of AI/LLM, and also attests that
   their usage of AI/LLMs was in compliance with the policies
   outlined in this document"


Then we can add whatever guidance we want in the AI policy that
steers people away from LLM usage patterns that we know would
expose us to undesirable risk. Explicitly stating that we do
not want LLMs used to "clean room" / "license launder" re-impl
existing code is something we could include. Or guide that 
agents should not be given free access to live git repos to
reduce change of direct copying ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


