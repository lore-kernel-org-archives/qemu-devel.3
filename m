Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6244FE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5xN-0005PP-Or; Tue, 07 Jan 2025 04:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xL-0005PE-IV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:32:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xI-0006Jk-8S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:32:59 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so10082036f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736242374; x=1736847174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=le6xEQUAKXVEdnvKDfxbK1jzAiqE1WDBuz0Ul4Gn8vE=;
 b=PJlmNn0qA0N8eIZ3hbD1QBxpn4ksZGw6aas0MJHbd9GbX1eCjBGaTdsyYZwbqXAr2d
 vyGtEc5F0XXiZ17GePLe0TroVE4AbYBTjD2oHC/mNdYP+tOvJR7TbR4ZLz7Rvb2Keivu
 pwLxtgJo/ZBdJy8VeZ1FKD6lgC36Up4PN/S/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736242374; x=1736847174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=le6xEQUAKXVEdnvKDfxbK1jzAiqE1WDBuz0Ul4Gn8vE=;
 b=Xwsc5VhUG3MgNbFwqIQXoogBK72FwUL8SC09Fmcheo5y7MPfU50SdqcbePkcIP5GSl
 pL6/yBR9Ae/b4q59Xo086vLGHiBZavlHz9tiH5o9BbZzceQuI23Mv2ls3mhnFRQ2Rm4p
 wdB0ojcqyBqxIeHQeHYSkdgpgzl248LnYFc5/O9nzvyq9RpK4nY3rKYSch2Y9WZYMoaU
 lf7c98kxy/UosAUZ3ZQc5KitG/dGf3j5ztXUvza6g1uX6pQD33KYfKg6R/3/03LAWRsj
 2KMBIQTC/s2Apw9aBJoLaT411o1XwuMmJak+qbcNRO0iCD6Ykc0B9z2UOUIzdHz+2KeC
 615Q==
X-Gm-Message-State: AOJu0YzJkpETFCc+Lrercjhh1lI7Lz6kd9pwDMf0k0xzAuEFxUAs5/gU
 opzqty62CxX11fMlIWs0EMKeAEsE5pNLtdrlAZ8iymc2tH6tNgBqLT2Nh/Ev4aalNIa8qLA/hq/
 x
X-Gm-Gg: ASbGncsNZetzxph7B8nbmGAxtWPfPQ5zalpaE2Fds+EUaV1g2KN5cLMRCu1oQ0INRPP
 +DnA6ouX4k7kcUjRWqItCj+XTPUHcUaMW7LMY7I1ly8YkAoxWDzihLfCql9QpoLahSSUNN3oxb/
 T8l6IaVZ0OHrTnDDuwKPkIAix0AZ60zIIWUA90aGLT7eR1QB1JWP6zv2mO5gUw9WRzwmPyYy/qO
 RkKRzv97H5Zpd+T3BjrBA9sHKSs9QrQCAsBj4QC96y5XxokwdF5cvRfDtv6yw==
X-Google-Smtp-Source: AGHT+IGs6RVcLqHmfQoSzmfYVFDzjcfB1yzxVrQ1br3JPwQL8Jwfwgn1cE39EOkxrmixmEPusLWFPA==
X-Received: by 2002:a5d:47c3:0:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38a7923b75dmr1712737f8f.20.1736242374009; 
 Tue, 07 Jan 2025 01:32:54 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4d7sm591188645e9.34.2025.01.07.01.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:32:53 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/2] xen/console: fix error handling in
 xen_console_device_create()
Date: Tue,  7 Jan 2025 10:31:39 +0100
Message-ID: <20250107093140.86180-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250107093140.86180-1-roger.pau@citrix.com>
References: <20250107093140.86180-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=roger.pau@cloud.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.179, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The usage of error_prepend() in some of the error contexts of
xen_console_device_create() is incorrect, as `errp` hasn't been initialized.
This leads to the following segmentation fault on error paths resulting from
xenstore reads:

Program terminated with signal SIGSEGV, Segmentation fault.
Address not mapped to object.
    fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50)
    at ../qemu-xen-dir-remote/util/error.c:142
142         g_string_append(newmsg, (*errp)->msg);
[...]
(gdb) bt
    (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50) at ../qemu-xen-dir-remote/util/error.c:142
    (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ")
    at ../qemu-xen-dir-remote/util/error.c:152
    (backend=0x43944de00660, opts=0x43944c929000, errp=0x15cd0165ae10)
    at ../qemu-xen-dir-remote/hw/char/xen_console.c:555

Replace usages of error_prepend() with error_setg() where appropriate.

Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org
---
 hw/char/xen_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index ef0c2912efa1..af706c7ef440 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -551,7 +551,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
     }
 
     if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
-        error_prepend(errp, "failed to read console device type: ");
+        error_setg(errp, "failed to read console device type: ");
         goto fail;
     }
 
@@ -582,7 +582,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
     } else if (number) {
         cd = serial_hd(number);
         if (!cd) {
-            error_prepend(errp, "console: No serial device #%ld found: ",
+            error_setg(errp, "console: No serial device #%ld found: ",
                           number);
             goto fail;
         }
-- 
2.46.0


