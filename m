Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88D4D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhnY-0001SN-2L; Wed, 03 Dec 2025 03:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnV-0001KY-UC; Wed, 03 Dec 2025 03:01:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnS-00071H-TR; Wed, 03 Dec 2025 03:01:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45B81170771;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1397B32B498;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 100/116] tests/functional: Remove unnecessary import
 statements
Date: Wed,  3 Dec 2025 10:59:20 +0300
Message-ID: <20251203075939.2366131-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

pylint complains about these unnecessary import statements,
so let's remove them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250414145457.261734-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 99fb9256b761c3cec4a82d2e9597b6cf24ae1285)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
index cc39939d48..631b77abf6 100644
--- a/tests/functional/qemu_test/ports.py
+++ b/tests/functional/qemu_test/ports.py
@@ -10,12 +10,11 @@
 import fcntl
 import os
 import socket
-import sys
-import tempfile
 
 from .config import BUILD_DIR
 from typing import List
 
+
 class Ports():
 
     PORTS_ADDR = '127.0.0.1'
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index c2bd5baaae..6c442ff0dc 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -10,8 +10,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import stat
-from subprocess import check_call, DEVNULL
 
 from qemu_test import QemuSystemTest
 from qemu_test import exec_command_and_wait_for_pattern
diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
index ce79da1b68..b7ef8f759b 100644
--- a/tests/functional/qemu_test/uncompress.py
+++ b/tests/functional/qemu_test/uncompress.py
@@ -13,7 +13,7 @@
 import stat
 import shutil
 from urllib.parse import urlparse
-from subprocess import run, CalledProcessError, DEVNULL
+from subprocess import run, CalledProcessError
 
 from .asset import Asset
 
diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 0f4f6103a1..746770e776 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -9,15 +9,13 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import time
 import os
-import logging
 
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 from test_aarch64_rme_virt import test_realms_guest
 
+
 class Aarch64RMESbsaRefMachine(QemuSystemTest):
 
     # Stack is built with OP-TEE build environment from those instructions:
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index a1abf584f0..8452d27928 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -9,9 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import time
 import os
-import logging
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command, wait_for_console_pattern
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index c660cc7a40..6108ec65a5 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -10,11 +10,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 2a26281d25..92ebc69c9b 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -10,8 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
 from test_aarch64_sbsaref import fetch_firmware
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 4ea71f5f88..cb7e9298fb 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -13,7 +13,6 @@
 
 import tempfile
 import mmap
-import os
 import re
 
 from qemu.machine.machine import VMLaunchFailure
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 249f22d978..7a6297f75c 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -13,12 +13,8 @@
 import logging
 from subprocess import check_call, DEVNULL
 
-from qemu.machine.machine import VMLaunchFailure
-
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
-from qemu_test import wait_for_console_pattern
-from qemu_test import skipIfMissingCommands, get_qemu_img
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern, get_qemu_img
 
 
 class Aarch64VirtMachine(QemuSystemTest):
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
index ddc6459f71..a3b44572fc 100755
--- a/tests/functional/test_arm_aspeed_ast2500.py
+++ b/tests/functional/test_arm_aspeed_ast2500.py
@@ -4,9 +4,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, exec_command_and_wait_for_pattern
 from aspeed import AspeedTest
-from qemu_test import exec_command_and_wait_for_pattern
 
 
 class AST2500Machine(AspeedTest):
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index 1eaca0272b..b536c2f77a 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -4,8 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import skipBigDataTest
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/test_arm_quanta_gsj.py
index da60aeb659..cb0545f7bf 100755
--- a/tests/functional/test_arm_quanta_gsj.py
+++ b/tests/functional/test_arm_quanta_gsj.py
@@ -4,8 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern, skipSlowTest
 
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
index 0fda45c63a..3154e7f732 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -4,8 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 
 
diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
index 181223a69e..c4393c3543 100755
--- a/tests/functional/test_migration.py
+++ b/tests/functional/test_migration.py
@@ -11,14 +11,13 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-
 import tempfile
-import os
 import time
 
 from qemu_test import QemuSystemTest, skipIfMissingCommands
 from qemu_test.ports import Ports
 
+
 class MigrationTest(QemuSystemTest):
 
     timeout = 10
diff --git a/tests/functional/test_mips64el_replay.py b/tests/functional/test_mips64el_replay.py
index 4f63d7fb34..26a6ccff3f 100755
--- a/tests/functional/test_mips64el_replay.py
+++ b/tests/functional/test_mips64el_replay.py
@@ -4,11 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-import logging
-
-from qemu_test import Asset, exec_command_and_wait_for_pattern
-from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
+from qemu_test import Asset, skipUntrustedTest
 from replay_kernel import ReplayKernelBase
 
 
diff --git a/tests/functional/test_mips_replay.py b/tests/functional/test_mips_replay.py
index eda031ccad..4327481e35 100755
--- a/tests/functional/test_mips_replay.py
+++ b/tests/functional/test_mips_replay.py
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, skipSlowTest, exec_command_and_wait_for_pattern
+from qemu_test import Asset, skipSlowTest
 from replay_kernel import ReplayKernelBase
 
 
diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/test_mipsel_replay.py
index 0a330de43f..5f4796cf89 100644
--- a/tests/functional/test_mipsel_replay.py
+++ b/tests/functional/test_mipsel_replay.py
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, wait_for_console_pattern, skipSlowTest
+from qemu_test import Asset, skipSlowTest
 from replay_kernel import ReplayKernelBase
 
 
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 1920e91f18..d87f440fa7 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -9,14 +9,14 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
+import subprocess
+
+from datetime import datetime
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import skipIfMissingCommands, skipBigDataTest
 from qemu_test import exec_command_and_wait_for_pattern
-import os
-import time
-import subprocess
-from datetime import datetime
 
 # Alpine is a light weight distro that supports QEMU. These tests boot
 # that on the machine then run a QEMU guest inside it in KVM mode,
diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index d4e9dd0279..5c0ee5f927 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -11,12 +11,12 @@
 # later.  See the COPYING file in the top-level directory.
 
 import socket
-from typing import List
-from qemu.machine.machine import VMLaunchFailure
 
+from qemu.machine.machine import VMLaunchFailure
 from qemu_test import QemuSystemTest
 from qemu_test.ports import Ports
 
+
 VNC_ADDR = '127.0.0.1'
 
 def check_connect(port: int) -> bool:
diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/test_x86_64_kvm_xen.py
index 0f1f5d8f0b..424d4b2001 100755
--- a/tests/functional/test_x86_64_kvm_xen.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -11,8 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu.machine import machine
 
 from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
-- 
2.47.3


