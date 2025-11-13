Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E7CD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVDI-0006g2-9L; Thu, 13 Nov 2025 06:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJVDC-0006bN-Nq
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:10:00 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vJVD8-0006eU-3r
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:09:57 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.73])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d6cx56W0dz5w7W;
 Thu, 13 Nov 2025 11:09:45 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 13 Nov
 2025 12:09:41 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0040c1c3a20-2a90-49a1-9952-c70b6ca2bddb,
 4476756531275CA3349E6B909B2DFE5C65DEBF14) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2f1397fe-3df3-4554-ae24-8c5e0ba89119@kaod.org>
Date: Thu, 13 Nov 2025 12:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/nvram: Add a new auxiliary function to init
 at24c eeprom
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>, Hao Wu
 <wuhaotsh@google.com>
References: <20251113-quanta-q71l-eeproms-v2-0-e72451b974b0@google.com>
 <20251113-quanta-q71l-eeproms-v2-1-e72451b974b0@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251113-quanta-q71l-eeproms-v2-1-e72451b974b0@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 4cb59560-feb8-44f3-81c6-b6a55e29f6e2
X-Ovh-Tracer-Id: 13580886153342978994
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGNX6EKlNqT32O3ZjTi/0lS8RAKjShRnZovoojPnVFtT3IQFBw1945DSc6DlGtEbvLqNyR+Z2dZtL/hH9aD+QlCvhWL5x019IeANISzErLjAV7p206oYzfex1WiKYdOKJmOkz72+E6ccJ8K1/oJNCbwXhVDDbjxNvbXGib0fuM2NzqcQ7NztW0znRkSHXs4fuFHuFOFV2bRipex4FUed5I3AP1ZF+3bHbbcnlF+WLlI4YQHtwdvBDuPfWgwgfISj1OZJ1Z9bKRLOAKhPIcGCEAgcDqFrSQdhr2/piUrZ9vS5AwGlWeZes1R8qYvovMHqBBY2IOkcjK4a8fJEopezSvjB8cPLopQJLqJdfDejdcDitQmydLC3neYouxoL7authi973ELl28DwG9wB8RpbFS/07MLXoc5I27gFSGhVCOJS0l0bYpjP1V1vy4EIlcTXf59Nh24ybtiJgcsQ7NjCFAHrw97muRzjw6pA0BIIFkOM0CEjn3GOd+uBXUFTP82NElnZpmCguGkpKQF6MXdzbaf9eA7ViHD7rYYkyaKKEN1nrB8LY/0t4OlC6q8aogYY3sWK9drQqftvFde23UDHgjT6j+oqepiu4HtKpwVPu8sXMFr4DzQGWehbRTSD2VnnvZ6jdfLSiKLcVpSAk21ET6VIhoWvnYnFJtxT7IQ5Bxu+A
DKIM-Signature: a=rsa-sha256; bh=40CnKT+CERV0oCAK4RQDRYi+U6pxISEGfQFTFjCIQlc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1763032188; v=1;
 b=id91oYO3DQGGjICv3ox/egdY0hwV7HAzE016oNJ3qXk8tjQdl+IRBHk1/YDmjvHPLv6asKPq
 GSashd+vkHBLUr0RG+xQ7CFcihOIsACuQ0IADvFg8dSj8UrBTAGdvaF8nIVr8dSi3yvy9yeyFE0
 3RiFg+UUItvBcXy2Cduzy7BgLPc2n7LtD2HQpb52LgtqKQI8XFC9XLBmbca2wDqJoIjKSFvhQOq
 OKpt6L80bekOZBbZ8qx4u0HaWyj8A7pz0GLlw4NgwYSJ0gXZD0p/wsmC7jKqOybIvcX/uMYfdXi
 cRR3voNjCKVe0TusGDhQLAc1koKJGLhLX+Mi0cjMrCUvg==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Yubin,

On 11/13/25 01:43, Yubin Zou wrote:
> From: Hao Wu <wuhaotsh@google.com>
> 
> In NPCM7xx boards, at24c eeproms are backed by drives. 

Are they ? I don't see any drive usage apart from the flash devices.

> However,
> these drives use unit number as unique identifier. So if we
> specify two drives with the same unit number, error will occured:
> `Device with id 'none85' exists`.

Yes. The drive interface is very poor when it comes to the user
interface. Something to avoid.

A better alternative is to define the devices on the command line
using a blockdev, something like :

   -blockdev node-name=eprom0,driver=file,filename=/path/to/eprom0-contents \
   -device at24c-eeprom,bus=aspeed.i2c.bus.1,address=0x54,id=foobar,drive=eprom0

Please try that instead. Or use at24c_eeprom_init_rom() like the
other machines.

A functional test of the quanta-q71l board would be appreciated.

Thanks,

C.



> Instead of using i2c address as unit number, we now assign unique
> unit numbers for each eeproms in each board. This avoids conflict
> in providing multiple eeprom contents with the same address.
> 
> We add an auxiliary function in the at24c eeprom module for this.
> This allows it to easily add at24c eeprom to non-nuvoton boards
> like aspeed as well.
> 
> Change-Id: I2f056cc0507d39164335a03bc18b5c94015b4b11
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/nvram/eeprom_at24c.c         | 17 +++++++++++++++++
>   include/hw/nvram/eeprom_at24c.h |  4 ++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 82ea97e552a15c8bcd38e38939b53545b01ad273..8542ca2b037d6e896c7b394e7ff4b6ec27297ad7 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -17,6 +17,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
>   #include "system/block-backend.h"
> +#include "system/blockdev.h"
>   #include "qom/object.h"
>   
>   /* #define DEBUG_AT24C */
> @@ -264,3 +265,19 @@ static void at24c_eeprom_register(void)
>   }
>   
>   type_init(at24c_eeprom_register)
> +
> +void at24c_eeprom_init_one(I2CBus *i2c_bus, int bus, uint8_t addr,
> +                           uint32_t rsize, int unit_number)
> +{
> +    I2CSlave *i2c_dev = i2c_slave_new("at24c-eeprom", addr);
> +    DeviceState *dev = DEVICE(i2c_dev);
> +    BlockInterfaceType type = IF_NONE;
> +    DriveInfo *dinfo;
> +
> +    dinfo = drive_get(type, bus, unit_number);
> +    if (dinfo) {
> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
> +    }

> +    qdev_prop_set_uint32(dev, "rom-size", rsize);> +    i2c_slave_realize_and_unref(i2c_dev, i2c_bus, &error_abort);
> +}
> diff --git a/include/hw/nvram/eeprom_at24c.h b/include/hw/nvram/eeprom_at24c.h
> index acb9857b2adddd1fe5a924652f6ebae13b674b66..fdac7c1c022f9f73307bb3ecf761caa732e999bc 100644
> --- a/include/hw/nvram/eeprom_at24c.h
> +++ b/include/hw/nvram/eeprom_at24c.h
> @@ -36,4 +36,8 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size);
>   I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
>                                   const uint8_t *init_rom, uint32_t init_rom_size);
>   
> +/* Init one at24c eeprom device */
> +void at24c_eeprom_init_one(I2CBus *i2c_bus, int bus, uint8_t addr,
> +                           uint32_t rsize, int unit_number);
> +
>   #endif
> 


