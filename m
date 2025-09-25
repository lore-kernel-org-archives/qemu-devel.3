Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AFBCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oYu-0005Z4-Bs; Thu, 25 Sep 2025 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1oYp-0005YC-Ks
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:11:14 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1oYg-00010u-VZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:11:10 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.217])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cXdx85g5vz6Vnt;
 Thu, 25 Sep 2025 16:10:52 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 25 Sep
 2025 18:10:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0041d220c37-f387-4b7a-9b89-51f65f2aa27a,
 430B70353558F8354C2EE2D8074F991CFFE72556) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8def4bc8-4075-4e69-9838-5cb41f6610bc@kaod.org>
Date: Thu, 25 Sep 2025 18:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] hw/arm/aspeed_ast27x0-fc: Make sub-init functions
 return bool with errp
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
 <20250925050535.2657256-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250925050535.2657256-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 2ba0f404-5799-40a8-a080-56131e8096bf
X-Ovh-Tracer-Id: 7605453871737441071
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGXl+jaMsTT9SVjFZMzKB/bvUhDKnp8dzfnzeNykRC4mXxoCLgFg28hf2ud44/v9c2o0Ud0GTsvBVRqlgJaVVr8+sUJZYvGJUqsbwrymrJa0dTEKxV+S2gJDRdhVmHBCfQiKvFYha3AEgKYCUFOCBpkwg3H8xJLro8HnplSMW3sS1Q36ATa8I4ExJsq8DnDJaVHq3GMRBW7mxBl1Pejr49FXXn5WedB75kBjR/XSmrtNcNbjpVE+v/HYpzYnMMpp1C7oPgN0hLo+LeTcxdtO30C8d7ZrgHlr/N8bSbi25jqBaHb0cXE6gUxo2G8q6AE9WCDdX4dgi04+m6sg4pl4oyZXyhYWh6BSxTn0/htM0S6KOhbB93MG/nhmJcUG6inIFl1cf02F2JBh3e052KJvvmliYS8sOo5y+MWGfa5IDunwnLlzgffyLAxCr7t9lo07Qedr74ii/Rp3On6fXsr2loHLLyZcZVoIKj9/sBArIQI/sS+HsvA4n94O6R914iUBjY0hSA1QRbkPKsp4hgAEajg6a6U/M6oI93dYoSPZPaXI3tGfIGr5Dh3t9L0GThqfar/A3bqQJSN/fM1lcTPyfMgn5R8d/t64vfbvHZb4Y8JmYEXPEoE033ltiaZyICsSoj7mOCnWeIbcKZWhQUTNUy5/T9bREh/4QQ9qF687JDXJw
DKIM-Signature: a=rsa-sha256; bh=DOB6qdi2ZfFuoaYdX6kAG0MXjldLbK3f+O8uCpHSD0Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758816654; v=1;
 b=fqek1M1IraYtfku3hYFeX+YSARzteFLwWWDoyhOAxPl+gbLOcy868b5ucwS/9TlpMEXu1pU8
 6G0OhmuK5rQ02JA7AGlTJa3gfudd+3jIN5yq8wpHAlHi8q5P0QyRI6fcC3d/x/iDsdYXu8v7aaM
 62uYhqoXumc7Ql6ePSe6bQiDEiupLDFr+5anvDOC/5PeEgp4NK9+MwKOdXzf4VwKPBZcYKQk7Cr
 yketJvYC5uGVJdchNkFg+BD7enTz7V4UodSBdrX79VzwtXx6Q723qCFgNb3p7Xas9PigYDmvhSd
 JNqBqqZZnDgZ5AkSW1eYcaLaQSSCNMZHGi66rVZKtGlSw==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/25/25 07:05, Jamin Lin wrote:
> Refactor ast2700fc_ca35_init(), ast2700fc_ssp_init(), and ast2700fc_tsp_init()
> to take an Error **errp parameter and return a bool.
> Each function now reports failure through the error object and returns false.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast27x0-fc.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index ebf3784df5..2e16a0340a 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -56,7 +56,7 @@ struct Ast2700FCState {
>   #define AST2700FC_FMC_MODEL "w25q01jvq"
>   #define AST2700FC_SPI_MODEL "w25q512jv"
>   
> -static void ast2700fc_ca35_init(MachineState *machine)
> +static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
>   {
>       Ast2700FCState *s = AST2700A1FC(machine);
>       AspeedSoCState *soc;
> @@ -71,8 +71,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       memory_region_add_subregion(get_system_memory(), 0, &s->ca35_memory);
>   
>       if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
> -                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
> -        return;
> +                                AST2700FC_BMC_RAM_SIZE, errp)) {
> +        return false;
>       }
>       object_property_set_link(OBJECT(&s->ca35), "memory",
>                                OBJECT(&s->ca35_memory), &error_abort);
> @@ -92,8 +92,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
>                               AST2700FC_HW_STRAP2, &error_abort);
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
> -    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
> -        return;
> +    if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
> +        return false;
>       }
>   
>       /*
> @@ -108,9 +108,11 @@ static void ast2700fc_ca35_init(MachineState *machine)
>       ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
>   
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
> +
> +    return true;
>   }
>   
> -static void ast2700fc_ssp_init(MachineState *machine)
> +static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
>   {
>       AspeedSoCState *soc;
>       Ast2700FCState *s = AST2700A1FC(machine);
> @@ -127,12 +129,14 @@ static void ast2700fc_ssp_init(MachineState *machine)
>   
>       soc = ASPEED_SOC(&s->ssp);
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
> -    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
> -        return;
> +    if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
> +        return false;
>       }
> +
> +    return true;
>   }
>   
> -static void ast2700fc_tsp_init(MachineState *machine)
> +static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
>   {
>       AspeedSoCState *soc;
>       Ast2700FCState *s = AST2700A1FC(machine);
> @@ -149,16 +153,18 @@ static void ast2700fc_tsp_init(MachineState *machine)
>   
>       soc = ASPEED_SOC(&s->tsp);
>       aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
> -    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
> -        return;
> +    if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
> +        return false;
>       }
> +
> +    return true;
>   }
>   
>   static void ast2700fc_init(MachineState *machine)
>   {
> -    ast2700fc_ca35_init(machine);
> -    ast2700fc_ssp_init(machine);
> -    ast2700fc_tsp_init(machine);
> +    ast2700fc_ca35_init(machine, &error_abort);
> +    ast2700fc_ssp_init(machine, &error_abort);
> +    ast2700fc_tsp_init(machine, &error_abort);
>   }
>   
>   static void ast2700fc_class_init(ObjectClass *oc, const void *data)


