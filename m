Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF02F8D763
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQvp-0003dD-TV; Thu, 16 Apr 2026 13:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDQvo-0003cm-6q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDQvl-0005qF-Na
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776362107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jUykcpdGLuF/1bbOATdLk+f9lxYKNrCYhO6NZHKwfAU=;
 b=YCIFTbObv97EHAC0bsrNzHnXmt/7EKE5TYPJHfP2h8JV2GVD6qnpnqllU4YouUfBya5gDE
 7znyn+EOQaTxaTOiNr86prJ1mihKTlDCQUvmNfGRPSkXRrOVPkZNOs8BsVoU8JhZn7xHJ/
 ph4wfwG1NHfsbdK8bFo442HM+PJ1G14=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-dwS5OgpKPI6hmf6ngkq3kw-1; Thu,
 16 Apr 2026 13:55:03 -0400
X-MC-Unique: dwS5OgpKPI6hmf6ngkq3kw-1
X-Mimecast-MFC-AGG-ID: dwS5OgpKPI6hmf6ngkq3kw_1776362102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D15319560B4; Thu, 16 Apr 2026 17:55:02 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F7221955F21; Thu, 16 Apr 2026 17:55:00 +0000 (UTC)
Date: Thu, 16 Apr 2026 18:54:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: rft0 <rafettaskindev@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net, deller@gmx.de
Subject: Re: [PATCH RFC] hw/scsi: Add SCSI tape device emulation
Message-ID: <aeEicSrfbE2sZo8w@redhat.com>
References: <20260416173448.88831-1-rafettaskindev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416173448.88831-1-rafettaskindev@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 16, 2026 at 08:34:48PM +0300, rft0 wrote:
> Add initial emulation of SCSI tape device supporting basic
> INQUIRY operation for now.
> 
> Hi, I am a GSoC 2026 applicant and this is my first patch.
> Any feedback or corrections appreciated.

When you have any notes that are not intended for long
term preservation in git history, it is preferrable to
put them after the "---"....

> 
> Signed-off-by: rft0 <rafettaskindev@gmail.com>
> ---

...just here...

>  hw/scsi/meson.build |   1 +
>  hw/scsi/scsi-tape.c | 334 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 335 insertions(+)
>  create mode 100644 hw/scsi/scsi-tape.c
> 
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 69fde0cf84..1699b6e591 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -7,6 +7,7 @@ scsi_ss.add(files(
>    'scsi-bus.c',
>    'scsi-disk.c',
>    'scsi-generic.c',
> +  'scsi-tape.c',
>  ))

I wonder if we shold add a "CONFIG_SCSI_TAPE"   KConfig
flag so that downstreams can selectively enable the tape
emulation


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
> +            if (l > 36) {
> +                l = 36;
> +            }

Rather than silently truncating it here, we should check the length
in realize() and report an error at that point, so this code can
assume the length is already within bounds.

> +            outbuf[3] = l;
> +            memcpy(&outbuf[4], s->serial, l);
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
> +
> +    memset(&outbuf[32], 0, 4);
> +    memcpy(&outbuf[32], s->version, MIN(4, strlen(s->version)));

product/vendor/version should be length checked too.

> +
> +    return buflen;
> +}
> +

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
> +    }
> +    if (!s->product) {
> +        s->product = g_strdup("QEMU TAPE");
> +    }
> +    if (!s->version) {
> +        s->version = g_strdup(QEMU_HW_VERSION);
> +    }

Here you can validate length of vendor, product, version
and serial.

> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


