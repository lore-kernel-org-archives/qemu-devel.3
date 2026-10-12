Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D399CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9WY-0005Dr-79; Mon, 12 Oct 2026 02:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9WW-0005AA-NC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:36 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9WV-0005DD-3z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:28:36 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j36wy04KRz886f;
 Mon, 12 Oct 2026 06:28:34 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:28:33 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.177])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4j36wx6Ngrz6Mbv;
 Mon, 12 Oct 2026 06:28:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 7F33A1922C93; Mon, 12 Oct 2026 06:28:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005a86a9ff3-24ae-437f-bde9-069ac6676dbd,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <064a2c68-35b9-401e-b089-1ff0e6af6688@kaod.org>
Date: Mon, 12 Oct 2026 08:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] hw/usb/aspeed-udc: Store the EP_DMA_STS write
 first
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005064418.3060881-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9084041924188875787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTExQIOmOrxGw7upjPnLgJF+XauQiqkLipHOMz5rK93QK4NYPTUzRKh0359J+ZEqBR2RGsobn2GpvREXTHjb8ma7NQTMPT7FWsady6vi2jw70tFgx8+wME9aNeapC3oirH4WfJYe+usvpCA2eXWzV0orUrKT403Kh+B0Ut94R/8Bkn6UW1d5LZF7/+PPua+QKuvEs4Iz3/HakJB3SjGMReEum1ukiF316s34+5h1P6mQKNFMiJz71GyV85dxwFNYTdPKZGPVJshwTHbx+1dkx/zlhGiJtjV91gdmaU4aaDPj9EHDYHtO7OrS5dRkpoxo8YhbCNJQxYUB+uPyH1nKAAZzf/Kip591s2WlQXG/05zx06xN2AIaEWYSMNoq5It81JQxtZrvCXHhH5wt/clcSLHssOyItcFXXwEX8LI7kxlQl3mzOSh71ThGr1wbAAcVRHTej+rfmBu2ow7DA0b8Pp39sCesTCQZ5lvASbsxVHmnJKlJkZ/3RPvm7AlaiJpDnlfu6uHRH0Cwrt5ZJ17XDMOINZCt/wLmaHeGobLX0Qygt8hkD+VafArDsdKo0511azkEBPCvm+uI8HUbuqNzWzMBtCw+1cjHqDyJssz31SA4OgZ/0MRmwQ6HODUQxjYQ80evykQtySzVQmswUxg35g//cvumIaJ88wyRC2wIUaH6jw
DKIM-Signature: a=rsa-sha256; bh=3GhEtNjpSw8NcxyP+QYis7VCzUL0GeLADC0BpTvQW+c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786514; v=1;
 b=WzNC+3MjYVcbp3JPk6t2ChLNtmaCM7Lp3kiXrW/2mo6VHYPReglDaLG+UZUYR/xS22fzIop6
 mM/ehtkAj/ZeVPZb+CKNIWb/044Pemacep0/Uv29itLSQh2qzpLVgegqm+SjaYBLf9SORtRl2L1
 S/mg2mCMY32u5vxyrq6H9UTfiC2HXljn/ENTQuU/Qg+kIqZ/wvO4OEq+bBafK8diNRk1/apticb
 jOQZNzgjedRuvmhEY6urGpp5PcrAWXyADzBgMzVe/iJ5h7rvZ1J8YTn1oyDke3lOSpVeo4iHoNj
 IosUevvDMMOaJYsr1+JFAZYM+DV90BK/nLd/3INQfqRXQ==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
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

On 10/5/26 08:44, Jamin Lin wrote:
> The other helpers run after EP_DMA_STS is written. The descriptor mode
> kick did not: it had to run before the write, because it stored the
> value itself.
> 
> Write the register first in every case, then call the helper. The order
> is now the same everywhere, so a later change cannot go wrong on it,
> and the code is easier to maintain.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/aspeed-udc.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index b43f077c2d..4572914e16 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -619,12 +619,13 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_single(AspeedUDCState *s,
>    * If the request needs more data than was queued, keep it parked and wait for
>    * the next kick.
>    */
> -static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t val)
> +static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep,
> +                                       uint32_t old_val)
>   {
>       AspeedUDCEP *e = &s->ep[ep];
> -    uint32_t cur_rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> -    uint32_t new_rptr = FIELD_EX32(val, EP_DMA_STS, RPTR);
> -    uint32_t new_wptr = FIELD_EX32(val, EP_DMA_STS, WPTR);
> +    uint32_t new_rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> +    uint32_t new_wptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);
> +    uint32_t cur_rptr = FIELD_EX32(old_val, EP_DMA_STS, RPTR);
>       USBPacket *p = e->pkt;
>   
>       /*
> @@ -641,8 +642,9 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep, uint32_t val)
>           cur_rptr = new_rptr;
>           e->desc_off = 0;
>       }
> -    /* store the guest's write, but keep our own read pointer */
> -    e->regs[R_EP_DMA_STS] = FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);
> +    /* keep our own read pointer */
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS,
> +                                       RPTR, cur_rptr);
>   
>       /* nothing to do unless an IN packet is waiting and the ring has data */
>       if (!p || cur_rptr == new_wptr) {
> @@ -715,6 +717,7 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
>       AspeedUDCEP *e = opaque;
>       AspeedUDCState *s = container_of(e - e->index, AspeedUDCState, ep[0]);
>       uint32_t reg = offset >> 2;
> +    uint32_t old_val = e->regs[reg];
>       uint32_t val = data;
>   
>       trace_aspeed_udc_ep_write(e->index, offset, val);
> @@ -725,12 +728,12 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
>           break;
>       case R_EP_DMA_STS:
>           val &= 0x77ffffff;
> +        e->regs[reg] = val;
>           if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
>               /* IN, descriptor-list mode */
> -            aspeed_udc_ep_in_kick_desc(s, e->index, val);
> +            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);
>           } else {
>               /* OUT, single-stage mode */
> -            e->regs[reg] = val;
>               aspeed_udc_ep_out_kick_single(s, e->index);
>           }
>           break;

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



