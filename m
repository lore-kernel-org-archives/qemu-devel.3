Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA1DC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLIF-0000mn-QE; Tue, 03 Jun 2025 02:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGd-0007mm-4f
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003R2-Hc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5LQXDHvjy1kP2PmWjPXugqEGBRau6Ojy+3j+rEPZEI=;
 b=QFokitB4z5hEHqM1Fc3dUVnW3U5va/Lt1wAgVH8zhfELFCKIK8vGDJjjOcxdhgrSebE0Pn
 Ge8TpCmEVh+5L9YW6r2M011Du3k3hQAas9WKdrN6VvtbF6wiMSbSyPdz1SR8e7u4Mjl/dl
 2A81wmmThstDyXJlm/SoDrDVHjeRmm0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-XhfLYTrbOI-M1Kg0u6lsDg-1; Tue,
 03 Jun 2025 02:36:48 -0400
X-MC-Unique: XhfLYTrbOI-M1Kg0u6lsDg-1
X-Mimecast-MFC-AGG-ID: XhfLYTrbOI-M1Kg0u6lsDg_1748932608
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246E619560AE
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C17B18008E0
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E66C921E66AD; Tue, 03 Jun 2025 08:36:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 02/13] qapi: Tidy up whitespace in doc comments
Date: Tue,  3 Jun 2025 08:36:33 +0200
Message-ID: <20250603063644.3953528-3-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json   | 16 ++++++++--------
 qapi/block-export.json |  4 ++--
 qapi/char.json         |  2 +-
 qapi/crypto.json       |  3 ++-
 qapi/job.json          |  8 ++++----
 qapi/machine.json      |  2 +-
 qapi/migration.json    | 12 ++++++------
 qapi/qom.json          |  2 +-
 8 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 29d7c1c2c9..13223df9b4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -488,7 +488,7 @@
 #
 # @active: true if the backend is active; typical cases for inactive backends
 #     are on the migration source instance after migration completes and on the
-#     destination before it completes. (since: 10.0)
+#     destination before it completes.  (since: 10.0)
 #
 # @encrypted: true if the backing device is encrypted
 #
@@ -3030,10 +3030,10 @@
 # state.  Completing the job in any other state is an error.
 #
 # This is supported only for drive mirroring, where it also switches
-# the device to write to the target path only. Note that drive
+# the device to write to the target path only.  Note that drive
 # mirroring includes drive-mirror, blockdev-mirror and block-commit
 # job (only in case of "active commit", when the node being commited
-# is used by the guest). The ability to complete is signaled with a
+# is used by the guest).  The ability to complete is signaled with a
 # BLOCK_JOB_READY event.
 #
 # This command completes an active background block operation
@@ -3068,10 +3068,10 @@
 #
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled. In turn, automatic dismiss may be enabled only
+# dismiss enabled.  In turn, automatic dismiss may be enabled only
 # for jobs that have @auto-dismiss option, which are drive-backup,
 # blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
-# block-stream. @auto-dismiss is enabled by default for these
+# block-stream.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
@@ -4737,7 +4737,7 @@
 # @active: whether the block node should be activated (default: true).
 #     Having inactive block nodes is useful primarily for migration because it
 #     allows opening an image on the destination while the source is still
-#     holding locks for it. (Since 10.0)
+#     holding locks for it.  (Since 10.0)
 #
 # @read-only: whether the block device should be read-only (default:
 #     false).  Note that some block drivers support only read-only
@@ -4999,14 +4999,14 @@
 ##
 # @blockdev-set-active:
 #
-# Activate or inactivate a block device. Use this to manage the handover of
+# Activate or inactivate a block device.  Use this to manage the handover of
 # block devices on migration with qemu-storage-daemon.
 #
 # Activating a node automatically activates all of its child nodes first.
 # Inactivating a node automatically inactivates any of its child nodes that are
 # not in use by a still active node.
 #
-# @node-name: Name of the graph node to activate or inactivate. By default, all
+# @node-name: Name of the graph node to activate or inactivate.  By default, all
 #     nodes are affected by the operation.
 #
 # @active: true if the nodes should be active when the command returns success,
diff --git a/qapi/block-export.json b/qapi/block-export.json
index c783e01a53..04190b503c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -373,9 +373,9 @@
 #     (since: 5.2)
 #
 # @allow-inactive: If true, the export allows the exported node to be inactive.
-#     If it is created for an inactive block node, the node remains inactive. If
+#     If it is created for an inactive block node, the node remains inactive.  If
 #     the export type doesn't support running on an inactive node, an error is
-#     returned. If false, inactive block nodes are automatically activated before
+#     returned.  If false, inactive block nodes are automatically activated before
 #     creating the export and trying to inactivate them later fails.
 #     (since: 10.0; default: false)
 #
diff --git a/qapi/char.json b/qapi/char.json
index 447c10b91a..f79216e4d2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -274,7 +274,7 @@
 # @reconnect: For a client socket, if a socket is disconnected, then
 #     attempt a reconnect after the given number of seconds.  Setting
 #     this to zero disables this function.  The use of this member is
-#     deprecated, use @reconnect-ms instead. (default: 0) (Since: 2.2)
+#     deprecated, use @reconnect-ms instead.  (default: 0) (Since: 2.2)
 #
 # @reconnect-ms: For a client socket, if a socket is disconnected,
 #     then attempt a reconnect after the given number of milliseconds.
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fc7e294966..9ec6301e18 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -55,7 +55,8 @@
 # @sha512: SHA-512.  (since 2.7)
 #
 # @ripemd160: RIPEMD-160.  (since 2.7)
-# @sm3: SM3. (since 9.2.0)
+#
+# @sm3: SM3.  (since 9.2.0)
 #
 # Since: 2.6
 ##
diff --git a/qapi/job.json b/qapi/job.json
index b03f80bc84..c53c96cce8 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -191,10 +191,10 @@
 # state.  Completing the job in any other state is an error.
 #
 # This is supported only for drive mirroring, where it also switches
-# the device to write to the target path only. Note that drive
+# the device to write to the target path only.  Note that drive
 # mirroring includes drive-mirror, blockdev-mirror and block-commit
 # job (only in case of "active commit", when the node being commited
-# is used by the guest). The ability to complete is signaled with a
+# is used by the guest).  The ability to complete is signaled with a
 # BLOCK_JOB_READY event.
 #
 # This command completes an active background block operation
@@ -216,10 +216,10 @@
 #
 # Deletes a job that is in the CONCLUDED state.  This command only
 # needs to be run explicitly for jobs that don't have automatic
-# dismiss enabled. In turn, automatic dismiss may be enabled only
+# dismiss enabled.  In turn, automatic dismiss may be enabled only
 # for jobs that have @auto-dismiss option, which are drive-backup,
 # blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
-# block-stream. @auto-dismiss is enabled by default for these
+# block-stream.  @auto-dismiss is enabled by default for these
 # jobs.
 #
 # This command will refuse to operate on any job that has not yet
diff --git a/qapi/machine.json b/qapi/machine.json
index 0af2e1e0bb..069e87d16a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -694,7 +694,7 @@
 # Structure of HMAT (Heterogeneous Memory Attribute Table)
 #
 # For more information about @HmatLBDataType, see chapter 5.2.27.4:
-# Table 5-146:  Field "Data Type" of ACPI 6.3 spec.
+# Table 5-146: Field "Data Type" of ACPI 6.3 spec.
 #
 # @access-latency: access latency (nanoseconds)
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index f5a6b35de4..7c7b09c341 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -842,9 +842,9 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration. The level is an integer between 1 and 9, where 1 means
+#     migration.  The level is an integer between 1 and 9, where 1 means
 #     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1023,9 +1023,9 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration. The level is an integer between 1 and 9, where 1 means
+#     migration.  The level is an integer between 1 and 9, where 1 means
 #     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
@@ -1233,9 +1233,9 @@
 #     more CPU.  Defaults to 1.  (Since 5.0)
 #
 # @multifd-qatzip-level: Set the compression level to be used in live
-#     migration. The level is an integer between 1 and 9, where 1 means
+#     migration.  The level is an integer between 1 and 9, where 1 means
 #     the best compression speed, and 9 means the best compression
-#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
+#     ratio which will consume more CPU.  Defaults to 1.  (Since 9.2)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
 #     migration, the compression level is an integer between 0 and 20,
diff --git a/qapi/qom.json b/qapi/qom.json
index 45cd47508b..3e8debf78c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -870,7 +870,7 @@
 #     information read from devices and switches in conjunction with
 #     link characteristics read from PCIe Configuration space.
 #     To get the full path latency from CPU to CXL attached DRAM
-#     CXL device:  Add the latency from CPU to Generic Port (from
+#     CXL device: Add the latency from CPU to Generic Port (from
 #     HMAT indexed via the node ID in this SRAT structure) to
 #     that for CXL bus links, the latency across intermediate switches
 #     and from the EP port to the actual memory.  Bandwidth is more
-- 
2.48.1


