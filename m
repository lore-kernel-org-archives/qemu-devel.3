Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2666CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 22:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs90r-0007fa-Ee; Wed, 03 Apr 2024 18:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rs90q-0007fL-Ii; Wed, 03 Apr 2024 18:23:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rs90n-0004Bc-NP; Wed, 03 Apr 2024 18:23:20 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BA28F4E601C;
 Thu,  4 Apr 2024 00:23:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id IYl2I0f9t0Zf; Thu,  4 Apr 2024 00:23:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7456A4E6004; Thu,  4 Apr 2024 00:23:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 72B507456FE;
 Thu,  4 Apr 2024 00:23:09 +0200 (CEST)
Date: Thu, 4 Apr 2024 00:23:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: TCG change broke MorphOS boot on sam460ex
In-Reply-To: <D0A8CN9E4ZZG.3RV43XZWO6S5H@gmail.com>
Message-ID: <48cbfaa1-82f9-d98b-a6c5-b06051b6c6a5@eik.bme.hu>
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
 <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
 <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
 <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
 <D0A8CN9E4ZZG.3RV43XZWO6S5H@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1312722301-1712182989=:78889"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1312722301-1712182989=:78889
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 3 Apr 2024, Nicholas Piggin wrote:
> On Tue Apr 2, 2024 at 9:32 PM AEST, BALATON Zoltan wrote:
>> On Thu, 21 Mar 2024, BALATON Zoltan wrote:
>>> On 27/2/24 17:47, BALATON Zoltan wrote:
>>>> Hello,
>>>>
>>>> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting
>>>> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified it
>>>> before that release but apparently missed it back then). It can be
>>>> reproduced with https://www.morphos-team.net/morphos-3.18.iso and following
>>>> command:
>>>>
>>>> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
>>>>    -drive if=none,id=cd,format=raw,file=morphos-3.18.iso \
>>>>    -device ide-cd,drive=cd,bus=ide.1
>>
>> Any idea on this one? While MorphOS boots on other machines and other OSes
>> seem to boot on this machine it may still suggest there's some problem
>> somewhere as this worked before. So it may worth investigating it to make
>> sure there's no bug that could affect other OSes too even if they boot. I
>> don't know how to debug this so some help would be needed.
>
> In the bad case it crashes after running this TB:
>
> ----------------
> IN:
> 0x00c01354:  38c00040  li       r6, 0x40
> 0x00c01358:  38e10204  addi     r7, r1, 0x204
> 0x00c0135c:  39010104  addi     r8, r1, 0x104
> 0x00c01360:  39410004  addi     r10, r1, 4
> 0x00c01364:  39200000  li       r9, 0
> 0x00c01368:  7cc903a6  mtctr    r6
> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> 0x00c01384:  39290001  addi     r9, r9, 1
> 0x00c01388:  4200ffe4  bdnz     0xc0136c
> ----------------
> IN:
> 0x00c01374: unable to read memory
> ----------------
>
> "unable to read memory" is the tracer, it does actually translate
> the address, but it points to a wayward real address which returns
> 0 to TCG, which is an invalid instruction.
>
> The good case instead doesn't exit the TB after 0x00c01370 but after
> the complete loop at the bdnz. That look like this after the same
> first TB:
>
> ----------------
> IN:
> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
> 0x00c01384:  39290001  addi     r9, r9, 1
> 0x00c01388:  4200ffe4  bdnz     0xc0136c
> ----------------
> IN:
> 0x00c0138c:  4c00012c  isync
>
> All the tlbwe are executed in the same TB. MMU tracing shows the
> first tlbwehi creates a new valid(!) TLB for 0x00000000-0x100000000
> that has a garbage RPN because the tlbwelo did not run yet.
>
> What's happening in the bad case is that the translator breaks
> and "re-fetches" instructions in the middle of that sequence, and
> that's where the bogus translation causes 0 to be returned. The
> good case the whole block is executed in the same fetch which
> creates correct translations.
>
> So it looks like a morphos bug, the can-do-io change just happens
> to cause it to re-fetch in that place, but that could happen for
> a number of reasons, so you can't rely on TLB *only* changing or
> ifetch *only* re-fetching at a sync point like isync.

Thanks a lot for the analysis. Probably ir works on real machine due to 
cache effects so maybe it was just luck this did not break.

> I would expect code like this to write an invalid entry with tlbwehi,
> then tlbwelo to set the correct RPN, then make the entry valid with
> the second tlbwehi. It would probably fix the bug if you just did the
> first tlbwehi with r6=0 (or at least without the 0x200 bit set).

I think I had to fix a similar issue in AROS years ago when I've first 
tried to make sam460ex emulation work and used AROS for testing:
https://github.com/aros-development-team/AROS/commit/586a8ada8a5b861a77cab177d39e01de8c3f4cf5

I can't fix MorphOS as it's not open source but hope MorphOS people will 
get to know about this and do something with it. It still works better on 
other emulated machines such as pegasos2 and mac99 so it's not a big deal, 
just wanted to make sure it would not be a bug that could affect other 
OSes on sam460ex.

Thank you,
BALATON Zoltan
--3866299591-1312722301-1712182989=:78889--

