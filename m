Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48138E7E36C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c06-0003zV-7Q; Fri, 03 Apr 2026 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c03-0003yc-EW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8c01-0005YN-SN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212971; bh=sxYYGzxX13JLYTURZXmXs1BXBksyTpPz/55bI456ahI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pYkecZT+t+EzK+2uNSv2aGwNevLhB7vxO3KgyjSCjI50c8yNU67LSde9SZ0Akv9+Q
 1q9fljJVSbkFRt98pP6nL9P7C7C7ZqLIJDq7EAy90bJhyhnJT3GfV3NEBFSNSLB7Hb
 mpTGOnrUbTsqyAWPzEJCUZd6K/3h4HTUIuZQ99VJsq8TgVWfa6fmy0s22dP1qimYNO
 x52pNSLM95dxhgW602f5RiUsA6yggO1AIYwxxNSYdopcG+J/VCHoszHBmZqDHDr82P
 7d37SMHeflT1gZXRJx3YS9cob9SN0pvQW7npN03z/7L4GTeDQBOR7Pp3qk22sA41ls
 vbiANOzvKKeOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0CD2119A63C;
 Fri, 03 Apr 2026 13:42:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BF64B38DB6C;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.0 2/6] hw/core: Move compat_props_add() to
 'hw/core/boards.h'
Date: Fri,  3 Apr 2026 13:43:22 +0300
Message-ID: <20260403104327.1163942-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

compat_props_add() is only used by board models, no need
to expose it to any device model. Restrict by defining it
only in "hw/core/boards.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/core/boards.h | 10 ++++++++++
 include/hw/core/qdev.h   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b8dad0a107..0ac7e17ef7 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -798,6 +798,16 @@ struct MachineState {
         } \
     } while (0)
 
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i = 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979cc..778617787c 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -421,16 +421,6 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
-static inline void
-compat_props_add(GPtrArray *arr,
-                 GlobalProperty props[], size_t nelem)
-{
-    int i;
-    for (i = 0; i < nelem; i++) {
-        g_ptr_array_add(arr, (void *)&props[i]);
-    }
-}
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
-- 
2.47.3


