Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958E5CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIh2-0005Qv-2y; Tue, 02 Jun 2026 02:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wUIgt-0005Pj-P2; Tue, 02 Jun 2026 02:33:32 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wUIgo-0004QX-A8; Tue, 02 Jun 2026 02:33:30 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gV1HB4h3nz40XV;
 Tue,  2 Jun 2026 06:33:10 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  2 Jun 2026 06:33:10 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.164])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gV1HB2g1rz5vMw;
 Tue,  2 Jun 2026 06:33:10 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5901712E305D;
 Tue,  2 Jun 2026 06:33:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004e841e1db-4ea9-4d05-bf0b-956d6e7da252,
 E738715FB773EF828F8B902CE3F45C10C1B236B1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5ce16ff8-4b29-4e83-925b-621c8ecda57c@kaod.org>
Date: Tue, 2 Jun 2026 08:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
 <20260602052827.1535299-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260602052827.1535299-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 8729664929436576779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGsdPbpdtqZW4s89iWVZu3Ln7hX5wgdMUkm8ksNwJNSyvQ9eP4CiyJPRR3HzmYHQrlWv5OW6708iwfqMB5mzlqAyBjH1INkxeT9H/75a0OaoI2txS5E9lUl4a9ukv+utztcGWqpbZh6ZpujD/WHavp+7DqobRB4v4o2Pkk2RL2VHNhDuD4JPydPRQWfW+8BF1lVEdGWcv4PxJKZVLR/QeQ5/JhQFAzUK3141cl6rbpnBcVrrcAX3nDl+m7hcfLsuNBdun1W3bMEYiwnw1/FThwDMElrsyEAVHIxHkdDW5ZlyKaN8O5s2QOZ0Eens4KVCtwoB8+vOvf/mQxOFVCR/RLdOtf9BYMLT/ei7ldHa1R/1Ww8dtkjxBpAjz8atxxmhZlRvv5b4s87LlorDG9wPiDzPaqw4P70F9T3T0+Sbbr/X+WEFNaWozvqbclcRC04WyF3HSRrWMN5MnZuqYeHeWK2KNhWkUqnNHuE9i0xHQng9ELLaQL0xBUtiol69KN9tG646p4Pp9KQnIDCmnM4DrHEhrXx+WISvnPVRl6h6VJbgKGdlUo/sDnPLwAtTWGmeOt+N483+s6nJAm3t75TWRAQ0aHvplu0MR4MD7vkSzWzm0BY/4M9E29BXoJ1sHMil4Y3t0U+o8tKxxogvtntWFUWdlJB5Z5Vh54j4ZqPC/zzQg
DKIM-Signature: a=rsa-sha256; bh=sFtXbp7HKk4oynXTLsBVa15XfgVJ/wIiwGfcjr2FMpY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780381992; v=1;
 b=DvdkPkIwQwp8QP910A/WYi4KuloVXQQGERkZt9Ntkc226WFrLm4uk55LEfyLPsLXnhbXXELx
 asnIhHwOe9bWX3E/kHLB5dwZ6TCsnt7wpnRwOqXCm8rU0FeLr3T1BR2eodbGRdO4l55BAU8DDAD
 xNL2Nhti0ZOaPIn4swodmGevIZBwdgTqWbT6i9vRGWGID9CY8AIWgOyCyEIynlqbURd7wvx+xfe
 JT0XfL3QGs3xAdAn2KbmAO9xTqW8PWjqwHPn2e4oLvUY40j+LUgWSSxTRGkAC63gaOWNwiNskyv
 TvJbFG52+0abeX4ulVRW8luWQbeM5vCxTbZXx+xNkC5mg==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
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

On 6/2/26 07:28, Jamin Lin wrote:
> Update the AST2700 I2C buffer mode configuration to match
> the latest firmware definition:
> - Increase buffer mode pool size from 0x20 to 0x40
> - Adjust buffer mode base offset to 0x1c0
> 
> Since the buffer mode region size changes, the migration state
> layout is also modified. Bump the VMState version numbers to
> prevent incompatible migration between old and new machine states.
> 
> Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST2700 support")
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i2c/aspeed_i2c.h |  2 +-
>   hw/i2c/aspeed_i2c.c         | 46 ++++++++++++++++++-------------------
>   2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 1fc229f699..b2e4d2fb9d 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -35,7 +35,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   
>   #define ASPEED_I2C_NR_BUSSES 16
>   #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
> -#define ASPEED_I2C_BUS_POOL_SIZE 0x20
> +#define ASPEED_I2C_BUS_POOL_SIZE 0x40
>   #define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)
>   
>   #define A_I2CD_M_STOP_CMD       BIT(5)
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index a6b44174f5..595b5fcf5c 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1132,8 +1132,8 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
>   
>   static const VMStateDescription aspeed_i2c_bus_vmstate = {
>       .name = TYPE_ASPEED_I2C,
> -    .version_id = 7,
> -    .minimum_version_id = 6,
> +    .version_id = 8,
> +    .minimum_version_id = 7,


I think min should be '8'. QEMU can not deserialise a v7 format
of the pool array. It reads exactly ASPEED_I2C_BUS_POOL_SIZE bytes
from the migration stream. But the size has changed.


>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
>           VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),
> @@ -1145,8 +1145,8 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
>   
>   static const VMStateDescription aspeed_i2c_vmstate = {
>       .name = TYPE_ASPEED_I2C,
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(intr_status, AspeedI2CState),
>           VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
> @@ -1250,37 +1250,37 @@ static void aspeed_i2c_instance_init(Object *obj)
>    * Address Definitions (AST2700)
>    *   0x000 ... 0x0FF: Global Register
>    *   0x100 ... 0x19F: Device 0
> - *   0x1A0 ... 0x1BF: Device 0 buffer
> + *   0x1C0 ... 0x1FF: Device 0 buffer
>    *   0x200 ... 0x29F: Device 1
> - *   0x2A0 ... 0x2BF: Device 1 buffer
> + *   0x2C0 ... 0x2FF: Device 1 buffer
>    *   0x300 ... 0x39F: Device 2
> - *   0x3A0 ... 0x3BF: Device 2 buffer
> + *   0x3C0 ... 0x3FF: Device 2 buffer
>    *   0x400 ... 0x49F: Device 3
> - *   0x4A0 ... 0x4BF: Device 3 buffer
> + *   0x4C0 ... 0x4FF: Device 3 buffer
>    *   0x500 ... 0x59F: Device 4
> - *   0x5A0 ... 0x5BF: Device 4 buffer
> + *   0x5C0 ... 0x5FF: Device 4 buffer
>    *   0x600 ... 0x69F: Device 5
> - *   0x6A0 ... 0x6BF: Device 5 buffer
> + *   0x6C0 ... 0x6FF: Device 5 buffer
>    *   0x700 ... 0x79F: Device 6
> - *   0x7A0 ... 0x7BF: Device 6 buffer
> + *   0x7C0 ... 0x7FF: Device 6 buffer
>    *   0x800 ... 0x89F: Device 7
> - *   0x8A0 ... 0x8BF: Device 7 buffer
> + *   0x8C0 ... 0x8FF: Device 7 buffer
>    *   0x900 ... 0x99F: Device 8
> - *   0x9A0 ... 0x9BF: Device 8 buffer
> + *   0x9C0 ... 0x9FF: Device 8 buffer
>    *   0xA00 ... 0xA9F: Device 9
> - *   0xAA0 ... 0xABF: Device 9 buffer
> + *   0xAC0 ... 0xAFF: Device 9 buffer
>    *   0xB00 ... 0xB9F: Device 10
> - *   0xBA0 ... 0xBBF: Device 10 buffer
> + *   0xBC0 ... 0xBFF: Device 10 buffer
>    *   0xC00 ... 0xC9F: Device 11
> - *   0xCA0 ... 0xCBF: Device 11 buffer
> + *   0xCC0 ... 0xCFF: Device 11 buffer
>    *   0xD00 ... 0xD9F: Device 12
> - *   0xDA0 ... 0xDBF: Device 12 buffer
> + *   0xDC0 ... 0xDFF: Device 12 buffer
>    *   0xE00 ... 0xE9F: Device 13
> - *   0xEA0 ... 0xEBF: Device 13 buffer
> + *   0xEC0 ... 0xEFF: Device 13 buffer
>    *   0xF00 ... 0xF9F: Device 14
> - *   0xFA0 ... 0xFBF: Device 14 buffer
> + *   0xFC0 ... 0xFFF: Device 14 buffer
>    *   0x1000 ... 0x109F: Device 15
> - *   0x10A0 ... 0x10BF: Device 15 buffer
> + *   0x10C0 ... 0x10BF: Device 15 buffer
>    */
>   static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>   {
> @@ -1666,9 +1666,9 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
>       aic->reg_gap_size = 0x60;
>       aic->gap = -1; /* no gap */
>       aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
> -    aic->pool_size = 0x20;
> -    aic->pool_gap_size = 0xe0;
> -    aic->pool_base = 0x1a0;
> +    aic->pool_size = 0x40;
> +    aic->pool_gap_size = 0xc0;
> +    aic->pool_base = 0x1c0;
>       aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
>       aic->has_dma = true;
>       aic->mem_size = 0x2000;


