Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036C0CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5Gc-00042o-JU; Thu, 18 Jun 2026 01:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wa5GF-0003tz-Rd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:25:58 -0400
Received: from smtpout2.mo539.mail-out.ovh.net ([51.210.91.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wa5G9-0007U7-VJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:25:54 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4ggq202B3Bz41lV;
 Thu, 18 Jun 2026 05:25:44 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Thu, 18 Jun 2026 05:25:44 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.114])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4ggq200qj5z7v2J; Thu, 18 Jun 2026 05:25:44 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 1F89024034AA; Thu, 18 Jun 2026 05:25:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0011c573003-1d78-4ec4-9663-69b7c825cfdf,
 A2996BA223552B7951DE2AB9C59D4C10FAA35807) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f66bc149-65de-4d11-8bfe-ace436763839@kaod.org>
Date: Thu, 18 Jun 2026 07:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/sensor: adc128d818: add 12-bit 8-channel ADC
 device
To: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
 <20260617-i2c-adc128d818-anacapa-v2-1-fd38764f0465@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-1-fd38764f0465@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9320199430270725165
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEYj/leqiBwvBhrUJQuspsoEc3E5CyuYW6MRWZTaQauic83w0Pj/+BIUD2b1zNPi1NOzxfpadvVQd+ddA3PxMl2cx8l7bYbbCIhJ+4rw/wfgNI8O33U2XCgB3BwxbuZlpkZ/jApvfhfKGjwQ+F3PaxinWIGQaMfhHVqwy9i0f+pVj98ijP66GEilFz2kdNMZ04KqjjyYB6xVmJ/Uij+Y03sS1RaiPETqJLFIXaWzQ1A6Oon4XiK3tmChnn9lPjDDAT3k/Itiyqi/TNYYJg/nbSxEThVqhmormRqvCvtWPa5W+UxiSEeKS7WLj6JGy1fDWAv9/tbUIuQ05Xi8nwxw3hafW+mHFLjvMIz6grKljsDoD+2rd/EPoAwFx4AZodFB9qbTuFj2wWkVGCvXsE3dVx6k3usdQGKKzSUqRgAkBgwkDk0QyrkMLllHOVF3CJqQLaav0ZlZBeAAR6IC8V2zwoPqqFcpsJdEkGheGdBUyUZLm/m0Nc/GKTX47CXefVYnNeNRVa3+VfPsolDRXg3jCfYf3TrF3DHJ7MhdJ+oqcc3uVWB92I/CxP0wqSsu6u4n7cuhJN4HoFKfEK8J8xrXppwMVCzOkFan6f4Ek7BsezH5Rcr+cHgwUAlquK0RKdaTCuCS8hQA1qrwxZCNA0hMoB0RHYQrSy+XJWjx/dtgNlGgA
DKIM-Signature: a=rsa-sha256; bh=1U7LsDTPej5urYfwlxTiQRIcIb4F2vv1v/wWLJMAA/o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1781760346; v=1;
 b=qoAu3FO3jqpOnAW/lSt7MSWABhTk3NMKMnlrefUrJ2zCo61xEHiekhrrtxG00Vip0nLzW+1r
 LQ/E3lJShiU/czngI/RPYk6RKkxLDYiyGCtwyNrKbiZSjUXMz5Wp7zDn8P5ExMNRfNP0vs1RkpD
 tjglRALldQGnPatcVcHLV6apt9MtOHPFdr8lJgvkTwG/nwg7/folgGV0Q8xe4aLplvqGC583dmo
 BRSTSGL1QBvbr/LryT6+xUI5C014Dfn60KodbnD8l8slhtTZFywIiyVDeaVGVTo8CDn+RhVCBea
 6uFYCRlSvbWUuF/VJgumIdGPzss64cNA9tp3eb3eyF7cA==
Received-SPF: pass client-ip=51.210.91.41; envelope-from=clg@kaod.org;
 helo=smtpout2.mo539.mail-out.ovh.net
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

On 6/17/26 12:26, Emmanuel Blot wrote:
> The ADC128D818 is a TI 12-bit, 8-channel I2C ADC used on several
> OpenBMC platforms for voltage and temperature monitoring.
> 
> Implement the device with:
>   - four operating modes
>   - 12-bit voltage conversion from QOM inputs
>   - 9-bit temperature conversion from milli-degree Celsius QOM inputs
>   - switchable internal or external voltage reference
>   - per-channel high/low limit registers
>   - interrupt support
>   - software reset
>   - one-shot conversion support in shutdown mode
> 
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
>   hw/sensor/Kconfig              |   4 +
>   hw/sensor/adc128d818.c         | 695 +++++++++++++++++++++++++++++++++++++++++
>   hw/sensor/meson.build          |   1 +
>   hw/sensor/trace-events         |   8 +
>   include/hw/sensor/adc128d818.h |  12 +
>   5 files changed, 720 insertions(+)
> 
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index bc6331b4ab..b459ac2240 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -1,3 +1,7 @@
> +config ADC128D818
> +    bool
> +    depends on I2C
> +
>   config TMP105
>       bool
>       depends on I2C
> diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
> new file mode 100644
> index 0000000000..46c0f5d71a
> --- /dev/null
> +++ b/hw/sensor/adc128d818.c
> @@ -0,0 +1,695 @@
> +/*
> + * Texas Instruments ADC128D818 12-bit 8-channel ADC with I2C interface
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qom/object.h"
> +#include "hw/sensor/adc128d818.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +
> +/* Register addresses */
> +#define REG_CONFIG              0x00u
> +#define REG_INT_STATUS          0x01u
> +#define REG_INT_MASK            0x03u
> +#define REG_CONV_RATE           0x07u
> +#define REG_CH_DISABLE          0x08u
> +#define REG_ONE_SHOT            0x09u
> +#define REG_DEEP_SHUTDOWN       0x0Au
> +#define REG_ADV_CONFIG          0x0Bu
> +#define REG_BUSY_STATUS         0x0Cu
> +
> +/* Channel Reading Registers (16-bit, read-only) */
> +#define REG_CH_READING_BASE     0x20u
> +#define REG_CH_READING_LAST     0x27u
> +
> +/* Limit Registers (8-bit, read/write) */
> +#define REG_LIMIT_BASE          0x2Au
> +#define REG_LIMIT_LAST          0x39u
> +
> +/* ID Registers (read-only) */
> +#define REG_MANUFACTURER_ID     0x3Eu
> +#define REG_REVISION_ID         0x3Fu
> +
> +/* Configuration Register (0x00) bitfields */
> +#define CONFIG_START            BIT(0)
> +#define CONFIG_INT_ENABLE       BIT(1)
> +#define CONFIG_INT_CLEAR        BIT(3)
> +#define CONFIG_INITIALIZATION   BIT(7)
> +#define CONFIG_WR_MASK \
> +    (CONFIG_START | CONFIG_INT_ENABLE | CONFIG_INT_CLEAR)
> +
> +/* Advanced Configuration Register (0x0B) bitfields */
> +#define ADV_CONFIG_EXT_REF_EN   BIT(0)
> +#define ADV_CONFIG_MODE_SHIFT   1u
> +#define ADV_CONFIG_MODE_MASK    (0x3u << ADV_CONFIG_MODE_SHIFT)
> +#define ADV_CONFIG_WR_MASK \
> +    (ADV_CONFIG_EXT_REF_EN | ADV_CONFIG_MODE_MASK)
> +
> +/* Busy Status Register (0x0C) bitfields */
> +#define BUSY_STATUS_NOT_READY   BIT(1)
> +
> +/* Conversion Rate Register (0x07) bitfields */
> +#define CONV_RATE_MASK          0x01u
> +
> +/* Deep Shutdown Register (0x0A) bitfields */
> +#define DEEP_SHUTDOWN_EN        0x01u
> +
> +/* Device constants */
> +#define ADC128D818_NUM_CHANNELS         8u
> +#define ADC128D818_NUM_REGS             0x40u
> +
> +#define ADC128D818_INTERNAL_VREF_MV     2560u
> +#define ADC128D818_MAX_VDD_MV           5500u
> +#define ADC128D818_MANUFACTURER_ID_VAL  0x01u
> +#define ADC128D818_REVISION_ID_VAL      0x09u
> +
> +/* ADC resolution */
> +#define ADC128D818_ADC_RESOLUTION       4096u
> +#define ADC128D818_ADC_MAX              4095u
> +
> +/* Temperature: 0.5 deg C per LSb = 500 milli-degrees per LSb */
> +#define ADC128D818_TEMP_LSB_MC          500
> +#define ADC128D818_TEMP_RAW_MIN         (-256)
> +#define ADC128D818_TEMP_RAW_MAX         255
> +
> +
> +typedef struct ADC128D818State ADC128D818State;
> +DECLARE_INSTANCE_CHECKER(ADC128D818State, ADC128D818, TYPE_ADC128D818)
> +
> +struct ADC128D818State {
> +    I2CSlave i2c;
> +
> +    qemu_irq irq;
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +    uint8_t rx_byte;
> +
> +    uint8_t regs[ADC128D818_NUM_REGS];
> +    uint16_t channel[ADC128D818_NUM_CHANNELS];
> +
> +    int16_t ain[ADC128D818_NUM_CHANNELS]; /* mV */
> +    int32_t temperature; /* milli-degrees Celsius */
> +    uint16_t ext_vref; /* mV, 0 means not connected */
> +    bool temp_alarm; /* temperature high-limit alarm latched */
> +
> +    char *description;
> +};
> +
> +static uint16_t adc128d818_get_vref(const ADC128D818State *s)
> +{
> +    if (s->regs[REG_ADV_CONFIG] & ADV_CONFIG_EXT_REF_EN) {
> +        if (s->ext_vref > 0u) {
> +            return s->ext_vref;
> +        }
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s: external VREF selected but not"
> +                      " connected, falling back to internal\n",
> +                      __func__, s->description);
> +    }
> +
> +    return ADC128D818_INTERNAL_VREF_MV;
> +}
> +
> +static uint8_t adc128d818_get_mode(const ADC128D818State *s)
> +{
> +    return (s->regs[REG_ADV_CONFIG] & ADV_CONFIG_MODE_MASK) >>
> +           ADV_CONFIG_MODE_SHIFT;
> +}
> +
> +static bool adc128d818_is_temp_channel(const ADC128D818State *s, unsigned ch)
> +{
> +    if (ch != 7u) {
> +        return false;
> +    }
> +
> +    return adc128d818_get_mode(s) != 1u;
> +}
> +
> +static bool adc128d818_is_reserved_channel(const ADC128D818State *s,
> +                                           unsigned ch)
> +{
> +    switch (adc128d818_get_mode(s)) {
> +    case 2u:
> +        return ch >= 4u && ch <= 6u;
> +    case 3u:
> +        return ch == 6u;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static int16_t adc128d818_channel_voltage(const ADC128D818State *s, unsigned ch)
> +{
> +    switch (adc128d818_get_mode(s)) {
> +    case 2u:
> +        switch (ch) {
> +        case 0u:
> +            return (int16_t)(s->ain[0] - s->ain[1]);
> +        case 1u:
> +            return (int16_t)(s->ain[3] - s->ain[2]);
> +        case 2u:
> +            return (int16_t)(s->ain[4] - s->ain[5]);
> +        case 3u:
> +            return (int16_t)(s->ain[7] - s->ain[6]);
> +        default:
> +            return 0;
> +        }
> +    case 3u:
> +        switch (ch) {
> +        case 4u:
> +            return (int16_t)(s->ain[4] - s->ain[5]);
> +        case 5u:
> +            return (int16_t)(s->ain[7] - s->ain[6]);
> +        default:
> +            return s->ain[ch];
> +        }
> +    default:
> +        return s->ain[ch];
> +    }
> +}
> +
> +static void adc128d818_update_irq(ADC128D818State *s)
> +{
> +    uint8_t cfg = s->regs[REG_CONFIG];
> +    uint8_t active;
> +    bool level;
> +
> +    active = s->regs[REG_INT_STATUS] & ~s->regs[REG_INT_MASK];
> +
> +    /* INT pin is active-low */
> +    level = !((cfg & CONFIG_INT_ENABLE) && !(cfg & CONFIG_INT_CLEAR) &&
> +              (active != 0u));
> +
> +    trace_adc128d818_irq(s->description, level);
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static bool adc128d818_monitoring_active(const ADC128D818State *s)
> +{
> +    if (s->regs[REG_DEEP_SHUTDOWN] & DEEP_SHUTDOWN_EN) {
> +        return false;
> +    }
> +    if (!(s->regs[REG_CONFIG] & CONFIG_START)) {
> +        return false;
> +    }
> +    if (s->regs[REG_CONFIG] & CONFIG_INT_CLEAR) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void adc128d818_check_limits(ADC128D818State *s)
> +{
> +    uint8_t disabled = s->regs[REG_CH_DISABLE];
> +    uint8_t int_status = 0u;
> +
> +    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
> +        if ((disabled & (1u << ch)) ||
> +            adc128d818_is_reserved_channel(s, ch)) {
> +            continue;
> +        }
> +
> +        if (adc128d818_is_temp_channel(s, ch)) {
> +            int raw = s->temperature / ADC128D818_TEMP_LSB_MC;
> +            int thot;
> +            int thyst;
> +
> +            raw = MAX(ADC128D818_TEMP_RAW_MIN,
> +                      MIN(ADC128D818_TEMP_RAW_MAX, raw));
> +            thot = (int)(int8_t)s->regs[REG_LIMIT_BASE + ch * 2u] * 2;
> +            thyst = (int)(int8_t)s->regs[REG_LIMIT_BASE + ch * 2u + 1u] * 2;
> +
> +            if (raw > thot) {
> +                s->temp_alarm = true;
> +            } else if (raw <= thyst) {
> +                s->temp_alarm = false;
> +            }
> +            if (s->temp_alarm) {
> +                int_status |= (1u << ch);
> +            }
> +        } else {
> +            uint8_t msb = (uint8_t)(s->channel[ch] >> 8u);
> +            uint8_t high_lim = s->regs[REG_LIMIT_BASE + ch * 2u];
> +            uint8_t low_lim = s->regs[REG_LIMIT_BASE + ch * 2u + 1u];
> +
> +            if (msb > high_lim || msb <= low_lim) {
> +                int_status |= (1u << ch);
> +            }
> +        }
> +    }
> +
> +    s->regs[REG_INT_STATUS] = int_status;
> +    adc128d818_update_irq(s);
> +}
> +
> +static void adc128d818_convert(ADC128D818State *s)
> +{
> +    uint8_t disabled;
> +    uint16_t vref;
> +
> +    disabled = s->regs[REG_CH_DISABLE];
> +    vref = adc128d818_get_vref(s);
> +
> +    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
> +        if ((disabled & (1u << ch)) ||
> +            adc128d818_is_reserved_channel(s, ch)) {
> +            continue;
> +        }
> +
> +        if (adc128d818_is_temp_channel(s, ch)) {
> +            int32_t raw = s->temperature / ADC128D818_TEMP_LSB_MC;
> +
> +            raw =
> +                MAX(ADC128D818_TEMP_RAW_MIN, MIN(ADC128D818_TEMP_RAW_MAX, raw));
> +            s->channel[ch] = (uint16_t)(((unsigned)raw & 0x1FFu) << 7u);
> +        } else {
> +            int16_t vin = adc128d818_channel_voltage(s, ch);
> +            int32_t dout;
> +
> +            dout = vin * (int32_t)ADC128D818_ADC_RESOLUTION / vref;
> +            dout = MAX(0, MIN((int32_t)ADC128D818_ADC_MAX, dout));
> +            s->channel[ch] = (uint16_t)(dout << 4u);
> +        }
> +
> +        trace_adc128d818_convert(s->description, ch, s->channel[ch]);
> +    }
> +
> +    s->regs[REG_BUSY_STATUS] &= ~BUSY_STATUS_NOT_READY;
> +
> +    adc128d818_check_limits(s);
> +}
> +
> +static uint8_t adc128d818_read_channel(ADC128D818State *s, unsigned ch)
> +{
> +    uint8_t val;
> +
> +    if (s->rx_byte == 0u) {
> +        val = (uint8_t)(s->channel[ch] >> 8u);
> +        trace_adc128d818_read_channel(s->description, ch, s->channel[ch]);
> +    } else {
> +        val = (uint8_t)(s->channel[ch] & 0xFFu);
> +    }
> +    s->rx_byte ^= 1u;
> +
> +    return val;
> +}
> +
> +static uint8_t adc128d818_read_reg(ADC128D818State *s, uint8_t reg)
> +{
> +    uint8_t val;
> +
> +    switch (reg) {
> +    case REG_INT_STATUS:
> +        val = s->regs[REG_INT_STATUS];
> +        s->regs[REG_INT_STATUS] = 0x00u;
> +        if (adc128d818_monitoring_active(s)) {
> +            adc128d818_check_limits(s);
> +        } else {
> +            adc128d818_update_irq(s);
> +        }
> +        trace_adc128d818_read(s->description, reg, val);
> +        return val;
> +    case REG_CONFIG:
> +    case REG_INT_MASK:
> +    case REG_CONV_RATE:
> +    case REG_CH_DISABLE:
> +    case REG_ONE_SHOT:
> +    case REG_DEEP_SHUTDOWN:
> +    case REG_ADV_CONFIG:
> +    case REG_BUSY_STATUS:
> +    case REG_LIMIT_BASE ... REG_LIMIT_LAST:
> +    case REG_MANUFACTURER_ID:
> +    case REG_REVISION_ID:
> +        trace_adc128d818_read(s->description, reg, s->regs[reg]);
> +        return s->regs[reg];
> +    case REG_CH_READING_BASE ... REG_CH_READING_LAST:
> +        return adc128d818_read_channel(s, reg - REG_CH_READING_BASE);
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s: read from undefined register 0x%02x\n",
> +                      __func__, s->description, reg);
> +        return 0x00u;
> +    }
> +}
> +
> +static void adc128d818_write_reg(ADC128D818State *s, uint8_t reg, uint8_t val);
> +
> +static void adc128d818_reset_regs(ADC128D818State *s)
> +{
> +    memset(s->regs, 0, sizeof(s->regs));
> +    memset(s->channel, 0, sizeof(s->channel));
> +    s->temp_alarm = false;
> +
> +    s->regs[REG_CONFIG] = 0x08u;
> +    s->regs[REG_BUSY_STATUS] = 0x02u;
> +    s->regs[REG_MANUFACTURER_ID] = ADC128D818_MANUFACTURER_ID_VAL;
> +    s->regs[REG_REVISION_ID] = ADC128D818_REVISION_ID_VAL;
> +
> +    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
> +        s->regs[REG_LIMIT_BASE + ch * 2u] = 0xFFu;
> +    }
> +
> +    s->pointer = 0x00u;
> +    s->len = 0u;
> +    s->rx_byte = 0u;
> +
> +    adc128d818_update_irq(s);
> +}
> +
> +static void adc128d818_write_reg(ADC128D818State *s, uint8_t reg, uint8_t val)
> +{
> +    trace_adc128d818_write(s->description, reg, val);
> +
> +    switch (reg) {
> +    case REG_CONFIG:
> +        if (val & CONFIG_INITIALIZATION) {
> +            trace_adc128d818_reset(s->description, "reg");
> +            adc128d818_reset_regs(s);
> +            break;
> +        }
> +        s->regs[REG_CONFIG] = val & CONFIG_WR_MASK;
> +        if ((val & CONFIG_START) && !(val & CONFIG_INT_CLEAR) &&
> +            !(s->regs[REG_DEEP_SHUTDOWN] & DEEP_SHUTDOWN_EN)) {
> +            adc128d818_convert(s);
> +        }
> +        adc128d818_update_irq(s);
> +        break;
> +    case REG_INT_MASK:
> +        s->regs[REG_INT_MASK] = val;
> +        adc128d818_update_irq(s);
> +        break;
> +    case REG_CONV_RATE:
> +        if (s->regs[REG_CONFIG] & CONFIG_START) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s: CONV_RATE written while running\n",
> +                          __func__, s->description);
> +            break;
> +        }
> +        s->regs[REG_CONV_RATE] = val & CONV_RATE_MASK;
> +        break;
> +    case REG_CH_DISABLE:
> +        if (s->regs[REG_CONFIG] & CONFIG_START) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s: CH_DISABLE written while running\n",
> +                          __func__, s->description);
> +            break;
> +        }
> +        s->regs[REG_CH_DISABLE] = val;
> +        memset(s->channel, 0, sizeof(s->channel));
> +        s->regs[REG_INT_STATUS] = 0x00u;
> +        s->temp_alarm = false;
> +        adc128d818_update_irq(s);
> +        break;
> +    case REG_ONE_SHOT:
> +        if (!(s->regs[REG_CONFIG] & CONFIG_START)) {
> +            adc128d818_convert(s);
> +        }
> +        break;
> +    case REG_DEEP_SHUTDOWN:
> +        if ((val & DEEP_SHUTDOWN_EN) && (s->regs[REG_CONFIG] & CONFIG_START)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s: DEEP_SHUTDOWN set while running\n",
> +                          __func__, s->description);
> +            break;
> +        }
> +        s->regs[REG_DEEP_SHUTDOWN] = val & DEEP_SHUTDOWN_EN;
> +        break;
> +    case REG_ADV_CONFIG:
> +        if (s->regs[REG_CONFIG] & CONFIG_START) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s: ADV_CONFIG written while running\n",
> +                          __func__, s->description);
> +            break;
> +        }
> +        s->regs[REG_ADV_CONFIG] = val & ADV_CONFIG_WR_MASK;
> +        memset(s->channel, 0, sizeof(s->channel));
> +        s->regs[REG_INT_STATUS] = 0x00u;
> +        s->temp_alarm = false;
> +        adc128d818_update_irq(s);
> +        break;
> +    case REG_LIMIT_BASE ... REG_LIMIT_LAST:
> +        s->regs[reg] = val;
> +        break;
> +    case REG_INT_STATUS:
> +    case REG_BUSY_STATUS:
> +    case REG_MANUFACTURER_ID:
> +    case REG_REVISION_ID:
> +    case REG_CH_READING_BASE ... REG_CH_READING_LAST:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s: write to read-only register 0x%02x\n",
> +                      __func__, s->description, reg);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: %s: write to undefined register 0x%02x\n",
> +                      __func__, s->description, reg);
> +        break;
> +    }
> +}
> +
> +static uint8_t adc128d818_recv(I2CSlave *i2c)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +
> +    return adc128d818_read_reg(s, s->pointer);
> +}
> +
> +static int adc128d818_send(I2CSlave *i2c, uint8_t data)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +
> +    if (s->len == 0u) {
> +        s->pointer = data;
> +        s->len++;
> +    } else {
> +        adc128d818_write_reg(s, s->pointer, data);
> +    }
> +
> +    return 0;
> +}
> +
> +static int adc128d818_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    ADC128D818State *s = ADC128D818(i2c);
> +
> +    s->len = 0u;
> +    s->rx_byte = 0u;
> +
> +    return 0;
> +}
> +
> +static void adc128d818_get_ain(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value;
> +    int ch_num;
> +    int rc;
> +
> +    rc = sscanf(name, "ain%d", &ch_num);
> +    if (rc != 1 || ch_num < 0 || ch_num >= (int)ADC128D818_NUM_CHANNELS) {
> +        error_setg(errp, "%s: %s: invalid channel '%s'", __func__,
> +                   s->description, name);
> +        return;
> +    }
> +
> +    value = s->ain[ch_num];
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void adc128d818_set_ain(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value;
> +    int ch_num;
> +    int rc;
> +
> +    if (!visit_type_int(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    rc = sscanf(name, "ain%d", &ch_num);
> +    if (rc != 1 || ch_num < 0 || ch_num >= (int)ADC128D818_NUM_CHANNELS) {
> +        error_setg(errp, "%s: %s: invalid channel '%s'", __func__,
> +                   s->description, name);
> +        return;
> +    }
> +
> +    if (value < INT16_MIN || value > INT16_MAX) {
> +        error_setg(errp, "%s: %s: value %" PRId64 " out of range for '%s'",
> +                   __func__, s->description, value, name);
> +        return;
> +    }
> +
> +    s->ain[ch_num] = (int16_t)value;
> +
> +    if (adc128d818_monitoring_active(s)) {
> +        adc128d818_convert(s);
> +    }
> +}
> +
> +static void adc128d818_get_temperature(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value = s->temperature;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void adc128d818_set_temperature(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value;
> +
> +    if (!visit_type_int(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value < INT32_MIN || value > INT32_MAX) {
> +        error_setg(errp, "%s: %s: value %" PRId64 " out of range", __func__,
> +                   s->description, value);
> +        return;
> +    }
> +
> +    s->temperature = (int32_t)value;
> +
> +    if (adc128d818_monitoring_active(s)) {
> +        adc128d818_convert(s);
> +    }
> +}
> +
> +static const VMStateDescription adc128d818_vmstate = {
> +    .name = "ADC128D818",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(len, ADC128D818State),
> +        VMSTATE_UINT8(pointer, ADC128D818State),
> +        VMSTATE_UINT8(rx_byte, ADC128D818State),
> +        VMSTATE_UINT8_ARRAY(regs, ADC128D818State,
> +                            ADC128D818_NUM_REGS),
> +        VMSTATE_UINT16_ARRAY(channel, ADC128D818State,
> +                             ADC128D818_NUM_CHANNELS),
> +        VMSTATE_INT16_ARRAY(ain, ADC128D818State,
> +                            ADC128D818_NUM_CHANNELS),
> +        VMSTATE_INT32(temperature, ADC128D818State),
> +        VMSTATE_UINT16(ext_vref, ADC128D818State),
> +        VMSTATE_BOOL(temp_alarm, ADC128D818State),
> +        VMSTATE_I2C_SLAVE(i2c, ADC128D818State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void adc128d818_reset_hold(Object *obj, ResetType type)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +
> +    trace_adc128d818_reset(s->description, "hw");
> +    adc128d818_reset_regs(s);
> +}
> +
> +static void adc128d818_get_ext_vref(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value = (int64_t)s->ext_vref;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void adc128d818_set_ext_vref(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(obj);
> +    int64_t value;
> +
> +    if (!visit_type_int(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value < 0 || value > ADC128D818_MAX_VDD_MV) {
> +        error_setg(errp,
> +                   "%s: %s: ext-vref-mv %" PRId64 " out of range (0..%u mV)",
> +                   __func__, s->description, value, ADC128D818_MAX_VDD_MV);
> +        return;
> +    }
> +
> +    s->ext_vref = (uint16_t)value;
> +
> +    if (adc128d818_monitoring_active(s)) {
> +        adc128d818_convert(s);
> +    }
> +}
> +
> +static void adc128d818_initfn(Object *obj)
> +{
> +    for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
> +        char *name = g_strdup_printf("ain%u", ch);
> +
> +        object_property_add(obj, name, "int", adc128d818_get_ain,
> +                            adc128d818_set_ain, NULL, NULL);
> +        g_free(name);
> +    }
> +
> +    object_property_add(obj, "temperature", "int", adc128d818_get_temperature,
> +                        adc128d818_set_temperature, NULL, NULL);
> +    object_property_add(obj, "ext-vref-mv", "int", adc128d818_get_ext_vref,
> +                        adc128d818_set_ext_vref, NULL, NULL);
> +}
> +
> +static void adc128d818_realize(DeviceState *dev, Error **errp)
> +{
> +    ADC128D818State *s = ADC128D818(dev);
> +
> +    if (!s->description) {
> +        s->description = g_strdup(object_get_typename(OBJECT(dev)));
> +    }
> +
> +    qdev_init_gpio_out(dev, &s->irq, 1u);
> +}
> +
> +static const Property adc128d818_properties[] = {
> +    DEFINE_PROP_STRING("description", ADC128D818State, description),
> +};
> +
> +static void adc128d818_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *ic = I2C_SLAVE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    ic->event = adc128d818_event;
> +    ic->recv = adc128d818_recv;
> +    ic->send = adc128d818_send;
> +    dc->realize = adc128d818_realize;
> +    rc->phases.hold = adc128d818_reset_hold;
> +    dc->vmsd = &adc128d818_vmstate;
> +    device_class_set_props(dc, adc128d818_properties);
> +}
> +
> +static const TypeInfo adc128d818_types[] = {
> +    {
> +        .name          = TYPE_ADC128D818,
> +        .parent        = TYPE_I2C_SLAVE,
> +        .instance_init = adc128d818_initfn,
> +        .instance_size = sizeof(ADC128D818State),
> +        .class_init    = adc128d818_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(adc128d818_types)
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index 420fdc3359..fe36c9ef91 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -1,3 +1,4 @@
> +system_ss.add(when: 'CONFIG_ADC128D818', if_true: files('adc128d818.c'))
>   system_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
>   system_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
>   system_ss.add(when: 'CONFIG_DPS310', if_true: files('dps310.c'))
> diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> index a3fe54fa6d..5a3630f7bb 100644
> --- a/hw/sensor/trace-events
> +++ b/hw/sensor/trace-events
> @@ -1,5 +1,13 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# adc128d818.c
> +adc128d818_read(const char *id, uint8_t reg, uint8_t value) "%s reg 0x%02x val 0x%02x"
> +adc128d818_read_channel(const char *id, uint8_t channel, uint16_t value) "%s ch %u val 0x%04x"
> +adc128d818_write(const char *id, uint8_t reg, uint8_t value) "%s reg 0x%02x val 0x%02x"
> +adc128d818_convert(const char *id, uint8_t channel, uint16_t value) "%s ch %u val 0x%04x"
> +adc128d818_irq(const char *id, bool level) "%s level %u"
> +adc128d818_reset(const char *id, const char *source) "%s %s"
> +
>   # tmp105.c
>   tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
>   tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
> diff --git a/include/hw/sensor/adc128d818.h b/include/hw/sensor/adc128d818.h
> new file mode 100644
> index 0000000000..ce7e94d2b4
> --- /dev/null
> +++ b/include/hw/sensor/adc128d818.h
> @@ -0,0 +1,12 @@
> +/*
> + * Texas Instruments ADC128D818 12-bit 8-channel ADC with I2C interface
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_SENSOR_ADC128D818_H
> +#define HW_SENSOR_ADC128D818_H
> +
> +#define TYPE_ADC128D818 "adc128d818"
> +
> +#endif
> 

Sent in v1:

Reviewed-by: Alexander Hansen <alexander.hansen@9elements.com>
Tested-by: Alexander Hansen <alexander.hansen@9elements.com>


C.

