Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE4CD8C92
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmB-0000JN-TR; Sun, 07 Jun 2026 13:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eb2d66400d7763e0f4c92e03c527009d5093f5ac@kylie.crudebyte.com>)
 id 1wWHmA-0000IK-Vh; Sun, 07 Jun 2026 13:59:10 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eb2d66400d7763e0f4c92e03c527009d5093f5ac@kylie.crudebyte.com>)
 id 1wWHm9-0004Jm-J7; Sun, 07 Jun 2026 13:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Nvijw5zxNpcwR19Sl1opG3FKxsazjdsC775GYkiqEho=; b=JcaXY
 FVuaGREgC2mgI+cIxiZTua8/3GtwwQkzBLWbCmifsJMbShi3kioiv56hk/pYCXGJemD1s7egn9Jx3
 pHbf3ce0ReGvW8roqXloOEJoypFveCfXbGk2ANJgecFDdyLNLn91RPE4ZWBQ9edqbfvIiatDC79/v
 OclSj80f9Tshb6e4lcPVcH4g+l7eySl+WRk5Q4/HHx8BuhqR0eEZ4g/WhO4YXVcbfRamc/ZAUYDQH
 UIC4JAnRNAnXnernRU4+Flx5AVXd+mSvbAZXAPlytDv61UaAS/yDPgBxgzC8V8NLC92GOsuFsDJ8M
 hac7SV96IXDcjgScXrOwmZiohenZCGOkKAfVgSVZYLwQEj7umND50umNUYPvXU8LUTlEPgAeqQNJ6
 b4mIhZz3YoNVS/0POxrWHCAfHRu3ZdWzbARsUwP+1wSZVpMBc+PKLq51l7pGHZArpEfJFo4smfoac
 xLUg3jhPHtlvHXMcU6nGexzkq8CPaallE0vF7GfOI84yrJQahmc6cPtHQxAZvXzRbQE64u2GvZzX1
 jDdJIDjoJO+C6l4+gKrwSpzWnEa1S/C8toBXDvHpy2o8Ec3tqevcddYPzfExnbR9N2Z+2Qpr03x4H
 f6bMcWvBtXlSbJQSKfaG1tiGGnWnWnzPRJz8d9vcwycwkfIlFoa2CNZqta1AWU=;
Message-ID: <eb2d66400d7763e0f4c92e03c527009d5093f5ac.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 09/12] tests/9p: increase P9_MAX_SIZE for test client
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=eb2d66400d7763e0f4c92e03c527009d5093f5ac@kylie.crudebyte.com;
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

Increase the maximum 9P message size from 4k to 32k to support larger
messages.

This is needed for the xattr tests being added with the subsequent
patches which are going to transmit xattrs of size 8k. It would have
also been possible to send them in multiple chunks, however let's not
overcomplicate things.

This new msize is still reasonable small compared to common msize
values on production systems.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index c432b0daee..4b04324503 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -21,7 +21,8 @@
 #include "qgraph.h"
 #include "tests/qtest/libqtest-single.h"
 
-#define P9_MAX_SIZE 4096 /* Max size of a T-message or R-message */
+/* Max size of a T-message or R-message */
+#define P9_MAX_SIZE (32 * 1024)
 
 typedef struct {
     QTestState *qts;
-- 
2.47.3


