Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C82606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=EFiEdeX9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTemv-0003TM-DK; Wed, 18 Nov 2026 07:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTemo-0003ST-W7
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:29:15 -0500
Received: from 9.mo2.mail-out.ovh.net ([46.105.35.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTemm-0001Ny-N7
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:29:14 -0500
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4jV19x27Jzz41r2;
 Wed, 18 Nov 2026 12:29:08 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 18 Nov 2026 12:29:08 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.215])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jV19w39b4z6Mf1; Wed, 18 Nov 2026 12:29:08 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 ECF9E192430C; Wed, 18 Nov 2026 12:29:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0023684ecf6-57d2-4915-b93e-d256a9b981ef,
 240B2D80E6D5B5AB1626C6D871A46C45E5CC6673) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fec7776d-c42b-486c-9d0c-25ea0747bc50@kaod.org>
Date: Wed, 18 Nov 2026 13:29:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
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
 <20260723022300.4174471-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260723022300.4174471-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11102498982587182195
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTElsT/MGqXBoO+3rc6JifCZ6AAyxABAWpoxFnRVrstV8/mBb/GPKn1D7O9/wYDB/UJ4Z9537oQZB5GHqL4wovDAzV1eikAf2xaqp5dgP7Rp6ii4g5YDT8Tz7GcXVMz2GZPZe9daQJsryVSI9kTakJKv3UJczXLyOrVE6/VxMfBwKewTBqMnmNpzdg3+SWyBSx23oMgNfMRjJWHIbXFhw39Q/ontf9PI8JkmYurQE9Wlanly0p7Ina2wQiFss1XQ7HKfdP+ooO5xf3ZunUoRDYcc+D3sAOAu7mb5aLa3IJsBeVbLmV2L/f0KHDINpTvlUw/P7tZowZb+QT9Y+zga3h3BkIoXzhNiqyB0cHaqkFbt1SlMDDflPfDkdsLJjOQ1ebxwzQw1QoCjI067572SANljUzKEp2TIIq/mB47icnEGk0m4eJQ8cu2zlPO1kRzRs0FaJGu8eqifQnNcydrqHeIItz735GZpXm4dVKK5LrzL95+vMtUx5JYX9eujVWoOr5AMirwZL4A//vW7+CAfQ8qj4UERokhb0Cv0UqWATIFLACUIBcRMxJCf1WmTV6X/+aWKzbop8JffOzBFYFi/zoBvbsd6dQDt+PJBmtwOdXUf3sQRJM+hBMZ7RUo3HrpamgPIF/un87Z+EPHMSu+lDZRYjGDE4UJcox4Cohln9nfsEw
DKIM-Signature: a=rsa-sha256; bh=Eo5ZPPM2AKEjNfqXn5MfPxFIIYJd6SG2PWAk3tVOA3Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795004950; v=1;
 b=EFiEdeX9HMUXaPv2KiyYHKDVTmzMhZoo2SHVnf2u32n450tB4h46SJijj2FuMC/zYL8u+Pay
 Vn8/6x4/sxBC/OqJR1XWCXO+MiQ+c4m+SfvNqjNPDVyqEr0IU2um6ZpM758BnOU5OYz05FhusXz
 NXdJ4aIHNPvj4IJb3WLDmq95dbWnEerej00QctE2PdAYaZ5uelH3wK4bmKH4pQaGx4PeOAZ9Ijd
 UqktEmmuyoESqsQqLsTLSz1ZqoV0aQiM/VfOg3WRCXxK7kG/xXWViN4cGv3CPs6PV79+Ym2mvul
 fjQ6C6/5J6Mt01zke3XTwcFDFcsBciU4+mfOigd+h04wA==
Received-SPF: pass client-ip=46.105.35.181; envelope-from=clg@kaod.org;
 helo=9.mo2.mail-out.ovh.net
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
> This patch implements SSP reset and power control logic in the SCU for AST2700.
> It introduces support for the following behavior:
> 
> 1. SSP Reset Trigger (via SCU 0x200):
>     - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL_1.
> 
> 2. SSP Reset State and Source Hold (via SCU 0x120):
>     - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.
>     - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an external source.
>     - Bit 1 (RST) is a software-controlled bit used to request holding SSP in reset.
>     - If an external reset source is present and bit 1 is set, bit 9 (RST_HOLD_RB)
>       will also be asserted to indicate the SSP is being held in reset.
>     - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.
> 
> 3. Hold Release and Power-on:
>     - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset is deasserted.
>     - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_CTRL_0 to release
>       the hold and power on SSP explicitly.
>     - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear after execution.
> 
> 4. Reset Status Clear (via SCU 0x204):
>     - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_RST_CLR_1,
>       which will deassert RST_SRC_RB and potentially trigger power-on if no hold is active.
> 
> 5. SSP Power Control Logic:
>     - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and invokes
>       `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).
>     - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, also asserts
>       RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.
> 
> 6. Register Initialization and Definitions:
>     - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (0x200),
>       and SYS_RST_CLR_1 (0x204).
>     - Updates the reset values for these registers during SCU initialization.
> 
> The default values are based on EVB (evaluation board) register dump observations.
> This patch enables proper modeling of SSP lifecycle management across reset,
> hold, and power-on states for the AST2700 SoC.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/misc/aspeed_scu.c | 109 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 109 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 5d34dbea5e..0fdeaf5648 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -20,6 +20,7 @@
>   #include "qemu/guest-random.h"
>   #include "qemu/module.h"
>   #include "trace.h"
> +#include "target/arm/arm-powerctl.h"
>   
>   #define TO_REG(offset) ((offset) >> 2)
>   
> @@ -143,6 +144,17 @@
>   #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)
>   #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)
>   
> +/* SSP TSP */
> +#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)
> +#define AST2700_SSP_TSP_ENABLE          BIT(0)
> +#define AST2700_SSP_TSP_RST             BIT(1)
> +#define AST2700_SSP_TSP_RST_RB          BIT(8)
> +#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)
> +#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)
> +#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)
> +#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)
> +#define AST2700_SCU_SYS_RST_SSP         BIT(30)
> +
>   #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
>   #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
>   #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)
> @@ -841,6 +853,35 @@ static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
>       asc->ops = &aspeed_ast2600_scu_ops;
>   }
>   
> +static void handle_2700_ssp_tsp_on(struct AspeedSCUState *s, int cpuid,
> +                                   int reg)
> +{
> +    uint32_t val = s->regs[reg];
> +
> +    val &= ~AST2700_SSP_TSP_RST_SRC_RB;
> +    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {
> +        val &= ~AST2700_SSP_TSP_RST_RB;
> +        arm_set_cpu_on_and_reset(cpuid);
> +    }
> +
> +    s->regs[reg] = val;
> +}
> +
> +static void handle_2700_ssp_tsp_off(struct AspeedSCUState *s, int cpuid,
> +                                    int reg)
> +{
> +    uint32_t val = s->regs[reg];
> +
> +    val |= AST2700_SSP_TSP_RST_RB;
> +    val |= AST2700_SSP_TSP_RST_SRC_RB;
> +    if (val & AST2700_SSP_TSP_RST) {
> +        val |= AST2700_SSP_TSP_RST_HOLD_RB;
> +    }
> +    arm_set_cpu_off(cpuid);
> +
> +    s->regs[reg] = val;
> +}
> +
>   static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
>                                           unsigned size)
>   {
> @@ -861,10 +902,14 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
>   static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
>                                        uint64_t data64, unsigned size)
>   {
> +    Aspeed2700SCUState *a = ASPEED_2700_SCU(opaque);
>       AspeedSCUState *s = ASPEED_SCU(opaque);
>       int reg = TO_REG(offset);
>       /* Truncate here so bitwise operations below behave as expected */
>       uint32_t data = data64;
> +    uint32_t active;
> +    uint32_t oldval;
> +    int cpuid;
>   
>       if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> @@ -876,6 +921,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
>       trace_aspeed_ast2700_scu_write(offset, size, data);
>   
>       switch (reg) {
> +    case AST2700_SCU_SSP_CTRL_0:
> +        cpuid = a->ssp_cpuid;
> +        if (cpuid < 0) {
> +            return;
> +        }
> +        oldval = s->regs[reg];
> +        data &= 0xff;
> +        active = oldval ^ data;
> +
> +        /*
> +         * If reset bit is being released (1 -> 0) and no other reset source
> +         * is active, clear HOLD_RB and power on the corresponding CPU.
> +         */
> +        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST)) {
> +            s->regs[reg] &= ~AST2700_SSP_TSP_RST_HOLD_RB;
> +            if ((oldval & AST2700_SSP_TSP_RST_RB) &&
> +                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {
> +                handle_2700_ssp_tsp_on(s, cpuid, reg);
> +            }
> +        }
> +
> +        /*
> +         * If ENABLE bit is newly set and reset state is ready,
> +         * clear HOLD_RB and power on the corresponding CPU.
> +         */
> +        if ((active & AST2700_SSP_TSP_ENABLE) &&
> +            (oldval & AST2700_SSP_TSP_RST_RB) &&
> +            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&
> +            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {
> +                s->regs[reg] &= ~AST2700_SSP_TSP_RST_HOLD_RB;
> +                handle_2700_ssp_tsp_on(s, cpuid, reg);
> +        }
> +
> +        /* Auto-clear the ENABLE bit (one-shot behavior) */
> +        data &= ~AST2700_SSP_TSP_ENABLE;
> +        s->regs[reg] = (s->regs[reg] & ~0xff) | (data & 0xff);
> +        return;
> +    case AST2700_SCU_SYS_RST_CTRL_1:
> +        if (a->ssp_cpuid < 0) {
> +            return;
> +        }
> +        if (data & AST2700_SCU_SYS_RST_SSP) {
> +            handle_2700_ssp_tsp_off(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_0);
> +        }
> +        s->regs[reg] |= data;
> +        return;
> +    case AST2700_SCU_SYS_RST_CLR_1:
> +        if (a->ssp_cpuid < 0) {
> +            return;
> +        }
> +        oldval = s->regs[AST2700_SCU_SYS_RST_CTRL_1];
> +        active = data & oldval;
> +        if (active & AST2700_SCU_SYS_RST_SSP) {
> +            handle_2700_ssp_tsp_on(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_0);
> +        }
> +        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &= ~active;
> +        return;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
> @@ -903,6 +1005,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
>       [AST2700_HW_STRAP1_SEC1]        = 0x000000FF,
>       [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
>       [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
> +    [AST2700_SCU_SSP_CTRL_0]        = 0x000007FE,
> +    [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
>       [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
>       [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
>       [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
> @@ -922,12 +1026,17 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
>   
>   static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)
>   {
> +    Aspeed2700SCUState *a = ASPEED_2700_SCU(obj);
>       AspeedSCUState *s = ASPEED_SCU(obj);
>       AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
>   
>       memcpy(s->regs, asc->resets, asc->nr_regs * 4);
>       s->regs[AST2700_SILICON_REV] = s->silicon_rev;
>       s->regs[AST2700_HW_STRAP1] = s->hw_strap1;
> +
> +    if (a->ssp_cpuid > 0) {

a->ssp_cpuid >= 0

> +        arm_set_cpu_off(a->ssp_cpuid);
> +    }
>   }
>   
>   static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)


