Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C0CC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaL-0005HG-Py; Sat, 05 Sep 2026 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaF-0005Dr-Ud; Sat, 05 Sep 2026 13:53:44 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaE-0008I6-0f; Sat, 05 Sep 2026 13:53:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 005CF44540;
 Sat,  5 Sep 2026 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A734F1F00ACF;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=iZMFXJG4YPvTIBsURsNf5N+2DcwOXXHAUugNxjcUsBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ow7QEv4LF3zgMu0XahMoKaqbZoX98jVoKQ1P3uRtTLw9EcurzYv097ac+iFsDCOSG
 krCt7zt4TKdoMAryIPjXL/x0N8mEFJZD3ouPjH8Vdm47EOtrfsoP2nqq6nD1w1Chl8
 +YIvV1NMEOqft6weoNljtKmFjioTxwYp1fKlLgPdxGq7THEENhIZhdn9vVj2kSkEbf
 M+SBZSvROysuzZFbLWD7Zy5ybYNotTmUCeYepQMid7fVbmppnFp7yZKErGilHvSYNQ
 tdQw++mXMmzoMZmrwO+/ERsQRg1TyW/Wkk9ol7Cq35G0twkD0MjgP5kWi34YyuwDhT
 guxz4WaHYEfBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bkrl-2xnb; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 2/8] tests/acpi: virt: reserve expected tables for PC GHES SCI
 support
Date: Sat,  5 Sep 2026 19:53:22 +0200
Message-ID: <bd387daaf58644a71258ebcff789d285da2ff8e7.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare to modify x86 firmware files, disabling DSDT and HEST table
check until we update it to new firmware file changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/data/acpi/x86/pc/DSDT.ras             | 0
 tests/data/acpi/x86/pc/HEST.ras             | 0
 tests/data/acpi/x86/q35/DSDT.ras            | 0
 tests/data/acpi/x86/q35/HEST.ras            | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/x86/pc/DSDT.ras
 create mode 100644 tests/data/acpi/x86/pc/HEST.ras
 create mode 100644 tests/data/acpi/x86/q35/DSDT.ras
 create mode 100644 tests/data/acpi/x86/q35/HEST.ras

diff --git a/tests/data/acpi/x86/pc/DSDT.ras b/tests/data/acpi/x86/pc/DSDT.ras
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/x86/pc/HEST.ras b/tests/data/acpi/x86/pc/HEST.ras
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/x86/q35/DSDT.ras b/tests/data/acpi/x86/q35/DSDT.ras
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/data/acpi/x86/q35/HEST.ras b/tests/data/acpi/x86/q35/HEST.ras
new file mode 100644
index 000000000000..e69de29bb2d1
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
2.55.0


