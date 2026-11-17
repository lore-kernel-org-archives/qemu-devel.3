Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30976606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iJl6Xc0z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQm7-0000HS-7q; Tue, 17 Nov 2026 16:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTQm4-0000H4-Nc
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:31:32 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTQm2-0001jx-SL
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:31:32 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67db6d4054eso190848d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794951089; cv=none;
 d=google.com; s=arc-20260327;
 b=VW3t9lfnTzmpPK/GLWXGhfp0brZzC2ipoydXSSauw3U3JKbs6/PoXNtnVOOEO7tWNT
 ad8OsEA+PPJYWHcihMTttXpm20aEyR0KMb4dSxCVos+2AkxDNCmRMlyixcSTfDifskfl
 fxrtZdh90Ki2x2Gyxdw9H3dUVVWkZrAs5DOd92Vk0F8vraohgiLpXuubLsdLWtk6RI6r
 cVRfOO+Y9nIFxV9ODeDZc4b7iILd6uuwXq3zkUA1bR7GccUYnR6UJq9cQGc1fQin7jox
 M1SXYzHsw5xAXIglGMc6xJ/nOutTYOYJEOq2+XxiyrjpOW2lgy9KVt9/lBT33f9K09v2
 wMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=alN1SKFcoOUU+hK+a+1Ix2msSb6rV2AQ5iXy8ujJuHw=;
 fh=AtujA3Pl0LlL7j6BCuU+ZpNGusxBW6Lx5vwN99pZeGE=;
 b=XAqfjDjBxaBjsy/J0HLlc3TlCdOk7DfiG110oCow4K2wzaTwmA9NS371YaUd/Qf7BW
 HJXyRhCCVyCfJZQYfaFVCzDDxVHB66TFbMGGtDPpYDl+iDX47iMMzIlSZsc4hj2qQ5Fp
 LOhuu30V681JDjeWVPXYDjbVLXC/0EVT2HKU1ugWQb1+ykRN4mKwaSvg7J2FMFjUUn54
 p4cemNrVvXsnjHHsjKKfChc+2ngJ2WoH0bxbWI/DaV63Dqs2XuUXud4mz9XiHNhJS9sq
 YMZ+I6HhX6e7KLxm3jQoL6vulgDQZPhias37vHYPzBQn6Apu5b7AgTqxj6KRDqmRDstI
 pw8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794951089; x=1795555889; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=alN1SKFcoOUU+hK+a+1Ix2msSb6rV2AQ5iXy8ujJuHw=;
 b=iJl6Xc0zxQMuwj8F8yt0yR0px1f3VIaoryY+SOStEDUIpsB72sWsJF4Tu/Avu/4Zhg
 DMWy7LmxCF11MKba/yBg4enkNWuw7y5U0wS/elyS7g4JheF5z2h9/cVa+cqmsc4cV9Vv
 Dbx9mDQ4ojNXLSdhlgUdE4/Coltdd/mV7bvDSyWoC5gfFDZ+0Y+QzmxaT5sJjOOixtJY
 bTiGvXwgn1qP56eS7nyoPMmEBQaZe15FkTQrYciip3vuAHGkE5wvkUXyqCRPJ/1vYeIO
 UqyvZSZ5AAqrN5CgjsRvHGDxh+57GVFBbYethEIKmVNXNGaS4E2Fkrgcp9rKJ3Go89W+
 Z3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794951089; x=1795555889;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=alN1SKFcoOUU+hK+a+1Ix2msSb6rV2AQ5iXy8ujJuHw=;
 b=Skvbe/xIVuIzMBRGi9GH3kgfNuPAPutG7ps/R2jCkuT2ooScZ3rz5LtVheLUvtIpzm
 Eh+iU5Lt9E2xO2EbYas6NoC+dt4l8ft7TDqtLGXR2zZnYxh2vcqSQtQaL+76T8VGCqwP
 4TtOCT+QZPjLCk53KNFxrU9KpmM1rrE0aw15oG0QmBfMZjgUYU/WxtNkam4nxhkwCWxd
 Z7L4MB8TEweqU6YfMc0VqZ+A8/daTYcaj8ODR0lGN7s8g/zokSq+byUpT+sFoxWBft53
 J3h3K5ji6sMJSKmPoWLdWHiQa15IAI0b2kXUQmToDTTTyiKwf+w1evTPTrXpmRUOYLDP
 HdDg==
X-Forwarded-Encrypted: i=1;
 AL+hErF/rykSt3A7RmllhRRxIm+aYzQCora0hVxll+nBobcROrg6+sEyC8NQh7HhtZrHW5TAj6w+CMPgf5q3@nongnu.org
X-Gm-Message-State: APuU4Z8IseG4WZaixAA/DEVG4NmjRBVc2lNVlhYBMQNkQ8O+4HgqLSxN
 BVOTQPZE6dUJV4UrIsTDXvzZVjKjiAYmUdo/0XgaFmCezSk1Jq6BSJinpCtFB+cxKYxSYTzdMDa
 f1rfDJ4oBLvNQ0PD0DLWLFfQhfdSyRv5bfqCmfjSWqg==
X-Gm-Gg: AZFdTZdQBlBt3FmmbN8oR15RLoUy7BkbEsp36vKS/1MT+HwWPudhH0z5WN8Ac+oL29j
 at3mFOZNKZXEX8PjcZS4x/YdhXTu59S1w3yNxVz2lcS8HYbYwaCzIVX5WuKgkpbosi6/rfrs8Yn
 sS0yUiFQ1XBoA/C2p51TI+Al0uDOmbUsatTL2BLPPvrnYARHuf+SFheOv+PUuPBK//Ha6Ky9jpk
 Ll+cdpRSLfzyaOAmKFeEEtSxSwsxmZxZr9LRmc/9PGbP8FMM6kOYqlsTUWekjJBZ3IMXFAGH8C8
 bSDfdi4YKDIglM5zCy8FJi+IhzHN7NNgx10lT/V+3wzUs6ZUnaZkYGr1q81f6LedOnAvBYChuJc
 iFR7ap9uqhOuS8uESaU+FpTJrrtQV5EFytmweO++mo/IMAQYMJTEsabDK8SrQ8vdEC7YhkqF9tC
 tyBABAG7lZWk8ZoTv4l8KihbuwL9hYvXGgK5L7IW23Bg==
X-Received: by 2002:a05:690e:1306:b0:67d:b08b:ef96 with SMTP id
 956f58d0204a3-67dd4022b3fmr379943d50.81.1794951089439; Tue, 17 Nov 2026
 13:31:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <avy4mkin-orpwskO@redhat.com> <avzDYfG-cPiWaCZ6@redhat.com>
In-Reply-To: <avzDYfG-cPiWaCZ6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 21:31:18 +0000
X-Gm-Features: AclHuK_m-Tu7PbWv76m9o7bUUnKinNg86WJ4xwtdnuTT2GI-dOJg19pp8f3Kgi0
Message-ID: <CAFEAcA87cvgsjGu3-y_7h5dB2HyA2tzKOW8WmBxvoi7zdp9Oyg@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 21:13, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 17.11.2026 um 21:40 hat Eric Blake geschrieben:
> > [Chiming in late]
> >
> > On Wed, Sep 30, 2026 at 10:54:30AM +0200, Paolo Bonzini wrote:
> > > +LLM-assisted and LLM-created contributions
> > > +''''''''''''''''''''''''''''''''''''''''''
> > > +
> > > +Use of generative AI can be classified in the following four buckets:
> > > +
> > > +- "background" assistance, such as completion and code review.  This does
> > > +  not need disclosure.
> > > +
> > > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> > > +  are allowed with disclosure.  Splitting a submission in multiple parts
> > > +  is **not** a valid way to bypass this rule; repeated, frequent posting
> > > +  of such fixes must follow the rule for full contributions.
> > > +
> > > +- use of LLMs to help generating parts of a larger patch---test cases,
> > > +  adaptations of existing code, boilerplate code for a new API, a tool to
> > > +  help performing mechanical changes, etc.  These are generally allowed;
> > > +  disclosure is highly recommended for non-trivial, functional code.
> >
> > I see lots of discussion about whether to stop here (and s/four/three/
> > above), and leaving off the fourth bullet (or splitting it to a
> > separate patch for later) appeals to me personally. But I can also go
> > along with the final bullet if that is what the consensus lands on.
>
> If the consensus is that the legal arguments for the current policy
> aren't relevant any more, I'd like to have some policy update merged
> rather sooner than later. Without this concern, I think I'm mostly in
> the "it's just a tool" camp.
>
> I don't mind the fourth point and don't expect practical problems from
> it, but if some people do have concerns that would take months to
> resolve, I'd prefer to do without it for now and allow at least the
> uncontentious cases without waiting.

Yes, I would rather we accepted the uncontentious cases and then
had the discussion about the one where it's less clear we have
consensus, than that we hold all the changes up until we get
agreement on all four points. "Push for all four" has got us mostly
"no change" so far.

I think we definitely should have that community-call discussion
on the AI policy so we can see where we are collectively. I also
don't think we particularly need to tie our policy updates to the
release schedule: it's just a documentation change.

thanks
-- PMM

