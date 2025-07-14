Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B995C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKr3-0007vP-EJ; Mon, 14 Jul 2025 11:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUl-0000NL-On
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUV-0003bt-2v
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhCWOsCJQu/PbM9sZns9WWGN2ELPWKJIuy/7qnAHGv4=;
 b=O4mLqIVNHDJ+kWbj66vx0pxm+6mgT5HsUjf/VILLZnwmWKEPSPMhGuKGsU//Hr8jJ6L8E3
 Lysv7B2TX/PAJkoPNYjk8lYjCSWNpaLpHZLvOYJnYkDV0y/GFs9urPErpZnJfizpB+Otvz
 fnweZ251TmmmcpYnucszclEUSAVvySk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-54Oys21MOaWvm8Lgs7Xezg-1; Mon,
 14 Jul 2025 09:45:07 -0400
X-MC-Unique: 54Oys21MOaWvm8Lgs7Xezg-1
X-Mimecast-MFC-AGG-ID: 54Oys21MOaWvm8Lgs7Xezg_1752500706
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46BDB1956048
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19F601977029
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF5D221E6741; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 10/32] qapi: remove trivial "Returns:" sections
Date: Mon, 14 Jul 2025 15:44:36 +0200
Message-ID: <20250714134458.2991097-11-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

The new qapidoc.py can generate "Returns" statements with type
information just fine, so we can remove it from the source where it
doesn't add anything particularly novel or helpful and just repeats the
type info.

This patch is fairly "gentle" and doesn't aggressively touch other
"Returns" lines that could be rephrased to omit repeating type
information; it only removes lines that appear appropriate to wholly
remove.

To help facilitate auto-generated placement, a few doc blocks have a
"TODO:" line inserted to help the placement algorithm differentiate the
introductory paragraph(s) from the rest of the documentation.

The auto-generated returns are in the exact same spot, except for
query-migrationthreads, query-machines, and
x-query-virtio-queue-element.  These auto-generation moves to a better
spot.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711051045.51110-4-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Two more Returns: removed, commit message amended to explain
auto-generated returns generated into a different spot]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/audio.json      |  2 --
 qapi/block-core.json |  8 --------
 qapi/char.json       |  8 --------
 qapi/cryptodev.json  |  2 --
 qapi/machine.json    | 24 ------------------------
 qapi/migration.json  | 12 ++----------
 qapi/misc-arm.json   |  2 --
 qapi/misc-i386.json  | 10 ----------
 qapi/misc.json       |  7 -------
 qapi/rocker.json     |  4 ----
 qapi/run-state.json  |  2 --
 qapi/tpm.json        |  4 ----
 qapi/ui.json         |  8 --------
 qapi/virtio.json     |  2 --
 qapi/yank.json       |  2 +-
 15 files changed, 3 insertions(+), 94 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 6a22ca384a..53142080f7 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -537,8 +537,6 @@
 #
 # Return information about audiodev configuration
 #
-# Returns: array of @Audiodev
-#
 # Since: 8.0
 ##
 { 'command': 'query-audiodevs',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8b413946ff..01bf41b8b0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1951,8 +1951,6 @@
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
 #
-# Returns: the list of BlockDeviceInfo
-#
 # Since: 2.0
 #
 # .. qmp-example::
@@ -2465,9 +2463,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns:
-#     BlockDirtyBitmapSha256
-#
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
 #     - If @name is not found or if hashing has failed, GenericError
@@ -6203,9 +6198,6 @@
 #
 # @name: optional the snapshot's name to be deleted
 #
-# Returns:
-#     SnapshotInfo
-#
 # Errors:
 #     - If @device is not a valid block device, GenericError
 #     - If snapshot not found, GenericError
diff --git a/qapi/char.json b/qapi/char.json
index f38d04986d..f0a53f742c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -38,8 +38,6 @@
 #
 # Return information about current character devices.
 #
-# Returns: a list of @ChardevInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -84,8 +82,6 @@
 #
 # Return information about character device backends.
 #
-# Returns: a list of @ChardevBackendInfo
-#
 # Since: 2.0
 #
 # .. qmp-example::
@@ -774,8 +770,6 @@
 #
 # @backend: backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 1.4
 #
 # .. qmp-example::
@@ -814,8 +808,6 @@
 #
 # @backend: new backend type and parameters
 #
-# Returns: ChardevReturn.
-#
 # Since: 2.10
 #
 # .. qmp-example::
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 1f49e1822c..eb309c22f8 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -98,8 +98,6 @@
 #
 # Return information about current crypto devices.
 #
-# Returns: a list of @QCryptodevInfo
-#
 # Since: 8.0
 ##
 { 'command': 'query-cryptodev', 'returns': ['QCryptodevInfo']}
diff --git a/qapi/machine.json b/qapi/machine.json
index 2d6a137f21..2364893cba 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -103,8 +103,6 @@
 #
 # Return information about all virtual CPUs.
 #
-# Returns: list of @CpuInfoFast
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -220,8 +218,6 @@
 #
 # @unstable: Argument @compat-props is experimental.
 #
-# Returns: a list of MachineInfo
-#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -270,8 +266,6 @@
 #
 # Return information on the current virtual machine.
 #
-# Returns: CurrentMachineParams
-#
 # Since: 4.0
 ##
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
@@ -293,8 +287,6 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: QemuTargetInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
@@ -318,8 +310,6 @@
 #
 # Query the guest UUID information.
 #
-# Returns: The @UuidInfo for the guest
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -471,8 +461,6 @@
 #
 # Return information about KVM acceleration
 #
-# Returns: @KvmInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -934,8 +922,6 @@
 #
 # Return information for all memory backends.
 #
-# Returns: a list of @Memdev.
-#
 # Since: 2.1
 #
 # .. qmp-example::
@@ -1051,8 +1037,6 @@
 #
 # TODO: Better documentation; currently there is none.
 #
-# Returns: a list of HotpluggableCPU objects.
-#
 # Since: 2.7
 #
 # .. qmp-example::
@@ -1174,9 +1158,6 @@
 #
 # Return information about the balloon device.
 #
-# Returns:
-#     @BalloonInfo
-#
 # Errors:
 #     - If the balloon driver is enabled but not functional because
 #       the KVM kernel module cannot support it, KVMMissingCap
@@ -1240,9 +1221,6 @@
 # Return the hv-balloon driver data contained in the last received
 # "STATUS" message from the guest.
 #
-# Returns:
-#     @HvBalloonInfo
-#
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
 #       reporting is not enabled or no guest memory status report
@@ -2260,8 +2238,6 @@
 #
 # Return a list of supported virtual CPU definitions
 #
-# Returns: a list of CpuDefinitionInfo
-#
 # Since: 1.2
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
diff --git a/qapi/migration.json b/qapi/migration.json
index 3bf97df5d8..57653160eb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -326,8 +326,6 @@
 # is active there will be another json-object with RAM migration
 # status.
 #
-# Returns: @MigrationInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -577,8 +575,6 @@
 #
 # Return information about the current migration capabilities status
 #
-# Returns: @MigrationCapabilityStatus
-#
 # Since: 1.2
 #
 # .. qmp-example::
@@ -1364,8 +1360,6 @@
 #
 # Return information about the current migration parameters
 #
-# Returns: @MigrationParameters
-#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -1946,7 +1940,7 @@
 #
 # Query replication status while the vm is running.
 #
-# Returns: A @ReplicationStatus object showing the status.
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
@@ -2000,7 +1994,7 @@
 #
 # Query COLO status while the vm is running.
 #
-# Returns: A @COLOStatus object showing the status.
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
@@ -2375,8 +2369,6 @@
 #
 # @deprecated: This command is deprecated with no replacement yet.
 #
-# Returns: @MigrationThreadInfo
-#
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f5341372f5..f9dd743b52 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -36,8 +36,6 @@
 # On non-ARM targets this command will report an error as the GIC
 # technology is not applicable.
 #
-# Returns: a list of GICCapability objects.
-#
 # Since: 2.6
 #
 # .. qmp-example::
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 24a2e143f6..5c3c9a14e0 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -132,8 +132,6 @@
 # @enabled field is set to 'false' and the state of all other fields
 # is unspecified.
 #
-# Returns: @SevInfo
-#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -214,8 +212,6 @@
 #
 # This is only supported on AMD X86 platforms with KVM enabled.
 #
-# Returns: SevCapability objects.
-#
 # Errors:
 #     - If SEV is not available on the platform, GenericError
 #
@@ -280,8 +276,6 @@
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
-# Returns: SevAttestationReport objects.
-#
 # Errors:
 #     - If the attestation report is unavailable, either due to an
 #       invalid guest configuration or because the guest has not
@@ -343,8 +337,6 @@
 #
 # Return information about configured SGX capabilities of guest
 #
-# Returns: @SgxInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
@@ -362,8 +354,6 @@
 #
 # Return information about SGX capabilities of host
 #
-# Returns: @SgxInfo
-#
 # Since: 6.2
 #
 # .. qmp-example::
diff --git a/qapi/misc.json b/qapi/misc.json
index a180c16db2..b19eb08606 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -58,8 +58,6 @@
 #
 # Return the name information of a guest.
 #
-# Returns: @NameInfo of the guest
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -334,9 +332,6 @@
 #
 # @opaque: A free-form string that can be used to describe the fd.
 #
-# Returns:
-#     @AddfdInfo
-#
 # Errors:
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
@@ -417,8 +412,6 @@
 #
 # Return information describing all fd sets.
 #
-# Returns: A list of @FdsetInfo
-#
 # Since: 1.2
 #
 # .. note:: The list of fd sets is shared by all monitor connections.
diff --git a/qapi/rocker.json b/qapi/rocker.json
index e494964952..5d2dbd2603 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -30,8 +30,6 @@
 #
 # @name: switch name
 #
-# Returns: @Rocker information
-#
 # Since: 2.4
 #
 # .. qmp-example::
@@ -100,8 +98,6 @@
 #
 # @name: port name
 #
-# Returns: a list of @RockerPort information
-#
 # Since: 2.4
 #
 # .. qmp-example::
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 083a3c5eb3..76f14569ff 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -121,8 +121,6 @@
 #
 # Query the run status of the VM
 #
-# Returns: @StatusInfo reflecting the VM
-#
 # Since: 0.14
 #
 # .. qmp-example::
diff --git a/qapi/tpm.json b/qapi/tpm.json
index e66b107f1d..3f2850a573 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -29,8 +29,6 @@
 #
 # Return a list of supported TPM models
 #
-# Returns: a list of TpmModel
-#
 # Since: 1.5
 #
 # .. qmp-example::
@@ -60,8 +58,6 @@
 #
 # Return a list of supported TPM types
 #
-# Returns: a list of TpmType
-#
 # Since: 1.5
 #
 # .. qmp-example::
diff --git a/qapi/ui.json b/qapi/ui.json
index f5e77ae19d..53489ab65f 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -328,8 +328,6 @@
 #
 # Return information about the current SPICE server
 #
-# Returns: @SpiceInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -660,8 +658,6 @@
 #
 # Return information about the current VNC server
 #
-# Returns: @VncInfo
-#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -691,8 +687,6 @@
 #
 # Return a list of vnc servers.  The list can be empty.
 #
-# Returns: a list of @VncInfo2
-#
 # Since: 2.3
 ##
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
@@ -1570,8 +1564,6 @@
 #
 # Return information about display configuration
 #
-# Returns: @DisplayOptions
-#
 # Since: 3.1
 ##
 { 'command': 'query-display-options',
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 3cac0774f7..f0753cde71 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -849,8 +849,6 @@
 #
 # @unstable: This command is meant for debugging.
 #
-# Returns: VirtioQueueElement information
-#
 # Since: 7.2
 #
 # .. qmp-example::
diff --git a/qapi/yank.json b/qapi/yank.json
index d13a8e9117..c14de5229e 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -104,7 +104,7 @@
 #
 # Query yank instances.  See @YankInstance for more information.
 #
-# Returns: list of @YankInstance
+# TODO: This line is a hack to separate the example from the body
 #
 # .. qmp-example::
 #
-- 
2.49.0


