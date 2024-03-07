Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F37AC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBDN-00075P-PZ; Thu, 07 Mar 2024 05:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hzXx=KN=kaod.org=clg@ozlabs.org>)
 id 1riBDI-0006zj-Fv; Thu, 07 Mar 2024 05:43:03 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hzXx=KN=kaod.org=clg@ozlabs.org>)
 id 1riBDG-0004TN-4R; Thu, 07 Mar 2024 05:43:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tr5VF0BHmz4wc8;
 Thu,  7 Mar 2024 21:42:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tr5V82Ssgz4wc7;
 Thu,  7 Mar 2024 21:42:37 +1100 (AEDT)
Message-ID: <bd9e5103-661e-46c4-801d-5afdd629d5cf@kaod.org>
Date: Thu, 7 Mar 2024 11:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Add AST2700 support
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <5e09c627-01aa-46cd-b367-b537f5b61e03@kaod.org>
 <SI2PR06MB5041140DFC668A43DBAB81E3FC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041140DFC668A43DBAB81E3FC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=hzXx=KN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/24 04:38, Jamin Lin wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Monday, March 4, 2024 11:54 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Andrew Jeffery <andrew@codeconstruct.com.au>;
>> Joel Stanley <joel@jms.id.au>; Alistair Francis <alistair@alistair23.me>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v2 0/9] Add AST2700 support
>>
>> Hello Jamin,
>>
>> On 3/4/24 10:29, Jamin Lin wrote:
>>> Changes from v1:
>>> The patch series supports WDT, SDMC, SMC, SCU, SLI and INTC for AST2700
>> SoC.
>>>
>>> Changes from v2:
>>> - replace is_aarch64 with is_bus64bit for sdmc patch review.
>>> - fix incorrect dram size for AST2700
>>>
>>> Test steps:
>>> 1. Download openbmc image for AST2700 from
>>>      https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.00
>>>
>> https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.00/
>>>      ast2700-default-obmc.tar.gz
>>> 2. untar ast2700-default-obmc.tar.gz
>>>      ```
>>>      tar -xf ast2700-default-obmc.tar.gz
>>>      ```
>>> 3. Run and the contents of scripts as following IMGDIR=ast2700-default
>>> UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
>>> UBOOT_DTB_ADDR=$((0x400000000 + ${UBOOT_SIZE}))
>>>
>>> qemu-system-aarch64 -M ast2700-evb -nographic\
>>>    -device
>> loader,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin,force-raw=on\
>>>    -device
>> loader,addr=${UBOOT_DTB_ADDR},file=${IMGDIR}/u-boot.dtb,force-raw=on\
>>>    -device loader,addr=0x430000000,file=${IMGDIR}/bl31.bin,force-raw=on\
>>>    -device
>> loader,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin,force-raw=on\
>>>    -device loader,addr=0x430000000,cpu-num=0\
>>>    -device loader,addr=0x430000000,cpu-num=1\
>>>    -device loader,addr=0x430000000,cpu-num=2\
>>>    -device loader,addr=0x430000000,cpu-num=3\
>>>    -smp 4\
>>>    -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd\
>>>    -serial mon:stdio\
>>>    -snapshot
>>>
>>> Known Issue:
>>> 1. QEMU supports ARM Generic Interrupt Controller, version 3(GICv3)
>>> but not support Shared Peripheral Interrupt (SPI), yet.
>>> Added work around in INTC patch to set GICINT132[18] which was BMC
>>> UART interrupt if it received GICINT132, so users are able to type any
>>> key from keyboard to trigger GICINT132 interrupt until AST2700 boot
>>> into login prompt. It is a temporary solution.
>>> If users encounter boot stck and no booting log, please type any key
>>> from keyboard.
>>
>> I haven't looked at the GIC issue but I started reviewing what I received.
>>
>> The mailer issue needs to be fixed before we consider this patches for merge.
>> May be use an external email while keeping the same
>> From: and Signed-off-by address.
>>
> Understand.
> Thanks for your suggestion. I am asking our IT help to fix our smtp server issue.
> They are fixing it. I will use my external account to send V3 patch series if
> this issues does not be fixed, yet.
>> When you resend, could you please add an avocado test ?
>>
> Sure, will create a patch for avocado test.

Forgot to add,

please update the documentation docs/system/arm/aspeed.rst.

Thanks,

C.



