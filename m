Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699BBFEFB6C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw0AH-0002jA-Do; Fri, 27 Feb 2026 10:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vw0AG-0002if-27; Fri, 27 Feb 2026 10:54:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vw0AE-0003D5-5u; Fri, 27 Feb 2026 10:54:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8DA4597318;
 Fri, 27 Feb 2026 16:53:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fIRVzAwFIKJB; Fri, 27 Feb 2026 16:53:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DF12A5972E2; Fri, 27 Feb 2026 16:53:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD1AF596A29;
 Fri, 27 Feb 2026 16:53:56 +0100 (CET)
Date: Fri, 27 Feb 2026 16:53:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aditya Gupta <adityag@linux.ibm.com>
cc: shivang upadhyay <shivangu@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
In-Reply-To: <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Message-ID: <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
 <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 27 Feb 2026, Aditya Gupta wrote:
> On 26/02/27 02:05PM, BALATON Zoltan wrote:
>> On Fri, 27 Feb 2026, Aditya Gupta wrote:
>>> On 26/02/27 03:43PM, shivang upadhyay wrote:
>>>>> <...snip...>
>>>>>
>>>>> Q: can the generated DBT genuinely be different on a
>>>>> subsequent reset than it was when QEMU first starts?
>>>>> The comments in the pnv_reset() code seem to suggest it,
>>>>> but on the other hand the code as written will only
>>>>> call pnv_dt_create() and update machine->fdt once on first
>>>>> reset, not on later resets. So perhaps the comment is
>>>>> just confusingly worded ?
>>>>
>>>> Yes, I am not much familiar with the design here. But, as per
>>>>
>>>> my current understanding of this code, DTB content should not
>>>>
>>>> not be changed.
>>>
>>> To add to this, yes, normally reset path doesn't change the device tree,
>>> since all reboots are the same as the first boot.
>>>
>>> As of upstream this is true, I don't see dtb changing between resets.
>>
>> Isn't VOF allowing clients to do setprop that would be changing the device
>> tree? Some settings are stored there so maybe it can be changed by the guest
>> that should be preserved between reboots?
>
> By VOF did you mean the pseries f/w ?

I don't know much about these machines. I meant Virtual Open Firmware in 
QEMU or SLOF which it can replace. But maybe this is only used by spapr so 
does not affect pseries but in spapr there's spapr_vof_setprop() which 
looks like it can change the fdt. Maybe it's handled differently on 
pseries, I don't know.

> i don't see anything changing the dt in powernv as of now, but
> for some edge case, where that is possible (will be possible atleast
> after mpipl support is merged), we can always update the fdt in below 2
> if cases in pnv_reset:
>
>    > if (machine->fdt) {
>    >     fdt = machine->fdt;
>    > } else {
>    >     fdt = pnv_dt_create(machine);
>    >     /* Pack resulting tree */
>    >     _FDT((fdt_pack(fdt)));
>    > }
>
> machine->fdt will never be NULL since it's being set in pnv_init
> should we just do pnv_dt_create on every pnv_reset ?

I don't know either but wasn't original code meant to either create an fdt 
or take what the user specified with -dtb option or similiar? In that case 
maybe you don't want to override the user specified dtb but I could be 
wrong about what this is meant to do as I have no idea whatsoever about 
these machines.

Regards,
BALATON Zoltan

