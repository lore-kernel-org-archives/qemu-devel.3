Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA171C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uff-0003rv-AY; Wed, 23 Apr 2025 03:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Ufc-0003j3-Qa
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfZ-0003LK-Cg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzKlpAvIYSjO88pMS10A+zh2U5QacjQjItAfwpjsTYY=;
 b=VhwZGYQMwDQDVlkJtkRlWMb+CqaIi2PqVFE25DsQ5lyDyWKOM963CpnSYVSmfwdpqmo+7+
 ZeuJ6oNb5u+tiOz4aBHA6jCmRl2pxrQNqU5FRhdFZBetw9js2K9zQlQcxSVILDeD6WnKVZ
 iofR6gdLSd/NuPrr54ZWi+8zkoQphrA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-A8qpsKX0MHmqsrMonNnsUA-1; Wed,
 23 Apr 2025 03:37:18 -0400
X-MC-Unique: A8qpsKX0MHmqsrMonNnsUA-1
X-Mimecast-MFC-AGG-ID: A8qpsKX0MHmqsrMonNnsUA_1745393837
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D92619560AA; Wed, 23 Apr 2025 07:37:17 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A838019560A3; Wed, 23 Apr 2025 07:37:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] tests/functional: Remove unnecessary import statements
Date: Wed, 23 Apr 2025 09:36:08 +0200
Message-ID: <20250423073610.271585-29-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 tests/functional/qemu_test/ports.py              | 3 +--
 tests/functional/qemu_test/tuxruntest.py         | 2 --
 tests/functional/qemu_test/uncompress.py         | 2 +-
 tests/functional/test_aarch64_rme_sbsaref.py     | 6 ++----
 tests/functional/test_aarch64_rme_virt.py        | 2 --
 tests/functional/test_aarch64_sbsaref_alpine.py  | 3 ---
 tests/functional/test_aarch64_sbsaref_freebsd.py | 2 --
 tests/functional/test_aarch64_tcg_plugins.py     | 1 -
 tests/functional/test_aarch64_virt.py            | 8 ++------
 tests/functional/test_arm_aspeed_ast2500.py      | 3 +--
 tests/functional/test_arm_cubieboard.py          | 2 --
 tests/functional/test_arm_quanta_gsj.py          | 2 --
 tests/functional/test_arm_smdkc210.py            | 2 --
 tests/functional/test_migration.py               | 3 +--
 tests/functional/test_mips64el_replay.py         | 6 +-----
 tests/functional/test_mips_replay.py             | 2 +-
 tests/functional/test_mipsel_replay.py           | 2 +-
 tests/functional/test_ppc64_hv.py                | 8 ++++----
 tests/functional/test_vnc.py                     | 4 ++--
 tests/functional/test_x86_64_kvm_xen.py          | 2 --
 20 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
index cc39939d481..631b77abf6b 100644
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
index c2bd5baaae9..6c442ff0dc4 100644
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
index ce79da1b686..b7ef8f759b7 100644
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
index 0f4f6103a1e..746770e776d 100755
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
index a1abf584f0e..8452d27928f 100755
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
index c660cc7a406..6108ec65a54 100755
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
index bd6728dc705..26dfc5878bb 100755
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
index 4ea71f5f882..cb7e9298fb8 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -13,7 +13,6 @@
 
 import tempfile
 import mmap
-import os
 import re
 
 from qemu.machine.machine import VMLaunchFailure
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 884aad7af61..4d0ad90ff89 100755
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
index ddc6459f710..a3b44572fcf 100755
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
index 1eaca0272bb..b536c2f77a0 100755
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
index da60aeb6595..cb0545f7bfa 100755
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
index 0fda45c63a8..3154e7f7322 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -4,8 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 
 
diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
index 181223a69e3..c4393c35434 100755
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
index 4f63d7fb340..26a6ccff3f7 100755
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
index eda031ccadd..4327481e35b 100755
--- a/tests/functional/test_mips_replay.py
+++ b/tests/functional/test_mips_replay.py
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, skipSlowTest, exec_command_and_wait_for_pattern
+from qemu_test import Asset, skipSlowTest
 from replay_kernel import ReplayKernelBase
 
 
diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/test_mipsel_replay.py
index 0a330de43f8..5f4796cf899 100644
--- a/tests/functional/test_mipsel_replay.py
+++ b/tests/functional/test_mipsel_replay.py
@@ -4,7 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset, wait_for_console_pattern, skipSlowTest
+from qemu_test import Asset, skipSlowTest
 from replay_kernel import ReplayKernelBase
 
 
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 1920e91f18b..d87f440fa79 100755
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
index d4e9dd0279e..5c0ee5f9272 100755
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
index c6abf6bba3b..a5d445023c9 100755
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
2.49.0


