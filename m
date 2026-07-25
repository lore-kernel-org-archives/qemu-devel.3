Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6E5C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnaMM-0007Xh-Tw; Sat, 25 Jul 2026 07:16:02 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d55b1234739c64fc6b7e0634613faf141bf91731@kylie.crudebyte.com>)
 id 1wnaM1-0007Uf-G4; Sat, 25 Jul 2026 07:15:53 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d55b1234739c64fc6b7e0634613faf141bf91731@kylie.crudebyte.com>)
 id 1wnaLz-0006Qx-Sn; Sat, 25 Jul 2026 07:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=UToPKQRq6EN0Bf8WFcKtA/hRT+IM7pe5itYKNLtP+24=; b=rglbq
 yD9BzNBy0zLIwMtFUJppYJRCSaelcFQsZ1s1Jr9++SDCWOIo+orw552tIHdhcfhQ93gttDV/MLzb0
 WCmTmVI3IQ+/bP3A41lqFzNRMIiSGIMsU0ntkNX9gXOGpAXhvmD4103ITZtZ2GBcWmuYypW2OHRgP
 ayOq18f3eIrT1v1OYIaHKNA9qdGyfYGKuLVSV3ZsV9MLTz8CqTLLi+NxQY/AGZcNiir+e4aCN8Uoo
 5Ixzyx2BPO8xzGRU0LPIK2A448XNsMnpeJJMUNDcLTkiOAy36YH9fzTRXOz44MkX5TvUAJ/eu4Yol
 VfAGNVPRfxWv235y7ri7rCHXbll+AlKXnRC4emkLLzd6IyBidsLUOkwFfo8057Oz1BM4sFCB/SIS2
 t7FsPBOUQ7TOkQMu3KQEimjrUEnpm4dZKtJd3HNgBplmGEZLnyjks3g5/xTvEPOx/lo2egWIho9q2
 Zw4K3pISM303NHh7+Z/ibvl8RxyF5lz7Sdb67JSJQfrRspccyTfrvzOv2XYfI6XFGaINkhhrZ5VJM
 KzAQgrGHV7howN69EA8nqN7vPyOq4pxYRPnD9sgi++W9zWj0xobzbO1Grv0TNVlzy8l35d3jXnilD
 fXQnAPFpzIgZZfgx69tm1kVwQOZXHbWbiZyvSHoFBOaLtO/aO8RehJw9BHULxM=;
Message-ID: <d55b1234739c64fc6b7e0634613faf141bf91731.1784977523.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784977523.git.qemu_oss@crudebyte.com>
References: <cover.1784977523.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 25 Jul 2026 13:05:24 +0200
Subject: [PULL 2/5] tests/9p: reduce xattr size to 1k
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d55b1234739c64fc6b7e0634613faf141bf91731@kylie.crudebyte.com;
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

On host systems with ext4 and ea_inode capability not enabled, the max. size
for xattr values is slightly below 4k, which caused the new xattr tests to
fail on such host systems.

Reduce the xattr size for our tests to 1k to prevent them to fail on such
host systems.

Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Fixes: 04a62cdfe8 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/E1wffqw-001Sc8-I9@kylie.crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 692a0e8e3f..22302bd2f8 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -38,11 +38,17 @@
 /*
  * xattr size to be used for xattr tests
  *
- * 64k is the max. xattr size supported by the Linux kernel, However btrfs
- * for instance supports only 16219 bytes. So let's be conservative and
- * just use 8k for the xattr tests.
+ * 64k is the max. xattr size supported by the Linux kernel on high-level VFS
+ * layer. However filesystems impose their own limits:
+ *
+ * - btrfs: 16219 bytes
+ *
+ * - ext4: blocksize - 56 bytes (~4KB) if no ea_inode capability enabled,
+ *         64k if ea_inode enabled
+ *
+ * So let's be conservative and just use 1k for the xattr tests.
  */
-#define TEST_XATTR_SIZE (8 * 1024)
+#define TEST_XATTR_SIZE (1 * 1024)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


