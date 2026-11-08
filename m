Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81E606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/Sre320
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyWr-0007bs-3x; Sun, 08 Nov 2026 03:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWm-0007YT-De; Sun, 08 Nov 2026 03:45:28 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWj-0000HX-Dv; Sun, 08 Nov 2026 03:45:28 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F99343335;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816AB1F008A2;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794127516;
 bh=/CSl8lAcUCmig49S7F/exLJyC2folrj9gXTelPXpoAg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E/Sre320ala3SG+5ghsxVgo07C0h4hsouEMMu5Pgc/8f8oZtwAdhexNNAyA5DMvss
 Nfr+KuhOPpl69p7lshjmwbWJMF48WMUj3e1pksl4xkZFp/uDYUg4lzD8bopJDHy0pB
 2zzKpdXPYAC3dllPw/xsx8taXag2Ua08BKv9h8jAp1jwHzg9ORqHiGsZZi4cqa1Hzm
 7GaNA42ng0F3IE125dsBA8dVDItRdrJ7ZPWG8Q0Al4aC6ucWvh91rvaQpZCOXXFL03
 bGL5dLZNXQIkw87fz2E4QPtft/qeY8oo6mgDUz1lSK+5r05v2yNK9q21IQ+Ku04Ye6
 FkjiSra4Zbh8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWY-00000005TMP-2OCc; Sun, 08 Nov 2026 09:45:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 2/8] tests/acpi: virt: reserve expected tables for PC GHES
 SCI support
Date: Sun,  8 Nov 2026 09:45:03 +0100
Message-ID: <ecf4f7a15c96d4cecc51e4bbd88d71a9af4f3619.1794124132.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794124132.git.mchehab+huawei@kernel.org>
References: <cover.1794124132.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare to modify x86 firmware files, disabling DSDT and HEST table
check until we update it to new firmware file changes.

Notice that we're adding a SPDX header at the new files just to
shut up checkpatch. This will be dropped when we add the BIOS
binaries there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/data/acpi/x86/pc/DSDT.ras             | 1 +
 tests/data/acpi/x86/pc/HEST.ras             | 1 +
 tests/data/acpi/x86/q35/DSDT.ras            | 1 +
 tests/data/acpi/x86/q35/HEST.ras            | 1 +
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 5 files changed, 8 insertions(+)
 create mode 100644 tests/data/acpi/x86/pc/DSDT.ras
 create mode 100644 tests/data/acpi/x86/pc/HEST.ras
 create mode 100644 tests/data/acpi/x86/q35/DSDT.ras
 create mode 100644 tests/data/acpi/x86/q35/HEST.ras

diff --git a/tests/data/acpi/x86/pc/DSDT.ras b/tests/data/acpi/x86/pc/DSDT.ras
new file mode 100644
index 000000000000..73fa78ef14ea
--- /dev/null
+++ b/tests/data/acpi/x86/pc/DSDT.ras
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/tests/data/acpi/x86/pc/HEST.ras b/tests/data/acpi/x86/pc/HEST.ras
new file mode 100644
index 000000000000..73fa78ef14ea
--- /dev/null
+++ b/tests/data/acpi/x86/pc/HEST.ras
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/tests/data/acpi/x86/q35/DSDT.ras b/tests/data/acpi/x86/q35/DSDT.ras
new file mode 100644
index 000000000000..73fa78ef14ea
--- /dev/null
+++ b/tests/data/acpi/x86/q35/DSDT.ras
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/tests/data/acpi/x86/q35/HEST.ras b/tests/data/acpi/x86/q35/HEST.ras
new file mode 100644
index 000000000000..73fa78ef14ea
--- /dev/null
+++ b/tests/data/acpi/x86/q35/HEST.ras
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..b3761468accc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT.ras",
+"tests/data/acpi/x86/pc/HEST.ras",
+"tests/data/acpi/x86/q35/DSDT.ras",
+"tests/data/acpi/x86/q35/HEST.ras",
-- 
2.56.0


