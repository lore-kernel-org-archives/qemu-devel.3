Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029B0C5479F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7EL-0008Js-L7; Thu, 22 Feb 2024 06:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7EJ-0008IR-B9; Thu, 22 Feb 2024 06:27:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7EH-00052n-D3; Thu, 22 Feb 2024 06:27:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5179A4FB50;
 Thu, 22 Feb 2024 14:26:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C02D18717C;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526182 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 14/34] tests: correct typos
Date: Thu, 22 Feb 2024 14:25:41 +0300
Message-Id: <20240222112601.2526057-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/avocado/acpi-bits/bits-tests/smbios.py2 | 2 +-
 tests/avocado/mem-addr-space-check.py         | 6 +++---
 tests/avocado/reverse_debugging.py            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/acpi-bits/bits-tests/smbios.py2 b/tests/avocado/acpi-bits/bits-tests/smbios.py2
index fc623de072..5868a7137a 100644
--- a/tests/avocado/acpi-bits/bits-tests/smbios.py2
+++ b/tests/avocado/acpi-bits/bits-tests/smbios.py2
@@ -1060,7 +1060,7 @@ class EventLogDescriptor(unpack.Struct):
             0x16: 'Log Area Reset/Cleared',
             0x17: 'System boot',
             xrange(0x18, 0x7F): 'Unused, available for assignment',
-            xrange(0x80, 0xFE): 'Availalbe for system- and OEM-specific assignments',
+            xrange(0x80, 0xFE): 'Available for system- and OEM-specific assignments',
             0xFF: 'End of log'
         }
         yield 'log_type', u.unpack_one('B'), unpack.format_table("{}", _event_log_type_descriptors)
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
index 363c3f12a6..af019969c0 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/avocado/mem-addr-space-check.py
@@ -165,7 +165,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
         For q35-7.0 machines, "above 4G" memory starts are 4G.
         pci64_hole size is 32 GiB. Since TCG_PHYS_ADDR_BITS is defined to
         be 40, TCG emulated CPUs have maximum of 1 TiB (1024 GiB) of
-        directly addressible memory.
+        directly addressable memory.
         Hence, maxmem value at most can be
         1024 GiB - 4 GiB - 1 GiB per slot for alignment - 32 GiB + 0.5 GiB
         which is equal to 987.5 GiB. Setting the value to 988 GiB should
@@ -190,7 +190,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
         AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
         version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 bit
         processor address space, it has to be 1012 GiB , that is 12 GiB
-        less than the case above in order to accomodate HT hole.
+        less than the case above in order to accommodate HT hole.
         Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
         than 988 GiB).
         """
@@ -297,7 +297,7 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         :avocado: tags=arch:x86_64
 
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
-        Same as above but by setting maxram beween 976 GiB and 992 Gib,
+        Same as above but by setting maxram between 976 GiB and 992 Gib,
         QEMU should start fine.
         """
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 4cce5a5598..92855a02a5 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -191,7 +191,7 @@ def reverse_debugging(self, shift=7, args=None):
         self.check_pc(g, steps[-1])
         logger.info('successfully reached %x' % steps[-1])
 
-        logger.info('exitting gdb and qemu')
+        logger.info('exiting gdb and qemu')
         vm.shutdown()
 
 class ReverseDebugging_X86_64(ReverseDebugging):
-- 
2.39.2


