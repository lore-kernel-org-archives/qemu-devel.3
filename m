Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312B606A896
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=arjGKZU7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=L52IW9u2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRr2Z-0001GZ-RW; Fri, 13 Nov 2026 08:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xRr2X-0001GD-0f
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:10:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xRr2U-0007Lh-W8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794575399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tftx91FOQBq5BrAGiE3Di+TDdBBiW9mLTzntAZF67DM=;
 b=arjGKZU7C+2uY3hhW912JyTWeYRvWOaE+dmpWqgtAduWybPX24vDTtkS2vGrHFwJAXnr/q
 p5ddOvHEBru1a1DCMELoI4jwi8lNS6/rMt8PkS09vU8519FLVlTFckECkQVwe/gq/f0hjq
 JhQAb2HmLgMXd1httqtG7yteQxkO+uU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-XfZoAsRqOseLOjonQj8VWA-1; Fri, 13 Nov 2026 08:09:55 -0500
X-MC-Unique: XfZoAsRqOseLOjonQj8VWA-1
X-Mimecast-MFC-AGG-ID: XfZoAsRqOseLOjonQj8VWA_1794575394
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a214a5f8a1so10322615e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794575394; x=1795180194; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tftx91FOQBq5BrAGiE3Di+TDdBBiW9mLTzntAZF67DM=;
 b=L52IW9u2NUeoCU+8hAVibvc1Y0oDVyZuXyBNxNVg1pFmSF6/EJXVM225ulE1QYEA8V
 Ck7FlvcplfK3KeCvJzWvrAbVztYySqYH0DBDqbVHx/B3nfoiqXnIhprzOxvKqoyHDBFH
 8LTXYIcpdTgQMR7xuY5QlecMAoTZUpY7zD5szKBhnqLX+B8Wo9VDNAhoTrlC6zD9/+pB
 espMh3kgYFXurhc61IrtXBOoiXfe2iR0BQyvuldfOnejoN2areg6HjThg7Ydo7l/bRyY
 qKa9+yOtf6qNw9echW7wB1etL3O/7xhnVag66AJmCJQCNVBDW2ERE5zUrMongfeIWJBk
 nXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575394; x=1795180194;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tftx91FOQBq5BrAGiE3Di+TDdBBiW9mLTzntAZF67DM=;
 b=JlAIpcUJgtKJsKG6+V76t5x0xlSmXeEcIUGb58MlN+EmY1+Wzf7eUYDotkVbPrSgfP
 z/PGpEkE9Da1fhJ36Z+a/GmqyZq54wKeC9ydzQpKy+Te41ma8LlWzUKqPxdBnh1AwQ7T
 dbH5UL7te6sT1JOTfC4yABluW2qnQj5cC2OYY7gOZPg7c6yPGaaZQXQ2JH7v7tjv3239
 gIO3rwLXd9djL6mnKAAvGWPhUfl6gCd6b5ua3uzjTx3uR5RvLl8b8CHek74ax5QhR06i
 bJcoLHIRfisXRUWoWi435Um1j4Qtb3KxpK0z0DOHrvyEObpLKlOT5kld+sia571aCMnU
 4b1A==
X-Forwarded-Encrypted: i=1;
 AL+hErF4N/BxNhE7cNf20dN/ZviGo74GcRKwBWDMOOQxThENFs6pH8r2Xpsizpnou5JHAwMoHDmhyT3YenVR@nongnu.org
X-Gm-Message-State: APuU4Z9Oa99uKZFp3gbtxauYd3tjaQMgdKn+kzFQMb3MAqAWQQzW/Fy3
 8yoN9mVK8QAbkTSQBfKb6khng0q+64U0NLTN4KZMHav8ILxUESw5bivUMCT7lszvl/xS5+QEjtU
 Dl7UqzUJ8t8kkwEU5dY6PMYoyorKq7oIB6QYAjJhJ2eulr1zzS0yFfn5c
X-Gm-Gg: AYBFou1rc9NBkS1XO8a8HW45Cjq9VlwQnnKUReXVycDWMErd91WrMWSjPrt3tn74VYj
 DfrkOr260cU9PKefnZO4ysUW0ZC8eSLsSSBgFLap8Y7ZPHahp8NxRXpFmdhbzgt6l4yIVX6S6N3
 9Oh4knpJHJHOqn6PNKjAxDdTvhidx2cj6okg7eGPPKAMjpWXX0Dt0UEu+t872nOmfinVTOltBkP
 LDTjjPcyWFiuS5orAqzDwe2zNJN4a/dE5p9ep7TXGDh7Q0+r+1XHW1H8Fr26L3gxPOF2wo+TeRF
 8iVQaMMlIY8i5ImEk/2r/sjYcytilKraOQx4NdwpU+PylAKnYNtNwZyf3jNeEuuV8bwb33Py+6h
 T6f5B9/QK6a86IFYaOPUkmvrBCp9+DcbEJs3ZQHX/2w==
X-Received: by 2002:a05:600c:4f0b:b0:4a2:1196:db0e with SMTP id
 5b1f17b1804b1-4bb55a7d04cmr54512815e9.30.1794575394085; 
 Fri, 13 Nov 2026 05:09:54 -0800 (PST)
X-Received: by 2002:a05:600c:4f0b:b0:4a2:1196:db0e with SMTP id
 5b1f17b1804b1-4bb55a7d04cmr54512015e9.30.1794575393574; 
 Fri, 13 Nov 2026 05:09:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm8092858f8f.7.2026.11.13.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:09:52 -0800 (PST)
Date: Fri, 13 Nov 2026 08:09:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <20261113080645-mutt-send-email-mst@kernel.org>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik21vy11.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:14:18AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Oct 01, 2026 at 01:21:43PM +0100, Peter Maydell wrote:
> >> On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> > +LLM-assisted and LLM-created contributions
> >> > +''''''''''''''''''''''''''''''''''''''''''
> >> > +
> >> > +Use of generative AI can be classified in the following four buckets:
> >> > +
> >> > +- "background" assistance, such as completion and code review.  This does
> >> > +  not need disclosure.
> >> > +
> >> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> >> > +  are allowed with disclosure.  Splitting a submission in multiple parts
> >> > +  is **not** a valid way to bypass this rule; repeated, frequent posting
> >> > +  of such fixes must follow the rule for full contributions.
> >> > +
> >> > +- use of LLMs to help generating parts of a larger patch---test cases,
> >> > +  adaptations of existing code, boilerplate code for a new API, a tool to
> >> > +  help performing mechanical changes, etc.  These are generally allowed;
> >> > +  disclosure is highly recommended for non-trivial, functional code.
> >> 
> >> I think we can get or have consensus on these first three buckets...
> >> 
> >> > +- large, heavily LLM-assisted contributions where LLMs write large parts
> >> > +  of functional code.  These are only allowed if *pre-arranged*,
> >> > +  *high-quality* and *well-tested*.
> >> > +
> >> > +The last case (*"LLM-created contribution"*) is the one that requires
> >> > +a more careful approach.  In particular:
> >> > +
> >> > +- "Pre-arranged" means that a maintainer has communicated ahead of time,
> >> > +  for example on `IRC or the QEMU mailing
> >> > +  list <https://www.qemu.org/contribute/>`__, that they are willing
> >> > +  to review an LLM-created contribution.
> >> > +
> >> > +- "High-quality" means that the contributor must apply the same judgment
> >> > +  that would be applied to other code changes.  Contributors must invest
> >> > +  substantial time reviewing their contributions, curating them, and
> >> > +  understanding them in depth.
> >> > +
> >> > +- "Well-tested" means the LLM-created contributions will be held to a
> >> > +  higher standard than human-created ones, because LLMs make it easier
> >> > +  to write tests.  There are no exceptions for "writing the tests seems
> >> > +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
> >> 
> >> ...but I think fundamentally I am not in favour of having this
> >> fourth category of permitted uses. It seems even to have lost the
> >> idea of it being an "experimental" approach in this revision of the
> >> series. The first three categories are fine, and I have no particular
> >> problem with our relaxing our current policy to explicitly permit them.
> >
> > I suggested previously to remove the "experimental" tag, because it
> > felt rather misleading wrt what the policy was actually proposing to
> > permit in practice.
> >
> >
> > When we're saying that a maintainer and contributor can agree to
> > use AI for *anything* and will merge it, then that work has ceased
> > to be for "experiments". It is a fully accepted use case for writing
> > and merging code. All the policy is doing at that point is attempting
> > to rate-limit work by requiring prior agreement to use AI.
> >
> >
> >> Our problem as a project does not seem to be on the "writing
> >> code" side of things, but has always been on the "code review"
> >> side. This policy relaxation makes it much easier to write more
> >> code. Even when there's a "pre-arranged reviewer" that isn't
> >> necessarily helpful -- if you're one of the primary maintainers
> >> for an area of QEMU then the fact that somebody else is reviewing
> >> it doesn't make a big AI-generated code infusion any more palatable.
> >
> > Yes, that is my concern with anything that ends up spreading outside
> > the bounds of a single subsystem & its maintainer(s).
> 
> A big part (maybe the biggest) of my review load is patches crossing
> boundaries.
> 
> Alice posts patches for a subsystem maintained by Bob and Charlie, but
> she also needs a new QMP interface, so I get copied on that.  This is
> *fine*.
> 
> David wants to do the same but with AI.  He "pre-arranges", and Bob
> agrees to review.  Does Charlie get a vote?  What about me?

I think we can trust maintainers on this?  I know *I* am not merging QMP
patches who didn't get review from QMP maintainers.  So whenever someone
would try to pre-arrange with me, I'll also say "but pls get
pre-approval from QMP maintainers on the QMP bits".

> 
> Charlie and I can of course leave the review to Bob.  But we'll have to
> live with whatever makes it into the tree.

But why would Bob want the responsibility?

> 
> I fear this risks creating resentment among maintainers.
> 
> [...]


