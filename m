Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258ACE7DF08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxCT-0001uU-DM; Mon, 02 Feb 2026 11:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vmxCR-0001tx-Pg; Mon, 02 Feb 2026 11:54:55 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vmxCP-0003gX-JG; Mon, 02 Feb 2026 11:54:55 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.1])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f4Xlt3HY2z5w28;
 Mon,  2 Feb 2026 16:54:50 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 17:54:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001648a52ee-0cda-4bfe-bd74-45b4b0a62539,
 7652E71065C1D671F0F2B67E69D7E7AF66B0F117) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3d4469cf-81ab-47c5-8753-ae8b4c905bab@kaod.org>
Date: Mon, 2 Feb 2026 17:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] hw/i2c/aspeed_i2c: Fix DMA moving data into
 incorrect address
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <SE3PR06MB8199EB45E8CB0A531B796C6BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SE3PR06MB8199EB45E8CB0A531B796C6BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f8603c86-954a-451d-837b-9089465e58cd
X-Ovh-Tracer-Id: 15481686670640385013
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGW5tiDXhJGEqToPDTp2l5ZRWIu71gxtEzAl/th9DAKP/CqXAUnyZ+Rm+S+eXkQthU3cXV0WB6OCvBcJB03hSj8BBgFlAl+hU+vvIT+q1vhrqHEVBWVReVSbL+xtDuaVgIcFb9FGVKKt0LPAujgGOX9u+alXJ6BS8ISEiRzzBy/JsvYP1HIbBeW8ZFXS//u/wMiSTE8H9lI8r+0KyXmGalGxIU44Dl097MTDBe6LxS1joUnZ1cWw4o9TINnamXJxKhJHgHh6UjJ8nYaeylmeNppSMnfrRZKw1sM2cw5rxmYhU3t/TqDpG+DAyJ8k56n0xHMMkjvHWOkZqof3qxB8i0TZOoyPQ2r/sYowzZQeJw2A+DNltzTTsHFSEoPGjtwtG7godh5p6Y9f4ZWq/VQp9aFVvN+qFvIwcOiRJYh8Y1SXRqqg7QlbcioN94UlnVyfD6eg2JKmqUuzusCyzFHesaszmX7J1SG6FSZGPIQX8E67gFFcNq8f39D6euqKNO0F3dxjHKNWZVsBBlgmrszP5PsZZwZHe7FPGPDL3ERFYQIGWbti7VbnNpm+ROLqYdLqqw2+Kh1irhvAx5W1zZi4VzPZNUPC3dwCSaCq+QKJPxg7ZhswLAyn0VEyxb0q9AgKpZqLuVOqhCf+sJAvnLD5xZ71on2FbSVXexTSUp3BbZV+g
DKIM-Signature: a=rsa-sha256; bh=sd2kAjW9IqMrEPzIDw4FlcuyPbIrObVPcOoK/Z69Xlk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770051290; v=1;
 b=Bi/8zcs4qnsRxmoEX2E4Rr47TtTQwEGj+ggEazXGJSadpw7Y6TzxdSSg63JhzNcidqA4Kg4V
 P9uXQTTAr03xREn2li7KFWY+Aj65IO5fP06ld7kR9apACKrNpG6KYdnpHbjaPCGe+L0KgLrf4Fs
 IkkB8oQbBQuJdMHtX0FFlKS0sJrsZhFBo+wT1JanT5bdxCqkB28as5EwjS+uRp+DIkbzsMhpjtB
 2qfr8tChmubh0TOLGsqRvUtceE5wEuSRVX3VMy6q+RSJS/bheVw3Pyqo0hodtxK0R59+nR3f1+K
 fzw39fdhqzxVwto2dsrG1CXekp0QyIifKmLcqPLVJAUvQ==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
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

On 2/2/26 07:19, Jamin Lin wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> In the previous design, the I2C model updated dma_dram_offset only when
> firmware programmed the RX/TX DMA buffer address registers. The firmware
> used to rewrite these registers before issuing each DMA command.
> 
> The firmware driver behavior has changed to program the DMA address
> registers only once during I2C initialization. As a result, the I2C model
> no longer refreshes dma_dram_offset, causing DMA to move data into an
> incorrect DRAM address.
> 
> Fix this by introducing helper functions to update dma_dram_offset from
> the DMA address registers, and invoke them right before handling TX/RX
> DMA operations. This guarantees DMA always uses the correct buffer
> address even if the registers are programmed only once.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Should we backport to stable branches too ?

Thanks,

C.


> ---
>   hw/i2c/aspeed_i2c.c | 87 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 61 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1ee73a8f5e..fb3d6a5600 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -116,8 +116,6 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
>               value = -1;
>               break;
>           }
> -
> -        value = extract64(bus->dma_dram_offset, 0, 32);
>           break;
>       case A_I2CD_DMA_LEN:
>           if (!aic->has_dma) {
> @@ -221,6 +219,64 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
>       return SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_CMD, TX_STATE);
>   }
>   
> +/*
> + * The AST2700 support the maximum DRAM size is 8 GB.
> + * The DRAM offset range is from 0x0_0000_0000 to
> + * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
> + * saving the dram offset.
> + * Therefore, save the high part physical address bit[1:0]
> + * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> + */
> +static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
> +{
> +    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
> +    uint32_t value;
> +
> +    assert(aic->has_dma);
> +
> +    if (aspeed_i2c_is_new_mode(bus->controller)) {
> +        value = bus->regs[R_I2CM_DMA_TX_ADDR];
> +        bus->dma_dram_offset =
> +            deposit64(bus->dma_dram_offset, 0, 32,
> +                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
> +        if (!aic->has_dma64) {
> +            value = bus->regs[R_I2CM_DMA_TX_ADDR_HI];
> +            bus->dma_dram_offset =
> +                deposit64(bus->dma_dram_offset, 32, 32,
> +                          extract32(value, 0, 2));
> +        }
> +    } else {
> +        value = bus->regs[R_I2CD_DMA_ADDR];
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
> +                                         value & 0x3ffffffc);
> +    }
> +}
> +
> +static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
> +{
> +    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
> +    uint32_t value;
> +
> +    assert(aic->has_dma);
> +
> +    if (aspeed_i2c_is_new_mode(bus->controller)) {
> +        value = bus->regs[R_I2CM_DMA_RX_ADDR];
> +        bus->dma_dram_offset =
> +            deposit64(bus->dma_dram_offset, 0, 32,
> +                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
> +        if (!aic->has_dma64) {
> +            value = bus->regs[R_I2CM_DMA_RX_ADDR_HI];
> +            bus->dma_dram_offset =
> +                deposit64(bus->dma_dram_offset, 32, 32,
> +                          extract32(value, 0, 2));
> +        }
> +    } else {
> +        value = bus->regs[R_I2CD_DMA_ADDR];
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
> +                                         value & 0x3ffffffc);
> +    }
> +}
> +
>   static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
>   {
>       MemTxResult result;
> @@ -270,6 +326,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
>           if (aspeed_i2c_is_new_mode(bus->controller)) {
>               ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
>           }
> +        aspeed_i2c_set_tx_dma_dram_offset(bus);
>           while (bus->regs[reg_dma_len]) {
>               uint8_t data;
>               ret = aspeed_i2c_dma_read(bus, &data);
> @@ -335,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>               ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
>           }
>   
> +        aspeed_i2c_set_rx_dma_dram_offset(bus);
>           while (bus->regs[reg_dma_len]) {
>               MemTxResult result;
>   
> @@ -401,6 +459,7 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
>       } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
>           uint8_t data;
>   
> +        aspeed_i2c_set_tx_dma_dram_offset(bus);
>           aspeed_i2c_dma_read(bus, &data);
>           return data;
>       } else {
> @@ -657,16 +716,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CM_DMA_TX_ADDR:
>           bus->regs[R_I2CM_DMA_TX_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR,
>                                                      ADDR);
> -        bus->dma_dram_offset =
> -            deposit64(bus->dma_dram_offset, 0, 32,
> -                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
>           break;
>       case A_I2CM_DMA_RX_ADDR:
>           bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
>                                                      ADDR);
> -        bus->dma_dram_offset =
> -            deposit64(bus->dma_dram_offset, 0, 32,
> -                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
>           break;
>       case A_I2CM_DMA_LEN:
>           w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
> @@ -748,15 +801,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           qemu_log_mask(LOG_UNIMP, "%s: Slave mode DMA TX is not implemented\n",
>                         __func__);
>           break;
> -
> -    /*
> -     * The AST2700 support the maximum DRAM size is 8 GB.
> -     * The DRAM offset range is from 0x0_0000_0000 to
> -     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
> -     * saving the dram offset.
> -     * Therefore, save the high part physical address bit[1:0]
> -     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> -     */
>       case A_I2CM_DMA_TX_ADDR_HI:
>           if (!aic->has_dma64) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
> @@ -766,8 +810,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_TX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_TX_ADDR_HI,
>                                                         ADDR_HI);
> -        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> -                                         extract32(value, 0, 2));
>           break;
>       case A_I2CM_DMA_RX_ADDR_HI:
>           if (!aic->has_dma64) {
> @@ -778,8 +820,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> -        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> -                                         extract32(value, 0, 2));
>           break;
>       case A_I2CS_DMA_TX_ADDR_HI:
>           qemu_log_mask(LOG_UNIMP,
> @@ -795,8 +835,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CS_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CS_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> -        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> -                                         extract32(value, 0, 2));
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
> @@ -887,9 +925,6 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
>               break;
>           }
> -
> -        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
> -                                         value & 0x3ffffffc);
>           break;
>   
>       case A_I2CD_DMA_LEN:


