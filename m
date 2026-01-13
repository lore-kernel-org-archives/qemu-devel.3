Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8759D2F34C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfipr-0003OT-OR; Tue, 13 Jan 2026 13:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vfiot-0002vJ-No; Tue, 13 Jan 2026 13:08:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vfioq-0007Oc-2n; Tue, 13 Jan 2026 13:08:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 630B7596A0D;
 Tue, 13 Jan 2026 19:08:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id SgVe6PxfnXyB; Tue, 13 Jan 2026 19:08:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4EF7C5969FF; Tue, 13 Jan 2026 19:08:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C89B5969E4;
 Tue, 13 Jan 2026 19:08:32 +0100 (CET)
Date: Tue, 13 Jan 2026 19:08:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH 04/12] hw/m68k: register a mcf5208evb_cpu_reset handler
In-Reply-To: <CAFEAcA_Y_fTBo_0qg4Lm+7WrMdEown=-RrHHjcsKKE6WRX3eRw@mail.gmail.com>
Message-ID: <b2c72aef-4a60-76af-4cd8-dd3142e46d2a@eik.bme.hu>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-5-alex.bennee@linaro.org>
 <CAFEAcA_Y_fTBo_0qg4Lm+7WrMdEown=-RrHHjcsKKE6WRX3eRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-927016346-1768327712=:58111"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-927016346-1768327712=:58111
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Jan 2026, Peter Maydell wrote:
> On Thu, 8 Jan 2026 at 14:34, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> It looks like allowing a -kernel to override any firmware setting is
>> intentional.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  hw/m68k/mcf5208.c | 25 +++++++++++++++++++------
>>  1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index c6d1c5fae9f..5680d516a23 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -27,6 +27,7 @@
>>  #include "qemu/timer.h"
>>  #include "hw/core/ptimer.h"
>>  #include "system/system.h"
>> +#include "system/reset.h"
>>  #include "system/qtest.h"
>>  #include "net/net.h"
>>  #include "hw/core/boards.h"
>> @@ -274,6 +275,20 @@ static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, qemu_irq *irqs)
>>      memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
>>  }
>>
>> +static void mcf5208evb_cpu_reset(void *opaque)
>> +{
>> +    M68kCPU *cpu = opaque;
>> +    CPUM68KState *env = &cpu->env;
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    cpu_reset(cs);
>> +    /* Initialize CPU registers.  */
>> +    env->vbr = 0;
>> +    /* TODO: Configure BARs.  */
>> +    env->aregs[7] = ldl_phys(cs->as, 0);
>> +    env->pc = env->reset_pc;
>> +}
>
> It looks from my quick skim of the m68k manual like
> "on reset, initial PC is read from offset 4, initial
> SP is read from offset 0" is part of the architected
> CPU reset, not board-specific. Maybe we should model
> that inside the CPU reset method? Compare M-profile
> Arm, which does basically the same thing in
> arm_cpu_reset_hold().
>
> (I really need to look again at whether we can move
> that to the reset_exit phase now and drop the awkward
> "maybe we need to look at a rom blob" special casing.)

Real machines usually have a way to remap ROM to address 0 on reset 
shadowing RAM and then the firmware flips the bits needed to set up the 
memory map with RAM at 0 and ROM at somewhere higher up but the way to do 
it is different for each board. Maybe in QEMU we don't bother to model 
this and have this special case instead to simplify things and be able to 
start from the final ROM address without needing to model this ROM remap 
thing. So modeling real CPU behaviour might make board models more 
complex.

Regards,
BALATON Zoltan
--3866299591-927016346-1768327712=:58111--

