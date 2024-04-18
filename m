Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB2C05052
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 08:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxNCp-0005w9-Fr; Thu, 18 Apr 2024 04:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=S08W=LX=kaod.org=clg@ozlabs.org>)
 id 1rxNCY-0005ul-8g; Thu, 18 Apr 2024 04:33:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=S08W=LX=kaod.org=clg@ozlabs.org>)
 id 1rxNCV-0000kW-DT; Thu, 18 Apr 2024 04:33:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VKrcx5s7fz4x1V;
 Thu, 18 Apr 2024 18:32:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKrct1cjdz4wyh;
 Thu, 18 Apr 2024 18:32:45 +1000 (AEST)
Message-ID: <a74efe19-83b0-4700-a1f3-d2f366f29be2@kaod.org>
Date: Thu, 18 Apr 2024 10:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/i2c: Fix checkpatch line over 80 chars warnings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
References: <20240416184722.28334-1-philmd@linaro.org>
 <20240416184722.28334-3-philmd@linaro.org>
 <4513c447-2ef3-4547-875b-5500067b44eb@kaod.org>
 <9722502e-ce18-49d4-932e-4ff777163763@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <9722502e-ce18-49d4-932e-4ff777163763@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=S08W=LX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 4/17/24 16:20, Philippe Mathieu-Daudé wrote:
> On 17/4/24 08:24, Cédric Le Goater wrote:
>> Hello,
>>
>> On 4/16/24 20:47, Philippe Mathieu-Daudé wrote:
>>> We are going to modify these lines, fix their style
>>> in order to avoid checkpatch.pl warnings:
>>>
>>>    WARNING: line over 80 characters
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/i2c/i2c.h            |  11 ++-
>>>   include/hw/nvram/eeprom_at24c.h |   6 +-
>>>   hw/arm/aspeed.c                 | 140 +++++++++++++++++++-------------
>>>   hw/nvram/eeprom_at24c.c         |   6 +-
>>>   4 files changed, 98 insertions(+), 65 deletions(-)
> 
> 
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>>> +                            "dps310", 0x76);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>>> +                            "max31785", 0x52);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>>> +                            "tmp423", 0x4c);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>>> +                            "tmp423", 0x4c);
>>>       /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
>>> -                     0x4a);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>>> +                            TYPE_TMP105, 0x4a);
>>>       /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>>>        * good enough */
>>> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
>>> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>>> +                            "ds1338", 0x32);
>>
>> If the definitions were on a single line, they would be more
>> readable IMHO. So I would do the opposit change ...
>>
>> An alternate solution could be to define an array of devices
>> at the machine class level, something like
>>    struct i2c_device [
>>            const char *type;
>>            uint8_t bus;
>>            uint8_t addr;
>>    } devices[] = { ... };
> 
> I agree this would be better, but this should be done separately
> of this series. For now I propose not modifying hw/arm/aspeed.c
> in this patch, and ignoring the checkpatch errors in the next
> patch. What do you think?

sure, np.

Thanks,

C.


