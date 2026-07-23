Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D89BC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRR-000203-4Y; Thu, 23 Jul 2026 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRJ-0001xW-Ny
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRF-000439-SN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso140451f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790108; x=1785394908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJcyrLyvAkPJGCOFIwqQ1qZlG599jZ6Ylb6PlbHkOhE=;
 b=Qs2dWgtdA8RifsUfQngEq2M8SMWPANSnnxeE97+JfiW9gCvqtn738hT+1JTLNnhW+t
 yRNQ8FfIvKagiH9O0IBTyrbQdNYkvkJo0z2H/7AX/WE8q0L7pTX0hqdjlE5V3xa9pRRO
 mifmLajaqiR8LwPURBwIJ7pS89XuyaIGlbyPbRxVpu8JrYnviLJq46i5OfsMdgDLnd9Z
 qdDmbQMGnLfBawLmacqCerCJL+GhA1p20LmbisVplFMfnPEs+Vs0WUEwrRpIjYvX/jfz
 WWa8VtIn+55q/dpWZA0kAgUZtJX0Lkoq5z0C0VBksmF8zlSThrrMb/2U103ESvGHGBuK
 tKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790108; x=1785394908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJcyrLyvAkPJGCOFIwqQ1qZlG599jZ6Ylb6PlbHkOhE=;
 b=LwIq4q/HrryNqKc3DnIdwXsHFKnJl4gJcQaRWD0P+xstsWc9ltCat6DS/I4qYK5puJ
 2m+iJGkOSUVJCxC5laoK/hEFo6J3dHhvlv7l9GbjBYgEgWLZ1hLIK/KTA4+7lFREq1Xh
 +wIi9HYHh5qh/+6km3+hLN+Ao2QJ4TtUMIevc+X+k2Zls5dmXz7eFHOkgCrNMti08FXc
 hp3LODMiBGhEhWIJLKCkebiC1wZTG5wcj0sPe4ZN7mPJaYcRtkengnO+0JRjCcDi7fv6
 G7cg4MTqeT9YBGCswKN1kqJZQGTA/1ANmLRxkG/ojH28d6FOtwTBbcQh7Cpdzm3Sm28g
 U6FQ==
X-Gm-Message-State: AOJu0YwLf0/b5z+PZ2p5BknBZSqAlGWHleXu9RNS0NlhXyl04jVYam+E
 LDFLT4wgfcEPpZrAK19MAypotdQG8X27wVDFbZsFUYBDqnZjuGWwbRjUft2e8A==
X-Gm-Gg: AR+sD10cdbwcixsgoG/UQCPqAybmi2Er8iUH6eU1EecLNSHtW+/L1Jzjwn2+D0Kt3ER
 UBk8C+MzRV0xtSpisQ50OpD34fEpUWzMeS1/l4iURhU38etb3hc/CSoGhhsaZ8GMJ3PXTF3XBUs
 M+F+5NlEHYIuq+awbMXHkiWJz+6RuzwTvOjbIjA9EmfxxE0msyYgTy2LpC9oX2s6Lyf53yOBdrl
 Bft3dyrupONQ6gh0hvYaYuEQn/V2YnZN6QCxmEdIjU1L0+d2KX0+QSMwFf0iGBsS5UcTfZMr5C4
 YmIxFvRr6KvYbr/BEBkfO3/IozCn+1cE6hJ0BlgLGaIWKfwiSxvQDk6vF/UXmJUweL+cqXEttlU
 ntv+Lqpm99dd1QjBRGMkaMe7+6ykD88S+B2zlbCij69KjD+uX99AsfoJEcCHWRJnsoPjproqFJ6
 KHf1GcsIyHD1NCW/DXDDqy6MY9+Wm2/S7ymd/x+07W4Zt+v3uqIZUlGYiZx7MrhTG70xdHYpCsn
 ZIdvGHToieP7EVfcrLOe69hxg==
X-Received: by 2002:a5d:6f08:0:b0:478:1a24:912d with SMTP id
 ffacd0b85a97d-47f8dca552cmr2476700f8f.57.1784790107868; 
 Thu, 23 Jul 2026 00:01:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 5/9] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_read()
Date: Thu, 23 Jul 2026 09:00:55 +0200
Message-ID: <20260723070059.6332-6-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Calculate mailbox indices from the `mbs[]` array layout instead of the
oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
the valid array range and fixes Coverity CID 1662974.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 651904fa37..8d680f1832 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1239,14 +1239,12 @@ static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
 static uint64_t flexcan_mem_read(void *opqaue, hwaddr addr, unsigned size)
 {
     FlexcanState *s = opqaue;
+    const int mbid = (addr - offsetof(FlexcanRegs, mbs)) /
+        sizeof(s->regs.mbs[0]);
     uint32_t rv = s->regs_raw[addr >> 2];
 
-    if (addr >= offsetof(FlexcanRegs, mb) &&
-        addr < offsetof(FlexcanRegs, _reserved4)) {
+    if (0 <= mbid && mbid < ARRAY_SIZE(s->regs.mbs)) {
         /* reading from mailbox */
-        hwaddr offset = addr - offsetof(FlexcanRegs, mb);
-        int mbid = offset / sizeof(FlexcanRegsMessageBuffer);
-
         if (addr % 16 == 0 && s->locked_mbidx != mbid) {
             /* reading control word locks the mailbox */
             flexcan_mb_unlock(s);
-- 
2.55.0


