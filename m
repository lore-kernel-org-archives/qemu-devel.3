Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0C5CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpwu-0006l2-Vl; Tue, 26 May 2026 07:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRpwt-0006kn-BL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:27:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRpwr-00069N-0x
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:27:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 50FBB5968DE;
 Tue, 26 May 2026 13:27:43 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id h4KYXZ1Os4EY; Tue, 26 May 2026 13:27:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E1E0B5968DC; Tue, 26 May 2026 13:27:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E05065966F5;
 Tue, 26 May 2026 13:27:40 +0200 (CEST)
Date: Tue, 26 May 2026 13:27:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Subject: Re: on ai generated and code provenance
In-Reply-To: <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
Message-ID: <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
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

On Tue, 26 May 2026, Paolo Bonzini wrote:
> Il mar 26 mag 2026, 10:23 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
>
>>> Personally I think QEMU's
>>> policy is fine but we should start introducing exceptions, possibly
>>> including large contributions with pre-authorization (but not
>>> pre-approval) from the maintainer.
>>
>> I want to note that [...] while we were essentially in the "blanket ban"
>> state anyway, there was no particular need to have the discussion about
>> other reasons we might also want to be restrictive or cautious about AI
>> contributions, but those other reasons and viewpoints don't go away
>> automatically with the legal one.
>>
>> I have quite a lot of sympathy with the rationale behind the Zig policy,
>> for instance: https://kristoff.it/blog/contributor-poker-and-ai/ I spend
>> quite a lot of time reviewing patches for things which are features I don't
>> necessarily personally care about. I'm happy with doing that for other
>> people who are hopefully learning and gaining something from the process;
>> I'm much less interested in reviewing a mountain of LLM-generated patches.
>>
>
> I agree and that's a good argument for pre-discussion with the maintainers.
> It would anyway be the right thing to do for large contributions, but it's
> even more important with AI given the different balance between contributor
> and reviewer.

I think the real problem is people who don't know what they are doing yet 
use an AI to generate a patch and submit it anyway. Reviewers are then 
flooded with nonsense that they have to look at to find out if there's 
anything useful in it which takes their time from doing more useful 
things. So the policy should make clear that we don't accept patches 
generated by AI that no human has read and understood before submission 
and adding a S-o-b should also mean (besides that the submitter made sure 
there's no copyright infringement) that that person has knowledge about 
the patch and is willing to correct it. Then reviewers can just bounce AI 
nonsense back to the conrtibutor or ignore it if they don't reply (or 
reply with more AI nonsense suggesting they don't know what the patch does 
so can't correct it). I think that's the real fear that has led to the AI 
ban and the copyright issues were just a convenient excuse. Maybe 
clarifying this in the policy could be done although there will always be 
people who ignore documents. So maybe what we want is no direct submission 
of AI generated patches without at least a human inbetween who has already 
reviewed tha patch before sending it to the list.

Regards,
BALATON Zoltan

