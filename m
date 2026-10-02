Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZmI-0000ZL-FG; Fri, 02 Oct 2026 05:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZmG-0000Yy-Ln
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZmE-0008J9-9C
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4CtC/SBr+WhTdke8jNTJ4zGFAIu3I9ldDfDhJGS/rVk=;
 b=FNfKRpZWrX8+0BaLz1WqHYqZQQcGQj4AX1DvzDkbGarB8DyZOgLSsxdkGgIv9nqQyqaGDD
 WxvFMyOep1juSZTPmgPJcnDpRDVatbzS0EF/uVf9kwFWYe0ikAfz+j4NU60LWk+KjUHk5y
 jUIKYHli+7YRowq3m5XOSF/FErWzbB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-MDD4dQSOO0OZZIY96PwVZA-1; Fri,
 02 Oct 2026 05:41:57 -0400
X-MC-Unique: MDD4dQSOO0OZZIY96PwVZA-1
X-Mimecast-MFC-AGG-ID: MDD4dQSOO0OZZIY96PwVZA_1790934116
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95EA618011EC; Fri,  2 Oct 2026 09:41:55 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ECB541D; Fri,  2 Oct 2026 09:41:51 +0000 (UTC)
Message-ID: <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
Date: Fri, 2 Oct 2026 11:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/1/26 14:21, Peter Maydell wrote:
> On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> +- large, heavily LLM-assisted contributions where LLMs write large parts
>> +  of functional code.  These are only allowed if *pre-arranged*,
>> +  *high-quality* and *well-tested*.
>> +
>> +The last case (*"LLM-created contribution"*) is the one that requires
>> +a more careful approach.  In particular:
>> +
>> +- "Pre-arranged" means that a maintainer has communicated ahead of time,
>> +  for example on `IRC or the QEMU mailing
>> +  list <https://www.qemu.org/contribute/>`__, that they are willing
>> +  to review an LLM-created contribution.
>> +
>> +- "High-quality" means that the contributor must apply the same judgment
>> +  that would be applied to other code changes.  Contributors must invest
>> +  substantial time reviewing their contributions, curating them, and
>> +  understanding them in depth.
>> +
>> +- "Well-tested" means the LLM-created contributions will be held to a
>> +  higher standard than human-created ones, because LLMs make it easier
>> +  to write tests.  There are no exceptions for "writing the tests seems
>> +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
> 
> ...but I think fundamentally I am not in favour of having this
> fourth category of permitted uses. It seems even to have lost the
> idea of it being an "experimental" approach in this revision of the
> series. The first three categories are fine, and I have no particular
> problem with our relaxing our current policy to explicitly permit them.
> 
> Our problem as a project does not seem to be on the "writing
> code" side of things, but has always been on the "code review"
> side. This policy relaxation makes it much easier to write more
> code. Even when there's a "pre-arranged reviewer" that isn't
> necessarily helpful -- if you're one of the primary maintainers
> for an area of QEMU then the fact that somebody else is reviewing
> it doesn't make a big AI-generated code infusion any more palatable.

I understand where you're coming from.

The purpose of the fourth category is norming contributions that are 
already happening.  I apologize for the allegation in advance, but take 
for example 
https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/; 
on one hand it is very high quality, on the other hand I give it at 
least a 70% likelihood of being heavily LLM-assisted for the 
implementation and not just for the analysis.

The question is: do we want contributions like that one?  If we decide 
that their quality and usefulness are high enough to want them, what 
process do we need around them?  I think we all agree that, if that kind 
of contribution is desirable, we want the submitters to declare AI usage 
and the reviewers to be aware of it.

> Allowing large heavily LLM-assisted contributions seems to me:
>   * the biggest risk legally speaking (though I think this is
>     in practice not all that big a risk at this point)
>   * the biggest risk of the codebase degenerating into
>     unmaintainability
>   * the biggest risk of finding ourselves reviewing contributions
>     that are in practice much more vibe-coded than the policy text
>     above is asking for

I agree completely with how you phrased the first and third.  I agree 
that the second bullet is a risk too, but it's mitigated by "LLM-created 
contributions will be held to a higher standard than human-created ones, 
because LLMs make it easier to write tests" (and by maintainers being 
able to *refuse* specific contributions, which is the point of 
pre-arrangement; note that pre-arrangement should exist today as a 
matter of courtesy for any large change).

The third risk is probably the biggest of these.  The heaviest toll that 
AI has on maintainers may not be the review per se; if a contribution is 
good and desirable, having to review it is all fine.  Rather, the 
problem is that maintainers have to be ready to say no more often to the 
free puppies, and that is not necessarily easy.  And dually, that 
contributors may not realize it when they're not respecting the 
maintainers' efforts.

I add a fourth risk: that new contributors using AI will not be willing 
to do the final stretch of the work that *has* to be manual, and makes a 
difference between work worth reviewing and work worth including.  This 
would be the biggest waste of time for the reviewer.

> I look at our issue tracker where we see AI assisted contributions
> that run the whole range from "an human making intelligent use of
> the tool to provide high-quality bug reports with good analysis"
> through to "absolute slop dumped on us with no apparent human
> thought or intervention". I don't really want to expand that
> from our issue tracker to our code review and codebase, please.
> 
> I would be much happier seeing the advocates of AI putting
> effort into making the process of QEMU code review better and
> less work, rather than in applying it to the code writing process.
To clarify, my goal with this policy change is not to advocate for AI 
usage, but to advocate for transparency when AI is involved.

I agree that making QEMU code review better should be a goal. 
Unfortunately it is an expensive goal (in real-world money).

Paolo


