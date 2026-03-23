Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF4F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4evF-0002Ym-Mt; Mon, 23 Mar 2026 09:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etU-00028G-6K; Mon, 23 Mar 2026 09:01:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w4etS-0006ax-2L; Mon, 23 Mar 2026 09:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1774270805; bh=dA/mM+TMJrDmRfclsXKHy52owWAOp95oB1OlZnWeP5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=opf4Av3uPdQz9cHtfzVW/EScHTuztcnbDJXSqSR7s3PBZM4ue804RGvTOE2hnY2yI
 073nbeIhuvI+IkLnXWAH+/HXJOFGmtGEV2f5RHVWqUJX/ojany8QX1nGa7QR2//RMB
 DVpbrSCCCI8Mdr17r7VpGk4zTS4BXAqMJqjfu0h8wwLGK5858KpDPGJ3+i8Plsiitb
 +dIn0SoHfXQOfb+EZryWSnsCenroWSZIYrmVyubQKbXYMh1C6MvFmYnbcgj5vBsUBB
 oIoGZ0YfcKE5hO3I/1Ua8roN3aAOFIBw4Lq4HXCMK4uKeuCL04766kgSQgNxhEQ8+B
 tjyN6IsP4E36A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2C2DF196972;
 Mon, 23 Mar 2026 16:00:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EBE8038515F;
 Mon, 23 Mar 2026 16:00:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/4] Fix include statement for u2f-emu.h
Date: Mon, 23 Mar 2026 16:00:14 +0300
Message-ID: <20260323130021.376393-3-mjt@tls.msk.ru>
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

All examples on https://github.com/Agnoctopus/libu2f-emu/ don't
simply include u2f-emu.h without any added directory.

The additional include directory does not exist when libu2f
was built with meson.

It's up to pkgconfig to make sure that u2f-emu.h is found in any case.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/u2f-emulated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index 196d05a83a..b82a315019 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -31,7 +31,7 @@
 #include "hw/usb/usb.h"
 #include "hw/core/qdev-properties.h"
 
-#include <u2f-emu/u2f-emu.h>
+#include <u2f-emu.h>
 
 #include "u2f.h"
 
-- 
2.47.3


