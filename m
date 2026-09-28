Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F5C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6Fy-0007Kr-8o; Mon, 28 Sep 2026 03:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xB6Fv-0007Ka-Ai
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xB6Fr-0006Tq-E8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790582307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/v1n4HcJrPaIJK21uVaLrb6rtLPGaoOM/ccZRGGYSQ=;
 b=B612uHeKeidI9Aiw0kT893gBpR/PwagBQEevgrKijHCoFWg9KvDRVD+QrBG+Go1fMJ6Y+a
 LXm17wnKmgYVuq2IFDepibMlkzmN6ZPsQ6Lp8Waz2C5LR9CAZIXYPgeJZfNMfYHLRlLPjE
 1d6iuABXBRR0ptIduzORtuPBnRHv/dg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-Lp0tzDdXNKmtTySKl2zjZQ-1; Mon,
 28 Sep 2026 03:58:23 -0400
X-MC-Unique: Lp0tzDdXNKmtTySKl2zjZQ-1
X-Mimecast-MFC-AGG-ID: Lp0tzDdXNKmtTySKl2zjZQ_1790582302
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF65E18009C4; Mon, 28 Sep 2026 07:58:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33D931956087; Mon, 28 Sep 2026 07:58:17 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:58:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <aroeF0CsjLoOszRJ@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <20260924120617-mutt-send-email-mst@kernel.org>
 <arVmjZTsLVLH0bm0@redhat.com>
 <20260927050956-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927050956-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 27.09.2026 um 11:20 hat Michael S. Tsirkin geschrieben:
> On Thu, Sep 24, 2026 at 08:06:05PM +0200, Kevin Wolf wrote:
> > Am 24.09.2026 um 18:06 hat Michael S. Tsirkin geschrieben:
> > > On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > > > Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > > > > Kevin Wolf <kwolf@redhat.com> writes:
> > > > > 
> > > > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > > > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > > > > >> > +          with all other requirements for contribution.**  In particular,
> > > > > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > > > >> > +          that the author takes responsibility for the entire contents of
> > > > > >> > +          the patch, certifying that their patch submission is made in
> > > > > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > > > >> > +          Origin (DCO) <dco>`.
> > > > > >> > +
> > > > > >> > +          Since a submitter cannot audit LLM output against its training
> > > > > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > > > >> > +          that the contributor has the legal right to submit code in general.
> > > > > >> 
> > > > > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > > > > >> the DCO. That first sentence in particular is somewhat saying that the
> > > > > >> contributor does not have to think about plagarism and thed project is ok
> > > > > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > > > > >> This is both not OK in its implication of the project accepting some
> > > > > >> liability, and then also contradicted by the next sentence.
> > > > > >> 
> > > > > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > > > > >> states the DCO applies to the submission as a whole, and leaves all liability
> > > > > >> for infringement on the contributor.
> > > > > >
> > > > > > I don't think making this the individual contributor's problem is great.
> > > > > > It's rather unfriendly towards contributors to expect them to certify
> > > > > > something that we all know they can't honestly certify.
> > > > > 
> > > > > This is the current position with the DCO anyway. If the contributor has
> > > > > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > > > > realistically the only person that can make that judgement.
> > > > 
> > > > Yes, that's the current position with the DCO and the reasoning why we
> > > > said LLM output is unacceptable in submissions.
> > > > 
> > > > The big difference is if I copy and pasted from Stack Overflow, I _know_
> > > > that I did that. If the LLM effectively does it for me, I don't know
> > > > that. The best I can do is check if I can find similar code elsewhere.
> > > 
> > > You can block your LLM from accessing stack overflow.
> > 
> > Given that training my own model from scratch isn't a realistic option,
> > I can't block the LLM from being trained on data from Stack Overflow.
> > 
> > Kevin
> 
> But again, that is beside the point, unless you believe that a judge
> will (or should?) close all LLMs overnight declaring their output a
> derivative of the internet and so illegal to use. If not, training is
> transformative, and LLM output is not a derivative of the internet
> *unless it is input with Stack Overflow*.

You're treating things as black and white here, which is maybe how
things should be, but not how they are in practice today. At least my
understanding is that the common interpretation is that LLM output is
generally okay, but if it reproduces an existing work too closely, then
you're still infringing on its copyright and that's your own problem.

Just because in >99% of cases the model doesn't reproduce things from
the training data too closely, that doesn't automatically make
everything it produces from training data clean. And this is the part
that courts in different jurisdictions have even decided on, so it's not
just speculation. I'm not aware of any court declaring that LLMs are
purely transformative and everything that comes from training data is
automatically good (though I'm also not aware of a court deciding the
opposite; it seems to be always just about the result in the individual
case and how much it resembles existing works).

Kevin


