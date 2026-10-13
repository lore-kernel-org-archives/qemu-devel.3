Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AECCC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfLL-0005Ch-Ts; Tue, 13 Oct 2026 12:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfKy-00051e-Sc; Tue, 13 Oct 2026 12:26:52 -0400
Received: from smtpout4.mo536.mail-out.ovh.net ([51.210.91.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfKu-00052M-Ou; Tue, 13 Oct 2026 12:26:47 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j408c26nFz821T;
 Tue, 13 Oct 2026 16:26:39 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:26:39 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.184])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j408b4Wrpz1xp2; Tue, 13 Oct 2026 16:26:39 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5C7E9202CA3; 
 Tue, 13 Oct 2026 16:26:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003478d24aa-79d8-42c0-9ce9-5944aa59226e,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <beae2a33-7a72-420c-a82d-6c33f6b2bfda@kaod.org>
Date: Tue, 13 Oct 2026 18:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/50] hw/i2c: pca954x: migrate mux state
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
 <20261012-bmc-minerva-v2-6-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-6-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6611002781404015661
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEy2TVmIGdJz9wb2lZxs6ZOYk0T6DuDjUbu8/zXGYTH4fUECEqloGjFfQQCwGTA+Qh7f8ykczPwXj/0yRHFk+ke0Oq8cqPzvgWUWqE52q4F8K7KHMRomHayz0KSPI3Kj1OS1RB4ltUXcr9VLwn8YMxu6kumcdPsPn14jLrFeI22oREKqPhMU2SvVrQ8KaXHRxjVPvt64nha3KIPtHpiy9r9K5jkCxjkBrKxyaee8ty7LwZMq0oVcVbO7WlIGgJOp6cyTRlPBQhZa3PdT41/UEK/QPowtMJd7DrnTJlu2XG9nN1MD1oRi9XLbB1T/tzjDKh80+WtaijTeEgascMvqUOAo8wlyyKTE58vv6KdWC3BynA6DoXlQpwBWKjXC6PHsZiFI1iWvgj3Ykgb8hiDVDl+zD1d8hjHIIm3GfXNkG5dnG/juHWFkyygybmMyfrlnpERMoJSZ3m7vdRKt96IZwtGefdGybqWcLi4andx/Fukcw/9osAeaf225phPoJgRhi5c1HnWFg58ETzbY13m9vPF1z3P7hMFAx33fXnZjVNh9FWG5DNKEzWPVoMB88Y/UDqDUOY9tr5eadOKTNum/KKVf6pqbNurNRTTm2fA8yJCSpewNbwkdZ+9eJhWiMJzLhPHEHXN4tezCr4R8AXcU2hFadNsluasUEOqrwrRrNPvVw
DKIM-Signature: a=rsa-sha256; bh=vFIVezBGVrvD+tdflbN0Ri2lqEKKJxPozYcGL9BLBWQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908801; v=1;
 b=PrWo0i5YEskEY7A3lITyzMHk6MRKR2YTo4aVsU6oNNFzr7LLggTG8LHsX928AjjMuTG3btep
 rjOFRAwuwxlZFVso8UI74aI8U2Akd1ZvH7Oa+y/Jp0l2JkSDUqKbBetAyScN4rBl/p2b1FeWdfh
 zn9NW5FmSfww1QcrleANrEOwJ0eTe39llZwxmYE8Abtc/S/OJ7rlDTe19x57lnNcwshGgXrVzOO
 6IJ6Zde1DSl4jmrrQ4jG0AfBWi6S8aFBpZ5eeu7ea8rj1CJgiwEDQA0WWVq6JIOVkj8eN7EqJIq
 tcTMu5Y9HFfIEHKlSDXs4mhKiySEfXCBLApptuOcyJ2rg==
Received-SPF: pass client-ip=51.210.91.13; envelope-from=clg@kaod.org;
 helo=smtpout4.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> The pca954x model had no VMStateDescription, so neither the channel
> selection nor the PCA9545 interrupt status survived a migration.
> 
> This changes the migration stream of the pre-existing PCA9546 and
> PCA9548, which an older QEMU rejects.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/i2c/i2c_mux_pca954x.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index 4bb078a03c..597e57d99a 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -28,6 +28,7 @@
>   #include "hw/core/irq.h"
>   #include "hw/core/qdev.h"
>   #include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
>   #include "qemu/log.h"
>   #include "qemu/queue.h"
>   #include "qom/object.h"
> @@ -270,6 +271,28 @@ static void pca954x_init(Object *obj)
>       }
>   }
>   
> +static int pca954x_post_load(void *opaque, int version_id)
> +{
> +    Pca954xState *s = PCA954X(opaque);
> +
> +    pca954x_enable_channel(s, s->control);
> +    qemu_set_irq(s->int_out, s->int_status == 0);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_pca954x = {
> +    .name = "pca954x",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = pca954x_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(parent, Pca954xState),
> +        VMSTATE_UINT8(control, Pca954xState),
> +        VMSTATE_UINT8(int_status, Pca954xState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static const Property pca954x_props[] = {
>       DEFINE_PROP_STRING("name", Pca954xState, name),
>   };
> @@ -287,6 +310,7 @@ static void pca954x_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "Pca954x i2c-mux";
>       dc->realize = pca954x_realize;
> +    dc->vmsd = &vmstate_pca954x;
>   
>       k->write_data = pca954x_write_data;
>       k->receive_byte = pca954x_read_byte;
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


