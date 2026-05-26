Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09540CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxUz-0001dR-8d; Tue, 26 May 2026 15:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRxUd-0001Yc-DT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRxUa-0001WG-JA
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779823866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sk2OA06M0ZiBfceNU+j+5ToFPiMTNNfr43gltGLJr7c=;
 b=FjhXr0af16JVlbmnGRKv+qLW+iG+0696MnJY/eoEW5AZp5zcgfqweFQHK20cH+0EyXUQgw
 JCTDlyCol2uSV/cCrJO0/Cf0339VNfI8gEEUi2bQ9Ej7O7GtjJuAwv9i0PBLcRdZoVY2R5
 dhoBrwIX5IlLvwaFyhOm5ZXgNKj6QBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-dBwIPUNAM6OtXgoIqApU4g-1; Tue, 26 May 2026 15:31:03 -0400
X-MC-Unique: dBwIPUNAM6OtXgoIqApU4g-1
X-Mimecast-MFC-AGG-ID: dBwIPUNAM6OtXgoIqApU4g_1779823862
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so85937405e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779823862; x=1780428662; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sk2OA06M0ZiBfceNU+j+5ToFPiMTNNfr43gltGLJr7c=;
 b=r82W58xcWhGAJNfwveHd3YFOqVEvN1qJd2Buf8QvzI29gve6vk4HQHxd9UnSPg+qMB
 YGlD36ArssTPL60krgwxEHTbnfqadZkhUbnzkdIZmFmjF4fMt1QG1PdUv/hfMLDbf6fJ
 J+dwwF22132fXxFCqHbCfFg+LoWx1PO5q94lBe2MMX86YRcMTWeysCh2eZewmQ0NvVt0
 QsgrPxV7fHEPrdrTdslrT9EMqeJyqHw4+mvpOFgQOiJJxe6JYwqpm0+f7puP4ONQVk2l
 2zkYTAzI71l6x4H5mP1lh7jvc8Fndf4ONDHaOWidyw0RhjnCxNl6L9VQ/V8xqbVN09ez
 tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779823862; x=1780428662;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sk2OA06M0ZiBfceNU+j+5ToFPiMTNNfr43gltGLJr7c=;
 b=NRL4enrB8ibbjftfSsp5DZLtF0pZCxMmPXBOohmGKypUUhWvl1wt/z/VSSSo8B5ka7
 xIz2P4ykCMdrLq9/4dKWznBLSm3mK/uuTSCDfe9rNU/NUUi5/Kj49OMlThcTa8bSSeDY
 V1AQAwuYdZTXJkqeXwwv4c5QD/5V/tZ2u/PjzKsXdHLZsu15dhqR3enASE+C8EFamSoJ
 yx7f/3CAoihRFiezjmEQsJS03wj1T0bQu8+o70s0IHX48E6+ECjR5rOk36WS0ec00Nk0
 k/NNLwPK2GFsTlz4wmkve0FSFEsMKn1ZeFSwrtY073dFBtuRAZRS/Rsjft0BjNtboNZ7
 avDg==
X-Gm-Message-State: AOJu0YzmcBodoQV8Ffpb2Tz58wcCadz2IKfdXHxtFtZN2arln1MVYsyJ
 S/HSRkbudQwIgs0Z0m5e1bAAMOtjbaO8Mj41fVIcdsB7oGEq7lSeb0H62dr8PBfSH2Ug380Af9P
 fWVt5a7AXnqN3jR85+70PIEpSOpQe9hn0Ldrab8xlDFjUXtxrLQ5nCoMm
X-Gm-Gg: Acq92OG983hzhUOkuL/0noscGlVum6MIgzxJYMSkztTB9gFZ/B44bC06AG3rUhsCsnz
 QPPFr9qczo+J9fV1RtJ/NhA+WqvfRnPI2Yxwm8edUQ+IpJxTG/4GBdm4cs2cgR0ioF2wOUnm3lb
 5lTWkSYU2EKpPnzBKtHESiZXPMXyTGgetxoFHH8EaG4IKtOrluKkEvHM7xmwAAjXYRwNlLgA8cw
 KRCsOE+cujbxi0UoatxZSbl/XIjddL7/hBzAz55TEfmUzSGIT+ZMVKkyq51bojXu3nVwD87wtsn
 B7Boj9exZ9tC0UKnYW9bMsb85S8oilLUQO1CWYpgvH6ZWKZ85Xs0t0IyVhApGUPrJRsUsUYoaza
 /S6GPor+nh/yCGNHrRKoQtg6/N+FyM2tDVgR08Vkr4w8=
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id
 5b1f17b1804b1-490482c4586mr352884435e9.23.1779823862411; 
 Tue, 26 May 2026 12:31:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id
 5b1f17b1804b1-490482c4586mr352883865e9.23.1779823861804; 
 Tue, 26 May 2026 12:31:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e7d0967sm2492855e9.11.2026.05.26.12.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:31:01 -0700 (PDT)
Date: Tue, 26 May 2026 15:30:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260526152526-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahXtqyuIa4XqkMHb@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 08:59:55PM +0200, Kevin Wolf wrote:
> Am 26.05.2026 um 20:03 hat Michael S. Tsirkin geschrieben:
> > On Tue, May 26, 2026 at 07:43:35PM +0200, Kevin Wolf wrote:
> > > Am 24.05.2026 um 14:42 hat Michael S. Tsirkin geschrieben:
> > > > So, I had to reject a perfectly reasonable patch:
> > > > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
> > > > just because of a tool used to make it.
> > > > 
> > > > 
> > > > 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> > > > 	content generators commonly available today is unclear.  The QEMU project is
> > > > 	not willing or able to accept the legal risks of non-compliance.
> > > > 
> > > > 
> > > > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> > > > published this piece:
> > > > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> > > > 
> > > > 
> > > > Saying, in particular "
> > > > 	We understand this concern, but the DCO has never
> > > > 	been interpreted to require that every line of a contribution must be
> > > > 	the personal creative expression of the contributor or another human
> > > > 	developer. 
> > > > "
> > > 
> > > I never found that blog post particularly convincing, especially because
> > > they acknowledge a concern:
> > > 
> > >     There are two versions of this concern. The first is practical: that
> > >     an AI tool could covertly insert excerpts of proprietary (or
> > >     license-incompatible) code into an open source project, potentially
> > >     creating legal risk for maintainers and users. The second is broader
> > >     and more philosophical: that large language models, trained on vast
> > >     amounts of open source software, are essentially misappropriating
> > >     the community’s work, producing outputs stripped of the obligations
> > >     that open source licenses require.
> > > 
> > >     We think these concerns deserve to be taken seriously.
> > > 
> > > The second one is essentially what I understood the QEMU policy to be
> > > about. Unfortunately, the blog post then goes on to only ever deal with
> > > the first one and ignore the second one that seems more relevant for us.
> > > 
> > > So yes, the DCO isn't about "personal creative expression" or whatever
> > > (and nobody suggested it is, this is a strawman), but it's about whether
> > > the submitter has the legal rights to submit the code. And that's
> > > exactly the question we decided we don't want to take a risk on.
> > > 
> > > 
> > > So if that part isn't helpful, what has changed since we introduced the
> > > AI policy? It's a few points:
> > > 
> > > 1. While AI has been in use for a while now, we haven't seen projects
> > >    accepting AI generated code/content get into big trouble. While it
> > >    could still happen in the future, it might be an indication that the
> > >    probability of the risk hitting us is not that high.
> > > 
> > > 2. The useful part of the blog post is that it tells us that Red Hat
> > >    considers the risk acceptable. This can inform our assessment of the
> > >    risks, though of course there might be a significant difference in
> > >    the impact of the risk for a company with a legal department and an
> > >    open source community consisting mainly of developers acting as
> > >    individuals.
> > > 
> > >    I think it's obvious that if the QEMU project gets involved in a
> > >    legal case, we have a problem (at the very least long lasting
> > >    distraction from actual work on QEMU), even if we didn't do anything
> > >    wrong and a good lawyer would easily win the case.
> > > 
> > > 3. It was easy to just outright ban AI while its results were usually
> > >    not really usable anyway. This has changed meanwhile, so it's much
> > >    harder to maintain an absolute ban.
> > > 
> > >    It's not really the best use of my time to look at the idea in
> > >    AI-generated test cases and then rewrite them from scratch so I can
> > >    actually submit them. (On the other hand, I think my rewritten
> > >    submissions were always better and more maintainable than what AI
> > >    produced initially, so there's that.)
> > > 
> > > So while my perspective is a lot more nuanced than yours, I do see a
> > > shift in the balance and was actually thinking of suggesting a change of
> > > the policy myself.
> > > 
> > > What I was thinking of was allowing AI-generated content in places where
> > > it's at least easy to revert if there is ever a problem with it: Tests,
> > > documentation etc., but not core code that lots of other things depend
> > > on and that will have evolved a lot when we notice a problem and for
> > > which throwing away is simply not an option.
> > 
> > OK. what about trivial changes? Using AI as a better sed?
> 
> The above is just what I was thinking of suggesting myself. I didn't
> mean to imply that I'm opposed to anything else, but just thought I'd
> post it as an example of fairly obvious things we could allow.
> 
> Of course, it also shows my own pain points. I don't see that much use
> in it for generating code for QEMU proper, because these changes tend to
> be few lines and I have an opinion on each of the lines - tests are the
> opposite, lots of boilerplate and I don't care much how elegant they
> are because nothing else will build on them anyway.
> 
> So yes, trivial patches is another obvious starting point. The challenge
> there is defining the line where a patch stops being trivial. So I'm not
> completely sure if making this distinction in a policy is a good idea;
> maybe practically speaking it has to be all or nothing in terms of
> creativity (for lack of a better word).

Let the maintainers decide?

Or we can enumerate things:
- fixing tool (compiler/checkpatch/smatch) errors/warnings in obvious ways (e.g. suggested by the
  tools itself, such as initializing an uninitialized variable)
- propagating API changes (e.g. rebasing a patch after an API change)
- anything that could be done by a perl/sed/coccinelle script
- adding or fixing code comments



> As an aside, personally, I'm not convinced that AI can be a "better
> sed". If it's really about mechanical changes, I think the resulting
> patch is much more reviewable if the agent doesn't modify the code, but
> just generate the sed command line or the Coccinelle patch and that is
> included in the commit message. Reviewers can then just review that and
> then reproduce the result themselves for comparison. This is impossible
> with AI prompts and agents do tend to forget an instance of something to
> replace here and there, so you do have to review the result carefully.
> 
> But none of these "better sed" problems need to handled in an AI policy.
> If a patch is hard to review, the maintainer will already reject it on
> those grounds.

Absolutely.

> > > > I propose adopting linux's rules instead:
> > > > https://docs.kernel.org/process/coding-assistants.html
> > > > 
> > > > which boils down to attribution.
> > > 
> > > What would we actually do with the detailed information? Why do we care
> > > which model was used? Is this helpful commit metadata or is it just free
> > > advertising for a handful of companies?
> > 
> > I presume, if a specific model is somehow declared "contaminated" so we
> > can locate its output?
> 
> Contaminated in what respect?
> 
> Quality? Might be because of malicious intentions or just because the
> model happens to be bad at a specific question. Review and testing must
> be able to catch quality problems. I don't think this is different from
> any other contributions.
> 
> Copyright? If so, then we're back to "can you really sign the DCO?"
> 
> Something completely different?
> 
> > > I think I would see more use in a tag like (better name welcome):
> > > 
> > >     AI-used-for: [code|tests|docs|commit message]...
> > > 
> > > Kevin
> > 
> > I surely don't mind.
> 
> Great. Let's see what others think.
> 
> Kevin


