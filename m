Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9811C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZid-0004i1-JM; Tue, 30 Jun 2026 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZic-0004hZ-Jd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:45:46 -0400
Received: from smtpout6.mo538.mail-out.ovh.net ([51.210.91.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZia-0006Jd-Vf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:45:46 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4gqQtY14bHz6JdB;
 Tue, 30 Jun 2026 14:45:41 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 30 Jun 2026 14:45:40 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.104])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gqQtX6nTpz5vMJ;
 Tue, 30 Jun 2026 14:45:40 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 2A1BB1923CEA; Tue, 30 Jun 2026 14:45:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0045203db43-8b92-4cef-b24d-5da687463a36,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8d1da954-d8e5-42bd-b57c-bbb554fe9e38@kaod.org>
Date: Tue, 30 Jun 2026 16:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/ssi: aspeed_smc: Fix direct-read dummy bytes
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-8-bin.meng@processmission.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260630135729.466264-8-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15461983423161543894
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEQSx1diC0J9uiKZUafSv9aKiyqW/HsXhmH4hT2rJWTfjT5eBa9iGH6ww9pWdKLRCJIaHQbvMO1JK/h66gk5/O/k1U+fW+kJwEbUJsoGorEfe/23uuJsrEhXunFJIJD582mpb0QNEcr3m5aIhfspUGNSnwh0GPa2YScPXku/NzkqLG+6qAlYLYbJmiFgJVZUZ2R09/LM31LehARZmokqSvscUUE/lXyWsWrUeza58Mel1+2X6q8qnlEONj0VpWIe7lrTLAuJ6Z2VXlJr8OT21Q5OjHCYLe2N2pjCwx3a2h/IzCuqas8Nc+2wrEuAH4nsAdkyDDiDkBXVf/nfVVdF7doC8bnqJtnL6mLs4ry4nLqDUXuDx6knDht05Txfd3PUEcW7A+bcEu4YRdMibvYrYYF3Vc1/teMFjXAc095cFYVLB7lXwCXQjq+NbYxrlvKmWSSua2S7mGLqSOIjogx4at5YelS8eK8sTchU64Enj1ThjObGy1ZPxgUqaSFgkFGZXKY1h0pOz5gvSm9/m0GZ/ZnJTWUbmaYEl/pieo370fsT2Ig80zojoMqWa0NdS7XJ46Ez8YCw9+KPRBjL5b1crJP+R9aEO6tdl1n39vuMYh9wvaiqrlGbxgcLIKAjIxcjhskerPQFw5HcoP3L5JyrCP5vPa0SKdczmmoYVaIi1Xbog
DKIM-Signature: a=rsa-sha256; bh=nJ0BE+Hw74QZw4DMiClZ0grePGxWCLY7x0tau66y2JY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782830742; v=1;
 b=H3eg6nRrtgUM9j0/31aQAdBZRjzumMXS6IoUTKW8DGQa0Ep5Uhfa1mtk2GmfkArnJZousksC
 pPPQbrOJ3j4SARvAtrM5tDqxwA0vmctW79j2r7X5uyWOjjajVg/vf6RnzIZixir1Dop/u8CATOm
 3KIQfN2bbhDPYXpbqOmqDU5eqxdvIsqcWS1xdSwgxVxVmMljz/7hfbt+Xq3YSbFV2V17wS5p/Jz
 euM3QqWoMy0F4WKGr9UrPLAeMS4gOcdSj5ghtMK43Aj0nAnSkjcMhPJDACr7DgnH8Ouze9hx4Y5
 OzAddIuL3y3G5cKc7pySW0tlj5SZKzjuM6hJ33i7qbWXA==
Received-SPF: pass client-ip=51.210.91.35; envelope-from=clg@kaod.org;
 helo=smtpout6.mo538.mail-out.ovh.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/30/26 15:57, Bin Meng wrote:
> m25p80 now consumes fast-read dummy phases as byte counts. The
> ASPEED SMC direct-read path still treated the CEx dummy field as
> raw cycles and emitted field * 8 SSI transfers. Convert the
> ASPEED dummy field to SSI byte transfers using the selected
> direct-read data width.
> 
> Fixes: ac2810defa9d ("aspeed/smc: handle dummy bytes when doing fast reads in command mode")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/ssi/aspeed_smc.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index d87fbd798c..f5abc9fcc9 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -449,19 +449,28 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
>       return addr;
>   }
>   
> -static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
> +static int aspeed_smc_flash_dummy_bytes(const AspeedSMCFlash *fl)
>   {
>       const AspeedSMCState *s = fl->controller;
>       uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->cs];
>       uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
>       uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
> -    uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
> +    uint32_t dummy_byte = (dummy_high << 2) | dummy_low;
>   
> -    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
> -        dummies /= 2;
> +    /*
> +     * Scale the controller dummy field to SSI byte transfers using the
> +     * direct-read dummy/address bus width.
> +     */
> +    if ((r_ctrl0 & CTRL_IO_QPI) ||
> +        ((r_ctrl0 & CTRL_IO_QUAD_DATA) &&
> +         (r_ctrl0 & CTRL_IO_QUAD_ADDR_DATA))) {
> +        dummy_byte *= 4;
> +    } else if ((r_ctrl0 & CTRL_IO_DUAL_DATA) &&
> +               (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA)) {
> +        dummy_byte *= 2;
>       }
>   
> -    return dummies;
> +    return dummy_byte;
>   }
>   
>   static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
> @@ -487,7 +496,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
>        * settings, let's check for fast read mode.
>        */
>       if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
> -        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
> +        for (i = 0; i < aspeed_smc_flash_dummy_bytes(fl); i++) {
>               ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
>           }
>       }

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


