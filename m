Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A534C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuEK-0004Pd-P6; Wed, 01 Jul 2026 08:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1weuEE-0004Oc-LL; Wed, 01 Jul 2026 08:39:48 -0400
Received: from smtpout9.mo536.mail-out.ovh.net ([51.210.91.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1weuE5-0003kF-O9; Wed, 01 Jul 2026 08:39:46 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gr02W2cCzz82NJ;
 Wed,  1 Jul 2026 12:39:31 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Wed,  1 Jul 2026 12:39:31 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.1])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gr02V6GYvz7tJy; Wed,  1 Jul 2026 12:39:30 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 7D1D61923CE8; Wed,  1 Jul 2026 12:39:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00635fc6e4c-ea57-4709-8603-6d56815b390c,
 301A22583DD1BC3AA74069A6B587A2F51A576089) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <03dbf5a7-68c7-4cdd-895d-178088421f9b@kaod.org>
Date: Wed, 1 Jul 2026 14:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, Markus Armbruster <armbru@redhat.com>
References: <20260627-i2c-adc128d818-anacapa-v3-0-cfb94270a980@meta.com>
 <20260627-i2c-adc128d818-anacapa-v3-3-cfb94270a980@meta.com>
 <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 757449165447801901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEfCxVbzupYT+omBcuGo06y1nGPEiaGosYuK0SauiS/Z6tE4qzsLrxZGDXf2Gn9lttrfZY+t39XxRkE5pCIMwJkJW9NXPvHG9AfCGNX1iKMzljtKMO73UkAN60jgnFj6WHsj2TMouUH2ztYqsWqCbfRuHpgLuwSk40P2jf+PaBaZd9bz5/fYuu3SXxSDjhqgnksH9KuazrUmgfJMBrD9h1iL3rFdi9uRO6BkhJ7dY2BAis3YoYFYss8BRjfyc1hUTetBRRjppbIQ5WZbMS4ZKj6FcoUClwK7OoGsPkTjYVbWLvQWuJVZLgU9//oZWxJfijAVZJq0XMCkslLV6n2zZCLTLk9KnuRDUKKVnbpXk2t3TLBbt3jQVbtj/hez60KOee/TgSNdMKHrW6m/MjEJ0R2raj0ojou26ZNE8YyrPCEE9OqbZmRwC0Rnu6m9SiusFDDYh24ZH2xpZ8baOCJHkdfHpin6Zz3eM8LrvkLjZNRHWGYF3BQfvesI3roXgm+TF3di7dFXqA0edB1tRfMld5nNRdNs+L9sDEhznqYhKGC9R0q47HnjHPBSSIHchIKrhrzCMqQVv8DrdyOr3F3Du/Ra7L1qxxUIrCYUWsSmWWDfpnZjfxfjPZ1ccxI/4wwPtiA+w5SXFjKa7Q6G4urIxId10B6Nut3Mau7B62MqcR8rw
DKIM-Signature: a=rsa-sha256; bh=XQeueU0Fn1iUGsUpYmausRvWKjy4Z5Pqzpm6pQfrNPY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782909573; v=1;
 b=lwPuLB0/m/OzrpIhSJi0XkwsAjGcl+JuqtKsovMbJvV3CWSYF/SYVGNCLb5MLUEDBSu55X/0
 zS9WgqL+4t+w3c27Xz84JCx+h8H6Cov1Qd9sq1yVuXLgKFQagUoMI/UrbD4ZIgVVZbocbRh9Obh
 TP0nNEAEn22dlxhqxq/ruM+3hfWByV3osNgMGsg5OEkFXhZAoOYQUEVA1bcgo0qMVJDrFTSZVeT
 +owgAVquW+eflwa79ySFGGnldVuSRETHVGt+l7JPANRmMCaCHpW2aJDqj/J85v/Wg5qXE2oitoX
 aS1lPq3MjdczXb5ZRykMdvGIYBP2pUlbgKSEo9x25BWEw==
Received-SPF: pass client-ip=51.210.91.18; envelope-from=clg@kaod.org;
 helo=smtpout9.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/1/26 08:29, Philippe Mathieu-Daudé wrote:
> On 28/6/26 02:45, Emmanuel Blot wrote:
>> Slaves created with i2c_slave_create_simple() were left unparented and
>> showed up under /machine/unattached with no stable QOM path. Add each
>> slave as a QOM child of its bus, named after its I2C address, so it has
>> a deterministic and addressable QOM path.
> 
> +Markus
> 
> Personally I never liked the idea of having buses being parents
> of the devices attached to them, 

What was the problem ?

> but maybe it is simpler this way.

It is much simpler for functional tests when looking for board
devices which don't have ids.

patch 5 didn't reach the list, but here is an extract :

+    ADC128D818_QOM_PATH = \
+        "/machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x1f"
+    ADC128D818_MUX_CHANNEL = "/sys/bus/i2c/devices/8-0072/channel-0"

+        adc = self.ADC128D818_QOM_PATH
+        for ch0_mv, ch1_mv in ((108, 2000), (1280, 500)):
+            self.vm.cmd("qom-set", path=adc, property="ain0", value=ch0_mv)
+            self.vm.cmd("qom-set", path=adc, property="ain1", value=ch1_mv)
+            self.wait_adc128d818_value("in0_input", ch0_mv)
+            self.wait_adc128d818_value("in1_input", ch1_mv)

Thanks,

C.

> 
>> Signed-off-by: Emmanuel Blot <eblot@meta.com>
>> ---
>>   hw/i2c/core.c        | 3 +++
>>   include/hw/i2c/i2c.h | 7 +++++--
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index 54f6bdca88..0bbce45d48 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
>>   {
>>       I2CSlave *dev = i2c_slave_new(name, addr);
>> +    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
>> +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
>> +
>>       i2c_slave_realize_and_unref(dev, bus, &error_abort);
>>       return dev;
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index dd5930f4b5..dc557bbf3f 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -166,13 +166,16 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
>>   I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>>   /**
>> - * Create and realize an I2C slave device on the heap.
>> + * Create and realize an I2C slave device on the heap, add the device as a
>> + * child of its parent bus.
>> + *
>>    * @bus: I2C bus to put it on
>>    * @name: I2C slave device type name
>>    * @addr: I2C address of the slave when put on a bus
>>    *
>>    * Create the device state structure, initialize it, put it on the
>> - * specified @bus, and drop the reference to it (the device is realized).
>> + * specified @bus, parent it, and drop the reference to it (the device is
>> + * realized).
>>    */
>>   I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
>>
> 


