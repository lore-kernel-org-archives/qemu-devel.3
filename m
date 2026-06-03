Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A619FCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUf8S-0006Y2-Ai; Wed, 03 Jun 2026 02:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wUf8R-0006Xu-9W
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:31:27 -0400
Received: from smtpout3.mo540.mail-out.ovh.net ([51.210.91.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wUf8P-00068z-Gc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:31:26 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gVdBT6vNfz4PwS;
 Wed,  3 Jun 2026 06:31:13 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  3 Jun 2026 06:31:13 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.96])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gVdBT1yLvz1xpD; Wed,  3 Jun 2026 06:31:13 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 2D458240306A; Wed,  3 Jun 2026 06:31:12 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055e5032cd-eeac-4152-b026-7defa558cd84,
 5CFAFB9919344B1C1428CC102C89BC7CB8215022) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <23f1f0b1-bf57-4698-9080-5df3f032a2ed@kaod.org>
Date: Wed, 3 Jun 2026 08:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] hw/arm/aspeed: Add AST1040 peripheral support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14569426272735046667
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFwrRqCKDh+q+o5iXEncbbuBB5GVMgbSVw4R1AgmWNjUnaU+FgHJJzYajXYXxIc+XpvTosR6C3o0ZR4UE/2A3cmCz2/iRGv1FQQSAb8CaP7b+UczBHFdN+h7XUOGjqRDnMJUaSs5KhwAn+MRVGNgNOE3SMZet0aBz3c+exYnmh3uEuLcBzC3rbbu02/BDOh5Sjqm7LLzINPB6vLq5Ed1rtJB3U9RswueQjllPszMuXIzl/sJ9WXoNzlTt9f/lFmr+c8UaP/FuG8pzppaCCDFN0dNfeJ2W5vwlmAnKp572z6SJ/aJVsEWFShka0fKIUs6l1WrXYdAwaBhTZRty8TdLgkH8jCffFOV0mp4/5n0q7ROd4GcngsuBSAXDnwOcdtqILsxSrDJssNZgXXaqLnxsrc8JRuObscKeaAOKSse8vVQixd3YDuQZtAOmBNwZm/bEgb+WEqEN5bGWtC72fTUkk05iy6Rh6dvbes1Hdl6uTe4k7NCbTYAuU8bq0c7EvNE8jQuQt7zRvjVxUTC730wBhV+RH5I3P3a0rhTBU+S/t//ye8NsNtEzwkZnTmupP9bo+c2W9kYfOPkmMrqfy4EB1AZhCkqR2NcXfwlQbj3oN1LMGSYpK4oVgn0ZaIrcTshvL8HbX+/cr1PlKl8dQE61LZZqmALu+JHbDYbnWxf5tH6Q
DKIM-Signature: a=rsa-sha256; bh=7cm9pIzhnwOwO6HaIfcO7ag1HjxCg873CDEbg0MM1HE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780468275; v=1;
 b=KIxdCBsckYKk3TSzofnIkjfPgcGCfOwPdQuNqGaRSIj2UnZXG3FM984AcOkP8+IKZSf/qL4L
 IqBIFfn9ILAGB5ty/GpGqEHwtqYtxk+EZ8NdtpAEJY3wSle+xCLWfswpDut9IGydGqD573jc7Ii
 rcvXWqX7fQSbi/PNr/AZbHv0QXX/MVo2rCfwKPzBD9jmNMRQ1ibpY3zbNoYVxtZcMJw9NvTHqjL
 ggJpIOl7E07hWsrax/H4aXSLBDa/nqVXCTpdjpyeuDYWvIvfQkeRfpyqjLCD31PiMaC0BoAXsJR
 LXhevTvKNEBOZaH+aKJVdVrk92rrLL4iGr3sO+rR4qT/w==
Received-SPF: pass client-ip=51.210.91.52; envelope-from=clg@kaod.org;
 helo=smtpout3.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 6/3/26 06:00, Jamin Lin wrote:
> This series extends the AST1040 SoC model by adding support for several
> peripherals that are compatible with existing AST2700 controller models.
> 
> The AST1040 shares a number of peripheral IP blocks with the AST2700,
> allowing the existing QEMU models to be reused with minimal changes.
> This series adds support for ADC, PECI, GPIO, SGPIO, I2C, and watchdog
> controllers, and updates the AST1040 EVB machine to instantiate onboard
> I2C devices for validation.
> 
> For I2C support, a new AST1040 I2C type is introduced. The model
> inherits the AST2700 I2C architecture, including DMA support and
> 64-bit DMA address registers, while constraining DMA accesses to the
> 16 MiB HyperRAM address space available on AST1040.
> 
> Depends on:
>    https://github.com/legoater/qemu.git (branch: aspeed-next)
> 
> v1:
>    1. Support ADC, GPIO, SGPIO, I2C and PECI
> 
> v2:
>    1. Address review feedback.
>    2. Fix issues reported during review.
>    3. Update i2c bus number to 14.
> 
> Jamin Lin (10):
>    hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to unify DMA address
>      handling
>    hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size and adjust offset
>    hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
>    hw/arm/aspeed_ast1040: Introduce PECI support
>    hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller model
>    hw/arm/aspeed_ast1040: Add SGPIO controller support
>    hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
>    hw/arm/aspeed_ast1040: Introduce I2C support
>    hw/arm/aspeed_ast1040_evb: Introduce onboard I2C device
>    hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models
> 
>   include/hw/i2c/aspeed_i2c.h |   8 ++-
>   hw/arm/aspeed_ast1040.c     |  97 ++++++++++++++++++++++++++++-----
>   hw/arm/aspeed_ast1040_evb.c |  15 ++++++
>   hw/i2c/aspeed_i2c.c         | 103 ++++++++++++++++++++++++------------
>   4 files changed, 173 insertions(+), 50 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


