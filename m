Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A67CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBriq-0001OS-0l; Wed, 30 Sep 2026 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrim-0001MM-F6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006l6-U8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d97Dnct+FeOHGQu2rJbwgjDT+PAJK6+738zur4d369s=;
 b=H5urzcBbgPvALXEHHaWESRMHerifoBSrTPhSB2RmrjE2gJLV+vMslNFKa4gdZtM3geqDVS
 mfJwdm56uLsgyHzkUqs54ffltKUq/Alc22KRz7tX41ZtAkkqG5OtyIz9p2t5HLSAa1zBWl
 Efb32x3foWQVnkANbDQa0kTYZF6X468=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-4tqoTeSYO2-CG0E3KvOwxA-1; Wed,
 30 Sep 2026 06:39:21 -0400
X-MC-Unique: 4tqoTeSYO2-CG0E3KvOwxA-1
X-Mimecast-MFC-AGG-ID: 4tqoTeSYO2-CG0E3KvOwxA_1790764760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA70A1802161; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BC5718004D2; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15FCD21E68A4; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 031/105] qapi: convert trivial intro sections for block.json
Date: Wed, 30 Sep 2026 12:37:56 +0200
Message-ID: <20260930103910.3934848-32-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-32-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 012a9d7333..c91cbf86b9 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -50,8 +50,8 @@
 
 ##
 # @FloppyDriveType:
-#
-# Type of floppy drive to be emulated by the Floppy Disk Controller.
+#     Type of floppy drive to be emulated by the
+#     Floppy Disk Controller.
 #
 # @144: 1.44MB 3.5" drive
 #
@@ -70,8 +70,7 @@
 
 ##
 # @PRManagerInfo:
-#
-# Information about a persistent reservation manager
+#     Information about a persistent reservation manager
 #
 # @id: the identifier of the persistent reservation manager
 #
@@ -85,9 +84,8 @@
 
 ##
 # @query-pr-managers:
-#
-# Return a list of information about each persistent reservation
-# manager.
+#     Return a list of information about each persistent reservation
+#     manager.
 #
 # Returns: a list of manager info for each persistent reservation
 #     manager
@@ -99,8 +97,7 @@
 
 ##
 # @eject:
-#
-# Ejects the medium from a removable drive.
+#     Ejects the medium from a removable drive.
 #
 # @device: Block device name
 #
@@ -297,9 +294,8 @@
 
 ##
 # @BlockdevChangeReadOnlyMode:
-#
-# Specifies the new read-only mode of a block device subject to the
-# `blockdev-change-medium` command.
+#     Specifies the new read-only mode of a block device subject to
+#     the `blockdev-change-medium` command.
 #
 # @retain: Retains the current read-only mode
 #
@@ -314,12 +310,11 @@
 
 ##
 # @blockdev-change-medium:
-#
-# Changes the medium inserted into a block device by ejecting the
-# current medium and loading a new image file which is inserted as the
-# new medium (this command combines `blockdev-open-tray`,
-# `blockdev-remove-medium`, `blockdev-insert-medium` and
-# `blockdev-close-tray`).
+#     Changes the medium inserted into a block device by ejecting the
+#     current medium and loading a new image file which is inserted as
+#     the new medium (this command combines `blockdev-open-tray`,
+#     `blockdev-remove-medium`, `blockdev-insert-medium` and
+#     `blockdev-close-tray`).
 #
 # @device: Block device name
 #
@@ -385,9 +380,8 @@
 
 ##
 # @DEVICE_TRAY_MOVED:
-#
-# Emitted whenever the tray of a removable device is moved by the
-# guest or by HMP/QMP commands
+#     Emitted whenever the tray of a removable device is moved by the
+#     guest or by HMP/QMP commands
 #
 # @device: Block device name.  This is always present for
 #     compatibility reasons, but it can be empty ("") if the image
@@ -414,9 +408,8 @@
 
 ##
 # @PR_MANAGER_STATUS_CHANGED:
-#
-# Emitted whenever the connected status of a persistent reservation
-# manager changes.
+#     Emitted whenever the connected status of a persistent
+#     reservation manager changes.
 #
 # @id: The id of the PR manager object
 #
-- 
2.55.0


