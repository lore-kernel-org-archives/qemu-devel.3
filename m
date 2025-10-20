Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9865CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApuB-0004Yz-NL; Mon, 20 Oct 2025 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vApu3-0004Xw-HG; Mon, 20 Oct 2025 09:26:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vApu0-0000J2-Gh; Mon, 20 Oct 2025 09:26:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F1EE359730B;
 Mon, 20 Oct 2025 15:26:16 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dnRr28yuYBCM; Mon, 20 Oct 2025 15:26:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E68DB5972FF; Mon, 20 Oct 2025 15:26:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4D2459703F;
 Mon, 20 Oct 2025 15:26:14 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:26:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 10/13] hw/ppc/pegasos2: Add bus frequency to machine
 state
In-Reply-To: <2ae1a2ba-74b6-4786-9001-29f292d7f144@linaro.org>
Message-ID: <1d26b401-a8a4-7420-c225-31ed9fcfe24b@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <bb655f2827b35951a76d2251f71382c0e7f31d2c.1760798392.git.balaton@eik.bme.hu>
 <2ae1a2ba-74b6-4786-9001-29f292d7f144@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-917270636-1760966774=:46197"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-917270636-1760966774=:46197
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 18/10/25 17:11, BALATON Zoltan wrote:
>> Store the bus frequency in the machine state and set it from instance
>> init method.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>> 
>> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
>> index f7999520e4..ae3f01231d 100644
>> --- a/hw/ppc/pegasos2.c
>> +++ b/hw/ppc/pegasos2.c
>> @@ -55,8 +55,6 @@
>>   #define H_PRIVILEGE  -3  /* Caller not privileged */
>>   #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or 
>> conflicting */
>>   -#define BUS_FREQ_HZ 133333333
>> -
>>   #define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
>>   OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
>>   @@ -66,6 +64,7 @@ struct PegasosMachineState {
>>       PowerPCCPU *cpu;
>>       DeviceState *nb; /* north bridge */
>>       DeviceState *sb; /* south bridge */
>> +    int bus_freq_hz;
>
> IMHO this field belongs to PegasosMachineClass, being read-only.

Reasons for not putting there:

1. I need it in machine init and build_fdt which get the machine state not 
machine class so would need to copy to machine state even if it was 
defined in the class.

2. We don't have a PegasosMachineState and it does not seem necessary to 
add one just for this single value which would then be never used other 
than copying it to the PegasosMachineState in init.

So for simplicity I've stored it the existing state along other values 
which seems to be simple enough. I don't see putting it in the class would 
be simpler.

>>       IRQState pci_irqs[PCI_NUM_PINS];
>>       OrIRQState orirq[PCI_NUM_PINS];
>>       qemu_irq mv_pirq[PCI_NUM_PINS];
>
>
>> +static void pegasos2_init(Object *obj)
>> +{
>> +    PegasosMachineState *pm = PEGASOS_MACHINE(obj);
>> +
>> +    pm->bus_freq_hz = 133333333;
>> +}
>> +
>>   static void pegasos2_machine_class_init(ObjectClass *oc, const void 
>> *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -610,7 +616,7 @@ static void pegasos2_machine_class_init(ObjectClass 
>> *oc, const void *data)
>>       VofMachineIfClass *vmc = VOF_MACHINE_CLASS(oc);
>>         mc->desc = "Genesi/bPlan Pegasos II";
>> -    mc->init = pegasos2_init;
>> +    mc->init = pegasos_init;
>>       mc->reset = pegasos2_machine_reset;
>>       mc->block_default_type = IF_IDE;
>>       mc->default_boot_order = "cd";
>> @@ -640,6 +646,7 @@ static const TypeInfo pegasos_machine_types[] = {
>>           .name          = MACHINE_TYPE_NAME("pegasos2"),
>>           .parent        = TYPE_PEGASOS_MACHINE,
>>           .class_init    = pegasos2_machine_class_init,
>> +        .instance_init = pegasos2_init,
>>           .interfaces = (const InterfaceInfo[]) {
>>                 { TYPE_PPC_VIRTUAL_HYPERVISOR },
>>                 { TYPE_VOF_MACHINE_IF },
>
> If you want pegasos2_init(), move the definition here to avoid churn
> in patch #12.

I don't understand what causes the churn as the function is the same, 
patch 12 only adds one line to it but maybe renaming surrounding functions 
confused git to generate patch that moves this function and not ammends 
it. What can I move here to avoid that?

Regards,
BALATON Zoltan
--3866299591-917270636-1760966774=:46197--

