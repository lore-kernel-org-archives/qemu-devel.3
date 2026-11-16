Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ALdxdBTe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3BG-0006Qs-Qj; Mon, 16 Nov 2026 15:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3BD-0006PQ-Mj; Mon, 16 Nov 2026 15:19:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3BB-0005sW-Rb; Mon, 16 Nov 2026 15:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=/8pV/wGn0ETk3WA8b4GI117FiKXkpE8rkAyLK0id7NM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ALdxdBTercggTKmLbXFIjWpjwjD3ncs7zBGM18ET1r3N3sl7tXR3dmodFr13DBOcO
 TlJEXM2sIaelFpoUMUEpaOW0LAZOGrrWe5a0nfd9nTWdwG1PMbJZ565lL+yvvrwGxZ
 jiQYuCBYEutFMvvluIAy8qg8j6rt0xC80qJpXGkBayqOhXUOGaToZzX1gXI5xJnGAH
 86ZQX7bUnVqNGTzbxyhUYeOXMMS9oAMtm1tzJ87994roek9LcTkHJr4Bgsg7pobqCQ
 ql3WvCJ3zPMk8ejQOuil51ykJKQrcQjT8MdxrN5pn4m9FyURMOW0TBCgVD3DiZ9sFD
 d5qLFpbz7bh0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 885BC1E7140;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8610645FB76;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5AF47B8DE2; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 10/59] hw/watchdog/wdt_imx2: Clear WDT lock on reset
Date: Mon, 16 Nov 2026 23:18:14 +0300
Message-ID: <20261116201922.534306-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

The WDT bit gets reset and becomes writeable after power on reset which
imx2_wdt_reset() represents. While the WDT bit in the WCR register
already gets reset, its locked attribute wasn't. Fix this inconsistency
by adding the missing unlock of its locked attribute.

Cc: qemu-stable@nongnu.org
Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 98d21eef2c383cd770e3205048a684560128a16d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 58fb4dc69c3..8b54747f9de 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
     s->wicr_locked = false;
     s->wcr_locked = false;
     s->wcr_wde_locked = false;
+    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index 600a552d2e2..d920c29af78 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -85,7 +85,7 @@ struct IMX2WdtState {
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
     bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
+    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
-- 
2.47.3


