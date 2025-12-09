Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF70D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStQB-0006Ow-IL; Tue, 09 Dec 2025 03:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vStQ7-0006OV-RZ
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:50:08 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vStQ4-00027h-Rd
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:50:06 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.30])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dQXb960DZz62rc;
 Tue,  9 Dec 2025 08:49:25 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Dec
 2025 09:49:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003da5cfa43-2430-43e2-89c3-b7e09e364397,
 913B1D19E2E265D49699B36B6A33E6F0AA87D788) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1891c6bf-9dfd-429b-9fdd-130233a01d96@kaod.org>
Date: Tue, 9 Dec 2025 09:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
To: Nabih Estefan <nabihestefan@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-18-kane_chen@aspeedtech.com>
 <CA+QoejXUfmJfuWSPndkuF=Dqu7QBJF7ACgH90Wmfshr4+3pDoA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CA+QoejXUfmJfuWSPndkuF=Dqu7QBJF7ACgH90Wmfshr4+3pDoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: dd3ea019-50cf-4250-824e-dd8173c95934
X-Ovh-Tracer-Id: 16321326527863688181
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGPdOzXh3hu3M+r+bxFL2cQyV8pSOGPHAtzuOuwvORaRojDRRlwhWuWkPbc4gQPAkMUHv2BT+jHZD+UvCAFAQ7ZjZB1xhfb7FUp8wU3uOQ0U/zSnCVOVtOAa6YR5W/GVLR3WwWrryCvH58jXpoj7vXn2Bj8rioFIur6S74Lfps5u3ueOiQl1w1YyVEXJjf1RbMQ7IuI57jdgDVYOlYVYBAmssf+PBJgXGS+ahYWyYB/DETOMrymD01TFN4OBKBI1NJa+DaXkth/65GYbxKVB4pEGhn1VwW7rCK2IbMnJgMEX22MJjEEbqaeDSa7dizk3MlLN+hIwcJvTFB96/WO+evya0opFjgLUNEZuHTMR2atuxYMUURH8xaSDWw6ybv/VnfWK9xFKhWa5LxUC4lJ+77OsJ7lOeoSoqCuNSTU2ov7xbdRS9Kiy7B18JxgJbUiPt5uKgPZqThIFRix0CqxjLqfY+PkFariAF9kyAnXiTudYjebn8B6I4JDFfS+mzxps1ewnYDg2rfcPL9hPFDPybOrxbaWud8QrrMcqMNl10Uxhtm6xQaQ6K1/mMnzpgMtx5iQjaYoSK/sNiNAZcJIt7Hiwr+CbEmHWgaQVDLWRKVp/+jau3mc4Nga3SZash9ryPXq4GJ3HUF51cuKmZTebxuA3TSjgn0g2+1gktzkhLx5MQ
DKIM-Signature: a=rsa-sha256; bh=mkEnxJR2CZAzn1z038kAmW3k26uqESjk7idDxFcFpRs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1765270178; v=1;
 b=lsbRqvGX0MOqvMzK3wdTuvfllmbGtNdZK3FGsq/+33B0MM1mUNh71N+fJBOK+rbbUTNHeKoV
 AWBQ5sR3EngJzGhkXdafv1ZeqoIHBa6MLEiyHcijNT4dXEQsRDtyU191exc/k7G8Sxit72HBcUN
 vF9svXz0Oi55Q6rg0RqAvoc0cm0oP+EAfjRHSGeCBGo45bTleF5tcH1egk634MQleezugfN1H21
 VsG5OeEvzVLBJljLowz1tPmMfO17rQzXbDTlkm6qPecsjETCFsueB/fP+52drZT0p8cJkdJC3+3
 WC/g2NzgUHtmSRqXPn7ycG+DSUf+Tu1QCVsfHH4xhE19w==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 19:21, Nabih Estefan wrote:
> On Sun, Dec 7, 2025 at 11:48 PM Kane Chen via <qemu-devel@nongnu.org> wrote:
>>
>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>> Connect the SGPIOM device to AST1700 model.
>>
>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>> ---
>>   include/hw/arm/aspeed_ast1700.h |  3 +++
>>   hw/arm/aspeed_ast1700.c         | 20 ++++++++++++++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
>> index 7292719dc2..490f2a3b05 100644
>> --- a/include/hw/arm/aspeed_ast1700.h
>> +++ b/include/hw/arm/aspeed_ast1700.h
>> @@ -12,6 +12,7 @@
>>   #include "hw/misc/aspeed_scu.h"
>>   #include "hw/adc/aspeed_adc.h"
>>   #include "hw/gpio/aspeed_gpio.h"
>> +#include "hw/gpio/aspeed_sgpio.h"
> 
> As far as I can tell this depends on Yubin Zou's SGPIO series (link below)?
> Does that mean the series looks good? Can you reply to the series
> itself if it is?
> 
>   https://lore.kernel.org//qemu-devel/20251106-aspeed-sgpio-v1-0-b026093716fa@google.com


Nabih, Kane, Jamin,

Could you please help review Yubin's series ?

Thanks,

C.


>>   #include "hw/i2c/aspeed_i2c.h"
>>   #include "hw/misc/aspeed_ltpi.h"
>>   #include "hw/misc/aspeed_pwm.h"
>> @@ -19,6 +20,7 @@
>>   #include "hw/watchdog/wdt_aspeed.h"
>>   #include "hw/char/serial-mm.h"
>>
>> +#define AST1700_SGPIO_NUM            2
>>   #define AST1700_WDT_NUM              9
>>
>>   #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
>> @@ -39,6 +41,7 @@ struct AspeedAST1700SoCState {
>>       AspeedADCState adc;
>>       AspeedSCUState scu;
>>       AspeedGPIOState gpio;
>> +    AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];
>>       AspeedI2CState i2c;
>>       AspeedPWMState pwm;
>>       AspeedWDTState wdt[AST1700_WDT_NUM];
>> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
>> index c9d7a97a80..e027ae02ad 100644
>> --- a/hw/arm/aspeed_ast1700.c
>> +++ b/hw/arm/aspeed_ast1700.c
>> @@ -23,6 +23,8 @@ enum {
>>       ASPEED_AST1700_DEV_ADC,
>>       ASPEED_AST1700_DEV_SCU,
>>       ASPEED_AST1700_DEV_GPIO,
>> +    ASPEED_AST1700_DEV_SGPIOM0,
>> +    ASPEED_AST1700_DEV_SGPIOM1,
>>       ASPEED_AST1700_DEV_I2C,
>>       ASPEED_AST1700_DEV_UART12,
>>       ASPEED_AST1700_DEV_LTPI_CTRL,
>> @@ -37,6 +39,8 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
>>       [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
>>       [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
>>       [ASPEED_AST1700_DEV_GPIO]      =  0x00C0B000,
>> +    [ASPEED_AST1700_DEV_SGPIOM0]   =  0x00C0C000,
>> +    [ASPEED_AST1700_DEV_SGPIOM1]   =  0x00C0D000,
>>       [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
>>       [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>> @@ -142,6 +146,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>>                           aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
>>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
>>
>> +    /* SGPIOM */
>> +    for (int i = 0; i < AST1700_SGPIO_NUM; i++) {
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
>> +            return;
>> +        }
>> +        memory_region_add_subregion(&s->iomem,
>> +                    aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SGPIOM0 + i],
>> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom[i]), 0));
>> +    }
>> +
>>       /* WDT */
>>       for (int i = 0; i < AST1700_WDT_NUM; i++) {
>>           AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
>> @@ -194,6 +208,12 @@ static void aspeed_ast1700_instance_init(Object *obj)
>>       object_initialize_child(obj, "ltpi-ctrl",
>>                               &s->ltpi, TYPE_ASPEED_LTPI);
>>
>> +    /* SGPIOM */
>> +    for (int i = 0; i < AST1700_SGPIO_NUM; i++) {
>> +        object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom[i],
>> +                                "aspeed.sgpio-ast2700");
>> +    }
>> +
>>       /* WDT */
>>       for (int i = 0; i < AST1700_WDT_NUM; i++) {
>>           object_initialize_child(obj, "ioexp-wdt[*]",
>> --
>> 2.43.0
>>
>>


