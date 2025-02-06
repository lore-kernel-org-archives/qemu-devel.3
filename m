Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E7C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1Qf-0000ic-9F; Thu, 06 Feb 2025 07:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg1Qa-0000hO-BI; Thu, 06 Feb 2025 07:56:20 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tg1QY-0002ed-8E; Thu, 06 Feb 2025 07:56:20 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4EE4A4E6005;
 Thu, 06 Feb 2025 13:56:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 8H_IzrJXURkt; Thu,  6 Feb 2025 13:56:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 57E664E6000; Thu, 06 Feb 2025 13:56:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 556B874577C;
 Thu, 06 Feb 2025 13:56:11 +0100 (CET)
Date: Thu, 6 Feb 2025 13:56:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2EBerrang=E9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
In-Reply-To: <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
Message-ID: <65a115a0-a2be-1c5f-f11a-e8b5f89c3ce4@eik.bme.hu>
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org> <87a5b07u1d.fsf@pond.sub.org>
 <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-2484570-1738846571=:22970"
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

--3866299591-2484570-1738846571=:22970
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 5/2/25 08:03, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>> 
>>> MachineClass::auto_create_sdcard is only useful to automatically
>>> create a SD card, attach a IF_SD block drive to it and plug the
>>> card onto a SD bus. Only the ARM and RISCV targets use such
>>> feature:
>>>
>>>   $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>>   hw/arm
>>>   hw/riscv
>>>   $
>>> 
>>> Remove all other uses.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> 
>> Impact?
>> 
>> As far as I can tell, this stops creation of the if=sd default drive
>> these machines don't actually use.  Correct?
>> 
>
> Yes, since these machines don't expose a SD-bus, the drive can
> not be attached and always triggers the same error:
>
> $ qemu-system-hppa -sd /bin/sh
> qemu-system-hppa: -sd /bin/sh: machine type does not support 
> if=sd,bus=0,unit=0

And how is this error improved after this series? This seems to be a 
meaningful error already.

In any case, if you plan to merge this, could you please cut down on 
adding nonsense defaults to every machine that are then removed again? 
Maybe only confine it to hw/arm where most of the machines are, for the 
rest you can point to an earlier version of the series in the cover letter 
to show how did you end up with the list of the machines to help review 
but the final version merged in master maybe does not have to have all the 
temporary changes to avoid excessive churn. Or was that the plan already?

Regards,
BALATON Zoltan
--3866299591-2484570-1738846571=:22970--

