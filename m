Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D14C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNa-0006b8-Br; Mon, 10 Feb 2025 11:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNL-0006Tb-AY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNE-0000yF-W5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBfOH5imhATpuMEU8VBlckuqMBnW0M1uEnt8wFgy4II=;
 b=iys+HbmpZqETxIccwheYT+YoKHkfBUaY0C4Vlt7oWbBCvas0KDihAhrrAUs3L2OVDU2DHS
 9vyT5FyCMhuvLBVj4PpWogAjtZPQIvYtNtnMVq0nwJBIErudoRx1AsnFGMPYjdvSxgl+i6
 lJzw9TOMwVG2Kyw2swfqtPSTK9tpXXM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-DT9ToAiSPOyc4D-evMX9Hw-1; Mon,
 10 Feb 2025 11:10:58 -0500
X-MC-Unique: DT9ToAiSPOyc4D-evMX9Hw-1
X-Mimecast-MFC-AGG-ID: DT9ToAiSPOyc4D-evMX9Hw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462BA180087B; Mon, 10 Feb 2025 16:10:57 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00EEC195608D; Mon, 10 Feb 2025 16:10:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/25] block: Improve blk_get_attached_dev_id() docstring
Date: Mon, 10 Feb 2025 17:10:12 +0100
Message-ID: <20250210161034.76494-4-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Expose the method docstring in the header, and mention
returned value must be free'd by caller.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111170333.43833-2-philmd@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/block-backend-io.h |  7 +++++++
 block/block-backend.c             | 12 ++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index d174275a5c..ba8dfcc7d0 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -32,6 +32,13 @@ void blk_set_allow_aio_context_change(BlockBackend *blk, bool allow);
 void blk_set_disable_request_queuing(BlockBackend *blk, bool disable);
 bool blk_iostatus_is_enabled(const BlockBackend *blk);
 
+/*
+ * Return the qdev ID, or if no ID is assigned the QOM path,
+ * of the block device attached to the BlockBackend.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 char *blk_get_attached_dev_id(BlockBackend *blk);
 
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
diff --git a/block/block-backend.c b/block/block-backend.c
index c93a7525ad..789fc6d4ea 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1019,6 +1019,10 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk)
     return blk->dev;
 }
 
+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
 {
     DeviceState *dev = blk->dev;
@@ -1033,15 +1037,15 @@ static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
     return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
 }
 
-/*
- * Return the qdev ID, or if no ID is assigned the QOM path, of the block
- * device attached to the BlockBackend.
- */
 char *blk_get_attached_dev_id(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, true);
 }
 
+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
 static char *blk_get_attached_dev_path(BlockBackend *blk)
 {
     return blk_get_attached_dev_id_or_path(blk, false);
-- 
2.48.1


