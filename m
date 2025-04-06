Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33B8C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 12:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1Pa3-0000fh-N1; Sun, 06 Apr 2025 08:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <integral@archlinuxcn.org>)
 id 1u1Lez-0007Ha-IT; Sun, 06 Apr 2025 04:47:21 -0400
Received: from wiki.archlinuxcn.org ([104.245.9.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <integral@archlinuxcn.org>)
 id 1u1Lew-0005J0-Rx; Sun, 06 Apr 2025 04:47:21 -0400
DKIM-Signature: a=rsa-sha256; bh=+TeWFmBLBkc+qOf6FxmxhHxvL5gsapneF1/gnQxpywk=; 
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1743929232; v=1; x=1744361232;
 b=jssXJnm9kKxIvw/lnX9cKZbsgC0P6ff1f60fZIK3Rz675PPiu8jeP1xI19Pl28SutrIxnEgi
 vScpZIu7KyLX65nEEwy3kx4zjk5hiSzn5xMEZjGl5a/FEHYWeZzPyYB1bVbIsD1/dmxik32VJgJ
 sc+tYtLOK3YZm2KU1ZdS9PWp4uYFaaRtJVybjzpCeFAZJ3GIHq82G6b3E75Qdv3nl7vbo3LxbIw
 dNX1PM/eZ2J9KMXJgR+9+s/tNdKMniH8ltgKYtvbGRLvt5YRBV83bBob+w47x9S/PavR9ns575d
 5km4U5dSu10yDfNymeJzD/+cJyCdS2m579ruV3TuaQ7Og==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 43effe2c; Sun, 06 Apr 2025
 16:47:12 +0800
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Integral <integral@archlinuxcn.org>
Subject: [PATCH] docs: replace `-hda` with `-drive` & update `root=` kernel
 parameter
Date: Sun,  6 Apr 2025 16:45:18 +0800
Message-ID: <20250406084515.95461-4-integral@archlinuxcn.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.245.9.4;
 envelope-from=integral@archlinuxcn.org; helo=wiki.archlinuxcn.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 06 Apr 2025 08:58:28 -0400
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
Reply-to:  Integral <integral@archlinuxcn.org>
From:  Integral via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to QEMU manual:

Older options like `-hda` are essentially macros which expand into
`-drive` options for various drive interfaces. The original forms
bake in a lot of assumptions from the days when QEMU was emulating a
legacy PC, they are not recommended for modern configurations.

Signed-off-by: Integral <integral@archlinuxcn.org>
---
 docs/system/gdb.rst         | 2 +-
 docs/system/linuxboot.rst   | 6 +++---
 docs/system/target-mips.rst | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 4228cb56bb..d50470b135 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -20,7 +20,7 @@ connection, use the ``-gdb dev`` option instead of ``-s``. See
 
 .. parsed-literal::
 
-   |qemu_system| -s -S -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+   |qemu_system| -s -S -kernel bzImage -drive file=rootdisk.img,format=raw -append "root=/dev/sda"
 
 QEMU will launch but will silently wait for gdb to connect.
 
diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
index 5db2e560dc..2328b4a73d 100644
--- a/docs/system/linuxboot.rst
+++ b/docs/system/linuxboot.rst
@@ -11,7 +11,7 @@ The syntax is:
 
 .. parsed-literal::
 
-   |qemu_system| -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+   |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw -append "root=/dev/sda"
 
 Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
 give the kernel command line arguments. The ``-initrd`` option can be
@@ -23,8 +23,8 @@ virtual serial port and the QEMU monitor to the console with the
 
 .. parsed-literal::
 
-   |qemu_system| -kernel bzImage -hda rootdisk.img \
-                    -append "root=/dev/hda console=ttyS0" -nographic
+   |qemu_system| -kernel bzImage -drive file=rootdisk.img,format=raw \
+                    -append "root=/dev/sda console=ttyS0" -nographic
 
 Use Ctrl-a c to switch between the serial console and the monitor (see
 :ref:`GUI_keys`).
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 83239fb9df..9028c3b304 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -112,5 +112,5 @@ https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b
 Start system emulation of Malta board with nanoMIPS I7200 CPU::
 
    qemu-system-mipsel -cpu I7200 -kernel <kernel_image_file> \
-       -M malta -serial stdio -m <memory_size> -hda <disk_image_file> \
+       -M malta -serial stdio -m <memory_size> -drive file=<disk_image_file>,format=raw \
        -append "mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
-- 
2.49.0


