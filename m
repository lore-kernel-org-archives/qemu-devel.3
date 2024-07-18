Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAFCC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULvj-0006L2-OU; Thu, 18 Jul 2024 03:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sULvi-0006Fd-Eh; Thu, 18 Jul 2024 03:51:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sULvg-0007sC-8q; Thu, 18 Jul 2024 03:51:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPlPZ144zz4x04;
 Thu, 18 Jul 2024 17:51:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPlPT5jTJz4wxk;
 Thu, 18 Jul 2024 17:51:21 +1000 (AEST)
Message-ID: <3deb04d4-0db6-4b9b-a5c2-a2b9c329e638@kaod.org>
Date: Thu, 18 Jul 2024 09:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] aspeed/adc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3riu=OS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/18/24 08:49, Jamin Lin wrote:
> AST2700 and AST2600 ADC controllers are identical.
> Introduce ast2700 class and set 2 engines.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/adc/aspeed_adc.c         | 16 ++++++++++++++++
>   include/hw/adc/aspeed_adc.h |  1 +
>   2 files changed, 17 insertions(+)
> 
> diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
> index 68bdbc73b0..48328ef891 100644
> --- a/hw/adc/aspeed_adc.c
> +++ b/hw/adc/aspeed_adc.c
> @@ -398,6 +398,15 @@ static void aspeed_1030_adc_class_init(ObjectClass *klass, void *data)
>       aac->nr_engines = 2;
>   }
>   
> +static void aspeed_2700_adc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedADCClass *aac = ASPEED_ADC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 ADC Controller";
> +    aac->nr_engines = 2;
> +}
> +
>   static const TypeInfo aspeed_adc_info = {
>       .name = TYPE_ASPEED_ADC,
>       .parent = TYPE_SYS_BUS_DEVICE,
> @@ -430,6 +439,12 @@ static const TypeInfo aspeed_1030_adc_info = {
>       .class_init = aspeed_1030_adc_class_init, /* No change since AST2600 */
>   };
>   
> +static const TypeInfo aspeed_2700_adc_info = {
> +    .name = TYPE_ASPEED_2700_ADC,
> +    .parent = TYPE_ASPEED_ADC,
> +    .class_init = aspeed_2700_adc_class_init,
> +};
> +
>   static void aspeed_adc_register_types(void)
>   {
>       type_register_static(&aspeed_adc_engine_info);
> @@ -438,6 +453,7 @@ static void aspeed_adc_register_types(void)
>       type_register_static(&aspeed_2500_adc_info);
>       type_register_static(&aspeed_2600_adc_info);
>       type_register_static(&aspeed_1030_adc_info);
> +    type_register_static(&aspeed_2700_adc_info);
>   }
>   
>   type_init(aspeed_adc_register_types);
> diff --git a/include/hw/adc/aspeed_adc.h b/include/hw/adc/aspeed_adc.h
> index ff1d06ea91..f502f197ac 100644
> --- a/include/hw/adc/aspeed_adc.h
> +++ b/include/hw/adc/aspeed_adc.h
> @@ -18,6 +18,7 @@
>   #define TYPE_ASPEED_2500_ADC TYPE_ASPEED_ADC "-ast2500"
>   #define TYPE_ASPEED_2600_ADC TYPE_ASPEED_ADC "-ast2600"
>   #define TYPE_ASPEED_1030_ADC TYPE_ASPEED_ADC "-ast1030"
> +#define TYPE_ASPEED_2700_ADC TYPE_ASPEED_ADC "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedADCState, AspeedADCClass, ASPEED_ADC)
>   
>   #define TYPE_ASPEED_ADC_ENGINE "aspeed.adc.engine"


