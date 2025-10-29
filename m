Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA5FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2UA-0000QZ-4c; Wed, 29 Oct 2025 05:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vE2U7-0000PM-V5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:28:51 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vE2Tz-0006eP-3O
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:28:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 351B580F38;
 Wed, 29 Oct 2025 12:28:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:57b::1:4] (unknown [2a02:6bf:8080:57b::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aSaBN10Fn8c0-MEVVUTVc; Wed, 29 Oct 2025 12:28:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761730116;
 bh=vdRNh/2Ug/8e2yUUQCbcgl+cBzOxx7zjJX81/VkIBCA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uSM9ktLg7Cpb9oNdbQG7tpjvPoszmytlPoPmJkaCRF4rOoCDoyr4SgpUqI2pf72YU
 rT3lSqvpsNxcCkEIYKcYIUQn1poIF1EMmLosusmPquvUosgRSdvc/BRa0N7RNvg1qj
 QeB4cccffafbGlpdnak0PayIRcqyqcvMQ6IbUuPA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3f9153b1-ba52-4f30-ac31-3916d9ee2ea5@yandex-team.ru>
Date: Wed, 29 Oct 2025 12:28:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <aOy0OtaNT9A48rhQ@redhat.com> <878qgurtz7.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <878qgurtz7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29.10.25 11:29, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Sat, Oct 11, 2025 at 05:04:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Let's bring the documentation in line with the requirements. And
>>> do check these requirements in QAPI parser.
>>
>> This implicitly assumes that the requirements are desirable.
>>
>> This is a large number of patches, showing the requirements are widely
>> ignored today. When I look at the changes in the patches my overwhealming
>> reaction is that they are not beneficial, which in turn makes me believe
>> the requirements should be changed to match the reality of the code,
>> rather than the reverse.
> 
> A QAPI schema contains four distinct kinds of text:
> 
> 1. Schema code
> 
> 2. Example code in comments
> 
> 3. Doc comments less example code, i.e. prose
> 
> 4. Non-doc comments
> 
> This series touches all four.

I'm unsure about [1.]. What do you mean? The series touch only comments.

I now check:

  git diff 37137ae582 HEAD | grep '^[+-][^#+-]'

where 37137ae582 is first commit "qapi: Add documentation format validation"
for me, and this grep finds nothing..

Assume [4.] is a tiny part.

> 
> "The requirements" refers to docs/devel/qapi-code-gen.rst section
> Documentation comments / Documentation markup:
> 
>      For legibility, wrap text paragraphs so every line is at most 70
>      characters long.
> 
>      Separate sentences with two spaces.
> 
> I've explained why these rules make sense a number of times, and I'm
> happy to explain again if needed.
> 
> Note this applies only to doc comments.
> 
> I've been enforcing it manually for prose.  Whether it should be
> enforced for example code is debatable.  Let's focus on prose.
> 
> "Widely ignored" is not true, and I have numbers to back that up.
> 
> We have some 20,000 lines of doc comments in the main QAPI schema and
> the QGA QAPI schema.  Some 3,000 lines are examples.  That leaves a bit
> over 17,000 lines of prose in 48 files.
> 
> If I drop the changes to the other three kinds from Vladimir's series,
> and add a few more prose changes he missed

Hmm it surprises me.. Does it mean that the check added in patch 01 misses
some violations?

>, I get this diffstat:
> 
>   24 files changed, 351 insertions(+), 332 deletions(-)

Compare with original diffstat:

  33 files changed, 713 insertions(+), 704 deletions(-)

So obviously, touching up code examples makes the series twice more invasive.

I agree, to at least postpone examples changing. And the series show, that in many
cases there are no obvious possibility to satisfy restrictions for examples.

Hmm, probably, we want another limit for examples? 90 characters? Anyway, not in this
series.

-- 
Best regards,
Vladimir

