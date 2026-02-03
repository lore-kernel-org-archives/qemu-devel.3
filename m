Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D79E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5qv-0002Vr-4M; Mon, 02 Feb 2026 21:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5qt-0002VS-3u; Mon, 02 Feb 2026 21:09:15 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5qr-0006uM-Pr; Mon, 02 Feb 2026 21:09:14 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 10:08:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 10:08:56 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Date: Tue, 3 Feb 2026 10:08:48 +0800
Message-ID: <20260203020855.1642884-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
References: <20260203020855.1642884-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sort the SSP and TSP IRQ map tables to improve readability and make the
definitions easier to maintain.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 4 ++--
 hw/arm/aspeed_ast27x0-tsp.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index e4bcf0fa2a..9b12ba6743 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
 };
 
 static const int aspeed_soc_ast27x0ssp_irqmap[] = {
+    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_UART0]     = 164,
     [ASPEED_DEV_UART1]     = 164,
     [ASPEED_DEV_UART2]     = 164,
     [ASPEED_DEV_UART3]     = 164,
-    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_UART5]     = 164,
     [ASPEED_DEV_UART6]     = 164,
     [ASPEED_DEV_UART7]     = 164,
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
     [ASPEED_DEV_UART10]    = 164,
     [ASPEED_DEV_UART11]    = 164,
     [ASPEED_DEV_UART12]    = 164,
-    [ASPEED_DEV_TIMER1]    = 16,
 };
 
 /* SSPINT 164 */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 68683a15d8..e39d1dc171 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
 };
 
 static const int aspeed_soc_ast27x0tsp_irqmap[] = {
+    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_UART0]     = 164,
     [ASPEED_DEV_UART1]     = 164,
     [ASPEED_DEV_UART2]     = 164,
     [ASPEED_DEV_UART3]     = 164,
-    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_UART5]     = 164,
     [ASPEED_DEV_UART6]     = 164,
     [ASPEED_DEV_UART7]     = 164,
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] = {
     [ASPEED_DEV_UART10]    = 164,
     [ASPEED_DEV_UART11]    = 164,
     [ASPEED_DEV_UART12]    = 164,
-    [ASPEED_DEV_TIMER1]    = 16,
 };
 
 /* TSPINT 164 */
-- 
2.43.0


