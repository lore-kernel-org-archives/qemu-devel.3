Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38EEC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1sg-0005b6-E1; Mon, 04 Mar 2024 01:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sW-0005YG-RO
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-000083-Bd
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MgM1k7X1o4w5pqerdPU9z26qKfE16Q0If0WZAOUvIs=;
 b=BAy9lWJQJnQC+jastxAx6TAbpR2VdPZ3BpLtJireUaUR8DXoR/VVtGfXt/ZcFMBZPB38i+
 96prXqhwJj3ONBPS3xOXIgzOz79wJ18iXoPH/o39yjpQSVAJxdKtnYg6koiXTi/W5D2YeF
 a2Wrx8zG6W2Bhmh72YAPUcmi/fpicj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-R_2ccEZAMJuhSFKNSgxLRg-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: R_2ccEZAMJuhSFKNSgxLRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CC5C846D5D;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE662166B36;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 797C121E6889; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 05/18] qapi: Delete useless "Returns" sections
Date: Mon,  4 Mar 2024 07:32:23 +0100
Message-ID: <20240304063236.213955-6-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-6-armbru@redhat.com>
---
 qapi/block-core.json     | 66 ----------------------------------------
 qapi/block.json          |  6 ----
 qapi/char.json           |  6 ----
 qapi/dump.json           |  2 --
 qapi/machine-target.json |  2 --
 qapi/machine.json        | 11 -------
 qapi/migration.json      | 26 ----------------
 qapi/misc-target.json    |  3 --
 qapi/misc.json           | 15 ---------
 qapi/net.json            |  9 ------
 qapi/qdev.json           |  3 --
 qapi/qom.json            |  6 ----
 qapi/run-state.json      |  5 +--
 qapi/tpm.json            |  2 --
 qapi/transaction.json    |  2 --
 qapi/ui.json             | 17 -----------
 qapi/yank.json           |  3 --
 17 files changed, 1 insertion(+), 183 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cea46b4668..94b01deffc 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1456,9 +1456,6 @@
 #
 # @size: new image size in bytes
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -1676,9 +1673,6 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshotSync.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -1758,9 +1752,6 @@
 #     is not validated, so care should be taken when specifying the
 #     string or the image chain may not be able to be reopened again.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If "device" does not exist or cannot be determined,
 #       DeviceNotFound
@@ -1860,9 +1851,6 @@
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
 #     and @top-node instead.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @device does not exist, DeviceNotFound
 #     - Any other error returns a GenericError.
@@ -1902,9 +1890,6 @@
 # @deprecated: This command is deprecated.  Use @blockdev-backup
 #     instead.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #
@@ -1931,9 +1916,6 @@
 # 'backup'. The operation can be stopped before it has completed using
 # the block-job-cancel command.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -2139,9 +2121,6 @@
 # specifies the format of the mirror image, default is to probe if
 # mode='existing', else the format of the source.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #
@@ -2318,9 +2297,6 @@
 # Create a dirty bitmap with a name on the node, and start tracking
 # the writes.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
 #     - If @name is already taken, GenericError with an explanation
@@ -2344,9 +2320,6 @@
 # with block-dirty-bitmap-add.  If the bitmap is persistent, remove it
 # from its storage too.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
@@ -2371,9 +2344,6 @@
 # backup from this point in time forward will only backup clusters
 # modified after this clear operation.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
@@ -2395,9 +2365,6 @@
 #
 # Enables a dirty bitmap so that it will begin tracking disk changes.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
@@ -2419,9 +2386,6 @@
 #
 # Disables a dirty bitmap so that it will stop tracking disk changes.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found, GenericError with an explanation
@@ -2451,9 +2415,6 @@
 # dirty in any of the source bitmaps.  This can be used to achieve
 # backup checkpoints, or in simpler usages, to copy bitmaps.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If any bitmap in @bitmaps or @target is not found,
@@ -2570,8 +2531,6 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
-# Returns: nothing on success.
-#
 # Since: 2.6
 #
 # Example:
@@ -2894,9 +2853,6 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
-# Returns:
-#     - Nothing on success.
-#
 # Errors:
 #     - If @device does not exist, DeviceNotFound.
 #
@@ -2935,9 +2891,6 @@
 # @speed: the maximum speed, in bytes per second, or 0 for unlimited.
 #     Defaults to 0.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -2982,9 +2935,6 @@
 #     paused) instead of waiting for the destination to complete its
 #     final synchronization (since 1.3)
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -3011,9 +2961,6 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -3038,9 +2985,6 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -3072,9 +3016,6 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -3099,8 +3040,6 @@
 #
 # @id: The job identifier.
 #
-# Returns: Nothing on success
-#
 # Since: 2.12
 ##
 { 'command': 'block-job-dismiss', 'data': { 'id': 'str' },
@@ -3118,8 +3057,6 @@
 #
 # @id: The job identifier.
 #
-# Returns: Nothing on success
-#
 # Since: 2.12
 ##
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
@@ -6110,9 +6047,6 @@
 # For the arguments, see the documentation of
 # BlockdevSnapshotInternal.
 #
-# Returns:
-#     - nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If any snapshot matching @name exists, or @name is empty,
diff --git a/qapi/block.json b/qapi/block.json
index dab616799a..65d9804bdf 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -110,9 +110,6 @@
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -461,9 +458,6 @@
 # the device will be removed from its group and the rest of its
 # members will not be affected.  The 'group' parameter is ignored.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
diff --git a/qapi/char.json b/qapi/char.json
index 4873bc635a..777dde55d9 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -139,8 +139,6 @@
 #     - data itself is always Unicode regardless of format, like any
 #       other string.
 #
-# Returns: Nothing on success
-#
 # Since: 1.4
 #
 # Example:
@@ -772,8 +770,6 @@
 #
 # @id: the chardev's ID, must exist and not be in use
 #
-# Returns: Nothing on success
-#
 # Since: 1.4
 #
 # Example:
@@ -791,8 +787,6 @@
 #
 # @id: the chardev's ID, must exist
 #
-# Returns: Nothing on success
-#
 # Since: 2.10
 #
 # Example:
diff --git a/qapi/dump.json b/qapi/dump.json
index f82dd6a1af..4c021dd53c 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -92,8 +92,6 @@
 #
 # Note: All boolean arguments default to false
 #
-# Returns: nothing on success
-#
 # Since: 1.2
 #
 # Example:
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index db6c0fae98..519adf3220 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -414,8 +414,6 @@
 #
 # @unstable: This command is experimental.
 #
-# Returns: Nothing on success.
-#
 # Since: 8.2
 ##
 { 'command': 'set-cpu-topology',
diff --git a/qapi/machine.json b/qapi/machine.json
index 0985c61740..7d3ca33683 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -326,8 +326,6 @@
 #
 # Since: 1.1
 #
-# Returns: nothing.
-#
 # Note: prior to 4.0, this command does nothing in case the guest
 #     isn't suspended.
 #
@@ -377,8 +375,6 @@
 # all CPUs (ppc64). The command fails when the guest doesn't support
 # injecting.
 #
-# Returns: If successful, nothing
-#
 # Since: 0.14
 #
 # Note: prior to 2.1, this command was only supported for x86 and s390
@@ -778,8 +774,6 @@
 # @cpu-index: the index of the virtual CPU to use for translating the
 #     virtual address (defaults to CPU 0)
 #
-# Returns: Nothing on success
-#
 # Since: 0.14
 #
 # Notes: Errors were not reliably returned until 1.1
@@ -806,8 +800,6 @@
 #
 # @filename: the file to save the memory to as binary data
 #
-# Returns: Nothing on success
-#
 # Since: 0.14
 #
 # Notes: Errors were not reliably returned until 1.1
@@ -1060,9 +1052,6 @@
 #
 #     From it we have: balloon_size = vm_ram_size - @value
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
diff --git a/qapi/migration.json b/qapi/migration.json
index 0b33a71ab4..27a67e5012 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1566,8 +1566,6 @@
 #
 # Cancel the current executing migration process.
 #
-# Returns: nothing on success
-#
 # Notes: This command succeeds even if there is no migration process
 #     running.
 #
@@ -1587,8 +1585,6 @@
 #
 # @state: The state the migration is currently expected to be in
 #
-# Returns: nothing on success
-#
 # Since: 2.11
 #
 # Example:
@@ -1710,8 +1706,6 @@
 # @deprecated: Members @inc and @blk are deprecated.  Use
 #     blockdev-mirror with NBD instead.
 #
-# Returns: nothing on success
-#
 # Since: 0.14
 #
 # Notes:
@@ -1793,8 +1787,6 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
-# Returns: nothing on success
-#
 # Since: 2.3
 #
 # Notes:
@@ -1862,8 +1854,6 @@
 # @live: Optional argument to ask QEMU to treat this command as part
 #     of a live migration.  Default to true.  (since 2.11)
 #
-# Returns: Nothing on success
-#
 # Since: 1.1
 #
 # Example:
@@ -1882,8 +1872,6 @@
 #
 # @enable: true to enable, false to disable.
 #
-# Returns: nothing
-#
 # Since: 1.3
 #
 # Example:
@@ -1926,8 +1914,6 @@
 # @failover: true to do failover, false to stop.  but cannot be
 #     specified if 'enable' is true.  default value is false.
 #
-# Returns: nothing.
-#
 # Example:
 #
 #     -> { "execute": "xen-set-replication",
@@ -1979,8 +1965,6 @@
 #
 # Xen uses this command to notify replication to trigger a checkpoint.
 #
-# Returns: nothing.
-#
 # Example:
 #
 #     -> { "execute": "xen-colo-do-checkpoint" }
@@ -2037,8 +2021,6 @@
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
-# Returns: nothing.
-#
 # Example:
 #
 #     -> { "execute": "migrate-recover",
@@ -2056,8 +2038,6 @@
 #
 # Pause a migration.  Currently it only supports postcopy.
 #
-# Returns: nothing.
-#
 # Example:
 #
 #     -> { "execute": "migrate-pause" }
@@ -2426,8 +2406,6 @@
 #
 # If @tag already exists, an error will be reported
 #
-# Returns: nothing
-#
 # Example:
 #
 #     -> { "execute": "snapshot-save",
@@ -2498,8 +2476,6 @@
 # device nodes that can have changed since the original @snapshot-save
 # command execution.
 #
-# Returns: nothing
-#
 # Example:
 #
 #     -> { "execute": "snapshot-load",
@@ -2561,8 +2537,6 @@
 # to determine completion and to fetch details of any errors that
 # arise.
 #
-# Returns: nothing
-#
 # Example:
 #
 #     -> { "execute": "snapshot-delete",
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 542a3e42f2..4e0a6492a9 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -472,9 +472,6 @@
 #
 # @port: The port number
 #
-# Returns:
-#     - Nothing on success.
-#
 # Since: 8.0
 #
 # Example:
diff --git a/qapi/misc.json b/qapi/misc.json
index 578f574a68..015388aa3e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -28,8 +28,6 @@
 #
 # @tls: whether to perform TLS. Only applies to the "spice" protocol
 #
-# Returns: nothing on success.
-#
 # Since: 0.14
 #
 # Example:
@@ -160,8 +158,6 @@
 #
 # Since: 0.14
 #
-# Returns: If successful, nothing
-#
 # Notes: This command will succeed if the guest is currently running.
 #     It will also succeed if the guest is in the "inmigrate" state;
 #     in this case, the effect of the command is to make sure the
@@ -196,8 +192,6 @@
 #
 # Since: 3.0
 #
-# Returns: nothing
-#
 # Example:
 #
 #     -> { "execute": "x-exit-preconfig" }
@@ -256,8 +250,6 @@
 #
 # @fdname: file descriptor name
 #
-# Returns: Nothing on success
-#
 # Since: 0.14
 #
 # Notes: If @fdname already exists, the file descriptor assigned to it
@@ -285,8 +277,6 @@
 #
 # @fdname: file descriptor name
 #
-# Returns: Nothing on success
-#
 # Since: 8.0
 #
 # Notes: If @fdname already exists, the file descriptor assigned to it
@@ -309,8 +299,6 @@
 #
 # @fdname: file descriptor name
 #
-# Returns: Nothing on success
-#
 # Since: 0.14
 #
 # Example:
@@ -376,9 +364,6 @@
 #
 # @fd: The file descriptor that is to be removed.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @fdset-id or @fd is not found, GenericError
 #
diff --git a/qapi/net.json b/qapi/net.json
index 09e644a742..417b61a321 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -17,9 +17,6 @@
 #
 # @up: true to set the link status to be up
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @name is not a valid network device, DeviceNotFound
 #
@@ -46,9 +43,6 @@
 #
 # Since: 0.14
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @type is not a valid network backend, DeviceNotFound
 #
@@ -69,9 +63,6 @@
 #
 # @id: the name of the network backend to remove
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @id is not a valid network backend, DeviceNotFound
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index cc72c55a99..facaa0bc6a 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -89,9 +89,6 @@
 #
 # @id: the device's ID or QOM path
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @id is not a valid device, DeviceNotFound
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 33aa30bb41..032c6fa037 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1056,9 +1056,6 @@
 #
 # Create a QOM object.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - Error if @qom-type is not a valid class name
 #
@@ -1081,9 +1078,6 @@
 #
 # @id: the name of the QOM object to remove
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - Error if @id is not a valid id for a QOM object
 #
diff --git a/qapi/run-state.json b/qapi/run-state.json
index dd0770b379..789fc34559 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -395,10 +395,7 @@
 #
 # @panic: @PanicAction action taken on guest panic.
 #
-# @watchdog: @WatchdogAction action taken when watchdog timer expires
-#     .
-#
-# Returns: Nothing on success.
+# @watchdog: @WatchdogAction action taken when watchdog timer expires.
 #
 # Since: 6.0
 #
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 07a73e5f2b..1577b5c259 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -166,8 +166,6 @@
 #
 # Return information about the TPM device
 #
-# Returns: @TPMInfo on success
-#
 # Since: 1.5
 #
 # Example:
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 78cc21800d..5749c133d4 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -234,8 +234,6 @@
 #     execution of the transaction.  See @TransactionProperties for
 #     additional detail.
 #
-# Returns: nothing on success
-#
 # Errors:
 #     Any errors from commands in the transaction
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 199a412c5a..1726f15429 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -78,9 +78,6 @@
 #
 # Set the password of a remote display server.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If Spice is not enabled, DeviceNotFound
 #
@@ -142,9 +139,6 @@
 #
 # Expire the password of a remote display server.
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If @protocol is 'spice' and Spice is not active,
 #       DeviceNotFound
@@ -191,8 +185,6 @@
 #
 # @format: image format for screendump.  (default: ppm) (Since 7.1)
 #
-# Returns: Nothing on success
-#
 # Since: 0.14
 #
 # Example:
@@ -1040,9 +1032,6 @@
 # @hold-time: time to delay key up events, milliseconds.  Defaults to
 #     100
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - If key is unknown or redundant, GenericError
 #
@@ -1265,8 +1254,6 @@
 #
 # @events: List of InputEvent union.
 #
-# Returns: Nothing on success.
-#
 # Since: 2.6
 #
 # Note: The consoles are visible in the qom tree, under
@@ -1611,8 +1598,6 @@
 #
 # Reload display configuration.
 #
-# Returns: Nothing on success.
-#
 # Since: 6.0
 #
 # Example:
@@ -1670,8 +1655,6 @@
 #
 # Update display configuration.
 #
-# Returns: Nothing on success.
-#
 # Since: 7.1
 #
 # Example:
diff --git a/qapi/yank.json b/qapi/yank.json
index a457284b45..fffb39a397 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -78,9 +78,6 @@
 #
 # @instances: the instances to be yanked
 #
-# Returns:
-#     - Nothing on success
-#
 # Errors:
 #     - @DeviceNotFound error, if any of the YankInstances doesn't exist
 #
-- 
2.44.0


