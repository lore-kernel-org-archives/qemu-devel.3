Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBECA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDpvt-0003TW-2i; Mon, 05 Oct 2026 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xDpvq-0003TI-IG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:09:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xDpvo-0008Nf-A4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:09:10 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 04D00583301;
 Mon, 05 Oct 2026 23:09:06 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lOtxTKJdTTLV; Mon,  5 Oct 2026 23:09:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 39BCF5832AF; Mon, 05 Oct 2026 23:09:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 379C25831F0;
 Mon, 05 Oct 2026 23:09:03 +0200 (CEST)
Date: Mon, 5 Oct 2026 23:09:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
Message-ID: <293cb972-35e1-1922-0834-601e2491a7a6@eik.bme.hu>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 2 Oct 2026, Paolo Bonzini wrote:
> On 10/1/26 14:21, Peter Maydell wrote:
>> On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> +- large, heavily LLM-assisted contributions where LLMs write large parts
>>> +  of functional code.  These are only allowed if *pre-arranged*,
>>> +  *high-quality* and *well-tested*.
>>> +
>>> +The last case (*"LLM-created contribution"*) is the one that requires
>>> +a more careful approach.  In particular:
>>> +
>>> +- "Pre-arranged" means that a maintainer has communicated ahead of time,
>>> +  for example on `IRC or the QEMU mailing
>>> +  list <https://www.qemu.org/contribute/>`__, that they are willing
>>> +  to review an LLM-created contribution.
>>> +
>>> +- "High-quality" means that the contributor must apply the same judgment
>>> +  that would be applied to other code changes.  Contributors must invest
>>> +  substantial time reviewing their contributions, curating them, and
>>> +  understanding them in depth.
>>> +
>>> +- "Well-tested" means the LLM-created contributions will be held to a
>>> +  higher standard than human-created ones, because LLMs make it easier
>>> +  to write tests.  There are no exceptions for "writing the tests seems
>>> +  hard" or for `yak shaving 
>>> <https://en.wiktionary.org/wiki/yak_shaving>`__.
>> 
>> ...but I think fundamentally I am not in favour of having this
>> fourth category of permitted uses. It seems even to have lost the
>> idea of it being an "experimental" approach in this revision of the
>> series. The first three categories are fine, and I have no particular
>> problem with our relaxing our current policy to explicitly permit them.
>> 
>> Our problem as a project does not seem to be on the "writing
>> code" side of things, but has always been on the "code review"
>> side. This policy relaxation makes it much easier to write more
>> code. Even when there's a "pre-arranged reviewer" that isn't
>> necessarily helpful -- if you're one of the primary maintainers
>> for an area of QEMU then the fact that somebody else is reviewing
>> it doesn't make a big AI-generated code infusion any more palatable.
>
> I understand where you're coming from.
>
> The purpose of the fourth category is norming contributions that are already 
> happening.  I apologize for the allegation in advance, but take for example 
> https://lore.kernel.org/qemu-devel/20260817190038.580257-1-mattst88@gmail.com/; 
> on one hand it is very high quality, on the other hand I give it at least a 
> 70% likelihood of being heavily LLM-assisted for the implementation and not 
> just for the analysis.
>
> The question is: do we want contributions like that one?  If we decide that 
> their quality and usefulness are high enough to want them, what process do we 
> need around them?  I think we all agree that, if that kind of contribution is 
> desirable, we want the submitters to declare AI usage and the reviewers to be 
> aware of it.
>
>> Allowing large heavily LLM-assisted contributions seems to me:
>>   * the biggest risk legally speaking (though I think this is
>>     in practice not all that big a risk at this point)
>>   * the biggest risk of the codebase degenerating into
>>     unmaintainability
>>   * the biggest risk of finding ourselves reviewing contributions
>>     that are in practice much more vibe-coded than the policy text
>>     above is asking for
>
> I agree completely with how you phrased the first and third.  I agree that 
> the second bullet is a risk too, but it's mitigated by "LLM-created 
> contributions will be held to a higher standard than human-created ones, 
> because LLMs make it easier to write tests" (and by maintainers being able to

Tests need to be reviewed too to be able to trust them so that does not 
help against overloading reviewers with generated patches but burdens them 
even more: they will also have to review the tests before the code.

We could say tests must be written by hand but nobody wants to do that or 
that they need to be reviewed by a human before submission but we ask that 
for all code in the patch including tests so I don't see how the argument 
that LLMs can write tests would reduce the original problem.

Regards,
BALATON Zoltan

