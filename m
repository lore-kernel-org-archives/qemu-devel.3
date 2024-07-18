Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C998C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTqU-0004s8-8Y; Thu, 18 Jul 2024 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUTqM-0004iA-QN; Thu, 18 Jul 2024 12:18:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUTqI-00083o-UC; Thu, 18 Jul 2024 12:18:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPyfc32LMz4x3c;
 Fri, 19 Jul 2024 02:18:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPyfV4bYcz4x12;
 Fri, 19 Jul 2024 02:18:22 +1000 (AEST)
Message-ID: <df6ee32d-f404-4f24-9dae-e755e5566d5f@kaod.org>
Date: Thu, 18 Jul 2024 18:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] support ADC and I2C for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3riu=OS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/18/24 08:49, Jamin Lin wrote:
> v1:
> 1. support ADC for AST2700
> 2. support I2C for AST2700
> 
> Jamin Lin (15):
>    aspeed/adc: Add AST2700 support
>    aspeed/soc: support ADC for AST2700
>    hw/i2c/aspeed: support to set the different memory size
>    hw/i2c/aspeed: support discontinuous register memory region of I2C bus
>    hw/i2c/aspeed: rename the I2C class pool attribute to share_pool
>    hw/i2c/aspeed: introduce a new bus pool buffer attribute in
>      AspeedI2Cbus
>    hw/i2c/aspeed: support discontinuous poll buffer memory region of I2C
>      bus
>    hw/i2c/aspeed: introduce a new dma_dram_offset attribute in
>      AspeedI2Cbus
>    hw/i2c/aspeed: Add AST2700 support
>    hw/i2c/aspeed: support Tx/Rx buffer 64 bits address
>    hw/i2c/aspeed: support high part dram offset for DMA 64 bits
>    aspeed/soc: introduce a new API to get the INTC orgate information
>    aspeed/soc: support I2C for AST2700
>    aspeed: fix coding style
>    aspeed: add tmp105 in i2c bus 0 for AST2700
> 
>   hw/adc/aspeed_adc.c         |  16 ++
>   hw/arm/aspeed.c             |  31 +++-
>   hw/arm/aspeed_ast27x0.c     |  65 +++++++
>   hw/i2c/aspeed_i2c.c         | 340 ++++++++++++++++++++++++++++++------
>   include/hw/adc/aspeed_adc.h |   1 +
>   include/hw/i2c/aspeed_i2c.h |  34 ++--
>   6 files changed, 418 insertions(+), 69 deletions(-)
> 



Applied 1-2 to aspeed-next.

Thanks,

C.



