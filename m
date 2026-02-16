Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E0E8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs76K-0003in-8a; Mon, 16 Feb 2026 17:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs76G-0003iJ-TN; Mon, 16 Feb 2026 17:29:52 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs76E-0001kS-50; Mon, 16 Feb 2026 17:29:52 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AEA95969FA;
 Mon, 16 Feb 2026 23:29:46 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id soFsPZel9aCe; Mon, 16 Feb 2026 23:29:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 840CD5969F6; Mon, 16 Feb 2026 23:29:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7DFCA5969F1;
 Mon, 16 Feb 2026 23:29:44 +0100 (CET)
Date: Mon, 16 Feb 2026 23:29:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
In-Reply-To: <bd3b2c15-9c3a-4301-94b0-8800293f3451@ilande.co.uk>
Message-ID: <84161ea3-3045-ba2a-ec3c-42bf9f247c1a@eik.bme.hu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
 <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
 <56a0f465-2055-4c82-b0c0-963b376609e9@linaro.org>
 <0492fc65-e156-1afe-ea72-520134ccca41@eik.bme.hu>
 <bd3b2c15-9c3a-4301-94b0-8800293f3451@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 16 Feb 2026, Mark Cave-Ayland wrote:
> On 15/02/2026 09:51, BALATON Zoltan wrote:
>
>> Maybe turning these into properties could work. I could look at adding such 
>> properties but don't know how to change the -g option. But considering 
>> these are all machines that Mark maintains maybe he should do something 
>> about it. The easiest were if he agreed to drop -g option but he never 
>> agrees removing anything so then he should provide patches to clean this up 
>> the way he prefers. I could try to make patches but I'm afraid those would 
>> become wasted effort so may I only do it when there's an approved way that 
>> will be accepted.
>
> I don't think these types of snide comment are appropriate.

Sorry, this is just my experience so far with patches that touch files you 
maintain. Last example is trying to change Sun machines to not use global 
vmstate that could have been done to clean this up and bring it in line 
with everyting else as these Sun machines are the last active user of this 
and have no migration guarantee but you insisted to keep it until the last 
possible minute. I did not mean to offend you, just wanted to say that 
since whatever I submit usually does not meet your preferred way it's best 
if I don't try to make patches that then would be discarded because you 
want something else and you should at lest tell in advance what would be 
your preference here.

Regards,
BALATON Zoltan

