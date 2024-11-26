Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C61D65520
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFybC-0001aX-E0; Tue, 26 Nov 2024 11:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HgjR=SV=kaod.org=clg@ozlabs.org>)
 id 1tFyb9-0001ZJ-Kw; Tue, 26 Nov 2024 11:39:35 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HgjR=SV=kaod.org=clg@ozlabs.org>)
 id 1tFyb6-0005kt-TG; Tue, 26 Nov 2024 11:39:35 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XySvn4KYtz4x6X;
 Wed, 27 Nov 2024 03:39:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XySvd5zsNz4wnp;
 Wed, 27 Nov 2024 03:39:08 +1100 (AEDT)
Message-ID: <40c40ef6-cae5-474d-a35d-13cf45207f96@kaod.org>
Date: Tue, 26 Nov 2024 17:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
 controllers
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-8-jamin_lin@aspeedtech.com>
 <e1803cd1-f4fd-4d1a-a8e9-5a5ed86c59e7@kaod.org>
 <6118d5bd-342e-41d3-aaf5-4ce9715a9ea1@kaod.org>
 <SI2PR06MB5041D0605EA1EC813A09F48BFC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB5041D0605EA1EC813A09F48BFC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=HgjR=SV=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin,

Sorry for the later answer. I think I missed the question below.

On 10/23/24 04:46, Jamin Lin wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v2 07/18] aspeed: Fix hardcode attach flash model of spi
>> controllers
>>
>> oops. R-b sent on the wrong patch.
>>
>> On 10/22/24 12:48, Cédric Le Goater wrote:
>>> On 10/22/24 11:40, Jamin Lin wrote:
>>>> It only attached flash model of fmc and spi[0] in aspeed_machine_init
>> function.
>>>> However, AST2500 and AST2600 have one fmc and two spi(spi1 and spi2)
>>>> controllers; AST2700 have one fmc and 3 spi(spi0, spi1 and spi2) controllers.
>>>>
>>>> Besides, it used hardcode to attach flash model of fmc, spi[0] and
>>>> spi[1] in aspeed_minibmc_machine_init for AST1030.
>>>>
>>>> To make both functions more flexible and support all ASPEED SOCs spi
>>>> controllers, adds a for loop with sc->spis_num to attach flash model
>>>> of all supported spi controllers. The sc->spis_num is from AspeedSoCClass.
>>
>> To be honest, I am not a big fan of the aspeed_board_init_flashes() routine.
>> See commit 27a2c66c92ec for the reason.
>>
>> I prefer the more flexible approach :
>>
>> $ qemu-system-arm -M ast2600-evb \
>>         -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
>>         -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
>>         -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
>>         -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
>>         -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
>>         -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
>>         -nographic -nodefaults
>>
> Thanks for notify me this solution.
> I can successfully attach the default image to supported SPI controllers with different flash model.
> It seems we need to add "defaults_enabled()" if-statement in aspeed_minibmc_machine_init
> to support this solution for AST1030. Otherwise, I will get this error.
> 
> qemu-system-arm: -device w25q80bl,bus=ssi.0,cs=0x0,drive=fmc0: CS index '0x0' in use by a w25q80bl device
> 
> https://github.com/qemu/qemu/blob/master/hw/arm/aspeed.c
>   if (defaults_enabled()) {
>    aspeed_board_init_flashes(&bmc->soc->fmc,
>                                bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
>                                amc->num_cs,
>                                0);
> 
>    aspeed_board_init_flashes(&bmc->soc->spi[0],
>                                bmc->spi_model ? bmc->spi_model : amc->spi_model,
>                                amc->num_cs, amc->num_cs);
> 
>      aspeed_board_init_flashes(&bmc->soc->spi[1],
>                                bmc->spi_model ? bmc->spi_model : amc->spi_model,
>                                amc->num_cs, (amc->num_cs * 2));
>    }
> 
> Do I need to send this patch in v3 patch series?
> Or individually send this patch in the new patch series?


defaults_enabled() should be used to avoid creating the devices indeed.
Please send a patch for it. Or did you already ?

Thanks,

C.



> 
> AST1030:
> -blockdev node-name=fmc0,driver=file,filename=./fmc_cs0_img \
> -device w25q80bl,bus=ssi.0,cs=0x0,drive=fmc0 \
> -blockdev node-name=fmc1,driver=file,filename=./fmc_cs1_img \
> -device w25q80bl,bus=ssi.0,cs=0x1,drive=fmc1 \
> -blockdev node-name=spi1c0,driver=file,filename=./spi1_cs0_img \
> -device w25q256,bus=ssi.1,cs=0x0,drive=spi1c0 \
> -blockdev node-name=spi1c1,driver=file,filename=./spi1_cs1_img \
> -device w25q256,bus=ssi.1,cs=0x1,drive=spi1c1 \
> -blockdev node-name=spi2c0,driver=file,filename=./spi2_cs0_img \
> -device w25q256,bus=ssi.2,cs=0x0,drive=spi2c0 \
> -blockdev node-name=spi2c1,driver=file,filename=./spi2_cs1_img \
> -device w25q256,bus=ssi.2,cs=0x1,drive=spi2c1 \
> -nodefaults
> 
> AST2600:
> -blockdev node-name=fmc0,driver=file,filename=$1 \
> -device mx66u51235f,cs=0x0,bus=ssi.0,drive=fmc0 \
> -blockdev node-name=fmc1,driver=file,filename=./fmc_cs1_img \
> -device mx66u51235f,cs=0x1,bus=ssi.0,drive=fmc1 \
> -blockdev node-name=spi1,driver=file,filename=./spi1_cs0_img \
> -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
> -blockdev node-name=spi2,driver=file,filename=./spi2_cs0_img \
> -device mx66u51235f,cs=0x0,bus=ssi.2,drive=spi2 \
> -nodefaults
> 
>> which doesn't use the drive_get() interface and so, doesn't make assumption
>> on the order of the drives defined on the QEMU command line.
>>
>> Also, the number of availabe flash devices is a machine definition, not a SoC
>> definition. Not all CS are wired.
>>
>> I will drop that patch for now.
>>
> Understand and thanks for suggestion.
> Jamin
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>> ---
>>>>    hw/arm/aspeed.c | 21 ++++++++++++---------
>>>>    1 file changed, 12 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
>>>> b4b1ce9efb..7ac01a3562 100644
>>>> --- a/hw/arm/aspeed.c
>>>> +++ b/hw/arm/aspeed.c
>>>> @@ -419,9 +419,11 @@ static void aspeed_machine_init(MachineState
>>>> *machine)
>>>>            aspeed_board_init_flashes(&bmc->soc->fmc,
>>>>                                  bmc->fmc_model ?
>> bmc->fmc_model :
>>>> amc->fmc_model,
>>>>                                  amc->num_cs, 0);
>>>> -        aspeed_board_init_flashes(&bmc->soc->spi[0],
>>>> -                              bmc->spi_model ?
>> bmc->spi_model :
>>>> amc->spi_model,
>>>> -                              1, amc->num_cs);
>>>> +        for (i = 0; i < sc->spis_num; i++) {
>>>> +            aspeed_board_init_flashes(&bmc->soc->spi[i],
>>>> +                            bmc->spi_model ?
>> bmc->spi_model :
>>>> +amc->spi_model,
>>>> +                            amc->num_cs, amc->num_cs +
>> (amc->num_cs
>>>> +* i));
>>>> +        }
>>>>        }
>>>>        if (machine->kernel_filename && sc->num_cpus > 1) { @@
>> -1579,7
>>>> +1581,9 @@ static void aspeed_minibmc_machine_init(MachineState
>>>> *machine)
>>>>    {
>>>>        AspeedMachineState *bmc = ASPEED_MACHINE(machine);
>>>>        AspeedMachineClass *amc =
>> ASPEED_MACHINE_GET_CLASS(machine);
>>>> +    AspeedSoCClass *sc;
>>>>        Clock *sysclk;
>>>> +    int i;
>>>>        sysclk = clock_new(OBJECT(machine), "SYSCLK");
>>>>        clock_set_hz(sysclk, SYSCLK_FRQ); @@ -1587,6 +1591,7 @@
>> static
>>>> void aspeed_minibmc_machine_init(MachineState *machine)
>>>>        bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
>>>>        object_property_add_child(OBJECT(machine), "soc",
>>>> OBJECT(bmc->soc));
>>>>        object_unref(OBJECT(bmc->soc));
>>>> +    sc = ASPEED_SOC_GET_CLASS(bmc->soc);
>>>>        qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
>>>>        object_property_set_link(OBJECT(bmc->soc), "memory", @@
>>>> -1599,13 +1604,11 @@ static void
>>>> aspeed_minibmc_machine_init(MachineState *machine)
>>>>                                  amc->num_cs,
>>>>                                  0);
>>>> -    aspeed_board_init_flashes(&bmc->soc->spi[0],
>>>> -                              bmc->spi_model ?
>> bmc->spi_model :
>>>> amc->spi_model,
>>>> -                              amc->num_cs,
>> amc->num_cs);
>>>> -
>>>> -    aspeed_board_init_flashes(&bmc->soc->spi[1],
>>>> +    for (i = 0; i < sc->spis_num; i++) {
>>>> +        aspeed_board_init_flashes(&bmc->soc->spi[i],
>>>>                                  bmc->spi_model ?
>> bmc->spi_model :
>>>> amc->spi_model,
>>>> -                              amc->num_cs,
>> (amc->num_cs * 2));
>>>> +                              amc->num_cs,
>> amc->num_cs +
>>>> +(amc->num_cs * i));
>>>> +    }
>>>>        if (amc->i2c_init) {
>>>>            amc->i2c_init(bmc);
>>>
> 


