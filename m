Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B29109B485
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7adX-0003G5-Rd; Tue, 31 Mar 2026 11:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adV-0003Bm-8A
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adT-0002Xu-EL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldb3K5ZW5hyzrTLNC7CI3aGq8mv6oYQ1ZbFmzuc+hVw=;
 b=SUzFldRPERhH7jqe0Nwfc72AvvDwmyLaXucw2jFNRyvbFV2l9nsdxA2kr+Qb+76Z8UkXh8
 vs9mSm41W2YTj7QPa2sSYAfgm5Prx4E7MVCwWM8MdGSadS5GVgKbnRPxigBXMyrS/SA7sP
 vYqH+2NzqLexx+ydVRuZHyT3rTCtEcw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-n_e5bf6qOjiwdpsl_v4sPA-1; Tue,
 31 Mar 2026 11:04:04 -0400
X-MC-Unique: n_e5bf6qOjiwdpsl_v4sPA-1
X-Mimecast-MFC-AGG-ID: n_e5bf6qOjiwdpsl_v4sPA_1774969443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CC1D19560B6; Tue, 31 Mar 2026 15:04:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1399C1954102; Tue, 31 Mar 2026 15:04:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 3/6] block: Fix references in bdrv_bsc_*() function comments
Date: Tue, 31 Mar 2026 17:03:49 +0200
Message-ID: <20260331150352.256332-4-kwolf@redhat.com>
In-Reply-To: <20260331150352.256332-1-kwolf@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some functions are defined in block_int-io.h, so the correct
annotation is block_int-io.h rather than block_int.h

Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>
Message-ID: <20260325094204300GFCZYBzAE00cSWaldbDcT@zte.com.cn>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 48a17f393c5..f0a6042e616 100644
--- a/block.c
+++ b/block.c
@@ -8477,7 +8477,7 @@ static bool bdrv_bsc_range_overlaps_locked(BlockDriverState *bs,
 }
 
 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 bool bdrv_bsc_is_data(BlockDriverState *bs, int64_t offset, int64_t *pnum)
 {
@@ -8487,7 +8487,7 @@ bool bdrv_bsc_is_data(BlockDriverState *bs, int64_t offset, int64_t *pnum)
 }
 
 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 void bdrv_bsc_invalidate_range(BlockDriverState *bs,
                                int64_t offset, int64_t bytes)
@@ -8501,7 +8501,7 @@ void bdrv_bsc_invalidate_range(BlockDriverState *bs,
 }
 
 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-- 
2.53.0


