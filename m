Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DE7C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPws-0008PS-AQ; Mon, 27 Jan 2025 09:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPwQ-0008Ki-KN; Mon, 27 Jan 2025 09:18:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPwP-0002Ki-03; Mon, 27 Jan 2025 09:18:18 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 348A6E0E2A;
 Mon, 27 Jan 2025 17:17:39 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 67AC351D69; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 06/41] pc-bios: add missing riscv64 descriptor
Date: Mon, 27 Jan 2025 17:17:20 +0300
Message-Id: <20250127141803.3514882-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Without descriptor libvirt cannot discover the EDK II binaries via
the qemu:///system connection.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 74dc38d0c6c15fd57a5dee94125d13ac5b00491d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index afb5a959cc..cdd0be01a3 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -6,7 +6,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-arm.json',
     '60-edk2-i386.json',
     '60-edk2-x86_64.json',
-    '60-edk2-loongarch64.json'
+    '60-edk2-loongarch64.json',
+    '60-edk2-riscv64.json'
   ]
     configure_file(input: files(f),
                    output: f,
-- 
2.39.5


