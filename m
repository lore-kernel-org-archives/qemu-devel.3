Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59895E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZzh-0004DI-Gy; Tue, 17 Dec 2024 11:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzb-00049f-8C
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzV-0001tR-Qp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t555vTEvyTWhoxnveFMNxWQgwKPFbd3cf+eGUqybrMo=;
 b=N3Q3vNsG6bS0zX21b70yZVXOMwP/mKs30Mu7wJHEtLq+/2Hy4VdAb8WpFs2YlpXE4md7PU
 kT7Q6B3JGXmP9s7QlMFIhxw1unEqC0gjhm8nXX229VVCL8r0iB6fTJSzL1IS2LDWcV7PUK
 HREzYMR7HAZZLFkUZN22CzToV/98dT0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-9HAYMvlJOYaB4tgcL9KiWA-1; Tue,
 17 Dec 2024 11:00:04 -0500
X-MC-Unique: 9HAYMvlJOYaB4tgcL9KiWA-1
X-Mimecast-MFC-AGG-ID: 9HAYMvlJOYaB4tgcL9KiWA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFE8E19560A2; Tue, 17 Dec 2024 16:00:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0165D300F9B5; Tue, 17 Dec 2024 16:00:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 02/32] tests/functional: remove many unused imports
Date: Tue, 17 Dec 2024 15:59:23 +0000
Message-ID: <20241217155953.3950506-3-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Identified using 'pylint --disable=all --enable=W0611'

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py              | 1 -
 tests/functional/qemu_test/tesseract.py          | 1 -
 tests/functional/qemu_test/tuxruntest.py         | 3 +--
 tests/functional/test_aarch64_aspeed.py          | 1 -
 tests/functional/test_aarch64_sbsaref_alpine.py  | 1 -
 tests/functional/test_aarch64_sbsaref_freebsd.py | 1 -
 tests/functional/test_acpi_bits.py               | 2 --
 tests/functional/test_arm_bpim2u.py              | 2 +-
 tests/functional/test_arm_collie.py              | 2 +-
 tests/functional/test_arm_cubieboard.py          | 1 -
 tests/functional/test_arm_orangepi.py            | 2 +-
 tests/functional/test_arm_smdkc210.py            | 3 +--
 tests/functional/test_arm_sx1.py                 | 2 +-
 tests/functional/test_microblaze_s3adsp1800.py   | 1 -
 tests/functional/test_ppc_amiga.py               | 2 +-
 tests/functional/test_virtio_gpu.py              | 1 -
 16 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f126cd5863..559af0351f 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -9,7 +9,6 @@
 import logging
 import os
 import stat
-import subprocess
 import sys
 import unittest
 import urllib.request
diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
index db441027b9..ef1833139d 100644
--- a/tests/functional/qemu_test/tesseract.py
+++ b/tests/functional/qemu_test/tesseract.py
@@ -5,7 +5,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import re
 import logging
 
 from . import has_cmd, run_cmd
diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index ab3b27da43..d375f2713b 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -11,10 +11,9 @@
 
 import os
 import stat
-import time
 
 from qemu_test import QemuSystemTest
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 from qemu_test import has_cmd, run_cmd, get_qemu_img
 
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index 59916efd71..e196f88537 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -6,7 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import sys
 import os
 
 from qemu_test import QemuSystemTest, Asset
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index ebc29b2fb5..6dbc90f30e 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -12,7 +12,6 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
 from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 80298dd190..77ba2ba1da 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -12,7 +12,6 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
 from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 63e2c5309d..3df9562394 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -31,14 +31,12 @@
 https://gitlab.com/qemu-project/biosbits-bits .
 """
 
-import logging
 import os
 import platform
 import re
 import shutil
 import subprocess
 import tarfile
-import tempfile
 import zipfile
 
 from pathlib import Path
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 35ea58d46c..c9cf43c147 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -9,7 +9,7 @@
 
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
-from qemu_test.utils import archive_extract, gzip_uncompress, lzma_uncompress
+from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
 from unittest import skipUnless
 
diff --git a/tests/functional/test_arm_collie.py b/tests/functional/test_arm_collie.py
index 7e144a0a8f..fe1be3d079 100755
--- a/tests/functional/test_arm_collie.py
+++ b/tests/functional/test_arm_collie.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class CollieTest(LinuxKernelTest):
 
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index 2b33a1b50b..9e42b72060 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -5,7 +5,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import shutil
 
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 6d57223a03..a872305e93 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -11,7 +11,7 @@
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test.utils import archive_extract, gzip_uncompress, lzma_uncompress
+from qemu_test.utils import gzip_uncompress, lzma_uncompress
 from qemu_test.utils import image_pow2ceil_expand
 from unittest import skipUnless
 
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/test_arm_smdkc210.py
index 967752feeb..b3b39b069d 100755
--- a/tests/functional/test_arm_smdkc210.py
+++ b/tests/functional/test_arm_smdkc210.py
@@ -5,9 +5,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import shutil
 
-from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import LinuxKernelTest, Asset
 from qemu_test.utils import gzip_uncompress
 
 class Smdkc210Machine(LinuxKernelTest):
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index 2292317946..b85bfaa178 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -14,7 +14,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from qemu_test.utils import archive_extract
+
 
 class SX1Test(LinuxKernelTest):
 
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index d2be3105a2..d452a0271c 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 from qemu_test.utils import archive_extract
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/test_ppc_amiga.py
index b793b5c432..f5faa0f0b3 100755
--- a/tests/functional/test_ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -10,7 +10,7 @@
 import subprocess
 
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern, run_cmd
+from qemu_test import wait_for_console_pattern
 from zipfile import ZipFile
 
 class AmigaOneMachine(QemuSystemTest):
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index d5027487ac..2d298b1f02 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -12,7 +12,6 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import is_readable_executable_file
 
-from qemu.utils import kvm_available
 
 import os
 import socket
-- 
2.46.0


