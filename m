Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D58C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9gyf-0006vu-7J; Thu, 24 Sep 2026 06:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9gyc-0006vV-D9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 06:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9gya-0002xr-Dw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 06:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790246811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57wnkrnk3TfoqaftJ2EkCMy/D2atXlj/7En5c+by65Y=;
 b=EfR9GtQe6YdJXL0+86xVT3rJyWJsy3C3lr44kbue58aKgCRdS5pwOu5e3jkSWKHAkdsh77
 ifsPfy9SqKiMxq2QMOqSkORFjPIumZu6Y1od/WYxs/hWRg3Tx6J3ScKFuzUcQf+PIl7+cN
 iedDVYzUgNJolQ1VZmRV5a/iN0YWl1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-T4sjUx81MhCSnIPniKEZUQ-1; Thu,
 24 Sep 2026 06:46:49 -0400
X-MC-Unique: T4sjUx81MhCSnIPniKEZUQ-1
X-Mimecast-MFC-AGG-ID: T4sjUx81MhCSnIPniKEZUQ_1790246808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D15D1828AC5; Thu, 24 Sep 2026 10:46:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FCDD180034F; Thu, 24 Sep 2026 10:46:43 +0000 (UTC)
Date: Thu, 24 Sep 2026 12:46:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <arT_kefzEhqg8-FB@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik3vyp3i.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> >> > +.. note:: **Use of AI does not remove the need for authors to comply
> >> > +          with all other requirements for contribution.**  In particular,
> >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> >> > +          that the author takes responsibility for the entire contents of
> >> > +          the patch, certifying that their patch submission is made in
> >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> >> > +          Origin (DCO) <dco>`.
> >> > +
> >> > +          Since a submitter cannot audit LLM output against its training
> >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> >> > +          that the contributor has the legal right to submit code in general.
> >> 
> >> I'm not a fan of this second paragraph, as that feels like it is undermining
> >> the DCO. That first sentence in particular is somewhat saying that the
> >> contributor does not have to think about plagarism and thed project is ok
> >> with that, and also implying that the DCO doesn't apply to the LLM output.
> >> This is both not OK in its implication of the project accepting some
> >> liability, and then also contradicted by the next sentence.
> >> 
> >> IMHO this paragraph should just be removed.  The first paragraph clearly
> >> states the DCO applies to the submission as a whole, and leaves all liability
> >> for infringement on the contributor.
> >
> > I don't think making this the individual contributor's problem is great.
> > It's rather unfriendly towards contributors to expect them to certify
> > something that we all know they can't honestly certify.
> 
> This is the current position with the DCO anyway. If the contributor has
> copy and pasted (and maybe adapted) from Stack Overflow they are still
> realistically the only person that can make that judgement.

Yes, that's the current position with the DCO and the reasoning why we
said LLM output is unacceptable in submissions.

The big difference is if I copy and pasted from Stack Overflow, I _know_
that I did that. If the LLM effectively does it for me, I don't know
that. The best I can do is check if I can find similar code elsewhere.

So while I can certify with 100% confidence that I didn't manually copy
things for code that I wrote myself, I can't certify that code from
other sources, including LLMs, isn't copied from elsewhere. I can only
say that I didn't find any reason to suspect it's copied.

> > Our current AI policy was built on the assertion that it's impossible to
> > sign the DCO for AI output, and I think that's still right. A developer
> > can't certify the origin of something when they don't really know where
> > it comes from.
> 
> It's certainly possible for LLMs to replicate copyright material but by
> far the biggest influence is the code *in the project* that shapes the
> output. It is basically pattern matching and predicting after all.

If there is one chunk of code that violates the copyright of someone,
you can't heal that just by having 1000 more chunks that are clean.

> What level of reassurance the submitter needs to be able to certify with
> their DCO is up to them. We can't police it, like every other submission
> we rely in the submitters good faith representation of what they have
> done.

The DCO doesn't talk about levels of reassurance. It talks about hard
facts, 100% confidence.

And that I can't give you with LLM generated content. I can maybe give
you 99%, but never 100%.

> > If we decide that we don't care as much about the legal risks any more
> > and that we're willing to accept them to some extent, that should be
> > explicitly reflected in the policy.
> >
> > It seems to me that the cleanest way to do it is to exempt correctly
> > advertised (with 'AI-used-for:') AI output from the DCO requirement and
> > instead add to the 'AI-used-for:' definition some relaxed version of it,
> > e.g. "I have reviewed the contribution for potential licensing issues
> > and haven't found a reason to doubt that I have the rights to submit
> > this AI generated content under the open source license indicated in the
> > file". This is something that could realistically be certified by
> > contributors in good faith and also isn't just "anything goes", but of
> > course it still is weaker than the DCO.
> >
> > If we're not willing to take the legal risk from this, we should
> > probably leave the current AI policy unchanged instead of telling
> > contributors that they have to work in a legal grey area.
> 
> I don't think we are asking them to work in a legally grey area, we are
> insisting they are confident there is no legal risk in what they submit.

If anyone is 100% "confident there is no legal risk", then I think
they're simply wrong (unless the contribution is obviously not
copyrightable anyway). The real question is if the risk is low enough.

But I suspect in most cases it's actually more like they're only 99%
confident and think "ah well, I'll sign it anyway, I probably won't get
into trouble". That gives people who are willing to bend the rules a
little an advantage over more conscientious contributors, which I don't
think is justified, because in the end it's the same 99% certainty for
both.

Kevin


