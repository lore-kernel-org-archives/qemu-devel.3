Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0B9CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl76r-0002SP-D3; Mon, 02 Sep 2024 09:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl76e-0001hM-NF; Mon, 02 Sep 2024 09:28:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl76c-0007Ko-8r; Mon, 02 Sep 2024 09:28:32 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wy8hq006Zz4xGl;
 Mon,  2 Sep 2024 23:28:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wy8hj5Xbtz4xCy;
 Mon,  2 Sep 2024 23:28:21 +1000 (AEST)
Message-ID: <0e62d8ed-f30d-4b18-914b-89a51d6d9687@kaod.org>
Date: Mon, 2 Sep 2024 15:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] hw/i2c/aspeed: support high part dram offset for
 DMA 64 bits
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240808024916.1262715-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Please adjust commit title

On 8/8/24 04:49, Jamin Lin wrote:
> ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
> And the base address of dram is "0x4 00000000" which
> is 64bits address.
> 
> The AST2700 support the maximum DRAM size is 8 GB.
> The DRAM physical address range is from "0x4_0000_0000" to
> "0x5_FFFF_FFFF".
> 
> The DRAM offset range is from "0x0_0000_0000" to
> "0x1_FFFF_FFFF" and it is enough to use bits [33:0]
> saving the dram offset.
> 
> Therefore, save the high part physical address bit[1:0]
> of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> It does not need to decrease the dram physical
> high part address for DMA operation.
> (high part physical address bit[7:0] – 4)
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/i2c/aspeed_i2c.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index c1ff80b1cf..44c3c39233 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -743,6 +743,14 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>                         __func__);
>           break;
>   
> +    /*
> +     * The AST2700 support the maximum DRAM size is 8 GB.
> +     * The DRAM offset range is from 0x0_0000_0000 to
> +     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
> +     * saving the dram offset.
> +     * Therefore, save the high part physical address bit[1:0]
> +     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> +     */
>       case A_I2CM_DMA_TX_ADDR_HI:
>           if (!aic->has_dma64) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
> @@ -752,6 +760,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_TX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_TX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       case A_I2CM_DMA_RX_ADDR_HI:
>           if (!aic->has_dma64) {
> @@ -762,6 +772,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       case A_I2CS_DMA_TX_ADDR_HI:
>           qemu_log_mask(LOG_UNIMP,
> @@ -777,6 +789,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CS_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CS_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",


