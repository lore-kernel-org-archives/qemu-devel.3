Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C94ACCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bki-0003De-S2; Tue, 30 Sep 2025 10:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3bkd-0003D8-NA
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:54:47 -0400
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3bkY-0003JU-4B
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:54:47 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.64])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cbh0p4DjRz5xNg;
 Tue, 30 Sep 2025 14:54:34 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 16:54:34 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0060d5ddaa4-d5c1-4af5-ae42-aea4ff4b3094,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fc857b89-6b57-4200-a21a-a60d49ba000b@kaod.org>
Date: Tue, 30 Sep 2025 16:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add Supermicro X11 SPI machine type
To: Guenter Roeck <linux@roeck-us.net>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
References: <20221025165109.1226001-1-linux@roeck-us.net>
 <dbea5c97-071e-4d7c-a022-8cd5d9cf6171@kaod.org>
 <e6ad0500-29b5-422f-a584-34d33a5e9a0a@roeck-us.net>
 <e493e89d-d161-4c5b-abf2-053034aa82b4@kaod.org>
 <69494307-46ce-41b7-b8ee-c7e0aa462566@roeck-us.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <69494307-46ce-41b7-b8ee-c7e0aa462566@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 77e8748a-3344-4254-9ec4-ceb6b8e96f8a
X-Ovh-Tracer-Id: 17233586925771655974
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEmN7N/4l4txM6wQj8B6y0JBRJjgNDq/rZA3MQURQJuPpHVQ2kDEAD3k3wXZBew044fEpepoDE17M+WGAyGsCdQOezwKGEwpsgu2E0HugrUKf5ot5Oq/YWVfZluZyWnjC039lJ8h+9avB3M30lCkZpMwXjU+Xpip7uzelBYMKDP5tnFX3Djk4Gp/N+N0ivMK2Gqw1d3Ccw8i3ewFVc7zIhV5vqX6hRsXFvUoAaIt2OrjdPTXyrdWCq0/qkabzcPGm/OQPfEoFCQMyxjFlgIMRv/PWOUAKLLLcL7EeafQPU4f2qTYLkAdjw8jXt/HPMo6TwAPSXPVABP7J+Hm09oOqfcfijFinQW1S9dtzlFI4Pp1CC5kJCFs0AjHhHQ2PmUZqbeQn2g3d49cp1N4aN061RQERigAKr4/6FMbZGQ77GZOU5VN+bqQzW9ReUQUazosarvVKNk0GO9g8pk5Vk0hl9eo2xQt1/HILcohuwybqxpiFkQQlqfGWmdzSLOLGpuHnzIqrIqjr5USFASleiuenmZCLcEkzAdgj64J9z4neV6t3hkFF/e7gL/7UCw2BQ2PWj5VFiyXlsAne+ibknsiwpYNAevHghpdqQfckfuVgOGEY06M67B/h+m9I5gJdVzWfOCia8O7hOo2ENn1eX9gaUAsrucYIxDRHhF0HWy7iZWOQ
DKIM-Signature: a=rsa-sha256; bh=ZRwdp6fv7FjMDmJGxcXYBKy9U0sRrbqf/a4418i1g7w=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759244075; v=1;
 b=RjgI24uNy5jVAu+rC5T/I0QC25HamHzy7ADyH1WuWWrEF5BuxnTantcfFuh+NwQdyTAY5AJM
 hos6YpSceDDuG8i4ova6tDtuAPylUFaHV2QjVTobkAHGPttK4szaHasS1IkjkB52Dl8oxLe+drL
 cb0BoWovsOcIThK90MjUWyHzBdvh8gJ2I/RLiR6y4P4oPwIWF4wLDlrYmF/x8UE6jCVJILNV81b
 yGb84DimG5lXXmziNN5OVL+7aoQFqtBEEO1Z+AbRMseOK9Icigy+/ro7j0lu4MkaB4JHPV3oQYm
 +1qwQ/vokqtxnKoJV3FguicIscdvCfbXEgL31MpK6uiDA==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/30/25 16:35, Guenter Roeck wrote:
> On 9/30/25 04:13, Cédric Le Goater wrote:
>> On 9/30/25 12:08, Guenter Roeck wrote:
>>> On 9/29/25 22:55, Cédric Le Goater wrote:
>>>> On 10/25/22 18:51, Guenter Roeck wrote:
>>>>> supermicrox11-bmc is configured with ast2400-a1 SoC. This does not match
>>>>> the Supermicro documentation for X11 BMCs, and it does not match the
>>>>> devicetree file in the Linux kernel.
>>>>>
>>>>> As it turns out, some Supermicro X11 motherboards use AST2400 SoCs,
>>>>> while others use AST2500.
>>>>>
>>>>> Introduce new machine type supermicrox11-spi-bmc with AST2500 SoC
>>>>> to match the devicetree description in the Linux kernel. Hardware
>>>>> configuration details for this machine type are guesswork and taken
>>>>> from defaults as well as from the Linux kernel devicetree file.
>>>>>
>>>>> The new machine type was tested with aspeed-bmc-supermicro-x11spi.dts
>>>>> from the Linux kernel and with Linux versions 6.0.3 and 6.1-rc2.
>>>>> Linux booted successfully from initrd and from both SPI interfaces.
>>>>> Ethernet interfaces were confirmed to be operational.
>>>>>
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> Hello Guenter
>>>>
>>>> Would it be possible to contribute a functional test for this
>>>> machine ?
>>>>
>>>> Since this machine contributes little to the Aspeed models,
>>>> its value lies in the firmware it can run to exercise the
>>>> models. Without functional tests, I plan to schedule the
>>>> removal in the QEMU 10.2 cycle.
>>>>
>>>
>>> I use it to test the Linux kernel. Nor worth enough to spend more time on.
>>> Just drop it; I'll drop the respective test runs.
>> Can the FW be downloaded ?
>>
> 
> I have no idea. I only test the Linux kernel (more specifically, the Linux kernel
> drivers). 

OK. you boot with -kernel and a custom rootfs I guess. That's OK
for a functional test too.

> I already have to work around issues with the board that because the
> Linux kernel no longer supports the Macronix flash on that board as emulated
> by qemu. 

Ah. I am the kernel maintainer of the spi driver. So interested
to know more. Is that related to the fact that there are mx25l25635e
and mx25l25635f flash devices with the same device ID but different
SFDP tables ? One has 4B support, the other not.

> My patch to let me specify the flash model for aspeed boards in qemu
> was rejected. 

The aspeed machines have these options :

   fmc-model=<string>     - Change the FMC Flash model
   spi-model=<string>     - Change the SPI Flash model

Isn't that enough ?

> So I already have to carry a downstream qemu change to support it.

I don't see any change under :

    https://github.com/groeck/qemu/commits/v10.0.2-local/

May be you are mistaking with the Nuvoton boards ?

Upstream lacks your UHCI proposal. Unfortunately, I don't know any
reviewers who could help us merge.

> Obviously no one else uses/tests it, or they would have reported that problem.
> So you might as well drop it.

Since you are using it for kernel, I probably won't.
  
> The flash problem is also seen with ast2600-evb, making me wonder if that board
> could/should be dropped as well.
the ast2600 EVB has numerous firmware images. See

   https://github.com/AspeedTech-BMC/openbmc/releases/

It's heavily used and none reported an issue.

buildroot has a defconfig for it too.

Thanks,

C.



