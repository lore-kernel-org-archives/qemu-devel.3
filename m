Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A7C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9npt-0004uv-V3; Thu, 24 Sep 2026 14:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9npr-0004uT-Lh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9npp-0007Ev-Hm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790273174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0F0NbQyoHYUtUYk8liYNCcKtstIQd3c/V7ItrymWj4=;
 b=gyEu0WBW+ldmLfCCEianaZPLpTgiV5CIcaI/phZgCVKucXs0d/7UI3c0pBcptbXBhArFuv
 4FkknfrpEeFova995ihoSjMFBTyl4MeIc6L4SZWCNbpMCVRZhteqFbzFTOvfdlKo0yeXkl
 iI/32PJ43DGQp5gvF7pdEIER0ymmX58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-uholJHkTPkuinbsON28_wQ-1; Thu,
 24 Sep 2026 14:06:13 -0400
X-MC-Unique: uholJHkTPkuinbsON28_wQ-1
X-Mimecast-MFC-AGG-ID: uholJHkTPkuinbsON28_wQ_1790273172
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A94D81802565; Thu, 24 Sep 2026 18:06:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.118])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25D40180056E; Thu, 24 Sep 2026 18:06:07 +0000 (UTC)
Date: Thu, 24 Sep 2026 20:06:05 +0200
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
Message-ID: <arVmjZTsLVLH0bm0@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <20260924120617-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924120617-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Am 24.09.2026 um 18:06 hat Michael S. Tsirkin geschrieben:
> On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > Am 24.09.2026 um 11:29 hat Alex Bennée geschrieben:
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > > 
> > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrangé geschrieben:
> > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > >> > +.. note:: **Use of AI does not remove the need for authors to comply
> > > >> > +          with all other requirements for contribution.**  In particular,
> > > >> > +          the ``Signed-off-by`` label in a patch submission is a statement
> > > >> > +          that the author takes responsibility for the entire contents of
> > > >> > +          the patch, certifying that their patch submission is made in
> > > >> > +          accordance with the rules of the :ref:`Developer's Certificate of
> > > >> > +          Origin (DCO) <dco>`.
> > > >> > +
> > > >> > +          Since a submitter cannot audit LLM output against its training
> > > >> > +          data, the DCO is paired with :ref:`metadata in the commit message
> > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> > > >> > +          that the contributor has the legal right to submit code in general.
> > > >> 
> > > >> I'm not a fan of this second paragraph, as that feels like it is undermining
> > > >> the DCO. That first sentence in particular is somewhat saying that the
> > > >> contributor does not have to think about plagarism and thed project is ok
> > > >> with that, and also implying that the DCO doesn't apply to the LLM output.
> > > >> This is both not OK in its implication of the project accepting some
> > > >> liability, and then also contradicted by the next sentence.
> > > >> 
> > > >> IMHO this paragraph should just be removed.  The first paragraph clearly
> > > >> states the DCO applies to the submission as a whole, and leaves all liability
> > > >> for infringement on the contributor.
> > > >
> > > > I don't think making this the individual contributor's problem is great.
> > > > It's rather unfriendly towards contributors to expect them to certify
> > > > something that we all know they can't honestly certify.
> > > 
> > > This is the current position with the DCO anyway. If the contributor has
> > > copy and pasted (and maybe adapted) from Stack Overflow they are still
> > > realistically the only person that can make that judgement.
> > 
> > Yes, that's the current position with the DCO and the reasoning why we
> > said LLM output is unacceptable in submissions.
> > 
> > The big difference is if I copy and pasted from Stack Overflow, I _know_
> > that I did that. If the LLM effectively does it for me, I don't know
> > that. The best I can do is check if I can find similar code elsewhere.
> 
> You can block your LLM from accessing stack overflow.

Given that training my own model from scratch isn't a realistic option,
I can't block the LLM from being trained on data from Stack Overflow.

Kevin


