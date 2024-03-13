Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEu-0003w2-7Y; Wed, 13 Mar 2024 11:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEf-0003cd-8y; Wed, 13 Mar 2024 11:09:42 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEd-0005ve-7t; Wed, 13 Mar 2024 11:09:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 8939760D9B;
 Wed, 13 Mar 2024 18:09:37 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-rhXfypM7; Wed, 13 Mar 2024 18:09:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342576;
 bh=8U0ZcAt8pJ1rlaY1RKjn1zGvGLkE3X5Uz+owbI77koc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZBn07nNvNf4fdBbINEObe8lNQ8XKOoaSQz1MYcDAyzBXqC5YIl4humF54MyGB37kJ
 nw3oXFu1GcvTZNA95epFrcwSqiygkxFWYD2Me3234OdyiHOrQ5KdfBpz0vYEvpABHF
 Q4pTk/S1/E1GbyOegNYilMkQdNQ6a+aOBCBjRLnw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 12/15] qapi: rename BlockDeviceIoStatus to IoStatus
Date: Wed, 13 Mar 2024 18:09:04 +0300
Message-Id: <20240313150907.623462-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This status is already shared between block-jobs and block-devices, so
structure name is misleading a bit. We also will need to use the
structure both in block-core.json and job.json. So give it more generic
name first.

The commit is made by commands:

    git grep -l BlockDeviceIoStatus | \
        xargs sed -i 's/BlockDeviceIoStatus/IoStatus/g'

    git grep -l BLOCK_DEVICE_IO_STATUS | \
        xargs sed -i 's/BLOCK_DEVICE_IO_STATUS/IO_STATUS/g'

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/block-backend.c                       | 14 +++++++-------
 block/mirror.c                              |  4 ++--
 block/monitor/block-hmp-cmds.c              |  4 ++--
 blockjob.c                                  | 10 +++++-----
 include/block/blockjob.h                    |  2 +-
 include/sysemu/block-backend-global-state.h |  2 +-
 qapi/block-core.json                        | 10 +++++-----
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9c4de79e6b..ec19c50e96 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -65,7 +65,7 @@ struct BlockBackend {
 
     BlockdevOnError on_read_error, on_write_error;
     bool iostatus_enabled;
-    BlockDeviceIoStatus iostatus;
+    IoStatus iostatus;
 
     uint64_t perm;
     uint64_t shared_perm;
@@ -1198,7 +1198,7 @@ void blk_iostatus_enable(BlockBackend *blk)
 {
     GLOBAL_STATE_CODE();
     blk->iostatus_enabled = true;
-    blk->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
+    blk->iostatus = IO_STATUS_OK;
 }
 
 /* The I/O status is only enabled if the drive explicitly
@@ -1212,7 +1212,7 @@ bool blk_iostatus_is_enabled(const BlockBackend *blk)
             blk->on_read_error == BLOCKDEV_ON_ERROR_STOP));
 }
 
-BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk)
+IoStatus blk_iostatus(const BlockBackend *blk)
 {
     GLOBAL_STATE_CODE();
     return blk->iostatus;
@@ -1228,7 +1228,7 @@ void blk_iostatus_reset(BlockBackend *blk)
 {
     GLOBAL_STATE_CODE();
     if (blk_iostatus_is_enabled(blk)) {
-        blk->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
+        blk->iostatus = IO_STATUS_OK;
     }
 }
 
@@ -1236,9 +1236,9 @@ void blk_iostatus_set_err(BlockBackend *blk, int error)
 {
     IO_CODE();
     assert(blk_iostatus_is_enabled(blk));
-    if (blk->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
-        blk->iostatus = error == ENOSPC ? BLOCK_DEVICE_IO_STATUS_NOSPACE :
-                                          BLOCK_DEVICE_IO_STATUS_FAILED;
+    if (blk->iostatus == IO_STATUS_OK) {
+        blk->iostatus = error == ENOSPC ? IO_STATUS_NOSPACE :
+                                          IO_STATUS_FAILED;
     }
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 96dcbbc3e8..8e672f3309 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -923,7 +923,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     MirrorBDSOpaque *mirror_top_opaque = s->mirror_top_bs->opaque;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
-    BlockDeviceIoStatus iostatus;
+    IoStatus iostatus;
     int64_t length;
     int64_t target_length;
     BlockDriverInfo bdi;
@@ -1060,7 +1060,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
             iostatus = s->common.iostatus;
         }
         if (delta < BLOCK_JOB_SLICE_TIME &&
-            iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
+            iostatus == IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
                 trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index d954bec6f1..64acb9cd6a 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -642,9 +642,9 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
         if (info->qdev) {
             monitor_printf(mon, "    Attached to:      %s\n", info->qdev);
         }
-        if (info->has_io_status && info->io_status != BLOCK_DEVICE_IO_STATUS_OK) {
+        if (info->has_io_status && info->io_status != IO_STATUS_OK) {
             monitor_printf(mon, "    I/O status:       %s\n",
-                           BlockDeviceIoStatus_str(info->io_status));
+                           IoStatus_str(info->io_status));
         }
 
         if (info->removable) {
diff --git a/blockjob.c b/blockjob.c
index d3cd4f4fbf..de1dd03b2d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -394,9 +394,9 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
 /* Called with job lock held */
 static void block_job_iostatus_set_err_locked(BlockJob *job, int error)
 {
-    if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
-        job->iostatus = error == ENOSPC ? BLOCK_DEVICE_IO_STATUS_NOSPACE :
-                                          BLOCK_DEVICE_IO_STATUS_FAILED;
+    if (job->iostatus == IO_STATUS_OK) {
+        job->iostatus = error == ENOSPC ? IO_STATUS_NOSPACE :
+                                          IO_STATUS_FAILED;
     }
 }
 
@@ -550,11 +550,11 @@ fail:
 void block_job_iostatus_reset_locked(BlockJob *job)
 {
     GLOBAL_STATE_CODE();
-    if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
+    if (job->iostatus == IO_STATUS_OK) {
         return;
     }
     assert(job->job.user_paused && job->job.pause_count > 0);
-    job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
+    job->iostatus = IO_STATUS_OK;
 }
 
 static void block_job_iostatus_reset(BlockJob *job)
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index fe433c8d35..fd7ba1a285 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -50,7 +50,7 @@ typedef struct BlockJob {
      * Status that is published by the query-block-jobs QMP API.
      * Protected by job mutex.
      */
-    BlockDeviceIoStatus iostatus;
+    IoStatus iostatus;
 
     /**
      * Speed that was set with @block_job_set_speed.
diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index 49c12b0fa9..a45643438f 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -66,7 +66,7 @@ int GRAPH_UNLOCKED blk_set_perm(BlockBackend *blk, uint64_t perm,
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
 
 void blk_iostatus_enable(BlockBackend *blk);
-BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
+IoStatus blk_iostatus(const BlockBackend *blk);
 void blk_iostatus_disable(BlockBackend *blk);
 void blk_iostatus_reset(BlockBackend *blk);
 int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 93f96e747e..1f00d4f031 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -571,7 +571,7 @@
             'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
 ##
-# @BlockDeviceIoStatus:
+# @IoStatus:
 #
 # An enumeration of block device I/O status.
 #
@@ -584,7 +584,7 @@
 #
 # Since: 1.0
 ##
-{ 'enum': 'BlockDeviceIoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
+{ 'enum': 'IoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
 
 ##
 # @BlockDirtyInfo:
@@ -705,7 +705,7 @@
 # @tray_open: True if the device's tray is open (only present if it
 #     has a tray)
 #
-# @io-status: @BlockDeviceIoStatus.  Only present if the device
+# @io-status: @IoStatus.  Only present if the device
 #     supports it and the VM is configured to stop on errors
 #     (supported device models: virtio-blk, IDE, SCSI except
 #     scsi-generic)
@@ -718,7 +718,7 @@
 { 'struct': 'BlockInfo',
   'data': {'device': 'str', '*qdev': 'str', 'type': 'str', 'removable': 'bool',
            'locked': 'bool', '*inserted': 'BlockDeviceInfo',
-           '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus' } }
+           '*tray_open': 'bool', '*io-status': 'IoStatus' } }
 
 ##
 # @BlockMeasureInfo:
@@ -1424,7 +1424,7 @@
 { 'union': 'BlockJobInfo',
   'base': {'type': 'JobType', 'device': 'str', 'len': 'int',
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
-           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
+           'io-status': 'IoStatus', 'ready': 'bool',
            'status': 'JobStatus',
            'auto-finalize': 'bool', 'auto-dismiss': 'bool',
            '*error': 'str' },
-- 
2.34.1


