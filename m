Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66370606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=IUT4Zs96
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMBGh-0005Xf-R0; Wed, 28 Oct 2026 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xMBGc-0005Ww-3j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:33:08 -0400
Received: from smtpout3.mo540.mail-out.ovh.net ([51.210.91.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xMBGZ-0000tO-QR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:33:05 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4jFLF84SYLz45g2;
 Wed, 28 Oct 2026 21:33:00 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 28 Oct 2026 21:33:00 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.236])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jFLF83cpBz46VM; Wed, 28 Oct 2026 21:33:00 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 7FF1F12E320B;
 Wed, 28 Oct 2026 21:32:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002a2655b0d-829a-48f1-a3a3-0c59cc2c8ba1,
 E08929C5676352A1F51837021B168DD299C323AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <d804bfa0-c44d-4f52-b647-f7e8b8c7201c@kaod.org>
Date: Wed, 28 Oct 2026 22:32:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/i2c/aspeed: fix DMA transfer in non-packet mode
To: Timur Maksimov <gessingate@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-5-07deed1dff60@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-5-07deed1dff60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 7641482671416519725
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE3uL7WlwYiX8hvkwz2ilpBGqZov9HiKC5f4p+JoCuMSjLUnjjQU01Alj6KVFNUuvKgYvoMaoDvZNN255iQ9GD2/kZZnCHFWXYXxPZWFvmZJJthjFNa3BS1m16bmV9hn1kokeFoO4OIEvLK0tNv3U2KFx8fREl7N6bedBjc5bZbAvRHHqQSYAMBw2nFCg+euZXUBP3V4TOKuyrnVPKXkV+54hrKEpasY1fZEimb/oToTjK8z41YPBnM7Ssjy93k+PLl8LujFD0fdXUO4IoTaYb4bO6scGgJuo05usgDuYlStIQM9H75Ou7K9SMB1gDI6jr/cUYpjvXs9NIw/HN2uimqH0rhlCOCEGLBxtuDBRrjOpoZq4VR1giMgNtnO0LWKqDM2Yu1NysiMy5VRz3uPjf9MiN5tivsLf2DXN8REhIumj4bpoTwf6f4EJMIO2JwCsb8IWSNC83izB++SlbwiO8PUsImzYDduBMIj98ZZuA9otC10uS+E7IJDtOjLc5QkPWUot9GeMqdK73Nzrujhqk2tYJH7CxpBh3o+kDN7A1112Z7vkhaOi/ln/F9kohePciSalMc7hvtJh/nQ9MPsKFGYgabcVnc3PY1/RYScvRoMqma1yfpVqEmcZigxSRQnh+0KuAQ1Y+77YA0LdMFE3CRn4wDZ298BrGwDP7ZaHxfHg
DKIM-Signature: a=rsa-sha256; bh=drcDv7zCP54WZZ73ZUaOym5TlatNdxXkRAeZbofnVao=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793223181; v=1;
 b=IUT4Zs96EgqY4yn2y37B02IRgFXEo3JQM5cdCmy21m1sAaD7KPO9Mw20ICHCHq7blusEYag0
 XSADu4wT3qAhwC6SRvnlM00cDm/QrgSpFn/KNhkqyz64pS1MNaeVYpzXOE2oAF91uduVPY8x8JJ
 QkstCwnDwAFDG/r308mYsVF21U7ai3a/b7epKhSWKaLPptFBSPxRvsQfoI+V/TtfpommezG+TNm
 L1g8e2xhZA0ydZKZPCrVB1DJHnbPGghPGIrLaHdNW0sp3+ywzijcxkNZ0t1R5HF/MmZkQVlYAVo
 apOmSoSTf23CHMgUCDKYjcLFUAnPw2t7flSOA4Qsz2sKw==
Received-SPF: pass client-ip=51.210.91.52; envelope-from=clg@kaod.org;
 helo=smtpout3.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 20:50, Timur Maksimov wrote:
> Avoid calling aspeed_i2c_set_tx_dma_dram_offset twice in non-packet mode
> where this function is called first in aspeed_i2c_get_addr.
> Also fix writing to I2CD_DMA_ADDR in old register mode.

This should be 2 changes.

> Signed-off-by: Timur Maksimov <gessingate@gmail.com>
> ---
>   hw/i2c/aspeed_i2c.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 510758fb7a..a2b4c8b576 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -416,7 +416,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, bool send_addr)
>           if (aspeed_i2c_is_new_mode(bus->controller)) {
>               ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
>           }
> -        aspeed_i2c_set_tx_dma_dram_offset(bus);
> +        if (!send_addr) {
> +            aspeed_i2c_set_tx_dma_dram_offset(bus);
> +        }
>           while (bus->regs[reg_dma_len]) {
>               uint8_t data;
>               ret = aspeed_i2c_dma_read(bus, &data);


Fixes: efea7ddb4689 ("hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address")

> @@ -1070,11 +1072,13 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->pending_intr_sts |= old_intr & cmd_intr;
>           aspeed_i2c_bus_raise_interrupt(bus);
>           break;
> +
>       case A_I2CD_DMA_ADDR:
>           if (!aic->has_dma) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
>               break;
>           }
> +        bus->regs[R_I2CD_DMA_ADDR] = value;
>           break;
>   
>       case A_I2CD_DMA_LEN:
> 

and

Fixes: 2260fc6ff3ff ("aspeed: i2c: Use reg array instead of individual vars")

Thanks,

C.

