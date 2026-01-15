Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C86D3CCB6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHa5-0001VC-K6; Thu, 15 Jan 2026 02:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vgHa2-0001So-1f; Thu, 15 Jan 2026 02:15:42 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vgHZy-0006wF-UN; Thu, 15 Jan 2026 02:15:41 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dsDld2vDsz5wBN;
 Thu, 15 Jan 2026 07:15:24 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 15 Jan
 2026 08:15:24 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0015fba716e-b646-4fff-9adf-8aa66565fe54,
 730BEF4863DC82B2970748FB5926F4A3C98AA806) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cd9a0f11-7d36-4e58-afc8-96113ceb3613@kaod.org>
Date: Thu, 15 Jan 2026 08:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260112083054.4151945-2-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: ecf55630-45d8-4b9f-9d0b-42b37f39c6e3
X-Ovh-Tracer-Id: 10667901617816439730
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE9GB32VZeJfIPRyXGgh2bmunTwVh3XaIeEViZIAHLqsuZUso3s31nHwzdIXA4XQ8Y9RbYEzfAOqrV1WYMc+LVGtFGzi/mwfw0v+4KgfABOiYaZhZuAW4WJReW85RCchXJDdqjd/I4zOGy0P+gk04TvR69P2/TdMy2Z0RdkrXDTPvxZrpQ+IgzBVdp+3My0vMrvS00NJsWl94i4KdkG9zBIwBWS96pLr8mWHh6KSgEeXgxmrN/oVLyFBBGXoJ0h+oEwCCnu8wxntpdOS++xK5M3pbr2W0kmHSLvymVf9zfIbFSLJaUc9c+KsQMzFOOmKY0n68YKipINQxkD9Gx7RbueR43/hMOvW4SbiMlwcVfVnXChFud/SMyG2nb0bSg9Sb2W9+n5Zz3ElwbGqfJVSqFiSJxZDXLyzaKd6NxIk7vkEUxZpyDe9BdlaJxyUetxJ4LJ9wEjt2x2RF1OR4f6Hs4hneXpeojZqYLNLMbW7upPEGTEKAtA5YB1IYxYx0t4PwA8rt+HEhuaNv++kF7ygPjdZeQZa77tYYerPcImfya4cBk0lfgOo7YB90ZhlpZWHeG3ygfOdrtnt07iU4IYTNbSY9eKQNWbLyGJdBoOhUqQWd0Ncq+zHp9QVrORJ3siOP+dZ6YMEOnOhAX9y0g6WdbNLDVolv5lpNB8y2ooJ8pK8w
DKIM-Signature: a=rsa-sha256; bh=iiAvlZD4hYm3xKjWOvSHWFkX22TXpE1R57u0w3275OU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768461327; v=1;
 b=qTTMKtZkisjhYnJvsuD7djjG30ucv/KwTXdIUrIbWZJO/TFXX4caQHjph5HCIhl9vvXFgy3Y
 HErYPFm3TEqxk4L4ZnctqM5u+A1RqpKCS3OBLIMsqEka88QsXiqoA94kSm3RUtedt5XV2/IMfeg
 eqatPpwfry1eIl36xQLtm/DkrY+QSpIliD5+xp9WaT+/5kqL4/e0bGASb5WCP9uurUvsMrL3IWt
 SMsvQmlsMNeBWM5wgFefR1MGOE39oRdBPW2BhUkdpsoOjV+CCbAHCgOZlszVSDH1SSzn3SCTGml
 kWSzWHXfikU/a7jcWakVVPmS8w6BkANUa4Mcp1CTAxCRw==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
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

On 1/12/26 09:30, Kane Chen via wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> On some Aspeed-based machines, multiple I2C controllers may exist
> across different components, such as the primary SoC and an external
> IO expander or co-processor (e.g., AST1700). Using the current static
> naming convention results in object name conflicts when multiple
> controllers attempt to instantiate buses with the same ID.
> 
> This patch introduces a 'bus-label' property for the Aspeed I2C
> controller. This allows higher-level layers, such as the SoC realize
> function, to provide a unique identifier for the buses. The I2C bus
> object name is then constructed using this label (e.g., "ioexp0.0"
> instead of the default "aspeed.i2c.bus.0").
> 
> This enhancement ensures unique bus identifiers across the system and
> resolves naming conflicts in multi-controller configurations.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   include/hw/i2c/aspeed_i2c.h |  2 ++
>   hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
>   2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index ffcff2580f..68bd138026 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -252,6 +252,7 @@ struct AspeedI2CBus {
>       MemoryRegion mr_pool;
>   
>       I2CBus *bus;
> +    char *name;
>       uint8_t id;
>       qemu_irq irq;
>   
> @@ -269,6 +270,7 @@ struct AspeedI2CState {
>       uint32_t intr_status;
>       uint32_t ctrl_global;
>       uint32_t new_clk_divider;
> +    char *bus_label;
>       MemoryRegion pool_iomem;
>       uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
>   
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1b8ac561c3..7cf92423c7 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1215,9 +1215,16 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>                             "aspeed.i2c", aic->mem_size);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
> +    /* default value */
> +    if (!s->bus_label) {
> +        s->bus_label = g_strdup(TYPE_ASPEED_I2C_BUS);
> +    }
> +
>       for (i = 0; i < aic->num_busses; i++) {
>           Object *bus = OBJECT(&s->busses[i]);
>           int offset = i < aic->gap ? 1 : 5;
> +        g_autofree char *name = g_strdup_printf("%s.%d",
> +                                                s->bus_label, i);
>   
>           if (!object_property_set_link(bus, "controller", OBJECT(s), errp)) {
>               return;
> @@ -1227,6 +1234,10 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> +        if (!object_property_set_str(bus, "bus-name", name, errp)) {
> +            return;
> +        }
> +
>           if (!sysbus_realize(SYS_BUS_DEVICE(bus), errp)) {
>               return;
>           }
> @@ -1263,6 +1274,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>   static const Property aspeed_i2c_properties[] = {
>       DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
>   };
>   
>   static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
> @@ -1423,24 +1435,26 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
>       AspeedI2CClass *aic;
> -    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
> -    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
> +    g_autofree char *pool_name = NULL;
>   
> -    if (!s->controller) {
> -        error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
> +    if (!s->controller || !s->name) {
> +        error_setg(errp, TYPE_ASPEED_I2C_BUS
> +                   ": 'controller' or 'bus-name' not set");
>           return;
>       }
>   
> +    pool_name = g_strdup_printf("%s.pool", s->name);
> +
>       aic = ASPEED_I2C_GET_CLASS(s->controller);
>   
>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>   
> -    s->bus = i2c_init_bus(dev, name);
> +    s->bus = i2c_init_bus(dev, s->name);
>       s->slave = i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE,
>                                          0xff);
>   
>       memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
> -                          s, name, aic->reg_size);
> +                          s, s->name, aic->reg_size);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>   
>       memory_region_init_io(&s->mr_pool, OBJECT(s), &aspeed_i2c_bus_pool_ops,
> @@ -1452,6 +1466,7 @@ static const Property aspeed_i2c_bus_properties[] = {
>       DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
>       DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I2C,
>                        AspeedI2CState *),
> +    DEFINE_PROP_STRING("bus-name", AspeedI2CBus, name),
>   };
>   
>   static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *data)


