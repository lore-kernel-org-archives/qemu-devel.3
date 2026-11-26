Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F7606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aS4JrmOK;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Po+NZ0Ge
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkE-00023I-IM; Thu, 26 Nov 2026 10:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbk2-00021O-JT
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjq-0004WV-6R
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w6KVXT+MUKUSEd09kJeDBcy9bPpVMlfL+oojVVH7Ew=;
 b=aS4JrmOK5MotsNOFXHJ0Ms5Ir0Kv3ngv2QIkyuaS0rE0wcqglSEXA6YJfpw6L3FE/YSBrP
 /AcmUTTYRIdAD55m9l5i9faxV609Q7cqiJKLncCA3dAgBAwJVujWeNm4+OzB9nZw2CfqqI
 37QnB8waINgZKHUrUboEzuwUORl66Dw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-cwCRiCB-OieIeH8Kai37-g-1; Thu, 26 Nov 2026 15:50:16 +0000
X-MC-Unique: cwCRiCB-OieIeH8Kai37-g-1
X-Mimecast-MFC-AGG-ID: cwCRiCB-OieIeH8Kai37-g_1795708215
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so59617075e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708215; x=1796313015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9w6KVXT+MUKUSEd09kJeDBcy9bPpVMlfL+oojVVH7Ew=;
 b=Po+NZ0GeCnueDfaMTEDqINm/547rnbN6I8cUcl46UxjiuvpEZeQqoMtk/7MrwcWcIV
 kf8QTEMnOAWwhsyJvr81ol85v566lJk4uqYf2VXAw4qZYNjeTa/iOXLIvsa8wlHol3Kb
 gPeqKNmKHwRltHulfpblhrFELgp2ES2wae/7FDIZTTZCufwMVdoUQFqM0Ge9a+atnbm5
 2roY9IMNj7w5N5hVtbHCukJx2aM8iZlBsi9OzCu42Yhw4bR4EIwShQL7uyXHjkNMCwVU
 i9ymROM+68ybx4nbf9ZGwm+Kz661vtbrsfWtuY4tuBy7oquuhSD0nR0nMoXBy2mAZySa
 wpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708215; x=1796313015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9w6KVXT+MUKUSEd09kJeDBcy9bPpVMlfL+oojVVH7Ew=;
 b=ApyCG778xodCALMiGkXA8I0wzT8w86ez5XZ4lrKgSV7W3NtV8T2W0/wxD559U+k1DO
 SUGS3ETE10BEDG9qyF/KSEcsiUMgHUM1TpF0hunAHD6tbMSKesyhAMW4J0TQGrSiYJgs
 9KZ2b/Z/IVtUVfjiGAKgXQPeMEOKTurTHfhE4GWv6hZVmixo9D6E7LQHLazSmOCU1boM
 ijlBaE3kz9DroNDRJ9nxCgDmqFjvY5EQPjtnGoN0qqH4yyLfXJ3emU8WRZAxKSF6vdTk
 BtVRyD0TQn8iw1LFg4W7anWXjq1b1aCMG/V8QKIXVJKuWZsnYWkBKMT5IswwyMxcdUYk
 qyHg==
X-Gm-Message-State: APuU4Z8zkU+rom8SVhvHos/LL57NtRGEYa73M4K9hrKDte6xO09istDA
 CaPEgjrEUZEficCzo32Lq/OKq86153+Tp/eWOEl4KQ1RTW6+FfqfF/vkVsYjpW8uKc/7z2h/KFk
 RnOwy7IQPgtPjpRSqKUvOllpiCqRXVJ6on3O8F1p7gM+tgCu8Hpjz3sab8QC9YjbxW9vJ6z9FRg
 TJwaJMRbdgyfVjBkx9nssjEW1CDK30uYbJkceNBQqOapjg
X-Gm-Gg: AZFdTZf34BU78eJfK7hu7m5zqiup5TiDaDYsU75Ez7IxW7+rpyIDqLZUkfTMUtp4uGm
 EHS/CfaudDvEOjHg6Wglqd8IcxPX50tUiEwM0+Ov4OCSWCOLWIpKtF3uQoBYXrr91elgb46Jyl7
 qKvMM9fi4truwPYQ7uE5IIldnM9XSl7ZRZlT8uDI2bNYPAJv39EyGIjyLu1hWfsMLQdtEzOWYP/
 /NjNmlpM6fYzB+wVEWZbaBp2iI1fNSSTJF4miP/5HFdniydigIjXwfM+13ySeG0PRCHRI+0gBoz
 rD/+P9hv1p02YQzV2zCruixYAQeYL0F+9whwdRp1bdBor3Jz4/PE3dwjrcgM4W/TL53A17ib0c9
 dMxrrtRcquNL9V8s8QCsHR/Eggu/RDCU9M1nQdJEovHp78EFqHHzXmtx5ITLXbK0I+sA=
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4bb8880f29bmr489036135e9.10.1795708215210; 
 Thu, 26 Nov 2026 07:50:15 -0800 (PST)
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4bb8880f29bmr489035545e9.10.1795708214720; 
 Thu, 26 Nov 2026 07:50:14 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm680056095e9.14.2026.11.26.07.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:14 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 4/6] hw/usb/dev-mtp: Detect end of SendObject data correctly
Date: Thu, 26 Nov 2026 16:49:56 +0100
Message-ID: <20261126154959.81769-5-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126154959.81769-1-tcalifano@redhat.com>
References: <20261126154959.81769-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The end of a SendObject data phase was detected by a short packet,
assuming a 64-byte max packet size. That only holds for full speed:
on high and super speed endpoints, transfers ending on a 64-byte
boundary were misdetected.

Use the endpoint's max_packet_size. Also end the transfer as soon as
the size declared in ObjectInfo has been received, and fail it with
RES_INCOMPLETE_TRANSFER if a short packet arrives before that.

Cc: qemu-stable@nongnu.org
Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 11726bc5ec..e44e2efe8e 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1845,7 +1845,28 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset += dlen;
         d->data_offset += dlen;
-        if ((p->iov.size % 64) || !p->iov.size) {
+        /*
+         * The transfer ends on:
+         *  - A short packet
+         *  - A Zero Length Packet
+         *  - When the declared size has been received.
+         * A size of 0xFFFFFFFF means the object is >= 4GiB and its real size
+         * is unknown, so it can be neither used to detect the end nor checked
+         * against the received length.
+         */
+        if (!p->iov.size ||
+            (p->ep->max_packet_size && (p->iov.size % p->ep->max_packet_size)) ||
+            (s->dataset.size != 0xFFFFFFFF && s->dataset.size == d->offset)) {
+            /* Size is known (< 4GiB) but received data doesn't match it */
+            if (s->dataset.size != 0xFFFFFFFF &&
+                s->dataset.size != d->offset) {
+                usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
+                                     0, 0, 0, 0);
+                usb_mtp_data_free(s->data_out);
+                s->data_out = NULL;
+                usb_mtp_reset_pending_write(s);
+                return;
+            }
             if (d->length == MTP_WRITE_BUF_SZ) {
                 d->write_status = WRITE_END;
             } else {
@@ -1965,7 +1986,15 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
         }
         break;
     case EP_DATA_OUT:
-        if (p->iov.size < sizeof(container)) {
+        /*
+         * A ZLP terminates the data phase: it carries no container header,
+         * and one arriving after the transfer already ended has nothing
+         * left to terminate.
+         */
+        if (!p->iov.size && (!s->data_out || s->data_out->first)) {
+            return;
+        }
+        if (p->iov.size && p->iov.size < sizeof(container)) {
             trace_usb_mtp_stall(s->dev.addr, "packet too small");
             p->status = USB_RET_STALL;
             return;
-- 
2.56.1


