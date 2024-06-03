Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC290C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE21v-0006QF-9Q; Mon, 03 Jun 2024 03:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jUUh=NF=kaod.org=clg@ozlabs.org>)
 id 1sE21s-0006PY-H5; Mon, 03 Jun 2024 03:22:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jUUh=NF=kaod.org=clg@ozlabs.org>)
 id 1sE21p-0003wj-T5; Mon, 03 Jun 2024 03:22:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Vt4tp52NBz4x2P;
 Mon,  3 Jun 2024 17:22:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vt4tj5L3Kz4wcJ;
 Mon,  3 Jun 2024 17:22:37 +1000 (AEST)
Message-ID: <98886224-8de7-41d7-9ae9-77ac85818605@kaod.org>
Date: Mon, 3 Jun 2024 09:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
 <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
 <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
 <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=jUUh=NF=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

>>>> @@ -670,7 +670,7 @@ static const MemoryRegionOps
>> aspeed_smc_flash_ops
>>>> = {
>>>>        .endianness = DEVICE_LITTLE_ENDIAN,
>>>>        .valid = {
>>>>            .min_access_size = 1,
>>>> -        .max_access_size = 4,
>>>> +        .max_access_size = 8,
>>>
>>> Is this a bugfix? If so, please use a separate patch. Otherwise please
>>> mention why it is OK to widen access for AST2600 & AST10x0.
>>
> According the design of SPI drivers, it uses this "memcpy_fromio" KERNEL API for SPI calibration.
> https://github.com/AspeedTech-BMC/linux/blob/1062a07420f9aed4ed7dc9deb3429b8e7828f5cf/drivers/spi/spi-aspeed-smc.c#L1832
> AST2700 is a 64 bits quad core cpus(Cortex-a35), so kernel API use 64 bits for data access.
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/kernel/io.c#L25
> I simply set the max_access_size to 8 for AST2700 support.
> AST2500, AST2600 and AST10x0 are all 32bits CPUS, that was why this max_access_size 8 did not impact these models.
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm/kernel/io.c#L45

Yes. I think we are safe on that side.

> If you have any suggestion about this patch modification, please let me know.
> I am going to re-send v5 patch for AST2700 support.

Please move this change in its own commit explaining the reason and
add a TODO comment in the code.
  
The aspeed_smc_flash_ops MemoryRegionOps should be copied in _realize()
to set a different width for the AST2700 SoC. You could do that too.

Thanks,

C.


