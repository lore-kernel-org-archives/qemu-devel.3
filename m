Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5001CF58E4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYI9-0004g0-Ry; Fri, 20 Sep 2024 03:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYI7-0004Ra-Do; Fri, 20 Sep 2024 03:42:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYI5-0000LG-1b; Fri, 20 Sep 2024 03:42:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E95D990869;
 Fri, 20 Sep 2024 10:41:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 906371409EC;
 Fri, 20 Sep 2024 10:41:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 19/22] license: Simplify GPL-2.0-or-later license descriptions
Date: Fri, 20 Sep 2024 10:41:31 +0300
Message-Id: <20240920074134.664961-20-mjt@tls.msk.ru>
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

Since the "2 | 3+" expression can be simplified as "2+",
it is pointless to mention the GPLv3 license.

Add the corresponding SPDX identifier to remove all doubt.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vdi.c                  | 4 +++-
 hw/net/eepro100.c            | 4 +++-
 hw/ppc/rs6000_mc.c           | 4 +++-
 include/qemu/timed-average.h | 4 +++-
 qemu.nsi                     | 4 +++-
 util/timed-average.c         | 4 +++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6363da08ce..149e15c831 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -3,10 +3,12 @@
  *
  * Copyright (c) 2009, 2012 Stefan Weil
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
- * (at your option) version 3 or any later version.
+ * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index d9a70c4544..c8a88b9813 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -6,10 +6,12 @@
  * Portions of the code are copies from grub / etherboot eepro100.c
  * and linux e100.c.
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
- * (at your option) version 3 or any later version.
+ * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index e6ec4b4c40..07b0b664d9 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -3,10 +3,12 @@
  *
  * Copyright (c) 2017 Hervé Poussineau
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
- * (at your option) version 3 or any later version.
+ * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/timed-average.h b/include/qemu/timed-average.h
index 08245e7a10..dfd8d653fa 100644
--- a/include/qemu/timed-average.h
+++ b/include/qemu/timed-average.h
@@ -8,10 +8,12 @@
  *   Benoît Canet <benoit.canet@nodalink.com>
  *   Alberto Garcia <berto@igalia.com>
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
- * (at your option) version 3 or any later version.
+ * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/qemu.nsi b/qemu.nsi
index 564d617d11..b186f223e1 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -7,7 +7,7 @@
 ; This program is free software: you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
 ; the Free Software Foundation, either version 2 of the License, or
-; (at your option) version 3 or any later version.
+; (at your option) any later version.
 ;
 ; This program is distributed in the hope that it will be useful,
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -16,6 +16,8 @@
 ;
 ; You should have received a copy of the GNU General Public License
 ; along with this program.  If not, see <http://www.gnu.org/licenses/>.
+;
+; SPDX-License-Identifier: GPL-2.0-or-later
 
 ; NSIS_WIN32_MAKENSIS
 
diff --git a/util/timed-average.c b/util/timed-average.c
index 2b49d532ce..5b5c22afd8 100644
--- a/util/timed-average.c
+++ b/util/timed-average.c
@@ -8,10 +8,12 @@
  *   Benoît Canet <benoit.canet@nodalink.com>
  *   Alberto Garcia <berto@igalia.com>
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
- * (at your option) version 3 or any later version.
+ * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.39.5


