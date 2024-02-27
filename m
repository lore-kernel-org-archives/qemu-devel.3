Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F374C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0gK-0002eV-6x; Tue, 27 Feb 2024 11:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf0gI-0002e3-Tj; Tue, 27 Feb 2024 11:51:50 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf0gH-0003eO-3O; Tue, 27 Feb 2024 11:51:50 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A79B64E6005;
 Tue, 27 Feb 2024 17:51:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id lKsFItlj4uw6; Tue, 27 Feb 2024 17:51:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B59954E60D3; Tue, 27 Feb 2024 17:51:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B46747456FE;
 Tue, 27 Feb 2024 17:51:44 +0100 (CET)
Date: Tue, 27 Feb 2024 17:51:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: Re: [PATCH v7 02/10] target/ppc: Readability improvements in exception
 handlers
In-Reply-To: <CAFEAcA_6R2wLaLOoOBQ0-Z_QydAEgxANmNPdKaAF=iiroFEhmA@mail.gmail.com>
Message-ID: <ab46d0f9-19cc-bb34-2a8e-0c4d3d8592ea@eik.bme.hu>
References: <cover.1709045654.git.balaton@eik.bme.hu>
 <a06f6259d7a37aa88145fb13e4bce153ff763f86.1709045654.git.balaton@eik.bme.hu>
 <CAFEAcA_6R2wLaLOoOBQ0-Z_QydAEgxANmNPdKaAF=iiroFEhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 27 Feb 2024, Peter Maydell wrote:
> On Tue, 27 Feb 2024 at 15:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Improve readability by shortening some long comments, removing
>> comments that state the obvious and dropping some empty lines so they
>> don't distract when reading the code.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Acked-by: Nicholas Piggin <npiggin@gmail.com>
>
>
>> -    /*
>> -     * new interrupt handler msr preserves existing ME unless
>> -     * explicitly overridden.
>> -     */
>> +    /* new interrupt handler msr preserves ME unless explicitly overriden */
>
> Minor typo introduced here: should be "overridden".
>
>>      new_msr = env->msr & (((target_ulong)1 << MSR_ME));
>
>> @@ -575,16 +558,10 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>>      /* new srr1 value excluding must-be-zero bits */
>>      msr = env->msr & ~0x783f0000ULL;
>>
>> -    /*
>> -     * new interrupt handler msr preserves existing ME unless
>> -     * explicitly overridden
>> -     */
>> +    /* new interrupt handler msr preserves ME unless explicitly overriden */
>
> Ditto, and similarly for other instances later in the patch.

Huh, sorry, don't know how I've lost that letter. It also seems that the 
last patch gone missing from the series somehow so if it does not turn up, 
I can resend it with these fixed.

Regards,
BALATON Zoltan

