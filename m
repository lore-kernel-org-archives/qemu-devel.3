Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BF2C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwiY-0004zc-7i; Thu, 20 Aug 2026 02:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwwiW-0004yv-5F
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:57:36 -0400
Received: from smtpout1.mo537.mail-out.ovh.net ([51.210.91.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwwiQ-00020O-IV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:57:35 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hQZ4k2GW0z49HK;
 Thu, 20 Aug 2026 06:57:25 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 06:57:25 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.222])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQZ4j4cqXz1xs9; Thu, 20 Aug 2026 06:57:25 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1DFAC203F56; 
 Thu, 20 Aug 2026 06:57:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008291684e7-6097-42ca-8e7b-118a3b844c78,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <5e918bcd-9714-485d-9208-c49c361c0f24@kaod.org>
Date: Thu, 20 Aug 2026 08:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260703074332.1049473-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11913428391370337519
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFm5wViAz/UxscuUYeenzlP0bMyEpk5wF0VVlr7oHRsEBfIgB1ffAgQN5Qtylj40LwZb3bAJVGXlYnu2ZiBC3Y+JTtITru1t7EQDNFa12TruOU6Z4S9yVU4UxATxPDZ8oCr0xDNL4nTN9hFxs0YKXJ4kbiELvG6dgn5Pm4r8ga2rkJVpelgOfDTs8v1IWAKBsLp9SPm0x2+EbwWIIYdh3SAr6C2mnB2WBe6g+XEYaWamGw3Xlt3kgb8QcSoNjt5tWNaL+vCdRIjEroh20cqpP2mIHPlBLyaZkPLqnmzPJY5B030TtDDuQMyxZjdRt/nqRCOJta+1i/3hjJuFHd1mSn3o9LwyRVC/zYrJwmszu5SZ/W227Ib0Eb5EG5Mi8Sv2bPyyqTaBXDxoeHFnBNWInyjLOuVcPJT8rhEE9rUTqmivgSnNaGwa0jnOmOB5WqE5AfEcg3aQ09pI5ITPXx8nnk6edjNWPnBUmAHBdDNFe2xRZPoC+Hw9TL+WXgrygsCebNHitkXdV2WpVLwJlBWzMzLucOD8nah8SDJwHjDYwen1u2AaJoZdDXRv3yiG/4ZW1qFnARqOmn6XgaiexF+GoE9hazij78wkPpwMBCoWJ1wUhu1sfHEApKY3nidy5cao4DRIbCyPRbLGAHXrVd8IO8aRJszrXp+2A1JrWvU7jQNBg
DKIM-Signature: a=rsa-sha256; bh=oH+SBj/tZIZoP5n//pnoGwzfCFNBbETRuw0RQL0pRUA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787209047; v=1;
 b=VDdGHdGC79bBr5GjzrvL3lWAgFe0LWHOwUM27DACAzmPMAPzAHrHc93uh9qKou/rgOSwg+I5
 h72RSQAY0c1FkZvIWU0fYHNOBpugcDCHDWViNhaHaQT19F/SkjKKONlhuwOwHab/hMt9IZLWn2L
 epEc4xYEQO2W5v20vu9hJ5M48Frf2xJfsFfdYMz6op9HBSlGWM8MLcgW2ZJtCjFlq7M3bNYnxHi
 XMyaNgcPw3eUIo5Gf+JKeiPlFR1t+eJYfq4AjYI44KbFyoTv4ecPnGmsgS+Zlmozuf+t+LYVNvp
 xT91/ZQh8vDoQPJC2TTampmzNVnYHFS/XhyGZUW7yooew==
Received-SPF: pass client-ip=51.210.91.20; envelope-from=clg@kaod.org;
 helo=smtpout1.mo537.mail-out.ovh.net
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

Hello,

Who could help review this patch ?

Thanks,

C.

On 7/3/26 09:43, Jamin Lin wrote:
> Present the UDC gadget side to a USB host controller as a USB device
> (TYPE_ASPEED_UDC_GADGET). This is a normal QEMU USB device, so it can be
> attached to any USB host controller bus, not only the BMC's own EHCI.
> 
> It forwards host transactions to the guest gadget driver by raising the
> matching controller interrupts, and completes them once the driver
> answers through the device-controller MMIO registers:
> 
>    - EP0 control: the SETUP packet is mirrored to the SETUP data buffer,
>      and the driver's IN/OUT data is copied to/from the host packet.
>    - Bulk endpoints: IN uses the descriptor-list DMA ring, OUT uses the
>      single-stage DMA buffer. A transfer larger than one host packet is
>      served across several polls and the packet is parked until the gadget
>      queues more data.
> 
> The gadget connects to / disconnects from the host bus when the driver
> sets or clears the upstream-enable bit (pull-up), and is detached on
> reset so a guest reboot does not leave the host enumerating a gadget with
> no driver behind it.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/aspeed-udc.c         | 678 +++++++++++++++++++++++++++++++++++-
>   hw/usb/trace-events         |   9 +
>   include/hw/usb/aspeed-udc.h |  30 ++
>   3 files changed, 711 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
> index 9be9cfcf13..3d69e33516 100644
> --- a/hw/usb/aspeed-udc.c
> +++ b/hw/usb/aspeed-udc.c
> @@ -9,18 +9,30 @@
>    * "aspeed_udc" gadget driver. It implements one control endpoint (EP0) and
>    * 4 programmable endpoints.
>    *
> - * This file is the system-bus side of the controller: the MMIO register map,
> - * the interrupt and the soft reset. The gadget USB device presented to a host
> - * controller (and the endpoint data path) is added on top of this.
> + * The model has two faces:
> + *   - a SysBus device exposing the MMIO register interface, the interrupt and
> + *     the integrated DMA engine to the guest gadget driver (the "system bus
> + *     device" section below);
> + *   - a USBDevice presented on a host controller's bus, which forwards host
> + *     transactions to the gadget by raising the matching controller interrupts
> + *     and completes them once the gadget responds via MMIO (the "USB device"
> + *     section below).
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/core/irq.h"
>   #include "hw/core/registerfields.h"
> +#include "hw/core/qdev-properties.h"
>   #include "hw/usb/aspeed-udc.h"
>   #include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "system/dma.h"
> +#include "system/address-spaces.h"
>   #include "trace.h"
>   
> +#define AST_UDC_EP0_MAXPKT      64
> +
>   /* Root / Global registers (offset from the controller base) */
>   REG32(UDC_FUNC_CTRL, 0x00)
>       FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)
> @@ -90,11 +102,29 @@ REG32(EP_DMA_STS, 0x0C)
>       FIELD(EP_DMA_STS, RPTR,                 8, 8)
>       FIELD(EP_DMA_STS, TX_SIZE,             16, 11)
>   
> +/* DMA descriptor ring (256-stage mode) and descriptor data limits */
> +#define ASPEED_UDC_DESCS_COUNT  256
> +#define ASPEED_UDC_DESC_MAX_LEN 4096
> +
> +/* DMA processing-status idle codes (EP_DMA_CTRL PROC_STS field) */
> +#define EP_DMA_CTRL_STS_RX_IDLE 0x0
> +#define EP_DMA_CTRL_STS_TX_IDLE 0x8
> +
> +/* DMA descriptor (DES1) fields, in guest memory */
> +#define AST_EP_DESC1_IN_LEN(w1)     ((w1) & 0x1fff)
> +/* interrupt-on-completion */
> +#define AST_EP_DESC1_INTR           BIT(31)
> +
>   /* Device-reset default: root, DMA and EP-pool soft-reset bits set (0x301) */
>   #define UDC_DEV_RESET_DEFAULT \
>       (R_UDC_DEV_RESET_ROOT_MASK | R_UDC_DEV_RESET_DMA_MASK | \
>        R_UDC_DEV_RESET_EP_POOL_MASK)
>   
> +static bool aspeed_udc_ep_serve_in(AspeedUDCState *s, unsigned ep,
> +                                   USBPacket *p, bool *complete);
> +static bool aspeed_udc_ep_deliver_out(AspeedUDCState *s, unsigned ep,
> +                                      USBPacket *p);
> +
>   static void aspeed_udc_update_irq(AspeedUDCState *s)
>   {
>       bool level;
> @@ -107,6 +137,159 @@ static void aspeed_udc_update_irq(AspeedUDCState *s)
>       qemu_set_irq(s->irq, level);
>   }
>   
> +static void aspeed_udc_raise_isr(AspeedUDCState *s, uint32_t mask)
> +{
> +    s->regs[R_UDC_ISR] |= mask;
> +    aspeed_udc_update_irq(s);
> +}
> +
> +/* Signal completion of a programmable-endpoint transaction to the gadget */
> +static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, unsigned ep)
> +{
> +    trace_aspeed_udc_ep_ack(ep);
> +    s->regs[R_UDC_EP_ACK_ISR] |= BIT(ep);
> +    s->regs[R_UDC_ISR] |= R_UDC_ISR_EP_POOL_ACK_MASK;
> +    aspeed_udc_update_irq(s);
> +}
> +
> +/*
> + * System bus device: MMIO register interface (guest gadget-driver facing)
> + */
> +
> +/* Connect/disconnect the gadget from the host bus (UBD00 upstream enable) */
> +static void aspeed_udc_set_pullup(AspeedUDCState *s, bool on)
> +{
> +    USBDevice *udev;
> +    Error *err = NULL;
> +
> +    if (!s->usbgadget) {
> +        /* no gadget device bound to this controller */
> +        return;
> +    }
> +
> +    udev = USB_DEVICE(s->usbgadget);
> +    if (!udev->port) {
> +        /* not attached to a host controller bus */
> +        return;
> +    }
> +
> +    trace_aspeed_udc_pullup(on, udev->attached);
> +    if (on && !udev->attached) {
> +        usb_device_attach(udev, &err);
> +        if (err) {
> +            warn_report_err(err);
> +        }
> +    } else if (!on && udev->attached) {
> +        usb_device_detach(udev);
> +    }
> +}
> +
> +/* Complete the in-flight EP0 control transfer back to the host */
> +static void aspeed_udc_ep0_complete(AspeedUDCState *s, uint32_t len)
> +{
> +    USBPacket *p = s->ep0_packet;
> +
> +    if (!p) {
> +        return;
> +    }
> +
> +    s->ep0_packet = NULL;
> +    p->actual_length = s->ep0_dir_in ? MIN(len, s->ep0_setup_len)
> +                                     : s->ep0_setup_len;
> +    p->status = USB_RET_SUCCESS;
> +    trace_aspeed_udc_ep0_complete(s->ep0_dir_in, p->actual_length);
> +    usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
> +}
> +
> +/*
> + * The gadget driver drives EP0 by writing UBD30. Translate those writes into
> + * data movement to/from the deferred host control packet plus the matching
> + * ACK interrupts the gadget expects.
> + */
> +static void aspeed_udc_ep0_ctrl_write(AspeedUDCState *s, uint32_t val)
> +{
> +    uint32_t buf_addr = s->regs[R_UDC_EP0_DATA_BUFF];
> +    uint32_t store = val & R_UDC_EP0_CTRL_STALL_MASK;
> +    uint32_t txlen;
> +    USBPacket *p;
> +    uint32_t n;
> +
> +    trace_aspeed_udc_ep0_ctrl_write(val, s->ep0_dir_in, s->ep0_offset);
> +
> +    /* Gadget stalled EP0: fail the pending control transfer */
> +    if (val & R_UDC_EP0_CTRL_STALL_MASK) {
> +        p = s->ep0_packet;
> +
> +        if (p) {
> +            s->ep0_packet = NULL;
> +            p->status = USB_RET_STALL;
> +            usb_generic_async_ctrl_complete(USB_DEVICE(s->usbgadget), p);
> +        }
> +        s->regs[R_UDC_EP0_CTRL] = store;
> +        return;
> +    }
> +
> +    if (val & R_UDC_EP0_CTRL_TX_RDY_MASK) {
> +        txlen = FIELD_EX32(val, UDC_EP0_CTRL, TX_LEN);
> +
> +        if (s->ep0_dir_in && s->ep0_packet) {
> +            /* IN data stage: copy a chunk from the gadget's DMA buffer */
> +            n = MIN(txlen, s->ep0_setup_len - s->ep0_offset);
> +
> +            if (n) {
> +                dma_memory_read(&address_space_memory, buf_addr,
> +                                s->ep0_data + s->ep0_offset, n,
> +                                MEMTXATTRS_UNSPECIFIED);
> +            }
> +            s->ep0_offset += n;
> +            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);
> +
> +            if (txlen < AST_UDC_EP0_MAXPKT ||
> +                s->ep0_offset >= s->ep0_setup_len) {
> +                aspeed_udc_ep0_complete(s, s->ep0_offset);
> +            }
> +        } else {
> +            /* Zero-length status IN for an OUT / no-data control transfer */
> +            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_IN_ACK_MASK);
> +            aspeed_udc_ep0_complete(s, s->ep0_offset);
> +        }
> +
> +    } else if (val & R_UDC_EP0_CTRL_RX_RDY_MASK) {
> +        if (s->ep0_dir_in) {
> +            /* Status stage OUT (zero length) following IN data */
> +            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);
> +        } else if (s->ep0_packet) {
> +            /* OUT data stage: hand a chunk of host data to the gadget */
> +            n = MIN(s->ep0_setup_len - s->ep0_offset,
> +                    AST_UDC_EP0_MAXPKT);
> +
> +            if (n) {
> +                dma_memory_write(&address_space_memory, buf_addr,
> +                                 s->ep0_data + s->ep0_offset, n,
> +                                 MEMTXATTRS_UNSPECIFIED);
> +            }
> +            s->ep0_offset += n;
> +            store = FIELD_DP32(store, UDC_EP0_CTRL, RX_LEN, n);
> +            aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_OUT_ACK_MASK);
> +        }
> +    }
> +
> +    s->regs[R_UDC_EP0_CTRL] = store;
> +}
> +
> +/* The upstream-enable bit connects/disconnects the gadget from the host bus */
> +static void aspeed_udc_func_ctrl_write(AspeedUDCState *s, uint32_t val)
> +{
> +    bool was_on = FIELD_EX32(s->regs[R_UDC_FUNC_CTRL],
> +                             UDC_FUNC_CTRL, UPSTREAM_EN);
> +    bool now_on = FIELD_EX32(val, UDC_FUNC_CTRL, UPSTREAM_EN);
> +
> +    s->regs[R_UDC_FUNC_CTRL] = val;
> +    if (now_on != was_on) {
> +        aspeed_udc_set_pullup(s, now_on);
> +    }
> +}
> +
>   static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       AspeedUDCState *s = ASPEED_UDC(opaque);
> @@ -132,6 +315,12 @@ static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
>           /* Status registers are write-1-to-clear */
>           s->regs[reg] &= ~val;
>           break;
> +    case R_UDC_FUNC_CTRL:
> +        aspeed_udc_func_ctrl_write(s, val);
> +        break;
> +    case R_UDC_EP0_CTRL:
> +        aspeed_udc_ep0_ctrl_write(s, val);
> +        return;
>       default:
>           s->regs[reg] = val;
>           break;
> @@ -154,6 +343,70 @@ static const MemoryRegionOps aspeed_udc_ops = {
>       },
>   };
>   
> +/*
> + * Descriptor-mode IN kick: the gadget wrote EP_DMA_STS to advance its write
> + * pointer (queue more IN data). Adopt the write pointer, keep our read pointer
> + * (the DMA engine owns it), then serve and complete a parked IN poll if any.
> + */
> +static void aspeed_udc_ep_dma_kick(AspeedUDCState *s, unsigned ep, uint32_t val)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t rptr = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);
> +    uint32_t rptr_w = FIELD_EX32(val, EP_DMA_STS, RPTR);
> +    uint32_t wptr = FIELD_EX32(val, EP_DMA_STS, WPTR);
> +    uint32_t sts = e->regs[R_EP_DMA_STS];
> +    USBPacket *p = e->pkt;
> +    bool complete;
> +
> +    sts = FIELD_DP32(sts, EP_DMA_STS, WPTR, wptr);
> +
> +    /*
> +     * A normal kick writes only the write pointer (bits[7:0]); the read-pointer
> +     * field is zero and is ours to advance. Only an explicit non-zero read
> +     * pointer equal to the write pointer (the driver draining the ring, e.g. on
> +     * reset) resets our read pointer. Testing rptr==wptr alone would wrongly
> +     * match a normal kick whose write pointer just wrapped to 0, resetting the
> +     * ring and stranding a parked packet until the host times out.
> +     */
> +    if (rptr_w != 0 && rptr_w == wptr) {
> +        rptr = rptr_w;
> +        e->desc_off = 0;
> +    }
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(sts, EP_DMA_STS, RPTR, rptr);
> +
> +    if (p && rptr != wptr) {
> +        if (aspeed_udc_ep_serve_in(s, ep, p, &complete)) {
> +            aspeed_udc_raise_ep_ack(s, ep);
> +        }
> +        if (complete) {
> +            e->pkt = NULL;
> +            p->status = USB_RET_SUCCESS;
> +            usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +        }
> +    }
> +}
> +
> +/*
> + * Single-stage OUT arm: the gadget wrote EP_DMA_STS to offer a receive
> + * buffer. If a host OUT packet is parked waiting for it,
> + * deliver into the buffer now and complete it (or keep it parked if the host
> + * data phase is larger than this one armed chunk).
> + */
> +static void aspeed_udc_ep_out_kick(AspeedUDCState *s, unsigned ep)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    USBPacket *p = e->pkt;
> +
> +    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {
> +        return;
> +    }
> +    if (aspeed_udc_ep_deliver_out(s, ep, p)) {
> +        e->pkt = NULL;
> +        p->status = USB_RET_SUCCESS;
> +        usb_packet_complete(USB_DEVICE(s->usbgadget), p);
> +    }
> +}
> +
>   static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       AspeedUDCEP *e = opaque;
> @@ -167,9 +420,33 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
>                                   unsigned size)
>   {
>       AspeedUDCEP *e = opaque;
> -
> -    trace_aspeed_udc_ep_write(e->index, offset, data);
> -    e->regs[offset >> 2] = data;
> +    AspeedUDCState *s = e->udc;
> +    uint32_t reg = offset >> 2;
> +    uint32_t val = data;
> +    uint32_t ctrl;
> +
> +    trace_aspeed_udc_ep_write(e->index, offset, val);
> +
> +    /*
> +     * A write to EP_DMA_STS is a DMA kick. In descriptor mode (IN) it advances
> +     * the ring and resumes a parked IN poll; in single-stage mode (OUT) it
> +     * arms a receive buffer and delivers a parked OUT packet. Every other
> +     * EP register is plain storage.
> +     */
> +    if (reg == R_EP_DMA_STS) {
> +        ctrl = e->regs[R_EP_DMA_CTRL];
> +
> +        if (FIELD_EX32(ctrl, EP_DMA_CTRL, DESC_OP_EN)) {
> +            /* descriptor-mode IN */
> +            aspeed_udc_ep_dma_kick(s, e->index, val);
> +        } else {
> +            /* single-stage OUT */
> +            e->regs[reg] = val;
> +            aspeed_udc_ep_out_kick(s, e->index);
> +        }
> +    } else {
> +        e->regs[reg] = val;
> +    }
>   }
>   
>   static const MemoryRegionOps aspeed_udc_ep_ops = {
> @@ -206,6 +483,7 @@ static void aspeed_udc_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>           g_autofree char *name = g_strdup_printf(TYPE_ASPEED_UDC ".ep%d", i);
>   
> +        s->ep[i].udc = s;
>           s->ep[i].index = i;
>           s->ep[i].regs = g_new0(uint32_t, ASPEED_UDC_EP_NR_REGS);
>           memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,
> @@ -226,8 +504,26 @@ static void aspeed_udc_reset_hold(Object *obj, ResetType type)
>       memset(s->regs, 0, ASPEED_UDC_NR_REGS * sizeof(uint32_t));
>       for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>           memset(s->ep[i].regs, 0, ASPEED_UDC_EP_NR_REGS * sizeof(uint32_t));
> +        s->ep[i].pkt = NULL;
> +        s->ep[i].desc_off = 0;
>       }
>       s->regs[R_UDC_DEV_RESET] = UDC_DEV_RESET_DEFAULT;
> +    s->ep0_packet = NULL;
> +
> +    /*
> +     * A machine reset (e.g. a guest reboot) wipes the gadget driver, so a
> +     * device still attached to the host bus from before the reset is now
> +     * dead. Detach it, otherwise the rebooted host tries to re-enumerate a
> +     * gadget with no driver behind it and fails with -110. It re-attaches
> +     * when the new gadget asserts pull-up (UBD00 upstream-enable).
> +     */
> +    if (s->usbgadget) {
> +        USBDevice *udev = USB_DEVICE(s->usbgadget);
> +
> +        if (udev->attached) {
> +            usb_device_detach(udev);
> +        }
> +    }
>   }
>   
>   static void aspeed_udc_unrealize(DeviceState *dev)
> @@ -252,6 +548,370 @@ static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
>       rc->phases.hold = aspeed_udc_reset_hold;
>   }
>   
> +/*
> + * USB device: gadget presented on a host controller's bus
> + *
> + * These callbacks run in the context of the host controller. They translate
> + * host transactions into the controller interrupts/state the gadget driver
> + * expects, then defer (USB_RET_ASYNC) until the driver responds through the
> + * MMIO register interface above.
> + */
> +
> +/* Locate the programmable endpoint matching a host transaction */
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
> +        if (!!FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) == is_out) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +/*
> + * IN endpoint, descriptor-list mode: serve the descriptors the gadget queued
> + * (read pointer .. write pointer) into the host IN packet.
> + *
> + * The host controller coalesces a multi-packet bulk IN into one packet whose
> + * iovec may span several descriptors, so drain as many queued descriptors as
> + * fit. A descriptor bigger than the remaining room is served partially and
> + * resumed on the next poll via desc_off; the read pointer only advances once a
> + * descriptor is fully consumed (so the gadget driver, which reads the read
> + * pointer back, learns exactly what completed).
> + *
> + * *complete is set true when the host transaction is finished (packet full, or
> + * a short/zero-length descriptor ended the gadget's transfer) and false when
> + * the ring ran dry with the packet still short - the caller then keeps the
> + * packet parked and resumes on the next kick, rather than completing it short
> + * (a maxpacket-multiple short read is not seen as end-of-transfer by the host,
> + * which would then wait forever for data the gadget considers already sent).
> + *
> + * Returns true when the gadget should be signalled (EP ACK): the ring drained
> + * (its descriptor handler waits for read==write) or a descriptor asked for an
> + * interrupt.
> + */
> +static bool aspeed_udc_ep_serve_in(AspeedUDCState *s, unsigned ep,
> +                                   USBPacket *p, bool *complete)
> +{
> +    QEMUIOVector *pktiov = p->combined ? &p->combined->iov : &p->iov;
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t mps = FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);
> +    uint32_t base = e->regs[R_EP_DMA_BUFF];
> +    uint32_t sts = e->regs[R_EP_DMA_STS];
> +    uint32_t wptr = FIELD_EX32(sts, EP_DMA_STS, WPTR);
> +    uint32_t rptr = FIELD_EX32(sts, EP_DMA_STS, RPTR);
> +    uint32_t remaining;
> +    uint8_t buf[1024];
> +    /* des_0: buffer base, des_1: control/len */
> +    uint32_t desc[2];
> +    uint32_t copied;
> +    uint32_t chunk;
> +    uint32_t dlen;
> +    uint32_t room;
> +    uint32_t seg;
> +    uint32_t off;
> +    uint32_t w0;
> +    uint32_t w1;
> +    bool done = false;
> +    bool ack = false;
> +
> +    if (mps == 0) {
> +        /* a MAX_PKT field of 0 means 1024 bytes */
> +        mps = 1024;
> +    }
> +
> +    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);
> +
> +    while (rptr != wptr) {
> +        copied = 0;
> +        dma_memory_read(&address_space_memory, base + rptr * sizeof(desc),
> +                        desc, sizeof(desc), MEMTXATTRS_UNSPECIFIED);
> +        w0 = le32_to_cpu(desc[0]);
> +        w1 = le32_to_cpu(desc[1]);
> +        dlen = AST_EP_DESC1_IN_LEN(w1);
> +        off = e->desc_off;
> +        remaining = dlen > off ? dlen - off : 0;
> +        room = pktiov->size > (uint32_t)p->actual_length ?
> +               pktiov->size - (uint32_t)p->actual_length : 0;
> +        chunk = MIN(remaining, room);
> +
> +        while (copied < chunk) {
> +            seg = MIN(chunk - copied, sizeof(buf));
> +            dma_memory_read(&address_space_memory, w0 + off + copied, buf, seg,
> +                            MEMTXATTRS_UNSPECIFIED);
> +            usb_packet_copy(p, buf, seg);
> +            copied += seg;
> +        }
> +        e->desc_off = off + chunk;
> +
> +        if (e->desc_off < dlen) {
> +            /* Room exhausted mid-descriptor: the packet is full */
> +            done = true;
> +            break;
> +        }
> +
> +        /* Descriptor fully served: advance the read pointer */
> +        rptr = (rptr + 1) % ASPEED_UDC_DESCS_COUNT;
> +        e->desc_off = 0;
> +        if (w1 & AST_EP_DESC1_INTR) {
> +            ack = true;
> +        }
> +        /* short/zero-length stage ends the transfer */
> +        if (dlen < mps) {
> +            done = true;
> +            break;
> +        }
> +        if ((uint32_t)p->actual_length >= pktiov->size) {
> +            done = true;
> +            break;
> +        }
> +    }
> +
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(sts, EP_DMA_STS, RPTR, rptr);
> +    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
> +                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE);
> +    /* The gadget driver completes its request when the ring drains */
> +    if (rptr == wptr) {
> +        ack = true;
> +    }
> +
> +    *complete = done;
> +    return ack;
> +}
> +
> +static void aspeed_udc_ep_data_in(AspeedUDCState *s, unsigned ep, USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t sts = e->regs[R_EP_DMA_STS];
> +    uint32_t rptr = FIELD_EX32(sts, EP_DMA_STS, RPTR);
> +    uint32_t wptr = FIELD_EX32(sts, EP_DMA_STS, WPTR);
> +    bool complete;
> +
> +    if (rptr == wptr) {
> +        /*
> +         * Nothing queued yet. Park the packet as ASYNC rather than NAKing: the
> +         * gadget will kick shortly and the kick handler serves and completes
> +         * it, waking the host immediately. NAK would leave the host to re-poll
> +         * on its much slower async-schedule timer, collapsing bulk throughput.
> +         */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        return;
> +    }
> +
> +    if (aspeed_udc_ep_serve_in(s, ep, p, &complete)) {
> +        aspeed_udc_raise_ep_ack(s, ep);
> +    }
> +    if (complete) {
> +        p->status = USB_RET_SUCCESS;
> +    } else {
> +        /*
> +         * Ring ran dry before the request was satisfied: keep it parked and
> +         * resume from the kick that queues the next chunk.
> +         */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +    }
> +}
> +
> +/*
> + * OUT endpoint, single-stage mode: deliver host OUT data into the buffer the
> + * gadget armed (EP_DMA_BUFF + EP_DMA_STS). The host controller may
> + * hand the whole OUT data phase as one packet larger than the armed chunk, so
> + * copy up to TX_SIZE bytes starting where the previous call left off
> + * (p->actual_length); the caller keeps the packet parked across re-arms until
> + * it is fully drained. Returns true once the packet is fully delivered.
> + */
> +static bool aspeed_udc_ep_deliver_out(AspeedUDCState *s, unsigned ep,
> +                                      USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t buf_addr = e->regs[R_EP_DMA_BUFF];
> +    uint32_t chunk = FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, TX_SIZE);
> +    uint32_t remaining = p->iov.size - (uint32_t)p->actual_length;
> +    uint32_t len = MIN(remaining, chunk);
> +    uint8_t buf[ASPEED_UDC_DESC_MAX_LEN];
> +
> +    if (buf_addr && len) {
> +        len = MIN(len, sizeof(buf));
> +        usb_packet_copy(p, buf, len);
> +        dma_memory_write(&address_space_memory, buf_addr, buf, len,
> +                         MEMTXATTRS_UNSPECIFIED);
> +    }
> +
> +    /* Report the received length; clearing WPTR disarms the receive buffer */
> +    e->regs[R_EP_DMA_STS] = FIELD_DP32(0, EP_DMA_STS, TX_SIZE, len);
> +    e->regs[R_EP_DMA_CTRL] = FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL,
> +                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE);
> +    aspeed_udc_raise_ep_ack(s, ep);
> +
> +    return (uint32_t)p->actual_length >= p->iov.size;
> +}
> +
> +static void aspeed_udc_ep_data_out(AspeedUDCState *s, unsigned ep, USBPacket *p)
> +{
> +    AspeedUDCEP *e = &s->ep[ep];
> +    uint32_t sts = e->regs[R_EP_DMA_STS];
> +
> +    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),
> +                                 FIELD_EX32(sts, EP_DMA_STS, TX_SIZE),
> +                                 p->iov.size);
> +    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {
> +        /*
> +         * No receive buffer armed yet. Park the packet as ASYNC rather than
> +         * NAKing: delivering into a stale buffer would lose the packet (e.g. a
> +         * mass-storage CBW), and NAK would fall back to the slow async re-poll.
> +         * aspeed_udc_ep_out_kick() delivers it once the gadget arms a buffer.
> +         */
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +        return;
> +    }
> +
> +    if (aspeed_udc_ep_deliver_out(s, ep, p)) {
> +        p->status = USB_RET_SUCCESS;
> +    } else {
> +        e->pkt = p;
> +        p->status = USB_RET_ASYNC;
> +    }
> +}
> +
> +static void aspeed_udc_gadget_handle_reset(USBDevice *udev)
> +{
> +    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> +
> +    s->ep0_packet = NULL;
> +    s->ep0_offset = 0;
> +    /* EHCI is high speed; let the gadget read the link speed from UBD24 */
> +    s->regs[R_UDC_STS] = R_UDC_STS_HIGHSPEED_MASK;
> +    trace_aspeed_udc_reset(s->regs[R_UDC_IER]);
> +    aspeed_udc_raise_isr(s, R_UDC_ISR_BUS_RESET_MASK);
> +}
> +
> +static void aspeed_udc_gadget_handle_control(USBDevice *udev, USBPacket *p,
> +                                          int request, int value, int index,
> +                                          int length, uint8_t *data)
> +{
> +    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> +    uint8_t type = request >> 8;
> +    uint8_t req = request & 0xff;
> +
> +    /*
> +     * Reconstruct the 8-byte SETUP packet into the SETUP data buffer where
> +     * the gadget driver reads it from (controller offset 0x80).
> +     */
> +    s->regs[R_UDC_SETUP0] = type | (req << 8) | ((value & 0xffff) << 16);
> +    s->regs[R_UDC_SETUP1] = (index & 0xffff) | ((length & 0xffff) << 16);
> +
> +    s->ep0_packet = p;
> +    s->ep0_data = data;
> +    s->ep0_setup_len = length;
> +    s->ep0_offset = 0;
> +    s->ep0_dir_in = (type & USB_DIR_IN);
> +
> +    trace_aspeed_udc_ep0_setup(type, req, value, index, length,
> +                               s->ep0_dir_in, udev->addr);
> +
> +    /*
> +     * SET_ADDRESS: adopt the address and complete the (zero-length) status
> +     * synchronously, exactly like QEMU's generic control handler. The gadget
> +     * is still notified so its own state machine advances, but the host
> +     * transfer must not depend on that asynchronous round-trip.
> +     */
> +    if (type == 0 && req == USB_REQ_SET_ADDRESS) {
> +        udev->addr = value;
> +        s->ep0_packet = NULL;
> +        aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);
> +        p->status = USB_RET_SUCCESS;
> +        return;
> +    }
> +
> +    aspeed_udc_raise_isr(s, R_UDC_ISR_EP0_SETUP_MASK);
> +    p->status = USB_RET_ASYNC;
> +}
> +
> +static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)
> +{
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
> +}
> +
> +static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)
> +{
> +    AspeedUDCState *s = ASPEED_UDC_GADGET(udev)->udc;
> +    int i;
> +
> +    if (s->ep0_packet == p) {
> +        s->ep0_packet = NULL;
> +    }
> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
> +        if (s->ep[i].pkt == p) {
> +            s->ep[i].pkt = NULL;
> +        }
> +    }
> +}
> +
> +static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)
> +{
> +    AspeedUDCGadget *dev = ASPEED_UDC_GADGET(udev);
> +
> +    if (!dev->udc) {
> +        error_setg(errp, "aspeed-udc-gadget: 'udc' link is not set");
> +        return;
> +    }
> +    /* Bind this gadget to its controller */
> +    dev->udc->usbgadget = dev;
> +
> +    /* Connection to the host is driven by the gadget via UBD00 upstream-en */
> +    udev->auto_attach = 0;
> +    /* The ASPEED UDC is USB 2.0, so it only runs at High-Speed for now */
> +    udev->speed = USB_SPEED_HIGH;
> +    udev->speedmask = USB_SPEED_MASK_HIGH;
> +}
> +
> +static const Property aspeed_udc_gadget_props[] = {
> +    DEFINE_PROP_LINK("udc", AspeedUDCGadget, udc, TYPE_ASPEED_UDC,
> +                     AspeedUDCState *),
> +};
> +
> +static void aspeed_udc_gadget_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
> +
> +    dc->desc           = "ASPEED UDC gadget device";
> +    uc->product_desc   = "ASPEED UDC gadget";
> +    uc->realize        = aspeed_udc_gadget_realize;
> +    uc->handle_reset   = aspeed_udc_gadget_handle_reset;
> +    uc->handle_control = aspeed_udc_gadget_handle_control;
> +    uc->handle_data    = aspeed_udc_gadget_handle_data;
> +    uc->cancel_packet  = aspeed_udc_gadget_cancel_packet;
> +    device_class_set_props(dc, aspeed_udc_gadget_props);
> +}
> +
>   static const TypeInfo aspeed_udc_types[] = {
>       {
>           .name          = TYPE_ASPEED_UDC,
> @@ -259,6 +919,12 @@ static const TypeInfo aspeed_udc_types[] = {
>           .instance_size = sizeof(AspeedUDCState),
>           .class_init    = aspeed_udc_class_init,
>       },
> +    {
> +        .name          = TYPE_ASPEED_UDC_GADGET,
> +        .parent        = TYPE_USB_DEVICE,
> +        .instance_size = sizeof(AspeedUDCGadget),
> +        .class_init    = aspeed_udc_gadget_class_init,
> +    },
>   };
>   
>   DEFINE_TYPES(aspeed_udc_types)
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index fb79e24fba..77958fe79a 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -383,4 +383,13 @@ aspeed_udc_read(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%
>   aspeed_udc_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
>   aspeed_udc_ep_read(int ep, uint64_t offset, uint64_t value) "ep %d, offset 0x%" PRIx64 " value 0x%" PRIx64
>   aspeed_udc_ep_write(int ep, uint64_t offset, uint64_t value) "ep %d, offset 0x%" PRIx64 " value 0x%" PRIx64
> +aspeed_udc_pullup(int on, int attached) "on %d, attached %d"
>   aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x, level %d"
> +aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"
> +aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t index, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bRequest 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"
> +aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val 0x%x, dir_in %d, off %u"
> +aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"
> +aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_idx) "ep_nr %d, %s, iov %u, ep_idx %d"
> +aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t iov) "ep %u, rptr %u, wptr %u, iov %u"
> +aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_t iov) "ep %u, wptr %u, avail %u, iov %u"
> +aspeed_udc_ep_ack(unsigned ep) "ep %u"
> diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
> index eb279dd9c3..cbfd1e30fb 100644
> --- a/include/hw/usb/aspeed-udc.h
> +++ b/include/hw/usb/aspeed-udc.h
> @@ -10,11 +10,19 @@
>   #define HW_USB_ASPEED_UDC_H
>   
>   #include "hw/core/sysbus.h"
> +#include "hw/usb/usb.h"
>   #include "qom/object.h"
>   
>   #define TYPE_ASPEED_UDC "aspeed.udc"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
>   
> +/*
> + * The gadget side of the controller is presented to a USB host controller's
> + * bus as a single USB device that delegates back to the AspeedUDCState.
> + */
> +#define TYPE_ASPEED_UDC_GADGET "aspeed.udc-gadget"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)
> +
>   /*
>    * EP0 (control) is served through the root registers (UDC_EP0_*), so only
>    * the 4 programmable endpoints get their own register bank / ep[] entry.
> @@ -36,10 +44,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
>   
>   typedef struct AspeedUDCEP {
>       MemoryRegion mr;
> +    AspeedUDCState *udc;
>       int index;
>       uint32_t *regs;
> +    /* host packet parked until the gadget queues (IN) or arms (OUT) data */
> +    USBPacket *pkt;
> +    /* bytes of the current IN descriptor already served */
> +    uint32_t desc_off;
>   } AspeedUDCEP;
>   
> +struct AspeedUDCGadget {
> +    USBDevice parent_obj;
> +    AspeedUDCState *udc;
> +};
> +
>   struct AspeedUDCState {
>       SysBusDevice parent_obj;
>   
> @@ -49,6 +67,18 @@ struct AspeedUDCState {
>       qemu_irq irq;
>       uint32_t *regs;
>       AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
> +    /* gadget USB device bound to this controller (set at its realize) */
> +    AspeedUDCGadget *usbgadget;
> +
> +    /*
> +     * In-flight EP0 control transfer (host side), deferred until the gadget
> +     * driver responds via MMIO.
> +     */
> +    USBPacket *ep0_packet;
> +    uint8_t *ep0_data;
> +    uint32_t ep0_setup_len;
> +    uint32_t ep0_offset;
> +    bool ep0_dir_in;
>   };
>   
>   #endif /* HW_USB_ASPEED_UDC_H */


