Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8425FCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl8RK-0005fZ-5H; Mon, 02 Sep 2024 10:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl8RI-0005XM-7D; Mon, 02 Sep 2024 10:53:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl8RF-0007si-RG; Mon, 02 Sep 2024 10:53:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WyBbH3jR4z4xD7;
 Tue,  3 Sep 2024 00:53:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WyBbB1QxRz4w2R;
 Tue,  3 Sep 2024 00:53:22 +1000 (AEST)
Message-ID: <935912ca-d664-4543-8d82-e8a32ebf78c5@kaod.org>
Date: Mon, 2 Sep 2024 16:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] aspeed/soc: introduce a new API to get the INTC
 orgate information
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240808024916.1262715-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3a9v=QA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jamin,

On 8/8/24 04:49, Jamin Lin wrote:
> Currently, users can set the intc mapping table with
> enumerated device id and device irq to get the INTC orgate
> input pins. However, some devices use the continuous bits number in the
> same orgate. To reduce the enumerated device id definition,
> create a new API to get the INTC orgate index and source bit number
> if users only provide the start bus number of device.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4257b5e8af..0bbd66110b 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -164,6 +164,11 @@ struct gic_intc_irq_info {
>       const int *ptr;
>   };
>   
> +struct gic_intc_orgate_info {
> +    int index;
> +    int int_num;
> +};
> +
>   static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
>       {128,  aspeed_soc_ast2700_gic128_intcmap},
>       {129,  NULL},
> @@ -193,6 +198,27 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
>       return qdev_get_gpio_in(DEVICE(&a->gic), sc->irqmap[dev]);
>   }
>   
> +static void aspeed_soc_ast2700_get_intc_orgate(AspeedSoCState *s, int dev,
> +    struct gic_intc_orgate_info *orgate_info)
> +{
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
> +        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
> +            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
> +            orgate_info->index = i;
> +            orgate_info->int_num = aspeed_soc_ast2700_gic_intcmap[i].ptr[dev];
> +            return;
> +        }
> +    }
> +
> +    /*
> +     * Invalid orgate index, device irq should be 128 to 136.
> +     */
> +    g_assert_not_reached();
> +}
> +
>   static uint64_t aspeed_ram_capacity_read(void *opaque, hwaddr addr,
>                                                       unsigned int size)
>   {

Here is a proposal, instead please introduce a routine returning
a qemu_irq like sc->get_irq() does :

   static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
                                                    int index)
   {
       Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
       int i;

       for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
           if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
               assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
               return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
                    aspeed_soc_ast2700_gic_intcmap[i].ptr[dev] + index);
           }
       }

       /*
        * Invalid orgate index, device irq should be 128 to 136.
        */
       g_assert_not_reached();
   }

and in the next patch, replace

         irq = qdev_get_gpio_in(DEVICE(&a->intc.orgates[orgate_info.index]),
                                orgate_info.int_num + i);
with

         irq = aspeed_soc_ast2700_get_irq_index(s, ASPEED_DEV_I2C, i);

I think this should be cleaner.

Thanks,

C.



