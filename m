Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCBCF6AA6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmLf-0006T8-45; Thu, 08 Jan 2026 04:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdmLP-0006Rx-ON
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:30:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdmLN-0005JE-S5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767864610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTpuzp5c6JJHJbgnehLnsxR05jmUZXdvtMX/JyFJebA=;
 b=gHtO92vc3jeMU/+jMlPzfsEgrYmvuruG4WVRTS4d2mycm3j+DwqkatwYu6u+eUj4RbfuQ3
 HZdlY4AhvhzxeGBxxlpzq/FkPfhjdFNUvt9Uo1XpF0CwEb1uzI9tcPTZqfcQkVqrTJDkhx
 XU1UAev9ZeUzSv2ZbiSJvHJo7j9lVZ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-KvIyjwMcOxKYQz3VcxSTcw-1; Thu,
 08 Jan 2026 04:30:07 -0500
X-MC-Unique: KvIyjwMcOxKYQz3VcxSTcw-1
X-Mimecast-MFC-AGG-ID: KvIyjwMcOxKYQz3VcxSTcw_1767864606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A221195FE33; Thu,  8 Jan 2026 09:29:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 182661953994; Thu,  8 Jan 2026 09:29:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 660A521E66CC; Thu, 08 Jan 2026 10:29:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: MAX78000 machine needs a maintainer
In-Reply-To: <CAMyd1rSG9FuSVYFHZpSwyN+CBi_HFYBUAiOqAXh35bZaiNQtsw@mail.gmail.com>
 (Jackson Donaldson's message of "Sun, 21 Dec 2025 09:40:49 -0500")
References: <87ike27ucd.fsf@pond.sub.org>
 <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
 <878qex3ac7.fsf@pond.sub.org>
 <CAMyd1rR9HLwn-fzWfgqu=ZdtOq_Ae6Den-0oCmZpXAjxbup87A@mail.gmail.com>
 <8e9cc465-fc3a-4665-b754-6d5e20bc3651@linaro.org>
 <CAMyd1rSG9FuSVYFHZpSwyN+CBi_HFYBUAiOqAXh35bZaiNQtsw@mail.gmail.com>
Date: Thu, 08 Jan 2026 10:29:49 +0100
Message-ID: <87ikdca1v6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Jackson Donaldson <jackson88044@gmail.com> writes:
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>> Jackson Donaldson <jackson88044@gmail.com> writes:
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>> Jackson Donaldson <jackson88044@gmail.com> writes:
>>>>
>>>>> Hello,
>>>>>
>>>>>> You added the MAX78000FTHR machine in the v10.1 development cycle.
>>>>>> Would you be willing to serve as its maintainer?
>>>>>
>>>>> I don't think I'm a good choice for a maintainer. I no longer have ac=
cess
>>>>> to a physical MAX78000FTHR to verify against, since submitting those
>>>>> patches I have joined a company with a restrictive IP agreement, and =
I'm
>>>>> fairly low on time in which I could contribute.
>>>>>
>>>>> - Jackson Donaldson
>>>>
>>>> Thanks for your quick reply!  Would've been nice to have you onboard.
>>>>
>>>> Out of curiosity, what was your motivation to add the machine?
>>>
>>> I wrote the implementation for my university team in the 2025 MITRE
>>> embedded capture the flag challenge
>>
>> My understanding of Markus question is not why you implemented this
>> machine, but why you decided to contribute it, if you are not going
>> to maintain it, because then this is more burden for other maintainers.
>
> I decided to contribute it in the hopes that it would be useful to someone
> in the future? It did not occur to me that contributing code came with any
> kind of implicit promise of maintenance.

It doesn't.  It can help getting code accepted and kept.

> If doing so created more of a burden for you and the other maintainers th=
en
> I'm sorry about that; I really appreciate all the work you do.

You didn't do anything wrong, Jackson!

In the long run, the cost of maintaining code commonly dwarfs the cost
of creating it.

That said, QEMU welcomes contributions, even if the author's goal is
just to learn or to have fun.  Learning and having fun matters!  It's up
to QEMU maintainers to reject patches that are likely to be more of a
burden than a benefit to QEMU.

Peter Maydell accepted yours in his role as ARM general architecture
maintainer.  If ARM maintainers come to the conclusion that an orphaned
MAX78000FTHR isn't worth keeping, they can deprecate and eventually
delete it.  I'm not going to interfere there :)


