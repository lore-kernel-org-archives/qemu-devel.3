Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36DCD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 05:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRkBF-0002Im-7f; Tue, 26 May 2026 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wRkBD-0002I5-K7; Tue, 26 May 2026 01:18:15 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wRkBB-0007CM-Ft; Tue, 26 May 2026 01:18:15 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gPgxt26tLz6KJS;
 Tue, 26 May 2026 05:18:10 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 26 May 2026 05:18:10 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.77])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gPgxt0MhRz5vZM;
 Tue, 26 May 2026 05:18:10 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 7DFA81B43B9E;
 Tue, 26 May 2026 05:18:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e23cb2f1-cd2c-4661-bcf1-1b592e22be8f,
 F49BC9865E6D06A1207BBF08B4ECD36E7EFD173C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ec384f92-fd55-40aa-a66f-7cf360576986@kaod.org>
Date: Tue, 26 May 2026 07:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
To: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
 <TYPPR06MB8206D1D6B283918E5FDC9172FC0A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <5207df68-1010-40af-a369-ac4b8a11e57c@kaod.org>
 <TYPPR06MB8206D1FF1AE00706FD371E82FC0B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206D1FF1AE00706FD371E82FC0B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3247658283480230972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF5AadH1/ql6L0i9NvTlBT1mUk5fhws0XpPMc1cDKFiDmPEiVXPZk5kpFTHM7dJqwpftImktuHrtcUmTTbgqu3a5KI1EsVC0vteOdG6cKLwUGc/GMxsrUh2lBIo1ut1IYVf9yFHjyrJh4UvJUDmO6mcPt8ts5H+aZtBDiUosUlYjpof9k4gWyBIYqQvvJfYLJzmstF7/WotTtvaI0H3Fx1jkgj5GyP3N2UHycW1MiCqursQUEwJaBGVfqJb3Rp4fBBoQz5rVD8YLxCmaNCIw51bUqGg+yBleOzVpOFQrLLWbi7cCSqKC2MUwPSn8C4Amid4vTeXSLaS7wbi6Ip8H9PCBb6goIk8vQEueMCIjg516ikJMXDswgFKq5FTlQ+NKO/Owa2rZu9kz3B1gbjzGgSpU5jvWQBBM3d3ef8/v5TL+xjm+62x7c2TVejWjKGC0OuknBqmfKb02zEygs6UDJSTucyKGttx/jX23BOkmSt1XGoSIgdYbeMgXrptc9S8lcey5GCIjyA4Yh36UDYU0PvzpX5lXcuii+mo1Z17I+8ohkTqv+6VYJ8y54Dr5jqwculC2yYtXantyiPrTe89hfqQ/j2qnQYimCc6hJsVaPhsMiB3IFKmNXdWi9nsWcg9UpvMUtaDmlxdwpi1iDm9cs/HP+ILGLlyHctqOmGnkkL5yw
DKIM-Signature: a=rsa-sha256; bh=fyg8jTw0zptPbJrFpvfrEgDztLVxpboPk4se57Azh6Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779772690; v=1;
 b=uHjA90vvawsQ41thjzC1Ygk4+UriIuqV49BjmPUqUa/f9ySzZsNqa2xzVcQ3Iewv0a28jfG5
 SYHzuDMg+Mb+EWaiiArMtapznUM7mjsaYv+92g7PPuYsazFFm6QIZ/TfYoMXRHbT9Z3uLGt3xbM
 7dnPi6JeRdzyZGlDQ9QcbenvEtXzXEXyTgDK0Y8ERecPt4g1gpy4ZbscwhP5fzretuOsBWxwJ0o
 W2EsoukRH+Zy+S1JKxCre5PgYjaMdtlygyV192UtbXE0+GT3Aj37puq3Uu7fE2c9vFqn27DqB4q
 +ztkx7vRWwsS9TJv0wuw4iEwhJ1DUhqdYPrcG7WVzKUcw==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/26/26 07:14, Jamin Lin wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Tuesday, May 26, 2026 1:13 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Kane Chen
>> <kane_chen@aspeedtech.com>; Peter Maydell <peter.maydell@linaro.org>;
>> Steven Lee <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>;
>> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
>> <joel@jms.id.au>; Alistair Francis <alistair@alistair23.me>; Ninad Palsule
>> <ninad@linux.ibm.com>; Joe Komlodi <komlodi@google.com>; Nabih Estefan
>> <nabihestefan@google.com>; Jason Wang <jasowang@redhat.com>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
>> Resettable interface
>>
>> Jamin,
>>
>> On 5/25/26 06:44, Jamin Lin wrote:
>>>> Subject: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
>>>> Resettable interface
>>>>
>>>> Hi,
>>>>
>>>> This series converts Aspeed device drivers from the legacy reset
>>>> callback registered via device_class_set_legacy_reset() to the
>>>> Resettable interface by setting rc->phases.hold directly.
>>>>
>>>> Best Regards,
>>>> Kane
>>>> ---
>>>>
>>>> Kane-Chen-AS (23):
>>>>     hw/misc/aspeed_pwm: convert to use Resettable interface
>>>>     hw/misc/aspeed_peci: convert to use Resettable interface
>>>>     hw/misc/aspeed_hace: convert to use Resettable interface
>>>>     hw/misc/aspeed_sbc: convert to use Resettable interface
>>>>     hw/misc/aspeed_xdma: convert to use Resettable interface
>>>>     hw/misc/aspeed_lpc: convert to use Resettable interface
>>>>     hw/misc/aspeed_sdmc: convert to use Resettable interface
>>>>     hw/misc/aspeed_scu: convert to use Resettable interface
>>>>     hw/misc/aspeed_ltpi: convert to use Resettable interface
>>>>     hw/pci-host/aspeed_pcie: convert to use Resettable interface
>>>>     hw/timer/aspeed_timer: convert to use Resettable interface
>>>>     hw/gpio/aspeed_gpio: convert to use Resettable interface
>>>>     hw/sd/aspeed_sdhci: convert to use Resettable interface
>>>>     hw/ssi/aspeed_smc: convert to use Resettable interface
>>>>     hw/intc/aspeed_vic: convert to use Resettable interface
>>>>     hw/intc/aspeed_intc: convert to use Resettable interface
>>>>     hw/i3c/aspeed_i3c: convert to use Resettable interface
>>>>     hw/watchdog/wdt_aspeed: convert to use Resettable interface
>>>>     hw/net/ftgmac100: convert to use Resettable interface
>>>>     hw/fsi/aspeed_apb2opb: convert to use Resettable interface
>>>>     hw/rtc/aspeed_rtc: convert to use Resettable interface
>>>>     hw/adc/aspeed_adc: convert to use Resettable interface
>>>>     hw/i2c/aspeed_i2c: convert to use Resettable interface
>>>>
>>>>    hw/adc/aspeed_adc.c       |  7 ++++---
>>>>    hw/fsi/aspeed_apb2opb.c   |  7 ++++---
>>>>    hw/gpio/aspeed_gpio.c     |  7 ++++---
>>>>    hw/i2c/aspeed_i2c.c       | 14 ++++++++------
>>>>    hw/i3c/aspeed_i3c.c       |  7 ++++---
>>>>    hw/intc/aspeed_intc.c     |  7 ++++---
>>>>    hw/intc/aspeed_vic.c      |  7 ++++---
>>>>    hw/misc/aspeed_hace.c     |  7 ++++---
>>>>    hw/misc/aspeed_lpc.c      |  7 ++++---
>>>>    hw/misc/aspeed_ltpi.c     |  7 ++++---
>>>>    hw/misc/aspeed_peci.c     |  7 ++++---
>>>>    hw/misc/aspeed_pwm.c      |  7 ++++---
>>>>    hw/misc/aspeed_sbc.c      |  7 ++++---
>>>>    hw/misc/aspeed_scu.c      | 39
>> ++++++++++++++++++++++-----------------
>>>>    hw/misc/aspeed_sdmc.c     | 14 ++++++++------
>>>>    hw/misc/aspeed_xdma.c     |  7 ++++---
>>>>    hw/net/ftgmac100.c        | 14 ++++++++------
>>>>    hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------
>>>>    hw/rtc/aspeed_rtc.c       |  7 ++++---
>>>>    hw/sd/aspeed_sdhci.c      |  7 ++++---
>>>>    hw/ssi/aspeed_smc.c       |  7 ++++---
>>>>    hw/timer/aspeed_timer.c   |  7 ++++---
>>>>    hw/watchdog/wdt_aspeed.c  |  7 ++++---
>>>>    23 files changed, 130 insertions(+), 98 deletions(-)
>>>>
>>>> --
>>>> 2.43.0
>>>
>>> This patch series
>>>
>>> Reviewed-by Jamin Lin <jamin_lin@aspeedtech.com>
>>>
>>> Thanks,
>>> Jamin
>>
>>
>> This email did not reach the mailing list for some reason. Could you resend
>> please ?
>>
> 
> Reviewed-by Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Thanks,
> Jamin
> 
>> Thanks,
>>
>> C.

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

C.

