Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A521DC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDp-00076x-CB; Tue, 29 Apr 2025 07:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDk-0006yJ-F8; Tue, 29 Apr 2025 07:33:53 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDh-0008Gw-Q7; Tue, 29 Apr 2025 07:33:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 88FB5613E7;
 Tue, 29 Apr 2025 14:33:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-aBhvFnOW; Tue, 29 Apr 2025 14:33:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926425;
 bh=SijDt/tVC8RzUpiTA3pc0vLmFBOBKfrzJu2UzhRznAY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UcJG8IxxLjb14iTpfNu3G+wTg3zJtbmg8fu7BB1QJF5hchI8oS0WM4Dkrd885T3Kj
 hDnaAWZhEC0GQvWgVwZD59o0n/ekDfCj+myN70kcpgKS/6BhPRHqA0+U4j5kRrDSL/
 2MKIUMbmVUi2FC9+d+a2dTrmPAm5WmcwcFZshpg8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 6/8] qapi: synchronize jobs and block-jobs documentation
Date: Tue, 29 Apr 2025 14:33:33 +0300
Message-ID: <20250429113335.423535-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Actualize documentation and synchronize it for commands which actually
call the same functions internally.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20250409084232.28201-2-vsementsov@yandex-team.ru>
---
 qapi/block-core.json | 61 ++++++++++++++++++++++++++------------------
 qapi/job.json        | 30 ++++++++++++++++++++--
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..6beab0dc12 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2956,13 +2956,14 @@
 #
 # Pause an active background block operation.
 #
-# This command returns immediately after marking the active background
-# block operation for pausing.  It is an error to call this command if
-# no operation is in progress or if the job is already paused.
+# This command returns immediately after marking the active job for
+# pausing.  Pausing an already paused job is an error.
+#
+# The job will pause as soon as possible, which means transitioning
+# into the PAUSED state if it was RUNNING, or into STANDBY if it was
+# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
 #
-# The operation will pause as soon as possible.  No event is emitted
-# when the operation is actually paused.  Cancelling a paused job
-# automatically resumes it.
+# Cancelling a paused job automatically resumes it.
 #
 # @device: The job identifier.  This used to be a device name (hence
 #     the name of the parameter), but since QEMU 2.7 it can have other
@@ -2982,9 +2983,8 @@
 #
 # Resume an active background block operation.
 #
-# This command returns immediately after resuming a paused background
-# block operation.  It is an error to call this command if no
-# operation is in progress or if the job is not paused.
+# This command returns immediately after resuming a paused job.
+# Resuming an already running job is an error.
 #
 # This command also clears the error status of the job.
 #
@@ -3004,10 +3004,15 @@
 ##
 # @block-job-complete:
 #
-# Manually trigger completion of an active background block operation.
-# This is supported for drive mirroring, where it also switches the
-# device to write to the target path only.  The ability to complete is
-# signaled with a BLOCK_JOB_READY event.
+# Manually trigger completion of an active job in the READY or STANDBY
+# state.  Completing the job in any other state is an error.
+#
+# This is supported only for drive mirroring, where it also switches
+# the device to write to the target path only. Note that drive
+# mirroring includes drive-mirror, blockdev-mirror and block-commit
+# job (only in case of "active commit", when the node being commited
+# is used by the guest). The ability to complete is signaled with a
+# BLOCK_JOB_READY event.
 #
 # This command completes an active background block operation
 # synchronously.  The ordering of this command's return with the
@@ -3017,8 +3022,6 @@
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
-# A cancelled or paused job cannot be completed.
-#
 # @device: The job identifier.  This used to be a device name (hence
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
@@ -3035,10 +3038,13 @@
 ##
 # @block-job-dismiss:
 #
-# For jobs that have already concluded, remove them from the
-# block-job-query list.  This command only needs to be run for jobs
-# which were started with QEMU 2.12+ job lifetime management
-# semantics.
+# Deletes a job that is in the CONCLUDED state.  This command only
+# needs to be run explicitly for jobs that don't have automatic
+# dismiss enabled. In turn, automatic dismiss may be enabled only
+# for jobs that have @auto-dismiss option, which are drive-backup,
+# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
+# block-stream. @auto-dismiss is enabled by default for these
+# jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
@@ -3055,12 +3061,17 @@
 ##
 # @block-job-finalize:
 #
-# Once a job that has manual=true reaches the pending state, it can be
-# instructed to finalize any graph changes and do any necessary
-# cleanup via this command.  For jobs in a transaction, instructing
-# one job to finalize will force ALL jobs in the transaction to
-# finalize, so it is only necessary to instruct a single member job to
-# finalize.
+# Instructs all jobs in a transaction (or a single job if it is not
+# part of any transaction) to finalize any graph changes and do any
+# necessary cleanup.  This command requires that all involved jobs are
+# in the PENDING state.
+#
+# For jobs in a transaction, instructing one job to finalize will
+# force ALL jobs in the transaction to finalize, so it is only
+# necessary to instruct a single member job to finalize.
+#
+# The command is applicable only to jobs which have @auto-finalize option
+# and only when this option is set to false.
 #
 # @id: The job identifier.
 #
diff --git a/qapi/job.json b/qapi/job.json
index cfc3beedd2..b03f80bc84 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -156,6 +156,9 @@
 # This command returns immediately after resuming a paused job.
 # Resuming an already running job is an error.
 #
+# This command also clears the error status for block-jobs (stream,
+# commit, mirror, backup).
+#
 # @id: The job identifier.
 #
 # Since: 3.0
@@ -184,7 +187,23 @@
 ##
 # @job-complete:
 #
-# Manually trigger completion of an active job in the READY state.
+# Manually trigger completion of an active job in the READY or STANDBY
+# state.  Completing the job in any other state is an error.
+#
+# This is supported only for drive mirroring, where it also switches
+# the device to write to the target path only. Note that drive
+# mirroring includes drive-mirror, blockdev-mirror and block-commit
+# job (only in case of "active commit", when the node being commited
+# is used by the guest). The ability to complete is signaled with a
+# BLOCK_JOB_READY event.
+#
+# This command completes an active background block operation
+# synchronously.  The ordering of this command's return with the
+# BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
+# occurs during the processing of this command: 1) the command itself
+# will fail; 2) the error will be processed according to the
+# rerror/werror arguments that were specified when starting the
+# operation.
 #
 # @id: The job identifier.
 #
@@ -197,7 +216,11 @@
 #
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled.
+# dismiss enabled. In turn, automatic dismiss may be enabled only
+# for jobs that have @auto-dismiss option, which are drive-backup,
+# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
+# block-stream. @auto-dismiss is enabled by default for these
+# jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
@@ -222,6 +245,9 @@
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
 #
+# The command is applicable only to jobs which have @auto-finalize option
+# and only when this option is set to false.
+#
 # @id: The identifier of any job in the transaction, or of a job that
 #     is not part of any transaction.
 #
-- 
2.48.1


