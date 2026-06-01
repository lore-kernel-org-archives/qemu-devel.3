Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BCECD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU27f-0000zj-47; Mon, 01 Jun 2026 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU27Y-0000xh-B6; Mon, 01 Jun 2026 08:51:56 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU27W-0007UA-Dy; Mon, 01 Jun 2026 08:51:56 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYkb6nTxz5wr7;
 Mon,  1 Jun 2026 12:51:51 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 12:51:51 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.183])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTYkb5hX4z7vf7; Mon,  1 Jun 2026 12:51:51 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 9C3F8203054; 
 Mon,  1 Jun 2026 12:51:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004b204950f-cb1d-4448-9f73-c26a5f5502d6,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d86e369b-ab79-4d9d-8d25-4945f2aaef1f@kaod.org>
Date: Mon, 1 Jun 2026 14:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to
 unify DMA address handling
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260529064243.2064188-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9252363960587561995
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcTL67SRRXQW9eygcNxmf+GQLIlpZhL1Yoy7r8/DcpBvajW5g0wRbvMhxkNNxGApAkRfOKTpi1VG+JIG970SkXAwx1jmcO6XPGb9OcPHfcUbPDUjZAHzLF1VChPkkn6qsL15qPYfjagFLKvzQWlZBCpRLY3hbNsThOE/y0aPUQSUUXubX4epOId5bbjAiW3NoGE/YH0s3w/bm2IEMWqyGNW1y53eQCkHwp3pTfpsujjUBdlhsFBFl4cxp9goXZIZtjk4j8wISSngE4cFPsr6beRms3adkbpNTqBWron0aBNZ7hL1P+tmmVSJq8eEy0VFkWlH8u3mv60KBrHHpaRHIcaU7v2nk5ndlW9zDE7LCajUOtFhkp8JIvA4LhRX2u6/E6GMbVtAhf0dXS4XxVPvGzIx9ysmxXzsVL9RFDoLY2vovzDTbWUq2wpQolkiXwbAu2AJAluds6eYMgKbQ1+sCwt5Waa4cSXX7tZAONMfhyEVhW4gQ0aradY222iYPbEiIH9N/ITKRCw7K8VXSYwKF5KP2RCTy9S5k1fRC5dtCu9sX1QbSQ5ID+QeIe9KL9WD2bbteKgIVHr8OXaPD949kodoenYhEHex2+WEu7VcePUvpj634A8mHCrjmX0pKLuiQyHWCy693SXhIX84crVbIlehBHrekoyPtZvVPQm/06Nw
DKIM-Signature: a=rsa-sha256; bh=2ABKee/cYjhJ6ensVGhgwx8kWT9yJWetNSI18OmVK2Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318312; v=1;
 b=DcC3PyExPwwdJ7RRKfcUIDJY+hyU7DMtYG0cfvMX2zax0xblhUldsFwAS4IL5nmqvvuo7Yit
 Ni5TFZRH7c6SHind3p6rfDZU8S0ELyhqcTariSwe8J4DUtjx8JVZ8dp4ltjBLSQ6awSXEBFR1TU
 0vvjduZ6oFSEfCnriUXCHI3ZI78IQBWrxpcWYKM/ehyJzcjXtgi3z2vyjIwUMUt4Ej7cLVMdavG
 ZvvZ2a8ulnImDnPA3pedmKk5VT9pNIxh5+NQg2bBtgMKO7rh6/OkF/45xv5R7AYm1gr04/z2XMu
 D2tNYGou1ZsQHSby0C2EXdXevNrs03aOpoDBAERky+n4g==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/29/26 08:42, Jamin Lin wrote:
> The Aspeed I2C controller has two register layouts.
> 
> The AST2500 uses the old mode with a single DMA address register (I2CD_DMA_ADDR)
> where the address is 4-byte aligned and masked to 0x3ffffffc.
> 
>  From AST2600 onwards, the new mode provides separate master TX/RX and slave RX DMA
> address registers (I2CM_DMA_TX_ADDR, I2CM_DMA_RX_ADDR, I2CS_DMA_RX_ADDR)
> with different address widths per SoC:
>    AST2600 (new mode): 0x7fffffff  - bits[30:0]
>    AST1030 (new mode): 0x7fffffff  - bits[30:0]
>    AST1060 (new mode): 0x7fffffff  - bits[30:0]
>    AST2700 (new mode): 0xffffffff  - bits[31:0]
> 
> Introduce dma_addr_lo_mask as a per-class attribute and apply it
> uniformly when storing DMA address register writes and when loading
> the address into dma_dram_offset for both master and slave paths.
> This replaces the previous FIELD_EX32 extractions (which incorrectly
> stripped bit 31 on AST2700) and the hardcoded 0x3ffffffc literal in
> the old-mode path.


Should we add a Fixes: tag ?

Thanks,

C.


> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i2c/aspeed_i2c.h |  5 +----
>   hw/i2c/aspeed_i2c.c         | 22 +++++++++++++---------
>   2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index d42cb4865a..1fc229f699 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -209,13 +209,9 @@ REG32(I2CS_DMA_LEN, 0x2c)
>       FIELD(I2CS_DMA_LEN, TX_BUF_LEN_W1T, 15, 1)
>       FIELD(I2CS_DMA_LEN, TX_BUF_LEN, 0, 11)
>   REG32(I2CM_DMA_TX_ADDR, 0x30)
> -    FIELD(I2CM_DMA_TX_ADDR, ADDR, 0, 31)
>   REG32(I2CM_DMA_RX_ADDR, 0x34)
> -    FIELD(I2CM_DMA_RX_ADDR, ADDR, 0, 31)
>   REG32(I2CS_DMA_TX_ADDR, 0x38)
> -    FIELD(I2CS_DMA_TX_ADDR, ADDR, 0, 31)
>   REG32(I2CS_DMA_RX_ADDR, 0x3c)
> -    FIELD(I2CS_DMA_RX_ADDR, ADDR, 0, 31)
>   REG32(I2CS_DEV_ADDR, 0x40)
>   REG32(I2CM_DMA_LEN_STS, 0x48)
>       FIELD(I2CM_DMA_LEN_STS, RX_LEN, 16, 13)
> @@ -303,6 +299,7 @@ struct AspeedI2CClass {
>       bool has_share_pool;
>       uint64_t mem_size;
>       bool has_dma64;
> +    uint32_t dma_addr_lo_mask;
>   };
>   
>   static inline bool aspeed_i2c_is_new_mode(AspeedI2CState *s)
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 80c4457500..9c0387a394 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -236,7 +236,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
>           value = bus->regs[R_I2CM_DMA_TX_ADDR];
>           bus->dma_dram_offset =
>               deposit64(bus->dma_dram_offset, 0, 32,
> -                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));
> +                      value & aic->dma_addr_lo_mask);
>           if (aic->has_dma64) {
>               value = bus->regs[R_I2CM_DMA_TX_ADDR_HI];
>               bus->dma_dram_offset =
> @@ -246,7 +246,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)
>       } else {
>           value = bus->regs[R_I2CD_DMA_ADDR];
>           bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
> -                                         value & 0x3ffffffc);
> +                                         value & aic->dma_addr_lo_mask);
>       }
>   }
>   
> @@ -261,7 +261,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
>           value = bus->regs[R_I2CM_DMA_RX_ADDR];
>           bus->dma_dram_offset =
>               deposit64(bus->dma_dram_offset, 0, 32,
> -                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));
> +                      value & aic->dma_addr_lo_mask);
>           if (aic->has_dma64) {
>               value = bus->regs[R_I2CM_DMA_RX_ADDR_HI];
>               bus->dma_dram_offset =
> @@ -271,7 +271,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)
>       } else {
>           value = bus->regs[R_I2CD_DMA_ADDR];
>           bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 0, 32,
> -                                         value & 0x3ffffffc);
> +                                         value & aic->dma_addr_lo_mask);
>       }
>   }
>   
> @@ -735,12 +735,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           aspeed_i2c_bus_raise_interrupt(bus);
>           break;
>       case A_I2CM_DMA_TX_ADDR:
> -        bus->regs[R_I2CM_DMA_TX_ADDR] = FIELD_EX32(value, I2CM_DMA_TX_ADDR,
> -                                                   ADDR);
> +        bus->regs[R_I2CM_DMA_TX_ADDR] = value & aic->dma_addr_lo_mask;
>           break;
>       case A_I2CM_DMA_RX_ADDR:
> -        bus->regs[R_I2CM_DMA_RX_ADDR] = FIELD_EX32(value, I2CM_DMA_RX_ADDR,
> -                                                   ADDR);
> +        bus->regs[R_I2CM_DMA_RX_ADDR] = value & aic->dma_addr_lo_mask;
>           break;
>       case A_I2CM_DMA_LEN:
>           w1t = FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||
> @@ -1385,6 +1383,8 @@ static const TypeInfo aspeed_i2c_info = {
>   static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
>                                             enum i2c_event event)
>   {
> +    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
> +
>       switch (event) {
>       case I2C_START_SEND_ASYNC:
>           if (!SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CS_CMD, RX_DMA_EN)) {
> @@ -1395,7 +1395,7 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
>           ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN_STS, RX_LEN, 0);
>           bus->dma_dram_offset =
>               deposit64(bus->dma_dram_offset, 0, 32,
> -                      ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_RX_ADDR, ADDR));
> +                      bus->regs[R_I2CS_DMA_RX_ADDR] & aic->dma_addr_lo_mask);
>           bus->regs[R_I2CC_DMA_LEN] =
>               ARRAY_FIELD_EX32(bus->regs, I2CS_DMA_LEN, RX_BUF_LEN) + 1;
>           i2c_ack(bus->bus);
> @@ -1638,6 +1638,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, const void *data)
>       aic->check_sram = true;
>       aic->has_dma = true;
>       aic->mem_size = 0x1000;
> +    aic->dma_addr_lo_mask = 0x3ffffffc;
>   }
>   
>   static const TypeInfo aspeed_2500_i2c_info = {
> @@ -1667,6 +1668,7 @@ static void aspeed_2600_i2c_class_init(ObjectClass *klass, const void *data)
>       aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
>       aic->has_dma = true;
>       aic->mem_size = 0x1000;
> +    aic->dma_addr_lo_mask = 0x7fffffff;
>   }
>   
>   static const TypeInfo aspeed_2600_i2c_info = {
> @@ -1691,6 +1693,7 @@ static void aspeed_1030_i2c_class_init(ObjectClass *klass, const void *data)
>       aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
>       aic->has_dma = true;
>       aic->mem_size = 0x10000;
> +    aic->dma_addr_lo_mask = 0x7fffffff;
>   }
>   
>   static const TypeInfo aspeed_1030_i2c_info = {
> @@ -1718,6 +1721,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
>       aic->has_dma = true;
>       aic->mem_size = 0x2000;
>       aic->has_dma64 = true;
> +    aic->dma_addr_lo_mask = 0xffffffff;
>   }
>   
>   static const TypeInfo aspeed_2700_i2c_info = {


