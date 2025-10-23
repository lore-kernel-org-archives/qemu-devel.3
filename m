Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6C4CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBt91-0005g6-KE; Thu, 23 Oct 2025 07:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBt8y-0005f0-Fl; Thu, 23 Oct 2025 07:06:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBt8u-0003Uo-Ro; Thu, 23 Oct 2025 07:06:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C01645972EC;
 Thu, 23 Oct 2025 13:06:01 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UWTAsNgFXjm3; Thu, 23 Oct 2025 13:05:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ADF6A5972E3; Thu, 23 Oct 2025 13:05:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABF1059703F;
 Thu, 23 Oct 2025 13:05:59 +0200 (CEST)
Date: Thu, 23 Oct 2025 13:05:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 10/12] hw/ppc/pegasos2: Add bus frequency to machine
 state
In-Reply-To: <73ea10fd-fbee-4c77-95ba-5520becdb910@linaro.org>
Message-ID: <fd2f7fc2-768e-d139-7ba6-6a1f3cddbb00@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <b69e21e353b7d7f22a34db5f13443f60f51c7238.1761176219.git.balaton@eik.bme.hu>
 <73ea10fd-fbee-4c77-95ba-5520becdb910@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1997699172-1761217559=:4926"
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

--3866299591-1997699172-1761217559=:4926
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 23 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 23/10/25 02:06, BALATON Zoltan wrote:
>> Store the bus frequency in the machine state and set it from instance
>> init method.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>> 
>> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
>> index f5b56c0e94..7eaefcf9a0 100644
>> --- a/hw/ppc/pegasos2.c
>> +++ b/hw/ppc/pegasos2.c
>> @@ -55,8 +55,6 @@
>>   #define H_PRIVILEGE  -3  /* Caller not privileged */
>>   #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or 
>> conflicting */
>>   -#define BUS_FREQ_HZ 133333333
>
>
>> -static void pegasos2_init(MachineState *machine)
>> +static void pegasos_init(MachineState *machine)
>>   {
>>       PegasosMachineState *pm = PEGASOS_MACHINE(machine);
>>       CPUPPCState *env;
>> @@ -158,7 +157,7 @@ static void pegasos2_init(MachineState *machine)
>>       }
>>         /* Set time-base frequency */
>> -    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
>> +    cpu_ppc_tb_init(env, pm->bus_freq_hz / 4);
>
> As a future cleanup patch on top, please replace the magic '4' value ...
>> -static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
>> +static void add_cpu_info(void *fdt, PowerPCCPU *cpu, int bus_freq)
>>   {
>>       uint32_t cells[2];
>>   @@ -824,8 +831,8 @@ static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
>>       qemu_fdt_setprop_cell(fdt, cp, "reservation-granule-size", 4);
>>       qemu_fdt_setprop_cell(fdt, cp, "timebase-frequency",
>>                             cpu->env.tb_env->tb_freq);
>> -    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", BUS_FREQ_HZ);
>> -    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", BUS_FREQ_HZ * 7.5);
>> +    qemu_fdt_setprop_cell(fdt, cp, "bus-frequency", bus_freq);
>> +    qemu_fdt_setprop_cell(fdt, cp, "clock-frequency", bus_freq * 7.5);
> ... and this '7.5' one by descriptive definitions.

These are just clock multipliers. The time-base often runs at quarter of 
the bus freq on PPC and I don't think we have a define for that anywhere 
else. The 7.5 is a CPU clock to bus clock multiplier that should be fairly 
obvious fron the above without a define.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks,
BALATON Zoltan
--3866299591-1997699172-1761217559=:4926--

