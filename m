Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C2C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSbx-00042K-US; Thu, 17 Jul 2025 13:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ucQ1b-0001BB-ER; Thu, 17 Jul 2025 10:55:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ucQ1Z-0000Cm-4T; Thu, 17 Jul 2025 10:55:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D400255BC04;
 Thu, 17 Jul 2025 16:55:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Rv8on3HrgbB1; Thu, 17 Jul 2025 16:55:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CE9A055BC02; Thu, 17 Jul 2025 16:55:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBADF745682;
 Thu, 17 Jul 2025 16:55:44 +0200 (CEST)
Date: Thu, 17 Jul 2025 16:55:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-10.1 1/3] accel/hvf: Display executable bit as 'X'
In-Reply-To: <1edeecdd-76cf-4baa-97d8-c07df20b4824@intel.com>
Message-ID: <2749ad31-b071-e91a-f7dc-25be726c7ed3@eik.bme.hu>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-2-philmd@linaro.org>
 <1edeecdd-76cf-4baa-97d8-c07df20b4824@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-1962885198-1752764144=:773"
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

--3866299591-1962885198-1752764144=:773
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 17 Jul 2025, Xiaoyao Li wrote:
> On 7/17/2025 1:28 AM, Philippe Mathieu-Daudé wrote:
>> Developers are custom to read RWX, not RWE.

"accustomed to"

>> Replace E -> X.
>> 
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>
>> ---
>>   accel/hvf/hvf-all.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>> index e67a8105a66..0a4b498e836 100644
>> --- a/accel/hvf/hvf-all.c
>> +++ b/accel/hvf/hvf-all.c
>> @@ -84,7 +84,7 @@ static int do_hvf_set_memory(hvf_slot *slot, 
>> hv_memory_flags_t flags)
>>       trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
>>                        flags & HV_MEMORY_READ ?  'R' : '-',
>>                        flags & HV_MEMORY_WRITE ? 'W' : '-',
>> -                     flags & HV_MEMORY_EXEC ?  'E' : '-');
>> +                     flags & HV_MEMORY_EXEC ?  'X' : '-');
>>       ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
>>       assert_hvf_ok(ret);
>>       return 0;
>
>
>
--3866299591-1962885198-1752764144=:773--

