Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F1DC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPWO-0004fX-VA; Thu, 16 Jul 2026 13:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkPWM-0004e1-Rg; Thu, 16 Jul 2026 13:05:14 -0400
Received: from smtpout7.mo537.mail-out.ovh.net ([51.210.91.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkPWK-0006zu-Ra; Thu, 16 Jul 2026 13:05:14 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4h1KD43d6bz3xZn;
 Thu, 16 Jul 2026 17:05:08 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 17:05:08 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.71])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1KD42mPnz7tKv; Thu, 16 Jul 2026 17:05:08 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id F2F771B43D69;
 Thu, 16 Jul 2026 17:05:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00488fe6421-30a6-41fc-a6b5-881c07aaded4,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8f99f8de-6932-4220-b907-870e589ce4a5@kaod.org>
Date: Thu, 16 Jul 2026 19:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-26-82a63fead90c@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260709-catalina-upgrade-v1-26-82a63fead90c@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 1100004213061430317
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE8SopXwkcKKUM3SWchme2ME3l73XRsEAaAcQvCXOVfbWC3DKbP4fctCqH08CKQpLSBc1Wa707j54AQlTl/9q/WVQjRnmcCcJuuWtB/aaGQ2hpFflAfr7jdWI4wn1p38hLUMVXl25LPSTMzd1lYPvMM6WF09CTFjuLNsaxTRSsPMfLXlZ9hnUCVYYYdY9C3jaWTbKbu/jmVzmp1C7P3GZMoINfAyFGuvChjlbQpXOmq9CYj2hsRbppvixzt9lD/f+h+fcRlmKeaewHKOPg9fZNXYJeEYkZaBG2O3ezh0PgHi3M0bGPBfiqkvA6YB4JZ0hjBoheC05o5+VndW0SGcEe2YGgP+zoteDIIHrX7mBhW4BxlRogf2CNMbCkDWmUQVZhj9A8dIChQDHa9kKSgKxGx1WgBeONv6nlGsNCn+hrR+6Dfsqjs+U2XElv9h9Wo9XV2GTMhVvx4slF6r8I8icuiNAaNQw+n/rnggIT0+FznA/6H09KnoJfA8R0cmIoVeHtIFx28QvtrHpyy5iprHgiGIJu0diaxbD8URmjyj6psfaksZW9dzY5e8XP0UwpI5y0scK46BOa/42tcKDAdmHcdOFfBqexG4ik2nsGLZTFl6TpWaFxWfDO3Q6K8WB0W8WiL3mOdm22Gsmzm0VSGtm3/cL7vg7jTFTF4FLNzs1pdkw
DKIM-Signature: a=rsa-sha256; bh=3IJRu8aXpbOVxXRv0PNPiDmg7DQxjZJHNvAQHKAfLG8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784221510; v=1;
 b=dqfkSWKBxh1LfmJninI9usCsjbNYT3g6a+W/1sPmPZr57du84Zw4gYbELOLelqs7U2mdtfLI
 Jh2gqf6kKKwCrdRZ5I17JFkX7D8Z7E0qhOoa2fr2PpY6rmxf2o2nz39/cg75/dhylT0dGl/ZbRc
 3A0AV2ZsLNfGczqTkyI6au7YlnOkIKi4yDZrACT+H2jYNtAXFH72EnHwwfXRNP3Bu5CpIW0/1KE
 aEe0F2Ms1KDE9IfwFaM6zp78oHVULCCQUCjaHADcHq/Nc9UHPuMse6fbPq672oX4/wTeFTEP+x2
 yH5/i31KzNgxWmkxjzLqXfzi2rkaq4tCw0gmTD7XGHx6Q==
Received-SPF: pass client-ip=51.210.91.26; envelope-from=clg@kaod.org;
 helo=smtpout7.mo537.mail-out.ovh.net
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

On 7/9/26 17:23, Emmanuel Blot wrote:
> THIS PATCH IS ALREADY PART OF THE ADC128D818 SERIES
> WILL BE REMOVED BEFORE FINAL REVIEW
> 
> Slaves created with i2c_slave_create_simple() were left unparented and
> showed up under /machine/unattached with no stable QOM path. Add each
> slave as a QOM child of its bus, named after its I2C address, so it has
> a deterministic and addressable QOM path.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> (cherry picked from commit f55644fa78777e52fd90efaa59dd89b4ff0a7020)

you can drop these

> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/i2c/core.c        | 3 +++
>   include/hw/i2c/i2c.h | 7 +++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 54f6bdca882..0bbce45d48d 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
>   {
>       I2CSlave *dev = i2c_slave_new(name, addr);
>   
> +    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
> +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
> +

This can not be merged yet. Discussions are in progress.

See :

   Call to clean up QOM onboard devices lacking a parent
   https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org/

and

   [RFC PATCH 000/134] qom: Make composition-tree parenting mandatory
   https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com/

It isn't as precise  as a QOM path :

     IOEXP0_QOM = "/machine/soc/i2c/bus[2]/aspeed.i2c.bus.2/0x20"

but it simplifies the device lookups.

C.

>       i2c_slave_realize_and_unref(dev, bus, &error_abort);
>   
>       return dev;
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index dd5930f4b5e..dc557bbf3f2 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -166,13 +166,16 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
>   I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>   
>   /**
> - * Create and realize an I2C slave device on the heap.
> + * Create and realize an I2C slave device on the heap, add the device as a
> + * child of its parent bus.
> + *
>    * @bus: I2C bus to put it on
>    * @name: I2C slave device type name
>    * @addr: I2C address of the slave when put on a bus
>    *
>    * Create the device state structure, initialize it, put it on the
> - * specified @bus, and drop the reference to it (the device is realized).
> + * specified @bus, parent it, and drop the reference to it (the device is
> + * realized).
>    */
>   I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
>   
> 


