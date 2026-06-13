Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91370CD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJp-00086u-Sk; Sat, 13 Jun 2026 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2dcb1243c80ea97d085af5171785850cf012be36@kylie.crudebyte.com>)
 id 1wYQJm-00086L-U4; Sat, 13 Jun 2026 11:30:44 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2dcb1243c80ea97d085af5171785850cf012be36@kylie.crudebyte.com>)
 id 1wYQJl-0005WT-FJ; Sat, 13 Jun 2026 11:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=QKz/pA4DSBTbw13vXd4yB2hXkK7fGrlgKI9R5osFqTs=; b=Ox8eL
 gdHvkm+ko3HxxbWMVEXaaje2oqc+4M9EtgWqYthwuXd0Kz+u48AJMBcl76EqHNE5C6wRLGfLn3GbU
 AFmX55SkbZhZDoFFlNUDAWHnDe38Vy9M0NN+0xqWlAjmtvRTs397R0ziJ0ngUSOBDBIDuxwdmliaz
 R4/bbc55vf+t6D0V3O4XyBx3hU4RPNC/lYNFCYTS0dogaWzF2z2ewFCEdT3Un0AxCevzHRrlsmZuS
 F9brSedC40s+IA1V4pe00HEaFBFUfMnAuKZgtW0hRAguntuf1mSVSZYmkl+38CvPby/Zuu26iSV7k
 9MpcqkKJgINTX7iKUGrs+Qo1IGemiW//NXwBqTKj1vtLkj5+XSeAIjXOa4uKtZanZHznTPJoiWf24
 kzfNU9DKwxkDKhC0LS0DK7JadeM4ekxZyB5m3SCxTiEVN2mmH+qa2rxfadIOTf7i61vuUY30l53OL
 G3OWSjibd12CzQBIskWQe/5bch79dafinVhJsvBoLRmMUrZG2iOWsomDvXzAsUFWPqkH4jYdeYB8r
 qwqfZJSwUsIcBnV8RRWgBdA/VeXfcmh+kJMtsIKpjLhGhbJmz1PYanpg4qS+EiauUtG7/1dkVdQDY
 pW1VjiZv7nJPBAPy8kRV51C7HlkrPDsCdPYWAAQK2puQoXAIFu0KO7jxRD7wVY=;
Message-ID: <2dcb1243c80ea97d085af5171785850cf012be36.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 09/12] tests/9p: increase P9_MAX_SIZE for test client
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2dcb1243c80ea97d085af5171785850cf012be36@kylie.crudebyte.com;
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

Increase the maximum 9P message size ('msize') of 9p test client from
4k to 32k to support larger messages.

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


