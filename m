Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87593CF58E5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYIX-0006Yy-Ju; Fri, 20 Sep 2024 03:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYIA-0004qU-SU; Fri, 20 Sep 2024 03:43:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYI8-0000Lo-SI; Fri, 20 Sep 2024 03:43:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2C869086B;
 Fri, 20 Sep 2024 10:41:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 94CAC1409EE;
 Fri, 20 Sep 2024 10:41:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 21/22] license: Update deprecated SPDX tag GPL-2.0+ to
 GPL-2.0-or-later
Date: Fri, 20 Sep 2024 10:41:33 +0300
Message-Id: <20240920074134.664961-22-mjt@tls.msk.ru>
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

The 'GPL-2.0+' license identifier has been deprecated since license
list version 2.0rc2 [1] and replaced by the 'GPL-2.0-or-later' [2]
tag.

[1] https://spdx.org/licenses/GPL-2.0+.html
[2] https://spdx.org/licenses/GPL-2.0-or-later.html

Mechanical patch running:

  $ sed -i -e s/GPL-2.0+/GPL-2.0-or-later/ \
    $(git grep -lP 'SPDX-License-Identifier: \W+GPL-2.0\+[ $]' \
        | egrep -v '^linux-headers|^include/standard-headers')

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/uboot_image.h           | 2 +-
 hw/nvram/fw_cfg-acpi.c          | 2 +-
 hw/virtio/virtio-acpi.c         | 2 +-
 include/hw/nvram/fw_cfg_acpi.h  | 2 +-
 include/hw/usb/dwc2-regs.h      | 2 +-
 include/hw/virtio/virtio-acpi.h | 2 +-
 target/riscv/cpu-param.h        | 2 +-
 target/s390x/cpu-param.h        | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/core/uboot_image.h b/hw/core/uboot_image.h
index 18ac293359..e4dcfb08f0 100644
--- a/hw/core/uboot_image.h
+++ b/hw/core/uboot_image.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * (C) Copyright 2008 Semihalf
  *
diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
index 58cdcd3121..2e6ef89b98 100644
--- a/hw/nvram/fw_cfg-acpi.c
+++ b/hw/nvram/fw_cfg-acpi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Add fw_cfg device in DSDT
  *
diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
index 230a669500..85becef03c 100644
--- a/hw/virtio/virtio-acpi.c
+++ b/hw/virtio/virtio-acpi.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * virtio ACPI Support
  *
diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
index b39eb0490f..dfd2a44ef0 100644
--- a/include/hw/nvram/fw_cfg_acpi.h
+++ b/include/hw/nvram/fw_cfg_acpi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * ACPI support for fw_cfg
  *
diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
index 0bf3f2aa17..523b112c5e 100644
--- a/include/hw/usb/dwc2-regs.h
+++ b/include/hw/usb/dwc2-regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
 /*
  * Imported from the Linux kernel file drivers/usb/dwc2/hw.h, commit
  * a89bae709b3492b478480a2c9734e7e9393b279c ("usb: dwc2: Move
diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
index cace2a315f..cdfbd943ae 100644
--- a/include/hw/virtio/virtio-acpi.h
+++ b/include/hw/virtio/virtio-acpi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * ACPI support for virtio
  */
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index 1fbd64939d..25686192c0 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -2,7 +2,7 @@
  * RISC-V cpu parameters for qemu.
  *
  * Copyright (c) 2017-2018 SiFive, Inc.
- * SPDX-License-Identifier: GPL-2.0+
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef RISCV_CPU_PARAM_H
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 11d23b600d..a05ffcf78d 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -2,7 +2,7 @@
  * S/390 cpu parameters for qemu.
  *
  * Copyright (c) 2009 Ulrich Hecht
- * SPDX-License-Identifier: GPL-2.0+
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef S390_CPU_PARAM_H
-- 
2.39.5


