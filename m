Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF45CD8C89
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmi-0000Vr-1l; Sun, 07 Jun 2026 13:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1a5a9695101ddeb4a8091bf1894b5b134a077e9e@kylie.crudebyte.com>)
 id 1wWHmZ-0000OL-98; Sun, 07 Jun 2026 13:59:35 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1a5a9695101ddeb4a8091bf1894b5b134a077e9e@kylie.crudebyte.com>)
 id 1wWHmX-0004Nm-Ql; Sun, 07 Jun 2026 13:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vsAnzYnUkbJPIjTxynzHZ+ERTcjQW3lJwhEltlSR2jw=; b=CH2UU
 lTPy9vg/ahu3Nl6A0P1cJtwfxEYSMSO61gGu3acgcQrZBThFBNOEtpMaJ8jYtjR3cL3dE0GN1nZNa
 dDuX65/WQQ2YeSmMhduSc3mIZHHPFISq53TjtEwD+EtaEfJuOEzrRE/V91F+Tawd6knpbv+zMzE4/
 gUxgUc/ShbBKRNhrCWI2Ss5COii73TN5CoDu1X9ZpymwsZHbdbzs40G5kRWHYteDDlwVfsR4RaGu9
 vCmaPNuhDG6ch40hNZ14/ocLuk6VsGoIiIZvgyD/c+ZFTpxVzIY3jzj6344G61dUCEdApJB8+HEE+
 7KXW7JEOQbNigDoboLaQ2x2O9cmhYG/jBKXWjIELROJAwQj5ks/KXihPrHENpopQgoU4ybLWCVhtz
 JHGjfo9JLQ8DUsDUCAyACWLPD15Vqs3po/GXCnY+vl1DFWZ6jLDM+Qj83NNkzLjhwrqABMn/lpq30
 N/HR0zEGaPhjjvwUZAhHeinUAfQqcToBdnrqASCzsN/AxATEWf682+Efro9u0l4OG1lXHJ7VzAdj0
 +kvKw8HEWYdIG3b74wpWwsICfUs+Z83N7krvWo5/EuxXA7Ya8ZErA4Q0wqUnqT0y+RMoHC5phQLKT
 3bdgtLI/7QQzZgNR3xJZ7b9cztXzOb4GQhc2GD35ViKaEGKq+1xGubZ6oRMkUk=;
Message-ID: <1a5a9695101ddeb4a8091bf1894b5b134a077e9e.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 10/12] tests/9p: add virtio_9p_add_synth_driver_args() test
 client function
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=1a5a9695101ddeb4a8091bf1894b5b134a077e9e@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add virtio_9p_add_synth_driver_args() to allow appending custom
QEMU options for individual 9p synth tests.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 6 ++++++
 tests/qtest/libqos/virtio-9p.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 186fcc1141..823756de8c 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -228,6 +228,12 @@ static void regex_replace(GString *haystack, const char *pattern,
     g_string_assign(haystack, s);
 }
 
+void virtio_9p_add_synth_driver_args(GString *cmd_line, const char *args)
+{
+    /* append passed args to '-fsdev ...' group */
+    regex_replace(cmd_line, "(-fsdev \\w[^ ]*)", "\\1,%s", args);
+}
+
 void virtio_9p_assign_local_driver(GString *cmd_line, const char *args)
 {
     g_assert_nonnull(local_test_path);
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index 480727120e..e7efeef7a1 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -44,6 +44,12 @@ struct QVirtio9PDevice {
     QVirtio9P v9p;
 };
 
+/**
+ * Add required test specific args to the QEMU command line for the 9pfs
+ * 'synth' fs driver.
+ */
+void virtio_9p_add_synth_driver_args(GString *cmd_line, const char *args);
+
 /**
  * Creates the directory for the 9pfs 'local' filesystem driver to access.
  */
-- 
2.47.3


