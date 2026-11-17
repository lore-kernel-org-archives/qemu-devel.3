Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6F606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQwq-00022x-Rv; Tue, 17 Nov 2026 16:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xTQwo-00022V-Vu
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:42:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xTQwm-00074R-RH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 16:42:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C1FB60C50E;
 Tue, 17 Nov 2026 22:42:32 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ONCaumZWJ5vB; Tue, 17 Nov 2026 22:42:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 38DBE60C4F1; Tue, 17 Nov 2026 22:42:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 36B5613B61E;
 Tue, 17 Nov 2026 22:42:30 +0100 (CET)
Date: Tue, 17 Nov 2026 22:42:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kevin Wolf <kwolf@redhat.com>
cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <avzDYfG-cPiWaCZ6@redhat.com>
Message-ID: <740c20c7-f8c2-bcb5-4669-d996a8a90cda@eik.bme.hu>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com> <avy4mkin-orpwskO@redhat.com>
 <avzDYfG-cPiWaCZ6@redhat.com>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026, Kevin Wolf wrote:
> Am 17.11.2026 um 21:40 hat Eric Blake geschrieben:
>> [Chiming in late]
>>
>> On Wed, Sep 30, 2026 at 10:54:30AM +0200, Paolo Bonzini wrote:
>>> Until now QEMU's code provenance policy declined any contribution
>>> believed to include or derive from AI-generated content.  A blanket ban
>>> was easy to maintain while LLM output was rarely usable on its own, but
>>> as the tools improved an absolute prohibition has become harder to
>>> justify and enforce.
>>
>> That ban is still impacting contributions today:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg03382.html
>> https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg03845.html
>
> And at least those of Christian's patches that I merged are a good
> example of how AI-assisted doesn't automatically mean bad quality. These
> patches were great, some of them better than the average human-only
> patch. I assume that he still spent significant time on these patches
> and didn't just send out the first thing AI gave him - which is how AI
> should be used.

The problem is not people using AI but people using AI who otherwise have 
no idea what they are doing and send the slop unreviewed and untested (or 
submit tickets that way) which will put all the work to understand and 
test these patches and tickets on maintainers. This might be OK for simple 
fixes, one liners or trivial patches but causes problem for larger 
changes, So this policy is meant to make that clear to not do that and AI 
usage is only allowed if the submitter does the work of reviewing and 
testing the generated patches before submission and has enough 
understanding to do that and answer review comments themselves. As people 
who are sending slop probably won't read this policy either I hope the AIs 
will follow AGENTS.md and tell them.

I've also come across another project where the AGENTS.md said agents 
should not create any tickets, humans should do that by hand (which 
probably filters the fire and forget people at least) and that AI should 
prefix generated patch subjects with [AI] (we have AI-used-for tag here 
that's similar) and also to prefix any generated text with a robot emoji. 
That's probably overkill but the point is to tell AI in AGENTS.md to mark 
generated content itself so it's easy to see at review. Just mentioning 
it what I saw others doing who don't want unreviewed AI content, not 
proposing we do the same. But maybe putting in AGENTS.md that tickets 
submitted by agents should have an AI tag in title or somewhere easily 
filterable might help to put them at the end of the queue in triage?

Regards,
BALATON Zoltan

