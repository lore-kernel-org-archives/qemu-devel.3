Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CE606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVFQTPk6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsjN-0000tC-RB; Mon, 02 Nov 2026 09:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi4-00081C-Kc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi2-0005F9-WD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EM2iAfwAwixmnmQXqwHmtYrUyBBE03lItngzAlvkHm8=;
 b=AVFQTPk6319aGijri83sNdsjj6N/DoGFsBdNwjBtwPx2u0kQp3OzSHJrdgHV8G4YQ6n2MG
 u50BR6Pk6w8fqUlSQrH/OMHRt/BO+lw7nKD+Y/uyd/8giawAz4WKypdyMsq5bznsRXCn+O
 Brtqxg+Xy6WnPdkoxP5kgeYE/FjX8gQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-k47H6-t-NsqFxQogk-blHQ-1; Mon,
 02 Nov 2026 09:08:23 -0500
X-MC-Unique: k47H6-t-NsqFxQogk-blHQ-1
X-Mimecast-MFC-AGG-ID: k47H6-t-NsqFxQogk-blHQ_1793628500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1863195F176; Mon,  2 Nov 2026 14:08:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B10DE1803A40; Mon,  2 Nov 2026 14:08:17 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 13/18] hw/usb/redirect-server: Announce the exported
 device
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-14-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-14-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845017.3960472.17221122285900334594.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3466;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BJecDlFM41zBkzwfSjkq949iyOSNc820i+D+sMx1DOM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkmGhrtimZSihYsFx6Il/MbWLCO0XS34Avz
 aNUQnOpoa6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5eDWD/sE+zg4Hx6tUTyNIzjemyF3yUjUQ5sp5gR8+pXW0Lnq/QGUoTiHqug1dKC3gKSq139L1J0
 vyAhZuY1alkBKUwcL8miqNzw/mtJkMhvfgp15wR3vGsJY5S3l1OGk4yOD7mMq+ghRRYzsfyVTN7
 neDhvN4Sth/6NjO9m5Lip0adoNb95JwIS64WkMaB6LLfpeX0mEsL7UH55XusFECkIk0c5Xegf1s
 of1PbS0qfA3kDRNE0XRgf2inJ/5OCbIvkvZpg75HC/iU0I7iEMwjWq+dvBGwSus587Mm810QQvK
 4OFLnRMw/ogSPJj8oln16IfuFPboY0p7Q1lUnocXfF0Z6SJxgqr2NxCEsKb3nE6s5uaqbNkVyB2
 64Tz5n5xf4wKZqDIPLyM9hf7f875aOuDELLA5LgDJP55p7VjCRPBlayGgAt2r7+9IRYU2QYSpo3
 aUfVeJSbUZ7D6f1ZqLTSHtcZ55PBbF6onWTUSM9rGvmEyNxV1P3dyTDznUIBbU1YVIrWspMyn6z
 8N+F4cFaQUgplCQxBMB7Kr1rucF6WE9VMN3/6bG+p7taisAeOsIHCQWsEPj2e0vI765fK4T6Hms
 gf5D4uiPmWzeQN3+1pNPO0/zBoMC8pLadPEOwz1kt3baL9btGSDnytmLj0ZAqUevwaUfgO6KDkj
 lCR7wFOwqA5Kzlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
> Message-ID: <20261102092201.1729245-14-jamin_lin@aspeedtech.com>
> ---
>  hw/usb/redirect-server.c | 150 ++++++++++++++++++++++++++++++++++++++-
>  hw/usb/trace-events      |   7 ++
>  2 files changed, 156 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c
> index f78351bde919..e207f5a7eb56 100644
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
> @@ -85,17 +86,105 @@ struct USBRedirServer {
>      /* usbredir over the chardev */
>      struct usbredirparser *parser;
>      QEMUBH *chardev_close_bh;
> +    QEMUBH *announce_bh;
>      const uint8_t *read_buf;
>      int read_buf_size;
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
> +static void usbredir_server_announce_device(void *opaque)
> +{
> +    USBRedirServer *s = opaque;
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
> +    /*
> +     * The device has to be in DEFAULT state before it can answer
> +     * anything, so reset it here.
> +     */
> +    usb_device_reset(device);
> +
> +    /* Send this before device_connect. The peer needs it to accept us. */
> +    usbredirparser_send_interface_info(s->parser, &iface_info);

The peer's usb-redir client evaluates its "filter" property against
device_connect and this interface_info. With interface_count == 0 and
the all-zero connect header above, any non-empty filter (vendor/product,
class or interface rule) rejects the exported device. Fill
interface_info from the saved configuration descriptor (interface
number, class/subclass/ protocol) and device_connect from the local
USBDevice?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


