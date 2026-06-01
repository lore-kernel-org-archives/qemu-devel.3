Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30B1CD6E62
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTyLg-0007Te-W5; Mon, 01 Jun 2026 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wTyLe-0007RE-Lx
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:50:15 -0400
Received: from smtpout3.mo540.mail-out.ovh.net ([51.210.91.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wTyLb-0000tQ-SI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:50:14 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gTSMW3hccz4Qt6;
 Mon,  1 Jun 2026 08:49:59 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 08:49:59 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.95])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTSMW26DHz7th0; Mon,  1 Jun 2026 08:49:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 135512403043; Mon,  1 Jun 2026 08:49:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002992e5ba5-dd78-49b6-a67f-524cb20876b9,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a986d247-a6f8-497d-ab37-261d8a7b43df@kaod.org>
Date: Mon, 1 Jun 2026 10:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/24] hw/aspeed: Convert all Aspeed devices to
 DEFINE_TYPES() with inlined TypeInfo
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5167599097832254524
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE2KY71qfhg80v2imIbFbQWFoBudvcxBker6rpaKRwgbpHgoi/umRDTd63qh5OnqZ8TFHt6eBnX4tTg0ungWt9Q5mlnEM5iwwE1nYcTz75Z/FUNKXTMGHgEvVuPnMYWoiNNIe9CR49WWP0iHHvrlSO9h1mAB3DfbG39BdVKzmG6ms0By2/EQ0rtyBSqAOBcdjFOsVQIYdKQ+J7PPuMUB8KsLI03E9dqbVG3hlBqJ9N/oQU8Ijx3NgUM730PXMKBOP+EsBChrlajK5sDFngHUXugYUaI3GCsduAlg0rXGSl/6lW8tH0PcxT4Nt4ttAvpqJfOqZW/ES8iisytK6Z0BG9peYT3mka+pTp6iKCitdUqeDloK/mM0ltxGLelXnRXCGrtIx6a7Uzjc4nK1UzT4ogV/YQxsE3nzVhrXcgOImOsOSGKQsOxfTPhfQbr/5Tc7+BDw2hMxle21eeDqI5eh2z460IAYBQhx+Tbh2i7UDhrwG/T2fRXuOoWYYoKaxA9X7eBcuGsDvpDNNYOZCOJAn5CRIpbPacS+RWMydpPaANat8jTTV5eueogcLOC/XvdmynxOd7uUDbywWw2Tuoho6ocCmw1G5PDYjh8L8JjcWGxyJNtOoqNWxNvA7nPzHYbPF9C2Sr+jbKSwqfqmQ9qRxtRXl1+NBVCLo9yvqxMejryHw
DKIM-Signature: a=rsa-sha256; bh=a/rg0Hn8eSqVzC2dInq+MikNnd1lbrrDHIsXG2wjLsM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780303801; v=1;
 b=bJf4/QFLGo0C5NeLlzam7IbqBb4LM38tfp8XwJFzfm+VrMBQfya4M1X66gG0I/2tq4fIDDaT
 z3C88Lziwm0ULXhNgJvCRiDjf7bE1lCZbcF3WJwtpxFmK147aXNNFSj/IYNf6P0Poudbrhxv7uG
 Wg0oQFWy+YBJ9LBZugynE5HBAnZ/Me4tsAPpV3T9OTmTESIp23/BwPkoYWGFwWy0L0i7DatxDM8
 O2+pT9R4nJfHhEA7y+HOptVQ5kAuQKeuKmcM0d61xKynzB3hXBZbbRL6Z2ufKIsBbvehVBUVJ/j
 QvyXsW46wndZRm4R4wBQLWjX4C71LlCDgOHeoplUgSPfA==
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

On 6/1/26 04:50, Jamin Lin wrote:
> The QEMU community now prefers the DEFINE_TYPES() macro over the legacy
> type_register_static()/type_init() pattern for device type registration.
> DEFINE_TYPES() accepts an array of TypeInfo structs and registers them
> all in a single call, making the registration code more concise and
> consistent with modern QEMU coding style.
> 
> This series converts all Aspeed device models to use DEFINE_TYPES() and
> further inlines the individual static TypeInfo variable declarations
> directly into the types array, eliminating the need for standalone
> TypeInfo variables scattered throughout each file.
> 
> v1:
>    The changes are purely mechanical refactoring with no functional
>    difference. The 24 patches cover all Aspeed-related device models
>    across hw/adc, hw/arm, hw/fsi, hw/gpio, hw/i2c, hw/intc, hw/misc,
>    hw/net, hw/nvram, hw/pci-host, hw/rtc, hw/ssi, hw/timer and
>    hw/watchdog.
> 
> Jamin Lin (24):
>    hw/misc/aspeed_hace: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_lpc: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_pwm: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_sbc: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_scu: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc:aspeed_sli: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/misc/aspeed_xdma: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/adc/aspeed_adc: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/arm/aspeed_ast1700: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/gpio/aspeed_gpio: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/intc/aspeed_intc: convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/intc/aspeed_vic: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/rtc/aspeed_rtc: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/watchdog/wdt_aspeed: Convert to DEFINE_TYPES() with inlined
>      TypeInfo
>    hw/nvram/aspeed_otp: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/timer/aspeed_timer: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/fsi/aspeed_apb2opb: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/pci-host/aspeed_pcie: Convert to DEFINE_TYPES() with inlined
>      TypeInfo
>    hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/net/ftgmac100: Convert to DEFINE_TYPES() with inlined TypeInfo
>    hw/ssi/aspeed_smc: Convert to DEFINE_TYPES() with inlined TypeInfo
> 
>   hw/adc/aspeed_adc.c       |  95 +++++++---------
>   hw/arm/aspeed_ast1700.c   |  21 ++--
>   hw/fsi/aspeed_apb2opb.c   |  42 +++----
>   hw/gpio/aspeed_gpio.c     | 107 ++++++++----------
>   hw/gpio/aspeed_sgpio.c    |  37 +++----
>   hw/i2c/aspeed_i2c.c       | 113 ++++++++-----------
>   hw/intc/aspeed_intc.c     | 121 +++++++++-----------
>   hw/intc/aspeed_vic.c      |  19 ++--
>   hw/misc/aspeed_hace.c     |  81 ++++++--------
>   hw/misc/aspeed_lpc.c      |  21 ++--
>   hw/misc/aspeed_ltpi.c     |  19 ++--
>   hw/misc/aspeed_pwm.c      |  19 ++--
>   hw/misc/aspeed_sbc.c      |  46 ++++----
>   hw/misc/aspeed_scu.c      | 107 ++++++++----------
>   hw/misc/aspeed_sdmc.c     |  73 ++++++------
>   hw/misc/aspeed_sli.c      |  44 ++++----
>   hw/misc/aspeed_xdma.c     |  58 +++++-----
>   hw/net/ftgmac100.c        |  32 +++---
>   hw/nvram/aspeed_otp.c     |  19 ++--
>   hw/pci-host/aspeed_pcie.c |  94 +++++++---------
>   hw/rtc/aspeed_rtc.c       |  19 ++--
>   hw/ssi/aspeed_smc.c       | 228 ++++++++++++++++----------------------
>   hw/timer/aspeed_timer.c   |  83 ++++++--------
>   hw/watchdog/wdt_aspeed.c  |  93 +++++++---------
>   24 files changed, 678 insertions(+), 913 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


