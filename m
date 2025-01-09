Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2013E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsM8-00014s-Vo; Thu, 09 Jan 2025 08:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9d2ca46a58b812ad17ca7bb8a84f12252d3e3832@kylie.crudebyte.com>)
 id 1tVsM6-00014M-Uh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:47 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9d2ca46a58b812ad17ca7bb8a84f12252d3e3832@kylie.crudebyte.com>)
 id 1tVsM5-0004kT-IM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=sffUx/yz/eiA09znaGr37CjqVvJFQSFMedIWdcuc7UA=; b=VpEaO
 aUN27FPZ+H4r/WWhD6/QI3TDRI92xwFRkY0XmxXIuoimQP64dC2myAlWrfw9Zcu45qPO3H0o4hR2S
 pakAvmanrEKbBEouYRlE3e4G9staVH1OyuaqA9gmC8zPOCDd3FAjVJSS655OMXGS+SAEQ2UdGSkKW
 mk4u7r/pzW2KmyLxCJSqOXn0Vppa1VnPScSK+mL6JjJyrE+xtvIP7+Rs0OIXZa9Cj9o4Lru8qDSoa
 9LOALfbY+9PTSYAsL0umHxJ+Op2tYcsP4gjg6PHA8Dw9UbqByTM63Xw2M2eVUq1YiQUNschmg4zd/
 oy2SmU4b9WpXBfaSyNKxCUYmCoN3k3/H4u2rEbVBp93f0VOpjG/71Ch+Q9n5ed3bJ1HO/gOihpZ0S
 Xyw9lBWEvknIG8JZhcsNrmauCzewMSOFWiTsalHrzfdHLzSyQJ/5xYpZZBWGYy5ZlfmDDdAvUKqW4
 q6E0DHbL2Js85fYeadNGqL8431H+5tOkEl1ZYYtN2Dm0HU3EpQBLuKZYdFYkdjNiwY5wTAZrPwDJ6
 sZO6p5rwrl8xKnPCszzYNAW7WKjJ9gdzUFXBd1cvNT+9CVwFj2J/IXpchC8gJtQGsm4oO6x8SjibI
 tPKUwbAVpsHdknKgeTJd6HGeEcMKH7/epyea9VWQm2+zKeYDPPGTqURdJu8DWE=;
Message-Id: <9d2ca46a58b812ad17ca7bb8a84f12252d3e3832.1736427878.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1736427878.git.qemu_oss@crudebyte.com>
References: <cover.1736427878.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jan 2025 13:59:46 +0100
Subject: [PATCH 1/3] tests/9p: rename test use_after_unlink ->
 use_file_after_unlink
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=9d2ca46a58b812ad17ca7bb8a84f12252d3e3832@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To pave the way for adding new test use_dir_after_unlink with subsequent
patch, i.e. making it clear that the existing test is just about unlinked
files, not unlinked directories.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index ab3a12c816..07459c5289 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -693,8 +693,8 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     g_assert(stat(real_file, &st_real) == 0);
 }
 
-static void fs_use_after_unlink(void *obj, void *data,
-                                QGuestAllocator *t_alloc)
+static void fs_use_file_after_unlink(void *obj, void *data,
+                                     QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
@@ -802,8 +802,8 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
     qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
                  &opts);
-    qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
-                 &opts);
+    qos_add_test("local/use_file_after_unlink", "virtio-9p",
+                 fs_use_file_after_unlink, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.39.5


