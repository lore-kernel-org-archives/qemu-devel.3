Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF01ACF58E4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYI6-00049b-3c; Fri, 20 Sep 2024 03:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYI3-0003m4-H9; Fri, 20 Sep 2024 03:42:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYI1-0000JV-MB; Fri, 20 Sep 2024 03:42:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8AF890867;
 Fri, 20 Sep 2024 10:41:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FA171409EA;
 Fri, 20 Sep 2024 10:41:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 17/22] tests/bench: Rename test_akcipher_keys.inc ->
 test_akcipher_keys.c.inc
Date: Fri, 20 Sep 2024 10:41:29 +0300
Message-Id: <20240920074134.664961-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Rename "test_akcipher_keys.inc" as "test_akcipher_keys.c.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/bench/benchmark-crypto-akcipher.c                         | 2 +-
 .../bench/{test_akcipher_keys.inc => test_akcipher_keys.c.inc}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/bench/{test_akcipher_keys.inc => test_akcipher_keys.c.inc} (100%)

diff --git a/tests/bench/benchmark-crypto-akcipher.c b/tests/bench/benchmark-crypto-akcipher.c
index 750c7e89ee..0a6e5db1d6 100644
--- a/tests/bench/benchmark-crypto-akcipher.c
+++ b/tests/bench/benchmark-crypto-akcipher.c
@@ -16,7 +16,7 @@
 #include "crypto/akcipher.h"
 #include "standard-headers/linux/virtio_crypto.h"
 
-#include "test_akcipher_keys.inc"
+#include "test_akcipher_keys.c.inc"
 
 static QCryptoAkCipher *create_rsa_akcipher(const uint8_t *priv_key,
                                             size_t keylen,
diff --git a/tests/bench/test_akcipher_keys.inc b/tests/bench/test_akcipher_keys.c.inc
similarity index 100%
rename from tests/bench/test_akcipher_keys.inc
rename to tests/bench/test_akcipher_keys.c.inc
-- 
2.39.5


