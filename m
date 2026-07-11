Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D5EC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifrF-0000Ym-Kt; Sat, 11 Jul 2026 18:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifrE-0000LF-1b; Sat, 11 Jul 2026 18:07:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifrC-00013M-18; Sat, 11 Jul 2026 18:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807182; bh=tP/CrzL07NHSuDze/u6Nu7yKAkynHCESZWIV2L/jryM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LFLdjyxWXXnbHjagdGqz0JuhoLssgN8CaSDaSFCsib0Jenmd2O/KEfAXJU/A0Jxp9
 GnBg6phPYqz+SZw4tFN+ZLSqhk8sZdvOUYd+RbvxgP7oTatqCjH0msRg2dRYPAQnIB
 xZkAj02aUaMOi5T9VuA73vZhKsWeAtJA4JFeVQnJ6rKN9tuqI1uFHuSv6YI35tNF5m
 Obp/okPs5MiD5nMwntklAf8RyxV5Wn7OsIMyccGPsw+evRslPHdfCfEIKX79GtfmQ4
 Llz8SdGQD7PsqWKrj/2fje4so2DXB1WwXlk8RlGup+eoaP+3iTXYxrmaUId180EP24
 ewmWAvtbQRl+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 039951C0ADC;
 Sun, 12 Jul 2026 00:59:42 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF0CF3EAF67;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 07F3713385; Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 81/81] tests: update SPCR loongarch64 and riscv64 test
 data
Date: Sun, 12 Jul 2026 00:58:59 +0300
Message-ID: <20260711215904.3757-81-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

On LoongArch and RISC-V the SPCR test data contained:

    Terminal Type : 00
    Language : 03

The corrected values are:

    Terminal Type : 03
    Language : 00

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

The ACPI table data was rebuilt with
tests/data/acpi/rebuild-expected-aml.sh.

Remove SPCR expections from tests/qtest/bios-tables-test-allowed-diff.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705063147.199732-4-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ec7d32428757d5813935cbe099449f6201980d80)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb80..7bb819cd0d2 100644
Binary files a/tests/data/acpi/loongarch64/virt/SPCR and b/tests/data/acpi/loongarch64/virt/SPCR differ
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a..59d2c8f7f21 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2c7086d9de1..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/SPCR",
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.47.3


