Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01588D3B980
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0NE-000169-5g; Tue, 09 Dec 2025 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vT0N2-00013L-OT
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:15:26 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vT0N0-0007Xt-HZ
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:15:24 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.180])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dQkTg1J0fz5w1J;
 Tue,  9 Dec 2025 16:15:19 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Dec
 2025 17:15:18 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0052033c54e-d333-455f-bd97-a2033c44769a,
 913B1D19E2E265D49699B36B6A33E6F0AA87D788) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5453c8c8-f923-4d46-9b32-d6962b9eccde@kaod.org>
Date: Tue, 9 Dec 2025 17:15:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/arm/aspeed_ast27x0: Wire SGPIO controller to
 AST2700 SoC
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, <qemu-arm@nongnu.org>
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
 <20251209-aspeed-sgpio-v2-5-976e5f5790c2@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251209-aspeed-sgpio-v2-5-976e5f5790c2@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0e1ef497-9897-45e1-9735-93707e4e3887
X-Ovh-Tracer-Id: 5410793478821219134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEzraO8sZVZrKBWf2P8+FZv+Sm9va4Xk2cnYOUkElsmfiPwMnIdvlUThoymgWogo0+wcqPve4aUo+LeH/GfOUiyEaUUElWmpiamSg1xWYIV5ThknytojrKFcg/6rLYN1Ri395nkFfov3zm76rWVU/G08+DCil3Xc2Ea5QXyGM7SL/c4BAhtWa+uwqZgpSQyyUpYOSJ9HLxv0UUQTpPChNYZuHk4d+IeN1aY+K0n2NkkoNMdvtQBgqgQ0SLXMwPhn86XWZ1rk/ZP/AtpCp3RQOc5JXbGAw76YiMhRUhnisYutuVe+JWQCeGVRkVYg2KHZVLUXk9bHT/6XjVOCdoJ68CBdA5xX059vdjwP82rjiKbiNHv8wcllx5dEbkE0rxfvzw+VXG1xL4OYlIQBNhOt3a+JWzIDNzGQocrw1opv08o06hz3tljH8O3pbb1hGWSNY9RVEL9vlON9ivyRGavOaV7silw5H6/S8o2jJnS25E3nvGuTFYqnhcK8YntyLT3s6/mQgP/Mc5zVrza7g0bBeWNIt4wrbT94cgwog7RZC20Gd/woRxM/tqZnyhU2aZ2LmdZtY80ypg3Id6oYbVL7HirUVJGgejQPx7SkcQhxsdiBCQ+vAeZAX++UE4bUZvjEIHncWn1VIslVuZYQb/jJmbK83o/9DgogdRsgclGKzkjZA
DKIM-Signature: a=rsa-sha256; bh=D9bYEsONgClFyZ1GOcHseMgw9Z4I2U8CaMF3dnOAJzk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1765296919; v=1;
 b=O84F1BN3W20iTrtwIqAo2g1G92DKa0SyQTB6s+2piEF2Te3KsQk3dynpJoxvQpgvp2q9GNjS
 6YPs7qLmUQIlyvmBJ2r1jToVQqVxhY3Z+hzKQx8PTj0OHlesurK8cGkypZMGnLHrMuS11VEvMpZ
 NfrzyiWoq4Gxbiy1EWmo2KYU+9bDL7sC7zk1Atb+bzWlBSDg9rApd6apMj/qMOohSTHCjbTls97
 visT01hlGV5pKhB/rIVa+FLLMabsOLtSqcXnHlCilCEXeQhFlHeM7C2NHlPa5E6z2eshpgmG2U7
 DvSexAUjxi2MCPbSZuxFZn7ddF9mfLazwTPslptUayUkw==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/9/25 01:01, Yubin Zou wrote:
> This commit integrates the Aspeed SGPIO controller into the AST2700
> 
> Signed-off-by: Yubin Zou <yubinz@google.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index e5f04bd16e80696e41005d9062a6df6d060b8088..787accadbecae376d0c747d054ec6372785375b1 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -519,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
>       object_initialize_child(obj, "gpio", &s->gpio, typename);
>   
> +    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
> +    }
> +
>       object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
>   
>       snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
> @@ -973,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
>                          aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
>   
> +    /* SGPIO */
> +    for (i = 0; i < sc->sgpio_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
> +                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
> +    }
> +
>       /* RTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
>           return;
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

