Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFCBC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2SPW-0007wz-2J; Wed, 09 Apr 2025 06:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1y2v=W3=kaod.org=clg@ozlabs.org>)
 id 1u2SPQ-0007te-E8; Wed, 09 Apr 2025 06:11:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1y2v=W3=kaod.org=clg@ozlabs.org>)
 id 1u2SPN-0000Bo-On; Wed, 09 Apr 2025 06:11:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZXdyg1tMNz4x1w;
 Wed,  9 Apr 2025 20:11:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZXdyb4vW8z4wby;
 Wed,  9 Apr 2025 20:11:35 +1000 (AEST)
Message-ID: <7512f3d5-d90e-449e-ab0c-4e82d32eb361@kaod.org>
Date: Wed, 9 Apr 2025 12:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250408082504.3060742-1-jamin_lin@aspeedtech.com>
 <SI2PR06MB50412DDB7CEE6844C1E5B953FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB50412DDB7CEE6844C1E5B953FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1y2v=W3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On 4/9/25 11:10, Jamin Lin wrote:
> Hi Cedric,
> 
> After discussing with the I2C hardware designers, we confirmed that the I2c design in AST2600 and AST2700 A1 is the same.
> The datasheet will be updated accordingly for AST2700.
> 
> However, please note that bit 15 and bit 31 are not available on AST2700 A0 and FW do not set either bit 15 and bit 31.
> AST2700 A0 was an engineering sample version. Given this, I plan to resend the v3 patch with AST2700 A0 explicitly marked as unsupported.

Are you going to introduce an I2C property to distinguish the
A0 implementation for the A1 ?

> I prefer not to introduce workarounds specifically for AST2700 A0, as it is not a production-grade silicon.

We can deprecate the AST2700 A0 machine too, See 56a37eda93ed,
and change the ast2700-evb machine alias.

> I will resend the v3 patch with the same content as v1, since the only issue in v1 was a functional test failure on AST2700 A0.
> Apologies for the inconvenience, and thank you for your understanding.

That's ok. Nothing is merged. Let's get it right first.

Thanks,

C.



> 
> Thanks-Jamin
> 
> ************* Email Confidentiality Notice ********************
> 免責聲明:
> 本信件(或其附件)可能包含機密資訊，並受法律保護。如 台端非指定之收件者，請以電子郵件通知本電子郵件之發送者, 並請立即刪除本電子郵件及其附件和銷毀所有複印件。謝謝您的合作!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
> 
>> -----Original Message-----
>> From: Jamin Lin <jamin_lin@aspeedtech.com>
>> Sent: Tuesday, April 8, 2025 4:25 PM
>> To: Cédric Le Goater <clg@kaod.org>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Andrew Jeffery <andrew@codeconstruct.com.au>;
>> Joel Stanley <joel@jms.id.au>; open list:ASPEED BMCs
>> <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
>> <troy_lee@aspeedtech.com>
>> Subject: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
>> I2CM_DMA_TX/RX_ADDR set first
>>
>> In the previous design, the I2C model would update I2CC_DMA_LEN (0x54)
>> based on the value of I2CM_DMA_LEN (0x1C) when the firmware set either
>> I2CM_DMA_TX_ADDR
>> (0x30) or I2CM_DMA_RX_ADDR (0x34). However, this only worked correctly if
>> the firmware set I2CM_DMA_LEN before setting I2CM_DMA_TX_ADDR or
>> I2CM_DMA_RX_ADDR.
>>
>> If the firmware instead set I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR
>> before setting I2CM_DMA_LEN, the value written to I2CC_DMA_LEN would be
>> incorrect.
>>
>> Ideally, this issue should be resolved by updating the model to set
>> I2CC_DMA_LEN (0x54) when the firmware writes to the I2CM_DMA_LEN
>> (0x1C) register, instead of when it writes to I2CM_DMA_TX_ADDR (0x30) or
>> I2CM_DMA_RX_ADDR (0x34).
>>
>> Originally, the design of I2CM_DMA_LEN (0x1C) included buffer length
>> write-enable bits for the current command:
>> Bit 31 enabled the RX buffer length update Bit 15 enabled the TX buffer length
>> update
>>
>> In other words, when the firmware set either bit 31 or bit 15, the I2C model
>> could safely update I2CC_DMA_LEN (0x54) with the value in I2CM_DMA_LEN
>> (0x1C).
>>
>> However, starting with the AST2700, the design of the I2CM_DMA_LEN (0x1C)
>> register was changed. The write-enable bits (bit 31 and bit 15) were removed,
>> meaning there is no longer an explicit indication of whether the firmware
>> intends to update the TX or RX length.
>>
>> As a result, on AST2700 and newer SoCs, the model cannot reliably determine
>> whether a write to I2CM_DMA_LEN was meant for TX or RX. This ambiguity is
>> especially problematic when the value written is 0, which actually corresponds
>> to a DMA length of 1.
>>
>> To ensure consistent behavior across all SoCs, the model now updates
>> I2CC_DMA_LEN when I2CM_CMD (0x18) is written, as this is the final
>> command that initiates a TX or RX transfer and reflects the firmware’s intent
>> more clearly.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> Fixes: ba2cccd (aspeed: i2c: Add new mode support)
>> ---
>>   hw/i2c/aspeed_i2c.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
>> a8fbb9f44a..c659099e9a 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -634,6 +634,20 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus
>> *bus, hwaddr offset,
>>               break;
>>           }
>>
>> +        /* Handle DMA length */
>> +        if (SHARED_FIELD_EX32(value, TX_DMA_EN) &&
>> +            SHARED_FIELD_EX32(value, M_TX_CMD)) {
>> +            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
>> +
>> I2CM_DMA_LEN,
>> +
>> TX_BUF_LEN) + 1;
>> +        }
>> +        if (SHARED_FIELD_EX32(value, RX_DMA_EN) &&
>> +            SHARED_FIELD_EX32(value, M_RX_CMD)) {
>> +            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
>> +
>> I2CM_DMA_LEN,
>> +
>> RX_BUF_LEN) + 1;
>> +        }
>> +
>>           if (bus->regs[R_I2CM_INTR_STS] & 0xffff0000) {
>>               qemu_log_mask(LOG_UNIMP, "%s: Packet mode is not
>> implemented\n",
>>                             __func__);
>> @@ -656,8 +670,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus
>> *bus, hwaddr offset,
>>           bus->dma_dram_offset =
>>               deposit64(bus->dma_dram_offset, 0, 32,
>>                         FIELD_EX32(value, I2CM_DMA_TX_ADDR,
>> ADDR));
>> -        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
>> I2CM_DMA_LEN,
>> -                                                     TX_BUF_LEN)
>> + 1;
>>           break;
>>       case A_I2CM_DMA_RX_ADDR:
>>           bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value,
>> I2CM_DMA_RX_ADDR, @@ -665,8 +677,6 @@ static void
>> aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>>           bus->dma_dram_offset =
>>               deposit64(bus->dma_dram_offset, 0, 32,
>>                         FIELD_EX32(value, I2CM_DMA_RX_ADDR,
>> ADDR));
>> -        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
>> I2CM_DMA_LEN,
>> -                                                     RX_BUF_LEN)
>> + 1;
>>           break;
>>       case A_I2CM_DMA_LEN:
>>           w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
>> --
>> 2.43.0
> 


