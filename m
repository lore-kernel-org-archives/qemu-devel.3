Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644B3C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ISR-0002mN-I0; Tue, 01 Sep 2026 02:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISQ-0002lk-A6
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:58:58 -0400
Received: from smtpout4.mo540.mail-out.ovh.net ([51.210.91.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISN-0001SI-Kx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:58:58 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxXg5sp6z454K;
 Tue,  1 Sep 2026 06:58:43 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:58:43 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.33])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxXg14xkz1xtq; Tue,  1 Sep 2026 06:58:43 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3E53E12E3FDD;
 Tue,  1 Sep 2026 06:58:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00554ae51dc-7779-41e1-a4d9-d019c8161ae4,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8c2a781f-7614-4069-8717-7b779d761435@kaod.org>
Date: Tue, 1 Sep 2026 08:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/25] hw/sensor: tmp105: make device state private to
 the implementation
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-1-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-1-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8620734113018522669
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFkhYwIgM6OorUqvwnbfq/XbjSJkA6E/t+D0+W2+Ug84GXGNDzeOS01kdCwKR/hGQwLk1t/s4FvcsvlAyQMhMgpPrYJ5+owUQUcOjsHggQR2+Lqms/0xIq7nYXr/vWJkNtgruSNEAP7SmFExZGdXdmyrNE0vJNeJ/TfrsGSj7ThNXVjZrEisC3eMueNchi0Cv4xFEBf4/VdZDSDuqzub8eY65jIxkMfzl5PlSN9yjuAWxloJExJHMNWgTt1/ncROr6lQg/04PHVtG6y3MQTx+jbXxmHrunQJ8ocg3uPZttXsq1HUgct+soNPTd73TBxqpfOE7bddLXH8zeRq4JHJYqBKxls/aAkvbLEbp2jStswqtsJzXv+FZAiEGZfyiOtSnRiKHfr6ITYpYpwYl8ZYRJeD/toJkvjhVjt3wBbuSoMk6AicsxcXA98SEo6LbPKRIpjmTQhaRfsTrZkxy4Ej/BLII/MgmVkenYJaqAHo+Ykkv+KQTeQ11ggO4wzH/nSdhsM1iFg0jJDthjhX6pMMU2ey4KcY0gzqshuuBFUX+8n0v3dE7/TqWAfCK3Lwq2LRINDvOKjDEMkO5q8Fl9v528SzymGyKuMYC0UnfO/XZTIixuzmFGbYIAgw2q2jjRBj7tMePJqn3RnOJwAKfYdcrwS/O1R6RcVhiO2m2zFjgYHEQ
DKIM-Signature: a=rsa-sha256; bh=k2aqUgH3Yn/o/CGSbM82Oz/fJCux9AfwHysPkda5u+U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245925; v=1;
 b=EozQBWMxDee3o3orblEZbQjEG6Qvsh+xT5QU5L0ezW6qqAajS9WAUr/DXD70cTzxYhRKNaci
 0yXIO/gOEYN9rKA8RYnITGgWM6nvyZqcqf1DITnfeKYEoE4ABSBO1jSStPUWgyMammIo/hmqjKM
 383OPXTKnq67lQj3waCxsel7jqAh9TH5a9BsnMnmsF4nltKzUEyTdukShca3No3OVBRQs9zskgr
 z3Vltma9sMKHXngq7b+FKPwGJCsjuFX/KhZFeDZd6wY/tcyvkmz06bRaBmUKlweEv70ThFFGU2V
 5065aO4EfKFHT7P7hzcuUsU3U0UOEVjRI+SKv4Z+NMrCw==
Received-SPF: pass client-ip=51.210.91.53; envelope-from=clg@kaod.org;
 helo=smtpout4.mo540.mail-out.ovh.net
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> The TMP105State struct, its cast macro and typedef are used only within
> tmp105.c. Move them out of the public header into the source file and
> drop the now-unused includes; the header is reduced to the TYPE_TMP105
> name, with its guard renamed to the path-derived form per current QEMU
> convention.
> 
> While here, normalize the source file include order to match the other
> hw/sensor devices.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/sensor/tmp105.c         | 45 ++++++++++++++++++++++++++++++++++++++++-----
>   include/hw/sensor/tmp105.h | 40 ++--------------------------------------
>   2 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index c5089d74f4b..6069c0905d9 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -19,16 +19,51 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "hw/i2c/i2c.h"
> -#include "hw/core/irq.h"
> -#include "migration/vmstate.h"
> -#include "hw/sensor/tmp105.h"
> +#include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> -#include "qemu/module.h"
> +#include "qom/object.h"
> +#include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp105_regs.h"
> +#include "hw/core/irq.h"
>   #include "hw/core/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
>   #include "trace.h"
>   
> +OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
> +
> +/**
> + * TMP105State:
> + * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
> + * temperature. See Table 8 in the data sheet.
> + *
> + * @see_also: http://www.ti.com/lit/gpn/tmp105
> + */
> +struct TMP105State {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t buf[2];
> +    qemu_irq pin;
> +
> +    uint8_t pointer;
> +    uint8_t config;
> +    int16_t temperature;
> +    int16_t limit[2];
> +    int faults;
> +    uint8_t alarm;
> +    /*
> +     * The TMP105 initially looks for a temperature rising above T_high;
> +     * once this is detected, the condition it looks for next is the
> +     * temperature falling below T_low. This flag is false when initially
> +     * looking for T_high, true when looking for T_low.
> +     */
> +    bool detect_falling;
> +};
> +
>   FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
>   FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
>   FIELD(CONFIG, POLARITY,             2, 1)
> diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
> index 244e2989feb..daece592e9b 100644
> --- a/include/hw/sensor/tmp105.h
> +++ b/include/hw/sensor/tmp105.h
> @@ -11,45 +11,9 @@
>    * This work is licensed under the terms of the GNU GPL, version 2 or
>    * later. See the COPYING file in the top-level directory.
>    */
> -#ifndef QEMU_TMP105_H
> -#define QEMU_TMP105_H
> -
> -#include "hw/i2c/i2c.h"
> -#include "hw/sensor/tmp105_regs.h"
> -#include "qom/object.h"
> +#ifndef HW_SENSOR_TMP105_H
> +#define HW_SENSOR_TMP105_H
>   
>   #define TYPE_TMP105 "tmp105"
> -OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
> -
> -/**
> - * TMP105State:
> - * @config: Bits 5 and 6 (value 32 and 64) determine the precision of the
> - * temperature. See Table 8 in the data sheet.
> - *
> - * @see_also: http://www.ti.com/lit/gpn/tmp105
> - */
> -struct TMP105State {
> -    /*< private >*/
> -    I2CSlave i2c;
> -    /*< public >*/
> -
> -    uint8_t len;
> -    uint8_t buf[2];
> -    qemu_irq pin;
> -
> -    uint8_t pointer;
> -    uint8_t config;
> -    int16_t temperature;
> -    int16_t limit[2];
> -    int faults;
> -    uint8_t alarm;
> -    /*
> -     * The TMP105 initially looks for a temperature rising above T_high;
> -     * once this is detected, the condition it looks for next is the
> -     * temperature falling below T_low. This flag is false when initially
> -     * looking for T_high, true when looking for T_low.
> -     */
> -    bool detect_falling;
> -};
>   
>   #endif
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


