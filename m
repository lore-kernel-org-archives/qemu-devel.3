Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA56DC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trjZ7-0001j5-Vy; Mon, 10 Mar 2025 16:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trjZ4-0001ib-LR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:17:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trjZ1-0006eD-0W
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 16:17:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF9A34E6030;
 Mon, 10 Mar 2025 21:17:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id QuCQl0snJWVN; Mon, 10 Mar 2025 21:17:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E53994E601A; Mon, 10 Mar 2025 21:17:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E327974577C;
 Mon, 10 Mar 2025 21:17:18 +0100 (CET)
Date: Mon, 10 Mar 2025 21:17:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
In-Reply-To: <4c2ee71d-6d7c-436d-8608-e4aec71c4df0@linaro.org>
Message-ID: <d2b5f9b9-f567-5434-d9b3-05c0ea9b5b1c@eik.bme.hu>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
 <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
 <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
 <e20b6a44-b371-4154-8dc9-5f3cb4a3f570@linaro.org>
 <4c2ee71d-6d7c-436d-8608-e4aec71c4df0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-293031111-1741637838=:88066"
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

--3866299591-293031111-1741637838=:88066
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Pierrick Bouvier wrote:
> On 3/10/25 09:53, Richard Henderson wrote:
>> On 3/10/25 09:43, Pierrick Bouvier wrote:
>>> On 3/10/25 09:37, Richard Henderson wrote:
>>>> On 3/10/25 09:14, Pierrick Bouvier wrote:
>>>>> On 3/10/25 09:08, Richard Henderson wrote:
>>>>>> On 3/9/25 21:58, Pierrick Bouvier wrote:
>>>>>>> For now, they are duplicate of the same macros in cpu-all.h that we
>>>>>>> eliminate in next commit.
>>>>>>> 
>>>>>>> Keep code readable by not defining them with macros, but simply their
>>>>>>> implementation.
>>>>>>> 
>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> 
>>>>>> Why do you want these in bswap.h, rather than tswap.h?
>>>>>> They're target swaps, after all.
>>>>>> 
>>>>>> 
>>>>>> r~
>>>>> 
>>>>> No preference on that, I simply added them to the same file than their 
>>>>> explicit endianness
>>>>> variant. Would you prefer the endianness agnostic variant to be in 
>>>>> tswap.h instead?
>>>> 
>>>> I think I would.
>>> 
>>> Ok, I will move it.
>>> 
>>>> 
>>>> In addition, I think we want
>>>> 
>>>> #ifdef COMPILING_PER_TARGET
>>>> #define target_words_bigendian()  TARGET_BIG_ENDIAN
>>>> #else
>>>> bool target_words_bigendian(void);
>>>> #endif
>>>> 
>>>> moving the conditional from around target_needs_bswap just below.
>>>> 
>>>> With that, we eliminate the extra branch that you're otherwise
>>>> adding to target-specific code with this patch.
>>>> 
>>> 
>>> I understand the change requested, but should we really aim in that 
>>> direction? In the end,
>>> if we pursue the compilation units deduplication, the branch will be 
>>> present anyway.
>>> 
>>> I'm ok with your change, just asking if we really want to preserve target 
>>> specific code
>>> until the "end".
>> 
>> All of target/ is target specific.  De-duplication will not eliminate that.
>> 
>
> My vocabulary was wrong here. I meant "if we want to preserve target specific 
> macros" until the end.
> Sure, there will always be compilation units (devices, cpus, helpers, ...) 
> specific to a target. I just wonder if sticking to ifdef paradigm for this 
> kind of code is worth the "optimization" we are supposed to get.

I've already tried to say that in the previous reply but maybe I can 
explain it better here. I think keeping per target binaries would be 
desired so single binary would not replace it just become an additional 
option. For example when I want to play with old stuff I compile with 
--target-list=ppc-softmmu and don't want to wait compiling all the other 
targets I don't use and not even interested in PPC64. A distro may want to 
ship a single qemu-system binary instead but other distros may prefer per 
target packages not one huge package so users can decide which ones to 
install. All of these are valid use cases, therefore this single binary 
should be an additional option not the only true way from now on 
replacing existing per target builds.

Regards,
BALATON Zoltan

> I'll add the change requested.
>
>> 
>> r~
>
>
--3866299591-293031111-1741637838=:88066--

