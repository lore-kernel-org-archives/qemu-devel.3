Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1A9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRwt-0006Xp-7F; Wed, 10 Jul 2024 03:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sRRwn-0006X3-Et
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:41:06 -0400
Received: from va-2-34.ptr.blmpb.com ([209.127.231.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sRRwi-0005Um-E6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1720597247;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gGM++8hg5AQEDA3Q0TpWg63YW7XObKV9eaj3BOdRmRQ=;
 b=a+DMSB0iGIj5pTrtsb8TSPcaYxryhBTzYWWWSr452aXl0Awxfrp8ZbIi2BxZCVINZI4rhq
 zFglTQsHXP3c43V02Ui0L1nl/TgSyhA50AJsJx7TW+0v4/8zHgC1FkNlTojXP9lUOz2RaF
 duoU5eUHLISkxaCb39QbprAp+hUlVGe3ScTfgRhaUOX2rWd20cCqzJWYljLFn8Hu8+/mk+
 f6jXNgObhAKqNEjbEhg2x4zIuzL63Y8fkGrPOS+z8PXhRYMJEaNE8/Jj79VXRCzBb5NanL
 DEezIyHntSaoHbcdTyVxyOSJGLR4uN/4p8dIBelXWbP4VtuLo0eIBVMBDmVUlA==
X-Original-From: xiangwencheng@dayudpu.com
To: <qemu-devel@nongnu.org>
Mime-Version: 1.0
Received: from localhost.localdomain ([124.64.23.34]) by smtp.feishu.cn with
 ESMTPS; Wed, 10 Jul 2024 15:40:46 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.30.0
X-Lms-Return-Path: <lba+2668e3afe+c96281+nongnu.org+xiangwencheng@dayudpu.com>
Content-Type: text/plain; charset=UTF-8
Cc: <mst@redhat.com>, <alex.bennee@linaro.org>, 
 "BillXiang" <xiangwencheng@dayudpu.com>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Subject: [PATCH] vhsot-user: Remove redundant judgment
Date: Wed, 10 Jul 2024 15:40:41 +0800
Message-Id: <20240710074041.85984-1-xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=209.127.231.34;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-34.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BillXiang <xiangwencheng@dayudpu.com>

Send only once has been supported in vhost_user_write by vhost_user_per_device_request

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
---
 hw/virtio/vhost-user.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..04e3568b7e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -446,11 +446,6 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
         .hdr.size = sizeof(msg.payload.log),
     };
 
-    /* Send only once with first queue pair */
-    if (dev->vq_index != 0) {
-        return 0;
-    }
-
     if (shmfd && log->fd != -1) {
         fds[fd_num++] = log->fd;
     }
-- 
2.30.0

