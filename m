Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E8CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVRXc-0005DY-RU; Fri, 05 Jun 2026 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wVRXb-0005DN-Bq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wVRXY-00009B-Bp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780654354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/px19uI1EuZF/RUCUDNDIOSxPSUxcBLdQFYGqy8cxJw=;
 b=LatJgdXg3swjTrqwBw4cgudgFf3qlOIIySVk9kdi8QS9+cV2EBpJM9++LohJRLH7Hg71fV
 rM8bN25jyJEbaWty4EXsNP35XvMNe3p8crxAmfWY9z//U5VkAqTJ30nTdo7otLRhGUzpCE
 dfjI5Q26IW85BSST8pUPyNjJ0RvcihE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-UHJLo2VZOWawNfXGQoEt8w-1; Fri,
 05 Jun 2026 06:12:29 -0400
X-MC-Unique: UHJLo2VZOWawNfXGQoEt8w-1
X-Mimecast-MFC-AGG-ID: UHJLo2VZOWawNfXGQoEt8w_1780654348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C94918002C3; Fri,  5 Jun 2026 10:12:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.109])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 614F41800480; Fri,  5 Jun 2026 10:12:23 +0000 (UTC)
Date: Fri, 5 Jun 2026 12:12:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <aiKhBDfATZ1SkmYm@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.06.2026 um 17:35 hat Paolo Bonzini geschrieben:
> > > +**Small bug fixes**
> > > +  These should be limited to 20 lines of code or less, not including
> > > +  tests.  You are still expected to :ref:`understand and explain your changes
> > > +  <write_a_meaningful_commit_message>` and the rationale behind them.
> >
> > I think the "20 lines or less" is not going a good job at expressing
> > the intent behind this point. I'd like us to emphasize between the
> > "why" of this point, as that helps contributors & reviewers make a
> > decision of whether a change is "within the spirit" or the rule of
> > not.
> 
> True but we also need a rule. The spirit is better explained elsewhere
> (and also, building consensus on spirit vs. a rule are two different
> things).

But "20 lines or less" is still not a good rule because it measures
something that isn't really what we're after. The rule is "trivial
code", and yes, there is no good way to measure that. But that's not a
good reason to replace it with a metric as good as defining productivity
of an engineer by lines of code added.

Can we turn this just into an example, and also be a bit more specific?
Like "20 lines of low complexity code"? (Or is it more like "moderate
complexity" that you have in mind?) But it's definitely possible to
write 20 lines that aren't trivial at all, so the rule shouldn't allow
that.

> > Docs is an area I'm more wary of from the social expectation side rather
> > than the technical or legal side.  I don't feeel like "pay attention to
> > the organization and flow" really mitigates to the tendancy to production
> > of vast reams of convincing sounding slop.
> 
> Reviewers have no obligation to review.  The good thing about slop is
> that saying no takes about the same effort as the author put into the
> creation of the change.

Just saying "no, because I don't feel like reviewing this" is actually a
new thing for most of us, and doesn't feel very comfortable. We may need
to get used to it, but I don't think it's easy.

> > > +There is no requirement to include your prompts or summarize the
> > > +conversation in the commit message or cover letter, but you may do so
> > > +if you think it helps a reviewer judge the result.  For example:
> >
> > IMHO we should actively discourage the inclusion of prompts
> > entirely as it is the wrong information to provide.
> 
> Why? I think it helps especially in the case where we're asking for
> maintainers to apply their discretion, and for reproducibility. It may
> not be always applicable, but it can also help.

Not sure how much reproducibility there can possibly be with LLMs. :-)

Kevin


