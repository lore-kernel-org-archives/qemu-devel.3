Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F78CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aEE-0005Hy-11; Sat, 11 Oct 2025 10:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDg-0004WF-GC; Sat, 11 Oct 2025 10:05:18 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDS-0005PU-Mo; Sat, 11 Oct 2025 10:05:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5C433C018F;
 Sat, 11 Oct 2025 17:04:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-T8CQTeeH; Sat, 11 Oct 2025 17:04:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191489;
 bh=wx/I6VtVDwoWBi0b5ijZlX7Un2UFdYPB/5MJo7VWM0k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FwOj+2uRS4t6bNk3t2qwhp4VJl3fjfcHYpUdHAzvkNhjGVtJsPCd4ZzloX2frdnaV
 igE5SOetQ7iaZLAqyomUycr+XZHvGY6Kcq/+yRl+YEOZwRR20rSLyGTeZEZMOhiejb
 LSkITL0tJq6OSv0s8+n39QUs4O8uRZnYPEggLdG4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PATCH v2 11/33] qapi/job.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 17:04:17 +0300
Message-ID: <20251011140441.297246-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/job.json | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 8b08350af2..887777b973 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -194,16 +194,16 @@
 #
 # This is supported only for drive mirroring, where it also switches
 # the device to write to the target path only.  Note that drive
-# mirroring includes `drive-mirror`, `blockdev-mirror` and `block-commit`
-# job (only in case of "active commit", when the node being commited
-# is used by the guest).  The ability to complete is signaled with a
-# `BLOCK_JOB_READY` event.
+# mirroring includes `drive-mirror`, `blockdev-mirror` and
+# `block-commit` job (only in case of "active commit", when the node
+# being commited is used by the guest).  The ability to complete is
+# signaled with a `BLOCK_JOB_READY` event.
 #
 # This command completes an active background block operation
 # synchronously.  The ordering of this command's return with the
-# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O error
-# occurs during the processing of this command: 1) the command itself
-# will fail; 2) the error will be processed according to the
+# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O
+# error occurs during the processing of this command: 1) the command
+# itself will fail; 2) the error will be processed according to the
 # rerror/werror arguments that were specified when starting the
 # operation.
 #
@@ -220,14 +220,14 @@
 # needs to be run explicitly for jobs that don't have automatic
 # dismiss enabled.  In turn, automatic dismiss may be enabled only
 # for jobs that have @auto-dismiss option, which are `drive-backup`,
-# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
-# `block-stream`.  @auto-dismiss is enabled by default for these
+# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
+# and `block-stream`.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
 # reached its terminal state, CONCLUDED.  For jobs that make use of
-# the JOB_READY event, `job-cancel` or `job-complete` will still need to
-# be used as appropriate.
+# the JOB_READY event, `job-cancel` or `job-complete` will still need
+# to be used as appropriate.
 #
 # @id: The job identifier.
 #
@@ -247,8 +247,8 @@
 # force ALL jobs in the transaction to finalize, so it is only
 # necessary to instruct a single member job to finalize.
 #
-# The command is applicable only to jobs which have @auto-finalize option
-# and only when this option is set to false.
+# The command is applicable only to jobs which have @auto-finalize
+# option and only when this option is set to false.
 #
 # @id: The identifier of any job in the transaction, or of a job that
 #     is not part of any transaction.
-- 
2.48.1


