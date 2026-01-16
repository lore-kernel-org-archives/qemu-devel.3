Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A08D4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggZG-0000hG-RM; Fri, 16 Jan 2026 04:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vggZD-0000fs-Jp
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vggZB-00016x-BD
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768557388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u4ykMC/1FLpZxu7vo/GAthdvo+eg7hPfTZi1Np4TRPU=;
 b=KXkIiyyCLalxuGjXKlqZD+6drWIpBHdjHjCHpqvehjfovaQF+Vn/omJASqFhaD83XfbUCi
 EW0FY2GPT0a3i422yZoN+XZ/nAHlB2rrTiSEN5ZzWlUP2BGlZSfx1yO1VLAtwpixQuXxCg
 ZY3EqMlWG/OtrQYkUyLO952ss7a8vCM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-CuqIuYVKO3-8B5pej6yvTw-1; Fri,
 16 Jan 2026 04:56:22 -0500
X-MC-Unique: CuqIuYVKO3-8B5pej6yvTw-1
X-Mimecast-MFC-AGG-ID: CuqIuYVKO3-8B5pej6yvTw_1768557381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAD781800372; Fri, 16 Jan 2026 09:56:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.79])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD26F18007D2; Fri, 16 Jan 2026 09:56:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH] tests/functional/riscv64: Silence warnings from Pylint in the
 boston test
Date: Fri, 16 Jan 2026 10:56:15 +0100
Message-ID: <20260116095615.269199-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Pylint complains:

 tests/functional/riscv64/test_boston.py:1:0: C0114:
  Missing module docstring (missing-module-docstring)
 tests/functional/riscv64/test_boston.py:95:8: C0415:
  Import outside toplevel (subprocess.run, subprocess.PIPE) (import-outside-toplevel)
 tests/functional/riscv64/test_boston.py:112:17: W1510:
  'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
 tests/functional/riscv64/test_boston.py:95:8: W0611:
  Unused PIPE imported from subprocess (unused-import)

Rework the code a little bit to make the linter happy.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/test_boston.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
index 385de6a61df..2582df96f21 100755
--- a/tests/functional/riscv64/test_boston.py
+++ b/tests/functional/riscv64/test_boston.py
@@ -1,11 +1,14 @@
 #!/usr/bin/env python3
 #
-# Boston board test for RISC-V P8700 processor by MIPS
-#
 # Copyright (c) 2025 MIPS
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
+"""
+Boston board test for RISC-V P8700 processor by MIPS
+"""
+
+from subprocess import run
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
@@ -92,7 +95,6 @@ def test_boston_invalid_cpu_count(self):
         """
         Test that 65 CPUs is rejected as invalid (negative test case)
         """
-        from subprocess import run, PIPE
 
         fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
         rootfs_path = self.ASSET_ROOTFS.fetch()
@@ -109,7 +111,8 @@ def test_boston_invalid_cpu_count(self):
         ]
 
         # Run QEMU and expect it to fail immediately.
-        result = run(cmd, capture_output=True, text=True, timeout=5)
+        result = run(cmd, capture_output=True, text=True, timeout=5,
+                     check=False)
 
         # Check that QEMU exited with error code 1
         self.assertEqual(result.returncode, 1,
-- 
2.52.0


