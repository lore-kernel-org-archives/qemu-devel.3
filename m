Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1566EC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siYDD-0006UE-IM; Mon, 26 Aug 2024 07:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siYD9-0006Pp-2Z; Mon, 26 Aug 2024 07:48:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org>)
 id 1siYD1-0007Pb-CY; Mon, 26 Aug 2024 07:48:38 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wsppg6DmLz4x3J;
 Mon, 26 Aug 2024 21:48:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wsppb4Hfzz4wnt;
 Mon, 26 Aug 2024 21:48:23 +1000 (AEST)
Message-ID: <62fad646-c132-4de3-8e57-aaa5cb23cc2f@kaod.org>
Date: Mon, 26 Aug 2024 13:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
 <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
 <SI2PR06MB5041E3D271FB5839B12E76D4FCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c7d00701-cada-4ed8-856b-85249aa1ac0b@kaod.org>
 <SI2PR06MB5041D50CAC61711661F4B56FFCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041D50CAC61711661F4B56FFCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7wMH=PZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

Hello Jamin,

On 7/26/24 08:00, Jamin Lin wrote:
> Hi Cedric,

I will looked at v2. Sorry for the late reply, I was on PTO.

Thanks,

C.

  


>> Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
>> memory region of I2C bus
>>
>> On 7/18/24 11:44, Jamin Lin wrote:
>>> Hi Cedric,
>>>
>>>> Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous
>>>> register memory region of I2C bus
>>>>
>>>> On 7/18/24 08:49, Jamin Lin wrote:
>>>>> It only support continuous register memory region for all I2C bus.
>>>>> However, the register address of all I2c bus are discontinuous for
>>>>> AST2700.
>>>>>
>>>>> Ex: the register address of I2C bus for ast2700 as following.
>>>>> 0x100 - 0x17F: Device 0
>>>>> 0x200 - 0x27F: Device 1
>>>>> 0x300 - 0x37F: Device 2
>>>>> 0x400 - 0x47F: Device 3
>>>>> 0x500 - 0x57F: Device 4
>>>>> 0x600 - 0x67F: Device 5
>>>>> 0x700 - 0x77F: Device 6
>>>>> 0x800 - 0x87F: Device 7
>>>>> 0x900 - 0x97F: Device 8
>>>>> 0xA00 - 0xA7F: Device 9
>>>>> 0xB00 - 0xB7F: Device 10
>>>>> 0xC00 - 0xC7F: Device 11
>>>>> 0xD00 - 0xD7F: Device 12
>>>>> 0xE00 - 0xE7F: Device 13
>>>>> 0xF00 – 0xF7F: Device 14
>>>>> 0x1000 – 0x107F: Device 15
>>>>>
>>>>> Introduce a new class attribute to make user set each I2C bus gap size.
>>>>> Update formula to create all I2C bus register memory regions.
>>>>
>>>> I don't think this is necessary to model. Could we simply increase
>>>> tge register MMIO size for the AST2700 bus model and rely on the
>>>> memops to catch invalid register offsets ?
>>>>
>>> Thanks for your review and suggestion.
>>>
>>> Sorry, I am not very clearly understand your comments.
>>> Could you please describe it more detail?
>>> Thanks-Jamin
>>
>> I don't think you need to introduce a gap size class attribute.
>>
>> Setting :
>>
>>       aic->reg_size = 0x100; /* size + gap */
>>
>> in aspeed_2700_i2c_class_init() should be enough.
>>
> Sorry reply you late.
> 
> The address space of I2C bus and pool buffer are as following
> 0x100 - 0x17F: device1_reg  0x1a0 - 0x1bf: device1_buf
> 0x200 - 0x27F: device2_reg  0x2a0 - 0x2bf:device2_buf
> 0x300 - 0x37F: device3_reg  0x3a0 -0x3bf: device3_buf
> 
> I tried to set the aic->reg_size 0x100 and aic->pool_size 0x100.
> And the memory regions of I2c bus became as following.
> 
> 0x100-0x1ff aspeed.i2c.bus.0  0x1a0-0x29f aspeed.i2c.bus.0.pool
> 0x200-0x2ff aspeed.i2c.bus.1  0x2a0-0x39f aspeed.i2c.bus.1.pool
> 0x300-0x3ff aspeed.i2c.bus.2  0x3a0-0x49f aspeed.i2c.bus.2.pool
> 
> 0000000014c0f000-0000000014c10fff (prio 0, i/o): aspeed.i2c
>      0000000014c0f100-0000000014c0f1ff (prio 0, i/o): aspeed.i2c.bus.0
>      0000000014c0f1a0-0000000014c0f29f (prio 0, i/o): aspeed.i2c.bus.0.pool
>      0000000014c0f200-0000000014c0f2ff (prio 0, i/o): aspeed.i2c.bus.1
>      0000000014c0f2a0-0000000014c0f39f (prio 0, i/o): aspeed.i2c.bus.1.pool
>      0000000014c0f300-0000000014c0f3ff (prio 0, i/o): aspeed.i2c.bus.2
>      0000000014c0f3a0-0000000014c0f49f (prio 0, i/o): aspeed.i2c.bus.2.pool
> 
> The memory region of aspeed.i2c.bus.0 (0x100-0x1ff) occupied aspeed.i2c.bus.0.pool address space(0x1a0-0x1bf).
> And the memory region of aspeed.i2c.bus.0.pool (0x1a0-0x29f) occupied aspeed.i2c.bus.1 address space(0x200-0x27F)
> That was why I created reg_gap_size and pool_gap_size to fix this issue.
> Do you have any suggestion?
> 
> Thanks-Jamin
> 
>> Thanks,
>>
>> C.
>>
> 
> ************* Email Confidentiality Notice ********************
> 免責聲明:
> 本信件(或其附件)可能包含機密資訊，並受法律保護。如 台端非指定之收件者，請以電子郵件通知本電子郵件之發送者, 並請立即刪除本電子郵件及其附件和銷毀所有複印件。謝謝您的合作!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.


