Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7352EB28FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIIN-0006ft-Rw; Fri, 06 Feb 2026 04:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIIM-0006ab-61; Fri, 06 Feb 2026 04:38:34 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1voIIK-0005bD-B4; Fri, 06 Feb 2026 04:38:33 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.75])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f6ptY1YVPz5w9v;
 Fri,  6 Feb 2026 09:38:29 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 6 Feb
 2026 10:38:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002de42e544-e36a-4f38-ac08-c645ed912818,
 C2DCEC2B1261BCA5104DC73024CD17A0EB88A4A8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <53c7f3d1-a4f5-4c0e-a850-b3caa42126f6@kaod.org>
Date: Fri, 6 Feb 2026 10:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB
 machine
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260206053340.3716041-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 846c8853-d63a-4057-9134-b07b0586ff01
X-Ovh-Tracer-Id: 13156421890157349694
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGoPMn5Bnbo+pBYsJIUCc/4sB9bmUHdi1zUZ9CuPR36n5V1GfnbadXGu3/I2z79goPCEQdC6TNvmSLq8G26G+u442HzltxUnIg90qjDVbYP0gRy5iNHERSXGQmsmUGaII9u0CpADBrscAiVHxC9jVWbfLO9QkZAFpaxHegll6i8Q5BUXm9ZrTUGqLmWbLtcweTS+fOSwoXsBsi2PdqwnlxmJ9fgCFsJdXBP4p8XWbdUjcabRF4Y/n3McMDEuE3KBUYUG/celaBQj9hvfefbPgvXTIF3qt2DtjI7rtWZNK8xyVhi8AmgrGRLg3s/MYbeRGwvHhW1/M3oVnMraw45Bo37RzStKWnhzglPgVzE19/Ia82HZy9ojCM1VPYYJoq5XeyaavxVdDgZ6/fvhxroaT2hG1LcTcMilf6zEq/SgQweViO9OI1GiD5OGrojquQXTkl9wswg0+KEXSew7rNubAqmJNJsASmSmn9XZwZVQguTII1OXT2OZVcYJ15apukevLcWcnVL58+WIMtO/yt7N6jQSw4UzJ/GNFb46gZ53Gu8du6KjFZJCjGjR+R7J+GTLRRJrLWAOQaHXYdQQD4kkyfscqnmQgPLM2gfWwEtC7CSokZlhszzHviodelkA31Bt5VWfU1p0ngckDwFO2M3yX5yfY00BUpPj2i1lP6T04nOJg
DKIM-Signature: a=rsa-sha256; bh=/6Xs1r6v8I+OtRCZQoC88v1s0dRscR+rmLvS5mEUEaY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770370709; v=1;
 b=oj7G0JlG3KvUope4wqjv+GD9PB0Yuf1CdM54U3We9Z+s7ZrvATFUeazflimk9h1rdW+9irWI
 26S1+1tiVmoEoPo2hbH5M5DllshqWVbtKLThUND5DEqc20Hqwf9ZrnxqI0hP43xwPOKEYj94jKO
 wG1azXOiyugNDI223iCOuGW1yjMCfLWbTaKKfXL+W3b3+5YDFSo5MJy3bRQddCfvRBJpTGfuvFJ
 tJsPBNuSFmReQQ34Tq9VqVTAtuhs+pKfl9+YRutVDeyYeZ3YFiqZa9jFgQnsXi3OxhNPyfXkvVG
 4ilQAMH+AiDILNF774svKoGmvOiplMUMapNmwm05lLCVw==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/6/26 06:33, Jamin Lin wrote:
> Add a new AST2700 A2 EVB machine to model the newer A2 silicon.
> 
> The "ast2700-evb" machine alias is moved to the AST2700 A2 EVB, making
> it the default AST2700 evaluation board. The existing AST2700 A1 EVB
> machine remains available as "ast2700a1-evb".
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0_evb.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
> index 31f7d61117..0ff1bebeb0 100644
> --- a/hw/arm/aspeed_ast27x0_evb.c
> +++ b/hw/arm/aspeed_ast27x0_evb.c
> @@ -34,7 +34,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
>       MachineClass *mc = MACHINE_CLASS(oc);
>       AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>   
> -    mc->alias = "ast2700-evb";

Please change the machine alias in a separate patch.

Thanks,

C.


>       mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
>       amc->soc_name  = "ast2700-a1";
>       amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> @@ -50,12 +49,40 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
> +                                                    const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->alias = "ast2700-evb";
> +    mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
> +    amc->soc_name  = "ast2700-a2";
> +    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> +    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
> +    amc->fmc_model = "w25q01jvq";
> +    amc->spi_model = "w25q512jv";
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> +    amc->uart_default = ASPEED_DEV_UART12;
> +    amc->i2c_init  = ast2700_evb_i2c_init;
> +    amc->vbootrom = true;
> +    mc->default_ram_size = 2 * GiB;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
>   static const TypeInfo aspeed_ast27x0_evb_types[] = {
>       {
>           .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_ast2700a1_evb_class_init,
>           .interfaces    = aarch64_machine_interfaces,
> +    },
> +    {
> +        .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_ast2700a2_evb_class_init,
> +        .interfaces    = aarch64_machine_interfaces,
>       }
>   };
>   


