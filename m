Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED95C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ISd-0002pa-Q9; Tue, 01 Sep 2026 02:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISb-0002ot-J8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:09 -0400
Received: from smtpout3.mo538.mail-out.ovh.net ([51.210.91.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISZ-0001Tv-Fo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:09 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxY46G4yz6GMl;
 Tue,  1 Sep 2026 06:59:04 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:59:04 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.41])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxY45X6bz1xpm;
 Tue,  1 Sep 2026 06:59:04 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A6789203FDD; 
 Tue,  1 Sep 2026 06:59:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0052def7ebf-5af8-40d8-b29c-3f0477aac35f,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <418366fe-0ae9-433b-b1c1-51edc84f4604@kaod.org>
Date: Tue, 1 Sep 2026 08:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] hw/sensor: tmp105: enforce the configurable
 fault queue
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
 <20260731-sanmiguel-bmc-locator-v2-4-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-4-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8626645090501438509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFCz8ENcifGGc7lwMsh5Km2xuR+xdVhCLoxl+J2tovlCADjZE+WbMnanW7kgYgQe1Xb30hsAtuy6Zdh3JAhi6x2xIv0v1XCEdPl3zPVRXVt5hjCmOq/ZpuqEhKYNf8xVymhh8KyRxc6vTjsgFENdi6tszQlEq8FCwobqBFX8MEKZhFbq1M/+xzqMFrMBrJxefSUfZ2mAx/Mmj98zFs8rSYoGmSYa8hp4Qmxm+k7rl1SKe4/Mp3afxzMeOZDjd8oBqNZM63rfKRRkKDccYy/hmCmI66unOknYfrD9bhs8c9qkAUt7fGjDSuiUibfBtFU5ZtXhyuCJ/gU1dRq45DzfQKybzI1GrPSA7+PE1aqbjHxxw2wN3n2IlkfzP40VNT3J9mS7vUhjA5D3tFAKTW7dVAAemdO2lipra+/Q9eWw1lcrzsNU0eXh0qkgUvdopQTuwyEB5hO9vDxH1mHUAuop0QK7+eEwaQ8cBYgbqb1w3xp0h0UB8qk87NVMyZJajTaNkfeSXzm2hjR2pegdUTbNrfoGciregGzfaVv6nvJAY8pqHlFKmGYP42gZDgxh5Encv7RZEu3TBkrT2WrspOKKiYBdY6CFeRfvx67MCkUblUbGEgwNndZ9MB4HcNU0gugV4a0eesT8AImGBMpQaE2KDuccy333orrY40u7+4qtk31Ew
DKIM-Signature: a=rsa-sha256; bh=etUgObnrH3QtXxODorv/g90f6/4uAkSf8ru/VQI8gyI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245945; v=1;
 b=DQ1+KKmiy266+hFJ9d18TmUpGTL6HZ9A8gz0lFRVWOvh72CM8qn1zHp5dkSFLcH/PR1WaGwE
 7Wo2Ei46NJXJlTnmOEVAez9hxNYyyCyVtAegSpm0bLflH7JileuJHz2GtBSh/Du6kogteoZz5/n
 UYlOcB38FpmA/mTDSPYasS7dhCgM0qLt/1/eqrvyjaWIYP7uJd1VmbLpodhql3Svl6NKUFj+e/S
 Lw5A5WnAczdI3QZACVsFoSWYQ3A7SC3a6xQLFt4PAHZ4uMtxRsYH8/1tavnHuLX0q1m04R4kvHi
 Ox60ufkfp0agY6j0W9sKevfULFX6twHPxma+7jNDO9SEg==
Received-SPF: pass client-ip=51.210.91.32; envelope-from=clg@kaod.org;
 helo=smtpout3.mo538.mail-out.ovh.net
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
> The fault-queue depth selected in the configuration register was decoded
> but never consulted, so the ALERT pin tripped on the very first
> out-of-limit conversion regardless of the programmed depth.
> 
> Track the consecutive-fault count and only change the ALERT state once
> it reaches the programmed depth; any in-range conversion clears the
> count. The default configuration keeps the previous behaviour. The count
> is migrated through an optional subsection so existing streams stay
> compatible.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/sensor/tmp105.c | 87 ++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 55 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index f7d0c738ca..5c77f991cc 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -54,6 +54,7 @@ struct TMP105State {
>       int16_t temperature;
>       int16_t limit[2];
>       int faults;
> +    uint8_t fault_count;
>       uint8_t alarm;
>       /*
>        * The TMP105 initially looks for a temperature rising above T_high;
> @@ -78,43 +79,40 @@ static void tmp105_interrupt_update(TMP105State *s)
>   
>   static void tmp105_alarm_update(TMP105State *s, bool one_shot)
>   {
> +    bool fault;
> +
>       if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE) && !one_shot) {
>           return;
>       }
>   
> -    if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
> -        /*
> -         * TM == 1 : Interrupt mode. We signal Alert when the
> -         * temperature rises above T_high, and expect the guest to clear
> -         * it (eg by reading a device register).
> -         */
> -        if (s->detect_falling) {
> -            if (s->temperature < s->limit[0]) {
> -                s->alarm = 1;
> -                s->detect_falling = false;
> -            }
> -        } else {
> -            if (s->temperature >= s->limit[1]) {
> -                s->alarm = 1;
> -                s->detect_falling = true;
> -            }
> -        }
> +    /*
> +     * A fault is a conversion that lies outside the limit currently being
> +     * watched: above T_high while looking for the alarm to trip, below T_low
> +     * afterwards.
> +     */
> +    if (s->detect_falling) {
> +        fault = s->temperature < s->limit[0];
>       } else {
> -        /*
> -         * TM == 0 : Comparator mode. We signal Alert when the temperature
> -         * rises above T_high, and stop signalling it when the temperature
> -         * falls below T_low.
> -         */
> +        fault = s->temperature >= s->limit[1];
> +    }
> +
> +    if (!fault) {
> +        s->fault_count = 0;
> +    } else if (++s->fault_count >= s->faults) {
> +        s->fault_count = 0;
>           if (s->detect_falling) {
> -            if (s->temperature < s->limit[0]) {
> -                s->alarm = 0;
> -                s->detect_falling = false;
> -            }
> +            /*
> +             * Temperature fell back below T_low. In comparator mode (TM == 0)
> +             * the alarm is released; in interrupt mode (TM == 1) it is
> +             * asserted again and the guest is expected to clear it by reading
> +             * a register.
> +             */
> +            s->alarm = FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE);
> +            s->detect_falling = false;
>           } else {
> -            if (s->temperature >= s->limit[1]) {
> -                s->alarm = 1;
> -                s->detect_falling = true;
> -            }
> +            /* Temperature rose to or above T_high: assert the alarm. */
> +            s->alarm = 1;
> +            s->detect_falling = true;
>           }
>       }
>   
> @@ -204,7 +202,12 @@ static void tmp105_write(TMP105State *s)
>           }
>           s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
>           s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> -        tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
> +        if (FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT) &&
> +            FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
> +            tmp105_alarm_update(s, true);
> +        } else {
> +            tmp105_interrupt_update(s);
> +        }
>           break;
>   
>       case TMP105_REG_T_LOW:
> @@ -213,7 +216,7 @@ static void tmp105_write(TMP105State *s)
>               s->limit[s->pointer & 1] = (int16_t)
>                       ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
>           }
> -        tmp105_alarm_update(s, false);
> +        tmp105_interrupt_update(s);
>           break;
>       }
>   }
> @@ -281,6 +284,13 @@ static bool detect_falling_needed(void *opaque)
>       return s->detect_falling;
>   }
>   
> +static bool fault_count_needed(void *opaque)
> +{
> +    const TMP105State *s = opaque;
> +
> +    return s->fault_count != 0;
> +}
> +
>   static const VMStateDescription vmstate_tmp105_detect_falling = {
>       .name = "TMP105/detect-falling",
>       .version_id = 1,
> @@ -292,6 +302,17 @@ static const VMStateDescription vmstate_tmp105_detect_falling = {
>       }
>   };
>   
> +static const VMStateDescription vmstate_tmp105_fault_count = {
> +    .name = "TMP105/fault-count",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = fault_count_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(fault_count, TMP105State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_tmp105 = {
>       .name = "TMP105",
>       .version_id = 0,
> @@ -310,6 +331,7 @@ static const VMStateDescription vmstate_tmp105 = {
>       },
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_tmp105_detect_falling,
> +        &vmstate_tmp105_fault_count,
>           NULL
>       }
>   };
> @@ -322,6 +344,7 @@ static void tmp105_reset_hold(Object *obj, ResetType type)
>       s->pointer = 0;
>       s->config = 0;
>       s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> +    s->fault_count = 0;
>       s->alarm = 0;
>       s->detect_falling = false;
>   
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


