Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4661606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F2zssyZF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBn-0008GT-0O; Thu, 29 Oct 2026 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUBA-0006qU-Pd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUB8-0003dU-He
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rINmdIdX+nqY1tB463gc7h4dJoixFBVUCyJSuMaIOhQ=;
 b=F2zssyZFhjHM2VfcjrsfAyXhKQi+X/l1D5TeRtGG4lQp92kxFjFUAxtcnXziRCaukiONfk
 FAOFYlKtMsJ98MC0dVAxbuL0wBZ9zpeFvsZuWMRzqc1SzLCYLgWTLqSNED+dDXewcnNZuO
 BQx8ZEPnZfoKiv45+veTPP/ynIq5MYo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-o6ZfG1TBN-Kr1kabVkHXhA-1; Thu,
 29 Oct 2026 13:44:23 -0400
X-MC-Unique: o6ZfG1TBN-Kr1kabVkHXhA-1
X-Mimecast-MFC-AGG-ID: o6ZfG1TBN-Kr1kabVkHXhA_1793295860
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E96A1955F6E; Thu, 29 Oct 2026 17:44:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6BC2410; Thu, 29 Oct 2026 17:44:18 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261028034140.367393-5-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-5-jamin_lin@aspeedtech.com>
Date: Thu, 29 Oct 2026 21:44:07 +0400
Message-Id: <179329584772.3884549.14074212173976966982.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l2O33EN1jKc35tAbULWnBdZ22SK/nhnMMLqFOt2Yuns=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq44Xr0vHV38TnXbiDgBYJnEyseSXPbkX6GW1Y1
 pGWp/0GfdqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauOF6wAKCRDa6OEJdZac
 5TRnD/9/FCDkBuTEUS1I5ezrouJ5HN7eW9B6oKrFWx9Gu9/bp8OSeSa/jf61SrzUMq1QNv4Pn+8
 0UZZg0qV0rryQCndyFZh41NAohmxDPhKQwct8Gb3NZBEzxZUGjuiq2Qz/CSeGhZzxzn/02trLgM
 V6AFKXJPr8Xtkjlg/3RlyJRIknpcfLr3nEamxVmOt/o9D6Yont7qVG2RPU956szXSAfIJNL3QSX
 9+XXVehj4VK1dB7Ufspt5vM83Oy8sAEOyC1c+ZGWvn/fX0h7WuV5bpPwIfL4W/lWAjVts/pxBpY
 3jknBJCjN/xzMnQzt6wlQvRYCjlh8YC8G9xLm8D704HX/3Hi6l3EGS/ezgvOovJ3yDi2+yPSCSC
 vTVneDDYKwAFzGUvrgii8TmeAqrTDTFnJgIlKcKhFxLWqLP5ZuW+XfzmWHstkWFLByS2TfqpBPc
 5dD9pm/1MvXWGDiYTxEt5codKug3oeIVLRJnWJ2VjTmXIwStpjDiEtgGTjKq7arA/fNwnJZAbRk
 sWEDH5LdiPAzH86QCB1EOr8a1l3YWTthxE9LhEM3ZouTkgfKn103gsYdWK/cYYoHO7Pt2wqyzXv
 m8Wv1P4Hll+uJnuiN8jAnl4XdUtm9FJNSb4li38kgIFWTowS9aixEQHMG5O3tjnmVeraIhMKUzi
 YwGJV3dSacCK2yQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Send device_connect when a device is attached and the host has greeted
> us, device_disconnect when it goes away, and handle the bus reset the
> host sends before enumerating.
> 
> device_connect carries no identity. The peer asks the device itself with
> GET_DESCRIPTOR as soon as it enumerates, so anything we put there would
> be made up. The speed is real: it comes from the device on our port.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20261028034140.367393-5-jamin_lin@aspeedtech.com>
> ---
>  hw/usb/redirect-server.c | 130 ++++++++++++++++++++++++++++++++++++++-
>  hw/usb/trace-events      |   7 +++
>  2 files changed, 136 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index 4971d81af489..ad6e4c422bb9 100644
> --- a/hw/usb/redirect-server.c
> +++ b/hw/usb/redirect-server.c
> @@ -56,6 +56,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "migration/vmstate.h"
> +#include "qemu/cutils.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/usb/usb.h"
>  #include "chardev/char-fe.h"
> @@ -90,12 +91,88 @@ struct USBRedirServer {
>      bool in_write;
>      guint watch;
>      bool host_connected;
> +    bool device_announced;
>  };
>  
> +/*
> + * The device is whatever USBDevice the user plugged into our port with
> + * "-device <device>,bus=<id>.0". NULL until then.
> + */
> +static USBDevice *usbredir_server_device(USBRedirServer *s)
> +{
> +    return s->port.dev;
> +}
> +
> +/*
> + * Device announcement
> + */
> +
> +static uint8_t usbredir_server_speed(USBDevice *device)
> +{
> +    switch (device->speed) {
> +    case USB_SPEED_LOW:
> +        return usb_redir_speed_low;
> +    case USB_SPEED_FULL:
> +        return usb_redir_speed_full;
> +    default:
> +        return usb_redir_speed_high;
> +    }
> +}
> +
> +static void usbredir_server_announce_device(USBRedirServer *s)
> +{
> +    USBDevice *device = usbredir_server_device(s);
> +    struct usb_redir_interface_info_header iface_info = {
> +        .interface_count = 0,
> +    };
> +    struct usb_redir_device_connect_header conn = {};
> +
> +    if (!s->host_connected || s->device_announced ||
> +        !device || !device->attached) {
> +        return;
> +    }
> +    s->device_announced = true;
> +    conn.speed = usbredir_server_speed(device);
> +
> +    /* Put the device in DEFAULT state. The host may not reset the bus. */
> +    device->addr = 0;
> +    device->state = USB_STATE_DEFAULT;

usb_attach() overwrites this with USB_STATE_ATTACHED right after the
port attach callback returns. A subsequent control request from the peer
would trip the dev->state == USB_STATE_DEFAULT assertion in
usb_handle_packet().

You could announce with a BH instead (cancel it on detach) and use
usb_device_reset() instead of manually poking the fields before
announcing.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


