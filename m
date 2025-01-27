Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ECAC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgZt-0000Gt-JC; Tue, 28 Jan 2025 03:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZY-0007b0-2O; Tue, 28 Jan 2025 03:03:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZU-0002O2-Jj; Tue, 28 Jan 2025 03:03:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0008EE1B65;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6FBC71A6318;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1A997520C1; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [Stable-9.1.3 30/58] pc-bios: add missing riscv64 descriptor
Date: Mon, 27 Jan 2025 23:25:16 +0300
Message-Id: <20250127202547.3723716-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Without descriptor libvirt cannot discover the EDK II binaries via
the qemu:///system connection.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 74dc38d0c6c15fd57a5dee94125d13ac5b00491d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in pc-bios/descriptors/meson.build due to missing
 v9.1.0-337-gb883fb93db "roms: Support compile the efi bios for loongarch")

diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descriptors/60-edk2-riscv64.json
new file mode 100644
index 0000000000..14811ca307
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-riscv64.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for riscv64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-riscv-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-riscv-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "riscv64",
+            "machines": [
+                "virt*"
+            ]
+        }
+    ],
+    "features": [
+
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index 66f85d01c4..18a584e5e3 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -5,7 +5,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-aarch64.json',
     '60-edk2-arm.json',
     '60-edk2-i386.json',
-    '60-edk2-x86_64.json'
+    '60-edk2-x86_64.json',
+    '60-edk2-riscv64.json'
   ]
     configure_file(input: files(f),
                    output: f,
-- 
2.39.5


