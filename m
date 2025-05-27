Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E6C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouQ-00043W-DT; Tue, 27 May 2025 03:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouN-00042o-Uk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007qK-7w
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbXa98tSi8Y9IpY28Hy3Ua0GXrYdUNTTC3TBLWtcgPI=;
 b=Fj5g3rZeDDOfJjQPLHQtRIpMFmadQf/NoOuNdi+sPZ1fgFXtIejwufGu0TYMcfidDU7+Wz
 Kp7Ch7ISoupl85bv6K38AyTBuOuZYedWuspH/tH1437I2o17ntYDJlHfRuj2wE5TZXCgzz
 nKC8JQtDjrl0Jk2b1WWc/sprvDAA1fw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-lsqV7grHM5WJKb12_kZCDw-1; Tue,
 27 May 2025 03:39:21 -0400
X-MC-Unique: lsqV7grHM5WJKb12_kZCDw-1
X-Mimecast-MFC-AGG-ID: lsqV7grHM5WJKb12_kZCDw_1748331560
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F36AB1800981; Tue, 27 May 2025 07:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 039AF180010A; Tue, 27 May 2025 07:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2439721E66C5; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 01/13] qapi: Tidy up run-together sentences in doc comments
Date: Tue, 27 May 2025 09:39:04 +0200
Message-ID: <20250527073916.1243024-2-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fixes: a937b6aa739f (qapi: Reformat doc comments to conform to current conventions)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/acpi.json       |  2 +-
 qapi/block-core.json | 14 +++++++-------
 qapi/crypto.json     | 18 +++++++++---------
 qapi/machine.json    |  4 ++--
 qapi/migration.json  | 18 +++++++++---------
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 045dab6228..2d53b82365 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -80,7 +80,7 @@
 ##
 # @ACPIOSTInfo:
 #
-# OSPM Status Indication for a device For description of possible
+# OSPM Status Indication for a device.  For description of possible
 # values of @source and @status fields see "_OST (OSPM Status
 # Indication)" chapter of ACPI5.0 spec.
 #
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b4115113d4..29d7c1c2c9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2667,7 +2667,7 @@
 # @iops-total-max: I/O operations burst
 #
 # @iops-total-max-length: length of the iops-total-max burst period,
-#     in seconds It must only be set if @iops-total-max is set as
+#     in seconds.  It must only be set if @iops-total-max is set as
 #     well.
 #
 # @iops-read: limit read operations per second
@@ -2675,14 +2675,14 @@
 # @iops-read-max: I/O operations read burst
 #
 # @iops-read-max-length: length of the iops-read-max burst period, in
-#     seconds It must only be set if @iops-read-max is set as well.
+#     seconds.  It must only be set if @iops-read-max is set as well.
 #
 # @iops-write: limit write operations per second
 #
 # @iops-write-max: I/O operations write burst
 #
 # @iops-write-max-length: length of the iops-write-max burst period,
-#     in seconds It must only be set if @iops-write-max is set as
+#     in seconds.  It must only be set if @iops-write-max is set as
 #     well.
 #
 # @bps-total: limit total bytes per second
@@ -2697,14 +2697,14 @@
 # @bps-read-max: total bytes read burst
 #
 # @bps-read-max-length: length of the bps-read-max burst period, in
-#     seconds It must only be set if @bps-read-max is set as well.
+#     seconds.  It must only be set if @bps-read-max is set as well.
 #
 # @bps-write: limit write bytes per second
 #
 # @bps-write-max: total bytes write burst
 #
 # @bps-write-max-length: length of the bps-write-max burst period, in
-#     seconds It must only be set if @bps-write-max is set as well.
+#     seconds.  It must only be set if @bps-write-max is set as well.
 #
 # @iops-size: when limiting by iops max size of an I/O in bytes
 #
@@ -5580,7 +5580,7 @@
 # @x-blockdev-amend:
 #
 # Starts a job to amend format specific options of an existing open
-# block device The job is automatically finalized, but a manual
+# block device.  The job is automatically finalized, but a manual
 # job-dismiss is required.
 #
 # @job-id: Identifier for the newly created job.
@@ -5589,7 +5589,7 @@
 #
 # @options: Options (driver specific)
 #
-# @force: Allow unsafe operations, format specific For luks that
+# @force: Allow unsafe operations, format specific.  For luks that
 #     allows erase of the last active keyslot (permanent loss of
 #     data), and replacement of an active keyslot (possible loss of
 #     data if IO error happens)
diff --git a/qapi/crypto.json b/qapi/crypto.json
index c9d967d782..fc7e294966 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -202,19 +202,19 @@
 #
 # The options that apply to LUKS encryption format initialization
 #
-# @cipher-alg: the cipher algorithm for data encryption Currently
+# @cipher-alg: the cipher algorithm for data encryption.  Currently
 #     defaults to 'aes-256'.
 #
-# @cipher-mode: the cipher mode for data encryption Currently defaults
-#     to 'xts'
+# @cipher-mode: the cipher mode for data encryption.  Currently
+#     defaults to 'xts'
 #
-# @ivgen-alg: the initialization vector generator Currently defaults
+# @ivgen-alg: the initialization vector generator.  Currently defaults
 #     to 'plain64'
 #
-# @ivgen-hash-alg: the initialization vector generator hash Currently
-#     defaults to 'sha256'
+# @ivgen-hash-alg: the initialization vector generator hash.
+#     Currently defaults to 'sha256'
 #
-# @hash-alg: the master key hash algorithm Currently defaults to
+# @hash-alg: the master key hash algorithm.  Currently defaults to
 #     'sha256'
 #
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
@@ -370,11 +370,11 @@
 # @new-secret: The ID of a QCryptoSecret object providing the password
 #     to be written into added active keyslots
 #
-# @old-secret: Optional (for deactivation only) If given will
+# @old-secret: Optional (for deactivation only).  If given will
 #     deactivate all keyslots that match password located in
 #     QCryptoSecret with this ID
 #
-# @iter-time: Optional (for activation only) Number of milliseconds to
+# @iter-time: Optional (for activation only).  Number of milliseconds to
 #     spend in PBKDF passphrase processing for the newly activated
 #     keyslot.  Currently defaults to 2000.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index c8feb9fe17..0c5c85d014 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1160,7 +1160,7 @@
 #
 # Information about the guest balloon device.
 #
-# @actual: the logical size of the VM in bytes Formula used:
+# @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
 #
 # Since: 0.14
@@ -1199,7 +1199,7 @@
 # is equivalent to the @actual field return by the 'query-balloon'
 # command
 #
-# @actual: the logical size of the VM in bytes Formula used:
+# @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
 #
 # .. note:: This event is rate-limited.
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..beebc2a6f8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -760,9 +760,9 @@
 #     auto-converge detects that migration is not making progress.
 #     The default value is 10.  (Since 2.7)
 #
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
+#     At the tail stage of throttling, the Guest is very sensitive to
+#     CPU percentage while the @cpu-throttle -increment is excessive
 #     usually at tail stage.  If this parameter is true, we will
 #     compute the ideal CPU percentage used by the Guest, which may
 #     exactly make the dirty rate match the dirty rate threshold.
@@ -941,9 +941,9 @@
 #     auto-converge detects that migration is not making progress.
 #     The default value is 10.  (Since 2.7)
 #
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
+#     At the tail stage of throttling, the Guest is very sensitive to
+#     CPU percentage while the @cpu-throttle -increment is excessive
 #     usually at tail stage.  If this parameter is true, we will
 #     compute the ideal CPU percentage used by the Guest, which may
 #     exactly make the dirty rate match the dirty rate threshold.
@@ -1155,9 +1155,9 @@
 #     auto-converge detects that migration is not making progress.
 #     (Since 2.7)
 #
-# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage At
-#     the tail stage of throttling, the Guest is very sensitive to CPU
-#     percentage while the @cpu-throttle -increment is excessive
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage.
+#     At the tail stage of throttling, the Guest is very sensitive to
+#     CPU percentage while the @cpu-throttle -increment is excessive
 #     usually at tail stage.  If this parameter is true, we will
 #     compute the ideal CPU percentage used by the Guest, which may
 #     exactly make the dirty rate match the dirty rate threshold.
-- 
2.48.1


