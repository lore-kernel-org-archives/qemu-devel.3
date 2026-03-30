Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB46FF494A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w75O5-0006EC-HY; Mon, 30 Mar 2026 01:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w75O1-0006Ds-VB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:42:07 -0400
Received: from smtpout1.mo533.mail-out.ovh.net ([51.210.94.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w75Nx-0000St-SX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:42:05 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4fkg9d68vRz5w1w;
 Mon, 30 Mar 2026 05:41:57 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 30 Mar 2026 05:41:57 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.121])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4fkg9d17JCz5vcx; Mon, 30 Mar 2026 05:41:57 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0CF65941574; 
 Mon, 30 Mar 2026 05:41:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00230b7952a-f3f7-4917-8935-328f9af28683,
 7D556D2DDFF67F75045F04EBDED03CA4E39E484C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5483de6e-6bc9-4267-8371-15fc3f748ee6@kaod.org>
Date: Mon, 30 Mar 2026 07:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts
To: GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 947163299149229067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGLFD9Zh5VsOcL9uqYoQ4sZ750kGI1mZJbQY/UR6SUQfcAV93EzPxzb9paIP6+C1lHhNuwGuttx04zrsQWo012a4PuPa5yFuDkT+2J0fKg1ekWq9W7mmdFV+q9vqYSdAH2KKfnIBJq4Okl+h0RhNpVhujnFGRfSWEFDbvQnIKID/ZVLMizg9Ylwm0QfWGkjBLJsX4bG+SEy2axo/Qy6pb+y68Z/A0uGRXFDKCiabNfB90V9QvFW7kkUvPjy5nHUqJrGQYNXnfscqfpQrzZsc6Msw9787XfG9ETd8LDbZnOD7oL/G+WXqDFeop0rnP+L8Q3C5m5nj50NyWF97OFMPU6hgTTajXuMXzrJS0Ce+IqYhBpc2+OX5F3P7kvUi8xZkc6fGITV1GyVDF2r1buEfwHR97pWM0xVbKrUdtSRZRxb4yAqZr7e0yVMcp83jju+L3Sx4B67uEbztbmSqc1vO4XYQ0++dfq/+7LoYiHCcVMjQG4Ezo11+us4WYN7XNXYx4c50UxivG93/uLkq2+akGjlq9nHdB7CNrxPwoyA1Z949PeRkng6PG1cAlaseB9sGSphYbB+4EonvmOQliOxRV+TVdcbJcaz+pQGg+MeDrVv3JQEaRw9De8Tag+4lpTUS4YP+aWexIHaCOutFslXClx0k/dhpmi8z4lOzouBtxyWzA
DKIM-Signature: a=rsa-sha256; bh=s4IHBSo4pLjvZNu50zRkqteOFW6eot0lc4BEU48dW1o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1774849319; v=1;
 b=I5DOddVYlj1mOEp+9I8Ad1M1kmUMx+op+U4NygZjAav67QSVgNf97OmtYTaPNBdnrh0c7Fsi
 oWqx2by2cZRFAYWzo51rx2QhYb4wEPpxH/C2i2MPOIJp2D7r4WnlA4nCs1f9AoZDqjWKyviea2f
 f9dEN6UvgtMO0ymdtq1Twto33UZGKHHppZaMXVX1mDteX1Q8wamku80i12aYiYtNK9lewTnG0kX
 P8BrNMMAPnyLNe21nJVFyv57zdWuivRxRHaSKq/3HZa65mfKf/RgPwB653d1gC68L/Vda5m0BAR
 g27SJf63Es37XyndnTWkbC01tUoIzrPu2XyDTjlxFLkZw==
Received-SPF: pass client-ip=51.210.94.138; envelope-from=clg@kaod.org;
 helo=smtpout1.mo533.mail-out.ovh.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On 3/25/26 09:54, GuoHan Zhao wrote:
> Commit 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on
> back-to-back commands") introduced pending_intr_sts to preserve
> interrupt bits that collide with already pending status bits.
> 
> That deferred interrupt state is consumed later when the guest clears
> INTR_STS, but it is not reset in aspeed_i2c_bus_reset() and it is not
> part of the bus migration state. A reset can therefore leave stale
> deferred bits behind, and migration can silently drop them.
> 
> Clear pending_intr_sts on reset and include it in VMState while keeping
> compatibility with older migration streams.
> 
> Fixes: 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on back-to-back commands")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/i2c/aspeed_i2c.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 5d18f8d49ea4..90f83a03fd4f 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1134,10 +1134,11 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops = {
>   
>   static const VMStateDescription aspeed_i2c_bus_vmstate = {
>       .name = TYPE_ASPEED_I2C,
> -    .version_id = 6,
> +    .version_id = 7,
>       .minimum_version_id = 6,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
> +        VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),
>           VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),
>           VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),
>           VMSTATE_END_OF_LIST()
> @@ -1510,6 +1511,7 @@ static void aspeed_i2c_bus_reset(DeviceState *dev)
>       AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
>   
>       memset(s->regs, 0, sizeof(s->regs));
> +    s->pending_intr_sts = 0;
>       i2c_end_transfer(s->bus);
>   }
>   

Applied to aspeed-next.

Thanks,

C.


