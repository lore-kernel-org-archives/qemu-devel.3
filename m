Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411CECA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9WA-0004uj-Hr; Mon, 12 Oct 2026 02:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9W7-0004t9-3k
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:11 -0400
Received: from smtpout1.mo538.mail-out.ovh.net ([51.210.91.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9W4-0005Af-BE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:10 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4j36wG0S15z5xTL;
 Mon, 12 Oct 2026 06:27:57 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:27:57 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.162])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j36wF2sW0z46Xg;
 Mon, 12 Oct 2026 06:27:57 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 11AC22402C97; Mon, 12 Oct 2026 06:27:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005d4d8aa55-6d1a-48d2-839e-ce36a59ff65f,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6fda4b41-9c70-4312-8e58-35690af36e1b@kaod.org>
Date: Mon, 12 Oct 2026 08:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hw/usb/aspeed-udc: Mask the reserved bits on
 register writes
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005064418.3060881-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9073908828282858507
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGiAXR8Ifyh3wPP9AAtd2qH1u9lmye61BdmBwEWKdch04gisrlgLmuw3IEbF5uLpFHrk/uRdlOVR+kDsI+xu3nKO/fuVVjLG3PX2zxWCLwDgNCdKzoId2UfguIikkocDaGek3KRESdjB3ye3EDci79JTh6LPNu/Rghgk0abhqqr80Pea4nucPYwHMVVg0Eaf8zTI+2acLY2ARg8HmR48hjdSZpvFhw0Vl0zTGjx2Ms9ajql6SFHcaPjL4Jw9oXgCpnc2T02IAJ+ZUfVKk1AvDf5wTzVePQapJcczEAVacoOUY6Gy14P9ClMXgBs8K7cujMg/a9cD0lNXPrB82s9yi9GAT1yy5bDESdN4xSO995F20DrNaIKHYdh5MOCAbCMoFJ2lGixPL3xD1zGpDLWRADhMhEjh3Z9O/fd025Fi+aATmkZQRnyYqlTq7fLfix+EE6DPKYZlqw8Z031aOp2Ksq+JXl1jKKkjHAa4xJwfjD3WsKtkbNOMrPrs49LgFVPXfLabfdMxHVFScGoFcav6SVtU1CLNlUNIBsM+bYcvdoIS9Q+Lz1pouoAUpYQMYIi5jSiaIxUDpyYxyQ3oq0BEPnW2CX/EkyNFLKyXwVwwPQ84ImICVvuddo6aDm1ms81g9JxJMv6xaDiInns5w2hUir9x25oh+P2w9ES+hSBW5xD5w
DKIM-Signature: a=rsa-sha256; bh=g5CEs4ABQUum+ZXeW7UVbzw7MPGexFZJkFnjqPZpikc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786479; v=1;
 b=l5PEJ6PrwkBw6+VGdHD8g69DZzqftUykyNbdY8RUKa0hb72DqAkJF12hxfh+5kkOC7YF0C3x
 F7FU/KZkIpPZQ26Q+KKsWB7+iEmhMGfWkFJkq6MxO6Ao8JvBvCdGXMvCmqFLTIpOFbRzaeAYzRb
 FlNwoqwBhLrKizQGUVfTsGGYrUOmWrSOq4svYH/SBm9V7Eo3tJq9piXTvXdSi5OhKRQ9l5Qtehs
 XpJRYPpKuXzGhxi6R7Oc9QAn0A/ve6MmyinnOarPW1WL5kmDTuuZLYRtqFs7teRjISUuuVJCrBF
 4IKyIbRXw5nJitcfZ+C6VLbubD6tUuTOykRYU1Zv7jBiA==
Received-SPF: pass client-ip=51.210.91.30; envelope-from=clg@kaod.org;
 helo=smtpout1.mo538.mail-out.ovh.net
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 08:44, Jamin Lin wrote:
> Writes to the interrupt registers were not masked, so a guest could set
> a reserved bit and read it back. The hardware returns 0 for those.
> 
> Mask each one to the bits the datasheet marks read/write:
> 
>    UDC_IER         17, 16, 8:6, 4:0
>    UDC_ISR         8:6, 4:0
>    UDC_EP_ACK_IER  3:0
>    UDC_EP_NAK_IER  3:0
>    UDC_EP_ACK_ISR  3:0
>    UDC_EP_NAK_ISR  3:0
> 
> UDC_ISR bits 17 and 16 summarise the endpoint pool. They are read only,
> so a write cannot clear them.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/aspeed-udc.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 355512822b..95fe823534 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -319,14 +319,24 @@ static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
>           s->regs[R_UDC_FUNC_CTRL] = val;
>           break;
>       case R_UDC_IER:
> +        val &= 0x000301df;
> +        s->regs[reg] = val;
> +        aspeed_udc_update_irq(s);
> +        break;
> +    case R_UDC_ISR:
> +        val &= 0x000001df;
> +        s->regs[reg] &= ~val;
> +        aspeed_udc_update_irq(s);
> +        break;
>       case R_UDC_EP_ACK_IER:
>       case R_UDC_EP_NAK_IER:
> +        val &= 0x0000000f;
>           s->regs[reg] = val;
>           aspeed_udc_update_irq(s);
>           break;
> -    case R_UDC_ISR:
>       case R_UDC_EP_ACK_ISR:
>       case R_UDC_EP_NAK_ISR:
> +        val &= 0x0000000f;
>           s->regs[reg] &= ~val;
>           aspeed_udc_update_irq(s);
>           break;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



