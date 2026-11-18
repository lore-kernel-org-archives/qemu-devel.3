Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143B606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=JL/60RH8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeoX-0004QX-W4; Wed, 18 Nov 2026 07:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTeoW-0004QB-A7
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:31:00 -0500
Received: from smtpout5.mo540.mail-out.ovh.net ([51.210.91.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTeoU-0000AL-CR
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:31:00 -0500
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4jV1Cy0zgvz48CF;
 Wed, 18 Nov 2026 12:30:53 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 18 Nov 2026 12:30:53 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.85])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jV1Cx45CPz6Mf2; Wed, 18 Nov 2026 12:30:53 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1AD311B44358;
 Wed, 18 Nov 2026 12:30:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002e5967198-71d8-457a-8ba8-03ba1826720e,
 240B2D80E6D5B5AB1626C6D871A46C45E5CC6673) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d75745df-6d12-48c8-92cf-f208eedc75f3@kaod.org>
Date: Wed, 18 Nov 2026 13:30:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] hw/misc/aspeed_scu: Add SCU support for SSP
 SDRAM remap
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
 <20260723022300.4174471-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260723022300.4174471-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11132053857761274995
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE+yYwPeOQUBpqCfX+NtzdrKpS8ih9orBm/pjP+tx2ZxppK1uLKgSxgRAeGTeVJ7mXbSUnE1sp0hwSeKBRONZjE31yL6v/QmXzxhc81jmDOzRDKr29bg6Tx9beH9up6BYsIRCcyDCexJU8vjkKWG8iP3hDxkk5nggV8EDYYETnR+FlAnmo1LSAa51Ia2URkLQBChDYQP/XlJ2Y1jiDP3HtZ25NJHFHm4dDQfoP2v2zxNu565IximcELaEdVHR4s9DIKuw62uh/7LuKKBCfKYh59qbjPW41g55oGlxYO7fS9qOCf9w4Y1PSc7R+6vhcwKdLNOTGQqnd+Me7KpWRT1g/2ch5M+BwoCKpV0ouBPvSXLmvsii9Gug+FMaMTn9r8HikDmmkPxs+BZOj3LTGfXES4Vzhh4HL8gMzODHwR3tC1wJIeckZprkSgS5MEPtLwSIUsGSq/XP9OJ/AnUmwM+8p3aswtrWo9+EUTvLyED3042WdmfCHorIXdESOHLTguWiX2KVCAtUauUncAHw0rDjtgdnJm1hPKcDz5W1icbQvHQfg7zycAXm49LKzed6F82mC+sByiM08qovroNI4WLuSI/SzJ2o9Tc7nuVi15RGyaUEhdyvpmXnRVjU4J3gUyPdXhy1l0dON01GuL1HjHPEmXGPi1dphwW/QCpsSVfAtplQ
DKIM-Signature: a=rsa-sha256; bh=RpqjKO83VIn7jBkK/vgtZxAOiKKukaheSy1wFhwX1Bk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795005055; v=1;
 b=JL/60RH8hbqUnYHGoQX3oDHXN0DgAU9MHmnSAAj9bDtmUJC48XKzacxd7pSykj2a8SZe+FJR
 6EGltKEjcE0z2Ko33nMtHY+AoDAUGbhGeD0HxeUhbcLTujkbFmHu5OX6SjzXWpJI80knxxE8cMk
 Uc+pYHwYDRbHM0pVa0Ed0oY0WszIthXkeyZ8QmpzZdvKUYr/McYs80UnVuMk0pdY0bZAcUAcwLu
 A/y5eeowpyy0A+ogz9REPZIya1glZJH/fxyTBsw/sv6X7m0tBgLpDTUhf+OkavjUuzf63HGFHmD
 12Kj/uQDjpQJhGEW80NSAV2ld6HMHyBLmMGMYUVPiEz1Q==
Received-SPF: pass client-ip=51.210.91.54; envelope-from=clg@kaod.org;
 helo=smtpout5.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 7/23/26 04:23, Jamin Lin wrote:
> This commit adds SCU register support for SSP SDRAM remap control and runtime
> activation. It introduces logic for the PSP to dynamically configure the mapping
> of its own DRAM windows into SSP-visible SDRAM space, enabling shared memory
> communication via memory region aliases.
> 
> - coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 0x1A77E000) to SSP SDRAM
>      offset 0x5880000
> - coprocessor_sdram_remap[1]: maps PSP DRAM offset 0x42C000000 (size: 0x05880000) to SSP SDRAM
>      offset 0x0
> 
> The SCU registers AST2700_SCU_SSP_CTRL_1/2 and
> AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfiguration
> of alias offset, base, and size.
> 
> |------------------------------------------|         |----------------------------|
> |               PSP DRAM                   |         |        SSP SDRAM           |
> |------------------------------------------|         |----------------------------|
> | 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000                |
> |   remap1 base                            |---| |   |  - SCU_150: target addr    |
> |   size: 0x1A77E000 (SCU_14C)             |   | |   |    remap2                  |
> |------------------------------------------|   | |   |----------------------------|
> |                                          |   | |   |                            |
> | 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x5880000                  |
> |   remap2 base                            |   |     |  - SCU_148: target addr    |
> |   size: 0x05880000 (SCU_154)             |   |---> |    remap1                  |
> |------------------------------------------|         |----------------------------|
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/misc/aspeed_scu.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index fdb1cf59b4..407c1743fc 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -146,6 +146,14 @@
>   
>   /* SSP TSP */
>   #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)
> +#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)
> +#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)
> +#define AST2700_SCU_SSP_REMAP_ADDR_0    TO_REG(0x140)
> +#define AST2700_SCU_SSP_REMAP_SIZE_0    TO_REG(0x144)
> +#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)
> +#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)
> +#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)
> +#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
>   #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)
>   #define AST2700_SSP_TSP_ENABLE          BIT(0)
>   #define AST2700_SSP_TSP_RST             BIT(1)
> @@ -908,6 +916,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
>   {
>       Aspeed2700SCUState *a = ASPEED_2700_SCU(opaque);
>       AspeedSCUState *s = ASPEED_SCU(opaque);
> +    MemoryRegion *mr = NULL;
>       int reg = TO_REG(offset);
>       /* Truncate here so bitwise operations below behave as expected */
>       uint32_t data = data64;
> @@ -965,6 +974,43 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
>           data &= ~AST2700_SSP_TSP_ENABLE;
>           s->regs[reg] = (s->regs[reg] & ~0xff) | (data & 0xff);
>           return;
> +    case AST2700_SCU_SSP_CTRL_1:
> +    case AST2700_SCU_SSP_CTRL_2:
> +        mr = (reg == AST2700_SCU_SSP_CTRL_1) ?
> +             a->ssp_remap[0] : a->ssp_remap[1];
> +        if (a->ssp_cpuid < 0 || mr == NULL) {
> +            return;
> +        }
> +        data &= 0x7fffffff;
> +        memory_region_transaction_begin();
> +        memory_region_set_alias_offset(mr,
> +                                       ((uint64_t) data << 4) & 0x3ffffffff);
> +        memory_region_transaction_commit();
> +        break;
> +    case AST2700_SCU_SSP_REMAP_ADDR_1:
> +    case AST2700_SCU_SSP_REMAP_ADDR_2:
> +        mr = (reg == AST2700_SCU_SSP_REMAP_ADDR_1) ?
> +             a->ssp_remap[0] : a->ssp_remap[1];
> +        if (a->ssp_cpuid < 0 || mr == NULL) {
> +            return;
> +        }
> +        data &= 0x3fffffff;
> +        memory_region_transaction_begin();
> +        memory_region_set_address(mr, data);
> +        memory_region_transaction_commit();
> +        break;
> +    case AST2700_SCU_SSP_REMAP_SIZE_1:
> +    case AST2700_SCU_SSP_REMAP_SIZE_2:
> +        mr = (reg == AST2700_SCU_SSP_REMAP_SIZE_1) ?
> +             a->ssp_remap[0] : a->ssp_remap[1];
> +        if (a->ssp_cpuid < 0 || mr == NULL) {
> +            return;
> +        }
> +        data &= 0x3fffffff;
> +        memory_region_transaction_begin();
> +        memory_region_set_size(mr, data);
> +        memory_region_transaction_commit();
> +        break;
>       case AST2700_SCU_SYS_RST_CTRL_1:
>           if (a->ssp_cpuid < 0) {
>               return;
> @@ -1035,6 +1081,14 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
>       [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
>       [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
>       [AST2700_SCU_SSP_CTRL_0]        = 0x000007FE,
> +    [AST2700_SCU_SSP_CTRL_1]        = 0x40000000,
> +    [AST2700_SCU_SSP_CTRL_2]        = 0x42C00000,
> +    [AST2700_SCU_SSP_REMAP_ADDR_0]  = 0x1FFFE000,
> +    [AST2700_SCU_SSP_REMAP_SIZE_0]  = 0x00002000,
> +    [AST2700_SCU_SSP_REMAP_ADDR_1]  = 0x05880000,
> +    [AST2700_SCU_SSP_REMAP_SIZE_1]  = 0x1A77E000,
> +    [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
> +    [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x05880000,
>       [AST2700_SCU_TSP_CTRL_0]        = 0x000007FE,
>       [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
>       [AST2700_SCU_SYS_RST_CTRL_2]    = 0x00001FFF,
> @@ -1067,6 +1121,14 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)
>   
>       if (a->ssp_cpuid > 0) {>           arm_set_cpu_off(a->ssp_cpuid);

+        if (a->ssp_remap[0] && a->ssp_remap[1]) {

> +        memory_region_transaction_begin();
> +        memory_region_set_address(a->ssp_remap[0], 0x5880000);
> +        memory_region_set_alias_offset(a->ssp_remap[0], 0);
> +        memory_region_set_size(a->ssp_remap[0], 0x1a77e000);
> +        memory_region_set_address(a->ssp_remap[1], 0);
> +        memory_region_set_alias_offset(a->ssp_remap[1], 0x2c000000);
> +        memory_region_set_size(a->ssp_remap[1], 0x5880000);
> +        memory_region_transaction_commit();
>       }
>   
>       if (a->tsp_cpuid > 0) {


