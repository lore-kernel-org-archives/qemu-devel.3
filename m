Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33EFE67803
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Ff6-0000n6-90; Sat, 02 Nov 2024 11:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Ff4-0000lr-4k; Sat, 02 Nov 2024 11:03:34 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Ff2-0004jV-JS; Sat, 02 Nov 2024 11:03:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XggwF6hGGz4x8R;
 Sun,  3 Nov 2024 02:03:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xggw92DkSz4wxf;
 Sun,  3 Nov 2024 02:03:21 +1100 (AEDT)
Message-ID: <9cf62dd0-2e88-4692-8a16-544b75665b6c@kaod.org>
Date: Sat, 2 Nov 2024 16:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 0/8] Support RTC for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uVOK=R5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/29/24 10:17, Jamin Lin wrote:
> change from v1:
> 1. Support RTC for AST2700.
> 2. Support SDHCI write protected pin inverted for AST2500 and AST2600.
> 3. Introduce Capabilities Register 2 for SD slot 0 and 1.
> 4. Support create flash devices via command line for AST1030.
> 
> Jamin Lin (8):
>    aspeed/soc: Support RTC for AST2700
>    hw/timer/aspeed: Fix coding style
>    hw/timer/aspeed: Fix interrupt status does not be cleared for AST2600
>    hw/sd/sdhci: Fix coding style
>    hw/sd/sdhci: Introduce a new Write Protected pin inverted property
>    hw/sd/aspeed_sdhci: Introduce Capabilities Register 2 for SD slot 0
>      and 1
>    hw/arm/aspeed: Invert sdhci write protected pin for AST2600 and
>      AST2500 EVBs
>    aspeed: Support create flash devices via command line for AST1030
> 
>   hw/arm/aspeed.c         | 30 ++++++++++++------
>   hw/arm/aspeed_ast27x0.c | 11 +++++++
>   hw/sd/aspeed_sdhci.c    | 40 ++++++++++++++++-------
>   hw/sd/sdhci.c           | 70 ++++++++++++++++++++++++++++-------------
>   hw/timer/aspeed_timer.c | 15 +++++----
>   include/hw/arm/aspeed.h |  1 +
>   include/hw/sd/sdhci.h   |  5 +++
>   7 files changed, 123 insertions(+), 49 deletions(-)
> 

Applied 1,2,3,6,8 to aspeed-next.

Thanks,

C.



