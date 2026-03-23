Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF2F46102
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4evM-0002e7-EU; Mon, 23 Mar 2026 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etU-00028F-5n; Mon, 23 Mar 2026 09:01:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etS-0006b3-Av; Mon, 23 Mar 2026 09:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774270805; bh=wwHUGGarCmbaL8dJjpjqkI/zpYoKiR0JviDKd9duN0U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mfS3SXGMK1LSBMbnjNW4B3ZZEJ21tk93RaRuDKlxg26LS1eJXaG6yW/MEKYC/keRo
 RnjPcCIY2ACF2RzL9oFiXtP/hr4v+m5S2a6U7VmmPPTOIRbw14f5NdOpiI41AhtZte
 dE79uln2VMzHggP06aK32UMO6McAa+Xu38Csc+lvDWXMyS5DjvxPg4mbmDzOM/Y8Bh
 zjrMD2CYmoKwvF13o4yxk7oEIMhhWEYuKh2J9QAYCYbHzh0llq8cG7/sLzv9/rNLbz
 +4JNjzvfpoYPnVjBpgd4ZqDfiR4UxsN2IfvTqaIqKHbhaMh6ZHR/aAUTyZdct1vx7N
 YFVKRnufPl1uw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 44204196973;
 Mon, 23 Mar 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0FADA385160;
 Mon, 23 Mar 2026 16:00:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/4] docs: Update GitHub URL of libu2f-emu
Date: Mon, 23 Mar 2026 16:00:15 +0300
Message-ID: <20260323130021.376393-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323130021.376393-1-mjt@tls.msk.ru>
References: <20260323130021.376393-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

This avoids a redirect from the old to the new URL.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/devices/usb-u2f.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/usb-u2f.rst b/docs/system/devices/usb-u2f.rst
index 4f57d5c8c3..f7ca127cbb 100644
--- a/docs/system/devices/usb-u2f.rst
+++ b/docs/system/devices/usb-u2f.rst
@@ -41,7 +41,7 @@ requires a working libudev):
 ----------------
 
 ``u2f-emulated`` is a completely software emulated U2F device.
-It uses `libu2f-emu <https://github.com/MattGorko/libu2f-emu>`__
+It uses `libu2f-emu <https://github.com/Agnoctopus/libu2f-emu>`__
 for the U2F key emulation. libu2f-emu
 provides a complete implementation of the U2F protocol device part for
 all specified transports given by the FIDO Alliance.
-- 
2.47.3


