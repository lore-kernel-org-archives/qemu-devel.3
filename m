Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7AC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7i-0002ps-TM; Mon, 06 May 2024 07:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7d-0002nb-BJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003en-3Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=et+/ntzRn8KKOw7HyPbGWlfdTlKfnZsjoA4xRTtetQg=;
 b=ffRJwpzijaIozsgXXoswl4ChBAn8F7K00yhSax8+uTFBq548Q1hs0BrMNBkRLVCkMC4W2h
 lsulV2YH51Wz6yO0cCW6Dmnpb9t8KvkxGDhxfpWAGGlHyG6BvgB0EkdFq5uPV3KDU/8m2M
 UbRMCz2PtaNZqBQ7vM9uW8uXLf9ASbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-crcPYp2FMLaeCxuZVTs6yQ-1; Mon, 06 May 2024 07:02:57 -0400
X-MC-Unique: crcPYp2FMLaeCxuZVTs6yQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE13080B70A;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57DDA492BC7;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5060321E5D2B; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 5/7] qapi: Drop "Returns" section where default is fine WIP
Date: Mon,  6 May 2024 13:02:49 +0200
Message-ID: <20240506110254.3965097-10-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

---
 qapi/audio.json          |  2 --
 qapi/block-core.json     | 21 ++++-----------------
 qapi/block-export.json   |  2 +-
 qapi/block.json          |  3 ---
 qapi/char.json           | 10 +---------
 qapi/control.json        |  5 -----
 qapi/cryptodev.json      |  2 --
 qapi/dump.json           |  5 -----
 qapi/job.json            |  2 --
 qapi/machine-target.json |  6 ++----
 qapi/machine.json        | 36 ------------------------------------
 qapi/migration.json      | 12 ------------
 qapi/misc-target.json    | 16 ----------------
 qapi/misc.json           | 16 ++--------------
 qapi/pci.json            |  2 +-
 qapi/qdev.json           |  3 ---
 qapi/qom.json            |  8 --------
 qapi/replay.json         |  2 --
 qapi/rocker.json         |  8 --------
 qapi/run-state.json      |  2 --
 qapi/stats.json          |  2 +-
 qapi/tpm.json            |  4 ----
 qapi/trace.json          |  5 ++---
 qapi/ui.json             | 10 ----------
 qapi/virtio.json         | 10 ----------
 qapi/yank.json           |  2 --
 26 files changed, 14 insertions(+), 182 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 519697c0cd..bf11ca6d0a 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -515,8 +515,6 @@
 #
 # Returns information about audiodev configuration
 #
-# Returns: array of @Audiodev
-#
 # Since: 8.0
 ##
 { 'command': 'query-audiodevs',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 746d1694c2..fab1a45365 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -757,10 +757,8 @@
 ##
 # @query-block:
 #
-# Get a list of BlockInfo for all virtual block devices.
-#
-# Returns: a list of @BlockInfo describing each virtual block device.
-#     Filter nodes that were created implicitly are skipped over.
+# Get a list of BlockInfo for all virtual block devices.  Filter nodes
+# that were created implicitly are skipped over.
 #
 # Since: 0.14
 #
@@ -1164,8 +1162,6 @@
 #     that were created implicitly are skipped over in this mode.
 #     (Since 2.3)
 #
-# Returns: A list of @BlockStats for each virtual block devices.
-#
 # Since: 0.14
 #
 # Example:
@@ -1434,9 +1430,8 @@
 ##
 # @query-block-jobs:
 #
-# Return information about long-running block device operations.
-#
-# Returns: a list of @BlockJobInfo for each active block job
+# Return information about active, long-running block device
+# operations ("block jobs").
 #
 # Since: 1.1
 ##
@@ -1941,8 +1936,6 @@
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
 #
-# Returns: the list of BlockDeviceInfo
-#
 # Since: 2.0
 #
 # Example:
@@ -2456,9 +2449,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns:
-#     BlockDirtyBitmapSha256
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
@@ -6100,9 +6090,6 @@
 #
 # @name: optional the snapshot's name to be deleted
 #
-# Returns:
-#     SnapshotInfo
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If snapshot not found, GenericError
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 3919a2d5b9..89a277db80 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -464,7 +464,7 @@
 ##
 # @query-block-exports:
 #
-# Returns: A list of BlockExportInfo describing all block exports
+# Query block export information.
 #
 # Since: 5.2
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 5de99fe09d..97e2ccc4f1 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -86,9 +86,6 @@
 # Returns a list of information about each persistent reservation
 # manager.
 #
-# Returns: a list of @PRManagerInfo for each persistent reservation
-#     manager
-#
 # Since: 3.0
 ##
 { 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'],
diff --git a/qapi/char.json b/qapi/char.json
index 777dde55d9..87e1523946 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -36,8 +36,6 @@
 #
 # Returns information about current character devices.
 #
-# Returns: a list of @ChardevInfo
-#
 # Since: 0.14
 #
 # Example:
@@ -82,8 +80,6 @@
 #
 # Returns information about character device backends.
 #
-# Returns: a list of @ChardevBackendInfo
-#
 # Since: 2.0
 #
 # Example:
@@ -173,7 +169,7 @@
 #     - The return value is always Unicode regardless of format, like
 #       any other string.
 #
-# Returns: data read from the device
+# Returns: data read from the device (string)
 #
 # Since: 1.4
 #
@@ -695,8 +691,6 @@
 #
 # @backend: backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 1.4
 #
 # Examples:
@@ -731,8 +725,6 @@
 #
 # @backend: new backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 2.10
 #
 # Examples:
diff --git a/qapi/control.json b/qapi/control.json
index 6bdbf077c2..39510430fc 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -93,9 +93,6 @@
 #
 # Returns the current version of QEMU.
 #
-# Returns: A @VersionInfo object describing the current version of
-#     QEMU.
-#
 # Since: 0.14
 #
 # Example:
@@ -131,8 +128,6 @@
 #
 # Return a list of supported QMP commands by this server
 #
-# Returns: A list of @CommandInfo for all supported commands
-#
 # Since: 0.14
 #
 # Example:
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 68289f4984..6707aa506f 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -89,8 +89,6 @@
 #
 # Returns information about current crypto devices.
 #
-# Returns: a list of @QCryptodevInfo
-#
 # Since: 8.0
 ##
 { 'command': 'query-cryptodev', 'returns': ['QCryptodevInfo']}
diff --git a/qapi/dump.json b/qapi/dump.json
index 2fa9504d86..ec18387c71 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -146,8 +146,6 @@
 #
 # Query latest dump status.
 #
-# Returns: A @DumpStatus object showing the dump status.
-#
 # Since: 2.6
 #
 # Example:
@@ -197,9 +195,6 @@
 #
 # Returns the available formats for dump-guest-memory
 #
-# Returns: A @DumpGuestMemoryCapability object listing available
-#     formats for dump-guest-memory
-#
 # Since: 2.0
 #
 # Example:
diff --git a/qapi/job.json b/qapi/job.json
index b3957207a4..4f22edde56 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -269,8 +269,6 @@
 #
 # Return information about jobs.
 #
-# Returns: a list with a @JobInfo for each active job
-#
 # Since: 3.0
 ##
 { 'command': 'query-jobs', 'returns': ['JobInfo'] }
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 29e695aa06..4ef7ef7b43 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -380,8 +380,6 @@
 #
 # Return a list of supported virtual CPU definitions
 #
-# Returns: a list of CpuDefinitionInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
@@ -499,12 +497,12 @@
 ##
 # @query-s390x-cpu-polarization:
 #
+# Return the machine's CPU polarization.
+#
 # Features:
 #
 # @unstable: This command is experimental.
 #
-# Returns: the machine's CPU polarization
-#
 # Since: 8.2
 ##
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
diff --git a/qapi/machine.json b/qapi/machine.json
index bce6e1bbc4..b8f4c83914 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -100,8 +100,6 @@
 #
 # Returns information about all virtual CPUs.
 #
-# Returns: list of @CpuInfoFast
-#
 # Since: 2.12
 #
 # Example:
@@ -217,8 +215,6 @@
 #
 # @unstable: Argument @compat-props is experimental.
 #
-# Returns: a list of MachineInfo
-#
 # Since: 1.2
 #
 # Example:
@@ -267,8 +263,6 @@
 #
 # Return information on the current virtual machine.
 #
-# Returns: CurrentMachineParams
-#
 # Since: 4.0
 ##
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
@@ -290,8 +284,6 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: TargetInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
@@ -315,8 +307,6 @@
 #
 # Query the guest UUID information.
 #
-# Returns: The @UuidInfo for the guest
-#
 # Since: 0.14
 #
 # Example:
@@ -468,8 +458,6 @@
 #
 # Returns information about KVM acceleration
 #
-# Returns: @KvmInfo
-#
 # Since: 0.14
 #
 # Example:
@@ -924,8 +912,6 @@
 #
 # Returns information for all memory backends.
 #
-# Returns: a list of @Memdev.
-#
 # Since: 2.1
 #
 # Example:
@@ -1042,8 +1028,6 @@
 #
 # TODO: Better documentation; currently there is none.
 #
-# Returns: a list of HotpluggableCPU objects.
-#
 # Since: 2.7
 #
 # Examples:
@@ -1155,9 +1139,6 @@
 #
 # Return information about the balloon device.
 #
-# Returns:
-#     @BalloonInfo
-#
 # Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
@@ -1221,9 +1202,6 @@
 # Returns the hv-balloon driver data contained in the last received
 # "STATUS" message from the guest.
 #
-# Returns:
-#     @HvBalloonInfo
-#
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
 #       reporting is not enabled or no guest memory status report
@@ -1729,8 +1707,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: interrupt statistics
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-irq',
@@ -1746,8 +1722,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: TCG compiler statistics
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-jit',
@@ -1764,8 +1738,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: topology information
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-numa',
@@ -1781,8 +1753,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: TCG opcode counters
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-opcount',
@@ -1799,8 +1769,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: system ramblock information
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-ramblock',
@@ -1816,8 +1784,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: registered ROMs
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-roms',
@@ -1833,8 +1799,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: USB device information
-#
 # Since: 6.2
 ##
 { 'command': 'x-query-usb',
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..e22645253c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -305,8 +305,6 @@
 # status and if block migration is active another one with block
 # migration status.
 #
-# Returns: @MigrationInfo
-#
 # Since: 0.14
 #
 # Examples:
@@ -597,8 +595,6 @@
 #
 # Returns information about the current migration capabilities status
 #
-# Returns: @MigrationCapabilityStatus
-#
 # Since: 1.2
 #
 # Example:
@@ -1412,8 +1408,6 @@
 #
 # Returns information about the current migration parameters
 #
-# Returns: @MigrationParameters
-#
 # Since: 2.4
 #
 # Example:
@@ -1997,8 +1991,6 @@
 #
 # Query replication status while the vm is running.
 #
-# Returns: A @ReplicationStatus object showing the status.
-#
 # Example:
 #
 #     -> { "execute": "query-xen-replication-status" }
@@ -2051,8 +2043,6 @@
 #
 # Query COLO status while the vm is running.
 #
-# Returns: A @COLOStatus object showing the status.
-#
 # Example:
 #
 #     -> { "execute": "query-colo-status" }
@@ -2419,8 +2409,6 @@
 #
 # Returns information of migration threads
 #
-# Returns: @MigrationThreadInfo
-#
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 4e0a6492a9..9edb7c1ade 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -85,8 +85,6 @@
 #
 # Returns information about SEV
 #
-# Returns: @SevInfo
-#
 # Since: 2.12
 #
 # Example:
@@ -116,8 +114,6 @@
 #
 # Query the SEV guest launch information.
 #
-# Returns: The @SevLaunchMeasureInfo for the guest
-#
 # Since: 2.12
 #
 # Example:
@@ -161,8 +157,6 @@
 # This command is used to get the SEV capabilities, and is supported
 # on AMD X86 platforms only.
 #
-# Returns: SevCapability objects.
-#
 # Since: 2.12
 #
 # Example:
@@ -215,8 +209,6 @@
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
-# Returns: SevAttestationReport objects.
-#
 # Since: 6.1
 #
 # Example:
@@ -280,8 +272,6 @@
 # This command is ARM-only.  It will return a list of GICCapability
 # objects that describe its capability bits.
 #
-# Returns: a list of GICCapability objects.
-#
 # Since: 2.6
 #
 # Example:
@@ -338,8 +328,6 @@
 #
 # Returns information about SGX
 #
-# Returns: @SGXInfo
-#
 # Since: 6.2
 #
 # Example:
@@ -357,8 +345,6 @@
 #
 # Returns information from host SGX capabilities
 #
-# Returns: @SGXInfo
-#
 # Since: 6.2
 #
 # Example:
@@ -432,8 +418,6 @@
 #
 # Query the Xen event channels opened by the guest.
 #
-# Returns: list of open event channel ports.
-#
 # Since: 8.0
 #
 # Example:
diff --git a/qapi/misc.json b/qapi/misc.json
index ec30e5c570..ab2d234973 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -56,8 +56,6 @@
 #
 # Return the name information of a guest.
 #
-# Returns: @NameInfo of the guest
-#
 # Since: 0.14
 #
 # Example:
@@ -101,14 +99,12 @@
 ##
 # @query-iothreads:
 #
-# Returns a list of information about each iothread.
+# Returns information about each iothread.
 #
 # Note: this list excludes the QEMU main loop thread, which is not
 #     declared using the -object iothread command-line option.  It is
 #     always the main thread of the process.
 #
-# Returns: a list of @IOThreadInfo for each iothread
-#
 # Since: 2.0
 #
 # Example:
@@ -331,9 +327,6 @@
 #
 # @opaque: A free-form string that can be used to describe the fd.
 #
-# Returns:
-#     @AddfdInfo
-#
 # Errors:
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
@@ -415,8 +408,6 @@
 #
 # Return information describing all fd sets.
 #
-# Returns: A list of @FdsetInfo
-#
 # Since: 1.2
 #
 # Note: The list of fd sets is shared by all monitor connections.
@@ -514,10 +505,7 @@
 #
 # Query command line option schema.
 #
-# @option: option name
-#
-# Returns: list of @CommandLineOptionInfo for all options (or for the
-#     given @option).
+# @option: limit query to just @option
 #
 # Errors:
 #     - if the given @option doesn't exist
diff --git a/qapi/pci.json b/qapi/pci.json
index 08bf695863..6355411373 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -178,7 +178,7 @@
 # Returns: a list of @PciInfo for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
 #     of all PCI devices attached to it.  Each device is represented
-#     by a json-object.
+#     by a json-object.  TODO check
 #
 # Since: 0.14
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index facaa0bc6a..798dc831d5 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -17,9 +17,6 @@
 #
 # @typename: the type name of a device
 #
-# Returns: a list of ObjectPropertyInfo describing a devices
-#     properties
-#
 # Note: objects can create properties at runtime, for example to
 #     describe links between different devices and/or objects.  These
 #     properties are not included in the output of this command.
diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..d1dc216474 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -54,9 +54,6 @@
 # @path: the path within the object model.  See @qom-get for a
 #     description of this parameter.
 #
-# Returns: a list of @ObjectPropertyInfo that describe the properties
-#     of the object.
-#
 # Since: 1.2
 #
 # Example:
@@ -178,9 +175,6 @@
 #
 # @abstract: if true, include abstract types in the results
 #
-# Returns: a list of @ObjectTypeInfo or an empty list if no results
-#     are found
-#
 # Since: 1.1
 ##
 { 'command': 'qom-list-types',
@@ -199,8 +193,6 @@
 #     describe links between different devices and/or objects.  These
 #     properties are not included in the output of this command.
 #
-# Returns: a list of ObjectPropertyInfo describing object properties
-#
 # Since: 2.12
 ##
 { 'command': 'qom-list-properties',
diff --git a/qapi/replay.json b/qapi/replay.json
index d3559f9c8f..e66823bf03 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -50,8 +50,6 @@
 # instruction count which may be used for @replay-break and
 # @replay-seek commands.
 #
-# Returns: record/replay information.
-#
 # Since: 5.2
 #
 # Example:
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5635cf174f..03c42713b4 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -26,8 +26,6 @@
 #
 # Return rocker switch information.
 #
-# Returns: @Rocker information
-#
 # Since: 2.4
 #
 # Example:
@@ -94,8 +92,6 @@
 #
 # Return rocker switch port information.
 #
-# Returns: a list of @RockerPort information
-#
 # Since: 2.4
 #
 # Example:
@@ -236,8 +232,6 @@
 # @tbl-id: flow table ID.  If tbl-id is not specified, returns flow
 #     information for all tables.
 #
-# Returns: rocker OF-DPA flow information
-#
 # Since: 2.4
 #
 # Example:
@@ -311,8 +305,6 @@
 # @type: group type.  If type is not specified, returns group
 #     information for all group types.
 #
-# Returns: rocker OF-DPA group information
-#
 # Since: 2.4
 #
 # Example:
diff --git a/qapi/run-state.json b/qapi/run-state.json
index f8773f23b2..37c30ee3a2 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -119,8 +119,6 @@
 #
 # Query the run status of the VM
 #
-# Returns: @StatusInfo reflecting the VM
-#
 # Since: 0.14
 #
 # Example:
diff --git a/qapi/stats.json b/qapi/stats.json
index 578b52c7ef..0753c11aa2 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -187,7 +187,7 @@
 # to return statistics about.
 #
 # Returns: a list of StatsResult, one for each provider and object
-#     (e.g., for each vCPU).
+#     (e.g., for each vCPU).  TODO check
 #
 # Since: 7.1
 ##
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 1577b5c259..6002a17f0e 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -27,8 +27,6 @@
 #
 # Return a list of supported TPM models
 #
-# Returns: a list of TpmModel
-#
 # Since: 1.5
 #
 # Example:
@@ -58,8 +56,6 @@
 #
 # Return a list of supported TPM types
 #
-# Returns: a list of TpmType
-#
 # Since: 1.5
 #
 # Example:
diff --git a/qapi/trace.json b/qapi/trace.json
index 043d12f83e..27a98fc9d9 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -52,7 +52,8 @@
 #
 # Query the state of events.
 #
-# @name: Event name pattern (case-sensitive glob).
+# @name: Limit the query to events with a name matching @name
+#     (case-sensitive glob).
 #
 # @vcpu: The vCPU to query (since 2.7).
 #
@@ -60,8 +61,6 @@
 #
 # @deprecated: Member @vcpu is deprecated, and always ignored.
 #
-# Returns: a list of @TraceEventInfo for the matching events
-#
 # Since: 2.2
 #
 # Example:
diff --git a/qapi/ui.json b/qapi/ui.json
index f610bce118..2b7f0b8401 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -327,8 +327,6 @@
 #
 # Returns information about the current SPICE server
 #
-# Returns: @SpiceInfo
-#
 # Since: 0.14
 #
 # Example:
@@ -658,8 +656,6 @@
 #
 # Returns information about the current VNC server
 #
-# Returns: @VncInfo
-#
 # Since: 0.14
 #
 # Example:
@@ -689,8 +685,6 @@
 #
 # Returns a list of vnc servers.  The list can be empty.
 #
-# Returns: a list of @VncInfo2
-#
 # Since: 2.3
 ##
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
@@ -824,8 +818,6 @@
 #
 # Returns information about each active mouse device
 #
-# Returns: a list of @MouseInfo for each device
-#
 # Since: 0.14
 #
 # Example:
@@ -1564,8 +1556,6 @@
 #
 # Returns information about display configuration
 #
-# Returns: @DisplayOptions
-#
 # Since: 3.1
 ##
 { 'command': 'query-display-options',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 74fc27c702..476a2a4192 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -30,8 +30,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: List of gathered VirtIODevices
-#
 # Since: 7.2
 #
 # Example:
@@ -199,8 +197,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioStatus of the virtio device
-#
 # Since: 7.2
 #
 # Examples:
@@ -557,8 +553,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtQueueStatus of the VirtQueue
-#
 # Notes: last_avail_idx will not be displayed in the case where the
 #     selected VirtIODevice has a running vhost device and the
 #     VirtIODevice VirtQueue index (queue) does not exist for the
@@ -686,8 +680,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtVhostQueueStatus of the vhost_virtqueue
-#
 # Since: 7.2
 #
 # Examples:
@@ -835,8 +827,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioQueueElement information
-#
 # Since: 7.2
 #
 # Examples:
diff --git a/qapi/yank.json b/qapi/yank.json
index 89f2f4d199..82e3515308 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -102,8 +102,6 @@
 #
 # Query yank instances.  See @YankInstance for more information.
 #
-# Returns: list of @YankInstance
-#
 # Example:
 #
 #     -> { "execute": "query-yank" }
-- 
2.44.0


