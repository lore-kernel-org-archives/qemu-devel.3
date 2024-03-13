Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24961C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEq-0003qu-Ku; Wed, 13 Mar 2024 11:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEY-0003a0-Iy; Wed, 13 Mar 2024 11:09:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEV-0005rz-0c; Wed, 13 Mar 2024 11:09:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 41B2760E1B;
 Wed, 13 Mar 2024 18:09:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-BYtVbgjh; Wed, 13 Mar 2024 18:09:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342566;
 bh=cLF4sNqFIfGUD8kpAtx4cz6Ol33QAQAavlhJwLdPbio=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aJafLsFCqrLkLfmhlsZPLOT8+/fSFiPwWstCRq7IV0aJshqg0LWtkJizhQr8YkmsP
 wqw1oHw6TEebHN2e25Ignobk0TvrPgil23L2UGTf6wvGKd97GczzQhMYFR35Oz2xAQ
 ig6v4+0k9tdektB7QUu9KekxHYFeQ+xjT4D+56LY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 02/15] qapi: rename BlockJobChangeOptions to JobChangeOptions
Date: Wed, 13 Mar 2024 18:08:54 +0300
Message-Id: <20240313150907.623462-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 block/mirror.c               |  4 ++--
 blockdev.c                   |  2 +-
 blockjob.c                   |  2 +-
 include/block/blockjob.h     |  2 +-
 include/block/blockjob_int.h |  2 +-
 qapi/block-core.json         | 12 ++++++------
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..a177502e4f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1251,11 +1251,11 @@ static bool commit_active_cancel(Job *job, bool force)
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
index d8fb3399f5..7881f6e5a6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3245,7 +3245,7 @@ void qmp_block_job_dismiss(const char *id, Error **errp)
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
index 1874f880a8..67dd0ef038 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3063,18 +3063,18 @@
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
@@ -3084,10 +3084,10 @@
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
@@ -3097,7 +3097,7 @@
 # Since: 8.2
 ##
 { 'command': 'block-job-change',
-  'data': 'BlockJobChangeOptions', 'boxed': true }
+  'data': 'JobChangeOptions', 'boxed': true }
 
 ##
 # @BlockdevDiscardOptions:
-- 
2.34.1


