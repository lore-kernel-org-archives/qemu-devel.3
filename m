Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF30E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIc0-000081-MT; Wed, 11 Dec 2024 04:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbT-0006fU-C2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIbN-0007wL-Tj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx840y/hPWPCVh0FOKpLgSCPsgN3Sje2tMkJuLULex8=;
 b=UMBv878gxkeNsTBVHPyH15HmfUn6kUZzukGTtMHuoXUgGVczwM/eA1zulA/to78vt5vDn7
 nt0QDsKoMudodZ3ezLSLpkWIBQGlTSq5EXuWsDngYlaOINmI0pcwumCRR8hTfHbM+lacEc
 Oj4xgfVmzUi9dSwbJnOf9Y3P7reNSYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-ItQq30FvOuSwMC_caVHEQw-1; Wed,
 11 Dec 2024 04:01:44 -0500
X-MC-Unique: ItQq30FvOuSwMC_caVHEQw-1
X-Mimecast-MFC-AGG-ID: ItQq30FvOuSwMC_caVHEQw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1097C1955F3F; Wed, 11 Dec 2024 09:01:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B234B1956089; Wed, 11 Dec 2024 09:01:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 25/26] tests/functional: remove unused system imports
Date: Wed, 11 Dec 2024 10:00:09 +0100
Message-ID: <20241211090014.619351-26-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241129173120.761728-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_sbsaref.py       | 1 -
 tests/functional/test_acpi_bits.py             | 1 -
 tests/functional/test_m68k_mcf5208evb.py       | 2 --
 tests/functional/test_microblaze_s3adsp1800.py | 1 -
 tests/functional/test_mips64el_loongson3v.py   | 1 -
 tests/functional/test_or1k_sim.py              | 2 --
 tests/functional/test_s390x_topology.py        | 1 -
 tests/functional/test_sh4_tuxrun.py            | 4 ----
 tests/functional/test_sh4eb_r2d.py             | 1 -
 tests/functional/test_virtio_version.py        | 2 --
 10 files changed, 16 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 9fda396b3a..6db08da522 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -14,7 +14,6 @@
 from qemu_test import wait_for_console_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test.utils import lzma_uncompress
-from unittest import skipUnless
 
 def fetch_firmware(test):
     """
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index e2f84414d7..63e2c5309d 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -39,7 +39,6 @@
 import subprocess
 import tarfile
 import tempfile
-import time
 import zipfile
 
 from pathlib import Path
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
index 00c59590c3..fb178fde1c 100755
--- a/tests/functional/test_m68k_mcf5208evb.py
+++ b/tests/functional/test_m68k_mcf5208evb.py
@@ -5,8 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test.utils import archive_extract
 
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 4f692ffdb1..d2be3105a2 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,7 +7,6 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import time
 from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/test_mips64el_loongson3v.py
index 55d62928c7..e57ec5499e 100755
--- a/tests/functional/test_mips64el_loongson3v.py
+++ b/tests/functional/test_mips64el_loongson3v.py
@@ -10,7 +10,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import time
 
 from unittest import skipUnless
 from qemu_test import QemuSystemTest, Asset
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
index 10e0437c50..5b68b6b628 100755
--- a/tests/functional/test_or1k_sim.py
+++ b/tests/functional/test_or1k_sim.py
@@ -5,8 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test.utils import archive_extract
 
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
index 20727f6bdf..c54c7a8177 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -11,7 +11,6 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
-import time
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import exec_command
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
index b33533fc7e..1748f8c7ef 100755
--- a/tests/functional/test_sh4_tuxrun.py
+++ b/tests/functional/test_sh4_tuxrun.py
@@ -11,10 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-import time
-
-from unittest import skipUnless
 from qemu_test import Asset, exec_command_and_wait_for_pattern
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
index d9c022c8b8..cd46007942 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -10,7 +10,6 @@
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.utils import archive_extract
-from unittest import skipUnless
 
 class R2dEBTest(LinuxKernelTest):
 
diff --git a/tests/functional/test_virtio_version.py b/tests/functional/test_virtio_version.py
index 92e3f5caf0..a5ea73237f 100755
--- a/tests/functional/test_virtio_version.py
+++ b/tests/functional/test_virtio_version.py
@@ -9,8 +9,6 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-import sys
-import os
 
 from qemu.machine import QEMUMachine
 from qemu_test import QemuSystemTest
-- 
2.47.1


