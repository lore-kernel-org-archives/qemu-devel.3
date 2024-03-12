Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13757C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4W4-0000Ox-CC; Tue, 12 Mar 2024 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rk4W2-0000On-FT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:58:10 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rk4W0-0005AV-09
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:58:10 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 1D514A0121; Tue, 12 Mar 2024 16:50:07 +0100 (CET)
Date: Tue, 12 Mar 2024 16:50:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 clg@kaod.org
Subject: Re: [PATCH v3] docs/system/ppc: Document running Linux on AmigaNG
 machines
In-Reply-To: <CZRUH5CRDRDU.3NS44E5KB0SSY@wheely>
Message-ID: <alpine.LMD.2.03.2403121645090.11217@eik.bme.hu>
References: <20240220232200.042DA4E6005@zero.eik.bme.hu>
 <c9dc84be-c7bf-c676-491b-2c6b1164d502@eik.bme.hu>
 <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
 <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
 <CZRPETJSO62V.5YV22F323JKC@wheely>
 <CZRUH5CRDRDU.3NS44E5KB0SSY@wheely>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-408705468-1710258607=:11217"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--1117279078-408705468-1710258607=:11217
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 Mar 2024, Nicholas Piggin wrote:
> On Tue Mar 12, 2024 at 8:36 PM AEST, Nicholas Piggin wrote:
>> On Tue Mar 12, 2024 at 7:28 PM AEST, Bernhard Beschow wrote:
>>>
>>>
>>> Am 9. M=C3=A4rz 2024 11:34:56 UTC schrieb BALATON Zoltan <balaton@eik.b=
me.hu>:
>>>> On Thu, 29 Feb 2024, BALATON Zoltan wrote:
>>>>> On Wed, 21 Feb 2024, BALATON Zoltan wrote:
>>>>>> Documentation on how to run Linux on the amigaone, pegasos2 and
>>>>>> sam460ex machines is currently buried in the depths of the qemu-deve=
l
>>>>>> mailing list and in the source code. Let's collect the information i=
n
>>>>>> the QEMU handbook for a one stop solution.
>>>>>
>>>>> Ping? (Just so it's not missed from next pull.)
>>>>
>>>> Ping for freeze.
>>>
>>> Has this patch been tagged yet? It would really be a pity if it didn't =
make it into 9.0.
>>
>> Will send out a PR today and I'll include it.
>>
>>>
>>> FWIW:
>>>
>>> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
>>
>> Thanks, always helpful.
>
> Oh you are Co-author. Sorry, took some time for light bulb
> to turn on... In that case it needs your SOB to merge.
>
> I will have to leave it out of the PR if I don't get that in
> time, but we should be able to get a doc improvement past
> the soft freeze. It's essentially a usability bug-fix.

This was the original submission that compiled my previous emails and=20
cover letters into some docs so the text was mine and editorship was=20
Bernhard:
https://patchew.org/QEMU/20231216123013.67978-1-shentey@gmail.com/
which I then took over and enhanced further so you can take his SoB from=20
that patch I just forgot to retain it as I did not think it would be=20
needed.

Regards,
BALATON Zoltan
--1117279078-408705468-1710258607=:11217--

