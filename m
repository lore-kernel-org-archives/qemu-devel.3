Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C01CD98DA
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJr-00087e-8O; Sat, 13 Jun 2026 11:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7fe3eca5d17292464676b68d0513052564cd432a@kylie.crudebyte.com>)
 id 1wYQJp-00086x-UU; Sat, 13 Jun 2026 11:30:46 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7fe3eca5d17292464676b68d0513052564cd432a@kylie.crudebyte.com>)
 id 1wYQJo-0005Ww-G9; Sat, 13 Jun 2026 11:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vsAnzYnUkbJPIjTxynzHZ+ERTcjQW3lJwhEltlSR2jw=; b=VbSXe
 N0kZU3S+kNe68g53rExsqh0v4rHo6CfMXFPv74vTLfIq2jh27/dWJCnPCCnH75StMvDU/l8WCwrMM
 pI1eWVeNtJ2QCvJPiJo0j0F/ToU07ED+VJ1qLjlzwHY0dfdF/0NhsOW6tbawKS1cJymzlqlIeoW29
 LFxXYp3bK9iNfHhMVA0g/NUi0RE8u4C2bTJvK89olJre+Efi6bJ1o34lfhDQl4o50aqQXoSJ8d59e
 oELTa3HvQnJ9mJcby/nNCOWzEMSZLMm1XX5u8LU6SEPi+DNhNvlXnx9D3nW/sc7qUkzwGm4O3jF2G
 kHGcnepnBGoPjZFIySLSxeW6nnXKDbN2bV6dJ6msqrVrBVv36yOB/7ydyKUfsIPSUgGowNtSwia8P
 Ib12NLi27ACW/pe1rXDCN4akGsKxP6v+gIpCTNf3CFGA9tJQB/KYLhSSbt5stBaVJXbbdlfm/HZjM
 retDU87i7bJNbxRJaH2nlu7Qi3i/pJmOHcK/rP2OE/+0+nxva9AjZglz4SFJCjTOnqVAjQh616b92
 CiewWCabYRcpi2asGF4grA4x47W9o74NCs4ysE5rcsi0+93trTDYd7AShE2kMyB5v/0XOD16KOfBq
 I/Gr3PcpoX8eNpTQ41FEIpXvcehcOwqodj9VoI7ZXREALhAQ2+Itj6lfOA/7gM=;
Message-ID: <7fe3eca5d17292464676b68d0513052564cd432a.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 10/12] tests/9p: add virtio_9p_add_synth_driver_args() test
 client function
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7fe3eca5d17292464676b68d0513052564cd432a@kylie.crudebyte.com;
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


