Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17900D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qF-0003Ww-VW; Fri, 29 Nov 2024 12:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qD-0003W6-3K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qA-0000qC-1p
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNFHcHWOGgepYw99svZdEFAwAytxphNPjWVwME+fCwc=;
 b=aUptLIaojRIAVVMseisiikzqQq/HFCs0VjsYFQMZ5g0XwHNOl5RQ5/Ou0PzHs7t6144YV4
 WE3G/eZg5GqFizciSQ9xJNQMJj8bNpZJ9C0tjlsteKC/ZFGV7vKRJbVTok7dMQ4bkHx0+I
 ggrVS3FU/WQ1bunKf32R4xS7hYunNEY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-V7QKmYQ0Pp6_wbcmcjovZA-1; Fri,
 29 Nov 2024 12:31:33 -0500
X-MC-Unique: V7QKmYQ0Pp6_wbcmcjovZA-1
X-Mimecast-MFC-AGG-ID: V7QKmYQ0Pp6_wbcmcjovZA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B491955F40; Fri, 29 Nov 2024 17:31:32 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 895241955F41; Fri, 29 Nov 2024 17:31:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/22] tests/functional: remove duplicated 'qemu_test' import
 statements
Date: Fri, 29 Nov 2024 17:31:01 +0000
Message-ID: <20241129173120.761728-4-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Group all imports that originate in the 'qemu_test' package into
one statement.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/tuxruntest.py         |  9 +++++----
 tests/functional/test_aarch64_raspi4.py          |  4 ++--
 tests/functional/test_aarch64_sbsaref.py         |  5 ++---
 tests/functional/test_aarch64_sbsaref_alpine.py  |  5 ++---
 tests/functional/test_aarch64_sbsaref_freebsd.py |  5 ++---
 tests/functional/test_aarch64_virt.py            |  6 ++----
 tests/functional/test_arm_aspeed.py              |  7 +++----
 tests/functional/test_arm_bflt.py                |  3 +--
 tests/functional/test_arm_bpim2u.py              |  8 ++++----
 tests/functional/test_arm_canona1100.py          |  3 +--
 tests/functional/test_arm_integratorcp.py        |  3 +--
 tests/functional/test_arm_orangepi.py            | 10 +++++-----
 tests/functional/test_arm_raspi2.py              |  4 ++--
 tests/functional/test_loongarch64_virt.py        |  6 +++---
 tests/functional/test_microblaze_s3adsp1800.py   |  5 ++---
 tests/functional/test_microblazeel_s3adsp1800.py |  5 ++---
 tests/functional/test_mips64el_fuloong2e.py      |  7 ++++---
 tests/functional/test_mips64el_loongson3v.py     |  3 +--
 tests/functional/test_mips64el_malta.py          |  4 ++--
 tests/functional/test_mipsel_malta.py            |  6 +++---
 tests/functional/test_multiprocess.py            |  4 ++--
 tests/functional/test_netdev_ethtool.py          |  3 +--
 tests/functional/test_ppc64_hv.py                |  4 ++--
 tests/functional/test_ppc64_powernv.py           |  3 +--
 tests/functional/test_ppc64_pseries.py           |  3 +--
 tests/functional/test_ppc_405.py                 |  6 +++---
 tests/functional/test_ppc_40p.py                 |  3 +--
 tests/functional/test_ppc_74xx.py                |  3 +--
 tests/functional/test_ppc_amiga.py               |  3 +--
 tests/functional/test_ppc_bamboo.py              |  6 +++---
 tests/functional/test_ppc_mpc8544ds.py           |  3 +--
 tests/functional/test_ppc_virtex_ml507.py        |  3 +--
 tests/functional/test_riscv_opensbi.py           |  4 ++--
 tests/functional/test_rx_gdbsim.py               |  6 +++---
 tests/functional/test_s390x_ccw_virtio.py        |  6 +++---
 tests/functional/test_s390x_topology.py          |  7 +++----
 tests/functional/test_sh4eb_r2d.py               |  4 ++--
 tests/functional/test_sparc64_sun4u.py           |  3 +--
 tests/functional/test_virtio_gpu.py              | 10 ++++------
 39 files changed, 85 insertions(+), 107 deletions(-)

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ab3b27da43..7c0456923e 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -13,10 +13,11 @@
 import stat
 import time
 
-from qemu_test import QemuSystemTest
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
-from qemu_test import has_cmd, run_cmd, get_qemu_img
+from qemu_test import (QemuSystemTest, exec_command,
+                       exec_command_and_wait_for_pattern,
+                       wait_for_console_pattern,
+                       has_cmd, run_cmd, get_qemu_img)
+
 
 class TuxRunBaselineTest(QemuSystemTest):
 
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/test_aarch64_raspi4.py
index e5c9f77479..95e9c8e643 100755
--- a/tests/functional/test_aarch64_raspi4.py
+++ b/tests/functional/test_aarch64_raspi4.py
@@ -7,8 +7,8 @@
 
 import os
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (LinuxKernelTest, Asset,
+                       exec_command_and_wait_for_pattern)
 from qemu_test.utils import gzip_uncompress
 
 
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 6db08da522..8064b691c7 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -10,9 +10,8 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       interrupt_interactive_console_until_pattern)
 from qemu_test.utils import lzma_uncompress
 
 def fetch_firmware(test):
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index ebc29b2fb5..6496418659 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -10,9 +10,8 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       interrupt_interactive_console_until_pattern)
 from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 80298dd190..002da59ea2 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -10,9 +10,8 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       interrupt_interactive_console_until_pattern)
 from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index c967da41b4..07b78f6a84 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -14,10 +14,8 @@
 import os
 import logging
 
-from qemu_test import BUILD_DIR
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, wait_for_console_pattern
-from qemu_test import get_qemu_img, run_cmd
+from qemu_test import (BUILD_DIR, QemuSystemTest, Asset, exec_command,
+                       wait_for_console_pattern, get_qemu_img, run_cmd)
 
 
 class Aarch64VirtMachine(QemuSystemTest):
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index d88170ac24..068740a813 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -11,10 +11,9 @@
 import subprocess
 import tempfile
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import has_cmd
+from qemu_test import (LinuxKernelTest, Asset,
+                       exec_command_and_wait_for_pattern,
+                       interrupt_interactive_console_until_pattern, has_cmd)
 from qemu_test.utils import archive_extract
 from zipfile import ZipFile
 from unittest import skipUnless
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/test_arm_bflt.py
index 281925d11a..cd417ebcfc 100755
--- a/tests/functional/test_arm_bflt.py
+++ b/tests/functional/test_arm_bflt.py
@@ -9,8 +9,7 @@
 import os
 import bz2
 
-from qemu_test import QemuUserTest, Asset
-from qemu_test import has_cmd
+from qemu_test import QemuUserTest, Asset, has_cmd
 from qemu_test.utils import cpio_extract
 from unittest import skipUnless
 
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 35ea58d46c..7b1b0a270f 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -7,10 +7,10 @@
 
 import os
 
-from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
-from qemu_test import Asset, interrupt_interactive_console_until_pattern
-from qemu_test.utils import archive_extract, gzip_uncompress, lzma_uncompress
-from qemu_test.utils import image_pow2ceil_expand
+from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
+                       Asset, interrupt_interactive_console_until_pattern)
+from qemu_test.utils import (archive_extract, gzip_uncompress, lzma_uncompress,
+                             image_pow2ceil_expand)
 from unittest import skipUnless
 
 class BananaPiMachine(LinuxKernelTest):
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
index 65f1228296..41e78b7d1b 100755
--- a/tests/functional/test_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -10,8 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test.utils import archive_extract
 
 class CanonA1100Machine(QemuSystemTest):
diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
index 0fe083f661..c2c6ff6ac5 100755
--- a/tests/functional/test_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -15,8 +15,7 @@
 import os
 import logging
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from unittest import skipUnless
 
 
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 6d57223a03..676327e8ef 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -8,11 +8,11 @@
 import os
 import shutil
 
-from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
-from qemu_test import Asset, interrupt_interactive_console_until_pattern
-from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract, gzip_uncompress, lzma_uncompress
-from qemu_test.utils import image_pow2ceil_expand
+from qemu_test import (LinuxKernelTest, exec_command_and_wait_for_pattern,
+                       Asset, interrupt_interactive_console_until_pattern,
+                       wait_for_console_pattern)
+from qemu_test.utils import (archive_extract, gzip_uncompress, lzma_uncompress,
+                             image_pow2ceil_expand)
 from unittest import skipUnless
 
 class BananaPiMachine(LinuxKernelTest):
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/test_arm_raspi2.py
index 3bf079dc4d..4d31454f8f 100755
--- a/tests/functional/test_arm_raspi2.py
+++ b/tests/functional/test_arm_raspi2.py
@@ -9,8 +9,8 @@
 
 import os
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (LinuxKernelTest, Asset,
+                       exec_command_and_wait_for_pattern)
 from qemu_test.utils import gzip_uncompress
 
 
diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/test_loongarch64_virt.py
index b7d9abf933..38cdd85f97 100755
--- a/tests/functional/test_loongarch64_virt.py
+++ b/tests/functional/test_loongarch64_virt.py
@@ -7,9 +7,9 @@
 # Copyright (c) 2023 Loongson Technology Corporation Limited
 #
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import (QemuSystemTest, Asset,
+                       exec_command_and_wait_for_pattern,
+                       wait_for_console_pattern)
 
 class LoongArchMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index d2be3105a2..387feb5dcc 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,9 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import (exec_command, exec_command_and_wait_for_pattern,
+                       QemuSystemTest, Asset, wait_for_console_pattern)
 from qemu_test.utils import archive_extract
 
 class MicroblazeMachine(QemuSystemTest):
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index faa3927f2e..875e2ab14c 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -8,9 +8,8 @@
 # later. See the COPYING file in the top-level directory.
 
 import time
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import (exec_command, exec_command_and_wait_for_pattern,
+                       QemuSystemTest, Asset, wait_for_console_pattern)
 from qemu_test.utils import archive_extract
 
 class MicroblazeelMachine(QemuSystemTest):
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
index a32d5f9d08..8d0ae8d1d5 100755
--- a/tests/functional/test_mips64el_fuloong2e.py
+++ b/tests/functional/test_mips64el_fuloong2e.py
@@ -12,10 +12,11 @@
 import os
 import subprocess
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import (LinuxKernelTest, Asset, wait_for_console_pattern,
+                       skipUntrustedTest)
 from unittest import skipUnless
 
+
 class MipsFuloong2e(LinuxKernelTest):
 
     timeout = 60
@@ -39,7 +40,7 @@ def test_linux_kernel_3_16(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUntrustedTest()
     @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')
     def test_linux_kernel_2_6_27_isa_serial(self):
         # Recovery system for the Yeeloong laptop
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/test_mips64el_loongson3v.py
index e57ec5499e..06032a3a6b 100755
--- a/tests/functional/test_mips64el_loongson3v.py
+++ b/tests/functional/test_mips64el_loongson3v.py
@@ -12,8 +12,7 @@
 import os
 
 from unittest import skipUnless
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class MipsLoongson3v(QemuSystemTest):
     timeout = 60
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 6d1195d362..b5959d33ea 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -12,8 +12,8 @@
 import os
 import logging
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (LinuxKernelTest, Asset,
+                       exec_command_and_wait_for_pattern)
 from qemu_test.utils import gzip_uncompress
 from unittest import skipUnless
 
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
index b8dfddd856..af6d280f99 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/test_mipsel_malta.py
@@ -11,9 +11,9 @@
 
 import os
 
-from qemu_test import QemuSystemTest, LinuxKernelTest, Asset
-from qemu_test import interrupt_interactive_console_until_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import (QemuSystemTest, LinuxKernelTest, Asset,
+                       interrupt_interactive_console_until_pattern,
+                       wait_for_console_pattern)
 from qemu_test.utils import lzma_uncompress
 from zipfile import ZipFile
 
diff --git a/tests/functional/test_multiprocess.py b/tests/functional/test_multiprocess.py
index 751cf10e63..33fcb26381 100755
--- a/tests/functional/test_multiprocess.py
+++ b/tests/functional/test_multiprocess.py
@@ -9,8 +9,8 @@
 import os
 import socket
 
-from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       exec_command, exec_command_and_wait_for_pattern)
 
 class Multiprocess(QemuSystemTest):
 
diff --git a/tests/functional/test_netdev_ethtool.py b/tests/functional/test_netdev_ethtool.py
index ee1a397bd2..ca4d374de7 100755
--- a/tests/functional/test_netdev_ethtool.py
+++ b/tests/functional/test_netdev_ethtool.py
@@ -8,8 +8,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from unittest import skip
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class NetDevEthtool(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 312248bbfe..c31432d18d 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -10,8 +10,8 @@
 # later.  See the COPYING file in the top-level directory.
 
 from unittest import skipIf, skipUnless
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       exec_command)
 import os
 import time
 import subprocess
diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 685e2178ed..4d570a9867 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -7,8 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
 
 class powernvMachine(LinuxKernelTest):
 
diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
index fdc404ed03..faca7f46f2 100755
--- a/tests/functional/test_ppc64_pseries.py
+++ b/tests/functional/test_ppc64_pseries.py
@@ -7,8 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class pseriesMachine(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc_405.py b/tests/functional/test_ppc_405.py
index 9851c03ee9..04df038af7 100755
--- a/tests/functional/test_ppc_405.py
+++ b/tests/functional/test_ppc_405.py
@@ -7,9 +7,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       exec_command_and_wait_for_pattern)
+
 
 class Ppc405Machine(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index 67bcdae53a..496282b164 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -10,8 +10,7 @@
 import os
 
 from unittest import skipUnless
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 
 class IbmPrep40pMachine(QemuSystemTest):
diff --git a/tests/functional/test_ppc_74xx.py b/tests/functional/test_ppc_74xx.py
index 5386016f26..1c3e6b2c94 100755
--- a/tests/functional/test_ppc_74xx.py
+++ b/tests/functional/test_ppc_74xx.py
@@ -7,8 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, wait_for_console_pattern
 
 class ppc74xxCpu(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
index b793b5c432..e92489fdb2 100755
--- a/tests/functional/test_ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -9,8 +9,7 @@
 
 import subprocess
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern, run_cmd
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern, run_cmd
 from zipfile import ZipFile
 
 class AmigaOneMachine(QemuSystemTest):
diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
index e72cbdee12..71b30781f1 100755
--- a/tests/functional/test_ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -8,9 +8,9 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test.utils import archive_extract
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
+                       exec_command_and_wait_for_pattern)
+
 
 class BambooMachine(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/test_ppc_mpc8544ds.py
index 2b3f0894ae..746efda1ae 100755
--- a/tests/functional/test_ppc_mpc8544ds.py
+++ b/tests/functional/test_ppc_mpc8544ds.py
@@ -8,8 +8,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test.utils import archive_extract
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class Mpc8544dsMachine(QemuSystemTest):
 
diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional/test_ppc_virtex_ml507.py
index ffa9a0633e..3c49d41341 100755
--- a/tests/functional/test_ppc_virtex_ml507.py
+++ b/tests/functional/test_ppc_virtex_ml507.py
@@ -8,8 +8,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test.utils import archive_extract
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
 class VirtexMl507Machine(QemuSystemTest):
 
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/test_riscv_opensbi.py
index d077e40f42..bccc2b2fe1 100755
--- a/tests/functional/test_riscv_opensbi.py
+++ b/tests/functional/test_riscv_opensbi.py
@@ -7,8 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import QemuSystemTest
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, wait_for_console_pattern
+
 
 class RiscvOpenSBI(QemuSystemTest):
 
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/test_rx_gdbsim.py
index 5687f756bb..6306863519 100755
--- a/tests/functional/test_rx_gdbsim.py
+++ b/tests/functional/test_rx_gdbsim.py
@@ -13,9 +13,9 @@
 import os
 
 from unittest import skipUnless
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import (QemuSystemTest, Asset,
+                       exec_command_and_wait_for_pattern,
+                       wait_for_console_pattern)
 from qemu_test.utils import gzip_uncompress
 
 
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
index f7acd90a89..c9d4730856 100755
--- a/tests/functional/test_s390x_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -14,9 +14,9 @@
 import os
 import tempfile
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import (QemuSystemTest, Asset,
+                       exec_command_and_wait_for_pattern,
+                       wait_for_console_pattern)
 from qemu_test.utils import lzma_uncompress
 
 class S390CCWVirtioMachine(QemuSystemTest):
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
index c54c7a8177..6bf64f09fe 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -12,10 +12,9 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
+from qemu_test import (QemuSystemTest, Asset, exec_command,
+                       exec_command_and_wait_for_pattern,
+                       wait_for_console_pattern)
 from qemu_test.utils import lzma_uncompress
 
 
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
index cd46007942..66daf8add4 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -7,8 +7,8 @@
 import os
 import shutil
 
-from qemu_test import LinuxKernelTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import (LinuxKernelTest, Asset,
+                       exec_command_and_wait_for_pattern)
 from qemu_test.utils import archive_extract
 
 class R2dEBTest(LinuxKernelTest):
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
index 32e245f4ad..798d6c3fb5 100755
--- a/tests/functional/test_sparc64_sun4u.py
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -12,8 +12,7 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test.utils import archive_extract
 
 class Sun4uMachine(QemuSystemTest):
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index d5027487ac..bc3b00e497 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -6,12 +6,10 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from qemu_test import BUILD_DIR
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import is_readable_executable_file
-
+from qemu_test import (BUILD_DIR, QemuSystemTest, Asset,
+                       wait_for_console_pattern,
+                       exec_command_and_wait_for_pattern,
+                       is_readable_executable_file)
 from qemu.utils import kvm_available
 
 import os
-- 
2.46.0


