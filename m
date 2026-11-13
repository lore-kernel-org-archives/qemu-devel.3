Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F936606A88A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjTEWVmJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoIi-0000AR-KH; Fri, 13 Nov 2026 05:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRoIg-0008Va-NB
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRoIe-0003t2-Sp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794564867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMOTJdC4FRjldVgjUE6g9IHAcDXU0z2qqfhjegY6YIk=;
 b=YjTEWVmJ49pHg0MD2ZQ6MzVBdf9oh/TeCVv8xAJvfn2ii2zWmFc/IqkTqjmV8er2VFiwBh
 u2fN013BexIpiFACTXGNOIKZPtLscmB1RALaumzWTBAcRkwVDsmW84WheQL507NpSRKFxL
 ijZ6CdT8CY34npNtZSW+1I6G21I8CyA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-W4I-7iiKPOGYp_UgJZ1KWA-1; Fri,
 13 Nov 2026 05:14:23 -0500
X-MC-Unique: W4I-7iiKPOGYp_UgJZ1KWA-1
X-Mimecast-MFC-AGG-ID: W4I-7iiKPOGYp_UgJZ1KWA_1794564862
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFA81977321; Fri, 13 Nov 2026 10:14:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEB8130000E5; Fri, 13 Nov 2026 10:14:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8684821E6A04; Fri, 13 Nov 2026 11:14:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis
 <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <ar_FXE5rzVqKcTc4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 2 Oct 2026 15:53:16 +0100")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com>
Date: Fri, 13 Nov 2026 11:14:18 +0100
Message-ID: <87ik21vy11.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 01, 2026 at 01:21:43PM +0100, Peter Maydell wrote:
>> On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > +LLM-assisted and LLM-created contributions
>> > +''''''''''''''''''''''''''''''''''''''''''
>> > +
>> > +Use of generative AI can be classified in the following four buckets:
>> > +
>> > +- "background" assistance, such as completion and code review.  This =
does
>> > +  not need disclosure.
>> > +
>> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of =
code)
>> > +  are allowed with disclosure.  Splitting a submission in multiple pa=
rts
>> > +  is **not** a valid way to bypass this rule; repeated, frequent post=
ing
>> > +  of such fixes must follow the rule for full contributions.
>> > +
>> > +- use of LLMs to help generating parts of a larger patch---test cases,
>> > +  adaptations of existing code, boilerplate code for a new API, a too=
l to
>> > +  help performing mechanical changes, etc.  These are generally allow=
ed;
>> > +  disclosure is highly recommended for non-trivial, functional code.
>>=20
>> I think we can get or have consensus on these first three buckets...
>>=20
>> > +- large, heavily LLM-assisted contributions where LLMs write large pa=
rts
>> > +  of functional code.  These are only allowed if *pre-arranged*,
>> > +  *high-quality* and *well-tested*.
>> > +
>> > +The last case (*"LLM-created contribution"*) is the one that requires
>> > +a more careful approach.  In particular:
>> > +
>> > +- "Pre-arranged" means that a maintainer has communicated ahead of ti=
me,
>> > +  for example on `IRC or the QEMU mailing
>> > +  list <https://www.qemu.org/contribute/>`__, that they are willing
>> > +  to review an LLM-created contribution.
>> > +
>> > +- "High-quality" means that the contributor must apply the same judgm=
ent
>> > +  that would be applied to other code changes.  Contributors must inv=
est
>> > +  substantial time reviewing their contributions, curating them, and
>> > +  understanding them in depth.
>> > +
>> > +- "Well-tested" means the LLM-created contributions will be held to a
>> > +  higher standard than human-created ones, because LLMs make it easier
>> > +  to write tests.  There are no exceptions for "writing the tests see=
ms
>> > +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shavi=
ng>`__.
>>=20
>> ...but I think fundamentally I am not in favour of having this
>> fourth category of permitted uses. It seems even to have lost the
>> idea of it being an "experimental" approach in this revision of the
>> series. The first three categories are fine, and I have no particular
>> problem with our relaxing our current policy to explicitly permit them.
>
> I suggested previously to remove the "experimental" tag, because it
> felt rather misleading wrt what the policy was actually proposing to
> permit in practice.
>
>
> When we're saying that a maintainer and contributor can agree to
> use AI for *anything* and will merge it, then that work has ceased
> to be for "experiments". It is a fully accepted use case for writing
> and merging code. All the policy is doing at that point is attempting
> to rate-limit work by requiring prior agreement to use AI.
>
>
>> Our problem as a project does not seem to be on the "writing
>> code" side of things, but has always been on the "code review"
>> side. This policy relaxation makes it much easier to write more
>> code. Even when there's a "pre-arranged reviewer" that isn't
>> necessarily helpful -- if you're one of the primary maintainers
>> for an area of QEMU then the fact that somebody else is reviewing
>> it doesn't make a big AI-generated code infusion any more palatable.
>
> Yes, that is my concern with anything that ends up spreading outside
> the bounds of a single subsystem & its maintainer(s).

A big part (maybe the biggest) of my review load is patches crossing
boundaries.

Alice posts patches for a subsystem maintained by Bob and Charlie, but
she also needs a new QMP interface, so I get copied on that.  This is
*fine*.

David wants to do the same but with AI.  He "pre-arranges", and Bob
agrees to review.  Does Charlie get a vote?  What about me?

Charlie and I can of course leave the review to Bob.  But we'll have to
live with whatever makes it into the tree.

I fear this risks creating resentment among maintainers.

[...]


