Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB8CD4851
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOKE6-0005N8-4T; Sat, 16 May 2026 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wOKE4-0005KP-8M
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:59:04 -0400
Received: from smtpout2.mo534.mail-out.ovh.net ([51.210.94.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wOKE2-0006LH-In
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:59:03 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gHtdR5FsTz613R;
 Sat, 16 May 2026 18:58:51 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat, 16 May 2026 18:58:51 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.44])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gHtdR01Khz7tgt;
 Sat, 16 May 2026 18:58:51 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id CBAAB12E3B34;
 Sat, 16 May 2026 18:58:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006a7c9b4b4-8660-430e-b62f-f650ce8c9147,
 A74BDF057EA0444B936764C4F05D8334868F2957) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <c8b85c06-bfdf-4483-bbc8-e07b98b91dd8@kaod.org>
Date: Sat, 16 May 2026 20:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/21] hw/arm/aspeed: Do not realize 64-bit CPU types
 under QTest
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260516171524.19184-1-philmd@linaro.org>
 <20260516171524.19184-6-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260516171524.19184-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13721060691137047597
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFflXHV1bDsDm/zTWZaC1ROu/FTGVmPD/AGJjPVbovo5Ngh37dBhTwcojhIgNygrfUFDsDrkR+p5CISoqSd+kkiRFTAU1aVKJbPqgsTWsiFGGr72hM/o4jsNmCLLAkk76/pw0RC2IDTOxsM3jyca6yzrmu+oxMJf0gKSLAKc2hFkFGZ789mTfzRJnnYeveOrifRP+2nGo2BvdANCkblSFL4Pfa9hg5gVqee0/zI0XrMOIZOJmO1HGnAE/jKEtdN3lAvZTS71Ny0hJczmwLe7IYfdAPwb7AnhuaPK0xawnrpva3O9gu25euN0Rd2m+2bx5ez0TEz8izBvvOiJrbGrwyHazbokW1Sn9H/F0Hqwd1Zd7Jp6Z4vXnrSGVFeHP4JuOvHihi6b1KwbctzAzwUFsfvgbawGoBj1wXEzPpbqamZCiFpdRo+u0RbxGf63tNGuz/ugRbrVX7tz8rh3qWoOF+lAb6aJt4Rm0aeoT97XaROjccIKyi/0YpVQr1wcW2t/ws0bfZXV9x8kHMm5+w2Z+2ePYWBJoBsmeAzBrSE9IJzqyN/Dk4q9a8USRwkOR6Cx9wv93r88++G7Z650e3v1+MzBWC6JIkmT3r+yu3aqiXJRiZkc+Q8QoeZGSKTkpzDOds6cBdPZd+P0nGvx09axDrgc9ruSj7ZkHN//KPjZU1wg
DKIM-Signature: a=rsa-sha256; bh=Fgbupl1STtfH5gUNzdQRvpHrt7pK7lTm51npEEyuWBw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778957933; v=1;
 b=qtLcqKBUools/OSZfLV2/J+0LiTjafq2GGW8z3un+JurWr3PFnRbLFqYMQB7pWLVLJ+2QsHD
 YSj27ty7uLXye/u/s9Vsxzb+kC74zi3hNR1aWe6PIFvwJ8NxEL3GP3B+imSttyY2m+v4xTPffWM
 EQhJAv4FWtFQhCQqiWGszrd/+57fqFpLHqlZtrVzuks5p8jGhW90E1u71fm9Q57UQQ9SPwUKoff
 3OUz8X9B7nnJaTKhrkgtX77OqSkRcLsaqVLGg4FOVOJvKeA5evBIX3OAlU7tNsE/NY9Nht8U+9H
 j+MqW/ADozPNWEDL284Uz4PR9WOxzzGX9enf0CVRRZdkA==
Received-SPF: pass client-ip=51.210.94.141; envelope-from=clg@kaod.org;
 helo=smtpout2.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/16/26 19:15, Philippe Mathieu-Daudé wrote:
> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
> CPU (Cortex-A35), only available in the 64-bit binary.
> 
> If we build this file as common object, these SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the init() method
> tries to init the Cortex-A35 type -- although not realizing it
> -- which is not available. Simply skip CPU initialization when
> running QTests on a 32-bit binary, asserting the realization
> step is not reached.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/arm/aspeed_ast27x0.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 87dcb82e1b0..8311902f0c7 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -18,6 +18,7 @@
>   #include "qemu/error-report.h"
>   #include "hw/i2c/aspeed_i2c.h"
>   #include "net/net.h"
> +#include "system/qtest.h"
>   #include "system/system.h"
>   #include "hw/intc/arm_gicv3.h"
>   #include "qobject/qlist.h"
> @@ -419,6 +420,15 @@ static void aspeed_soc_ast2700_init(Object *obj)
>       }
>   
>       for (i = 0; i < sc->num_cpus; i++) {
> +        if (qtest_enabled() && !target_aarch64()) {
> +            /*
> +             * Introspection qtest just want to create this object
> +             * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
> +             * is not available on 32-bit binary: skip it since we
> +             * won't even realize it.
> +             */
> +            continue;
> +        }
>           object_initialize_child(obj, "cpu[*]", &a->cpu[i],
>                                   aspeed_soc_cpu_type(sc->valid_cpu_types));
>       }
> @@ -693,6 +703,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       qemu_irq irq;
>       int uart;
>   
> +    if (qtest_enabled() && !target_aarch64()) {
> +        g_assert_not_reached();
> +    }
> +
>       /* Default boot region (SPI memory or ROMs) */
>       memory_region_init(&s->spi_boot_container, OBJECT(s),
>                          "aspeed.spi_boot_container", 0x400000000);


