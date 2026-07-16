Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C3C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFdF-0004uD-Vr; Thu, 16 Jul 2026 02:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkFcH-0004iv-H9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:30:43 -0400
Received: from smtpout9.mo536.mail-out.ovh.net ([51.210.91.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkFcB-0001fy-Pe
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:30:38 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4h137q2JL7z87tS;
 Thu, 16 Jul 2026 06:30:31 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Thu, 16 Jul 2026 06:30:31 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.159])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h137q0c1dz7tLD;
 Thu, 16 Jul 2026 06:30:31 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 964E42403DCF; Thu, 16 Jul 2026 06:30:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S00845926cd9-ae6f-42c5-ac48-23336c4e9b46,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5d04f85f-1ac6-41e8-a2aa-744d7891b16d@kaod.org>
Date: Thu, 16 Jul 2026 08:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-9-jamin_lin@aspeedtech.com>
 <bf6d933b-c15b-45ca-b20f-62b786e3d434@kaod.org>
 <TYZPR06MB4980058F16852B1E754F2DFFFCF82@TYZPR06MB4980.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYZPR06MB4980058F16852B1E754F2DFFFCF82@TYZPR06MB4980.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8829025598266584075
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGkjGI0aaFLpQyYQ8xLGzPskbpxmPeD137evB4ROUvcqI1OVR50VBt2VEBFVRhcx2QuxvaoDgaWiIg8ppEk92XXjn95eQEAImrx1t7RHNccqs5b56XFg9IcAijwPZ5PXR9FzVxmTbOEkcRk+IQHeT9MSNcf8G/O/2rS6TnuNh3/Ef4QYw1cDXPEpfMVBeA9NQjafE8ZPZecWgUY+ZSc6Zu7z6oQAwoWAcnB4UL6Vmy2ShdUxmAxxklVFZMJg0VkLt3diGuh22aOoI+BbJo3gGitxafndo8rSDUrn0jQ6jg7qT86nXOz1vaLFBTmOGc15cet4wHFGhZMBPTBtFwA+WKeCpC6qQKnUe+lUCqgg9Ir8xQHHS1XxPzdnxsOpPtaxo3hWMAE3tweyXUE4DmZQ0TT0gJoNvarsZFhYJvCYLv2o4e/J9H6bconMFsDOj2gdDZbkO1/WHtxJWq1njrfV02Xh97LqOu/IWN2QS/hOaQlEAdEtxMPNr0VJ3J8VaSfMCI4uL0GpXAIZlOoLygsycOER0HORyb82S4IU/Cz0F2lUUw+8Zo+LAi3tILyFbI8O6QH5VWVzSLmY9PHKCgFyDTaDfszP0u7+sy0tfX+5wIaYQE4EQo3YEdhoxf8U+ph7Xn/3lqTef3Qb6Co2tZmxMhn+gJnCIUs48Ofn/73FWFcLA
DKIM-Signature: a=rsa-sha256; bh=5Ah0psj7eFvuUiYLrZ50hwHgFPUUHAlcMukDOLOM0nM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784183432; v=1;
 b=Cv9TSjAImzWsz8eVDv89kA77D0Qars+0JNS8yJ7ccc8aCZ83KGZtqJ1nhZajnaRqsBT3T0Kw
 hJ5CMtrM0m3S6RS3r1k3AG1P6tN7/v24GoWIb3Oe8Z/a6jmIMHaSQbyaj/Xyw33TpAAlcs82vCo
 KhE11Om+KGen3tX6hyZhlBvbvwPdMmn+ZjKLG5bD7l7IMxkEfpYJWbaL+M3LNABHoA78s8uQb9d
 7bWVT79/wVyNmEUFxoZvkvZYKSAyYfywEeMqiJrbBsKDioyExzsr3wOo6CP5V3IGa+78UJMzppC
 4gI/MJK0mjdE9tKzrFOCw173Dp6sjp8WJi2ZT9RN07KBQ==
Received-SPF: pass client-ip=51.210.91.18; envelope-from=clg@kaod.org;
 helo=smtpout9.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/26 09:58, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
>> access support for AST2700
>>
>> On 7/7/26 08:09, Jamin Lin wrote:
>>> AST2700 supports a Data FIFO mode where flash accesses can be
>>> performed directly through Data FIFO MMIO offsets. The Data FIFO start
>>> offset increments by one for every 16MB of flash address space,
>>> allowing the chip select (CS) to be decoded from the Data FIFO offset.
>>>
>>> This change adds Data FIFO support to the Aspeed SMC model and
>>> introduces a class callback to translate Data FIFO offsets into CS
>>> indices. For AST2700, the Data FIFO offset is matched against the
>>> segment start address of each CS to determine the target flash device.
>>>
>>> The SMC register region size (nregs) is also extended dynamically
>>> based on the number of supported chip selects to cover all possible
>>> Data FIFO regions.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    include/hw/ssi/aspeed_smc.h |   3 +-
>>>    hw/ssi/aspeed_smc.c         | 113
>> +++++++++++++++++++++++++++++++++---
>>>    2 files changed, 107 insertions(+), 9 deletions(-)
>>
>> I am looking for a way to test "Data FIFO-based flash access".
>> A qtest extension of the ast2700 smc test would be nice to have.
>>
> Will do.
> 
>> Is the latest SDK kernel using this feature ?
>>
> Yes. Please try the following pre-built image:
> https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.02/ast2700-irot-obmc.tar.gz
> 
> The image-bmc file in the archive is smaller than 128 MB. Since the QEMU FMC flash model expects a 128 MB flash device, please resize it before using it:
> 
> jamin@JaminLin-PC:~/qemu-work/debug-qemu-ssp-review/ast2700-irot$ truncate --size 128M image-bmc
> 
> This pre-built image boots both the PSP and SSP.
> 
> After the system boots, log in to the Zephyr shell running on the SSP and use the following command to read the contents of the FMC CS0 flash:
> 
> ssp:~$ flash read fmc@0 0 100
> 00000000: 46 4c 53 48 01 00 11 00  aa 26 87 00 f9 64 80 79 |FLSH.... .&...d.y|
> 00000010: 01 00 00 00 dc 00 00 00  74 a6 01 00 02 00 00 00 |........ t.......|
> 00000020: 50 a7 01 00 84 3e 00 00  03 00 00 00 d4 e5 01 00 |P....>.. ........|
> 00000030: 60 ce 02 00 00 10 00 00  34 b4 04 00 d8 77 00 00 |`....... 4....w..|
> 00000040: 01 10 00 00 0c 2c 05 00  00 00 01 00 02 10 00 00 |.....,.. ........|
> 00000050: 0c 2c 06 00 b8 74 00 00  03 10 00 00 c4 a0 06 00 |.,...t.. ........|
> 00000060: 00 00 01 00 04 10 00 00  c4 a0 07 00 54 cf 00 00 |........ ....T...|
> 00000070: 05 10 00 00 18 70 08 00  00 00 01 00 06 10 00 00 |.....p.. ........|
> 00000080: 18 70 09 00 00 40 00 00  07 10 00 00 18 b0 09 00 |.p...@.. ........|
> 00000090: 00 a0 00 00 08 10 00 00  18 50 0a 00 6c 70 00 00 |........ .P..lp..|
> 000000A0: 09 10 00 00 84 c0 0a 00  90 ac 06 00 0a 10 00 00 |........ ........|
> 000000B0: 14 6d 11 00 58 82 0d 00  0b 10 00 00 6c ef 1e 00 |.m..X... ....l...|
> 000000C0: 6c 3e 03 00 0c 10 00 00  d8 2d 22 00 00 00 00 00 |l>...... .-".....|
> 000000D0: 0d 10 00 00 d8 2d 22 00  34 99 75 03 43 4d 41 4e |.....-". 4.u.CMAN|
> 000000E0: fc 16 00 00 5f 19 49 fc  a6 6a 8d 66 e6 26 80 87 |...._.I. .j.f.&..|
> 000000F0: e3 f0 48 2a 3b 01 b0 63  fe cf 0a a3 20 56 f1 62 |..H*;..c .... V.b|
> 
> You can then compare it with the beginning of the image-bmc file on the host:
> 
> jamin@JaminLin-PC:~/qemu-work/debug-qemu-ssp-review/ast2700-irot$ xxd image-bmc | head
> 00000000: 464c 5348 0100 1100 aa26 8700 f964 8079  FLSH.....&...d.y
> 00000010: 0100 0000 dc00 0000 74a6 0100 0200 0000  ........t.......
> 00000020: 50a7 0100 843e 0000 0300 0000 d4e5 0100  P....>..........
> 00000030: 60ce 0200 0010 0000 34b4 0400 d877 0000  `.......4....w..
> 00000040: 0110 0000 0c2c 0500 0000 0100 0210 0000  .....,..........
> 00000050: 0c2c 0600 b874 0000 0310 0000 c4a0 0600  .,...t..........
> 00000060: 0000 0100 0410 0000 c4a0 0700 54cf 0000  ............T...
> 00000070: 0510 0000 1870 0800 0000 0100 0610 0000  .....p..........
> 00000080: 1870 0900 0040 0000 0710 0000 18b0 0900  .p...@..........
> 00000090: 00a0 0000 0810 0000 1850 0a00 6c70 0000  .........P..lp..
> 
> The contents read from the emulated flash should match the corresponding data in image-bmc

I trust you will add a test case for Data FIFO-based flash access support
in a follow up patch.

Thanks,

C.


