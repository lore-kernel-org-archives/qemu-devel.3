Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BCAC624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ISX-0002nL-6c; Tue, 01 Sep 2026 02:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1ISU-0002mU-KQ; Tue, 01 Sep 2026 02:59:02 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x1ISS-0001T0-JY; Tue, 01 Sep 2026 02:59:02 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxXn14Npz3xwZ;
 Tue,  1 Sep 2026 06:58:49 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:58:48 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.33])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxXm6qm8z1xrg; Tue,  1 Sep 2026 06:58:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8F50112E3FDD;
 Tue,  1 Sep 2026 06:58:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005a8a5af55-fcfa-470e-99ef-dffef0e3ba18,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <790b50e4-9ddb-4463-bf22-5b6c8ccdcc70@kaod.org>
Date: Tue, 1 Sep 2026 08:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/sensor: tmp105: name the parent object field
 parent_obj
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
 <20260731-sanmiguel-bmc-locator-v2-2-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-2-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8622141487276207149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGxufBk2Eg2lfgW0HN7MYGfVnmNKhjefcdxQEyAoiUz4QfNSymZsDgpLAhtEgI8+oE3o0jd2MTAnUAcq64nI4vxZ2ah57ehBlX6bV1XqCDwM6GewsfJQjP0rZHnmsDrsCLCH6fQTbPotAXXfbGBLsBs80IrmlbJJSILSHsKQKMRqE/Fbi3+6webTNtmKYfb/9hXD3anfPQx0VGbX7gUqu1LALQmXaUi6pWq3Nck6aVCHTDvdJ1VPXbxCyhGHKCat+yPLIxfNIiyIB/YoJaKj9X0DxaoAsWdyf2NY58+CsZIXbiN1nCoZ57sFAwWB76AdLMy5Kn8E+6Ko77hwI87AVrloSk4g3ZvaMX88KBolVAgMmEtsMFQrhDqPnryjG4/avxeov9yXCz0cgPOs5jfdSvjHGiAvCrrJNm9m7oMW+WDfyDrbeLTnkl1KrBs1me8G/MX0Wr7oi+OvRg+Y2JQtiyXHoLJLP/ed8dX1TxwCtCsuxvb7gjOvvGIDdYi1YpwTSAVYKBPF/X6AeFqtx64+6Gbwj0vfB1KrfelltYOmYJP/jnOuw9iFgLtI/Hn2LNoFfNfsO/wecxBgY+tUDDWEJpJpCHmiKw8BcP3zWH8edFu1Vhtv3LBemVTK2dxuPUv4j4SHUAoDaZ9LF1zqcO2lF+itjtFm+QLRA+s+ReySltjGA
DKIM-Signature: a=rsa-sha256; bh=ZBe9LuI4jhNxifhrlLVNM/kOLjh+j9j77cir40Uh9TI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245930; v=1;
 b=CvaI9Sy8f+gfSS5rUf740xg29BF93EbQBBnMc7yBBTE++jQx7K5OuRdhQkvWRhEN4B037bIw
 oLhPYdySjw7AiRi4RX6zU/klFa5plNm3PgtcJJSEfC8d2wepUQF/juzoseikjFuH0liEhlaePsQ
 s4+VnAh6L3AKcC1pzTGLOGjiAN/dupaG0m635/GBqF4WNJa7v5aPxtfAZqtR/rKv3HZwbMQ/19G
 Ugtj/yof5akLlzzq6kGPki7X5B/NqoRnIpLmuGFhiz3hJmLveOza2nSjQP/SohTqZpiRp1FJ0gF
 +WzGSutDxmR7gKMEboAnaMubifwR3GoCvRwlb/jup3zug==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> QEMU coding conventions expect the embedded parent object of a QOM type
> to be named parent_obj. Rename the TMP105State I2CSlave member
> accordingly and update its references; the change is purely cosmetic.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/sensor/tmp105.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
> index 6069c0905d..aabeb34f08 100644
> --- a/hw/sensor/tmp105.c
> +++ b/hw/sensor/tmp105.c
> @@ -42,7 +42,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
>    */
>   struct TMP105State {
>       /*< private >*/
> -    I2CSlave i2c;
> +    I2CSlave parent_obj;
>       /*< public >*/
>   
>       uint8_t len;
> @@ -187,12 +187,12 @@ static void tmp105_read(TMP105State *s)
>           break;
>       }
>   
> -    trace_tmp105_read(s->i2c.address, s->pointer);
> +    trace_tmp105_read(s->parent_obj.address, s->pointer);
>   }
>   
>   static void tmp105_write(TMP105State *s)
>   {
> -    trace_tmp105_write(s->i2c.address, s->pointer);
> +    trace_tmp105_write(s->parent_obj.address, s->pointer);
>   
>       switch (s->pointer & 3) {
>       case TMP105_REG_TEMPERATURE:
> @@ -200,7 +200,7 @@ static void tmp105_write(TMP105State *s)
>   
>       case TMP105_REG_CONFIG:
>           if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
> -            trace_tmp105_write_shutdown(s->i2c.address);
> +            trace_tmp105_write_shutdown(s->parent_obj.address);
>           }
>           s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
>           s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
> @@ -305,7 +305,7 @@ static const VMStateDescription vmstate_tmp105 = {
>           VMSTATE_INT16(temperature, TMP105State),
>           VMSTATE_INT16_ARRAY(limit, TMP105State, 2),
>           VMSTATE_UINT8(alarm, TMP105State),
> -        VMSTATE_I2C_SLAVE(i2c, TMP105State),
> +        VMSTATE_I2C_SLAVE(parent_obj, TMP105State),
>           VMSTATE_END_OF_LIST()
>       },
>       .subsections = (const VMStateDescription * const []) {
> @@ -338,7 +338,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
>   
>       qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
>   
> -    tmp105_reset(&s->i2c);
> +    tmp105_reset(&s->parent_obj);
>   }
>   
>   static void tmp105_initfn(Object *obj)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


