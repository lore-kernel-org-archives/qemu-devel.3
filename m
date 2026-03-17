Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44ACF33828
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Qlg-0004HX-Te; Tue, 17 Mar 2026 05:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w2Qlf-0004GF-0j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:31:15 -0400
Received: from 11.mo533.mail-out.ovh.net ([87.98.181.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w2Qlc-0007aw-BN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:31:14 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4fZmt52nVTz64cl;
 Tue, 17 Mar 2026 09:31:09 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 17 Mar 2026 09:31:09 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.160])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4fZmt51JNcz1xsZ; Tue, 17 Mar 2026 09:31:09 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A1B371B43922;
 Tue, 17 Mar 2026 09:31:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00458bc19fd-0850-4d93-984c-ec23235a0a37,
 4AC1E9A3EE45423C0527B61D87123FAFA3CB088F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <aa66c11a-7595-4155-a94e-44368e593a1b@kaod.org>
Date: Tue, 17 Mar 2026 10:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/aspeed: fix lost interrupts on back-to-back
 commands
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, peter.maydell@linaro.org
Cc: steven_lee@aspeedtech.com, leetroy@gmail.com, jamin_lin@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, quan@os.amperecomputing.com, jae.yoo@oss.qualcomm.com
References: <20260311023712.2730185-1-jithu.joseph@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311023712.2730185-1-jithu.joseph@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 2259962592113830934
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEzBMi5H3lunFtC+DY6Bmf8y+4WK/Euuea+ACxtFQcOwxgTLJyIAncf3J6xI25DOhux+VXILLvpcA5Dw3H9G1iok7ZUSXomiLD4FCw9uF6R8ltik96AYO8o7ICji96iSkatE8HJkYnCkkrzHSrxkg2wcVOTTVlNif6Uq9+b1ehWYoT3U2ovgo9vQaQpufQhsLuJbhXRN18E9em0JPWquNipaNfmsi9nqSMRSpNeZjWKY4MijjRcrIPiUJ4ZGahmiAwaRXF61P4Q1rTY7htu9zu3BeEEiVOE/+sXdCm6DiGKnN6/PXcXU1TxFaBDdyzpIgVW0vCp6WwDJZ5F6Miu30FjMkd0tVMCJSPmB+jLlRuOXwC7Ixek+5nArfWbVkVNY5Lrl18v7wbvMPiJHFqbxHx5aiIbkWVPvO/UAL+kGv1KHAmkLTlaoXsw4GGmKBEf17smi7jd2jZ+9PD530D3fqRSa/j3rzfhc/TdD0MqLMx1jtNJmbJ08Jdw8i6xq2o0jAWWrkSwlbSR3/nIBJNtOVTEPDG1sNEEOb0gYp4cYe6AQWpGoouJV3GclFt4KRpEr0vaQYiIta1sMvY025AAWtRneCuGrVkx9eRl2wV47Fmr9U0scBEJwp7PHFH3xg0XcN/VFDzV5yCnBOx9kxR4JSS6J/FJ586DJpFm/rc94iWfEA
DKIM-Signature: a=rsa-sha256; bh=HtwDKE9YETmbtUEz0h7rybsHzgWTqaiBHdJL6L74dLA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1773739870; v=1;
 b=MHidOQvw7RcRKtLDBenVFrOXYl3MCrPBKDW05umQOtsG9th2dXQp8IvesJblFlbSxWo8bYeq
 V9AAVJcF+owiBsLOz7oQTELMNYwUYfsKPdtXY+Tb3tA4EK0rAjc4QPiTcgPL99Vs/jF1ScHCMAX
 niflypd4s3tVj0udiX997eiBzWqzLNUuMzOFGGMHLeJWd1gUVebwEfy5+p/Jl96waqGOwapif0W
 Ifl7/A1OhYNVHLGD6d1L68lBAZo8G3WKR5JiYSy/V9J1V+9/dubq9oIc9/KgiqVQauuGplINrYx
 87GrvfqjNSkVzkscUX4+zrFOJAmHc4ySeD4/6hbGalMFQ==
Received-SPF: pass client-ip=87.98.181.139; envelope-from=clg@kaod.org;
 helo=11.mo533.mail-out.ovh.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/11/26 03:37, Jithu Joseph wrote:
> QEMU executes I2C commands synchronously inside the CMD register write
> handler. On real hardware each command takes time on the bus, so the
> ISR can clear the previous interrupt status before the next completion
> arrives. In QEMU, when the guest ISR handles a TX_ACK and immediately
> issues the next command by writing to CMD, that command completes
> instantly — before the ISR returns to W1C-clear the first TX_ACK.
> Since the bit is already set, setting it again is a no-op. The ISR
> then clears it, wiping both completions at once. No interrupt fires
> for the second command and the driver stalls.
> 
> This affects any multi-step I2C transaction: register reads, SMBus
> word reads, and PMBus device probes all fail ("Error: Read failed"
> from i2cget, -ETIMEDOUT from kernel drivers).
> 
> The issue is exposed when the guest kernel includes commit "i2c:
> aspeed: Acknowledge Tx done with and without ACK irq late" [1] which
> defers W1C acknowledgment of TX_ACK until after the ISR has issued
> the next command. This means the old TX_ACK is still set when the
> next command completes synchronously, and the subsequent W1C wipes
> both completions at once.
> 
> The trace below shows `i2cget -y 15 0x50 0x00` (read EEPROM register
> 0x00) failing without the fix. The first START+TX sets TX_ACK. The
> ISR handles it and issues a second TX to send the register address.
> That TX completes synchronously while TX_ACK is still set:
> 
>    aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
>    aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
>    aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
>    aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
>    aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x1      # TX runs, TX_ACK already set!
>    aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # re-set is no-op
>    aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
>    aspeed_i2c_bus_read  0x10: 0x0                    # LOST — both ACKs wiped
> 
> The driver sees INTR_STS=0 and never proceeds to the read phase.
> 
> Fix this by tracking interrupt bits that collide with already-pending
> bits. Before calling aspeed_i2c_bus_handle_cmd(), save and clear
> INTR_STS so that only freshly set bits are visible after the call.
> Any overlap between the old and new bits is saved in pending_intr_sts.
> When the ISR later W1C-clears the old bits, re-apply the saved
> pending bits so the ISR sees them on its next loop iteration.
> 
> With the fix, the same operation completes successfully:
> 
>    aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
>    aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
>    aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
>    aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
>    aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x0      # INTR_STS cleared first
>    aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK freshly set
>    aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
>    aspeed_i2c_bus_read  0x10: 0x1                    # RE-DELIVERED from pending
>    aspeed_i2c_bus_write 0x14: 0x1b                   # ISR proceeds: START+RX
>    aspeed_i2c_bus_cmd cmd=0x40001b start|tx|rx|last| # read phase completes
>    i2c_recv recv(addr:0x50) data:0x00                # data received
> 
> [1] https://lore.kernel.org/all/20231211102217.2436294-3-quan@os.amperecomputing.com/
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
> ---
> Background: A Linux kernel patch series by Quan Nguyen (Ampere) reworked
> the i2c-aspeed driver's interrupt handling to delay the W1C clear of
> TX_ACK until after the ISR has processed the completion and issued any
> follow-up command. The motivation was to correctly handle AST2600 and
> AST2500 hardware where I2C slave mode requires this ordering — the
> authors explicitly verified the series on both platforms. On our internal
> AST2600 hardware we carry this patch as a necessary fix for I2C slave
> mode to work correctly.
> 
> The series did not make it into the upstream Linux kernel because test
> failures on QEMU blocked it. However, the failures are on the emulation
> side: QEMU executes I2C commands synchronously inside the MMIO write
> handler, causing a follow-up command to complete and re-raise an
> already-pending interrupt bit before the ISR has had a chance to
> W1C-clear it. On real hardware this race cannot occur since bus
> transactions take measurable time.
> 
> Since the kernel patch reflects correct real-hardware behaviour, the
> right fix is to adapt QEMU's interrupt delivery to handle this ordering,
> rather than requiring the kernel driver to work around a QEMU-specific
> timing artifact. This patch does that.
> 
>   include/hw/i2c/aspeed_i2c.h |  1 +
>   hw/i2c/aspeed_i2c.c         | 46 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 53a9dba71b07..d42cb4865aa5 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -256,6 +256,7 @@ struct AspeedI2CBus {
>       qemu_irq irq;
>   
>       uint32_t regs[ASPEED_I2C_NEW_NUM_REG];
> +    uint32_t pending_intr_sts;
>       uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];
>       uint64_t dma_dram_offset;
>   };
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 8022938f3478..ad6342bec0d4 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -628,6 +628,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
>       bool handle_rx;
>       bool w1t;
> +    uint32_t old_intr;
> +    uint32_t cmd_intr;
>   
>       trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
>   
> @@ -665,6 +667,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>               break;
>           }
>           bus->regs[R_I2CM_INTR_STS] &= ~(value & 0xf007f07f);
> +        /*
> +         * Re-apply interrupts lost due to synchronous command completion.
> +         * When a command completes instantly during an MMIO write, the new
> +         * interrupt status bits collide with already-pending bits. After
> +         * the ISR clears them, re-apply the saved bits so the ISR can
> +         * process the new completion.
> +         */
> +        if (bus->pending_intr_sts) {
> +            bus->regs[R_I2CM_INTR_STS] |= bus->pending_intr_sts;
> +            bus->pending_intr_sts = 0;
> +        }
>           if (!bus->regs[R_I2CM_INTR_STS]) {
>               bus->controller->intr_status &= ~(1 << bus->id);
>               qemu_irq_lower(aic->bus_get_irq(bus));
> @@ -708,7 +721,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>               bus->regs[R_I2CM_CMD] = value;
>           }
>   
> +        old_intr = bus->regs[R_I2CM_INTR_STS];
> +        bus->regs[R_I2CM_INTR_STS] = 0;
>           aspeed_i2c_bus_handle_cmd(bus, value);
> +        /*
> +         * cmd_intr has only the bits handle_cmd freshly set.
> +         * Overlap with old_intr means the same bit was re-fired
> +         * and would be lost when the ISR W1C-clears the old one.
> +         */
> +        cmd_intr = bus->regs[R_I2CM_INTR_STS];
> +        bus->regs[R_I2CM_INTR_STS] = cmd_intr | old_intr;
> +        bus->pending_intr_sts |= old_intr & cmd_intr;
>           aspeed_i2c_bus_raise_interrupt(bus);
>           break;
>       case A_I2CM_DMA_TX_ADDR:
> @@ -845,6 +868,8 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
>   {
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
>       bool handle_rx;
> +    uint32_t old_intr;
> +    uint32_t cmd_intr;
>   
>       trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
>   
> @@ -868,6 +893,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
>           handle_rx = SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_INTR_STS, RX_DONE)
>                       && SHARED_FIELD_EX32(value, RX_DONE);
>           bus->regs[R_I2CD_INTR_STS] &= ~(value & 0x7FFF);
> +        /*
> +         * Re-apply interrupts lost due to synchronous command completion.
> +         * When a command completes instantly during an MMIO write, the new
> +         * interrupt status bits collide with already-pending bits. After
> +         * the ISR clears them, re-apply the saved bits so the ISR can
> +         * process the new completion.
> +         */
> +        if (bus->pending_intr_sts) {
> +            bus->regs[R_I2CD_INTR_STS] |= bus->pending_intr_sts;
> +            bus->pending_intr_sts = 0;
> +        }
>           if (!bus->regs[R_I2CD_INTR_STS]) {
>               bus->controller->intr_status &= ~(1 << bus->id);
>               qemu_irq_lower(aic->bus_get_irq(bus));
> @@ -915,7 +951,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CD_CMD] &= ~0xFFFF;
>           bus->regs[R_I2CD_CMD] |= value & 0xFFFF;
>   
> +        old_intr = bus->regs[R_I2CD_INTR_STS];
> +        bus->regs[R_I2CD_INTR_STS] = 0;
>           aspeed_i2c_bus_handle_cmd(bus, value);
> +        /*
> +         * cmd_intr has only the bits handle_cmd freshly set.
> +         * Overlap with old_intr means the same bit was re-fired
> +         * and would be lost when the ISR W1C-clears the old one.
> +         */
> +        cmd_intr = bus->regs[R_I2CD_INTR_STS];
> +        bus->regs[R_I2CD_INTR_STS] = cmd_intr | old_intr;
> +        bus->pending_intr_sts |= old_intr & cmd_intr;
>           aspeed_i2c_bus_raise_interrupt(bus);
>           break;
>       case A_I2CD_DMA_ADDR:

Applied to aspeed-next.

Thanks,

C.


