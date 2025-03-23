Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0506C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTZR-0000jF-PQ; Sun, 23 Mar 2025 18:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twTZH-0000il-Tu; Sun, 23 Mar 2025 18:13:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twTZE-0003Ap-7l; Sun, 23 Mar 2025 18:13:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC4324E6004;
 Sun, 23 Mar 2025 23:13:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id epcHyiw9MPvN; Sun, 23 Mar 2025 23:13:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E3E314E6014; Sun, 23 Mar 2025 23:13:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E18AA74577C;
 Sun, 23 Mar 2025 23:13:07 +0100 (CET)
Date: Sun, 23 Mar 2025 23:13:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-ppc <qemu-ppc@nongnu.org>, Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
In-Reply-To: <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
Message-ID: <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
 <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
 <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-149857279-1742767987=:37405"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-149857279-1742767987=:37405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 23 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 23/3/25 20:07, Richard Henderson wrote:
>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>> index 28fbbb8d3c1..ed79cc1a6b7 100644
>>> --- a/target/ppc/cpu_init.c
>>> +++ b/target/ppc/cpu_init.c
>>> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>>>     .translate_code = ppc_translate_code,
>>>     .restore_state_to_opc = ppc_restore_state_to_opc,
>>> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>>>     .guest_default_memory_order = 0,
>> 
>> Similarly.  I'd be surprised if ppc32 can't use mttcg, really.
>
> Per Cédric on IRC our ppc32 implementations are single core,
> so never tested for mttcg.

We're just trying to implement more CPUs for G4 mac99 and tested it with 
-smp 2 and it seems to generally work but we need to implement more of the 
Mac hardware for this but we could already run Mac OS X with two CPUs and 
mttcg and Linux too if we add a delay on boot when second CPU is started 
(it may need implementing timebase control as done on the G4 Mac to avoid 
that but if it gets past that it seems to work). So please leave this 
enabled. Not tested does not mean it does not work so only disable if 
there's a known problem.

Regards,
BALATON Zoltan
--3866299591-149857279-1742767987=:37405--

