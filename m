Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85528E6FE49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZ8o-0006lY-F2; Mon, 09 Sep 2024 03:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ8l-0006jU-9M; Mon, 09 Sep 2024 03:48:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Li2i=QH=kaod.org=clg@ozlabs.org>)
 id 1snZ8i-000442-QH; Mon, 09 Sep 2024 03:48:51 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X2JqW6cK9z4wyh;
 Mon,  9 Sep 2024 17:48:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2JqL0Y6Zz4wb5;
 Mon,  9 Sep 2024 17:48:29 +1000 (AEST)
Message-ID: <5b87f9c2-5595-4d00-a341-40609e807082@kaod.org>
Date: Mon, 9 Sep 2024 09:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] usb/uhci: checkpatch cleanup
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-2-linux@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240906122542.3808997-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Li2i=QH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/24 14:25, Guenter Roeck wrote:
> Fix reported checkpatch issues to prepare for next patches
> in the series.
> 
> No functional change.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/usb/hcd-uhci.c | 90 +++++++++++++++++++++++++++++------------------
>   1 file changed, 56 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
> index a03cf22e69..dfcc3e05c0 100644
> --- a/hw/usb/hcd-uhci.c
> +++ b/hw/usb/hcd-uhci.c
> @@ -67,7 +67,7 @@ struct UHCIPCIDeviceClass {
>       UHCIInfo       info;
>   };
>   
> -/*
> +/*
>    * Pending async transaction.
>    * 'packet' must be the first field because completion
>    * handler does "(UHCIAsync *) pkt" cast.
> @@ -220,8 +220,9 @@ static void uhci_async_cancel(UHCIAsync *async)
>       uhci_async_unlink(async);
>       trace_usb_uhci_packet_cancel(async->queue->token, async->td_addr,
>                                    async->done);
> -    if (!async->done)
> +    if (!async->done) {
>           usb_cancel_packet(&async->packet);
> +    }
>       uhci_async_free(async);
>   }
>   
> @@ -322,7 +323,7 @@ static void uhci_reset(DeviceState *dev)
>       s->fl_base_addr = 0;
>       s->sof_timing = 64;
>   
> -    for(i = 0; i < UHCI_PORTS; i++) {
> +    for (i = 0; i < UHCI_PORTS; i++) {
>           port = &s->ports[i];
>           port->ctrl = 0x0080;
>           if (port->port.dev && port->port.dev->attached) {
> @@ -387,7 +388,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>   
>       trace_usb_uhci_mmio_writew(addr, val);
>   
> -    switch(addr) {
> +    switch (addr) {
>       case 0x00:
>           if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
>               /* start frame processing */
> @@ -404,7 +405,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>               int i;
>   
>               /* send reset on the USB bus */
> -            for(i = 0; i < UHCI_PORTS; i++) {
> +            for (i = 0; i < UHCI_PORTS; i++) {
>                   port = &s->ports[i];
>                   usb_device_reset(port->port.dev);
>               }
> @@ -425,10 +426,13 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>           break;
>       case 0x02:
>           s->status &= ~val;
> -        /* XXX: the chip spec is not coherent, so we add a hidden
> -           register to distinguish between IOC and SPD */
> -        if (val & UHCI_STS_USBINT)
> +        /*
> +         * XXX: the chip spec is not coherent, so we add a hidden
> +         * register to distinguish between IOC and SPD
> +         */
> +        if (val & UHCI_STS_USBINT) {
>               s->status2 = 0;
> +        }
>           uhci_update_irq(s);
>           break;
>       case 0x04:
> @@ -436,8 +440,9 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>           uhci_update_irq(s);
>           break;
>       case 0x06:
> -        if (s->status & UHCI_STS_HCHALTED)
> +        if (s->status & UHCI_STS_HCHALTED) {
>               s->frnum = val & 0x7ff;
> +        }
>           break;
>       case 0x08:
>           s->fl_base_addr &= 0xffff0000;
> @@ -464,8 +469,8 @@ static void uhci_port_write(void *opaque, hwaddr addr,
>               dev = port->port.dev;
>               if (dev && dev->attached) {
>                   /* port reset */
> -                if ( (val & UHCI_PORT_RESET) &&
> -                     !(port->ctrl & UHCI_PORT_RESET) ) {
> +                if ((val & UHCI_PORT_RESET) &&
> +                     !(port->ctrl & UHCI_PORT_RESET)) {
>                       usb_device_reset(dev);
>                   }
>               }
> @@ -487,7 +492,7 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
>       UHCIState *s = opaque;
>       uint32_t val;
>   
> -    switch(addr) {
> +    switch (addr) {
>       case 0x00:
>           val = s->cmd;
>           break;
> @@ -533,12 +538,13 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
>   }
>   
>   /* signal resume if controller suspended */
> -static void uhci_resume (void *opaque)
> +static void uhci_resume(void *opaque)
>   {
>       UHCIState *s = (UHCIState *)opaque;
>   
> -    if (!s)
> +    if (!s) {
>           return;
> +    }
>   
>       if (s->cmd & UHCI_CMD_EGSM) {
>           s->cmd |= UHCI_CMD_FGR;
> @@ -674,7 +680,8 @@ static int uhci_handle_td_error(UHCIState *s, UHCI_TD *td, uint32_t td_addr,
>       return ret;
>   }
>   
> -static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_t *int_mask)
> +static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async,
> +                            uint32_t *int_mask)
>   {
>       int len = 0, max_len;
>       uint8_t pid;
> @@ -682,8 +689,9 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
>       max_len = ((td->token >> 21) + 1) & 0x7ff;
>       pid = td->token & 0xff;
>   
> -    if (td->ctrl & TD_CTRL_IOS)
> +    if (td->ctrl & TD_CTRL_IOS) {
>           td->ctrl &= ~TD_CTRL_ACTIVE;
> +    }
>   
>       if (async->packet.status != USB_RET_SUCCESS) {
>           return uhci_handle_td_error(s, td, async->td_addr,
> @@ -693,12 +701,15 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
>       len = async->packet.actual_length;
>       td->ctrl = (td->ctrl & ~0x7ff) | ((len - 1) & 0x7ff);
>   
> -    /* The NAK bit may have been set by a previous frame, so clear it
> -       here.  The docs are somewhat unclear, but win2k relies on this
> -       behavior.  */
> +    /*
> +     * The NAK bit may have been set by a previous frame, so clear it
> +     * here.  The docs are somewhat unclear, but win2k relies on this
> +     * behavior.
> +     */
>       td->ctrl &= ~(TD_CTRL_ACTIVE | TD_CTRL_NAK);
> -    if (td->ctrl & TD_CTRL_IOC)
> +    if (td->ctrl & TD_CTRL_IOC) {
>           *int_mask |= 0x01;
> +    }
>   
>       if (pid == USB_TOKEN_IN) {
>           pci_dma_write(&s->dev, td->buffer, async->buf, len);
> @@ -780,9 +791,11 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
>   
>       if (async) {
>           if (queuing) {
> -            /* we are busy filling the queue, we are not prepared
> -               to consume completed packages then, just leave them
> -               in async state */
> +            /*
> +             * we are busy filling the queue, we are not prepared
> +             * to consume completed packages then, just leave them
> +             * in async state
> +             */
>               return TD_RESULT_ASYNC_CONT;
>           }
>           if (!async->done) {
> @@ -832,7 +845,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
>       }
>       usb_packet_addbuf(&async->packet, async->buf, max_len);
>   
> -    switch(pid) {
> +    switch (pid) {
>       case USB_TOKEN_OUT:
>       case USB_TOKEN_SETUP:
>           pci_dma_read(&s->dev, td->buffer, async->buf, max_len);
> @@ -911,12 +924,15 @@ static void qhdb_reset(QhDb *db)
>   static int qhdb_insert(QhDb *db, uint32_t addr)
>   {
>       int i;
> -    for (i = 0; i < db->count; i++)
> -        if (db->addr[i] == addr)
> +    for (i = 0; i < db->count; i++) {
> +        if (db->addr[i] == addr) {
>               return 1;
> +        }
> +    }
>   
> -    if (db->count >= UHCI_MAX_QUEUES)
> +    if (db->count >= UHCI_MAX_QUEUES) {
>           return 1;
> +    }
>   
>       db->addr[db->count++] = addr;
>       return 0;
> @@ -970,8 +986,10 @@ static void uhci_process_frame(UHCIState *s)
>   
>       for (cnt = FRAME_MAX_LOOPS; is_valid(link) && cnt; cnt--) {
>           if (!s->completions_only && s->frame_bytes >= s->frame_bandwidth) {
> -            /* We've reached the usb 1.1 bandwidth, which is
> -               1280 bytes/frame, stop processing */
> +            /*
> +             * We've reached the usb 1.1 bandwidth, which is
> +             * 1280 bytes/frame, stop processing
> +             */
>               trace_usb_uhci_frame_stop_bandwidth();
>               break;
>           }
> @@ -1120,8 +1138,10 @@ static void uhci_frame_timer(void *opaque)
>           uhci_async_validate_begin(s);
>           uhci_process_frame(s);
>           uhci_async_validate_end(s);
> -        /* The spec says frnum is the frame currently being processed, and
> -         * the guest must look at frnum - 1 on interrupt, so inc frnum now */
> +        /*
> +         * The spec says frnum is the frame currently being processed, and
> +         * the guest must look at frnum - 1 on interrupt, so inc frnum now
> +         */
>           s->frnum = (s->frnum + 1) & 0x7ff;
>           s->expire_time += frame_t;
>       }
> @@ -1174,7 +1194,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
>   
>       if (s->masterbus) {
>           USBPort *ports[UHCI_PORTS];
> -        for(i = 0; i < UHCI_PORTS; i++) {
> +        for (i = 0; i < UHCI_PORTS; i++) {
>               ports[i] = &s->ports[i].port;
>           }
>           usb_register_companion(s->masterbus, ports, UHCI_PORTS,
> @@ -1200,8 +1220,10 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
>       memory_region_init_io(&s->io_bar, OBJECT(s), &uhci_ioport_ops, s,
>                             "uhci", 0x20);
>   
> -    /* Use region 4 for consistency with real hardware.  BSD guests seem
> -       to rely on this.  */
> +    /*
> +     * Use region 4 for consistency with real hardware.  BSD guests seem
> +     * to rely on this.
> +     */
>       pci_register_bar(&s->dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
>   }
>   


