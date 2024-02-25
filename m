Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB8C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHzi-00075X-Dq; Sun, 25 Feb 2024 12:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reHzh-00074z-3L; Sun, 25 Feb 2024 12:08:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reHze-0002Rl-Em; Sun, 25 Feb 2024 12:08:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A56534E6076;
 Sun, 25 Feb 2024 18:08:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hbHAB1_ZN2IS; Sun, 25 Feb 2024 18:08:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AEEB34E601E; Sun, 25 Feb 2024 18:08:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AD4F97456B4;
 Sun, 25 Feb 2024 18:08:42 +0100 (CET)
Date: Sun, 25 Feb 2024 18:08:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/ide: Remove last two uses of ide/internal.h outside
 of hw/ide
In-Reply-To: <bcffda64-6805-4322-bfc2-888d246cc554@linaro.org>
Message-ID: <3e576d33-1973-3f44-afd1-9224609f89a6@eik.bme.hu>
References: <20240223142633.933694E6004@zero.eik.bme.hu>
 <bcffda64-6805-4322-bfc2-888d246cc554@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-468862581-1708880922=:25692"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-468862581-1708880922=:25692
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 25 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 23/2/24 15:26, BALATON Zoltan wrote:
>> Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
>> replace them with newly added public header to allow moving internal.h
>> into hw/ide to really stop exposing it.
>> 
>> Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/arm/sbsa-ref.c                 | 2 +-
>>   {include/hw => hw}/ide/internal.h | 0
>>   include/hw/misc/macio/macio.h     | 2 +-
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>   rename {include/hw => hw}/ide/internal.h (100%)
>> 
>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>> index 5d3a574664..f027622a75 100644
>> --- a/hw/arm/sbsa-ref.c
>> +++ b/hw/arm/sbsa-ref.c
>> @@ -36,7 +36,7 @@
>>   #include "hw/arm/smmuv3.h"
>>   #include "hw/block/flash.h"
>>   #include "hw/boards.h"
>> -#include "hw/ide/internal.h"
>> +#include "hw/ide/ide-bus.h"
>>   #include "hw/ide/ahci_internal.h"
>
> Unrelated, but what about this one ^?

The ahci_internal.h is in hw/ide not in include/hw/ide so how does that 
even work? I don't care about AHCI so not interested to anything about 
that personally.

Regards,
BALATON Zoltan
--3866299591-468862581-1708880922=:25692--

