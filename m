Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300DCF43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfnd-0008MG-Oi; Fri, 17 Apr 2026 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wDfna-0008LU-Mk; Fri, 17 Apr 2026 05:47:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wDfnY-0007K1-18; Fri, 17 Apr 2026 05:47:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5A8D596958;
 Fri, 17 Apr 2026 11:47:34 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id vp9EOE1QEoKD; Fri, 17 Apr 2026 11:47:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 27782596957; Fri, 17 Apr 2026 11:47:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 25224596954;
 Fri, 17 Apr 2026 11:47:32 +0200 (CEST)
Date: Fri, 17 Apr 2026 11:47:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Jamin Lin <jamin_lin@aspeedtech.com>
cc: "philmd@linaro.org" <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn structure
 and dead code
In-Reply-To: <TYPPR06MB8206FFD9BA069A555C54A137FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
Message-ID: <efadd094-380a-41e4-0346-7ba296781968@eik.bme.hu>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-2-jamin_lin@aspeedtech.com>
 <d7e9d943-fd8d-dd48-5a86-e54613c466dd@eik.bme.hu>
 <TYPPR06MB820623725F12A9326E19B44FFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206FFD9BA069A555C54A137FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 17 Apr 2026, Jamin Lin wrote:
> Hi all,
>
>> Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
>> structure and dead code
>>
>> Hi all,
>>
>>> Subject: Re: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
>>> structure and dead code
>>>
>>> On Thu, 16 Apr 2026, Jamin Lin wrote:
>>>> The EHCIfstn structure, defined according to EHCI spec section 3.7,
>>>> is currently unused in the EHCI implementation. Remove it to reduce
>>>> unused code and improve maintainability.
>>>>
>>>> Additionally, drop a block of disabled (#if 0) code in
>>>> ehci_state_advqueue() that was never implemented. This code path is
>>>> incomplete and has no functional impact.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>> ---
>>>> hw/usb/hcd-ehci.h |  7 -------
>>>> hw/usb/hcd-ehci.c | 11 -----------
>>>> 2 files changed, 18 deletions(-)
>>>>
>>>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h index
>>>> 0ae8c06331..3aec0e047c 100644
>>>> --- a/hw/usb/hcd-ehci.h
>>>> +++ b/hw/usb/hcd-ehci.h
>>>> @@ -202,13 +202,6 @@ typedef struct EHCIqh {
>>>> #define BUFPTR_SBYTES_SH              5
>>>> } EHCIqh;
>>>>
>>>> -/*  EHCI spec version 1.0 Section 3.7
>>>> - */
>>>> -typedef struct EHCIfstn {
>>>> -    uint32_t next;                    /* Standard next link pointer
>> */
>>>> -    uint32_t backptr;                 /* Standard next link pointer */
>>>> -} EHCIfstn;
>>>> -
>>>> enum async_state {
>>>>     EHCI_ASYNC_NONE = 0,
>>>>     EHCI_ASYNC_INITIALIZED,
>>>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c index
>>>> 57f930b099..5ea8461f70 100644
>>>> --- a/hw/usb/hcd-ehci.c
>>>> +++ b/hw/usb/hcd-ehci.c
>>>> @@ -1756,17 +1756,6 @@ static int ehci_state_fetchsitd(EHCIState
>>>> *ehci, int async)
>>>> /* Section 4.10.2 - paragraph 3 */
>>>> static int ehci_state_advqueue(EHCIQueue *q) { -#if 0
>>>> -    /* TO-DO: 4.10.2 - paragraph 2
>>>> -     * if I-bit is set to 1 and QH is not active
>>>> -     * go to horizontal QH
>>>> -     */
>>>
>>> Is it worth to keep the comment in case it's still valid to remind we
>>> have something missing here?
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>
>> If we decide to keep these comments as reminders for unimplemented parts,
>> please let me know. I will resend the patch series and drop this patch.
>>
>> Thanks,
>> Jamin
>>
>
> Another approach:
> We can remove the #if 0 dead code and keep only the comments as a reminder that this part is not yet implemented.
>
> Ex:
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1756,16 +1756,10 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
> /* Section 4.10.2 - paragraph 3 */
> static int ehci_state_advqueue(EHCIQueue *q)
> {
> -#if 0
>     /* TO-DO: 4.10.2 - paragraph 2
>      * if I-bit is set to 1 and QH is not active
>      * go to horizontal QH
>      */
> -    if (I-bit set) {
> -        ehci_set_state(ehci, async, EST_HORIZONTALQH);
> -        goto out;
> -    }
>
> Thanks,
> Jamin

That's what I meant to leave the comment but OK the remove ineffective 
code.

Regards,
BALATON Zoltan

