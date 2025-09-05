Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABDCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 19:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuc4a-0003sV-TB; Fri, 05 Sep 2025 15:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uuc4D-0003ol-Cu
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 15:25:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uuc40-0001YL-3D
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 15:25:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74EC056F29E;
 Fri, 05 Sep 2025 21:25:27 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uD5FRGSnOGZ7; Fri,  5 Sep 2025 21:25:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6423656F30D; Fri, 05 Sep 2025 21:25:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 623B656F288;
 Fri, 05 Sep 2025 21:25:25 +0200 (CEST)
Date: Fri, 5 Sep 2025 21:25:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Julian Ganz <neither@nut.email>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
Message-ID: <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1581212006-1757099900=:18226"
Content-ID: <768701e5-ec6c-a40f-cad4-7a5ae99f18a8@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--3866299591-1581212006-1757099900=:18226
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <e5f23854-ee6f-4828-93af-9840ae19de24@eik.bme.hu>

On Fri, 5 Sep 2025, Julian Ganz wrote:
> September 5, 2025 at 1:38 PM, "BALATON Zoltan" wrote:
>> On Thu, 4 Sep 2025, Julian Ganz wrote:
>>>  Even with the existing interfaces, it is more or less possible to
>>>  discern these situations, e.g. as done by the cflow plugin. However,
>>>  this process poses a considerable overhead to the core analysis one may
>>>  intend to perform.
>>>
>> I'd rather have overhead in the plugin than in interrupt and exception
>> handling on every target unless this can be completely disabled
>> somehow when not needed to not pose any overhead on interrupt handling
>> in the guest.
>
> The "more or less" is rather heavy here: with the current API there is
> no way to distinguish between interrupts and exceptions. Double-traps
> can probably only be detected if you don't rely on weird, very error
> prone heuristics around TB translations.
>
> And as Alex Benée pointed out, qemu can be easily built with plugins
> disabled.
>
>> Have you done any testing on how much overhead this adds
>> to interrupt heavy guest workloads? At least for PPC these are already
>> much slower than real CPU so I'd like it to get faster not slower.
>
> No, I have not made any performance measurements. However, given that
> for every single TB execution a similar hook is called already, the
> impact related to other existing plugin infrastructure _should_ be
> neglectible.
>
> That is, if your workload actually runs any code and is not constantly
> bombarded with interrupts that _do_ result in a trap (which _may_ happen
> during some tests).
>
> So if you are performance sensitive enough to care, you will very likely
> want to disable plugins anyway.

I can disable plugins and do that normally but that does not help those 
who get QEMU from their distro (i.e. most users). If this infrastructure 
was disabled in default builds and needed an explicit option to enable 
then those who need it could enable it and not imposed it on everyone else 
who just get a default build from a distro and never use plugins. Having 
an option which needs rebuild is like not having the option for most 
people. I guess the question is which is the larger group? Those who just 
run guests or those who use this instrumentation with plugins. The default 
may better be what the larger group needs. Even then distros may still 
change the default so it would be best if the overhead can be minimised 
even if enabled. I think the log infrastructure does that, would a similar 
solution work here?

For testing I've found that because embedded PPC CPUs have a software 
controlled MMU (and in addition to that QEMU may flush TLB entries too 
often) running something that does a lot of memory access like runnung the 
STREAM benchmark on sam460ex is hit by this IIRC but anything else causing 
a lot of interrupts like reading from emulated disk or sound is probably 
affected as well. I've tried to optimise PPC exception handling a bit 
before but whenever I optimise something it is later undone by other 
changes not caring about performance.

Regards,
BALATON Zoltan
--3866299591-1581212006-1757099900=:18226--

