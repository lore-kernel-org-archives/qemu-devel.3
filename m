Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0A8CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUGd-0004q0-Mi; Tue, 03 Sep 2024 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org>)
 id 1slUGa-0004cG-8G; Tue, 03 Sep 2024 10:12:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org>)
 id 1slUGY-0000Vm-65; Tue, 03 Sep 2024 10:12:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wyncr1lj9z4x8F;
 Wed,  4 Sep 2024 00:12:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wynck74PCz4wxx;
 Wed,  4 Sep 2024 00:11:47 +1000 (AEST)
Message-ID: <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
Date: Tue, 3 Sep 2024 16:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 00/11] support I2C for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Bo9S=QB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 9/3/24 10:35, Jamin Lin wrote:
> v1:
> - support I2C for AST2700
> 
> v2:
> - fix review issues and add reviewer suggestion
> - update avocado test case for AST2700 I2C
> - support i2c bus pool
> 
> v3:
> - update commit messages and commit title
> - update API to get the device irq
> 
> Jamin Lin (11):
>    hw/i2c/aspeed: Support discontinuous register memory region of I2C bus
>    hw/i2c/aspeed: Introduce a new bus pool buffer attribute in
>      AspeedI2Cbus
>    hw/i2c/aspeed: Support discontinuous poll buffer memory region of I2C
>      bus
>    hw/i2c/aspeed: Introduce a new dma_dram_offset attribute in
>      AspeedI2Cbus
>    hw/i2c/aspeed: Add AST2700 support
>    hw/i2c/aspeed: Add support for Tx/Rx buffer 64 bit addresses
>    hw/i2c/aspeed: Add support for 64 bit addresses
>    aspeed/soc: Introduce a new API to get the device irq
>    aspeed/soc: Support I2C for AST2700
>    aspeed: Add tmp105 in i2c bus 0 for AST2700
>    machine_aspeed.py: Update to test I2C for AST2700
> 
>   hw/arm/aspeed.c                 |  10 ++
>   hw/arm/aspeed_ast27x0.c         |  45 +++++
>   hw/i2c/aspeed_i2c.c             | 310 ++++++++++++++++++++++++++++----
>   include/hw/i2c/aspeed_i2c.h     |  28 ++-
>   tests/avocado/machine_aspeed.py |  16 ++
>   5 files changed, 362 insertions(+), 47 deletions(-)
> 



Applied to aspeed-next.

Thanks,

C.



