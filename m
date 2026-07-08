Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D50C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbaw-0001Fk-HH; Wed, 08 Jul 2026 19:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1whbau-0001Ax-W6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:22:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1whbas-0004fD-N3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:22:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc97653887so14165895ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783552937; x=1784157737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L9zYR5KSqHz25KI/p65hWP2kAAkZ1GWxhngihdh1MGw=;
 b=CigMVCuWP7MXXWgfaLxaxlDFwBFyacSrt/yl7cnYou94sLkf/oI30/OIpaDxiF7S0a
 0dUe6wswLBxPWNsjTXwhS1CVIUAJykrdT6F+ssPt9MDGFhsZ6GUmMqKI0wGk9a66c5zy
 k3+97o3Q0TyYrvTfrPgrgMKS4dTv912zRa5EmuR1hWQW3Uq4dfrfdHwe0fsbuZt7iLFT
 YVWy/mVNBdcvNP7/T6kR2krOzqA0k2KlxIsZ6SEYRzsBAEQMh/jKs1VZLR8B3LbiosgQ
 qS8L9xPHGogF424uMJ+lVk9wobpwMjtwHQQLUCAqMurF5fISkuiDGByYJ0uFIh6oUWj3
 T9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552937; x=1784157737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L9zYR5KSqHz25KI/p65hWP2kAAkZ1GWxhngihdh1MGw=;
 b=B9+z+6/Z5Rch/t6x8+VXGXiKkDryLhcPhUj+GcFQokiK+oFicj2W0DZy7I2CrS5d59
 UdLd6DI1+N50ac1TKrk8kMDyE1u2DcsOuGmJpvII969THK4rfG9FsvOHDhlqagJLylMn
 czvw+1fcRovOG+WZfVxThixH49Lz1kJTDbDnXGQg/R82aJXWR0jWG46AwwoNG2PTpLlx
 RQXuDG7LNQaKdcrGnc04ZROf4bzoWIBDhcKCBmubQ2ukgPPRtSKdlOud3H/YNV48c+/p
 1NO5TrvdmHWPoeb8uzs6hece4ymmED2PPGAebxBPi7uj5DA+5FOlY59O0uB67eCviCct
 WInA==
X-Gm-Message-State: AOJu0YzClLmoR0KdEh5axVZYzhFbftuiktZTPk9l1Cp7V6WC+FT4/FL1
 JBniHBBw/Ac1Ptqmt+qaxhOWK2xkzmj4FM+YHGoFReI47eXmZcWBy0gSEJcjDA==
X-Gm-Gg: AfdE7cmMOgs0DPyU8UWu0XWejFxm8XNHO4bVRdwOp7sGLlu6yOZl8nGjJp8YpSdMpE3
 h2sNPnW5EWuD+qWaXJeuiQcQ6k8DGiBJRPpsaEpFd4eS9NexlyR66O+hgs46tDow+eljB4RN67V
 GMwhqtVRqH6+8dlaGNRknuSid/PS1sVg/Qu464eMC+SbUOMkEXYD+GnKxkpXAnYx5CRBG4AcUUx
 SKYXtDUUkhiLwKGNLapDBPW0kMLZI81u4FVTlI5BLzMoqGau2+GvuLiJBL06He0+fKxgKmAvarc
 v7Sg4X5W4MFhhhdIu8jaPGBDQazLWU+WI9BZS/T/76X4vn40tc/ZuDphxn1cl5OfE8Sg+1hp3CL
 892ukiao83RzGQuqA48PLUhtwvG3ETycODjEzUB+3BqoniiDdJABc0M5r5PEJMgNZQ/1EECbdlG
 UgdQ3ypX6OrkKI4zZ6EQ==
X-Received: by 2002:a17:902:fc84:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2ccea2d7691mr53267425ad.4.1783552937224; 
 Wed, 08 Jul 2026 16:22:17 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf74cbsm33961225ad.18.2026.07.08.16.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 16:22:16 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 Jia Jia <physicalmtea@gmail.com>
Subject: [PULL 1/1] hw/ufs: avoid double unref of wrapped scsi-hd
Date: Thu,  9 Jul 2026 08:22:03 +0900
Message-ID: <90aacd5bc405cb71f77472616093f9e5ad9afd2b.1783552661.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783552661.git.jeuk20.kim@samsung.com>
References: <cover.1783552661.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jia Jia <physicalmtea@gmail.com>

ufs_init_scsi_device() creates an internal scsi-hd and adds it as a
child of lu->bus. qdev_realize_and_unref() then drops the construction
reference, leaving the bus child ownership to tear it down.

ufs_lu_unrealize() still unrefs lu->scsi_dev directly. If the UFS
controller is ejected through ACPI PCI hotplug, the scsi-hd object can be
finalized there and then the bus child removal RCU callback later unrefs
the same object again.

Keep lu->scsi_dev as a borrowed pointer and clear it during unrealize
without unreffing it.

Add a qtest that ejects the UFS controller through the x86 ACPI PCI
hotplug eject register. On an ASAN build, the test reproduces the UAF
before the fix.

Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c            |  5 +----
 tests/qtest/ufs-test.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1e75b1eb4d..13f4a90145 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -530,10 +530,7 @@ static void ufs_lu_unrealize(DeviceState *dev)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
 
-    if (lu->scsi_dev) {
-        object_unref(OBJECT(lu->scsi_dev));
-        lu->scsi_dev = NULL;
-    }
+    lu->scsi_dev = NULL;
 }
 
 static void ufs_lu_class_init(ObjectClass *oc, const void *data)
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 3b85296a72..9a9c5ca834 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -34,6 +34,8 @@
 #define TEST_QID 0
 #define QUEUE_SIZE 32
 #define UFS_MCQ_MAX_QNUM 32
+#define ACPI_PCIHP_ADDR 0xae00
+#define PCI_EJ_BASE 0x0008
 
 typedef struct QUfs QUfs;
 
@@ -635,6 +637,17 @@ static void ufstest_reg_read(void *obj, void *data, QGuestAllocator *alloc)
     qpci_iounmap(&ufs->dev, ufs->bar);
 }
 
+static void ufstest_acpi_eject(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    QTestState *qts = ufs->dev.bus->qts;
+
+    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << 4);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'query-status' }");
+    g_usleep(3 * G_USEC_PER_SEC);
+    qtest_qmp_assert_success(qts, "{ 'execute': 'query-status' }");
+}
+
 static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
 {
     QUfs *ufs = obj;
@@ -1682,6 +1695,7 @@ static void ufs_register_nodes(void)
                                              "mcq=false,nutrs=32,nutmrs=8,"
                                              "wb-max-size=1024,"
                                              "wb-min-size=256" };
+    QOSGraphTestOptions acpi_eject_test_opts = { .subprocess = true };
 
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
 
@@ -1700,6 +1714,10 @@ static void ufs_register_nodes(void)
         g_test_message("Skipping ufs io tests for ppc64");
         return;
     }
+    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+        qos_add_test("acpi-eject", "ufs", ufstest_acpi_eject,
+                     &acpi_eject_test_opts);
+    }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
-- 
2.43.0


