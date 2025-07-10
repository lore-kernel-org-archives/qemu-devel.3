Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05083C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvTc-0005WO-0J; Thu, 10 Jul 2025 13:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hannesbredberg@gmail.com>)
 id 1uZuIO-0000wF-9R
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:38:58 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hannesbredberg@gmail.com>)
 id 1uZuIM-0008Ud-JL
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:38:51 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so12376977b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752165529; x=1752770329; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RBo5Y57XeyEcRFI9qswP0Qed6TlA7wiEKzlycKNK0Nc=;
 b=OPc5Knxi7ko95B/B1MT2e8CCRWbUkgCAgTelqbvlbtBBs0AgYp1WSe4tx0y1PWLjzd
 o44cxm/Swc7Y+beZWyQvQT3xJGSgzzeHF7hQU+0MGmSJr5SFe94K6UOucuUNhVrCEH/W
 nn8o5IDFCLbIIxBwa3GkfcG7I9akXQQiB7jDGTWVswCr5jo80opWTer4ZUP722H+EGDZ
 R0Alx50RVuoRAsJdU4rHFCw3sTHatmBsRP8+F3jMqg3qxlZ71lMnC+GcJ/m+pPRocAgP
 vkFlY5M+I69/f8ZUKZqdVWQjxzCqOii+iebdFnDh+ZjYNTR1qWZdVUcZngLOYe4q5V2a
 uIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165529; x=1752770329;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBo5Y57XeyEcRFI9qswP0Qed6TlA7wiEKzlycKNK0Nc=;
 b=ZkbYdoBsUZQC5oCeicF1N/ZPdqQ5xjXEEzSX00EeyhA0wTczHZY9EYOxtilHNWIFYw
 a5uW9VFq/axLmMHx5HSbqAhBlKOOrCHYme/o4slOCZjxvP7VianLIS0XLb4Acinpz77c
 CxrTsSAEjpcZbxWH30ya28kr2vWZVDcUVb1Rp1om0ExY1AG2SJRCb3eiTnLlTdZiHdBZ
 k+CEmPXmc4PuIG8aOT+H8bB6rrEbW1z8lBVIrUrjnrKJtQMz9O8X9aJWShrksNd06yNs
 fxYNmwRMfk7zkNZaVYrEgP3DM1aW0rWOeho27SHjgc7W771LBYQJ8j2LiVbHA7d028dd
 rgMg==
X-Gm-Message-State: AOJu0YwLoXbHwhvHXcsgcJ/LZjawV/t31nEqj3xPK/KzGsA1P8DTJdwS
 JYG8xXDmrOI8fDIAx4UWUo/vVthWt1ebYUVFJTyvwSidWCOV06h7FvQ4KoUsVArrhPRFlF7l0lg
 eudR464hmkBkiVApUmyOxF5f6cO3k5MiVPcJ6
X-Gm-Gg: ASbGncsFHIV4o2Xjw2rACtDf4EXgdgza80yOTRVp3gLYpI744VSbrYDp/aTKRSekce1
 xjuCekwf1BLoXnnqSZSnq6osxw9hkAXWQAcF5X3y2XNunFk4FlHiCwQu77G0fSlOQSK9caayOY6
 J9OZ9rK7GEE+GOenj4ak0juiAFW196uVUfuqfNM7TBsoU=
X-Google-Smtp-Source: AGHT+IEArleUuVJe8acDHuxwh4oS7QNycj2s0RYdsZiRmpgkLNknPqG348lkf+B9BDxjJlSj7j4z3Op5Xwc2UjjJDeY=
X-Received: by 2002:a05:690c:7202:b0:715:969:ce31 with SMTP id
 00721157ae682-717d5e1f1f7mr3192457b3.35.1752165528835; Thu, 10 Jul 2025
 09:38:48 -0700 (PDT)
MIME-Version: 1.0
From: Hannes Bredberg <hannesbredberg@gmail.com>
Date: Thu, 10 Jul 2025 16:38:35 +0000
X-Gm-Features: Ac12FXzxIGfPxChoaoyKm_kaYuGCz7U_7BC7QresURQIQnJVy7Mhk82xyMZInhk
Message-ID: <CA+z0mrds11nuuiANc6UHsTSSctYfN-AFqj61Q38kXA+iKFB0qw@mail.gmail.com>
Subject: [PATCH] USB MSD: Set s->req to NULL after handling a packet
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=hannesbredberg@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Jul 2025 13:38:17 -0400
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

This fixes compatibility for OSes which enqueue multiple data transfers
on the same endpoint without waiting for the previous one to be ACKed by
the mass storage device.

Signed-off-by: Hannes Bredberg <hannesbredberg@gmail.com>
---
 hw/usb/dev-storage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b13fe345c4..43d57afd00 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -182,13 +182,14 @@ static void usb_msd_packet_complete(MSDState *s,
int status)
     USBPacket *p = s->packet;

     /*
-     * Set s->packet to NULL before calling usb_packet_complete
+     * Set s->packet and s->req to NULL before calling usb_packet_complete
      * because another request may be issued before
      * usb_packet_complete returns.
      */
     trace_usb_msd_packet_complete();
     p->status = status;
     s->packet = NULL;
+    s->req = NULL;
     usb_packet_complete(&s->dev, p);
 }

--
2.47.0

