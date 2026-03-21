Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6148108B8FF
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 04:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3nZT-0006hs-Dr; Sat, 21 Mar 2026 00:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w3nZI-0006dL-Nd; Sat, 21 Mar 2026 00:04:09 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w3nZE-0006sf-JW; Sat, 21 Mar 2026 00:04:06 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4fd5QZ3YgQz4xPSQ;
 Sat, 21 Mar 2026 12:03:50 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
 by mse-fl1.zte.com.cn with SMTP id 62L43mHU064294;
 Sat, 21 Mar 2026 12:03:48 +0800 (+08)
 (envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njy2app01[null]) by mapi (Zmail) with MAPI id mid201;
 Sat, 21 Mar 2026 12:03:49 +0800 (CST)
X-Zmail-TransId: 2af969be18a5f84-ed3c0
X-Mailer: Zmail v1.0
Message-ID: <20260321120349693fnwhekaw-qAQrFgoQPU4g@zte.com.cn>
Date: Sat, 21 Mar 2026 12:03:49 +0800 (CST)
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <jsnow@redhat.com>, <vsementsov@yandex-team.ru>, <kwolf@redhat.com>,
 <hreitz@redhat.com>
Cc: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <mou.yi@zte.com.cn>,
 <liang.xianlong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBtaXJyb3I6IEFkZCBzcGFyc2UgY29weSBzdXBwb3J0IGZvciByYXcgYmxvY2sgZGV2aWNlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 62L43mHU064294
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: long.yunjian@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 21 Mar 2026 12:03:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69BE18A6.000/4fd5QZ3YgQz4xPSQ
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=long.yunjian@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Yunjian Long <long.yunjian@zte.com.cn>

In the raw block devices scenario, when the guest OS writes only
a small amount of valid data, the current mirroring mechanism writes
all the data to the destination. However, when the target device has
already been zeroed, it is actually possible to skip writing zero data,
which is very useful for performance improvement.

Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>
---
 block/mirror.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2fcded9e93..939a97f1ba 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -199,6 +199,22 @@ static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
     }
 }

+static bool check_iov_is_zero(struct iovec *iov, int niov)
+{
+    int i = 0;
+
+    if (niov <= 0) {
+        return false;
+    }
+
+    for (i = 0; i < niov; i++) {
+        if (!buffer_is_zero(iov->iov_base, iov->iov_len)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
@@ -270,6 +286,12 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
         return;
     }

+    if (s->target_is_zero && op->qiov.size > 0 &&
+           check_iov_is_zero(op->qiov.iov, op->qiov.niov)) {
+        mirror_iteration_done(op, ret);
+        return;
+    }
+
     ret = blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qiov, 0);
     mirror_write_complete(op, ret);
 }
@@ -1656,8 +1678,14 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
     MirrorOp *op = NULL;
     MirrorBDSOpaque *s = bs->opaque;
     int ret = 0;
+    bool target_force_write = false;

-    if (copy_to_target) {
+    if (s->job && s->job->target_is_zero && qiov->size > 0 &&
+           check_iov_is_zero(qiov->iov, qiov->niov)) {
+        target_force_write = true;
+    }
+
+    if (copy_to_target || target_force_write) {
         op = active_write_prepare(s->job, offset, bytes);
     }

@@ -1689,12 +1717,12 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
         goto out;
     }

-    if (copy_to_target) {
+    if (copy_to_target || target_force_write) {
         do_sync_target_write(s->job, method, offset, bytes, qiov, flags);
     }

 out:
-    if (copy_to_target) {
+    if (copy_to_target || target_force_write) {
         active_write_settle(op);
     }
     return ret;
-- 
2.27.0

