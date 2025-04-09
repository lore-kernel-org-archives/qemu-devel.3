Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B0FC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2R4q-0003xl-Vd; Wed, 09 Apr 2025 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u2R4n-0003x4-B7
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:46:30 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u2R4k-0005di-H4
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:46:28 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id A7728151AEBCD;
 Wed,  9 Apr 2025 10:46:07 +0200 (CEST)
Message-ID: <b610c46f-3137-4fc9-a80a-6855e5884c6c@lauterbach.com>
Date: Wed, 9 Apr 2025 10:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, christian.boenig@lauterbach.com
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org> <87y0wahh65.fsf@draig.linaro.org>
 <87mscqiut6.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <87mscqiut6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1744188367691
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08.04.2025 16:37, Markus Armbruster wrote:

> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>
>>>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>>>
>>>>>> Apologies for the line wrapping in yesterday's answer. Should be fixed now.
>>>>>>
>>>>>> On 08.04.2025 09:00, Markus Armbruster wrote:
>>>
>>> [...]
>>>
>>>>>>> What about providing the MCD interface as a separate QMP-like protocol?
>>>>>>> It gets its own QAPI schema, just like for qemu-ga.  Simplifies
>>>>>>> compiling it out when not needed.
>>>>>>>
>>>>>>> It gets its own socket, just like the GDB stub.  Might reduce
>>>>>>> interference between debugging and QMP.
>>>>>>>
>>>>>>> Thoughts?  Alex, Philippe, care to chime in?
>>>>>>
>>>>>> Sound reasonable to me. Keeping in mind the size of generated QAPI code,
>>>>>> an option to `./configure [...] --enable-mcd` is definitely advisable.
>>>>>
>>>>> Alex, Philippe?
>>>>
>>>> When I spoke to Mario at DVCon last year I liked the idea of re-using
>>>> QMP instead of inventing yet another RPC interface for QEMU. QMP
>>>> certainly has nicer properties than the gdbstub which has a very
>>>> "organic" and "serial" feel to it.
>>>>
>>>> Are you suggesting we re-use the machinery but use an entirely separate
>>>> socket with just the MCD namespace in it? I don't see that being a
>>>> problem as long as we can test it properly in the CI.
>>>
>>> Yes.
>>>
>>> "Keep them separate" is only a gut feeling, though.  While I pay
>>> attention to my gut feelings, I know they can be wrong.  I am soliciting
>>> opinions.
>>
>> I forgot to add isn't the flexibility of the QMP API something we need
>> to handle for single binary anyway?
> 
> I have no idea :)

Alex, thanks for chiming in! By "single binary", I assume you mean user
space emulation? In that case, could you elaborate whether and how it's
a concern related to MCD? Maybe I'm missing something here. MCD is
specifically designed for debugging multi-core SoCs and therefore
currently only supported in system emulation. For user-space debugging,
I don't see any reason why not to use GDB's remote serial protocol.

> Evolving a target-dependent interface into a target-independent
> interface without breaking compatibility is always a bother.
> 
> It's likely more of a bother when the interface is binary.  Textual
> interfaces tend to have less target-dependence.
> 
> Designing a target-independent interface is probably easier than
> evolving it compatibly from a target-dependent one.

Like the gdbstub, the MCD implementation does not have any
target-specific dependencies. This is also a change compared to the last
patch set and something I wanted to point out with

> Architecture-independent MCD implementation

But, again, maybe I'm missing something.

> QMP is textual, and it's designed for certain kinds of compatible
> evolution.  Using QAPI/QMP for a debugging interface may be a perfectly
> sensible idea.  I don't know enough about debugging interfaces to judge.

Even though MCD is a very stable API (developed in 2008, functions
haven't changed since then), as you've already pointed out, it's bold to
assume that it will never change in the future. For that reason, MCD
provides the mcd_initialize_f function which can be used to communicate
the requested and implemented API versions. As long as that function
stays serializable over the RPC layer, evolution should be possible.

> Use of QAPI/QMP does not imply use of the QMP monitor.  We can keep the
> monitor and the debugging interface separate even though both are based
> on QAPI/QMP.
> 
> The monitor code is gnarly, I'm afraid.  It supports multiple monitors,
> but they are not fully independent for historical reasons, chiefly
> implied mutual exclusion for commands.  Adding a QAPI/QMP-based
> debugging interface without undue coupling to monitors may pose a few
> technical problems.  One way to find out.

If I understand you correctly, when QAPI-MCD runs on a separate socket
without using a monitor, it's still coupled to the monitor code
internally? Does this have an influence on the either the usage of a
monitor or the MCD interface or is it rather an implementation detail?


