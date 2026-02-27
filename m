Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60293FD530E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvt19-0003CR-0y; Fri, 27 Feb 2026 03:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvt0w-0003Bx-2O
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:15:59 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvt0r-0003yd-4d
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:15:56 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.178])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fMh3V0wTxz5w1W;
 Fri, 27 Feb 2026 08:15:50 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 09:15:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0043db11e66-586d-496a-8e73-3713535b6d82,
 1764588C194503052958D0AAF3448E51E66CE866) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <928e51e5-3111-46fd-88b3-c1a1e82666c5@kaod.org>
Date: Fri, 27 Feb 2026 09:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Joel Bueno <buenocalvachejoel@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:Block layer core"
 <qemu-block@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>,
 'Jamin Lin' <jamin_lin@aspeedtech.com>
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
 <b780d16f-82ba-43e2-b189-ba70594c7d7a@redhat.com>
 <CAPDLHD6ecMFX-Ls0inPM6kDrWXAKLiqf+jLXbUiFDgVGjBCruA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAPDLHD6ecMFX-Ls0inPM6kDrWXAKLiqf+jLXbUiFDgVGjBCruA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG11EX2.mxp5.local (172.16.2.112) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: fea5cf17-6b86-4352-8288-416acdea2443
X-Ovh-Tracer-Id: 5959951159258811314
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEWyI1YS5lc50K8yflqikBitf2imPGfmT6HSTD/4Yca2JVY8vAdo4pNHg0rmRUKBJqFuWrtr4gz/1QRrUbLNNgttGeskcmOszY4WKiNMdRg8h9XRbNROLLExlp3O9MMCHMfTGCwRaMpksN1zvbaiuuLBplzUWRmwSqzOnDDMom/CPHwC9S92reN8UjSHr1+LtznjpvlnhFAvmaNcxm+LyXpIP2obfGZ//Kbc6hpWn2bxWUX2P9kPHMSmP5s/H3nAZoRhokDWUi/bYqBIb4Mp646UwyCMxDpR/Lw9xqR93AbQ743DVxyPdqKGvNWfIev6R7ICy+B0nvUbqxXr24j22HDY+sc8O8b4IR16LcRKaHXvnECUJ2JRd+jaQWdAVG0RaRE+3JmvIBaeY3/7fEw487gILkngEEpRSafT1LSp02ezSEhm7pN3IcG6ZZsVu4LEr/ZHlO002iPRA5BO4sS6TLOR/h/7VwJOOAbE9yjJcq7tiskC+toPLzV1Su1MxCty2vcTkCUvcqKXE699bEaJbG1AkLC0LzIGV/Pc81umkCeTMWdeRH7Ykcl/TzxPKj46lJQDZ+e3dYkHJEtlir5UBGT3qpU208wpV5APx22jbVMByoV5J9mwDsIbiLVC8CeIt6vGiK+W7gpW38YETKF2nlTefHe4192caZnuVULj4SStw
DKIM-Signature: a=rsa-sha256; bh=RoUEDFGe3fmIWtD2nuAFn+qUdWFXjOJ7LIRx91xCI9A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772180150; v=1;
 b=hwVkFW08UZKlIyimei+d7mp8Lf6hM3gse7V0D4fpLYnaFJY1Yg/dbCXSoB73T8ncW70+vzsO
 5ZTLTbSpnp5i83RxjiFsGNmxoJfqUzp7s8ZOIHy07xaRmbXPf60UFEXxqwBZYmN47A4XPmc8cMW
 YkWL/DgRqBEVncP9dORQGjYTcEKjYbenpGA0kbxh89DSVLcHtSXPLng7TzM3F+F5thcGZlB4npz
 SRQNDf4oe5gaQZN4y+kXZjIwgiHM61C29gzwlArOAxTk84s8fW3Dvf2HLy1XPO4IZoWFBCB738Z
 jZUamp8XWUxzwrKmePc369zupaCm/pac5WBgJf3AYw9PA==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Joel,

+ Jamin, who spent time on aspeed_smc and m25p80 models.


On 2/20/26 11:09, Joel Bueno wrote:
> Hi Cédric, thanks for the detailed response and your time; I should've run the tests prior to the submission; apologies for the oversight!
> 
> I've been eyeing the aspeed_smc.c file and it seems to "inflate" the dummy clock phases:
> 
> static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
> {
>      const AspeedSMCState *s = fl->controller;
>      uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->cs];
>      uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>      uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
>      uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
> 
>      if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
>          dummies /= 2;
>      }
> 
>      return dummies;
> }
> 
> As you can see, it basically multiplies the number of "dummies" (Which is gathered by obtaining the full value of the register) by 8.
> That is, in turn, used on "aspeed_smc_flash_setup" (Only if aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) to decide how much dummy data to push with "ssi_transfer()".
> 
> It's a bit confusing for me to compare what the actual Winbond datasheet we have (Also cross-referenced similar product's datasheets just in case) expects in terms of needed_bytes (Which, as per datasheet, would be just 1, matching what, for instance, SST ones have; for reference).
> 
> The Designware SPI controller QEMU device we have sends a single byte (8 cycles in SPI) to the flash (Again, matching both Designware's and Winbond's datasheet).
> 
> Would it be interesting to have a second set of patch series trying to address the inconsistencies (Whilst addressing aspeed too) and making the Winbond model with what SST currently does in terms of "naming" convention?
> 
> Thanks again for everyone's time.
Could you please open an issue on gitlab with all the information
you gathered ? Please cc @legoater and @jamin-aspeed.

See https://gitlab.com/qemu-project/qemu/-/issues/3290 for an example.

Thanks for the time you have dedicated to this problem.

C.



> 
> 
> El vie, 20 feb 2026 a las 9:56, Cédric Le Goater (<clg@redhat.com <mailto:clg@redhat.com>>) escribió:
> 
>     Hello,
> 
>     +Marcin,
> 
>     On 2/19/26 21:01, Peter Maydell wrote:
>      > On Wed, 7 Jan 2026 at 11:30, Joel Bueno <buenocalvachejoel@gmail.com <mailto:buenocalvachejoel@gmail.com>> wrote:
>      >>
>      >> Is there any feedback on this patch series?
>      >
>      > Which board model(s) does this affect? You might have
>      > some luck cc'ing their maintainers.
>     AFAIR (10y ago ...), the dummy cycles in m25p80 are modeled as
>     extra "dummy bytes" consumed before data phase begins. So,
>     in QEMU : 8 cycles = 1 dummy byte.
> 
>     There could be bugs in this area, but this case was supposedly
>     fixed by commit 3830c7a460b8 ("m25p80: Fix WINBOND fast read
>     command handling") and given the number of QEMU boards booting
>     from a Winbond flash device :
> 
>         tests/functional/aarch64/test_aspeed_ast2700a1.py:        self.vm.set_machine('ast2700a1-evb,fmc-model=w25q512jv')
>         tests/functional/aarch64/test_aspeed_ast2700a2.py:        self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
>         hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model = "w25q80bl";
>         hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model = "w25q256";
>         hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model = "w25q80bl";
>         hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model = "w25q02jvm";
>         hw/arm/aspeed_ast2600_bletchley.c:    amc->fmc_model = "w25q01jvq";
>         hw/arm/aspeed_ast2600_catalina.c:    amc->fmc_model = "w25q01jvq";
>         hw/arm/aspeed_ast2600_evb.c:    amc->fmc_model = "w25q512jv";
>         hw/arm/aspeed_ast2600_evb.c:    amc->spi_model = "w25q512jv";
>         hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model = "w25q01jvq";
>         hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model = "w25q512jv";
>         hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model = "w25q01jvq";
>         hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model = "w25q512jv";
>         hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_FMC_MODEL "w25q01jvq"
>         hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_SPI_MODEL "w25q512jv"
>         hw/arm/npcm7xx_boards.c:    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
>         hw/arm/npcm8xx_boards.c:    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
> 
>     I doubt this change is correct or the issue is more complex
>     than it seems. Please try to run the functional tests, all
>     ast2600 machines seem to fail to boot with this patch.
> 
> 
>     Thanks,
> 
>     C.
> 
> 
>     For the records, fast read commands are used in the tests. See below.
> 
>         [0x406c0641] : The second byte '6c' is the SPI operation.
> 
> 
>     aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-11 13:22:45,545: [    0.510414] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-11 13:22:45,713: [    0.650635] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,173: [    1.517517] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,320: [    1.608993] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_sdk_v11_00/console.log:2026-02-13 11:49:30,346: [    1.625580] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
>     aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_ioexp_v11_00/console.log:2026-02-13 15:50:03,329: [    4.852499] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]
>     aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_ioexp_v11_00/console.log:2026-02-13 15:50:03,850: [    5.178221] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]
>     aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,247: [    1.275618] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,369: [    1.352064] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_sdk_v11_00/console.log:2026-02-13 11:49:31,385: [    1.361942] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
>     aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioexp_v11_00/console.log:2026-02-10 16:47:50,922: [    3.123120] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]
>     aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioexp_v11_00/console.log:2026-02-10 16:47:51,224: [    3.312014] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]
>     aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,279: [    1.264763] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,408: [    1.345588] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v11_00/console.log:2026-02-10 16:49:00,424: [    1.355559] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
>     aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:40,859: [    1.568162] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:41,032: [    1.676511] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]
>     aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_vbootrom_v11_00/console.log:2026-02-13 11:49:41,069: [    1.699459] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]
>     arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_buildroot/console.log:2026-02-13 15:50:25,370: [    1.333537] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
>     arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_buildroot/console.log:2026-02-13 15:50:25,659: [    1.625199] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]
>     arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console.log:2026-02-13 15:50:22,593: [    1.287417] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 2 [0x203b0641]
>     arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console.log:2026-02-13 15:50:23,319: [    2.013603] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 2 [0x203c0741]
>     arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_buildroot/console.log:2026-02-13 15:50:35,593: [    2.848343] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
>     arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_buildroot/console.log:2026-02-13 15:50:35,876: [    3.086504] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
>     arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_buildroot_tpm/console.log:2026-02-13 15:51:11,310: [    1.769397] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
>     arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_buildroot_tpm/console.log:2026-02-13 15:51:11,400: [    1.844341] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
>     arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-13 15:50:31,578: [    4.177582] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
>     arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console.log:2026-02-13 15:50:32,052: [    4.571849] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
>     arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockdev_device/console.log:2026-02-13 15:50:27,134: [    2.312565] spi-aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]
>     arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockdev_device/console.log:2026-02-13 15:50:27,533: [    2.644716] spi-aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]
>     arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc/console.log:2026-02-13 15:50:39,306: [    2.488488] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
>     arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc/console.log:2026-02-13 15:50:46,183: [    8.220262] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
>     arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/console.log:2026-02-13 15:50:34,667: [    1.470919] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
>     arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/console.log:2026-02-13 15:50:41,745: [    7.369080] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
>     arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/console.log:2026-02-13 15:50:22,255: [    1.277601] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]
>     arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/console.log:2026-02-13 15:50:22,589: [    1.558898] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]
>     arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/console.log:2026-02-13 15:50:31,164: [    0.840722] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
>     arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/console.log:2026-02-13 15:50:31,405: [    1.082523] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c2041]
>     arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/console.log:2026-02-13 15:50:35,622: [    1.281889] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]
>     arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/console.log:2026-02-13 15:50:35,832: [    1.491569] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]
>     arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,149: [    0.885126] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]
>     arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,193: [    0.932894] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]
>     arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon_openbmc/console.log:2026-02-13 15:50:44,242: [    0.982561] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]
> 


