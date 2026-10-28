Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF63606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=LrVO5n4Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzQS-0005RG-Ly; Wed, 28 Oct 2026 04:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzQN-0005Qv-ID
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:54:23 -0400
Received: from smtpout7.mo537.mail-out.ovh.net ([51.210.91.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzQJ-0001xa-NK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:54:23 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jF1Pf5WHXz492K;
 Wed, 28 Oct 2026 08:54:14 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 28 Oct 2026 08:54:14 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.169])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jF1Pf4NVhz1yhs; Wed, 28 Oct 2026 08:54:14 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 8234224031E8; Wed, 28 Oct 2026 08:54:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002c154e182-14a3-4fb2-ac06-b2b643357d5d,
 E08929C5676352A1F51837021B168DD299C323AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
Date: Wed, 28 Oct 2026 09:54:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
To: Timur Maksimov <gessingate@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13273796954292726829
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEOswFbIdNngyiHpe4WVUanhEcTd4o7h6bIy79V4ndSmNdGnpUA2Ll3tHZ6HmG7+zhKYiLXOmz/VCYm9yeooxLNrIxp7k/D7FTU6I47IYLfVCJo7J2WF4pr7xsbe1CJGrruc/DPYuc1MoMAkqgExq540e/bguCnS1zX73/j22cDbgAaxtPHjAR/Lk4xM6xCgq3nhL5mBSWJQBZEUSCzoWS12JUdL9g9Oij7RrZYbkUewcVxPRzcNXEYISbStdJvFRgoYC3lI/gYusSE22rokSNKx6vZihQVY9fAcHVkasBC2pT9V5MJnnl3bSbnKfqJZssjxeocXULiJB8NqA30tgyzTDezBGbUmlwlEbC09pUzVi9jUQrgzddWxXEZJ+Ouwc85bbFz6IZrvIy4HUoqH6S0rRDEBtD4R84+8r+SZGBmgarbTYAUCmbUEVcGS2zcSWLRqg62dZS/FHBAqZ+nlMj9/PhYpLhb3W29iCqL4MHTGYNDq+b6uLLeYxw8Ttn0cgA2Kd5why7x17qvBbdGy6GY8jZQs8MpjfR8EYF6nioJ04rudeSiKTbhFgysrPDyWlSlWgdZCP36Aa95QWwTtRDCeSQOREIXxgsT8qfQwwqa79oOZ9D1r9CGxI5Nm6haAW0v18k8txH1x8lzUWq4GOsOj69fKyleg+iSgRg/VFE7SA
DKIM-Signature: a=rsa-sha256; bh=Jb5CSbg/sOZguzvLpR49XqjUum7PfEhigMdiwIpZtm8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793177655; v=1;
 b=LrVO5n4YaIakw/E6bUAlc5Ji0udX6E0WbEqF7n+1uD25q7WJ9VC9dRXQSGJAIrYbxOkWE0yn
 sW6UXww/DeSH/dgcH1f1U4sjQD5wTQGPfxEG/hOZ9DMiTae3/nNqJloWbqOpQrOEkeWBnToD6JK
 b0qX2vQnT1LmdOBObJ+zebKd8bkv8c4o1Em0tA9WxE3bVYS3mP2Nex/4UA3B7tn1Gtn7m2yOiyq
 4OLxZ0uoG0PCYJdMaz+WsjyPEq1VIBezp+eEb+JmVGYnImM3QNSQHMT5AxNAebk6LmjXPnYnOtz
 pCNcF/ZOmWJK95eECdqB0lhE10FZGPgA0pYj4AROXY/mw==
Received-SPF: pass client-ip=51.210.91.26; envelope-from=clg@kaod.org;
 helo=smtpout7.mo537.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Corey for I2C feed back.

+ Markus for QOM

The brute-force solution to expose the contents of the device array
with 128 properties has a slight AI smell. I find it ugly but I am
human :) That said I don't know if there are better alternatives.

My approach would have been to use a string property :

       object_property_add_str(obj, "tx",
                               i2c_dummy_device_get_tx, NULL);
       object_property_add_str(obj, "rx",
                               i2c_dummy_device_get_rx,
                               i2c_dummy_device_set_rx);
  

Any better ideas ?


On 10/27/26 20:50, Timur Maksimov wrote:
> Simple I2C device with QOM properties to access
> transmit and receive buffers.
> Can be used for testing or prototyping.
> 
> Signed-off-by: Timur Maksimov <gessingate@gmail.com>
> ---
>   hw/i2c/Kconfig            |   5 ++
>   hw/i2c/i2c-dummy-device.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++

MAINTAINERS need updating.


>   hw/i2c/meson.build        |   3 +-
>   3 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 0766130b59..04912671db 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -6,6 +6,11 @@ config I2C_DEVICES
>       # to any board's i2c bus
>       bool
>   
> +config I2C_DUMMY_DEVICE
> +    bool
> +    default y if TEST_DEVICES
> +    depends on I2C
> +
>   config SMBUS
>       bool
>       select I2C
> diff --git a/hw/i2c/i2c-dummy-device.c b/hw/i2c/i2c-dummy-device.c
> new file mode 100644
> index 0000000000..645525a572
> --- /dev/null
> +++ b/hw/i2c/i2c-dummy-device.c
> @@ -0,0 +1,168 @@
> +/*
> + * QEMU I2C Dummy Device
> + *
> + * Copyright (c) 2026 Timur Maksimov <gessingate@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
> +
> +#define TYPE_I2C_DUMMY_DEVICE "i2c-dummy-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(I2CDummyDeviceState, I2C_DUMMY_DEVICE)
> +
> +#define I2C_DUMMY_ARRAY_SIZE 64
> +
> +struct I2CDummyDeviceState {
> +    I2CSlave parent_obj;
> +
> +    uint8_t tx[I2C_DUMMY_ARRAY_SIZE];
> +    uint8_t rx[I2C_DUMMY_ARRAY_SIZE];
> +
> +    uint8_t tx_pos;
> +    uint8_t rx_pos;
> +    uint8_t event;
> +};
> +
> +static void i2c_dummy_device_reset(DeviceState *dev)
> +{
> +    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(dev);
> +
> +    s->tx_pos = 0;
> +    s->rx_pos = 0;
> +    s->event = I2C_FINISH;
> +    memset(s->tx, 0, sizeof s->tx);
> +    /* Don't reset rx as it is a readonly parameter for the model */
> +}
> +
> +static int i2c_dummy_device_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        s->tx_pos = 0;
> +        break;
> +
> +    case I2C_START_RECV:
> +        s->rx_pos = 0;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    s->event = event;
> +    return 0;
> +}
> +
> +static int i2c_dummy_device_send(I2CSlave *i2c, uint8_t data)
> +{
> +    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
> +
> +    if (s->tx_pos >= I2C_DUMMY_ARRAY_SIZE) {
> +        /*
> +         * The TX buffer is full. NACK the byte.
> +         */
> +        return 1;
> +    }
> +
> +    if (s->event == I2C_START_SEND) {
> +        s->tx[s->tx_pos++] = data;
> +    }
> +
> +    return 0;
> +}
> +
> +static uint8_t i2c_dummy_device_recv(I2CSlave *i2c)
> +{
> +    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(i2c);
> +
> +    if (s->rx_pos >= I2C_DUMMY_ARRAY_SIZE || s->event != I2C_START_RECV) {
> +        /*
> +         * There is no more data available.
> +         */
> +        return 0xff;
> +    }
> +
> +    return s->rx[s->rx_pos++];
> +}
> +
> +static void i2c_dummy_device_init(Object *obj)
> +{
> +    I2CDummyDeviceState *s = I2C_DUMMY_DEVICE(obj);
>
> +    for (int i = 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
> +        g_autofree char *name = g_strdup_printf("tx[%d]", i);
> +
> +        object_property_add_uint8_ptr(
> +            obj, name, &s->tx[i],
> +            OBJ_PROP_FLAG_READWRITE);
> +    }
> +
> +    for (int i = 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
> +        g_autofree char *name = g_strdup_printf("rx[%d]", i);
> +
> +        object_property_add_uint8_ptr(
> +            obj, name, &s->rx[i],
> +            OBJ_PROP_FLAG_READWRITE);
> +    }
> +
> +    object_property_add_uint8_ptr(
> +            obj, "tx-pos", &s->tx_pos,
> +            OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_uint8_ptr(
> +            obj, "rx-pos", &s->rx_pos,
> +            OBJ_PROP_FLAG_READWRITE);

alignment could be improved.

> +}
> +
> +static const VMStateDescription vmstate_i2c_dummy_device = {
> +    .name = TYPE_I2C_DUMMY_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(parent_obj, I2CDummyDeviceState),
> +
> +        VMSTATE_UINT8_ARRAY(tx, I2CDummyDeviceState,
> +                            I2C_DUMMY_ARRAY_SIZE),
> +
> +        VMSTATE_UINT8_ARRAY(rx, I2CDummyDeviceState,
> +                            I2C_DUMMY_ARRAY_SIZE),
> +
> +        VMSTATE_UINT8(tx_pos, I2CDummyDeviceState),
> +        VMSTATE_UINT8(rx_pos, I2CDummyDeviceState),
> +        VMSTATE_UINT8(event, I2CDummyDeviceState),
> +
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void i2c_dummy_device_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *isc = I2C_SLAVE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, i2c_dummy_device_reset);

Please use Resettable phases for new devices.

> +
> +    dc->vmsd = &vmstate_i2c_dummy_device;
> +
> +    isc->event = i2c_dummy_device_event;
> +    isc->send = i2c_dummy_device_send;
> +    isc->recv = i2c_dummy_device_recv;
> +}
> +
> +static const TypeInfo i2c_dummy_device_info[] = {
> +    {
> +        .name = TYPE_I2C_DUMMY_DEVICE,
> +        .parent = TYPE_I2C_SLAVE,
> +        .instance_size = sizeof(I2CDummyDeviceState),
> +        .instance_init = i2c_dummy_device_init,
> +        .class_init = i2c_dummy_device_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(i2c_dummy_device_info)
> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> index 88aea35662..4695cbcd28 100644
> --- a/hw/i2c/meson.build
> +++ b/hw/i2c/meson.build
> @@ -1,5 +1,5 @@
>   i2c_ss = ss.source_set()
> -i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
> +i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c', 'i2c-dummy-device.c'))

Please drop this change.

Config I2C_DUMMY_DEVICE which defaults to y when TEST_DEVICES is set
should be enough.

>   i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
>   i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
>   i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
> @@ -19,4 +19,5 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
>   i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
>   i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
>   i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_I2C_DUMMY_DEVICE', if_true: files('i2c-dummy-device.c'))
>   system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
> 


Thanks,

C.

