Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B3ECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHH25-0004V1-Fo; Thu, 15 Oct 2026 04:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHH1z-0004UB-8H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:41:43 -0400
Received: from smtpout8.mo537.mail-out.ovh.net ([51.210.91.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHH1v-0000V9-2c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:41:43 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4j51l23fnGz3wdy;
 Thu, 15 Oct 2026 08:41:33 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 15 Oct 2026 08:41:33 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.3])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j51l15lLmz5vLZ;
 Thu, 15 Oct 2026 08:41:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C22382402CB9; Thu, 15 Oct 2026 08:41:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0029b981eaf-9198-4b4d-9fa8-091ae1bb4bad,
 39EAFCA45846CB7F25CFDE7C5DD07A896C21AD00) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <059ada7e-1147-4bd8-b0ca-212cb58d5fe5@kaod.org>
Date: Thu, 15 Oct 2026 10:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/50] hw/rtc: ds1338: parameterise the register map
 via a device class
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
 <20261012-bmc-minerva-v2-12-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-12-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10501549907263401005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGYPHbKaUDx2U8j6haCXe+72+ZjA4sKgsWOvXkO38jkeRj3unjdS/nLI+gUwDWAXMWDFr7OyX0bbGp1DRb2crdiF0gVjLDdpmC4LT0tn3bO+ovrCNzIo3Df3GrBdlKGmxfCaY3gobztYERel7qm2D4xIOcw3BtdHMeivXI7q4RwQdCQScV0DVscn+7PGu1pxFyQAdCWHij+yrVjQA0Xc5ahiJY8n7XhHnzVVjvt4/qq6utUW7RjJjqghjBJvi4tuq/bpgospbEjBB1fsJHEiMJw7vZ7u55NvKTq/MAu/bdSe734MpUgZuetfD0+bjA9Bj8R1ak0BdMMIW+MD85TLZQ5YGSrqOSXxObU9pcEYpOSaqX4z6tz4GJVoWGqvMDaAeSdrA+c3nX1NBgjb08xOE5KJwVJAeisVxYYTs17tIsmSw0zXxETYzP7uy+CG47Ysrrz0k0SiG1Mma2gyqH4p53Pi9nBxJoEAZ3JWdejC7SWN8YN+CARhHfz2YUS2D5wnwo/hOeDvL8WCRiprZZ16GiKWXYhLl8ZxhZOlA8J0grOlENB3lmB8DzT9l8YMDo1pSBStHnKh6fgbR42Y5/MlihfANKnSmDTvfGajAXXcWC74Z2NRaS9ORW/Urx82WLmKzXRqmy1CifMQMkD1SsJ9EUXSzASJlQ61XEuOKZPm0vv9Q
DKIM-Signature: a=rsa-sha256; bh=dGqBYFGI9TJn1266Qal9LY5sKgaq/pRXLwu0poCR+YM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1792053695; v=1;
 b=OPjc/7+R4oIqNajRzY2Z90TtpMFJmMPK5+eo5qhTpfkhzMzAvVD1vHUWpRaT13/mfKcOrpX6
 qQUzQdqCa7uyo8W2sGQl+KVdpOVDy+pNNoqfo4zXfNJwA5Uwuvsdyp6HdEFvSf5xFaOsTFnmDi3
 51UYVcKG4ih1IkCAeBg1ybiT2e1jmbHNa/ABtGrgpa7NmXC8xlg11/udceCgd9RuRD1lWAhx7qV
 neoavuTfIszmtxaOQFk8SklESxV6P9pOc3l+EP0gAewRu53UgGb6MNFSs9NHnDqQT6qrkwlZ98B
 Q4IvIvYhtneqtVw8fwJDO4UNicyEIypAKwise/LqXFvXg==
Received-SPF: pass client-ip=51.210.91.27; envelope-from=clg@kaod.org;
 helo=smtpout8.mo537.mail-out.ovh.net
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

On 10/12/26 16:32, Emmanuel Blot wrote:
> In preparation for a register-compatible variant, refactor DS1338
> register map. Introduce DS1338Class, carrying the register-pointer wrap
> boundary and the control/OSF register location and masks, and drive
> inc_regptr() and the control-register handling.
> 
> The control-register power-on value is parameterised along with them,
> so the part comes up holding the contents its datasheet specifies
> rather than zero, and its oscillator-stop flag now reads set at
> power-on.
> 
> Encode the year register modulo 100 (tm_year % 100) instead of
> tm_year - 100.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/rtc/ds1338.c | 71 ++++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
> index 1755a3a37c..7eaa663113 100644
> --- a/hw/rtc/ds1338.c
> +++ b/hw/rtc/ds1338.c
> @@ -30,7 +30,14 @@
>   #define HOURS_PM   0x20
>   #define CTRL_OSF   0x20
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
> +/* DS1338 register map */
> +#define DS1338_NUM_REGS    NVRAM_SIZE   /* 0x00..0x3f, then wraps */
> +#define DS1338_CONTROL     0x07
> +#define DS1338_CTRL_MASK   0xb3         /* bits 2, 3 and 6 read back as zero */
> +/* POR: OUT, OSF, SQWE and both rate-select bits come up set. */
> +#define DS1338_CTRL_RESET  0xb3
> +
> +OBJECT_DECLARE_TYPE(DS1338State, DS1338Class, DS1338)
>   
>   struct DS1338State {
>       I2CSlave parent_obj;
> @@ -42,6 +49,17 @@ struct DS1338State {
>       bool addr_byte;
>   };
>   
> +struct DS1338Class {
> +    I2CSlaveClass parent_class;
> +
> +    uint8_t num_regs;       /* register-pointer wrap boundary */
> +    uint8_t ctrl_addr;      /* control register address */
> +    uint8_t ctrl_mask;      /* writable/read-back bits of the control reg */
> +    uint8_t osf_addr;       /* register holding the OSF flag */
> +    uint8_t osf_mask;       /* OSF bit within osf_addr */
> +    uint8_t ctrl_reset;     /* control-register power-on value */
> +};
> +
>   static const VMStateDescription vmstate_ds1338 = {
>       .name = "ds1338",
>       .version_id = 2,
> @@ -82,16 +100,19 @@ static void ds1338_capture_current_time(DS1338State *s)
>       s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
>       s->nvram[4] = to_bcd(now.tm_mday);
>       s->nvram[5] = to_bcd(now.tm_mon + 1);
> -    s->nvram[6] = to_bcd(now.tm_year - 100);
> +    s->nvram[6] = to_bcd(now.tm_year % 100);
>   }
>   
>   static void ds1338_inc_regptr(DS1338State *s)
>   {
> -    /* The register pointer wraps around after 0x3F; wraparound
> -     * causes the current time/date to be retransferred into
> -     * the secondary registers.
> +    DS1338Class *k = DS1338_GET_CLASS(s);
> +
> +    /*
> +     * The register pointer wraps around after the last register; wraparound
> +     * causes the current time/date to be retransferred into the secondary
> +     * registers.
>        */
> -    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
> +    s->ptr = (s->ptr + 1) % k->num_regs;
>       if (!s->ptr) {
>           ds1338_capture_current_time(s);
>       }
> @@ -136,11 +157,12 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
>   static int ds1338_send(I2CSlave *i2c, uint8_t data)
>   {
>       DS1338State *s = DS1338(i2c);
> +    DS1338Class *k = DS1338_GET_CLASS(i2c);
>   
>       trace_ds1338_send(s->ptr, data);
>   
>       if (s->addr_byte) {
> -        s->ptr = data & (NVRAM_SIZE - 1);
> +        s->ptr = data % k->num_regs;
>           s->addr_byte = false;
>           return 0;
>       }
> @@ -190,18 +212,19 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>               break;
>           }
>           s->offset = qemu_timedate_diff(&now);
> -    } else if (s->ptr == 7) {
> -        /* Control register. */
> -
> -        /* Ensure bits 2, 3 and 6 will read back as zero. */
> -        data &= 0xB3;
> -
> -        /* Attempting to write the OSF flag to logic 1 leaves the
> -           value unchanged. */
> -        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
> -
> -        s->nvram[s->ptr] = data;
>       } else {
> +        if (s->ptr == k->ctrl_addr) {
> +            /* Control register: reserved bits read back as zero. */
> +            data &= k->ctrl_mask;
> +        }
> +        if (s->ptr == k->osf_addr) {
> +            /*
> +             * Attempting to write the OSF flag to logic 1 leaves the
> +             * value unchanged.
> +             */
> +            data = (data & ~k->osf_mask) |
> +                   (data & s->nvram[s->ptr] & k->osf_mask);
> +        }
>           s->nvram[s->ptr] = data;
>       }
>       ds1338_inc_regptr(s);
> @@ -211,11 +234,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>   static void ds1338_reset_hold(Object *obj, ResetType type)
>   {
>       DS1338State *s = DS1338(obj);
> +    DS1338Class *k = DS1338_GET_CLASS(s);
>   
>       /* The clock is running and synchronized with the host */
>       s->offset = 0;
>       s->wday_offset = 0;
>       memset(s->nvram, 0, NVRAM_SIZE);
> +    s->nvram[k->ctrl_addr] = k->ctrl_reset;
>       s->ptr = 0;
>       s->addr_byte = false;
>   }
> @@ -225,12 +250,21 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DS1338Class *dsc = DS1338_CLASS(klass);
>   
>       k->event = ds1338_event;
>       k->recv = ds1338_recv;
>       k->send = ds1338_send;
>       rc->phases.hold = ds1338_reset_hold;
> +    dc->desc = "DS1338 I2C RTC with 56-byte NV RAM";
>       dc->vmsd = &vmstate_ds1338;
> +
> +    dsc->num_regs   = DS1338_NUM_REGS;
> +    dsc->ctrl_addr  = DS1338_CONTROL;
> +    dsc->ctrl_mask  = DS1338_CTRL_MASK;
> +    dsc->osf_addr   = DS1338_CONTROL;
> +    dsc->osf_mask   = CTRL_OSF;
> +    dsc->ctrl_reset = DS1338_CTRL_RESET;
>   }
>   
>   static const TypeInfo ds1338_types[] = {
> @@ -238,6 +272,7 @@ static const TypeInfo ds1338_types[] = {
>           .name          = TYPE_DS1338,
>           .parent        = TYPE_I2C_SLAVE,
>           .instance_size = sizeof(DS1338State),
> +        .class_size    = sizeof(DS1338Class),
>           .class_init    = ds1338_class_init,
>       },
>   };
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


