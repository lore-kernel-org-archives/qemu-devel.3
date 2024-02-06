Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3878C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOb5-00043E-RN; Tue, 06 Feb 2024 11:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOb0-000422-Fo; Tue, 06 Feb 2024 11:46:54 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOay-0006Su-KW; Tue, 06 Feb 2024 11:46:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TTq043wFTz4wyp;
 Wed,  7 Feb 2024 03:46:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTq0200Xqz4wcC;
 Wed,  7 Feb 2024 03:46:39 +1100 (AEDT)
Message-ID: <39340aef-9560-4b10-8ced-58b84fbf2746@kaod.org>
Date: Tue, 6 Feb 2024 17:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
 <da2708e0-c3f3-4e11-af24-07817bc0cdfd@linaro.org>
 <SI2PR06MB5041B14996B7E258F54AEAF9FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041B14996B7E258F54AEAF9FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=f3tV=JP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

[ ... ]


> As you said, uart12 mapped ASPEED_DEV_UART13.
> The device naming will confuse users because the device name in qemu mismatch with ast2700 datasheet.
>
> That way why we want to add ASPEED_DEV_UART0 and set the memory map of AST2700 as following.
> static const hwaddr aspeed_soc_ast2700_memmap[] = {
>      [ASPEED_DEV_UART0]     =  0X14C33000,
>      [ASPEED_DEV_UART1]     =  0X14C33100,
>      [ASPEED_DEV_UART2]     =  0X14C33200,
>      [ASPEED_DEV_UART3]     =  0X14C33300,
>      [ASPEED_DEV_UART4]     =  0X12C1A000,
>      [ASPEED_DEV_UART5]     =  0X14C33400,
>      [ASPEED_DEV_UART6]     =  0X14C33500,
>      [ASPEED_DEV_UART7]     =  0X14C33600,
>      [ASPEED_DEV_UART8]     =  0X14C33700,
>      [ASPEED_DEV_UART9]     =  0X14C33800,
>      [ASPEED_DEV_UART10]    =  0X14C33900,
>      [ASPEED_DEV_UART11]    =  0X14C33A00,
>      [ASPEED_DEV_UART12]    =  0X14C33B00,
>

So we would prefer to keep the QEMU IP names in sync with the datasheet,
and in that case your proposal makes sense.

A have a few comments that I will make on the patch.

Thanks,

C.




