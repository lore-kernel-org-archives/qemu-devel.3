Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD19C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO5-0006oO-MI; Mon, 10 Feb 2025 11:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNs-0006gq-Dd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNq-00018J-Aq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vH17dfNtoF7dp+qqcESuD3DiukoWCJ2/xxWOV2bzx6s=;
 b=CRydHXJcbNDCbDhdTt3kvwGIYitgmaXXifFzOkkx91ecgnHZV9V4Pt8InunRdUN3XdjbAH
 bvRjM+InKg+/yOCV4mGlpRysuP4T+4mixBfJ/E5enJph8bNPwtqbxuzWqr7iq/WmJVgVpb
 ihFszNFGipe16o4SEMq5cHgz/2exLqQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-pCbp_q5fPHu6jTTDj28Edw-1; Mon,
 10 Feb 2025 11:11:39 -0500
X-MC-Unique: pCbp_q5fPHu6jTTDj28Edw-1
X-Mimecast-MFC-AGG-ID: pCbp_q5fPHu6jTTDj28Edw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A417180087F; Mon, 10 Feb 2025 16:11:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB66A195608D; Mon, 10 Feb 2025 16:11:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/25] block: remove unused BLOCK_OP_TYPE_DATAPLANE
Date: Mon, 10 Feb 2025 17:10:34 +0100
Message-ID: <20250210161034.76494-26-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

BLOCK_OP_TYPE_DATAPLANE prevents BlockDriverState from being used by
virtio-blk/virtio-scsi with IOThread. Commit b112a65c52aa ("block:
declare blockjobs and dataplane friends!") eliminated the main reason
for this blocker in 2014.

Nowadays the block layer supports I/O from multiple AioContexts, so
there is even less reason to block IOThread users. Any legitimate
reasons related to interference would probably also apply to
non-IOThread users.

The only remaining users are bdrv_op_unblock(BLOCK_OP_TYPE_DATAPLANE)
calls after bdrv_op_block_all(). If we remove BLOCK_OP_TYPE_DATAPLANE
their behavior doesn't change.

Existing bdrv_op_block_all() callers that don't explicitly unblock
BLOCK_OP_TYPE_DATAPLANE seem to do so simply because no one bothered to
rather than because it is necessary to keep BLOCK_OP_TYPE_DATAPLANE
blocked.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250203182529.269066-1-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h | 1 -
 block/replication.c          | 1 -
 blockjob.c                   | 2 --
 hw/block/virtio-blk.c        | 9 ---------
 hw/scsi/virtio-scsi.c        | 3 ---
 5 files changed, 16 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 7030669f04..0b831ef87b 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -356,7 +356,6 @@ typedef enum BlockOpType {
     BLOCK_OP_TYPE_CHANGE,
     BLOCK_OP_TYPE_COMMIT_SOURCE,
     BLOCK_OP_TYPE_COMMIT_TARGET,
-    BLOCK_OP_TYPE_DATAPLANE,
     BLOCK_OP_TYPE_DRIVE_DEL,
     BLOCK_OP_TYPE_EJECT,
     BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT,
diff --git a/block/replication.c b/block/replication.c
index 2ce16f0589..d4d677a902 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -576,7 +576,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
-        bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
         bdrv_graph_wrunlock();
 
diff --git a/blockjob.c b/blockjob.c
index e94a840d7f..32007f31a9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -539,8 +539,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         goto fail;
     }
 
-    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
-
     if (!block_job_set_speed(job, speed, errp)) {
         goto fail;
     }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index e0acce89e1..a1829e3abd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1562,15 +1562,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             error_setg(errp, "ioeventfd is required for iothread");
             return false;
         }
-
-        /*
-         * If ioeventfd is (re-)enabled while the guest is running there could
-         * be block jobs that can conflict.
-         */
-        if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
-            error_prepend(errp, "cannot start virtio-blk ioeventfd: ");
-            return false;
-        }
     }
 
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 23516995dc..7d094e1881 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1065,9 +1065,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     int ret;
 
     if (s->ctx && !s->dataplane_fenced) {
-        if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
-            return;
-        }
         ret = blk_set_aio_context(sd->conf.blk, s->ctx, errp);
         if (ret < 0) {
             return;
-- 
2.48.1


