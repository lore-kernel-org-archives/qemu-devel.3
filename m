Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE36D729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qC-0003Vn-D2; Fri, 29 Nov 2024 12:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q9-0003V9-67
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q6-0000nc-SA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifXmOmdjbWBTIvEozeD9D+7JRzpwmcM0ewP4FejXQMM=;
 b=XGriXgQn26bVBOPSGOmw+k6MUK+14ueoGqopuYCCSE2BmGUtFkOi6eCgUyQoANM61oI+ci
 tRm5Dejt75g7XxbIwCuFekqEBwUx3yEVn8cY7+KNMTvuM2DNFZRPIkqU3Wa3AKJcSdq/Y6
 Ts13qHR0ToXPC99zXrF/OHH9Nz5s3VI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-uU4rNS1AP1Kf_ZYIWxiDhA-1; Fri,
 29 Nov 2024 12:31:29 -0500
X-MC-Unique: uU4rNS1AP1Kf_ZYIWxiDhA-1
X-Mimecast-MFC-AGG-ID: uU4rNS1AP1Kf_ZYIWxiDhA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE724195419B; Fri, 29 Nov 2024 17:31:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A79A1955F41; Fri, 29 Nov 2024 17:31:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/22] tests/functional: remove unused system imports
Date: Fri, 29 Nov 2024 17:31:00 +0000
Message-ID: <20241129173120.761728-3-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
index 3498b96787..6fc49a30bc 100755
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
index eb23060564..501e0e5397 100755
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
2.46.0


