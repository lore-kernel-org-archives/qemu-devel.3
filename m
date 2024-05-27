Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D03C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 22:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBjFR-0004hT-Iy; Mon, 27 May 2024 18:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBjFQ-0004h9-0m; Mon, 27 May 2024 18:55:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBjFM-0001wj-Jc; Mon, 27 May 2024 18:55:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A40384E6004;
 Tue, 28 May 2024 00:55:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id o_UhACqbAKQi; Tue, 28 May 2024 00:55:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5624F4E6001; Tue, 28 May 2024 00:55:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 53E6D7470B7;
 Tue, 28 May 2024 00:55:11 +0200 (CEST)
Date: Tue, 28 May 2024 00:55:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: TCG change broke MorphOS boot on sam460ex
In-Reply-To: <01b67a5a-111c-ba3a-f51d-9c8a5b228500@eik.bme.hu>
Message-ID: <db82c283-5b16-7dab-c0b5-b0c04ac752e7@eik.bme.hu>
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
 <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
 <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
 <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
 <D0A8CN9E4ZZG.3RV43XZWO6S5H@gmail.com>
 <01b67a5a-111c-ba3a-f51d-9c8a5b228500@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-878347133-1716850511=:90539"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-878347133-1716850511=:90539
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 May 2024, BALATON Zoltan wrote:
> On Wed, 3 Apr 2024, Nicholas Piggin wrote:
>> On Tue Apr 2, 2024 at 9:32 PM AEST, BALATON Zoltan wrote:
>>> On Thu, 21 Mar 2024, BALATON Zoltan wrote:
>>>> On 27/2/24 17:47, BALATON Zoltan wrote:
>>>>> Hello,
>>>>> 
>>>>> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting
>>>>> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified 
>>>>> it
>>>>> before that release but apparently missed it back then). It can be
>>>>> reproduced with https://www.morphos-team.net/morphos-3.18.iso and 
>>>>> following
>>>>> command:
>>>>> 
>>>>> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
>>>>>    -drive if=none,id=cd,format=raw,file=morphos-3.18.iso \
>>>>>    -device ide-cd,drive=cd,bus=ide.1
>>> 
>>> Any idea on this one? While MorphOS boots on other machines and other OSes
>>> seem to boot on this machine it may still suggest there's some problem
>>> somewhere as this worked before. So it may worth investigating it to make
>>> sure there's no bug that could affect other OSes too even if they boot. I
>>> don't know how to debug this so some help would be needed.
>> 
>> In the bad case it crashes after running this TB:
>> 
>> ----------------
>> IN:
>> 0x00c01354:  38c00040  li       r6, 0x40
>> 0x00c01358:  38e10204  addi     r7, r1, 0x204
>> 0x00c0135c:  39010104  addi     r8, r1, 0x104
>> 0x00c01360:  39410004  addi     r10, r1, 4
>> 0x00c01364:  39200000  li       r9, 0
>> 0x00c01368:  7cc903a6  mtctr    r6
>> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
>> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
>> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
>> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
>> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
>> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
>> 0x00c01384:  39290001  addi     r9, r9, 1
>> 0x00c01388:  4200ffe4  bdnz     0xc0136c
>> ----------------
>> IN:
>> 0x00c01374: unable to read memory
>> ----------------
>> 
>> "unable to read memory" is the tracer, it does actually translate
>> the address, but it points to a wayward real address which returns
>> 0 to TCG, which is an invalid instruction.
>> 
>> The good case instead doesn't exit the TB after 0x00c01370 but after
>> the complete loop at the bdnz. That look like this after the same
>> first TB:
>> 
>> ----------------
>> IN:
>> 0x00c0136c:  84c70004  lwzu     r6, 4(r7)
>> 0x00c01370:  7cc907a4  tlbwehi  r6, r9
>> 0x00c01374:  84c80004  lwzu     r6, 4(r8)
>> 0x00c01378:  7cc90fa4  tlbwelo  r6, r9
>> 0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
>> 0x00c01380:  7cc917a4  tlbwehi  r6, r9
>> 0x00c01384:  39290001  addi     r9, r9, 1
>> 0x00c01388:  4200ffe4  bdnz     0xc0136c
>> ----------------
>> IN:
>> 0x00c0138c:  4c00012c  isync
>> 
>> All the tlbwe are executed in the same TB. MMU tracing shows the
>> first tlbwehi creates a new valid(!) TLB for 0x00000000-0x100000000
>> that has a garbage RPN because the tlbwelo did not run yet.
>> 
>> What's happening in the bad case is that the translator breaks
>> and "re-fetches" instructions in the middle of that sequence, and
>> that's where the bogus translation causes 0 to be returned. The
>> good case the whole block is executed in the same fetch which
>> creates correct translations.
>> 
>> So it looks like a morphos bug, the can-do-io change just happens
>> to cause it to re-fetch in that place, but that could happen for
>> a number of reasons, so you can't rely on TLB *only* changing or
>> ifetch *only* re-fetching at a sync point like isync.
>> 
>> I would expect code like this to write an invalid entry with tlbwehi,
>> then tlbwelo to set the correct RPN, then make the entry valid with
>> the second tlbwehi. It would probably fix the bug if you just did the
>> first tlbwehi with r6=0 (or at least without the 0x200 bit set).
>
> Revisiting this, I've found in the docs that PPC440 has shadow TLBs so this 
> code can rely upon the TLB not being invalidated until isync and works on 
> real machine but breaks on QEMU. We would either need to make sure the TB 
> runs until the sync or somehow emulate the shadow TLB. I've experimented with 
> the latter but I could not make it work (and unexpectedly keeping a cache of 
> the most recently used entries is slower than always searching through all 
> TLB entries as done now so I've abandoned that idea). The problem is that an 
> entry is modified by multiple tlbwe instructions but these can come in any 
> order (and sometimes only one of them is done like invalidating an entry 
> seems to only do one write) so I don't know when to copy the new entry to the 
> TLB and when to wait for more parts and keep the old one. Any idea how to fix 
> this?
>
> Also I'm not sure if it's related but by running the stream benchmark on 
> sam460ex now I can reproduce some memory access problem but I'm not sure what 
> causes it. The full output of that benchmark under AmigaOS on sam460ex is 
> this:
>
> -------------------------------------------------------------
> STREAM version $Revision: 5.10 $
> -------------------------------------------------------------
> This system uses 8 bytes per array element.
> -------------------------------------------------------------
> Array size = 10000000 (elements), Offset = 0 (elements)
> Memory per array = 76.3 MiB (= 0.1 GiB).
> Total memory required = 228.9 MiB (= 0.2 GiB).
> Each kernel will be executed 10 times.
> The *best* time for each kernel (excluding the first iteration)
> will be used to compute the reported bandwidth.
> -------------------------------------------------------------
> Your clock granularity/precision appears to be 3 microseconds.
> Each test below will take on the order of 186279 microseconds.
>   (= 62093 clock ticks)
> Increase the size of the arrays if this shows that
> you are not getting at least 20 clock ticks per test.
> -------------------------------------------------------------
> WARNING -- The above is only a rough guideline.
> For best results, please be sure you know the
> precision of your system timer.
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            1723.8     0.095517     0.092821     0.103645
> Scale:            790.2     0.206338     0.202479     0.214062
> Add:              994.7     0.246171     0.241289     0.256950
> Triad:            763.2     0.323731     0.314454     0.343873
> -------------------------------------------------------------
> Failed Validation on array a[], AvgRelAbsErr > epsilon (1.000000e-13)
>     Expected Value: 1.153301e+12, AvgAbsErr: 1.137394e+12, AvgRelAbsErr: 
> 9.862079e-01
>     For array a[], 9863168 errors were found.
> Failed Validation on array b[], AvgRelAbsErr > epsilon (1.000000e-13)
>     Expected Value: 2.306602e+11, AvgAbsErr: 2.274872e+11, AvgRelAbsErr: 
> 9.862438e-01
>     AvgRelAbsErr > Epsilon (1.000000e-13)
>     For array b[], 9863168 errors were found.
> Failed Validation on array c[], AvgRelAbsErr > epsilon (1.000000e-13)
>     Expected Value: 3.075469e+11, AvgAbsErr: 3.033024e+11, AvgRelAbsErr: 
> 9.861989e-01
>     AvgRelAbsErr > Epsilon (1.000000e-13)
>     For array c[], 9863168 errors were found.
> -------------------------------------------------------------
>
> while on amigaone or pegasos2 the same executable finishes with:
> -------------------------------------------------------------
> Solution Validates: avg error less than 1.000000e-13 on all three arrays
> -------------------------------------------------------------
>
> On a real Sam460EX this same executable also validates as confirmed here:
> https://www.amigans.net/modules/newbb/viewtopic.php?post_id=148020#forumpost148020
>
> The binary and source is from here:
> http://os4depot.net/?function=showfile&file=utility/benchmark/stream.lha
>
> This binary runs on QEMU amigaone and pegasos2 that use G4 and validates so 
> only seems to be a problem with 460EX. I've compiled the source for PPC Linux 
> and tried running that with qemu-ppc linux-user to verify it which does not 
> use MMU so it's expected to work and it does:
>
> $ qemu-ppc -cpu 460ex streamPPC
> -------------------------------------------------------------
> Based on STREAM version $Revision: 5.10 $
> -------------------------------------------------------------
> This system uses 8 bytes per array element.
> -------------------------------------------------------------
> Array size = 10000000 (elements), Offset = 0 (elements)
> Memory per array = 76.3 MiB (= 0.1 GiB).
> Total memory required = 228.9 MiB (= 0.2 GiB).
> Each kernel will be executed 10 times.
> The *best* time for each kernel (excluding the first iteration)
> will be used to compute the reported bandwidth.
> -------------------------------------------------------------
> Your clock granularity/precision appears to be 1 microseconds.
> Each test below will take on the order of 192649 microseconds.
>   (= 192649 clock ticks)
> Increase the size of the arrays if this shows that
> you are not getting at least 20 clock ticks per test.
> -------------------------------------------------------------
> WARNING -- The above is only a rough guideline.
> For best results, please be sure you know the
> precision of your system timer.
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            3191.5     0.050227     0.050133     0.050584
> Scale:            889.5     0.181873     0.179880     0.183075
> Add:             1174.7     0.207856     0.204303     0.213941
> Triad:            683.0     0.354251     0.351415     0.358936
> -------------------------------------------------------------
> Solution Validates: avg error less than 1.000000e-13 on all three arrays
> Results Validation Verbose Results:
>    Expected a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 
> 307546875000.000000
>    Observed a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 
> 307546875000.000000
>    Rel Errors on a, b, c:     0.000000e+00 0.000000e+00 0.000000e+00
> -------------------------------------------------------------
>
> or compiled with -O3 that was said to be used for the AmigaOS binary it's 
> even better (as long as no FPU is used at least which is another known weak 
> point of QEMU):
>
> $ qemu-ppc -cpu 460ex streamPPCpowerpcO3
> -------------------------------------------------------------
> Based on STREAM version $Revision: 5.10 $
> -------------------------------------------------------------
> This system uses 8 bytes per array element.
> -------------------------------------------------------------
> Array size = 10000000 (elements), Offset = 0 (elements)
> Memory per array = 76.3 MiB (= 0.1 GiB).
> Total memory required = 228.9 MiB (= 0.2 GiB).
> Each kernel will be executed 10 times.
> The *best* time for each kernel (excluding the first iteration)
> will be used to compute the reported bandwidth.
> -------------------------------------------------------------
> Your clock granularity/precision appears to be 1 microseconds.
> Each test below will take on the order of 171833 microseconds.
>   (= 171833 clock ticks)
> Increase the size of the arrays if this shows that
> you are not getting at least 20 clock ticks per test.
> -------------------------------------------------------------
> WARNING -- The above is only a rough guideline.
> For best results, please be sure you know the
> precision of your system timer.
> -------------------------------------------------------------
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:            8931.7     0.017950     0.017914     0.018114
> Scale:           1078.1     0.151183     0.148407     0.153068
> Add:             1359.3     0.178790     0.176561     0.184122
> Triad:           1161.2     0.210525     0.206683     0.216876
> -------------------------------------------------------------
> Solution Validates: avg error less than 1.000000e-13 on all three arrays
> Results Validation Verbose Results:
>    Expected a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 
> 307546875000.000000
>    Observed a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 
> 307546875000.000000
>    Rel Errors on a, b, c:     0.000000e+00 0.000000e+00 0.000000e+00
> -------------------------------------------------------------
>
> Then I've tried booting Linux on QEMU sam460ex and run my compiled Linux exe 
> under that and it validates there so I could only reproduce this on AmigaOS

For completeness here's the run on sam460ex Linux:

$ ./streamPPCpowerpcO3
-------------------------------------------------------------
Based on STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
  The *best* time for each kernel (excluding the first iteration)
  will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 2 microseconds.
Each test below will take on the order of 169662 microseconds.
    (= 84831 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2143.7     0.075259     0.074636     0.076172
Scale:            846.4     0.190517     0.189029     0.192099
Add:             1043.7     0.232548     0.229945     0.237299
Triad:            814.4     0.299620     0.294695     0.309323
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
Results Validation Verbose Results:
     Expected a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 307546875000.000000
     Observed a(1), b(1), c(1): 1153300781250.000000 230660156250.000000 307546875000.000000
     Rel Errors on a, b, c:     0.000000e+00 0.000000e+00 0.000000e+00
-------------------------------------------------------------

> with the binary in stream.lha but that binary works on real machine so there 
> is some problem somewhere but I'm not sure what and how to debug it. I think 
> this may be related to TLB writes though as AmigaOS seems to do a lot of 
> those when running this test so maybe it hits some issues that does not 
> happen normally. Fixing the known issue with missing shadow TLB as found with 
> MorphOS might fix this too or we could at least rule that out then.

Also it's not something that broke recently and thus could be bisected. I 
get the same validation error with QEMU v8.2.0 before any embedded tlb 
changes or even before that so it may be something pre existing and then 
not related to the MorphOS boot problem above.

> I'm open to ideas on this one as I don't have any on how to proceed.
>
> Regards,
> BALATON Zoltan
--3866299591-878347133-1716850511=:90539--

