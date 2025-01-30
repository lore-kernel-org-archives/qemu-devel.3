Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5ABC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUhF-0002iN-0z; Thu, 30 Jan 2025 08:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUhC-0002gN-RW; Thu, 30 Jan 2025 08:35:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUhA-0002Xw-O7; Thu, 30 Jan 2025 08:35:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03513E3044;
 Thu, 30 Jan 2025 16:34:19 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E74391A7F8B;
 Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D131E5240C; Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/7] licenses: Remove SPDX tags not being license identifier
 for Linaro
Date: Thu, 30 Jan 2025 16:34:46 +0300
Message-Id: <20250130133447.873566-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250130133447.873566-1-mjt@tls.msk.ru>
References: <20250130133447.873566-1-mjt@tls.msk.ru>
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

Per [*]:

  "we're only interested in adopting SPDX for recording the
  licensing info, [not] any other SPDX metadata."

Replace the 'SPDX-FileCopyrightText' and 'SPDX-FileContributor'
tags added by Linaro by 'Copyright (c)' and 'Authors' words
respectively.

[*] https://lore.kernel.org/qemu-devel/20241007154548.1144961-4-berrange@redhat.com/

Inspired-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 accel/tcg/vcpu-state.h                           | 9 +++++++--
 hw/misc/ivshmem-flat.c                           | 5 +++--
 include/hw/misc/ivshmem-flat.h                   | 5 +++--
 scripts/qom-cast-macro-clean-cocci-gen.py        | 7 +++++--
 target/m68k/semihosting-stub.c                   | 7 +++++--
 target/mips/tcg/system/semihosting-stub.c        | 5 +++--
 tests/functional/test_aarch64_sbsaref.py         | 8 +++++---
 tests/functional/test_aarch64_sbsaref_alpine.py  | 8 +++++---
 tests/functional/test_aarch64_sbsaref_freebsd.py | 8 +++++---
 tests/qtest/libqos/virtio-scmi.c                 | 2 +-
 10 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index e407d914df..2e3464b5ee 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -1,6 +1,11 @@
 /*
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * TaskState helpers for QEMU
+ *
+ * Copyright (c) 2023 Linaro Ltd.
+ *
+ * Authors:
+ *   Philippe Mathieu-Daudé
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef ACCEL_TCG_VCPU_STATE_H
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 33fc9425d2..40309a8ff3 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -1,9 +1,10 @@
 /*
  * Inter-VM Shared Memory Flat Device
  *
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
- * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2023 Linaro Ltd.
+ * Authors:
+ *   Gustavo Romero
  *
  */
 
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 97ca0ddce6..0c2b015781 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -1,9 +1,10 @@
 /*
  * Inter-VM Shared Memory Flat Device
  *
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
- * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2023 Linaro Ltd.
+ * Authors:
+ *   Gustavo Romero
  *
  */
 
diff --git a/scripts/qom-cast-macro-clean-cocci-gen.py b/scripts/qom-cast-macro-clean-cocci-gen.py
index 2fa8438a14..5aa51d0c18 100644
--- a/scripts/qom-cast-macro-clean-cocci-gen.py
+++ b/scripts/qom-cast-macro-clean-cocci-gen.py
@@ -13,8 +13,11 @@
 #           --in-place \
 #           --dir .
 #
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileCopyrightText: 2023 Linaro Ltd.
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import re
diff --git a/target/m68k/semihosting-stub.c b/target/m68k/semihosting-stub.c
index d6a5965e29..dbe669cc5f 100644
--- a/target/m68k/semihosting-stub.c
+++ b/target/m68k/semihosting-stub.c
@@ -1,8 +1,11 @@
 /*
  *  m68k/ColdFire semihosting stub
  *
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors:
+ *   Philippe Mathieu-Daudé
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
diff --git a/target/mips/tcg/system/semihosting-stub.c b/target/mips/tcg/system/semihosting-stub.c
index 7ae27d746f..bb1f7aae62 100644
--- a/target/mips/tcg/system/semihosting-stub.c
+++ b/target/mips/tcg/system/semihosting-stub.c
@@ -1,9 +1,10 @@
 /*
  *  MIPS semihosting stub
  *
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2024 Linaro Ltd.
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2024 Linaro Ltd.
+ * Authors:
+ *   Philippe Mathieu-Daudé
  */
 
 #include "qemu/osdep.h"
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 99cfb6f29a..e6a55aecfa 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6dbc90f30e..9faf066d18 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 77ba2ba1da..8dcb4991c3 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/qtest/libqos/virtio-scmi.c b/tests/qtest/libqos/virtio-scmi.c
index ce8f4d5c06..6b5bd4db42 100644
--- a/tests/qtest/libqos/virtio-scmi.c
+++ b/tests/qtest/libqos/virtio-scmi.c
@@ -1,7 +1,7 @@
 /*
  * virtio-scmi nodes for testing
  *
- * SPDX-FileCopyrightText: Linaro Ltd
+ * Copyright (c) Linaro Ltd.
  * SPDX-FileCopyrightText: Red Hat, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
-- 
2.39.5


