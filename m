Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85A9CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeYN-0002SJ-DV; Mon, 05 Oct 2026 05:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXy-0001t8-1L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeXu-0002ZV-4y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrDMf/UMfWrJBtYDLN9ivsZP3I5NDeWV1F9SUkdG8jM=;
 b=YD7n6DCYnYQ17l4UAoElmju7jr5P6vgb3Ulla6y/lldxc5bTsopDWkv6m6WAn23v9MgpS8
 vULSCoOV6a1hhfyeD5sAphMxXTMQ8dxwGfl+H9rn2O3JhOHT5PQxLfSpSUvRU+y4841EYw
 DJwHnx3TAUu4nVjbXBoizeaTBLcodwA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-7-emqgaBOtCIIBEIohtWLA-1; Mon,
 05 Oct 2026 04:59:36 -0400
X-MC-Unique: 7-emqgaBOtCIIBEIohtWLA-1
X-Mimecast-MFC-AGG-ID: 7-emqgaBOtCIIBEIohtWLA_1791190775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66C118007FD; Mon,  5 Oct 2026 08:59:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E2BE3001D28; Mon,  5 Oct 2026 08:59:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: clg@kaod.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
Date: Mon, 05 Oct 2026 12:59:18 +0400
Message-Id: <179119075845.699310.5944945395562648270.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6877;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DSccGtA5ShU+fLLMzJc3Dd52+/g5F3xwuHWESojdLxE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqw2bpTtpMSI7ZnrzpntZ39s6PD+GUHOWJtyWrc
 AkAP2/wISyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasNm6QAKCRDa6OEJdZac
 5WXVD/wOCBTsdQYWzOfOuEUjPiyuyL0bIJgluxg2bryPD7LBT+lz2I/YGFst6MCNoNhNMqdniNp
 bQC4qHpGSagyxWSo7H9mraUB07KnCotMG1SmWfF3nDtIuNdufUtVNSj5IR/vAlPfK77UhdsZj2i
 S6wjKdBK97JAf8+4U0/Z6Zhv9orpWEuEU5q2BaGNYK1dCIRCWlSIuk9lxVr5GRX29oGZUZlEEnA
 iiDDGuOqbC/qrZwUuXpzu8ihXC75zlNm9lveYWNV2EUmBRC2wUZ676dkWrqsyv2YjFXqHa1fRrc
 ESIWFcxBMa6r+Gy1rBD3N60zG1z/thj1SD72MokshE+LCTrEN4tTX+GIO2FqSh6gHxX/tSuY9QK
 +jwfOUxHpDcSEh7uG0s7QIRm//U9gIta0VrOPcd4lYXl3oTd9woMPiSJvicZYGvNjZYtY+TwOz3
 3Rhu4c38ESVyyy4j1HO438+oqcj/kJvAsr89ZBkpVwtHXSZSuxP7ZbPZ90UnOHEMIEep2AWwSts
 NnfKlUuTm8CGubObxjajHSSouONvUBAWzAxLMeq68kiHDVVaxkP/VYf/1o2EYJaQP6xAJwDTWFG
 N/aaypolSzEKEDWrMoemBz2gM37v9j2Rr7c1VzQuKLaH7ZrPhB/WbSu+plXwTXztqx/1FtGDFju
 aqVqWNVzg9KDzCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

> Add "usb-redir-server". It exports a USB device from this QEMU to a USB
> host in another QEMU, using the usbredir protocol. The other side is the
> existing "usb-redir" device.
> 
> The exported device is plugged in with "-device <dev>,bus=<id>.0". So we
> have to provide a USB bus. To find that bus, qdev starts at the main
> system bus and walks down the tree. A device that is not on a bus is not
> in the tree, so the bus it provides cannot be found. We have to sit on
> the main system bus. That makes this a sysbus device, even though it has
> no MMIO and no IRQ.
> 
> usbredir carries one device, not a bus. A hub cannot be exported because
> the protocol has no device address field, so only the device on the
> first port is redirected. To export several devices, run one
> usb-redir-server per device, each with its own chardev.
> 
> The link to the remote host is a chardev, so this device cannot be
> migrated. Its VMStateDescription says so with unmigratable.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
>
> diff --git a/hw/usb/meson.build b/hw/usb/meson.build
> index 429dcd6a24f7..0061b935e6bb 100644
> --- a/hw/usb/meson.build
> +++ b/hw/usb/meson.build
> @@ -78,7 +78,8 @@ endif
>  if usbredir.found()
>    usbredir_ss = ss.source_set()
>    usbredir_ss.add(when: 'CONFIG_USB',
> -                  if_true: [usbredir, files('redirect.c', 'quirks.c')])
> +                  if_true: [usbredir, files('redirect.c', 'quirks.c',
> +                                            'redirect-server.c')])
>    hw_usb_modules += {'redirect': usbredir_ss}
>  endif
>  
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> new file mode 100644
> index 000000000000..5f365f0a35fc
> --- /dev/null
> +++ b/hw/usb/redirect-server.c
> @@ -0,0 +1,130 @@
> +/*
> + * USB redirector, server side
> + *
> + * Copyright (c) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Exports a locally emulated USB device to a remote USB host over the
> + * usbredir protocol, so a device emulated in one QEMU instance can be
> + * enumerated by a host controller emulated in another one.
> + *
> + * Architecture. The left column is a request going to the device. The
> + * right column is the answer coming back. The middle hop carries
> + * usbredir messages over a socket. The top and bottom hops carry
> + * USBPackets inside QEMU.
> + *
> + *     remote QEMU: guest driver -> EHCI/XHCI
> + *              |                     ^
> + *    USBPacket |                     | USBPacket
> + *              v                     |
> + *     "usb-redir" (the client)
> + *              |                     ^
> + *     usbredir |   chardev socket    | usbredir
> + *              v                     |
> + *     usb-redir-server (the server, this file)
> + *              |                     ^
> + *    USBPacket |                     | USBPacket
> + *              v                     |
> + *     any USBDevice, "-device <dev>,bus=<id>.0"
> + *
> + * "usb-redir" (hw/usb/redirect.c) is the client:
> + *   - it takes a USBPacket from the remote guest and writes it to the
> + *     socket as a usbredir message
> + *   - it reads the answer from the socket and completes the USBPacket
> + *
> + * This file is the server. It does the same thing, but backwards:
> + *   - it reads a usbredir message from the socket and runs it as a
> + *     USBPacket on the bus below
> + *   - it takes the result of that USBPacket and writes it back to the
> + *     same socket as a usbredir message, for the client to read
> + *
> + * A USB device has to sit on a USB bus, and in QEMU a USB bus is always
> + * made by a host controller. So this file makes one and acts as the
> + * host controller on this side. It models no real chip: its cable is
> + * the chardev socket. The real host is in the other QEMU.
> + *
> + * usbredir carries one device, not a bus. A hub cannot be exported:
> + * the protocol has no device address field. To export several devices,
> + * run one usb-redir-server per device, each with its own chardev.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "hw/usb/redirect-server.h"
> +
> +/*
> + * USB port ops
> + */
> +
> +static void usbredir_server_port_child_detach(USBPort *port, USBDevice *child)
> +{
> +    /* We only export the device on our own port. Nothing to do. */
> +}
> +
> +static void usbredir_server_port_wakeup(USBPort *port)
> +{
> +    /* We do not pass remote wakeup to the host. Nothing to do. */
> +}
> +
> +static USBPortOps usbredir_server_port_ops = {
> +    .child_detach = usbredir_server_port_child_detach,
> +    .wakeup = usbredir_server_port_wakeup,
> +};
> +
> +/*
> + * USB bus ops
> + */
> +
> +static USBBusOps usbredir_server_bus_ops = {
> +};
> +
> +/*
> + * Device registration
> + */
> +
> +static void usbredir_server_realize(DeviceState *dev, Error **errp)
> +{
> +    USBRedirServer *s = USB_REDIR_SERVER(dev);
> +
> +    /* One port: usbredir carries a single device. */
> +    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);
> +    s->bus.no_auto_hub = true;
> +    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,
> +                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
> +                      USB_SPEED_MASK_HIGH);
> +}
> +
> +/*
> + * The link to the remote host is a chardev, and we cannot migrate
> + * that. So this device cannot be migrated either.
> + */
> +static const VMStateDescription vmstate_usbredir_server = {
> +    .name = TYPE_USB_REDIR_SERVER,
> +    .unmigratable = 1,
> +};
> +
> +static void usbredir_server_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "USB Redirection Server";
> +    dc->realize = usbredir_server_realize;
> +    dc->vmsd = &vmstate_usbredir_server;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +}
> +
> +static const TypeInfo usbredir_server_types[] = {
> +    {
> +        .name = TYPE_USB_REDIR_SERVER,
> +        .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(USBRedirServer),
> +        .class_init = usbredir_server_class_init,
> +    },
> +};
> +module_obj(TYPE_USB_REDIR_SERVER);
> +module_kconfig(USB);
> +
> +DEFINE_TYPES(usbredir_server_types)
> diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-server.h

What do you need a header for? If there is nothing to share with other units, better
keep it all in .c.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


