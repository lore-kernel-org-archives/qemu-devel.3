Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5785EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVq5Y-0003Hp-PI; Mon, 22 Jul 2024 06:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVq5R-0003Gb-P8; Mon, 22 Jul 2024 06:16:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVq5O-00019y-Dr; Mon, 22 Jul 2024 06:16:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B04A4E6005;
 Mon, 22 Jul 2024 12:16:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id EKYYOxSr7o4O; Mon, 22 Jul 2024 12:16:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 12C3E4E6000; Mon, 22 Jul 2024 12:16:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0FC91746E3B;
 Mon, 22 Jul 2024 12:16:01 +0200 (CEST)
Date: Mon, 22 Jul 2024 12:16:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Andrew Randrianasulu <randrianasulu@gmail.com>, 
 Amit Singh Tomar <amit.tomar@freescale.com>
Subject: Re: [PATCH] hw/i2c/mpc_i2c.c: Fix mmio region size
In-Reply-To: <8ab5cfc4-3360-4b2e-9679-8566aea9b890@linaro.org>
Message-ID: <5ccba9c4-50ec-7d55-4d34-14a925662563@eik.bme.hu>
References: <20240721225506.B32704E6039@zero.eik.bme.hu>
 <8ab5cfc4-3360-4b2e-9679-8566aea9b890@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-97805229-1721643361=:44083"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-97805229-1721643361=:44083
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 22 Jul 2024, Philippe Mathieu-Daudé wrote:
> +Amit & Andrew
>
> On 22/7/24 00:55, BALATON Zoltan wrote:
>> The last register of this device is at offset 0x14 occupying 8 bits so
>> to cover it the mmio region needs to be 0x15 bytes long. Also correct
>> the name of the field storing this register value to match the
>> register name.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/i2c/mpc_i2c.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>
>
>> @@ -329,7 +329,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error 
>> **errp)
>>       MPCI2CState  *i2c = MPC_I2C(dev);
>>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
>>       memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
>> -                          "mpc-i2c", 0x14);
>> +                          "mpc-i2c", 0x15);
>
> Personally I'm not a big fan of non-pow2 regions, so I'd have picked
> 0x20 or 0x100 where the 2nd i2c controller starts. Amit, what do you

Coverung unused areas isn't a good idea because that would omit invalid 
read/write warnings when those are enabled so it's harder to catch 
unimplemented registers that way. So 0x100 is definitely overkill, 0x20 
could be acceptable as other regs are also covering some unused area after 
them but is also unnecessary when we can cover exactly the area where the 
register is.

Regards,
BALATON Zoltan

> think?
>
> Anyhow,
>
> Fixes: 7abb479c7a ("PPC: E500: Add FSL I2C controller")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
>>       i2c->bus = i2c_init_bus(dev, "i2c");
>>   }
>
>
--3866299591-97805229-1721643361=:44083--

