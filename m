Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85DBC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 16:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz5O-0007RT-R8; Sat, 09 Mar 2024 10:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5J-0007PX-CF; Sat, 09 Mar 2024 10:58:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz5H-0004Jt-3O; Sat, 09 Mar 2024 10:58:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2C4A654533;
 Sat,  9 Mar 2024 18:58:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AFE37944C5;
 Sat,  9 Mar 2024 18:57:43 +0300 (MSK)
Received: (nullmailer pid 1694677 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 11/11] docs/acpi/bits: add some clarity and details while also
 improving formating
Date: Sat,  9 Mar 2024 18:57:29 +0300
Message-Id: <20240309155729.1694607-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
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

From: Ani Sinha <anisinha@redhat.com>

Update bios-bits docs to add more details on why a pre-OS environment for
testing bioses is useful. Add author's FOSDEM talk link. Also improve the
formating of the document while at it.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/acpi-bits.rst | 55 ++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
index 9677b0098f..1ec394f5fb 100644
--- a/docs/devel/acpi-bits.rst
+++ b/docs/devel/acpi-bits.rst
@@ -1,26 +1,48 @@
 =============================================================================
 ACPI/SMBIOS avocado tests using biosbits
 =============================================================================
-
+************
+Introduction
+************
 Biosbits is a software written by Josh Triplett that can be downloaded
 from https://biosbits.org/. The github codebase can be found
-`here <https://github.com/biosbits/bits/tree/master>`__. It is a software that executes
-the bios components such as acpi and smbios tables directly through acpica
-bios interpreter (a freely available C based library written by Intel,
+`here <https://github.com/biosbits/bits/tree/master>`__. It is a software that
+executes the bios components such as acpi and smbios tables directly through
+acpica bios interpreter (a freely available C based library written by Intel,
 downloadable from https://acpica.org/ and is included with biosbits) without an
-operating system getting involved in between.
+operating system getting involved in between. Bios-bits has python integration
+with grub so actual routines that executes bios components can be written in
+python instead of bash-ish (grub's native scripting language).
 There are several advantages to directly testing the bios in a real physical
-machine or VM as opposed to indirectly discovering bios issues through the
-operating system. For one thing, the OSes tend to hide bios problems from the
-end user. The other is that we have more control of what we wanted to test
-and how by directly using acpica interpreter on top of the bios on a running
-system. More details on the inspiration for developing biosbits and its real
-life uses can be found in [#a]_ and [#b]_.
+machine or in a VM as opposed to indirectly discovering bios issues through the
+operating system (the OS). Operating systems tend to bypass bios problems and
+hide them from the end user. We have more control of what we wanted to test and
+how by being as close to the bios on a running system as possible without a
+complicated software component such as an operating system coming in between.
+Another issue is that we cannot exercise bios components such as ACPI and
+SMBIOS without being in the highest hardware privilege level, ring 0 for
+example in case of x86. Since the OS executes from ring 0 whereas normal user
+land software resides in unprivileged ring 3, operating system must be modified
+in order to write our test routines that exercise and test the bios. This is
+not possible in all cases. Lastly, test frameworks and routines are preferably
+written using a high level scripting language such as python. OSes and
+OS modules are generally written using low level languages such as C and
+low level assembly machine language. Writing test routines in a low level
+language makes things more cumbersome. These and other reasons makes using
+bios-bits very attractive for testing bioses. More details on the inspiration
+for developing biosbits and its real life uses can be found in [#a]_ and [#b]_.
+
 For QEMU, we maintain a fork of bios bits in gitlab along with all the
-dependent submodules here: https://gitlab.com/qemu-project/biosbits-bits
+dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
 This fork contains numerous fixes, a newer acpica and changes specific to
 running this avocado QEMU tests using bits. The author of this document
-is the sole maintainer of the QEMU fork of bios bits repo.
+is the sole maintainer of the QEMU fork of bios bits repository. For more
+information, please see author's `FOSDEM talk on this bios-bits based test
+framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
+
+*********************************
+Description of the test framework
+*********************************
 
 Under the directory ``tests/avocado/``, ``acpi-bits.py`` is a QEMU avocado
 test that drives all this.
@@ -120,8 +142,9 @@ Under ``tests/avocado/`` as the root we have:
        (b) Add a SPDX license header.
        (c) Perform modifications to the test.
 
-   Commits (a), (b) and (c) should go under separate commits so that the original
-   test script and the changes we have made are separated and clear.
+   Commits (a), (b) and (c) preferably should go under separate commits so that
+   the original test script and the changes we have made are separated and
+   clear. (a) and (b) can sometimes be combined into a single step.
 
    The test framework will then use your modified test script to run the test.
    No further changes would be needed. Please check the logs to make sure that
@@ -141,4 +164,4 @@ References:
 -----------
 .. [#a] https://blog.linuxplumbersconf.org/2011/ocw/system/presentations/867/original/bits.pdf
 .. [#b] https://www.youtube.com/watch?v=36QIepyUuhg
-
+.. [#c] https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/
-- 
2.39.2


