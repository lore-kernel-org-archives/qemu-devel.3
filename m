Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A09CC6B1C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfKp-0004oq-Oo; Tue, 13 Oct 2026 12:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfKm-0004nd-Qc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:36 -0400
Received: from smtpout9.mo540.mail-out.ovh.net ([51.210.91.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfKk-0004zr-0I
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:36 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4j408Q1JfPz45t3;
 Tue, 13 Oct 2026 16:26:29 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:26:29 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.181])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j408P3j4Kz6MbW; Tue, 13 Oct 2026 16:26:29 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 68EF4202CA4; 
 Tue, 13 Oct 2026 16:26:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0019c50bc1e-3dde-4172-99e1-c1bf330a206b,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b070f85e-b5e5-4c5a-99e8-c28943186903@kaod.org>
Date: Tue, 13 Oct 2026 18:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/50] hw/i2c: pca954x: add PCA9545 4-channel mux model
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-5-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-5-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6608188031405763629
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEy2TVmIGdJz9wb2lZxs6ZOYk0T6DuDjUbu8/zXGYTH4fUECEqloGjFfQQCwGTA+Qh7f8ykczPwXj/0yRHFk+ke0Oq8cqPzvgWUWqE52q4F8K7KHMRomHayz0KSPI3Kj1OS1RB4ltUXcr9VLwn8YMxu6kumcdPsPn14jLrFeI22oREKqPhMU2SvVrQ8KaXHRxjVPvt64nha3KIPtHpiy9r9K5jkCxjkBrKxyaee8ty7LwZMq0oVcVbO7WlIGgJOp6cyTRlPBQhZa3PdT41/UEK/QPowtMJd7DrnTJlu2XG9nN1MD1oRi9XLbB1T/tzjDKh80+WtaijTeEgascMvqUOAtlX7p1p/I3N/MoNJcn5TNbqDRMhtuEvmB70vpyySMBk1C+CyBT0T8Ey31k7vDlMzYSkjLRecHaSOvhuVgjV8c46e2u6SM4lTFTC4O2jlQ9qxGue8Bm7ocREPrVaLn/I8PXnJJYGKJnypuxImOis2JrduO37nhUwKxFD+WVPWzjhSG4b5X9j1ZQ/UNf8vxk3Tz1yABEZsnr1F/f6loc+40nOKua3E+9WfL7NCDwjPvrAyT9TTZsxAl92hBXf+0j9UPfdVHQMvIr1CpCzdhz8G00U3IrnBny8BykPRUlT+SSCOSlOVGYRNFAVR7IUvddnR1lhpCFPeHzpsxXErP5yhZw
DKIM-Signature: a=rsa-sha256; bh=gI4u/JepEAK27OIw8ngtTDe7oVZ9NxrCw0hdnAW3mUQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908791; v=1;
 b=LeNiVAfboSEt31kHOBJ5EZEUwTwhEXBRdUGhLP7gTkJzaWEQML50Bn3ZoXuaiX8Qzmcgeih1
 f368j3ZtPEZDtWclSHjvj1ynji5VIO2bXOiW0AmBvu3JHSLAz+VsUGTixz+Xh8QJF2NTXAYL9TN
 kXPJYDMv7Tb0JsaJyCXr0+tU9c2OeQvgHeO6tT3k4NgOAtZWhcXtE72QStdKEkOQ/eiDAiy43VV
 xRkjQ75JLdWOTfus2y3Gn64uGMPR2LYLsjo4gy2KshASBJL6sfj77ejVizr4OlXfdQAOPg7fXan
 5aGK8IH3gus1RS1h9pHDmB562VvOfCvo14FOmVoBup3zQ==
Received-SPF: pass client-ip=51.210.91.58; envelope-from=clg@kaod.org;
 helo=smtpout9.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/12/26 16:31, Emmanuel Blot wrote:
> The PCA9545 is a 4-channel I2C mux/switch. What sets it apart from the
> plain PCA9546 is its interrupt logic: one INTn input per channel and a
> shared INT output, both active low, asserted whenever any channel
> interrupt is active.
> 
> Model this behind a new has_irq class flag. The PCA9545 gains four named
> "interrupt" GPIO inputs and an "interrupt-out" output, and its control
> read-back merges the latched status nibble; the plain PCA9546/PCA9548
> switches keep their previous behaviour.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/i2c/i2c_mux_pca954x.c         | 71 ++++++++++++++++++++++++++++++++++++++--
>   include/hw/i2c/i2c_mux_pca954x.h |  1 +
>   2 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index c8e75da8b2..4bb078a03c 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -12,12 +12,20 @@
>    * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>    * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
>    * for more details.
> + *
> + * Limitations:
> + * - A control write longer than one byte is rejected rather than retaining the
> + *   last received byte as the datasheet specifies.
> + * - On reset the cached per-channel interrupt state is cleared; a downstream
> + *   INT input that stays asserted across the reset is not re-sampled until it
> + *   next toggles.
>    */
>   
>   #include "qemu/osdep.h"
>   #include "hw/i2c/i2c.h"
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/i2c/smbus_slave.h"
> +#include "hw/core/irq.h"
>   #include "hw/core/qdev.h"
>   #include "hw/core/qdev-properties.h"
>   #include "qemu/log.h"
> @@ -26,11 +34,15 @@
>   #include "trace.h"
>   
>   #define PCA9548_CHANNEL_COUNT 8
> +#define PCA9545_CHANNEL_COUNT 4
>   #define PCA9546_CHANNEL_COUNT 4
>   
>   /*
>    * struct Pca954xState - The pca954x state object.
>    * @control: The value written to the mux control.
> + * @int_status: Per-channel interrupt status, for parts with interrupt logic.
> + * @int_out: The mux INT output, driven low while any channel interrupt is
> + * active.
>    * @channel: The set of i2c channel buses that act as channels which own the
>    * i2c children.
>    */
> @@ -38,6 +50,8 @@ typedef struct Pca954xState {
>       SMBusDevice parent;
>   
>       uint8_t control;
> +    uint8_t int_status;
> +    qemu_irq int_out;
>   
>       bool enabled[PCA9548_CHANNEL_COUNT];
>       I2CBus *bus[PCA9548_CHANNEL_COUNT];
> @@ -48,11 +62,13 @@ typedef struct Pca954xState {
>   /*
>    * struct Pca954xClass - The pca954x class object.
>    * @nchans: The number of i2c channels this device has.
> + * @has_irq: Whether the part implements interrupt logic.
>    */
>   typedef struct Pca954xClass {
>       SMBusDeviceClass parent;
>   
>       uint8_t nchans;
> +    bool has_irq;
>   } Pca954xClass;
>   
>   #define TYPE_PCA954X "pca954x"
> @@ -116,8 +132,10 @@ static void pca954x_enable_channel(Pca954xState *s, uint8_t enable_mask)
>   
>   static void pca954x_write(Pca954xState *s, uint8_t data)
>   {
> -    s->control = data;
> -    pca954x_enable_channel(s, data);
> +    Pca954xClass *c = PCA954X_GET_CLASS(s);
> +
> +    s->control = c->has_irq ? data & ((1 << c->nchans) - 1) : data;
> +    pca954x_enable_channel(s, s->control);
>   
>       trace_pca954x_write_bytes(data);
>   }
> @@ -148,16 +166,45 @@ static int pca954x_write_data(SMBusDevice *d, uint8_t *buf, uint8_t len)
>   static uint8_t pca954x_read_byte(SMBusDevice *d)
>   {
>       Pca954xState *s = PCA954X(d);
> +    Pca954xClass *c = PCA954X_GET_CLASS(s);
>       uint8_t data = s->control;
> +
> +    /*
> +     * On parts with interrupt logic the read-back byte carries the per-channel
> +     * interrupt status in the upper nibble.
> +     */
> +    if (c->has_irq) {
> +        data = (s->int_status << 4) | (s->control & 0x0f);
> +    }
> +
>       trace_pca954x_read_data(data);
>       return data;
>   }
>   
> +/*
> + * A downstream device drives one of the INTn inputs. INTn and INT are active
> + * low, and both carry the physical level: 0 is asserted, 1 is idle.
> + */
> +static void pca954x_irq_handler(void *opaque, int n, int level)
> +{
> +    Pca954xState *s = PCA954X(opaque);
> +
> +    if (level) {
> +        s->int_status &= ~(1 << n);
> +    } else {
> +        s->int_status |= (1 << n);
> +    }
> +
> +    qemu_set_irq(s->int_out, s->int_status == 0);
> +}
> +
>   static void pca954x_enter_reset(Object *obj, ResetType type)
>   {
>       Pca954xState *s = PCA954X(obj);
>       /* Reset will disable all channels. */
>       pca954x_write(s, 0);
> +    s->int_status = 0;
> +    qemu_set_irq(s->int_out, 1); /* INT released */
>   }
>   
>   I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
> @@ -169,6 +216,13 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
>       return pca954x->bus[channel];
>   }
>   
> +static void pca9545_class_init(ObjectClass *klass, const void *data)
> +{
> +    Pca954xClass *s = PCA954X_CLASS(klass);
> +    s->nchans = PCA9545_CHANNEL_COUNT;
> +    s->has_irq = true;
> +}
> +
>   static void pca9546_class_init(ObjectClass *klass, const void *data)
>   {
>       Pca954xClass *s = PCA954X_CLASS(klass);
> @@ -184,12 +238,20 @@ static void pca9548_class_init(ObjectClass *klass, const void *data)
>   static void pca954x_realize(DeviceState *dev, Error **errp)
>   {
>       Pca954xState *s = PCA954X(dev);
> +    Pca954xClass *c = PCA954X_GET_CLASS(dev);
>       DeviceState *d = DEVICE(s);
>       if (s->name) {
>           d->id = g_strdup(s->name);
>       } else {
>           d->id = g_strdup_printf("pca954x[%x]", s->parent.i2c.address);
>       }
> +
> +    if (c->has_irq) {
> +        /* One INTn input per channel, plus the shared INT output. */
> +        qdev_init_gpio_in_named(dev, pca954x_irq_handler, "interrupt",
> +                                c->nchans);
> +        qdev_init_gpio_out_named(dev, &s->int_out, "interrupt-out", 1);
> +    }
>   }
>   
>   static void pca954x_init(Object *obj)
> @@ -242,6 +304,11 @@ static const TypeInfo pca954x_info[] = {
>           .class_init    = pca954x_class_init,
>           .abstract      = true,
>       },
> +    {
> +        .name          = TYPE_PCA9545,
> +        .parent        = TYPE_PCA954X,
> +        .class_init    = pca9545_class_init,
> +    },
>       {
>           .name          = TYPE_PCA9546,
>           .parent        = TYPE_PCA954X,
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
> index 3dd25ec983..19a1050505 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -3,6 +3,7 @@
>   
>   #include "hw/i2c/i2c.h"
>   
> +#define TYPE_PCA9545 "pca9545"
>   #define TYPE_PCA9546 "pca9546"
>   #define TYPE_PCA9548 "pca9548"
>   
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


