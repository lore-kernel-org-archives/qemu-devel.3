Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8D6F43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxp-0003k5-D5; Fri, 17 Apr 2026 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDfxN-0003CC-3u
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDfxJ-0003KO-Pv
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776419864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7+69OMv8gYeP8zQnWEjVdVgPPFuLj2SH4ocZ4CutaMI=;
 b=b9xqp6azw+tE81NR1Ucj7YI3X2N2Gp4WgzIaoOtr4wJ/gUJfR8zOBEIqPS+P6kD3OzXeic
 iplIqbfl7OB9oPk6wjAfb+z3uzallV8CGFw4O+OlwZVNAVqESfoRMXH2OaQ7L+ZkVsWKLV
 7q6yt6KdNze3VLkP6bQhonjWaFuoDRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-JSjxaL5WMN68yoDJGLJQ8A-1; Fri,
 17 Apr 2026 05:57:41 -0400
X-MC-Unique: JSjxaL5WMN68yoDJGLJQ8A-1
X-Mimecast-MFC-AGG-ID: JSjxaL5WMN68yoDJGLJQ8A_1776419860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E55931800454; Fri, 17 Apr 2026 09:57:39 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5786718004AD; Fri, 17 Apr 2026 09:57:38 +0000 (UTC)
Date: Fri, 17 Apr 2026 10:57:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: rft0 <rafettaskindev@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net
Subject: Re: [PATCH v2] hw/scsi: Add SCSI tape device emulation
Message-ID: <aeIED0hn1vC9NpZH@redhat.com>
References: <aeEicSrfbE2sZo8w>
 <20260416183540.142727-1-rafettaskindev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416183540.142727-1-rafettaskindev@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 16, 2026 at 09:35:40PM +0300, rft0 wrote:
> Add initial emulation of SCSI tape device supporting basic
> INQUIRY operation for now.
> 
> Signed-off-by: rft0 <rafettaskindev@gmail.com>
> ---
> Second patch:
>  - Add kconfig entry
>  - Validate vendor, product, version, serial lengths
> 
>  hw/scsi/Kconfig     |   5 +
>  hw/scsi/meson.build |   1 +
>  hw/scsi/scsi-tape.c | 349 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 hw/scsi/scsi-tape.c
> 
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index 5743ee9b4d..06e7cab178 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -1,6 +1,11 @@
>  config SCSI
>      bool
>  
> +config SCSI_TAPE
> +    bool
> +    default y
> +    depends on SCSI
> +
>  config LSI_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 69fde0cf84..1c62115d8e 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -8,6 +8,7 @@ scsi_ss.add(files(
>    'scsi-disk.c',
>    'scsi-generic.c',
>  ))
> +scsi_ss.add(when: 'CONFIG_SCSI_TAPE', if_true: files('scsi-tape.c'))
>  scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
>  scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
>  scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
> diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
> new file mode 100644
> index 0000000000..adbae9b4ad
> --- /dev/null
> +++ b/hw/scsi/scsi-tape.c
> @@ -0,0 +1,349 @@
> +/*
> + * SCSI Tape Device emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Written by Rafet Taskin <rafettaskindev@gmail.com>
> + *
> + * SCSI Tape device emulation.
> + *
> + */
> +
> +#include "qemu/hw-version.h"
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qemu/memalign.h"
> +#include "qemu/cutils.h"
> +#include "hw/scsi/scsi.h"
> +#include "scsi/constants.h"
> +#include "system/block-backend.h"
> +#include "hw/block/block.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "qom/object.h"
> +
> +#define SCSI_MAX_INQUIRY_LEN    256
> +
> +#define MAX_SERIAL_LEN 36

This doesn't appear to be used - the value is just
hardcoded at time of use. Can we use that, and also
add constants for the max product, vendor and
version fields, since those magic constants are
used several times over


> +static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
> +{
> +    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, req->dev);
> +    uint8_t page_code = req->cmd.buf[2];
> +
> +    outbuf[0] = TYPE_TAPE;
> +    outbuf[1] = page_code;
> +    outbuf[2] = 0x00;
> +    outbuf[3] = 0x00;
> +
> +    switch (page_code) {
> +    case 0x00: /* Supported VPD pages */
> +        outbuf[4] = 0x00;   /* page 0x00 (this page) */
> +        if (s->serial) {
> +            outbuf[5] = 0x80;   /* page 0x80 (serial number) */
> +            outbuf[3] = 2;      /* page data length */
> +            return 6;
> +        }
> +        outbuf[3] = 1;
> +        return 5;
> +
> +    case 0x80: /* Unit Serial Number */
> +        if (!s->serial) {
> +            return -1;   /* not supported, caller sends INVALID_FIELD */
> +        }
> +        {
> +            int l = strlen(s->serial);
> +            outbuf[3] = l;
> +            memcpy(&outbuf[4], s->serial, l);

strpadcpy is probably a better idea, as this leaves the tail of
the buffer uninitialized and does not include a NUL terminator.
Even if the caller has initialized the buffer with nuls, it is
more reassuring to reviewers if we explicitly pad here.

Use  MAX_SERIAL_LEN here too with strpadcpy

> +            return 4 + l;
> +        }
> +
> +    default:
> +        return -1;  /* unsupported VPD page */
> +    }
> +}
> +
> +static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
> +{
> +    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, req->dev);
> +    int buflen;
> +
> +    if (req->cmd.buf[1] & 0x1) {
> +        return scsi_disk_emulate_vpd_page(req, outbuf);
> +    }
> +
> +    /* Standard INQUIRY, not a VPD request */
> +    if (req->cmd.buf[2] != 0) {
> +        return -1;
> +    }
> +
> +    /* PAGE_CODE == 0 */
> +    buflen = req->cmd.xfer;
> +    if (buflen > SCSI_MAX_INQUIRY_LEN) {
> +        buflen = SCSI_MAX_INQUIRY_LEN;
> +    }
> +
> +    outbuf[0] = TYPE_TAPE;      /* 0x01 = Tape */
> +    outbuf[1] = 0x80;           /* Always removable */
> +    outbuf[2] = 0x05;           /* SPC-3 */
> +    outbuf[3] = 0x02 | 0x10;    /* Format 2, HiSup */
> +
> +    if (buflen > 36) {
> +        outbuf[4] = buflen - 5;
> +    } else {
> +        outbuf[4] = 36 - 5;
> +    }
> +
> +    outbuf[7] = 0x10 | (req->bus->info->tcq ? 0x02 : 0);
> +
> +    strpadcpy((char *)&outbuf[16], 16, s->product, ' ');
> +    strpadcpy((char *)&outbuf[8], 8, s->vendor, ' ');

The 2nd arg here can use MAX_VENDOR_LEN / MAX_PRODUCT_LEN

> +
> +    memset(&outbuf[32], 0, 4);
> +    memcpy(&outbuf[32], s->version, MIN(4, strlen(s->version)));

Why not use strpadcpy like the two lines above. Also MAX_VERSION_LEN
constant would be wise.

> +
> +    return buflen;
> +}

> +static void scsi_tape_realize(SCSIDevice *dev, Error **errp)
> +{
> +    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, dev);
> +
> +    dev->type = TYPE_TAPE;
> +
> +    if (!s->qdev.conf.blk) {
> +        error_setg(errp, "Drive property not set");
> +        return;
> +    }
> +
> +    if (!blk_is_inserted(s->qdev.conf.blk)) {
> +        error_setg(errp, "Device needs media, but drive is empty");
> +        return;
> +    }
> +
> +    if (!s->vendor) {
> +        s->vendor = g_strdup("QEMU");
> +    } else if (strlen(s->vendor) > 8) {
> +        error_setg(errp, "Vendor must be 8 characters at most");
> +        return;
> +    }

Get rid of the "else" here and in the checks below - we want
to sanity check that the static constant is not oversized too,
especially for QEMU_HW_VERSION. Also use the constants for max
length and include the string in the error message . IOW more
like this code:

    if (!s->vendor) {
        s->vendor = g_strdup("QEMU");
    }
    if (strlen(s->vendor) > MAX_VENDOR_LEN) {
        error_setg(errp, "Vendor '%s' must be %d characters at most",
	           s->vendor, MAX_VENDOR_LEN);
        return;
    }




> +    if (!s->product) {
> +        s->product = g_strdup("QEMU TAPE");
> +    } else if (strlen(s->product) > 16) {
> +        error_setg(errp, "Product must be 16 characters at most");
> +        return;
> +    }
> +
> +    if (!s->version) {
> +        s->version = g_strdup(QEMU_HW_VERSION);
> +    } else if (strlen(s->version) > 4) {
> +        error_setg(errp, "Version must be 4 characters at most");
> +        return;
> +    }
> +
> +    if (s->serial && strlen(s->serial) > 36) {
> +        error_setg(errp, "Serial must be 36 characters at most");
> +        return;
> +    }
> +}

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


