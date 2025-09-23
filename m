Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A302FCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 17:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v16xh-0005gc-4O; Tue, 23 Sep 2025 13:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1v16xe-0005g5-48; Tue, 23 Sep 2025 13:37:54 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1v16xX-00089o-Jy; Tue, 23 Sep 2025 13:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1758649050;
 bh=Sa6lvqhr049XeA+Jq9HMN0lampgwYAxIOoDrrlaLxYg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ymFNBlh81Gd6+263LU25k5551gyvpCvxg2zd2yondqCDMCmeG2Dha0DP6thrK7KpM
 5aC5d4jNr7mLFjKnD58JT4bnVTWSJVAjTCTtSYIBM5TcNpXlxOX9ZxrQ01UTSSqdea
 ObZcdQvNXo5/yqtQMx/bgY6WeXBJcRYqJNYn3th0VNI4mxdSdaboqdNxM/+sjyzihh
 GjZg/AfTQBykMNiUa7zJhtNwHJGeZ+MGb1eHWnoPeHFJt/+ImB+w5Fbvm25r5bHEMj
 2Uj7mF/KBR9qNDt62aVQSnq1VSLyVaaIyCOYqy43hxBCVsEm8Wc0MK7jUp+067mkoQ
 m85kkffNba+Hw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id DC13C40293;
 Tue, 23 Sep 2025 19:37:30 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id D6A51FF998;
 Tue, 23 Sep 2025 19:37:30 +0200 (CEST)
Received: from [192.168.1.62] (35.201.90.79.rev.sfr.net [79.90.201.35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id CAE88400CB;
 Tue, 23 Sep 2025 19:37:29 +0200 (CEST)
Message-ID: <640a2527-6eb1-4d82-8d39-b1fbc6399b48@univ-grenoble-alpes.fr>
Date: Tue, 23 Sep 2025 19:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] Adding partial support for 128-bit riscv target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, bin.meng@windriver.com,
 richard.henderson@linaro.org, palmer@dabbelt.com,
 fabien.portas@grenoble-inp.org, alistair.francis@wdc.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20220106210108.138226-1-frederic.petrot@univ-grenoble-alpes.fr>
 <c5c8566a-fd0d-48d1-8ed1-e52f0bb4f210@linaro.org>
 <CAKmqyKN51+jriKkSL8V5EFc9hBSFoEHYKp-70uP6RvO_K6a=pg@mail.gmail.com>
 <9ae32149-fe18-49d3-a689-60ee6752c20d@univ-grenoble-alpes.fr>
 <CAKmqyKO4GYqJ5GcvEc+yL4d01ONzDLR=2Ava7Disw2aSOZVFsg@mail.gmail.com>
 <498b3a87-e3dc-4a4f-b5e2-1bd79700e8c0@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <498b3a87-e3dc-4a4f-b5e2-1bd79700e8c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Philippe,

Le 23/09/2025 à 15:47, Philippe Mathieu-Daudé a écrit :
> Hi Frédéric,
> 
> On 7/4/25 01:25, Alistair Francis wrote:
>> On Mon, Apr 7, 2025 at 4:24 AM Frédéric Pétrot
>> <frederic.petrot@univ-grenoble-alpes.fr> wrote:
>>>
>>> Hi Alistair, Phil,
>>> well, I'm trying to keep the thing alive, checking from time to time that
>>> the current QEMU still runs the 128-bit tests that I have, and on which
>>> I continue (slowly) to do stuffs.
> 
> Are you able to share your tests?

   Sure, I have that on github (https://github.com/fpetrot/128-test) but
   they are not exactly easy to integrate in upstream qemu because we
   assume an elf-128 toolchain to produce elf-128 executables.
   So your below proposal is probably the best way to go! >
> Otherwise, could you add a simple one in tests/tcg/riscv128,
> based on tests/tcg/riscv64/?

   Sure, I'll do that in the coming days!

>> If it's being used then I don't see any issue keeping it
> 
> With no guest test code, it is hard to make distinction with
> dead code... We'd like to be sure we don't bitrot this, while
> doing heavy refactorings.

   I perfectly understand.
   Cheers,
   Frédéric
   >
> Thanks,
> 
> Phil.
> 
>>
>> Alistair
>>
>>> I hope this can stay upstream for experimental/research purposes, but the
>>> 128-bit riscv community is, I follow you on that, scarce for now.
>>>
>>> So, your call.
>>> Cheers,
>>> Frédéric
>>>
>>> Le 04/04/2025 à 05:26, Alistair Francis a écrit :
>>>> On Sat, Mar 22, 2025 at 1:09 AM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 6/1/22 22:00, Frédéric Pétrot wrote:
>>>>>> This series of patches provides partial 128-bit support for the riscv
>>>>>> target architecture, namely RVI and RVM, with minimal csr support.
>>>>>
>>>>>
>>>>>> Frédéric Pétrot (18):
>>>>>>      exec/memop: Adding signedness to quad definitions
>>>>>>      exec/memop: Adding signed quad and octo defines
>>>>>>      qemu/int128: addition of div/rem 128-bit operations
>>>>>>      target/riscv: additional macros to check instruction support
>>>>>>      target/riscv: separation of bitwise logic and arithmetic helpers
>>>>>>      target/riscv: array for the 64 upper bits of 128-bit registers
>>>>>>      target/riscv: setup everything for rv64 to support rv128 execution
>>>>>
>>>>>
>>>>> I see this series has been merged as commit afe33262585, with
>>>>> 332dab68785b describing:
>>>>>
>>>>>        This patch adds the support of the '-cpu rv128' option to
>>>>>        qemu-system-riscv64 so that we can indicate that we want to
>>>>>        run rv128 executables.
>>>>>
>>>>>        Still, there is no support for 128-bit insns at that stage
>>>>>        so qemu fails miserably (as expected) if launched with this
>>>>>        option.
>>>>>
>>>>> Is this code tested? 3 years passed so I wonder about possible
>>>>> code bitrot here.
>>>>
>>>>   From memory at the time there was some momentum for RV128. So this was
>>>> merged with the expectation that it would continue to improve.
>>>>
>>>> That doesn't seem to have happened, either software or spec wise though.
>>>>
>>>>>
>>>>> (I reached this code by looking at targets not supporting MTTCG).
>>>>
>>>> I'm happy to remove the CPU if it's blocking you, it's experimental so
>>>> it doesn't need to be deprecated or anything fancy.
>>>>
>>>> Alistair
>>>>
>>>>>
>>>>>>      target/riscv: moving some insns close to similar insns
>>>>>>      target/riscv: accessors to registers upper part and 128-bit load/store
>>>>>>      target/riscv: support for 128-bit bitwise instructions
>>>>>>      target/riscv: support for 128-bit U-type instructions
>>>>>>      target/riscv: support for 128-bit shift instructions
>>>>>>      target/riscv: support for 128-bit arithmetic instructions
>>>>>>      target/riscv: support for 128-bit M extension
>>>>>>      target/riscv: adding high part of some csrs
>>>>>>      target/riscv: helper functions to wrap calls to 128-bit csr insns
>>>>>>      target/riscv: modification of the trans_csrxx for 128-bit support
>>>>>>      target/riscv: actual functions to realize crs 128-bit insns
>>>>>
>>>>>
>>>
>>> -- 
>>> +---------------------------------------------------------------------------+
>>> | Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
>>> | Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
>>> | http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
>>> +---------------------------------------------------------------------------+
>>>
> 

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


