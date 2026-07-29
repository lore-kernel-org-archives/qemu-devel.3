Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D69BC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8Ke-0005sI-V5; Wed, 29 Jul 2026 13:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wp8Kc-0005rj-FF; Wed, 29 Jul 2026 13:44:39 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wp8KX-0005wv-SX; Wed, 29 Jul 2026 13:44:38 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KTK4Fjjz5xTx;
 Wed, 29 Jul 2026 17:44:21 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 29 Jul 2026 17:44:20 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.138])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h9KTJ4JzLz6JXG; Wed, 29 Jul 2026 17:44:20 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 30ED1203E56; 
 Wed, 29 Jul 2026 17:44:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003f0c85720-acce-4764-bcfc-90db5372366c,
 8FFE599222FA429370CFDB2A71624BCB30E75F05) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <feb70328-dc8e-4ace-b98a-7f11ac15bdef@kaod.org>
Date: Wed, 29 Jul 2026 19:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] hw/sensor: tmp105: add TMP75, TMP175 and LM75B
 variants
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
 <20260729-sanmiguel-bmc-locator-v1-7-c8f9a8d101f6@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-7-c8f9a8d101f6@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 4320077946504195117
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGSfpiAAf24rEM4RrQfZGb3cnidySuQFuOG1S8dsDNSoJtLyhic9mHrCT+07HMqi+QlsDJ0ORBezYPyXDsX4IEzLAe3d05nHsYWNWA1ydzBqj6slxgYKoeZiKcg0Ud+0BzzQsK+Q8BGWHkihKlEcb3dldm+SmxPbj0Cp/JFXDf0fGucDOfVnY39y4tbHyhJ+9MR6culo0ayHmlXSQsmN87vOva3yPDdE90MU9kpiz2e2CIf99Eqeu6abXIfji7DYLdNfoFTvlUSTkCRXPPJP2EbaW2rvrHrFheQMlby02zjjbLdupLT3aiRL1e8QuiCDPfjUliYyNH9BDj8lJHlnWRlU4RvwlIqeiKCBDE+zGPrrx3PfsjdAHbnSNAw2a5EK+CittrSuKrvTBKjv7vAymBpW0v9f9qSmPnreDkZB3jdP/83x1sDecIk1IA9Y7/buh0AlZ1AW0vHVmIAKM21b1BQALMLtWV6qR2qRbvjlhJtIcFjr5ldmKm/3xwc2lDTNn1NSQ1ouYtiI4Gkml02buYyAeqDiaenWNcfikgFo7QvJ9KCT+eQKLNgx502M2Lkw08ruFdpLXCW8xfxsTEd+pzZ6Ah+/Hy4WgWzuJWekPgn8XE7koTGWEV0ITpJhQXrnRN0h1jj4LX2h69Yoz/d9HdauPcJUge+0ngkmyQFdOmK0w
DKIM-Signature: a=rsa-sha256; bh=ymimZJi2J4sf+nzv/A9pQg18QGPFr5OYRN9x8I1M4OE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1785347063; v=1;
 b=BPBWMaH8+W83yG55gfjetwzodzS7XfTw7hCzUyI6lsYDuicpmRuCjH2x13mFZASMtKEvVO4U
 oslp3JMFrBSJELur3WVPJa9oebowcls+Bq/EOVbudXbUwNmk+vbBMV4aI8cP2RNn2Sfha19qX/9
 7MWfyy+4ecN6etZdQVPWgQzkYY1Qa8lpIMB1nVNPvzYhZNAtGLeIZriiz9uQvFVDGjBRgi8Q78M
 8vBBrVMtVtE9kl06yYxyDCkJ3AWIMQgOAQAwy1QRbdwK6aQRP5m2HNMf2Ybi+DZ3bef7qZilvnW
 wcEsopYG4bUvoX6fhPw0EyXfXZ6pEXX7Ikmn/S1iftpRQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
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

On 7/29/26 17:12, Emmanuel Blot wrote:
> The TI TMP75/TMP175 and the NXP LM75B share the TMP105 register map and
> control semantics, differing only in a few details. Model them as
> variants of the TMP105, parameterised by a small per-type class
> descriptor covering the fault-queue depths, the writable config bits,
> the converter resolution, the set-point masks and the TMP75's
> alert-clear on thermostat-mode change.
> 
> The variant is class data, not migrated state, so the wire format is
> unchanged and all variants share the existing vmstate.
> 
> While here, align the shared shutdown handling with the hardware:
> entering shutdown now clears the ALERT/OS output in interrupt mode,
> correcting the base TMP105 as well.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/sensor/tmp105.c         | 171 +++++++++++++++++++++++++++++++++++++--------
>   include/hw/sensor/tmp105.h |   6 +-
>   2 files changed, 147 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index fefa661711..69ade2013d 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -1,5 +1,5 @@
>   /*
> - * Texas Instruments TMP105 temperature sensor.
> + * Texas Instruments TMP105/TMP75/TMP175/LM75B temperature sensor.
>    *
>    * Copyright (C) 2008 Nokia Corporation
>    * Written by Andrzej Zaborowski <andrew@openedhand.com>
> @@ -16,6 +16,13 @@
>    *
>    * You should have received a copy of the GNU General Public License along
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * Limitations:
> + * - The SMBus Alert Response Address protocol and the general-call commands
> + *   are not implemented.
> + * - The over-limit comparison uses the full 8.8 fixed-point temperature and a
> + *   ">=" boundary for every variant. The LM75B's 9-bit comparison quantisation
> + *   and strict-exceed boundary are therefore only approximated.
>    */
>   
>   #include "qemu/osdep.h"
> @@ -31,15 +38,29 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
> +OBJECT_DECLARE_TYPE(TMP105State, TMP105Class, TMP105)
>   
>   /**
> - * TMP105State:
> - * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
> - * temperature. See Table 8 in the data sheet.
> + * TMP105Variant:
> + * Per-device-model parameters. The TMP105, TMP75, TMP175 and LM75B share the
> + * same register map and control semantics; they differ only in a handful of
> + * details captured here.
>    *
> - * @see_also: http://www.ti.com/lit/gpn/tmp105
> + * @faultq: fault-queue length table selected by Config bits
> + * @config_wmask: writable Config bits. The LM75B has no resolution (R1:R0) or
> + * one-shot (OS) bits.
> + * @fixed_res: converter resolution field pinned by the device, or -1 when it is
> + * software-selectable.
> + * @limit_lsb_mask: low-byte mask applied to the T_LOW/T_HIGH limit registers.
>    */
> +typedef struct TMP105Variant {
> +    const uint8_t *faultq;
> +    uint8_t config_wmask;
> +    int8_t fixed_res;
> +    uint8_t limit_lsb_mask;
> +    bool tm_change_clears_alert;
> +} TMP105Variant;

There are class attributes which belong to the TMP105Class below.

Thanks,

C.

>   struct TMP105State {
>       /*< private >*/
>       I2CSlave parent_obj;
> @@ -53,7 +74,7 @@ struct TMP105State {
>       uint8_t config;
>       int16_t temperature;
>       int16_t limit[2];
> -    int faults;
> +    uint8_t faults;
>       uint8_t fault_count;
>       uint8_t alarm;
>       /*
> @@ -65,6 +86,11 @@ struct TMP105State {
>       bool detect_falling;
>   };
>   
> +struct TMP105Class {
> +    I2CSlaveClass parent_class;
> +    const TMP105Variant *var;
> +};
> +
>   FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
>   FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
>   FIELD(CONFIG, POLARITY,             2, 1)
> @@ -152,10 +178,11 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
>       tmp105_alarm_update(s, false);
>   }
>   
> -static const int tmp105_faultq[4] = { 1, 2, 4, 6 };
> -
>   static void tmp105_read(TMP105State *s)
>   {
> +    const TMP105Variant *var = TMP105_GET_CLASS(s)->var;
> +    int res;
> +
>       s->len = 0;
>   
>       if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
> @@ -165,9 +192,11 @@ static void tmp105_read(TMP105State *s)
>   
>       switch (s->pointer & 3) {
>       case TMP105_REG_TEMPERATURE:
> +        res = var->fixed_res >= 0 ? var->fixed_res :
> +              FIELD_EX8(s->config, CONFIG, CONVERTER_RESOLUTION);
>           s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
>           s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
> -                (0xf0 << (FIELD_EX8(~s->config, CONFIG, CONVERTER_RESOLUTION)));
> +                (0xf0 << (3 - res));
>           break;
>   
>       case TMP105_REG_CONFIG:
> @@ -190,6 +219,10 @@ static void tmp105_read(TMP105State *s)
>   
>   static void tmp105_write(TMP105State *s)
>   {
> +    const TMP105Variant *var = TMP105_GET_CLASS(s)->var;
> +    uint8_t config, one_shot;
> +    bool waking;
> +
>       trace_tmp105_write(s->parent_obj.address, s->pointer);
>   
>       switch (s->pointer & 3) {
> @@ -197,14 +230,27 @@ static void tmp105_write(TMP105State *s)
>           break;
>   
>       case TMP105_REG_CONFIG:
> -        if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
> +        config = s->buf[0] & var->config_wmask;
> +        if (FIELD_EX8(config & ~s->config, CONFIG, SHUTDOWN_MODE)) {
>               trace_tmp105_write_shutdown(s->parent_obj.address);
> +            if (FIELD_EX8(config, CONFIG, THERMOSTAT_MODE)) {
> +                s->alarm = 0;
> +            }
>           }
> -        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
> -        s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> -        if (FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT) &&
> -            FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
> +        if (var->tm_change_clears_alert &&
> +            FIELD_EX8(config ^ s->config, CONFIG, THERMOSTAT_MODE)) {
> +            s->alarm = 0;
> +            s->fault_count = 0;
> +            s->detect_falling = false;
> +        }
> +        waking = FIELD_EX8(s->config & ~config, CONFIG, SHUTDOWN_MODE);
> +        one_shot = FIELD_EX8(config, CONFIG, ONE_SHOT);
> +        s->config = FIELD_DP8(config, CONFIG, ONE_SHOT, 0);
> +        s->faults = var->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> +        if (one_shot && FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
>               tmp105_alarm_update(s, true);
> +        } else if (waking) {
> +            tmp105_alarm_update(s, false);
>           } else {
>               tmp105_interrupt_update(s);
>           }
> @@ -214,7 +260,8 @@ static void tmp105_write(TMP105State *s)
>       case TMP105_REG_T_HIGH:
>           if (s->len >= 3) {
>               s->limit[s->pointer & 1] = (int16_t)
> -                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
> +                    ((((uint16_t) s->buf[0]) << 8) |
> +                     (s->buf[1] & var->limit_lsb_mask));
>           }
>           tmp105_interrupt_update(s);
>           break;
> @@ -265,8 +312,9 @@ static int tmp105_event(I2CSlave *i2c, enum i2c_event event)
>   static int tmp105_post_load(void *opaque, int version_id)
>   {
>       TMP105State *s = opaque;
> +    const TMP105Variant *var = TMP105_GET_CLASS(s)->var;
>   
> -    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> +    s->faults = var->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
>   
>       tmp105_interrupt_update(s);
>       return 0;
> @@ -339,11 +387,12 @@ static const VMStateDescription vmstate_tmp105 = {
>   static void tmp105_reset_hold(Object *obj, ResetType type)
>   {
>       TMP105State *s = TMP105(obj);
> +    const TMP105Variant *var = TMP105_GET_CLASS(s)->var;
>   
>       s->temperature = 0;
>       s->pointer = 0;
>       s->config = 0;
> -    s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> +    s->faults = var->faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
>       s->fault_count = 0;
>       s->alarm = 0;
>       s->detect_falling = false;
> @@ -376,6 +425,7 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    TMP105Class *tc = TMP105_CLASS(klass);
>   
>       dc->realize = tmp105_realize;
>       k->event = tmp105_event;
> @@ -383,19 +433,82 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
>       k->send = tmp105_tx;
>       rc->phases.hold = tmp105_reset_hold;
>       dc->vmsd = &vmstate_tmp105;
> +    tc->var = data;
>   }
>   
> -static const TypeInfo tmp105_info = {
> -    .name          = TYPE_TMP105,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_size = sizeof(TMP105State),
> -    .instance_init = tmp105_initfn,
> -    .class_init    = tmp105_class_init,
> +/*
> + * Fault-queue length selected by Config F1:F0. Row 0 (1/2/4/6) is used by the
> + * TMP105, TMP175 and LM75B; row 1 (1/2/3/4) by the TMP75.
> + */
> +static const uint8_t tmp105_faultq[][4] = {
> +    { 1, 2, 4, 6 },
> +    { 1, 2, 3, 4 },
>   };
>   
> -static void tmp105_register_types(void)
> -{
> -    type_register_static(&tmp105_info);
> -}
> +/* The F1:F0 field must never index past a fault-queue table row. */
> +QEMU_BUILD_BUG_ON((1 << R_CONFIG_FAULT_QUEUE_LENGTH) - 1 >=
> +                  ARRAY_SIZE(tmp105_faultq[0]));
> +
> +static const TMP105Variant tmp105_variant = {
> +    .faultq = tmp105_faultq[0],
> +    .config_wmask = 0xff,
> +    .fixed_res = -1,
> +    .limit_lsb_mask = 0xf0,
> +    .tm_change_clears_alert = false,
> +};
> +
> +static const TMP105Variant tmp175_variant = {
> +    .faultq = tmp105_faultq[0],
> +    .config_wmask = 0xff,
> +    .fixed_res = -1,
> +    .limit_lsb_mask = 0xf0,
> +    .tm_change_clears_alert = false,
> +};
> +
> +static const TMP105Variant tmp75_variant = {
> +    .faultq = tmp105_faultq[1],
> +    .config_wmask = 0xff,
> +    .fixed_res = -1,
> +    .limit_lsb_mask = 0xf0,
> +    .tm_change_clears_alert = true,
> +};
> +
> +static const TMP105Variant lm75b_variant = {
> +    .faultq = tmp105_faultq[0],
> +    .config_wmask = 0x1f,    /* R1:R0 and OS are reserved */
> +    .fixed_res = 2,          /* fixed 11-bit resolution, 0.125 C */
> +    .limit_lsb_mask = 0x80,  /* 9-bit limits, 0.5 C */
> +    .tm_change_clears_alert = false,
> +};
> +
> +static const TypeInfo tmp105_types[] = {
> +    {
> +        .name          = TYPE_TMP105,
> +        .parent        = TYPE_I2C_SLAVE,
> +        .instance_size = sizeof(TMP105State),
> +        .class_size    = sizeof(TMP105Class),
> +        .instance_init = tmp105_initfn,
> +        .class_init    = tmp105_class_init,
> +        .class_data    = &tmp105_variant,
> +    },
> +    {
> +        .name          = TYPE_TMP175,
> +        .parent        = TYPE_TMP105,
> +        .class_init    = tmp105_class_init,
> +        .class_data    = &tmp175_variant,
> +    },
> +    {
> +        .name          = TYPE_TMP75,
> +        .parent        = TYPE_TMP105,
> +        .class_init    = tmp105_class_init,
> +        .class_data    = &tmp75_variant,
> +    },
> +    {
> +        .name          = TYPE_LM75B,
> +        .parent        = TYPE_TMP105,
> +        .class_init    = tmp105_class_init,
> +        .class_data    = &lm75b_variant,
> +    },
> +};
>   
> -type_init(tmp105_register_types)
> +DEFINE_TYPES(tmp105_types)
> diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
> index daece592e9..0698aeead7 100644
> --- a/include/hw/sensor/tmp105.h
> +++ b/include/hw/sensor/tmp105.h
> @@ -1,5 +1,5 @@
>   /*
> - * Texas Instruments TMP105 Temperature Sensor
> + * Texas Instruments TMP105/TMP75/TMP175/LM75B Temperature Sensor
>    *
>    * Browse the data sheet:
>    *
> @@ -14,6 +14,10 @@
>   #ifndef HW_SENSOR_TMP105_H
>   #define HW_SENSOR_TMP105_H
>   
> +/* TMP75, TMP175 and NXP LM75B are register-compatible with TMP105. */
>   #define TYPE_TMP105 "tmp105"
> +#define TYPE_TMP175 "tmp175"
> +#define TYPE_TMP75  "tmp75"
> +#define TYPE_LM75B  "lm75b"
>   
>   #endif
> 


