Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A8ECD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 05:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjvO-0006M5-FV; Tue, 26 May 2026 01:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wRjvM-0006LF-Pe
 for qemu-devel@nongnu.org; Tue, 26 May 2026 01:01:52 -0400
Received: from smtpout7.mo538.mail-out.ovh.net ([51.210.91.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wRjvK-0005t2-8k
 for qemu-devel@nongnu.org; Tue, 26 May 2026 01:01:52 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4gPgZx5ZCQz5xgH;
 Tue, 26 May 2026 05:01:45 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 26 May 2026 05:01:45 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.160])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gPgZx4NMwz1xpD; Tue, 26 May 2026 05:01:45 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 6A6E61B43B9D;
 Tue, 26 May 2026 05:01:43 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004c7398abd-cfd4-4579-a4aa-b0e1726d27d5,
 F49BC9865E6D06A1207BBF08B4ECD36E7EFD173C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2f690cae-dc55-48b5-86c2-16872c519a09@kaod.org>
Date: Tue, 26 May 2026 07:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 2970405432647461948
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEsoNkkBbiZPWLIvc7Zsf2jl+WS3OMhsKmDNMmPsFhyULXCDb+YlApiXPtuCZx1+UsqWIa8aIhaPsHswe8y9KIn6Q066R0v97tSK0f7imbFD5VYxkY07RIut/FDcNjPm2LJrAnG06BfITG0C3w4dVNbzqBqHqXbc9+q5Vo9sSp8XrSvzjSXuBwWEJnQCSF0yyQRYeZfHBBxhGMP+wih9GS/wWnc8jXhEOub70RiQ4/lKwIHHjNs5qYCo/q0M6NEiP/Nl4k63Wi443lwzf9UICp08wXOs2dmgTw0lI5xbnh2pmVI/ZJ4QD3dqFMqmKfv8vn1iEbOROg2dIqpD8iRNiawLItMHnlkTVaTP9Ty84Wh947iuu3HFsc+Rm4V0yNEDKdfGtiz42q8co6MwW8rXJaqNgapOQN8jypzGzUdBsj+znSlPxdfICOHFH/ijyQGFGiuHxx4CnXKkamXX8De43RFfyrMwpGrMITClJbm2D0YLwuXoqeeuWS3OeUzP9OG3m4EENSDA26jgfq4XUAt5ZtwJfbAT3tYixOdN6FG1EmNDITjNrtn0uMGqjzPhb6Hjiy/5pxYolYfKK0kHzqrBO8I2Z4r1QzfAXPnfJtOx4V4xcEBx36SjgTw2Z7BGvQBaiHlQYx7hwr1gEPseg3+biIGtEqbu59FYqHToPe8nw0ZYw
DKIM-Signature: a=rsa-sha256; bh=LBjpBavcTfY+1sunE4RLbNS9t9RvEqKYXL1D3V/Wc2M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779771707; v=1;
 b=nd7X8+9uHQus0X6LSkyJ/f8IF2+H0SUk3v01555LUs8V83jSF3vsGP0UeUYZdc1i8+W/8JNr
 WGAK/4hJPOMqjtLb2F8aheV2oN9vBjYFpoyeMNsYfijCNk77ZW6f7ULKWQjWzIfEVzhnLzNDMqs
 Qokd5v5ZcajGk6D/36+pc/JrPgxCZuT9xygRk4ihSMLDPtaEY1gQs5lHfykB1/1iJSY+K+CH6ia
 RYTBL9xjpdo2rKyYjWyGMosEv/F0LspKwo3cCziI24N3/tiM9FSfvby2cQ76uiA4mAV3SueMgLn
 qGpCNNSw3PppWzTYGWw3WG9uj2PkE3WJxKfTtVPTlEzig==
Received-SPF: pass client-ip=51.210.91.36; envelope-from=clg@kaod.org;
 helo=smtpout7.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/25/26 06:41, Kane Chen wrote:
> Hi,
> 
> This series converts Aspeed device drivers from the legacy reset
> callback registered via device_class_set_legacy_reset() to the
> Resettable interface by setting rc->phases.hold directly.
> 
> Best Regards,
> Kane
> ---
> 
> Kane-Chen-AS (23):
>    hw/misc/aspeed_pwm: convert to use Resettable interface
>    hw/misc/aspeed_peci: convert to use Resettable interface
>    hw/misc/aspeed_hace: convert to use Resettable interface
>    hw/misc/aspeed_sbc: convert to use Resettable interface
>    hw/misc/aspeed_xdma: convert to use Resettable interface
>    hw/misc/aspeed_lpc: convert to use Resettable interface
>    hw/misc/aspeed_sdmc: convert to use Resettable interface
>    hw/misc/aspeed_scu: convert to use Resettable interface
>    hw/misc/aspeed_ltpi: convert to use Resettable interface
>    hw/pci-host/aspeed_pcie: convert to use Resettable interface
>    hw/timer/aspeed_timer: convert to use Resettable interface
>    hw/gpio/aspeed_gpio: convert to use Resettable interface
>    hw/sd/aspeed_sdhci: convert to use Resettable interface
>    hw/ssi/aspeed_smc: convert to use Resettable interface
>    hw/intc/aspeed_vic: convert to use Resettable interface
>    hw/intc/aspeed_intc: convert to use Resettable interface
>    hw/i3c/aspeed_i3c: convert to use Resettable interface
>    hw/watchdog/wdt_aspeed: convert to use Resettable interface
>    hw/net/ftgmac100: convert to use Resettable interface
>    hw/fsi/aspeed_apb2opb: convert to use Resettable interface
>    hw/rtc/aspeed_rtc: convert to use Resettable interface
>    hw/adc/aspeed_adc: convert to use Resettable interface
>    hw/i2c/aspeed_i2c: convert to use Resettable interface
> 
>   hw/adc/aspeed_adc.c       |  7 ++++---
>   hw/fsi/aspeed_apb2opb.c   |  7 ++++---
>   hw/gpio/aspeed_gpio.c     |  7 ++++---
>   hw/i2c/aspeed_i2c.c       | 14 ++++++++------
>   hw/i3c/aspeed_i3c.c       |  7 ++++---
>   hw/intc/aspeed_intc.c     |  7 ++++---
>   hw/intc/aspeed_vic.c      |  7 ++++---
>   hw/misc/aspeed_hace.c     |  7 ++++---
>   hw/misc/aspeed_lpc.c      |  7 ++++---
>   hw/misc/aspeed_ltpi.c     |  7 ++++---
>   hw/misc/aspeed_peci.c     |  7 ++++---
>   hw/misc/aspeed_pwm.c      |  7 ++++---
>   hw/misc/aspeed_sbc.c      |  7 ++++---
>   hw/misc/aspeed_scu.c      | 39 ++++++++++++++++++++++-----------------
>   hw/misc/aspeed_sdmc.c     | 14 ++++++++------
>   hw/misc/aspeed_xdma.c     |  7 ++++---
>   hw/net/ftgmac100.c        | 14 ++++++++------
>   hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------
>   hw/rtc/aspeed_rtc.c       |  7 ++++---
>   hw/sd/aspeed_sdhci.c      |  7 ++++---
>   hw/ssi/aspeed_smc.c       |  7 ++++---
>   hw/timer/aspeed_timer.c   |  7 ++++---
>   hw/watchdog/wdt_aspeed.c  |  7 ++++---
>   23 files changed, 130 insertions(+), 98 deletions(-)
> 



Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


