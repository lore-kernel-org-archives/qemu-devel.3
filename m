Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC35C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg54M-0008Rk-UN; Thu, 06 Feb 2025 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3d68de855175ae590479f15b37e8db300d43e860@kylie.crudebyte.com>)
 id 1tg53t-0008MU-Cg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:09 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3d68de855175ae590479f15b37e8db300d43e860@kylie.crudebyte.com>)
 id 1tg53r-0006F9-Vx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Ca3s76Xbf8+ekttt2UWEE6onhWTBpocpOOjWu6ipy1A=; b=VfDis
 0lb4ATJYRDgueDhE0f6CYwW2MKN+o538mpeawsV/D7Qefqt6SXs+bu3mP/l5EVAndmlRBWoWa4Ssg
 7hncKAomBh71q5vFxI9KJ/jLkK6qTqtDupnFv3EwMHtdZLzXZID2eicOlCT+3zo6izdwG7IiSSY6K
 bmCcoX/dNv7F7Dh3cZtNepJRxrtgY79kKmhFh7a0003Z9mNh2x9xr6uenTxDQix6qLsd7EVUFS5GP
 pWyVdStIpSlMRbETvFBX5uIXLEhTGc3JztTtJyX5NvDwabZNOifdiA9qF5fmXQYiePJtbZdbrAxzY
 t2uzHe0aOJ50r+3zMhNqN+L4R7wEvGeTF3+hVTH8ZyKnmA3VKL0sh1FTLSBq/44xyVQrsuMdF/2O7
 w1EaLhmHXUTVgAJtAjYvttVDXRM2+07bipvScixqzT3fIdkvjFWe3mGTL2PFWAAuXdlCikIiNB94H
 Qqk8GfIqYubwOb0PNetS3b4IKt4Fgp/UMaID8XmlEQpjx/jkCkuwfBZW5DW5J+ZzZlc96x7obEh0F
 YqXC2a/fc+pgX8MXDHEtf0/M6T3iIC/3hISsNpHy00lZY/MgRV3J03QJ0S4sEaagejKHF8ACquPx3
 fKk1AA8HaZL1ZL+LdIBn40Teo69Br4+Pa4qzE90I0eIIBRH9iFCzJjNTGp2cAE=;
Message-Id: <3d68de855175ae590479f15b37e8db300d43e860.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 4/7] tests/9p: rename test use_after_unlink ->
 use_file_after_unlink
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3d68de855175ae590479f15b37e8db300d43e860@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Message-Id: <9d2ca46a58b812ad17ca7bb8a84f12252d3e3832.1736427878.git.qemu_oss@crudebyte.com>
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
2.30.2


