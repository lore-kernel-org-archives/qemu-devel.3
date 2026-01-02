Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2133FA374A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbfCs-0007Bw-UT; Fri, 02 Jan 2026 08:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vbfCj-0007A1-Lc; Fri, 02 Jan 2026 08:28:36 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vbfCe-0007wc-Lk; Fri, 02 Jan 2026 08:28:31 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.75])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4djPdp2ntjz5w8j;
 Fri,  2 Jan 2026 13:28:14 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 2 Jan
 2026 14:28:12 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0062b48a99b-67b1-4a38-b3a2-ad9b7b5a0fb2,
 B7FD5E44328430CDF13337E5E30BE77826E2EBC7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <637a3773-004a-42c3-9a1b-0ea7a7ddd8f8@kaod.org>
Date: Fri, 2 Jan 2026 14:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20260102090746.1130033-1-jamin_lin@aspeedtech.com>
 <20260102090746.1130033-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260102090746.1130033-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 9f073d49-04cf-4a54-a5e7-6303c2a96ea5
X-Ovh-Tracer-Id: 14406170787081653170
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEZdQjDjPxWmruKpvMPuDGzVE1cxcPGmCa3dvAu8T/Z4yWJ6RxddKNB6t3k/1NBlcjHF8dE6gWhPEEIBz/+921EVKZIVSUORCeK0deoHWfI8EAOdjXWlpx7NgUzkBw5/EgeA8HTtjmsIz4BWgpTx77mAkzE799hM7AkPxr+W8AkUp11Kb1KNWBXLaMOIn25AMlUW7yX0f93ro3fOZnRBLJLlL/qVdA/V6wjhhM7jy1TnO0lhZwOA6XHuQMNTFI29eqsWBiBcU9r1l+x+4FVkAuukumEnAWQPtJMFELO6cXJyF3Pr7KyW++0AN5Rw+STYebdq4cqmdmFj8ycoMIhqVaSDBX6CSjadjCxWzNR+pmG+VlwlZMcxh2QrzPK6qSrHnfZ0PV4N5LqztMSMDzoPtx+mXFGjhAR+VAebaCtLpY61DGHD4FlIN+crHxKRF8vg9P1DchxpdSgeYRMwPKjiEtCrN8oiYo2mnS7/GuzPvNYzaM4q+n6n2gO11fCy9NJbLgGGp+FrRVRdWpllod23dryqWk2InLSWNV913SanGyG+VHGSJN7g51sOMkUFoUBTnpP1P5JEir0eGDOANd9QeodPnwMe/AbjINgReP1rH4nIuATfNHS1bZ4fPjZSvhtQfiqB+QHVbf8zyJBgaWbrsj3/3rZgAd/4FpxuzyMogmWGQ
DKIM-Signature: a=rsa-sha256; bh=qZgYOABXk12OdwGj5dCvvYrpt3WJnfL11CFxL1GSc+Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767360495; v=1;
 b=hQdxJ3BMiAeBsaCWjVBasnGAK9buhD8kphJTrN+3xvntL58KXrB8QnuCYhlN5/s7xfAZ+6jS
 lEAICKFzARTrInKmmTTXO/JIFOGACEKEQ2QWvPgTwvP22RF7ziXp6w1O2L3Em4nHf25wUJcRbk6
 Oml3MimIFShLcCF9wK0ub3VhYJa52b2Aks6op3THuUicpbBSpVjjm6l5QuzrA504HvlFwRXBdsm
 ZHZEbn+zDEM3UYte1UXYwAVjRbyjybdyLOmWLz/r2K7Q3wAajT/u+qtvP+YdJHjne/T2TJl+53K
 Ux6qPbB6eR9Xx5uVa8EZ+9FglEKQMJElGea+/BZkp9EEQ==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
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

On 1/2/26 10:07, Jamin Lin wrote:
> In the previous design, the I2C model would update I2CC_DMA_LEN (0x54) based on
> the value of I2CM_DMA_LEN (0x1C) when the firmware set either I2CM_DMA_TX_ADDR
> (0x30) or I2CM_DMA_RX_ADDR (0x34). However, this only worked correctly if the
> firmware set I2CM_DMA_LEN before setting I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR.
> 
> If the firmware instead set I2CM_DMA_TX_ADDR or I2CM_DMA_RX_ADDR before setting
> I2CM_DMA_LEN, the value written to I2CC_DMA_LEN would be incorrect.
> 
> To fix this issue, the model should be updated to set I2CC_DMA_LEN when the
> firmware writes to the I2CM_DMA_LEN register, rather than when it writes to the
> I2CM_DMA_RX_ADDR and I2CM_DMA_TX_ADDR registers.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Fixes: ba2cccd (aspeed: i2c: Add new mode support)

Fixes: ba2cccd64e90 ("aspeed: i2c: Add new mode support")

This change should be backported on the stable branches.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/i2c/aspeed_i2c.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index faf2160c06..1b8ac561c3 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -656,8 +656,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->dma_dram_offset =
>               deposit64(bus->dma_dram_offset, 0, 32,
>                         FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
> -        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
> -                                                     TX_BUF_LEN) + 1;
>           break;
>       case A_I2CM_DMA_RX_ADDR:
>           bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
> @@ -665,8 +663,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->dma_dram_offset =
>               deposit64(bus->dma_dram_offset, 0, 32,
>                         FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
> -        bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs, I2CM_DMA_LEN,
> -                                                     RX_BUF_LEN) + 1;
>           break;
>       case A_I2CM_DMA_LEN:
>           w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
> @@ -679,10 +675,16 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           if (FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T)) {
>               ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, RX_BUF_LEN,
>                                FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN));
> +            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
> +                                                         I2CM_DMA_LEN,
> +                                                         RX_BUF_LEN) + 1;
>           }
>           if (FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN_W1T)) {
>               ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN, TX_BUF_LEN,
>                                FIELD_EX32(value, I2CM_DMA_LEN, TX_BUF_LEN));
> +            bus->regs[R_I2CC_DMA_LEN] = ARRAY_FIELD_EX32(bus->regs,
> +                                                         I2CM_DMA_LEN,
> +                                                         TX_BUF_LEN) + 1;
>           }
>           break;
>       case A_I2CM_DMA_LEN_STS:


