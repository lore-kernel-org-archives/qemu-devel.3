Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA0ECFD64E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVZI-0004Ik-89; Wed, 07 Jan 2026 10:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vdVZ8-0004Gb-PZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:35:18 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vdVZ6-00038O-2h
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:35:18 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.64])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dmXCz3mY2z5w0w;
 Wed,  7 Jan 2026 15:35:10 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 7 Jan
 2026 16:35:10 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0033f692ec6-bedd-4c15-b4bd-d21babaa998d,
 B17C28E31DD9158A39196EDC3B37DBE8CF9EC635) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
Date: Wed, 7 Jan 2026 16:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 96bb252d-6dff-44bb-8626-9fdf767c8f59
X-Ovh-Tracer-Id: 9020147106303740917
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFvmv85mzbX21EIUP4wUXHwExZpyIK0Z0QEJRCtR4xpqwbNNWS6RrFJXG1MCheu8SBv75sjcBSU4BIkLOe4JOQwygRrbCKLZNUa+D+KpS9UVqW8AYtvJ2kNzYRBF6N1rQaNVv4u/DIrtBmtRcVJAiNcfAZ/HVrU3RaeBaXqFjNImLHG3FIkFVZv6Ff4M7i/gKANUR+17qKdKpv4+Q4F8NK7fa9AjUeymjc7AiOibPxcAVPM6YB5zqi4feZuNkUYuVLu7M3MBcdgKE7J2zqUbDjDSh1mvOVhlU/Ktto+U6+quBCYU7/2yxOwLIkgmMSIrmFBUPHnlXhZHpaM9VkEMviiieRa0sbCxRIctJv6RyeY9emZ1Yvtu+o5hKSkGhECwKC9MSaOpOJYRk2epR/UyFpU9IMeWWgkUNduqDQS0tvufmpWDqDmy8i37gmL6LjbIro3RF3NskzCc8xj3gWti7Z+3RzyVTbAaatVQ674WeBcqPTPe8Ej1MTHkMVqE3yt1O41p5oi9U3ZRHj6DWdklx0RojCzE+uuJ2vTuFYpBqBCqtbdC551xE4ZLUfnzfS0W8XGqdQ+VX3yRCOq7EvUuS9BXO2/lPNRL9BFUJCVBqJmQK5qqc5k3QK8xQPX1F5JLzKQStSING+qZns80lyumRAmsQg0nDR1kvWVCsQ73QztcA
DKIM-Signature: a=rsa-sha256; bh=N+ldpoKKjvpXRETDZuedrZLTOn9mY4dIi109fFA99+Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767800112; v=1;
 b=GsU7d/vlQjNCqoLkXYZpGgy09IIGe30TcEWU3iLou4mfKFt5oyKwsGCAYrgVyHtWny0MLYI9
 4FzJdd9+4PWWY6P+GL8pEH13EFRLiEQW/TRn8rl7Py4CpVT9C5S92oA8qbdOqCAyYlN1eNc+Dv6
 EQbTavRDj+8poKm+XDIHbE6W/RubfojnBOmIAg7Vxtn5wB4W3kWt9Oq/9fL50GBQ5FH6OtAtoP9
 C6rGB3h4B6EeEkKMSz9jxuBP9aSc9Gnz3C01SG2MzLIG9OjBKQcGAvyHHApg3EjvFe53LkAb6I9
 6wHK/4fDRgMTwF9op8k4gVZOjoXIIX7aENlsIXNTdFCzg==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
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

On 1/7/26 15:53, Cédric Le Goater wrote:
> Hello Kane,
> 
> I agree we need a way to distinguish the I2C buses belonging to
> the Aspeed Soc from those of the Aspeed IO Expander, so devices
> can be attached on the correct bus.
> 
> Let's proceed with your proposal. Below are some refinements.
> 
> [ ... ]
> 
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -1261,6 +1261,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>>   static const Property aspeed_i2c_properties[] = {
>>       DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
>>                        TYPE_MEMORY_REGION, MemoryRegion *),
>> +    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
>>   };
>>   static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
>> @@ -1421,14 +1422,28 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
>>   {
>>       AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
>>       AspeedI2CClass *aic;
>> -    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
> 
> 
> I would prefer if you added a new property to AspeedI2CBus :
> 
>      DEFINE_PROP_STRING("name", AspeedI2CBus, name),
> 
> which would be set in aspeed_i2c_realize() :
> 
>      /* default value */
>      if (!s->bus_label) {
>              s->bus_label = g_strdup(TYPE_ASPEED_I2C_BUS);
>      }
> 
>      g_autofree char *name = g_strdup_printf("%s.%d", s->bus_label, i);
> 
>          if (!object_property_set_str(bus, "bus-name", name, errp)) {
>              return;
>          }

The above changes may be included in a separate prerequisite patch.

Thanks,

C.


> The naming should be a higher level decision, made at the SoC level.
> So, aspeed_ast1700_realize() should be adjusted when the "bus-label"
> property is set.
> 
> I don't think we need to keep the "aspeed.%s.i2c.bus" prefix. How about
> removing "aspeed" (which is redudant anyhow on an Aspeed machine) ?
> 
>    "ioexp%d.i2c.bus"
> 
> Also, in aspeed_i2c_bus_realize(), please make sure AspeedI2CBus::name
> is set, like s->controller. This could be an assert too.
> 
> Thanks,
> 
> C.
> 
> 
>> -    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
>> +    g_autofree char *name = NULL;
>> +    g_autofree char *pool_name = NULL;
>>       if (!s->controller) {
>>           error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
>>           return;
>>       }
>> +    /*
>> +     * I2C bus naming:
>> +     *   - Empty bus_label -> BMC internal controller, use default name.
>> +     *   - Non-empty bus_label -> external/addon controller, prefix with label
>> +     *     to avoid conflicts and show bus origin.
>> +     */
>> +    if (!s->controller->bus_label || (strlen(s->controller->bus_label) == 0)) {
>> +        name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
>> +    } else {
>> +        name = g_strdup_printf("aspeed.%s.i2c.bus.%d",
>> +                               s->controller->bus_label, s->id);
>> +    }
>> +    pool_name = g_strdup_printf("%s.pool", name);
>> +
>>       aic = ASPEED_I2C_GET_CLASS(s->controller);
>>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> 


