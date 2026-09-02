Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8916CC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1dmq-0001IE-Si; Wed, 02 Sep 2026 01:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1dmp-0001Hn-3p
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:45:27 -0400
Received: from smtpout7.mo539.mail-out.ovh.net ([51.210.91.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1dmk-0000sW-T2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:45:26 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hZWsT11Tjz42lj;
 Wed,  2 Sep 2026 05:45:16 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  2 Sep 2026 05:45:16 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.64])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hZWsS3RWpz6MWK; Wed,  2 Sep 2026 05:45:16 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 0BC412403FD6; Wed,  2 Sep 2026 05:45:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S00525b370eb-c767-4e12-8438-4c9511401356,
 E05C9764BA5542D7874F2BFBE20C1A6231857223) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c8092889-0649-4439-ae67-422b0d38a520@kaod.org>
Date: Wed, 2 Sep 2026 07:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
 <20260902021542.3194812-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260902021542.3194812-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13252967807710768367
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEB7mnZhBjO7cCXemOAPoozWgmBWRVgq317Uq8vSxWHbIycAlg7q7a50t8pNxnLUW9UeqRFD2EEZo6E4jtcuXZNGVKVFoqtCvywK3HIMOWJj6ePvouhIwlfgLJqn9YS+UHoWM3VYtucYl+gA8eG23b3eqJGL3N3i7fT9ZRzqBqSq2uPAz706Kh5trzKVleyEIzUF7c98IzA9pZC+0SLDmLniowh3Ad90+50FLMnzp3+1TrvkFUGoaG2/bdqJspaETOnsSZVaj+2WenAj2jv3W9P3By8j5psgDiz9IRquKJfzTMXB++R5r9Ng+2V6lKxyMcjl1zJ6Ey0p9AW1f1ShiAGkRVL5HjwF6VKspOUBVWaDvXNccMInw1acjWSvN/N426YB8m8vhIU2+mo6rx46A4jJjhVMJ/tO0r60lQ/wMh191uwbZCSHX+Ym5PyooNXWPd9YFP3O7MnSAanIW1wGlqweLDdOrxwsmwyKodQZfvNzbockg+5kXmiZAQ8gAkSvCIY0pHSleZ4226up6oV7Q6wVGG5E8mzZOuOeLhho/+qGKyIOShf02MOEeTSk4Vf1D3y5r6yYECODUwoF7BOXuPZg+kKXhb7CeMGjRrAMkBAz1f4REYNCdobXPi0h76V7DMesjHGCtO4tfjugIb1dFPqRyYBiqmauyEdeu8OnlqiNw
DKIM-Signature: a=rsa-sha256; bh=zfPftJB88P7DKmKQ78Drs+oUvm7mQGy20NLpKViedUo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788327918; v=1;
 b=LrhHCV8NInHcs8ecP7CNoLr6xZGoGZ68n6vvsEnEa//HDhxUX9YIUsOusWAu4ElxOk9SXvYr
 Yh70MczVI/n7jmO4EfTJhj7msa24SKpDaHQY+tUdcJf1qtdit/zwbCnw/Z5m0qH9X08uzG2VcUO
 JpAFzYylVE+0VKK1fHmnV/I3b3706WTMDJGJ2eE3AcA6cRLFyvW/08J7rmzYSlzX+0K0WkOsFe8
 VR5m56B9nCsp1t2E4FtfFDZpyhGJ23vjy521GpVla1x5fxUKRUvAbvslaMD65wGZ12gxFv28Kp9
 AW/Qlh+EeX1zrX2NaykVAdyHIB6wGqdcV2uVWhNYMpHWA==
Received-SPF: pass client-ip=51.210.91.46; envelope-from=clg@kaod.org;
 helo=smtpout7.mo539.mail-out.ovh.net
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

On 9/2/26 04:15, Jamin Lin wrote:
> Add the bulk data plane for the four programmable endpoints. The gadget
> driver queues IN data through the descriptor-list DMA ring and arms OUT
> buffers through the single-stage DMA registers; host bulk transactions
> are served from / delivered into those.
> 
> The DMA mode is taken from EP_DMA_CTRL.DESC_OP_EN: IN endpoints use the
> descriptor-list ring, OUT endpoints use single-stage buffers.
> 
> A transfer larger than one host packet is served across several polls,
> with the host packet parked (USB_RET_ASYNC) until the gadget queues (IN)
> or arms (OUT) more data, then completed from the matching DMA kick.
> 
> With this the gadget data endpoints work, e.g. a mass-storage gadget can
> be enumerated and read/written end to end.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/usb/aspeed-udc.h |   8 +
>   hw/usb/aspeed-udc.c         | 456 +++++++++++++++++++++++++++++++++++-
>   hw/usb/trace-events         |   4 +
>   3 files changed, 463 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
> index ab9d016c61..7701c1aa34 100644
> --- a/include/hw/usb/aspeed-udc.h
> +++ b/include/hw/usb/aspeed-udc.h
> @@ -42,6 +42,14 @@ typedef struct AspeedUDCEP {
>       MemoryRegion mr;
>       uint32_t regs[ASPEED_UDC_EP_NR_REGS];
>       int index;
> +
> +    /*
> +     * host packet parked until the guest gadget driver queues (IN) or
> +     * arms (OUT) data
> +     */
> +    USBPacket *pkt;
> +    /* bytes of the current IN descriptor already served */
> +    uint32_t desc_off;
>   } AspeedUDCEP;
>   
>   struct AspeedUDCGadget {
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 70a2296062..4c90b4f4c2 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -72,12 +72,37 @@ REG32(EP_DMA_CTRL, 0x04)
>       FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)
>       FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)
>   REG32(EP_DMA_BUFF, 0x08)
> +    FIELD(EP_DMA_BUFF, BASE_ADDR,           0, 31)
>   REG32(EP_DMA_STS, 0x0C)
>       FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)
>       FIELD(EP_DMA_STS, RPTR,                 8, 8)
>       FIELD(EP_DMA_STS, WPTR,                 0, 8)
>   
> -#define ASPEED_UDC_EP0_MAXPKT      64
> +#define ASPEED_UDC_EP0_MAXPKT   64
> +#define ASPEED_UDC_EP_MAXPKT    1024
> +
> +/* DMA descriptor ring (256-stage mode) and descriptor data limits */
> +#define ASPEED_UDC_DESCS_COUNT  256
> +#define ASPEED_UDC_DESC_MAX_LEN 4096
> +
> +/* DMA processing-status idle codes */
> +#define EP_DMA_CTRL_STS_RX_IDLE 0x0
> +#define EP_DMA_CTRL_STS_TX_IDLE 0x8
> +
> +/* DMA descriptor (DES1) fields, in guest memory */
> +#define ASPEED_EP_DESC1_IN_LEN(ctrl)   ((ctrl) & 0x1fff)
> +/* interrupt-on-completion */
> +#define ASPEED_EP_DESC1_INTR           BIT(31)
> +
> +/* Result of moving a host data packet through an endpoint's DMA */
> +typedef enum {
> +    /* whole packet transferred */
> +    ASPEED_UDC_XFER_DONE,
> +    /* not finished, keep parked */
> +    ASPEED_UDC_XFER_MORE,
> +    /* DMA failed */
> +    ASPEED_UDC_XFER_ERROR,
> +} AspeedUDCXferResult;
>   
>   static void aspeed_udc_update_irq(AspeedUDCState *s)
>   {
> @@ -97,6 +122,14 @@ static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)
>       aspeed_udc_update_irq(s);
>   }
>   
> +static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, int ep)
> +{
> +    trace_aspeed_udc_ep_ack(ep);
> +    s->regs[R_UDC_EP_ACK_ISR] |= BIT(ep);
> +    s->regs[R_UDC_ISR] |= R_UDC_ISR_EP_POOL_ACK_MASK;
> +    aspeed_udc_update_irq(s);
> +}
> +
>   /*
>    * System bus device: MMIO register interface (guest gadget-driver facing)
>    */
> @@ -330,6 +363,287 @@ static const MemoryRegionOps aspeed_udc_ops = {
>       },
>   };
>   
> +/*
> + * Copy len bytes from guest memory at addr into the IN packet, going through
> + * a bounce buffer one buf-full at a time. Returns false on DMA failure.
> + */
> +static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s, int ep, uint32_t addr,
> +                                      uint32_t len, USBPacket *p)
> +{
> +    uint8_t buf[ASPEED_UDC_EP_MAXPKT];
> +    uint32_t copied = 0;
> +    uint32_t seg;
> +
> +    while (copied < len) {
> +        seg = MIN(len - copied, sizeof(buf));
> +        if (address_space_read(&s->dram_as, addr + copied,
> +                               MEMTXATTRS_UNSPECIFIED, buf, seg) != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: ep %d IN data DMA read failed\n", __func__,
> +                          ep);
> +            return false;
> +        }
> +        usb_packet_copy(p, buf, seg);
> +        copied += seg;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * IN transfer: send data to the host by filling its IN packet from the
> + * buffers the guest gadget driver queued in the descriptor ring (from the
> + * read pointer to the write pointer).
> + *
> + * One host packet can be bigger than one descriptor's buffer, so we copy from
> + * several descriptors in a row until the packet is full or the ring is empty.
> + * If a descriptor is too big for the space left in the packet, we copy only
> + * part of it now and copy the rest on the next call; desc_off remembers how
> + * far we got. We move the read pointer to the next descriptor only after a
> + * descriptor is fully copied, so the guest gadget driver can read the pointer
> + * and see how much was sent.
> + *
> + * This function raises the endpoint ACK by itself when the ring becomes empty
> + * or when a descriptor asks for an interrupt.
> + */
> +static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep,
> +                                                 USBPacket *p)
> +{
> +    QEMUIOVector *pktiov = p->combined ? &p->combined->iov : &p->iov;
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t mps = FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);
> +    uint32_t wptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);
> +    uint32_t rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> +    uint32_t desc_base = e->regs[R_EP_DMA_BUFF];
> +    uint32_t desc_addr;
> +    uint32_t remaining;
> +    uint32_t desc_ctrl;
> +    uint32_t pkt_space;
> +    /* des_0: data buffer base address, des_1: control/status */
> +    uint32_t desc[2];
> +    uint32_t offset;
> +    uint32_t chunk;
> +    uint32_t dlen;
> +    bool done = false;
> +    bool ack = false;
> +
> +    if (mps == 0) {
> +        /* a MAX_PKT field of 0 means the maximum packet size */
> +        mps = ASPEED_UDC_EP_MAXPKT;
> +    }
> +
> +    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);
> +
> +    /* walk the queued descriptors, filling the packet */
> +    while (rptr != wptr) {
> +        if (address_space_read(&s->dram_as, desc_base + rptr * sizeof(desc),
> +                               MEMTXATTRS_UNSPECIFIED, desc,
> +                               sizeof(desc)) != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: ep %d descriptor DMA read failed\n",
> +                          __func__, ep);
> +            return ASPEED_UDC_XFER_ERROR;
> +        }
> +        desc_addr = le32_to_cpu(desc[0]) & R_EP_DMA_BUFF_BASE_ADDR_MASK;
> +        desc_ctrl = le32_to_cpu(desc[1]);
> +        dlen = ASPEED_EP_DESC1_IN_LEN(desc_ctrl);
> +        offset = e->desc_off;
> +        /* how much to copy: min(descriptor bytes left, packet space left) */
> +        remaining = dlen > offset ? dlen - offset : 0;
> +        pkt_space = pktiov->size > (uint32_t)p->actual_length ?
> +                    pktiov->size - (uint32_t)p->actual_length : 0;
> +        chunk = MIN(remaining, pkt_space);
> +
> +        if (!aspeed_udc_ep_copy_to_pkt(s, ep, desc_addr + offset, chunk, p)) {
> +            return ASPEED_UDC_XFER_ERROR;
> +        }
> +        e->desc_off += chunk;
> +
> +        if (e->desc_off < dlen) {
> +            /*
> +             * The packet ran out of space in the middle of this descriptor,
> +             * so only part of it was copied. Stop here, and leave the read
> +             * pointer on this descriptor: the next call resumes copying the
> +             * rest (desc_off remembers how far we got).
> +             */
> +            done = true;
> +            break;
> +        }
> +
> +        /*
> +         * This descriptor was copied in full. Advance the read pointer to the
> +         * next descriptor and reset desc_off so it starts from the beginning.
> +         */
> +        rptr = (rptr + 1) % ASPEED_UDC_DESCS_COUNT;
> +        e->desc_off = 0;
> +        if (desc_ctrl & ASPEED_EP_DESC1_INTR) {
> +            ack = true;
> +        }
> +        /*
> +         * This descriptor is shorter than the max packet size, i.e. a short
> +         * (or zero-length) packet. In USB that marks the end of the transfer,
> +         * so stop here.
> +         */
> +        if (dlen < mps) {
> +            done = true;
> +            break;
> +        }
> +        /*
> +         * The packet is now completely full, so the host has received all the
> +         * data it asked for. Stop here.
> +         */
> +        if ((uint32_t)p->actual_length >= pktiov->size) {
> +            done = true;
> +            break;
> +        }
> +    }
> +
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS,
> +                                       RPTR, rptr);
> +    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
> +                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE);
> +    /* The guest gadget driver completes its request when the ring drains */
> +    if (rptr == wptr) {
> +        ack = true;
> +    }
> +    if (ack) {
> +        aspeed_udc_raise_ep_ack(s, ep);
> +    }
> +
> +    return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;
> +}
> +
> +/*
> + * OUT transfer: receive data from the host by copying its OUT packet into the
> + * buffer the guest gadget driver set up (single-stage mode).
> + *
> + * A host packet can be bigger than one buffer, so we copy at most PKT_SIZE
> + * bytes per call, continuing from where the last call stopped
> + * (p->actual_length). The caller keeps the packet parked until it is fully
> + * copied.
> + */
> +static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int ep,
> +                                                  USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t chunk = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_SIZE);
> +    uint32_t remaining = p->iov.size - (uint32_t)p->actual_length;
> +    uint32_t data_buf_addr = e->regs[R_EP_DMA_BUFF];
> +    uint32_t len = MIN(remaining, chunk);
> +    g_autofree uint8_t *buf = g_malloc(len);
> +
> +    if (data_buf_addr && len) {
> +        usb_packet_copy(p, buf, len);
> +        if (address_space_write(&s->dram_as, data_buf_addr,
> +                                MEMTXATTRS_UNSPECIFIED, buf,
> +                                len) != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: ep %d OUT data DMA write failed\n",
> +                          __func__, ep);
> +            return ASPEED_UDC_XFER_ERROR;
> +        }
> +    }
> +
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS],
> +                                       EP_DMA_STS, PKT_SIZE, len);
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(e->regs[R_EP_DMA_STS],
> +                                       EP_DMA_STS, WPTR, 0);
> +    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
> +                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE);
> +    aspeed_udc_raise_ep_ack(s, ep);
> +
> +    if ((uint32_t)p->actual_length >= p->iov.size) {
> +        return ASPEED_UDC_XFER_DONE;
> +    }
> +
> +    return ASPEED_UDC_XFER_MORE;
> +}
> +
> +/*
> + * IN kick: the guest gadget driver wrote EP_DMA_STS to tell us it queued more
> + * IN data to send to the host. If a host IN request is already waiting
> + * (parked because there was no data before), send the data now and finish it.
> + * If the request needs more data than was queued, keep it parked and wait for
> + * the next kick.
> + */
> +static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t cur_rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> +    uint32_t new_rptr = FIELD_EX32(val, EP_DMA_STS, RPTR);
> +    uint32_t new_wptr = FIELD_EX32(val, EP_DMA_STS, WPTR);
> +    USBPacket *p = e->pkt;
> +
> +    /*
> +     * A normal kick only sets the write pointer and leaves the read-pointer
> +     * field 0 (the read pointer is ours to advance). The guest resets the ring
> +     * by writing a read pointer that is non-zero and equal to the write
> +     * pointer.
> +     *
> +     * We check non-zero as well as equal: on a normal kick whose write pointer
> +     * just wrapped back to 0, both fields would be 0, so an "equal" test alone
> +     * would look like a reset by mistake.
> +     */
> +    if (new_rptr != 0 && new_rptr == new_wptr) {
> +        cur_rptr = new_rptr;
> +        e->desc_off = 0;
> +    }
> +    /* store the guest's write, but keep our own read pointer */
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);
> +
> +    /* nothing to do unless an IN packet is waiting and the ring has data */
> +    if (!p || cur_rptr == new_wptr) {
> +        return;
> +    }
> +
> +    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {
> +    case ASPEED_UDC_XFER_DONE:
> +        e->pkt = NULL;
> +        p->status = USB_RET_SUCCESS;
> +        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +        break;
> +    case ASPEED_UDC_XFER_ERROR:
> +        e->pkt = NULL;
> +        p->status = USB_RET_IOERROR;
> +        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +        break;
> +    case ASPEED_UDC_XFER_MORE:
> +        break;
> +    }
> +}
> +
> +/*
> + * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer for
> + * OUT data. If an OUT packet is already waiting (parked because there was no
> + * buffer before), copy its data into the buffer now and finish it. If the
> + * packet has more data than fits, keep it parked and wait for the next buffer.
> + */
> +static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    USBPacket *p = e->pkt;
> +
> +    /* nothing to do unless an OUT packet is waiting and a buffer is ready */
> +    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {
> +        return;
> +    }
> +
> +    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {
> +    case ASPEED_UDC_XFER_DONE:
> +        e->pkt = NULL;
> +        p->status = USB_RET_SUCCESS;
> +        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +        break;
> +    case ASPEED_UDC_XFER_ERROR:
> +        e->pkt = NULL;
> +        p->status = USB_RET_IOERROR;
> +        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +        break;
> +    case ASPEED_UDC_XFER_MORE:
> +        break;
> +    }
> +}
> +
>   static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       AspeedUDCEP *e = opaque;
> @@ -346,10 +660,31 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
>                                   unsigned size)
>   {
>       AspeedUDCEP *e = opaque;
> +    AspeedUDCState *s = container_of(e - e->index, AspeedUDCState, ep[0]);
>       uint32_t reg = offset >> 2;
> +    uint32_t val = data;
>   
> -    trace_aspeed_udc_ep_write(e->index, offset, data);
> -    e->regs[reg] = data;
> +    trace_aspeed_udc_ep_write(e->index, offset, val);
> +
> +    switch (reg) {
> +    case R_EP_DMA_BUFF:
> +        e->regs[reg] = val & R_EP_DMA_BUFF_BASE_ADDR_MASK;
> +        break;
> +    case R_EP_DMA_STS:
> +        val &= 0x77ffffff;
> +        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {
> +            /* IN, descriptor-list mode */
> +            aspeed_udc_ep_in_kick(s, e->index, val);
> +        } else {
> +            /* OUT, single-stage mode */
> +            e->regs[reg] = val;
> +            aspeed_udc_ep_out_kick(s, e->index);
> +        }
> +        break;
> +    default:
> +        e->regs[reg] = val;
> +        break;
> +    }
>   }
>   
>   static const MemoryRegionOps aspeed_udc_ep_ops = {
> @@ -375,6 +710,8 @@ static void aspeed_udc_reset_hold(Object *obj, ResetType type)
>       memset(s->regs, 0, sizeof(s->regs));
>       for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>           memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));
> +        s->ep[i].pkt = NULL;
> +        s->ep[i].desc_off = 0;
>       }
>   
>       /* Device-reset default: root, DMA and EP-pool soft-reset bits set */
> @@ -468,6 +805,95 @@ static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
>    * through the MMIO register interface above.
>    */
>   
> +static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)
> +{
> +    uint32_t cfg;
> +    int i;
> +
> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
> +        cfg = s->ep[i].regs[R_EP_CONFIG];
> +
> +        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||
> +            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) != ep_nr) {
> +            continue;
> +        }
> +        if (FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) == is_out) {
> +            return i;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> +    uint32_t wptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);
> +
> +    if (rptr == wptr) {
> +        /*
> +         * No IN data is queued yet. Save the packet and return ASYNC
> +         * instead of NAK. A NAK would make the host retry slowly.
> +         * aspeed_udc_ep_in_kick() serves and completes this packet later,
> +         * once the guest gadget driver queues descriptors.
> +         */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        return;
> +    }
> +
> +    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {
> +    case ASPEED_UDC_XFER_DONE:
> +        p->status = USB_RET_SUCCESS;
> +        break;
> +    case ASPEED_UDC_XFER_MORE:
> +        /* not fully sent yet: save the packet, wait for more descriptors */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        break;
> +    case ASPEED_UDC_XFER_ERROR:
> +        p->status = USB_RET_IOERROR;
> +        break;
> +    }
> +}
> +
> +static void aspeed_udc_ep_data_out(AspeedUDCState *s, int ep, USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t sts = e->regs[R_EP_DMA_STS];
> +
> +    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),
> +                                 FIELD_EX32(sts, EP_DMA_STS, PKT_SIZE),
> +                                 p->iov.size);
> +    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {
> +        /*
> +         * No OUT buffer is ready yet. Save the packet and return ASYNC
> +         * instead of NAK. Writing now could use an old buffer address and
> +         * lose the data (for example a mass-storage CBW). A NAK would make
> +         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this
> +         * packet later, once the guest gadget driver sets up a buffer.
> +         */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        return;
> +    }
> +
> +    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {
> +    case ASPEED_UDC_XFER_DONE:
> +        p->status = USB_RET_SUCCESS;
> +        break;
> +    case ASPEED_UDC_XFER_MORE:
> +        /* not fully received yet: save the packet, wait for the next buffer */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        break;
> +    case ASPEED_UDC_XFER_ERROR:
> +        p->status = USB_RET_IOERROR;
> +        break;
> +    }
> +}
> +
>   static void aspeed_udc_gadget_handle_reset(USBDevice *udev)
>   {
>       AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> @@ -531,17 +957,37 @@ static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p,
>   
>   static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)
>   {
> -    /* Programmable endpoint (bulk) transfers are added in a later patch. */
> -    p->status = USB_RET_STALL;
> +    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> +    bool is_out = (p->pid == USB_TOKEN_OUT);
> +    int ep = aspeed_udc_find_ep(s, p->ep->nr, is_out);
> +
> +    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",
> +                                 p->iov.size, ep);
> +    if (ep < 0) {
> +        p->status = USB_RET_STALL;
> +        return;
> +    }
> +
> +    if (is_out) {
> +        aspeed_udc_ep_data_out(s, ep, p);
> +    } else {
> +        aspeed_udc_ep_data_in(s, ep, p);
> +    }
>   }
>   
>   static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)
>   {
>       AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> +    int i;
>   
>       if (s->ep0_packet == p) {
>           s->ep0_packet = NULL;
>       }
> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
> +        if (s->ep[i].pkt == p) {
> +            s->ep[i].pkt = NULL;
> +        }
> +    }
>   }
>   
>   static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 098c3d6179..80ead23358 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -389,3 +389,7 @@ aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"
>   aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t index, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bRequest 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"
>   aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val 0x%x, dir_in %d, off %u"
>   aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"
> +aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_idx) "ep_nr %d, %s, iov %u, ep_idx %d"
> +aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t iov) "ep %u, rptr %u, wptr %u, iov %u"
> +aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_t iov) "ep %u, wptr %u, avail %u, iov %u"
> +aspeed_udc_ep_ack(unsigned ep) "ep %u"

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


