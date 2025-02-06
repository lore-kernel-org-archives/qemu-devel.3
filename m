Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7432C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwDm-0001SK-PL; Thu, 06 Feb 2025 02:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=u7L3=U5=kaod.org=clg@ozlabs.org>)
 id 1tfwDk-0001Rf-MR; Thu, 06 Feb 2025 02:22:44 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=u7L3=U5=kaod.org=clg@ozlabs.org>)
 id 1tfwDi-0007YQ-Lj; Thu, 06 Feb 2025 02:22:44 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YpT8660Srz4wyr;
 Thu,  6 Feb 2025 18:22:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YpT826fXrz4wnp;
 Thu,  6 Feb 2025 18:22:26 +1100 (AEDT)
Message-ID: <5856008e-a664-4f5c-a0c0-6813aaf8775a@kaod.org>
Date: Thu, 6 Feb 2025 08:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of
 INTC controllers for AST2700 A1
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-13-jamin_lin@aspeedtech.com>
 <cb18b72dbfce3a606a4bd7ea41732d451fbea0f1.camel@codeconstruct.com.au>
 <SI2PR06MB50414F9067112317161AD907FCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ad26f753de3648a2b238514ac7136847a2ae3a71.camel@codeconstruct.com.au>
 <SI2PR06MB50410511510D84B854672E8CFCF72@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB50410511510D84B854672E8CFCF72@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=u7L3=U5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.069, RCVD_IN_DNSWL_MED=-2.3,
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

> The design of the OR gates for GICINT 196 is as follows:
> It has interrupt sources ranging from 0 to 31, with its output pin connected to
> INTC_IO "T0 GICINT_196".
> The output pin is then connected to INTC_CPU "GIC_192_201" at bit 4, and
> its bit 4 output should be connected to GIC 196.
> The design of INTC_CPU GIC_192_201 have 10 output pins, mapped as following:
> Bit 0 -> GIC 192
> Bit 1 -> GIC 193
> Bit 2 -> GIC 194
> Bit 3 -> GIC 195
> Bit 4 -> GIC 196
> 
> Jamin
>      |-------------------------------------------------------------------------------------------------------|
>      |                                                   AST2700 A1 Design                                   |
>      |           To GICINT196                                                                                |
>      |                                                                                                       |
>      |   ETH1    |-----------|                    |--------------------------|        |--------------|       |
>      |  -------->|0          |                    |         INTC_IO          |        |  orgates[0]  |       |
>      |   ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|------->| 0            |       |
>      |  -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|------->| 1            |       |
>      |   ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|------->| 2            |       |
>      |  -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|------->| 3  OR[0:9]   |-----| |
>      |   UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|------->| 4            |     | |
>      |  -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|------->| 5            |     | |
>      |   UART1   |         22|   orgates[6]------>|inpin[6]-------->outpin[6]|------->| 6            |     | |
>      |  -------->|8        23|   orgates[7]------>|inpin[7]-------->outpin[7]|------->| 7            |     | |
>      |   UART2   |         24|   orgates[8]------>|inpin[8]-------->outpin[8]|------->| 8            |     | |
>      |  -------->|9        25|   orgates[9]------>|inpin[9]-------->outpin[9]|------->| 9            |     | |
>      |   UART3   |         26|                    |--------------------------|        |--------------|     | |
>      |  ---------|10       27|                                                                             | |
>      |   UART5   |         28|                                                                             | |
>      |  -------->|11       29|                                                                             | |
>      |   UART6   |           |                                                                             | |
>      |  -------->|12       30|     |-----------------------------------------------------------------------| |
>      |   UART7   |         31|     |                                                                         |
>      |  -------->|13         |     |                                                                         |
>      |   UART8   |  OR[0:31] |     |                |------------------------------|           |----------|  |
>      |  -------->|14         |     |                |            INTC              |           |     GIC  |  |
>      |   UART9   |           |     |                |inpin[0:0]--------->outpin[0] |---------->|192       |  |
>      |  -------->|15         |     |                |inpin[0:1]--------->outpin[1] |---------->|193       |  |
>      |   UART10  |           |     |                |inpin[0:2]--------->outpin[2] |---------->|194       |  |
>      |  -------->|16         |     |                |inpin[0:3]--------->outpin[3] |---------->|195       |  |
>      |   UART11  |           |     |--------------> |inpin[0:4]--------->outpin[4] |---------->|196       |  |
>      |  -------->|17         |                      |inpin[0:5]--------->outpin[5] |---------->|197       |  |
>      |   UART12  |           |                      |inpin[0:6]--------->outpin[6] |---------->|198       |  |
>      |  -------->|18         |                      |inpin[0:7]--------->outpin[7] |---------->|199       |  |
>      |           |-----------|                      |inpin[0:8]--------->outpin[8] |---------->|200       |  |
>      |                                              |inpin[0:9]--------->outpin[9] |---------->|201       |  |
>      |-------------------------------------------------------------------------------------------------------|
>      |-------------------------------------------------------------------------------------------------------|
>      |  ETH1    |-----------|     orgates[1]------->|inpin[1]|---------->outpin[10]|---------->|128       |  |
>      | -------->|0          |     orgates[2]------->|inpin[2]|---------->outpin[11]|---------->|129       |  |
>      |  ETH2    |          4|     orgates[3]------->|inpin[3]|---------->outpin[12]|---------->|130       |  |
>      | -------->|1         5|     orgates[4]------->|inpin[4]|---------->outpin[13]|---------->|131       |  |
>      |  ETH3    |          6|---->orgates[5]------->|inpin[5]|---------->outpin[14]|---------->|132       |  |
>      | -------->|2        19|     orgates[6]------->|inpin[6]|---------->outpin[15]|---------->|133       |  |
>      |  UART0   |         20|     orgates[7]------->|inpin[7]|---------->outpin[16]|---------->|134       |  |
>      | -------->|7        21|     orgates[8]------->|inpin[8]|---------->outpin[17]|---------->|135       |  |
>      |  UART1   |         22|     orgates[9]------->|inpin[9]|---------->outpin[18]|---------->|136       |  |
>      | -------->|8        23|                       |------------------------------|           |----------|  |
>      |  UART2   |         24|                                                                                |
>      | -------->|9        25|                       AST2700 A0 Design                                        |
>      |  UART3   |         26|                                                                                |
>      | -------->|10       27|                                                                                |
>      |  UART5   |         28|                                                                                |
>      | -------->|11       29| GICINT132                                                                      |
>      |  UART6   |           |                                                                                |
>      | -------->|12       30|                                                                                |
>      |  UART7   |         31|                                                                                |
>      | -------->|13         |                                                                                |
>      |  UART8   |  OR[0:31] |                                                                                |
>      | -------->|14         |                                                                                |
>      |  UART9   |           |                                                                                |
>      | -------->|15         |                                                                                |
>      |  UART10  |           |                                                                                |
>      | -------->|16         |                                                                                |
>      |  UART11  |           |                                                                                |
>      | -------->|17         |                                                                                |
>      |  UART12  |           |                                                                                |
>      | -------->|18         |                                                                                |
>      |          |-----------|                                                                                |
>      |                                                                                                       |
>      |-------------------------------------------------------------------------------------------------------|


Nice ! When you send the intc series for ast2700a1 support, could you
please include this diagram in file docs/specs/aspeed-intc.rst with
some description ? The text could be the same as the cover letter.


Thanks,

C.


