Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98821C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7Fx-0004qO-Pt; Thu, 22 Feb 2024 06:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Ft-0004TE-SN; Thu, 22 Feb 2024 06:28:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Fo-0005F8-Im; Thu, 22 Feb 2024 06:28:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 55CD14FB61;
 Thu, 22 Feb 2024 14:26:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D07298718D;
 Thu, 22 Feb 2024 14:26:03 +0300 (MSK)
Received: (nullmailer pid 2526235 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 31/34] target/sparc: correct typos
Date: Thu, 22 Feb 2024 14:25:58 +0300
Message-Id: <20240222112601.2526057-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/sparc/asi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index 3270ed0c7f..a66829674b 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -145,14 +145,14 @@
  * and later ASIs.
  */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
-#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
-#define ASI_REAL_IO             0x15 /* Real address, non-cachable      */
+#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
+#define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
 #define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
 #define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
 #define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
-#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
-#define ASI_REAL_IO_L           0x1d /* Real address, non-cachable, LE  */
+#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cacheable, little endian*/
+#define ASI_REAL_IO_L           0x1d /* Real address, non-cacheable, LE  */
 #define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
 #define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
 #define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
-- 
2.39.2


