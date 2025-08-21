Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA95CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 18:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upATr-0006st-TB; Thu, 21 Aug 2025 14:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1upATm-0006r6-Kc
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:57:45 -0400
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1upATj-0003hz-7z
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:57:41 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c7CHZ5wnCz3Shk;
 Thu, 21 Aug 2025 18:57:30 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R13" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c7CHZ4xN8z3p78;
 Thu, 21 Aug 2025 18:57:30 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755802650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PiR1KOY3L2nM0tOn/LiJOsYc1jlD4RERmlfqalr9+BA=;
 b=F4F1qneHBntj3IJDx4ZhuulfjaSesj42oyNQ5CO0oVRnxMsd/4JzxYfa0cmh23YDQMK36h
 j8iLZaQ+WgwAN+exqsBmUJVlDAtFuCisP57LiakpiZQOAsGteA2q3vnOZ9RfoQA0PRA/Rl
 AGj14GlLbZY4L1n9/Wigof5qMVOlIvPT9jmLv6DsETln0Z7GBMmitSfbT7DJ7Zy3oQLLvS
 YgEw3LZSv9xFxKLhkn4sxZOnUiXa8E1DY5hNq0ERHXccU6koeDMTKlZylfuOFZybLGn8x9
 43BIkxgYkcJh7yLdtclbE4gH+tASV0FvQ6ENcAfTDkoownwCEZC87anghI+97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755802650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PiR1KOY3L2nM0tOn/LiJOsYc1jlD4RERmlfqalr9+BA=;
 b=b1ZyKsCaDX/ECQ3vHVd9069YZP7M8unueZJn7UhciGD0E2lo0tvi/6WqTi58Pg/0FCRAHy
 cziy0qxjlx1zZsJhw01Cx5fa5bLEqb3wlIwNKu8k+GN10SFK4jQDhmV5me+v7OJFy8ZPAh
 Z+lyFMaapRkOSqinVRR8GFHygT5Bu59FOsDM82utap/wPfrPR7lVyI387NMibUgIDBwNpk
 h/hSvihsx2coya8uH/JccmA4VlKHEC244oZlfgaS/GVmBgMx8Z7RtKAPsDIrv7uMcHNkiM
 RH+6a+HaU/oA7W3B+/XOJhGU8ZlsKP+itWI1LaWC905PNDYsBlxHBg0veYKO6g==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755802650; a=rsa-sha256; cv=none;
 b=i3Axkrte5CSgDYMF2aozLPdKPJKH3pPOh6vtZt1H0CkfM6k/oQUWpPpqwpbegjPNsfUy9r
 oPcmQO8chcGB0CvRgfJY8lplcuBMxQhgQnOyfYLaAFCWMa4je0OKw8swbZzCA7ZuStF+At
 Gk8Pd8jwKElc2funaFZ5TYcAqkIH4H8B4yIIHDn8FrpeSoYHbHAdDCXApd1qdwHgLE13u9
 9ua0ISlzUJboWRH7gh4PtFYdCCkObD4EIzbaJhjGAnD8TJUHLwXQqxFO0xxnu+tGpAvtLk
 wc9WYnhP+yymDa8gTpjprOo61oUHScuq/wEwbTmOIt6+8bBJ5SHBMZwiu5SM8w==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from localhost.localdomain
 (2001-b011-3808-3444-a66b-b6ff-fe3d-469a.dynamic-ip6.hinet.net
 [IPv6:2001:b011:3808:3444:a66b:b6ff:fe3d:469a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: aokblast)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c7CHY2sDrz80w;
 Thu, 21 Aug 2025 18:57:29 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
From: ShengYi Hung <aokblast@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: ShengYi Hung <aokblast@FreeBSD.org>
Subject: [PATCH] hid: fix incorrect return value for hid.
Date: Thu, 21 Aug 2025 14:57:17 -0400
Message-ID: <20250821185717.89580-1-aokblast@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2610:1c1:1:606c::19:2;
 envelope-from=aokblast@FreeBSD.org; helo=mx2.freebsd.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The return value of hid_keyboard_write is used to set the packet's actual_length.
Therefore, return 1 to indicate a successful transfer or it should be
considered as a wrong xfer.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Sponsored by:   The FreeBSD Foundation
---
 hw/input/hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 76bedc1844..5da9fee763 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -478,6 +478,7 @@ int hid_keyboard_write(HIDState *hs, uint8_t *buf, int len)
             ledstate |= QEMU_CAPS_LOCK_LED;
         }
         kbd_put_ledstate(ledstate);
+        return (1);
     }
     return 0;
 }
-- 
2.50.1


