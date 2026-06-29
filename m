Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913DDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCE5-0007dS-BU; Mon, 29 Jun 2026 09:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <df88255543667e7f14ac34d97e0ced142af18bdf@kylie.crudebyte.com>)
 id 1weCE1-0007Ys-RF; Mon, 29 Jun 2026 09:40:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <df88255543667e7f14ac34d97e0ced142af18bdf@kylie.crudebyte.com>)
 id 1weCE0-0004tB-0p; Mon, 29 Jun 2026 09:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=t4QUJKC3tav/AW1Vk7YSwbFsYkjKNJAkyGxOrWh91zs=; b=lE0jZ
 OZWrdh3Cu6bm2zUwsQu68AAXFtzYCfI7tpx1qNQ9NmSQSj+ORfrT1u65k8n16bpGBzb1cbjNdFOd9
 TV07Oi8uXDb4E2ayoywlpiSL0i7+j/GxdEilpSBLuelpSYWo9jNRYq+0x8XDpQU+dCSBZOp+RzecH
 ISaRHECGfs5bc1y0bPVw8JfJUc/+K8Agv+Jl/KnuzunYbquarx+4qnBCCZYKuzo5Y0fwyDm6CQYQD
 ZMKv1OYz09IVAQlyFXjddbCDxGaOIR8Vf8U93HcMUusapO4kmXrCzpfoQ6NNJPk3TQZSG1YV7A5CO
 r8p3AYFvl4P7CxixF9O/uIFr7GXi4XTgaQ1fouvmJ+CLn6ZSwianEW4Kdae8gIhxEBdzmp6ebR5Pi
 Rey6rJ1DA/TZ9e9WpcSCs/HzYFIdXDmfRVE+WGHLCZNnepyALWnpIgiE+9MXWEVm4kU5ypIFHbX1m
 5/XtWLxEb8S09pG6zC6L9qhFJL/LWWq4CvUTYARyYUC5LpTbwMzzcWC8XsfTHfeVQyx0LioT66ut2
 +NWtVTeuLPGQEzzPkCVxNhEWAvMHaoNJ2Hmp9jdiNZXlAplEEM0QQdknTgvPsHySdGuVFHg/3Uiwe
 dMNyzWLE3NNcuKF0fbItfK/s7qCTHgaChvqUERn8a0nWRwOtoO8Tfv/BFDWFvs=;
Message-ID: <df88255543667e7f14ac34d97e0ced142af18bdf.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 17/23] tests/9p: increase P9_MAX_SIZE for test client
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=df88255543667e7f14ac34d97e0ced142af18bdf@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/2dcb1243c80ea97d085af5171785850cf012be36.1781361555.git.qemu_oss@crudebyte.com
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


