Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D33CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9XK-0007Ce-HX; Mon, 12 Oct 2026 02:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9XI-00077K-3V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:24 -0400
Received: from smtpout10.mo538.mail-out.ovh.net ([51.210.91.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xG9XE-0005Hh-Gy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:29:23 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4j36xp4Bcwz5vbF;
 Mon, 12 Oct 2026 06:29:18 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 12 Oct 2026 06:29:18 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.65])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j36xp2vmFz1xp3; Mon, 12 Oct 2026 06:29:18 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E74A8941FDA; 
 Mon, 12 Oct 2026 06:29:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0047c7e9177-c02f-4009-abda-c9f2b5d369ab,
 A46244FAB654B0099A82D276BA68AD972340DB92) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <696266dd-5a57-42b3-aa33-7c851a259cad@kaod.org>
Date: Mon, 12 Oct 2026 08:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] hw/usb/aspeed-udc: Add trace events for the
 transfer paths
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
 <20261005064418.3060881-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261005064418.3060881-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9096708297752423435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTExQIOmOrxGw7upjPnLgJF+XauQiqkLipHOMz5rK93QK4NYPTUzRKh0359J+ZEqBR2RGsobn2GpvREXTHjb8ma7NQTMPT7FWsady6vi2jw70tFgx8+wME9aNeapC3oirH4WfJYe+usvpCA2eXWzV0orUrKT403Kh+B0Ut94R/8Bkn6UW1d5LZF7/+PPua+QKuvEs4Iz3/HakJB3SjGMReEum1ukiF316s34+5h1P6mQKNFMiJz71GyV85dxwFNYTdPKZGPVJshwTHbx+1dkx/zlhGiJtjV91gdmaU4aaDPj9EHDYHtO7OrS5dRkpoxo8YhbCNJQxYUB+uPyH1nKAAZzOdxH+q+AQuPeT2mrt0p9LkSltjGf6CyUQCXsfXom4e+M4RMUSsjDII7BUe7f4G5T+753uKi6RudPlr+8t/dwPxIPLHuTdGfFJygzROO7e49W7C3enmONb9HsucIGUllcfvjgk3V8MwhhA1uFZ3RNmu/YOBNfsHkRzOkyShylLI22q5+ywfF7+sqY8knqy1G/AhsS9M8W0LbOYpTS0TwMQYB9LwUnin+bqY3XseHMq8SXCz1HKbGHarU34jAUnHS6ojnV8w2gtcV3ivtNL1a4m7r8QFq3LvHKdrAP2kPEqZFSj1rmT/1TwoLV1vWp2uC6Wc5cKo9wMDnGxFXvUot13g
DKIM-Signature: a=rsa-sha256; bh=/0TS4KwisEsCTsjOCLha9WepZBo0xPWQ4kjeId+PBdI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791786558; v=1;
 b=AeEpX3bSz67B0vgx2eIilp86JzS4R6510xWAU5RQgrBoGg8bHpqzGCs78ZxtJzJmN7i398+O
 plTpdDeOm6RUFKS8xDDeTXW6Xmka5yZgSWD77mZLxY4fWgyt+ykoJeGS98lCGW70E3A0ZGJebxI
 JI7SkbQH+yAS0EOHtaEPc0yVJPlquwLb548qDJZpYPdOfua1t02LzZnt46WInQEnonxVdhp1UF7
 vjss8o42RolbFgBW8jOf05qeF19mQdOpeqeqWGs3OfRMu2jmE3ymZBWH6kGcrnQHTKf1BSvRI0O
 sXLi5ATIr2t4Oid/qn9CMOP1fJ6xTEy4oFY1DzG588Xiw==
Received-SPF: pass client-ip=51.210.91.39; envelope-from=clg@kaod.org;
 helo=smtpout10.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> The register traces show what the guest wrote, but not which transfer
> path the write chose, how much each call moved, or when the host gave up
> on a packet.
> 
> Add one event per path, so the name says which path ran and a single
> path can be enabled on its own: a kick, a transfer result, and a
> cancelled packet.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/aspeed-udc.c | 23 +++++++++++++++++++++++
>   hw/usb/trace-events |  7 +++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 09f5913aef..1c99e45d9a 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -565,6 +565,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_desc(AspeedUDCState *s,
>           aspeed_udc_raise_ep_ack(s, ep);
>       }
>   
> +    trace_aspeed_udc_ep_xfer_in_desc(ep, (uint32_t)p->actual_length,
> +                                     done ? "done" : "more");
> +
>       return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;
>   }
>   
> @@ -606,6 +609,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single(AspeedUDCState *s,
>        * buffer, and the next IN request sends the rest.
>        */
>       if (e->single_buf_off < buf_len) {
> +        trace_aspeed_udc_ep_xfer_in_single(ep,
> +                                           (uint32_t)p->actual_length,
> +                                           "buffer left");
>           return ASPEED_UDC_XFER_DONE;
>       }
>   
> @@ -619,6 +625,9 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_in_single(AspeedUDCState *s,
>                                           PROC_STS, EP_DMA_CTRL_STS_TX_IDLE);
>       aspeed_udc_raise_ep_ack(s, ep);
>   
> +    trace_aspeed_udc_ep_xfer_in_single(ep, (uint32_t)p->actual_length,
> +                                       "done");
> +
>       return ASPEED_UDC_XFER_DONE;
>   }
>   
> @@ -664,9 +673,15 @@ static AspeedUDCXferResult aspeed_udc_ep_xfer_out_single(AspeedUDCState *s,
>       aspeed_udc_raise_ep_ack(s, ep);
>   
>       if ((uint32_t)p->actual_length >= pktiov->size) {
> +        trace_aspeed_udc_ep_xfer_out_single(ep,
> +                                            (uint32_t)p->actual_length,
> +                                            "done");
>           return ASPEED_UDC_XFER_DONE;
>       }
>   
> +    trace_aspeed_udc_ep_xfer_out_single(ep, (uint32_t)p->actual_length,
> +                                        "more");
> +
>       return ASPEED_UDC_XFER_MORE;
>   }
>   
> @@ -686,6 +701,8 @@ static void aspeed_udc_ep_in_kick_desc(AspeedUDCState *s, int ep,
>       uint32_t cur_rptr = FIELD_EX32(old_val, EP_DMA_STS, RPTR);
>       USBPacket *p = e->pkt;
>   
> +    trace_aspeed_udc_ep_in_kick_desc(ep);
> +
>       /*
>        * A normal kick only sets the write pointer and leaves the read-pointer
>        * field 0 (the read pointer is ours to advance). The guest resets the ring
> @@ -735,6 +752,8 @@ static void aspeed_udc_ep_in_kick_single(AspeedUDCState *s, int ep)
>       AspeedUDCEP *e = &s->ep[ep];
>       USBPacket *p = e->pkt;
>   
> +    trace_aspeed_udc_ep_in_kick_single(ep);
> +
>       /* Do nothing if no host request is waiting, or no buffer was queued. */
>       if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {
>           return;
> @@ -770,6 +789,8 @@ static void aspeed_udc_ep_out_kick_single(AspeedUDCState *s, int ep)
>       AspeedUDCEP *e = &s->ep[ep];
>       USBPacket *p = e->pkt;
>   
> +    trace_aspeed_udc_ep_out_kick_single(ep);
> +
>       /* nothing to do unless an OUT packet is waiting and a buffer is ready */
>       if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {
>           return;
> @@ -1155,6 +1176,8 @@ static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)
>       AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
>       int i;
>   
> +    trace_aspeed_udc_cancel_packet(p->ep->nr);
> +
>       if (s->ep0_packet == p) {
>           s->ep0_packet = NULL;
>       }
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index aa260dacad..661011b07e 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -395,3 +395,10 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_idx) "ep
>   aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t iov) "ep %u, rptr %u, wptr %u, iov %u"
>   aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_t iov) "ep %u, wptr %u, avail %u, iov %u"
>   aspeed_udc_ep_ack(unsigned ep) "ep %u"
> +aspeed_udc_ep_in_kick_desc(int ep) "ep %d"
> +aspeed_udc_ep_in_kick_single(int ep) "ep %d"
> +aspeed_udc_ep_out_kick_single(int ep) "ep %d"
> +aspeed_udc_ep_xfer_in_desc(int ep, uint32_t sent, const char *res) "ep %d, sent %u, %s"
> +aspeed_udc_ep_xfer_in_single(int ep, uint32_t sent, const char *res) "ep %d, sent %u, %s"
> +aspeed_udc_ep_xfer_out_single(int ep, uint32_t received, const char *res) "ep %d, received %u, %s"
> +aspeed_udc_cancel_packet(int ep) "ep %d"

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



