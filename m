Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A4BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCEP-0007ph-Q4; Mon, 29 Jun 2026 09:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <84525ece6817f4e9760a1d484cab01123a546e92@kylie.crudebyte.com>)
 id 1weCEB-0007ky-NB; Mon, 29 Jun 2026 09:40:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <84525ece6817f4e9760a1d484cab01123a546e92@kylie.crudebyte.com>)
 id 1weCE7-0004xU-K4; Mon, 29 Jun 2026 09:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=FJnTo+tWawD92WQKJyoQXjepZzMT1atyWHiIsi0MPy4=; b=goBk8
 xFMImZWfvmPRqzHwKLvWAswcQtKDlzGqYwVRKb99YXwjv0nx8BXhMuaa2sWJkJcf79LCxfr+zZLDn
 ba8Kl2MciQ6Ddyu8x2N8YEH1FBU3PgsrP7jcNZTY1fcF9vW8emKmhVZ+eunV3esXGpfWkPgY1/09l
 nGXbqOvj3Ws7OEMW6HzzcsE99p3gGM+5UxtVjiel+g8vnUKpI2cttJ0b1gMtrmi9kYNKZX5pTEc0x
 dEg0BAjZE8DP1yQxZ6PV6ZN+d6t8GlMQhnW5mLQ7RHP03OeRS9QKI/K2eN+VYFe6qgjVaL/iFth9K
 LkkQ+tOFmlnI1saFnW9NLYv3C547ls7xJe1ZBQwZjEKytzqju0RHd4IetF2W7qpZ6oaftkszztiD1
 T3tKF+8fFHFgWv2FnTEe8/Sc5/eu1eWhqaIET77JXuL0e7h/0xJprc464CbGhyWwXo4jRkwp4MROd
 T+dd5/FD6AV95HGibMKRGxVkxluX0rHdmIT5n9BUe57N2L4XY7TikXvtTfUhCgLcAxso/6LE1P4In
 pxDsNjksutWo4awkxf4Ye2q1SnOo/Wdj3/+54x/JdIwT8jMkEzGmr+tmHR3OPh1M7eCsach0xDuc7
 jtvUjQGPoNGO/ldXkaDoaCv3UrZI43zv53ofPgwcV6khk6IXXkAUMhXhY+D3L0=;
Message-ID: <84525ece6817f4e9760a1d484cab01123a546e92.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 18/23] tests/9p: add virtio_9p_add_synth_driver_args() test
 client function
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=84525ece6817f4e9760a1d484cab01123a546e92@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/7fe3eca5d17292464676b68d0513052564cd432a.1781361555.git.qemu_oss@crudebyte.com
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


