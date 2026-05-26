Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB834CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx0d-0007np-D8; Tue, 26 May 2026 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRx0Z-0007nM-OA
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRx0W-00011L-Ir
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779822002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8h7gw2ZBCzlYajnD6x4ROzo6o/+iXjeBJoHxfPTvLw=;
 b=djoERxfuOlkhrh1zbjNnRU9wC03TZepWwDLqmaE7TCVAVV4Dw0AaegU1Fm6wx7FXEL+Vvg
 VZvUsttDK3iyjkfizudH7bvrtHuZmHNczjWd6D4bBPQubGIZM2bXAU+hDUsfjZuhxMmAxM
 uLeX/jQXf5BINjp04OfOIjFaMcqev2g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-wZO7sHVbPdemQgRiUF9-EQ-1; Tue,
 26 May 2026 15:00:00 -0400
X-MC-Unique: wZO7sHVbPdemQgRiUF9-EQ-1
X-Mimecast-MFC-AGG-ID: wZO7sHVbPdemQgRiUF9-EQ_1779821999
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963AA1956089
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 18:59:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DA5919560A3; Tue, 26 May 2026 18:59:57 +0000 (UTC)
Date: Tue, 26 May 2026 20:59:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahXtqyuIa4XqkMHb@redhat.com>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526140231-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 26.05.2026 um 20:03 hat Michael S. Tsirkin geschrieben:
> On Tue, May 26, 2026 at 07:43:35PM +0200, Kevin Wolf wrote:
> > Am 24.05.2026 um 14:42 hat Michael S. Tsirkin geschrieben:
> > > So, I had to reject a perfectly reasonable patch:
> > > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
> > > just because of a tool used to make it.
> > > 
> > > 
> > > 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> > > 	content generators commonly available today is unclear.  The QEMU project is
> > > 	not willing or able to accept the legal risks of non-compliance.
> > > 
> > > 
> > > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> > > published this piece:
> > > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> > > 
> > > 
> > > Saying, in particular "
> > > 	We understand this concern, but the DCO has never
> > > 	been interpreted to require that every line of a contribution must be
> > > 	the personal creative expression of the contributor or another human
> > > 	developer. 
> > > "
> > 
> > I never found that blog post particularly convincing, especially because
> > they acknowledge a concern:
> > 
> >     There are two versions of this concern. The first is practical: that
> >     an AI tool could covertly insert excerpts of proprietary (or
> >     license-incompatible) code into an open source project, potentially
> >     creating legal risk for maintainers and users. The second is broader
> >     and more philosophical: that large language models, trained on vast
> >     amounts of open source software, are essentially misappropriating
> >     the community’s work, producing outputs stripped of the obligations
> >     that open source licenses require.
> > 
> >     We think these concerns deserve to be taken seriously.
> > 
> > The second one is essentially what I understood the QEMU policy to be
> > about. Unfortunately, the blog post then goes on to only ever deal with
> > the first one and ignore the second one that seems more relevant for us.
> > 
> > So yes, the DCO isn't about "personal creative expression" or whatever
> > (and nobody suggested it is, this is a strawman), but it's about whether
> > the submitter has the legal rights to submit the code. And that's
> > exactly the question we decided we don't want to take a risk on.
> > 
> > 
> > So if that part isn't helpful, what has changed since we introduced the
> > AI policy? It's a few points:
> > 
> > 1. While AI has been in use for a while now, we haven't seen projects
> >    accepting AI generated code/content get into big trouble. While it
> >    could still happen in the future, it might be an indication that the
> >    probability of the risk hitting us is not that high.
> > 
> > 2. The useful part of the blog post is that it tells us that Red Hat
> >    considers the risk acceptable. This can inform our assessment of the
> >    risks, though of course there might be a significant difference in
> >    the impact of the risk for a company with a legal department and an
> >    open source community consisting mainly of developers acting as
> >    individuals.
> > 
> >    I think it's obvious that if the QEMU project gets involved in a
> >    legal case, we have a problem (at the very least long lasting
> >    distraction from actual work on QEMU), even if we didn't do anything
> >    wrong and a good lawyer would easily win the case.
> > 
> > 3. It was easy to just outright ban AI while its results were usually
> >    not really usable anyway. This has changed meanwhile, so it's much
> >    harder to maintain an absolute ban.
> > 
> >    It's not really the best use of my time to look at the idea in
> >    AI-generated test cases and then rewrite them from scratch so I can
> >    actually submit them. (On the other hand, I think my rewritten
> >    submissions were always better and more maintainable than what AI
> >    produced initially, so there's that.)
> > 
> > So while my perspective is a lot more nuanced than yours, I do see a
> > shift in the balance and was actually thinking of suggesting a change of
> > the policy myself.
> > 
> > What I was thinking of was allowing AI-generated content in places where
> > it's at least easy to revert if there is ever a problem with it: Tests,
> > documentation etc., but not core code that lots of other things depend
> > on and that will have evolved a lot when we notice a problem and for
> > which throwing away is simply not an option.
> 
> OK. what about trivial changes? Using AI as a better sed?

The above is just what I was thinking of suggesting myself. I didn't
mean to imply that I'm opposed to anything else, but just thought I'd
post it as an example of fairly obvious things we could allow.

Of course, it also shows my own pain points. I don't see that much use
in it for generating code for QEMU proper, because these changes tend to
be few lines and I have an opinion on each of the lines - tests are the
opposite, lots of boilerplate and I don't care much how elegant they
are because nothing else will build on them anyway.

So yes, trivial patches is another obvious starting point. The challenge
there is defining the line where a patch stops being trivial. So I'm not
completely sure if making this distinction in a policy is a good idea;
maybe practically speaking it has to be all or nothing in terms of
creativity (for lack of a better word).

As an aside, personally, I'm not convinced that AI can be a "better
sed". If it's really about mechanical changes, I think the resulting
patch is much more reviewable if the agent doesn't modify the code, but
just generate the sed command line or the Coccinelle patch and that is
included in the commit message. Reviewers can then just review that and
then reproduce the result themselves for comparison. This is impossible
with AI prompts and agents do tend to forget an instance of something to
replace here and there, so you do have to review the result carefully.

But none of these "better sed" problems need to handled in an AI policy.
If a patch is hard to review, the maintainer will already reject it on
those grounds.

> > > I propose adopting linux's rules instead:
> > > https://docs.kernel.org/process/coding-assistants.html
> > > 
> > > which boils down to attribution.
> > 
> > What would we actually do with the detailed information? Why do we care
> > which model was used? Is this helpful commit metadata or is it just free
> > advertising for a handful of companies?
> 
> I presume, if a specific model is somehow declared "contaminated" so we
> can locate its output?

Contaminated in what respect?

Quality? Might be because of malicious intentions or just because the
model happens to be bad at a specific question. Review and testing must
be able to catch quality problems. I don't think this is different from
any other contributions.

Copyright? If so, then we're back to "can you really sign the DCO?"

Something completely different?

> > I think I would see more use in a tag like (better name welcome):
> > 
> >     AI-used-for: [code|tests|docs|commit message]...
> > 
> > Kevin
> 
> I surely don't mind.

Great. Let's see what others think.

Kevin


