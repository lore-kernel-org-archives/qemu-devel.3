Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD096C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 18:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6vmF-0004wn-Re; Mon, 21 Apr 2025 14:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6vmA-0004vi-VM; Mon, 21 Apr 2025 14:21:52 -0400
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6vm6-0001Uw-AJ; Mon, 21 Apr 2025 14:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1745259693; bh=Tl45TIOGSxAkFysukum9w0CUvwW3KYUli2sefCaQdTw=;
 h=From:To:Cc:Subject:Date;
 b=K/n4g1OwPmpxtBkt9A4KQpHd1Nrp1jYuj5n+Vvm01zs3MN1yg+AZ+/b/mlyqKG48o
 2YoyhbUq+hQIB7CH1tQ9O/AhejqvQoIiaUkvqe8LbVV9CAek2EBdUUqpD0jYF2+Acx
 NmzjwBvDs/2KmPIr0GaxKengNtCwhklPLXiTVyxk=
Received: from 192.168.182.133 ([117.147.34.254])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 55F86E80; Tue, 22 Apr 2025 02:21:31 +0800
X-QQ-mid: xmsmtpt1745259691to5wm6on3
Message-ID: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCamuJb9f3OLCv7r90p83hxPZ+oRocdhuXid84wpUkjw8A9Kba3u
 +RpOo9m3rguUbS47RwOczr2rYY575cmYfvTUEcI66yKMR85W5eGtMueAoif3M6aGuF7xWHzEkuKk
 dGfapAy/bE12grscbE7iw5RJmATJuBLBYnUFOjzJYl0imTpC1GyZr63/xj6ikbR6LO6Ih1K4yjyt
 cITC/Yk8xRiIcpTAYo9iiNRDiind9hbL8r9p0hUixMevbtK+HCqOHfrPPFr+lDdNQiZOs5vRHs77
 KsdevjNJiaDfI4SA7926Q7VpnPKxgVY1vEDoNX/e71p55DUyYo76LaD8IHC2+u1gAOpvf5axKrTQ
 6GzGhWh23R0vY8k4vkCSzba7tDvOp8Sif2D7CiauW3Ca2yaQJK6Gq/m29vUCYS4nArs0pH/wDpGb
 qg2BtW/bbxWYOBb49/Onw+RSfosq36nMGJD8C2lHZIaCIsZhiEqZXUOeaUvZuSLAICvEMdD7nBA4
 QuGc3vbEySM5a6SAObaPXD6XPIR0qEcrWV1fDHlZag2GbJdR2nSlhFhj9v9NwQVEyMJgfHQptkGf
 X9cJrLnLTQJOBKPzzInpte8E7P4R8gntiEXVNQnQS96l+dhn8Khq8GJb/d4zXlRP3jNjTLfuOlt+
 cxMFUxomg6hmVtFt4Okn6ZrR0vwbk7j8Q79zMMJWwf3PNRKQFxbLdtmigyblT+xiSXd0eKA2aYaA
 +WMUz9w7QWisLW+tI72YNyUZMF/DJl2IAvzmHRVEEQB0V4Q2HD1kdv8W4ou2XU9Qom/16vo0FG4a
 oe2tN7D3C6sFFZRFsu6lNrlFIVW/uWgQwWtl+DthxuhKpCXkV42LT7lQqDMWKM3HHleqazanxVoi
 4uPSsZy2KC5AbpAKJR+aI9nMW7q4rH1fRC15trccof7gV8+CF9uLFwNf3iRaSnU1QlJaUEGIsMWq
 SsldYpuZzM66E9ywl2Pw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, sunnyzhyy@qq.com
Subject: [PATCH v2] block: Remove unused callback function *bdrv_aio_pdiscard
Date: Tue, 22 Apr 2025 02:21:26 +0800
X-OQ-MSGID: <20250421182126.42346-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.137; envelope-from=sunnyzhyy@qq.com;
 helo=out162-62-57-137.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The bytes type in *bdrv_aio_pdiscard should be int64_t rather than int.

There are no drivers implementing the *bdrv_aio_pdiscard() callback,
it appears to be an unused function. Therefore, we'll simply remove it
instead of fixing it.

Additionally, coroutine-based callbacks are preferred. If someone needs
to implement bdrv_aio_pdiscard, a coroutine-based version would be
straightforward to implement.

Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
---
 block/io.c                       | 22 +++-------------------
 include/block/block_int-common.h |  4 ----
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1ba8d1aeea..cfddeb4756 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3102,7 +3102,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
         return 0;
     }
 
-    if (!bs->drv->bdrv_co_pdiscard && !bs->drv->bdrv_aio_pdiscard) {
+    if (!bs->drv->bdrv_co_pdiscard) {
         return 0;
     }
 
@@ -3161,24 +3161,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
             ret = -ENOMEDIUM;
             goto out;
         }
-        if (bs->drv->bdrv_co_pdiscard) {
-            ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
-        } else {
-            BlockAIOCB *acb;
-            CoroutineIOCompletion co = {
-                .coroutine = qemu_coroutine_self(),
-            };
-
-            acb = bs->drv->bdrv_aio_pdiscard(bs, offset, num,
-                                             bdrv_co_io_em_complete, &co);
-            if (acb == NULL) {
-                ret = -EIO;
-                goto out;
-            } else {
-                qemu_coroutine_yield();
-                ret = co.ret;
-            }
-        }
+
+        ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
         if (ret && ret != -ENOTSUP) {
             goto out;
         }
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..0d8187f656 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -506,10 +506,6 @@ struct BlockDriver {
     BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_flush)(
         BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
 
-    BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
-        BlockDriverState *bs, int64_t offset, int bytes,
-        BlockCompletionFunc *cb, void *opaque);
-
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
 
-- 
2.43.0


