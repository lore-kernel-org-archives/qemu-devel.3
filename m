Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A84C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxlJO-0000vW-8X; Sat, 22 Aug 2026 08:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wxlJN-0000uu-3T
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:59:01 -0400
Received: from smtpout2.mo536.mail-out.ovh.net ([51.210.91.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wxlJK-000449-Nv
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:59:00 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hRy0k72mSz87xv;
 Sat, 22 Aug 2026 12:58:46 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sat, 22 Aug 2026 12:58:46 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.206])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hRy0k2B1wz1xq5; Sat, 22 Aug 2026 12:58:46 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C2E392403F6C; Sat, 22 Aug 2026 12:58:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0083f942e2d-af53-4753-b6ea-97a1464eeca8,
 E8B800FEFED6146C3308969C34F18DEAE428D2DF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <5f045be6-b0c5-4332-b8dc-03bb25262679@kaod.org>
Date: Sat, 22 Aug 2026 14:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/misc/aspeed_scu: Support the second random number
 generator
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260821080408.2503092-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260821080408.2503092-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11314731116522941451
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFiu4RMswsgExA3Kh/2FF96p2+jVnc4SCoFAiFAlY0UDYv+0WUXmDs+/2XE+1Oq9IDA5z0ddV8hjPWUdtK/yNoTeiuh61TuQtBcwloPcvk/IG+ralU9BdUORgq7NZ2mIvzCuNlNzywHwDKES7PCDZo/ABF4epWQcNWrWsRON0zmLOMVW0Sd06rRJSDptE3hVYjLlSNaE8tKel3nOfqIZDYf+aDUohufsgws2RZgEj/hkB8ooaPbaSs+/9QkkFZ9txdDlDfHCrn3D0stIzejofzbxxmPXHRKpWDuLspnt5+MxXuZKwEOtvsPWjNibgNOax5IT6CBCxArNeSga4xtnJb+XwHFBrq0EZ37n84PlwLXH1EAG0uIPVPnXQ+7qjRhYCKvuy35rQ/GsQMe5yHWyEU5GOx1Z8+SiDam2wGy4FRi/8Lwmixiv63I2E2Pgw3Z7Nxk32hokKLMOOViegM2h0IEsW78CTUQ0ff/gl0xRuRqCs1EghF+NnmECX3hLL5KZdFU6whRysVM8/eAHrd+F9zxhi1O+ymBagcRyQsppeUWCf0r4/nyzHoZcqymbZRCfS2Qx6WssRTJbYfpLG4OyVtRViyayis4XbX2a383N0gxHIBMEzqMRLpsmnnsuTFiQpf1YI4FI0vHNeQKy3LGBJ27OFnN+YP+HE0OXEoAwT3LJQ
DKIM-Signature: a=rsa-sha256; bh=91xHvCxL6qS1hHNxOp74gV1uq2e5F9hh3DUAAhVqCrc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787403528; v=1;
 b=qV8LY6R1o6Sn0k8Ryc89y9X6snb090T6ZU8oBFKslyjPHvJsyZGw2vDan7IVQbG1rXwt3NIG
 lUCDPnfpUfKMGZJtoR0rGhwW4J2Oih31YeeHfyPsNHfRISusqypOZlukvOYarWYKWPubRY4/ey0
 I38FDxJUIqih2+y1q7s9brl+fr/McZjUFuC8qSIA0Uzu87jHNdQKVTXWSbdi/bU4PZz7akZI8zE
 XS+9qOnPOKh/PzONeD5CYH4M9PScN1LbiZAIkfYvql0rYFlY8RHElf7XvXYK501X0a9ev5MJ7B7
 BywiJo6VhcWBiHAhNjtHYEZXKpJgYdgl/LA/MMbPE3edQ==
Received-SPF: pass client-ip=51.210.91.11; envelope-from=clg@kaod.org;
 helo=smtpout2.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/21/26 10:04, Jamin Lin wrote:
> Implement SCU530 and SCU534, the control and data registers of the
> AST2600 second random number generator.
> 
> Per the AST2600 datasheet, only SCU530[5:0] are writable and the
> read-only SCU530[31] reports that random data is valid, which is only
> meaningful while SCU530[4] is set. Report it as set whenever SCU530[4]
> is, and initialise SCU530 to its datasheet reset value.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_scu.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index ca93c3699d..ca79a93b15 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -130,6 +130,10 @@
>   #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
>   #define AST2600_RNG_CTRL          TO_REG(0x520)
>   #define AST2600_RNG_DATA          TO_REG(0x524)
> +#define AST2600_RNG2_CTRL         TO_REG(0x530)
> +#define AST2600_RNG2_CTRL_MASK    0x3F
> +#define AST2600_RNG2_CTRL_VLD     BIT(31)
> +#define AST2600_RNG2_DATA         TO_REG(0x534)
>   #define AST2600_CHIP_ID0          TO_REG(0x5B0)
>   #define AST2600_CHIP_ID1          TO_REG(0x5B4)
>   
> @@ -679,13 +683,14 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
>           /* PLLs are always "locked" */
>           return s->regs[reg] | BIT(31);
>       case AST2600_RNG_DATA:
> +    case AST2600_RNG2_DATA:
>           /*
>            * On hardware, RNG_DATA works regardless of the state of the
>            * enable bit in RNG_CTRL
>            *
>            * TODO: Check this is true for ast2600
>            */
> -        s->regs[AST2600_RNG_DATA] = aspeed_scu_get_random();
> +        s->regs[reg] = aspeed_scu_get_random();
>           break;
>       }
>   
> @@ -756,6 +761,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
>           return;
>   
>       case AST2600_RNG_DATA:
> +    case AST2600_RNG2_DATA:
>       case AST2600_SILICON_REV:
>       case AST2600_SILICON_REV2:
>       case AST2600_CHIP_ID0:
> @@ -765,6 +771,14 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
>                         "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
>                         __func__, offset);
>           return;
> +    case AST2600_RNG2_CTRL:
> +        data &= AST2600_RNG2_CTRL_MASK;
> +        if (data & BIT(4)) {
> +            data |= AST2600_RNG2_CTRL_VLD;
> +        } else {
> +            data &= ~AST2600_RNG2_CTRL_VLD;
> +        }
> +        break;
>       }
>   
>       s->regs[reg] = data;
> @@ -803,6 +817,7 @@ static const uint32_t ast2600_a3_resets[ASPEED_AST2600_SCU_NR_REGS] = {
>       [AST2600_HUARTCLK]          = 0x000145C0,
>       [AST2600_CHIP_ID0]          = 0x1234ABCD,
>       [AST2600_CHIP_ID1]          = 0x88884444,
> +    [AST2600_RNG2_CTRL]         = 0x8000000E,
>   };
>   
>   static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)
> @@ -1122,6 +1137,7 @@ static void aspeed_ast1030_scu_reset_hold(Object *obj, ResetType type)
>       s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
>       s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
>       s->regs[PROT_KEY] = s->hw_prot_key;
> +    s->regs[AST2600_RNG2_CTRL] = 0x8000000E;
>   }
>   
>   static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *data)

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



