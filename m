Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180B3CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxPR-0002rA-S2; Tue, 09 Jun 2026 10:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <df93ef4700c808af4c120ea0e636b28539fe4598@kylie.crudebyte.com>)
 id 1wWxPQ-0002pI-GN; Tue, 09 Jun 2026 10:26:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <df93ef4700c808af4c120ea0e636b28539fe4598@kylie.crudebyte.com>)
 id 1wWxPN-0001Qs-Lc; Tue, 09 Jun 2026 10:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vsAnzYnUkbJPIjTxynzHZ+ERTcjQW3lJwhEltlSR2jw=; b=LC8sH
 ETMRpplF02XWG2v7SUVSENN1lCjyBx5xOxnHVMA7TFsSVv9X5GHAeKDobqk9D+7jthKFLAGSfOYgH
 FOQs1SFge5uDKzBGJ6v+LWOpVfCL/ZMdVhp++xhJNsgNUc0ND/QuJSTpeswndxl6jFOzv3cOc4IM6
 iqCwoyIvIFRjQ3PfvThTodF3GgccmpJJWo78+SvyUlptZm2/fBvXoCbubd8u49V37P4WKkNFzsc6a
 hJgRk/J43ymTnzh+rj7KvhZzUxWGiCle0hCt3iMS2A8RRuZTammQCMHP+3Xosx+1aUbMULz9/VqXA
 uj/voKZJirN+zOhFUmKjO4nfscYuyrcuy5ElsfyV3bgzPNRxuvYGI5Yzo9rGErCPar9hJ/15F4jaE
 uHLAfDlFo2Pe7mMi4etJ0bUyKxue6jYnNrwuCj9gNqi9P8Smce9qMFqhZzC40+6dg+uknExnooBUj
 6bDYFLvaeEXvCw7DkkrdewiAVIb8JPhsDJ8ABAgJRou/yBBfsPSqalkaMf5xqsrpea4lK0swohRUY
 hzinZpuCnLdMaVoFTy+ymD3hbM6ti7ZXdXA7qNShP7UvSwdbHuIKA2o2BwC3BL7zz00BLvsn7GQ/Q
 Lf7Cd0Ok3np/6S8lMdnbAYjNDfeHba3P8vHed1hbKA3ExJJzW68HtvUEvf7qrA=;
Message-ID: <df93ef4700c808af4c120ea0e636b28539fe4598.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 10/12] tests/9p: add virtio_9p_add_synth_driver_args() test
 client function
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=df93ef4700c808af4c120ea0e636b28539fe4598@kylie.crudebyte.com;
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


