Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60915CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB60q-0002s2-QA; Tue, 21 Oct 2025 02:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vB60h-0002qT-KP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:38:21 -0400
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vB60d-0000Wf-EA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 02:38:19 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.1])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4crN0H5vnHz5wPX;
 Tue, 21 Oct 2025 06:38:07 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 21 Oct
 2025 08:38:06 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008bce79b10-607d-4143-8e2e-12425c97bdf8,
 2E289DBED20BDC21D191179C8FCAB8BCAFA041EF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d51ad87c-8076-4f86-b9ed-388313ae9e2d@kaod.org>
Date: Tue, 21 Oct 2025 08:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: aspeed: Split the machine definition into individual source files
To: Jamin Lin <jamin_lin@aspeedtech.com>, "'qemu-arm@nongnu.org'"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: 'Andrew Jeffery' <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Patrick
 Williams <patrick@stwcx.xyz>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
 <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
 <KL1PR0601MB419628CE287BDF2715845C4BFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <KL1PR0601MB419628CE287BDF2715845C4BFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 44204d84-942c-49e8-9bbd-16b10294d7e8
X-Ovh-Tracer-Id: 3048655475195808559
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGwSkciloGouJnZzxwIP12v0kmLDrSJ4BLaNUBKSzv7bGqDDjCBofrlVjuvrwmJqVBY7qFdzFF9gPna/8CNEysi2xc7Ll7r/IkUvzHYM9a7R3QqyhgQQASaOCcebN3pXd5AmzSOVueVe9Z+r5/qkthbkB2/+tYLFhsLS0P2YmIGRY/YQlELcc99BUU01CjZ4gyzR94Da6nHrxQaMFKZDAWphPPuDMYNBricjP1m1gCJoGDYPtEdI+1OsYYeCqVN7xSzTGM2A7AyRYoUzHouMGx52ZKu3j6JsgBKYVC1WRJDyeOOdzBt60liSMMCt+n7D72hJwqIxu55tjgHosKmCt/aM4z8opHEIC1UTXQD1xXTdqoC9cA0ES7IqVjAy3c+CNtFkW0sfXFsk1ol9x0AnJMdUs2T70FlIXMkOmwc2Nb7/AGulXnVHXGHfH4vhquZEnvQB0mUrhK8AKhD9xgoWxWs49svBDiELy88NG1l7pCm4G8/p9E68SwWsEbSEroLeGp8cgmrTiUgKeWuu5u1V8PJUxR07eBL+bPX30kWNDI7Ll0ZY2NzyAwY9m3EWREmDfdeWF6DQikbVorhzZIIbVWJ/AUHROQe0hq0jGGuD6Co2Y0npAedd47XPwRjHdzaqSFkSOtbRIbIg/KoAUAPMi0LJAHfJStW6Ms4BujxSb4Khw
DKIM-Signature: a=rsa-sha256; bh=wWTwHAHFSt01lzXeU9PXDm6bQs3oetps6Qz1SmSH97M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1761028689; v=1;
 b=GNEdz9SH718vsB2JjuuYlm4PDZCkDaGOf0/RQLb5g4IpNHiVyQb0qWUzUSw/zi7UAQWzkHiv
 tw7SULrAC+lMIwO7UL+bKt6lQEAXMQCbTQGid6lltYBMpPQ8qkugqmQcf93556qD52L2FQZxoPB
 3HF/T//g5hF1XrIzxcArej5Jr+zT06dc5ZwN0q6X6yU2yaT7MDur08BL4lDcJTdKfWyqU0mUIQh
 GGj93wegUWM21cvhIED+ecxEAEQ4oN2UdYOW9s3OgZJO7m+9VYFWJEgDlR3/lDNbW02vQ5gJW2r
 rhMO+SEd7geztzIkgkwwW+gVMeDHVGo3QOCwlatfMF8wQ==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,


> Patch series 1
> hw/arm/aspeed_ast1030_evb.c (ast1030-evb) ---> or hw/arm/aspeed_ast10x0_evb.c, then we can place (ast1030-evb and ast1060-evb)
> hw/arm/aspeed_ast27x0_evb.c (ast2700a0-evb, ast2700a1-evb)
> 
> Patch series 2
> hw/arm/aspeed_ast2400_palmetto.c (palmetto-bmc)
> hw/arm/aspeed_ast2400_quanta-q71l.c (quanta-q71l-bmc)
> hw/arm/aspeed_ast2400_supermicrox11.c (supermicrox11-bmc)
> 
> Patch series 3
> hw/arm/aspeed_ast2500_evb.c (ast2500-evb)
> hw/arm/aspeed_ast2500_romulus.c (romulus-bmc)
> hw/arm/aspeed_ast2500_sonorapass.c (sonorapass-bmc)
> hw/arm/aspeed_ast2500_witherspoon.c (witherspoon-bmc)
> hw/arm/aspeed_ast2500_yosemitev2.c (yosemitev2-bmc)
> hw/arm/aspeed_ast2500_supermicro-x11spi.c (supermicro-x11spi-bmc)
> hw/arm/aspeed_ast2500_fp5280g2.c (fp5280g2-bmc)
> hw/arm/aspeed_ast2500_g220a.c (g220a-bmc)
> hw/arm/aspeed_ast2500_tiogapass.c (tiogapass-bmc)
> 
> Patch series 4
> hw/arm/aspeed_ast2600_evb.c (ast2600-evb)
> hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c (qcom-dc-scm-v1-b mc)
> hw/arm/aspeed_ast2600_qcom-firework-bmc.c (qcom-firework-bmc)
> hw/arm/aspeed_ast2600_rainier.c (rainier-bmc)
> hw/arm/aspeed_ast2600_fuji.c (fuji-bmc)
> hw/arm/aspeed_ast2600_bletchley.c (bletchley-bmc)
> hw/arm/aspeed_ast2600_ fby35.c (fby35-bmc)
> 
> For the FBY35 platform, since it includes both AST1030 and AST2600, we may consider renaming the file to:
> hw/arm/aspeed_ast1030_ast2600_fby35.c  (hw/arm/fby35.c)

Since ast2600 is the main SoC of the fby35, "hw/arm/aspeed_ast2600_fby35.c"
should be a more relevant name.

The rest looks good to me.

Thanks,

C.


