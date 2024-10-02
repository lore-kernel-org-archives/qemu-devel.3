Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEFACF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00p-0003m0-DT; Wed, 02 Oct 2024 10:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003T2-EN; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-00056D-8z; Wed, 02 Oct 2024 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0E27360A05;
 Wed,  2 Oct 2024 17:06:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-U58OG1no; Wed, 02 Oct 2024 17:06:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878007;
 bh=NC4l71ZU2QZsFuC9zoxFRkAOwdL2wTKK5ZcxHOVIUVU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HHbwSQ0KmyaTgOQPz+mwsBiMTnemoamCOFQzxaLiJr4fRmSgap4Zzp9MS4CTxB8uF
 4Hl9GywCkpFWUiVhb+ibQRH8hu5G5rDSmOZ60BK3dzSQc1VxEffs48WteZbuJ0xzSP
 pjZhrqu1cszP3Pq4OJ2u8GnJIQmwgB9aewp0pfb0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 1/7] qapi: rename BlockJobChangeOptions to JobChangeOptions
Date: Wed,  2 Oct 2024 17:06:10 +0300
Message-Id: <20241002140616.561652-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002140616.561652-1-vsementsov@yandex-team.ru>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We are going to move change action from block-job to job
implementation, and then move to job-* extenral APIs, deprecating
block-job-* APIs. This commit simplifies further transition.

The commit is made by command

    git grep -l BlockJobChangeOptions | \
        xargs sed -i 's/BlockJobChangeOptions/JobChangeOptions/g'

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 block/mirror.c               |  4 ++--
 blockdev.c                   |  2 +-
 blockjob.c                   |  2 +-
 include/block/blockjob.h     |  2 +-
 include/block/blockjob_int.h |  2 +-
 qapi/block-core.json         | 12 ++++++------
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 61f0a717b7..2816bb1042 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1258,11 +1258,11 @@ static bool commit_active_cancel(Job *job, bool force)
     return force || !job_is_ready(job);
 }
 
-static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
+static void mirror_change(BlockJob *job, JobChangeOptions *opts,
                           Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
-    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
+    JobChangeOptionsMirror *change_opts = &opts->u.mirror;
     MirrorCopyMode current;
 
     /*
diff --git a/blockdev.c b/blockdev.c
index 6740663fda..626f53102d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3251,7 +3251,7 @@ void qmp_block_job_dismiss(const char *id, Error **errp)
     job_dismiss_locked(&job, errp);
 }
 
-void qmp_block_job_change(BlockJobChangeOptions *opts, Error **errp)
+void qmp_block_job_change(JobChangeOptions *opts, Error **errp)
 {
     BlockJob *job;
 
diff --git a/blockjob.c b/blockjob.c
index d5f29e14af..8cfbb15543 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -312,7 +312,7 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     return block_job_set_speed_locked(job, speed, errp);
 }
 
-void block_job_change_locked(BlockJob *job, BlockJobChangeOptions *opts,
+void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
                              Error **errp)
 {
     const BlockJobDriver *drv = block_job_driver(job);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7061ab7201..5dd1b08909 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -181,7 +181,7 @@ bool block_job_set_speed_locked(BlockJob *job, int64_t speed, Error **errp);
  *
  * Change the job according to opts.
  */
-void block_job_change_locked(BlockJob *job, BlockJobChangeOptions *opts,
+void block_job_change_locked(BlockJob *job, JobChangeOptions *opts,
                              Error **errp);
 
 /**
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 4c3d2e25a2..d9c3b911d0 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -73,7 +73,7 @@ struct BlockJobDriver {
      *
      * Note that this can already be called before the job coroutine is running.
      */
-    void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
+    void (*change)(BlockJob *job, JobChangeOptions *opts, Error **errp);
 
     /*
      * Query information specific to this kind of block job.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c3b0a2376b..0156762024 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3068,18 +3068,18 @@
   'allow-preconfig': true }
 
 ##
-# @BlockJobChangeOptionsMirror:
+# @JobChangeOptionsMirror:
 #
 # @copy-mode: Switch to this copy mode.  Currently, only the switch
 #     from 'background' to 'write-blocking' is implemented.
 #
 # Since: 8.2
 ##
-{ 'struct': 'BlockJobChangeOptionsMirror',
+{ 'struct': 'JobChangeOptionsMirror',
   'data': { 'copy-mode' : 'MirrorCopyMode' } }
 
 ##
-# @BlockJobChangeOptions:
+# @JobChangeOptions:
 #
 # Block job options that can be changed after job creation.
 #
@@ -3089,10 +3089,10 @@
 #
 # Since: 8.2
 ##
-{ 'union': 'BlockJobChangeOptions',
+{ 'union': 'JobChangeOptions',
   'base': { 'id': 'str', 'type': 'JobType' },
   'discriminator': 'type',
-  'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }
+  'data': { 'mirror': 'JobChangeOptionsMirror' } }
 
 ##
 # @block-job-change:
@@ -3102,7 +3102,7 @@
 # Since: 8.2
 ##
 { 'command': 'block-job-change',
-  'data': 'BlockJobChangeOptions', 'boxed': true }
+  'data': 'JobChangeOptions', 'boxed': true }
 
 ##
 # @BlockdevDiscardOptions:
-- 
2.34.1


