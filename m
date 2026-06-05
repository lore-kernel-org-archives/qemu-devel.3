Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AFCCD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVTq2-0008NG-NO; Fri, 05 Jun 2026 08:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wVTpy-0008N3-8u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 08:39:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wVTpv-0002zO-Lg
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 08:39:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F60159694F;
 Fri, 05 Jun 2026 14:39:38 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id XnCy9jgdYaD9; Fri,  5 Jun 2026 14:39:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD890596945; Fri, 05 Jun 2026 14:39:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DB1545968DE;
 Fri, 05 Jun 2026 14:39:35 +0200 (CEST)
Date: Fri, 5 Jun 2026 14:39:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <aiKjupJNo5wLB4Du@redhat.com>
Message-ID: <1cb908e1-2d9a-3333-240e-1f7023c5c09e@eik.bme.hu>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com> <20260605051949-mutt-send-email-mst@kernel.org>
 <aiKZQ2VVnERuUKt0@redhat.com> <20260605054212-mutt-send-email-mst@kernel.org>
 <aiKjupJNo5wLB4Du@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1767147633-1780663175=:92009"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1767147633-1780663175=:92009
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 5 Jun 2026, Daniel P. Berrangé wrote:
> On Fri, Jun 05, 2026 at 05:48:37AM -0400, Michael S. Tsirkin wrote:
>> On Fri, Jun 05, 2026 at 10:39:15AM +0100, Daniel P. Berrangé wrote:
>>> On Fri, Jun 05, 2026 at 05:25:36AM -0400, Michael S. Tsirkin wrote:
>>>> On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
>>>>> On Thu, Jun 04, 2026 at 12:37:58PM +0200, Paolo Bonzini wrote:
>>>>>> Il mer 3 giu 2026, 19:54 Daniel P. Berrangé <berrange@redhat.com> ha
>>>>>> scritto:
>>>>>>
>>>>>>> The AI policy should just
>>>>>>> make a point that we expect to be communicating with people not
>>>>>>> bots pretending to be people.
>>>>>>>
>>>>>>
>>>>>> Yes, it's better to have that stated clearly.
>>>>>>
>>>>>>> True but we also need a rule. The spirit is better explained elsewhere
>>>>>>>> (and also, building consensus on spirit vs. a rule are two different
>>>>>>>> things).
>>>>>>>
>>>>>>> Do we have a better elsewhere in this case ?  It is a point specifically
>>>>>>> about intent of the AI policy rule.
>>>>>>
>>>>>>
>>>>>> The rule in this draft says 20 lines, tests, mechanical changes and docs.
>>>>>> The spirit is what is in the commit message, basically to maximize the
>>>>>> benefit and limit the possible damage?
>>>>>
>>>>> Putting "the spirit" in the commit message is essentially /dev/null to
>>>>> anyone reading the policy later.
>>>>>
>>>>>>> See my reply to Peter elsewhere in the thread. I agree with your
>>>>>>>> concerns for both docs and discretion, but I had specific uses in mind
>>>>>>>> that I'd like to allow.
>>>>>>>>
>>>>>>>> For docs:
>>>>>>>> - create tutorials and/or feature documentation based on functional tests
>>>>>>>
>>>>>>> That doesn't sound too appealing to me. Reverse engineering docs or
>>>>>>> tutorials from our functional tests is exactly the kind of thing that feels
>>>>>>> likely to result in volumous text of marginal value which will have a large
>>>>>>> burden on reviewers.
>>>>>>>
>>>>>>
>>>>>> At the same time this can be helpful for maintainers themselves? Let's also
>>>>>> look at this from the point of view of producing better output, not just
>>>>>> from that of being on the receiving end of slop. Especially for docs I have
>>>>>> a hard time imagining people sending out whole new "manuals"... The
>>>>>> bugfixes rule ironically seems the most dangerous to me from the
>>>>>> Dunning-Krueger point of view.
>>>>>>
>>>>>> My question is: do we want disclosure for anything is created with the help
>>>>>> of LLMs, even if only small parts survive untouched? I think so, because a
>>>>>> lot more, even if edited, would still be originally from AI. But then it's
>>>>>> important to have rules allowing it and a way to track it.
>>>>>
>>>>> IMHO need unconditional disclosure, because the use of the LLM impacts
>>>>> the license of the code. QEMU is traditionally expected to be GPLv2+
>>>>> licensed for all new code, but there's the train of thought that LLM
>>>>> code is public domain.
>>>>> If it gets human editting afterwards we can
>>>>> consider that the human edits are GPLv2+ licensed, but IMHO we still
>>>>> want to know the origins.
>>>>
>>>> Wait that's a big ask.
>>>>
>>>> DOC explicitly does not ask if code might be available anywhere else
>>>> under any other license. Just that contributor can contribute under GPL.
>>>> If it's public domain then the human can license is under GPL.
>>>
>>> For new files, in checkpatch we validate that SPDX-License-Identifier
>>> is explicitly set as GPL-2.0-or-later. Contributors are expected to
>>> justify any divergence in the commit message.
>>>
>>> I've seen guidance that SPDX-License-Identifier for AI output code
>>> should NOT state a license, under the theory it is public domain.
>>
>> Not state a license? Recommended by a lawyer? Seen where? Why?
>
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
>
>  "The harder case is when an entire source file, or even
>   an entire repository, is generated by AI. Here, adding
>   a copyright and license notice may be inappropriate
>   unless and until human contributions transform the file
>   into a copyrightable work. "
>
> I interpret that to suggest we should not automatically use
> SPDX-License-Identifier: GPL-2.0-or-later on LLM generated
> code, unless subsequent human editting was non-trivial.

The presumtion that LLM generated code is public domain is dubious. If you 
tell it to regenerate part of QEMU source after it has seen the GPL 
sources and it comes up with something equivalent does that make the 
generated version public domain? If so people could just rewrite GPL code 
and make it proprietary. This can't be right as the generated code will 
likely contain parts copied from the original so still fall under GPL. 
What if I just tell LLM to rewrite QEMU in C++? Will that make a public 
domain version that I can then make closed source even though it still 
contains large parts of GPL code? I don't think so. The code generated by 
LLM comes from somewhere but nobody can tell where from so also nobody 
knows what licence it is. If you're lucky it comes from examples or other 
sources with a free licence but could be anything even some open source 
code not compatible with GPL or proprietary code. The idea of public 
domain probably comes from that there's no human to hold the copyright but 
what about cases of copying copyleft code by LLM that should not make it 
public domain. This is similar to the case when somebody who worked on a 
proprietary code before then writes some open source code that does 
similar things or vice versa. What is the legal status of those cases? Can 
the other party claim copyright for the code? Probably only if the person 
recalls whole parts that resemble each other closely which could happen. 
The risk is probably the same with LLMs and thus the handling of this 
should be similar probably. This seems more complex than assuming anthing 
from an LLM is public domain.

>>> Ultimately QEMU is a copyleft project as a whole and IMHO we should
>>> prioritize retaining that for as large a portion of the codebase is
>>> is practical.
>>
>> But of course. We can make this explicit too: that
>> contributing it should be under GPL and/or implies licensing it under GPL.
>
> The subtlety is that generally when changing an existing file, you assume
> the edits are under the same licence as the initial code being editted.
>
> If the initial code is LLM generated & thus presumed public domain, it
> might be inferred that human edits are public domain too. I don't think
> we want to have that interpretation and should be explicit that human
> edits to LLM code in code are assumed to be GPL-2.0-or-later licensed
> unless explicitly stated to the contrary.

The LICENSE file in QEMU says that sources without a licence are 
GPL-2.0-or-later so if you add public domain code, it will be that licence 
as part of QEMU and won't retain original public domain status.

Regards,
BALATON Zoltan
--3866299591-1767147633-1780663175=:92009--

