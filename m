Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A5CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 19:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoorf-0007rC-3V; Wed, 20 Aug 2025 15:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1uolsT-0006Xk-1W
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 12:41:33 -0400
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aokblast@FreeBSD.org>)
 id 1uolsR-0000VP-Aw
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 12:41:32 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c6XK05YW0z3KZf;
 Wed, 20 Aug 2025 16:41:24 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c6XK04TrBz46rt;
 Wed, 20 Aug 2025 16:41:24 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755708084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Meg5y5yIO9cA5TOxaGY2rGJmv+4eQqldz+xmooMPcro=;
 b=er+lSG57i8Rc8+hCuaYjANZbvYE+fpgjlzXLXEvQFEQCeFc8kI11irqEz4ov+jLhrNNbyN
 skRuyn4ZIYEG69wu9eRmvVX7pr+Jh4Rfo5kzKvMA1pfEPTvyZ5CQyUGeZ9rqjBoB1aNRhj
 gJ2yT30FSqODQH7k80Yxy3nelhbZRN5vLVmPPG67OGLirmbxXhigEjNkMxqsn1nMmHm6q2
 59sEBYyVnFLxQ5PVmq9yOAYaZ5Tjwb4tXvFyHDdOQv8cR3vxU0YZKGDZiktlpCcohT5D6l
 jYNFMxQQGmmgdczfOvO+a4ybTHPVkRIiiqIk/gQP/O3lt0zUyr7vzGkvaK1FUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755708084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Meg5y5yIO9cA5TOxaGY2rGJmv+4eQqldz+xmooMPcro=;
 b=I7IoYHVNjOjiAz/PTFPDxjhshG+q9HJXFzklf2BnaG6idEsRuFqejxq1pHEB/TZyoflWjv
 lE/tMd06gMKF4y4X+fCLXKomUPGaCX78lHD2GQyOwZw5Z8nCNUQ71ILedjHKdCW5lMQs7F
 eMichqFTTBb9/mIa0y7MczhS4+oYhj0G3uQe2ygCteiCouQiQjSBoPjMnhBlRNFdRMtv84
 Yt61wK8s5vdEwNgCviZDbZpTXIWRy/S1s5xYm1pKi+wJf2tNMLidraSh9DL9OqEfv52C6C
 g6YDmWyywrJ6zenfHAbreeXttycWC+36vj+qOK7ZO4cVfMbpgVigeiORpulgvA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755708084; a=rsa-sha256; cv=none;
 b=s/Wnd28Z+1CzRB+/Ou8PRJPqXKgCIhJIoF3SOPJnCy4neXDcUXIWTDfQjnKyd86TqtrEC3
 hXYvRgXkiDOHayclv9M9Fbkf1w0wADZtdF7CD7RE1+Oiv3P4ISecKLh+nq4vfaMiO8VXKA
 ngXBmWh5GEsRJGDco/RjnqvLBEvBm4ThaMaQjk++7GP4OO01NTEF9Oz3JX/XOED2u8ned6
 GfGFJ8JB1GfqPEuZ2H5odmU0hbF6/1yqp6jXVpzY9x3ibeUWwGNGPGin2eCOvZHZ/oWW+K
 SQEg+NQ50eH/MsmcytyVU6/jlfR/5qHg7sCFqW4yW8XBfZl07nLEiISBt09Keg==
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
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c6XJy663dzr01;
 Wed, 20 Aug 2025 16:41:22 +0000 (UTC)
 (envelope-from aokblast@FreeBSD.org)
From: ShengYi Hung <aokblast@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 ShengYi Hung <aokblast@FreeBSD.org>
Subject: [PATCH] i6300esb: fix incorrect mask for interrupt type
Date: Wed, 20 Aug 2025 12:41:05 -0400
Message-ID: <20250820164105.422-1-aokblast@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=96.47.72.81; envelope-from=aokblast@FreeBSD.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Aug 2025 15:52:53 -0400
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

According to Intel 6300ESB Controller Hub Datasheet 14.4.15, the interrupt type
mask should be 0x03 (0b11) instead of 0x11. In the original
implementation, when we want to disable all interrupt by setting the
value to 0x03, we will get 0x01 which will be incorrect when we reading
the value again. However, there is no problem since 0x1 is reserved and
unused.

Signed-off-by: ShengYi Hung <aokblast@FreeBSD.org>
Sponsored by:   The FreeBSD Foundation
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index bb8a2766b6..3aa01b8d68 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -55,7 +55,7 @@
 /* Config register bits */
 #define ESB_WDT_REBOOT  (0x01 << 5)   /* Enable reboot on timeout          */
 #define ESB_WDT_FREQ    (0x01 << 2)   /* Decrement frequency               */
-#define ESB_WDT_INTTYPE (0x11 << 0)   /* Interrupt type on timer1 timeout  */
+#define ESB_WDT_INTTYPE (0x03 << 0)   /* Interrupt type on timer1 timeout  */
 
 /* Reload register bits */
 #define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
-- 
2.50.1


