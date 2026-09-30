Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2216CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrix-0001Y2-KV; Wed, 30 Sep 2026 06:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBril-0001Km-09
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kQ-FK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flTIP/I6hh8yH5v7PP+cHlkK6wNrd2PO3UMqlV9Yt20=;
 b=Kt9umN8J6LtaI/GN05cHLmoMxb070R1sNzFrMGyPEIpFFN91Ok9Q+GgrIm6bB1yRjw96VX
 nXn8LjD1Fq2DwG6+8StHldtkqzE0RsMGqfLm+LP4wFfOfWnMa73AeQWVegJofiotsJvBuQ
 FfI4Fq/DDfZ3tqO0csV/xngo48Egnt0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-l4_ETusUP2OTDB_59DuHfQ-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: l4_ETusUP2OTDB_59DuHfQ-1
X-Mimecast-MFC-AGG-ID: l4_ETusUP2OTDB_59DuHfQ_1790764762
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563041954B28; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE87F1956045; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 439BC21E6832; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 042/105] qapi: convert trivial intro sections for machine.json
Date: Wed, 30 Sep 2026 12:38:07 +0200
Message-ID: <20260930103910.3934848-43-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260831201945.287730-43-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 195 ++++++++++++++++------------------------------
 1 file changed, 68 insertions(+), 127 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index b1be5608b6..4a1fa6911b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -46,9 +46,8 @@
 
 ##
 # @S390CpuState:
-#
-# An enumeration of cpu states that can be assumed by a virtual S390
-# CPU
+#     An enumeration of cpu states that can be assumed by a virtual
+#     S390 CPU
 #
 # Since: 2.12
 ##
@@ -57,8 +56,7 @@
 
 ##
 # @CpuInfoS390:
-#
-# Additional information about a virtual S390 CPU
+#     Additional information about a virtual S390 CPU
 #
 # @cpu-state: the virtual CPU's state
 #
@@ -75,8 +73,7 @@
 
 ##
 # @CpuInfoFast:
-#
-# Information about a virtual CPU
+#     Information about a virtual CPU
 #
 # @cpu-index: index of the virtual CPU
 #
@@ -105,8 +102,7 @@
 
 ##
 # @query-cpus-fast:
-#
-# Return information about all virtual CPUs.
+#     Return information about all virtual CPUs.
 #
 # Since: 2.12
 #
@@ -143,9 +139,8 @@
 
 ##
 # @CompatProperty:
-#
-# Property default values specific to a machine type, for use by
-# scripts/compare-machine-types.
+#     Property default values specific to a machine type, for use by
+#     scripts/compare-machine-types.
 #
 # @qom-type: name of the QOM type to which the default applies
 #
@@ -163,8 +158,7 @@
 
 ##
 # @MachineInfo:
-#
-# Information describing a machine.
+#     Information describing a machine.
 #
 # @name: the name of the machine
 #
@@ -219,8 +213,7 @@
 
 ##
 # @query-machines:
-#
-# Return a list of supported machines
+#     Return a list of supported machines
 #
 # @compat-props: if true, also return compatibility properties.
 #     (default: false) (since 9.1)
@@ -261,8 +254,7 @@
 
 ##
 # @CurrentMachineParams:
-#
-# Information describing the running machine parameters.
+#     Information describing the running machine parameters.
 #
 # @wakeup-suspend-support: true if the machine supports wake up from
 #     suspend
@@ -274,8 +266,7 @@
 
 ##
 # @query-current-machine:
-#
-# Return information on the current virtual machine.
+#     Return information on the current virtual machine.
 #
 # Since: 4.0
 ##
@@ -283,8 +274,8 @@
 
 ##
 # @QemuTargetInfo:
-#
-# Information on the target configuration built into the QEMU binary.
+#     Information on the target configuration built into the QEMU
+#     binary.
 #
 # @arch: the target architecture
 #
@@ -295,8 +286,7 @@
 
 ##
 # @query-target:
-#
-# Return information about the target for this QEMU
+#     Return information about the target for this QEMU
 #
 # Since: 1.2
 ##
@@ -304,8 +294,7 @@
 
 ##
 # @UuidInfo:
-#
-# Guest UUID information (Universally Unique Identifier).
+#     Guest UUID information (Universally Unique Identifier).
 #
 # @UUID: the UUID of the guest
 #
@@ -318,8 +307,7 @@
 
 ##
 # @query-uuid:
-#
-# Query the guest UUID information.
+#     Query the guest UUID information.
 #
 # Since: 0.14
 #
@@ -332,8 +320,7 @@
 
 ##
 # @GuidInfo:
-#
-# GUID information.
+#     GUID information.
 #
 # @guid: the globally unique identifier
 #
@@ -343,8 +330,7 @@
 
 ##
 # @query-vm-generation-id:
-#
-# Show Virtual Machine Generation ID
+#     Show Virtual Machine Generation ID
 #
 # Since: 2.9
 ##
@@ -352,8 +338,7 @@
 
 ##
 # @system_reset:
-#
-# Performs a hard reset of a guest.
+#     Performs a hard reset of a guest.
 #
 # Since: 0.14
 #
@@ -366,8 +351,7 @@
 
 ##
 # @system_powerdown:
-#
-# Requests that a guest perform a powerdown operation.
+#     Requests that a guest perform a powerdown operation.
 #
 # Since: 0.14
 #
@@ -527,8 +511,7 @@
 
 ##
 # @NumaDistOptions:
-#
-# Set the distance between 2 NUMA nodes.
+#     Set the distance between 2 NUMA nodes.
 #
 # @src: source NUMA node.
 #
@@ -548,8 +531,7 @@
 
 ##
 # @CXLFixedMemoryWindowOptions:
-#
-# Create a CXL Fixed Memory Window
+#     Create a CXL Fixed Memory Window
 #
 # @size: Size of the Fixed Memory Window in bytes.  Must be a multiple
 #     of 256MiB.
@@ -599,8 +581,7 @@
 
 ##
 # @CXLFMWProperties:
-#
-# List of CXL Fixed Memory Windows.
+#     List of CXL Fixed Memory Windows.
 #
 # @cxl-fmw: List of `CXLFixedMemoryWindowOptions`
 #
@@ -612,8 +593,7 @@
 
 ##
 # @X86CPURegister32:
-#
-# A X86 32-bit register
+#     A X86 32-bit register
 #
 # Since: 1.5
 ##
@@ -622,8 +602,7 @@
 
 ##
 # @X86CPUFeatureWordInfo:
-#
-# Information about a X86 CPU feature word
+#     Information about a X86 CPU feature word
 #
 # @cpuid-input-eax: Input EAX value for CPUID instruction for that
 #     feature word
@@ -645,9 +624,8 @@
 
 ##
 # @DummyForceArrays:
-#
-# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
-# internally
+#     Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
+#     internally
 #
 # Since: 2.5
 ##
@@ -829,8 +807,7 @@
 
 ##
 # @memsave:
-#
-# Save a portion of guest memory to a file.
+#     Save a portion of guest memory to a file.
 #
 # @val: the virtual address of the guest to start from
 #
@@ -862,8 +839,7 @@
 
 ##
 # @pmemsave:
-#
-# Save a portion of guest physical memory to a file.
+#     Save a portion of guest physical memory to a file.
 #
 # @val: the physical address of the guest to start from
 #
@@ -891,8 +867,7 @@
 
 ##
 # @Memdev:
-#
-# Information about memory backend
+#     Information about memory backend
 #
 # @id: backend's ID if backend has 'id' property (since 2.9)
 #
@@ -932,8 +907,7 @@
 
 ##
 # @query-memdev:
-#
-# Return information for all memory backends.
+#     Return information for all memory backends.
 #
 # Since: 2.1
 #
@@ -1108,9 +1082,9 @@
 
 ##
 # @set-numa-node:
-#
-# Runtime equivalent of '-numa' CLI option, available at preconfigure
-# stage to configure numa mapping before initializing machine.
+#     Runtime equivalent of '-numa' CLI option, available at
+#     preconfigure stage to configure numa mapping before initializing
+#     machine.
 #
 # Since: 3.0
 ##
@@ -1121,8 +1095,7 @@
 
 ##
 # @balloon:
-#
-# Request the balloon driver to change its balloon size.
+#     Request the balloon driver to change its balloon size.
 #
 # @value: the target logical size of the VM in bytes.  We can deduce
 #     the size of the balloon using this formula:
@@ -1156,8 +1129,7 @@
 
 ##
 # @BalloonInfo:
-#
-# Information about the guest balloon device.
+#     Information about the guest balloon device.
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1168,8 +1140,7 @@
 
 ##
 # @query-balloon:
-#
-# Return information about the balloon device.
+#     Return information about the balloon device.
 #
 # Errors:
 #     - If the balloon driver is enabled but not functional because
@@ -1213,8 +1184,7 @@
 
 ##
 # @HvBalloonInfo:
-#
-# hv-balloon guest-provided memory status information.
+#     hv-balloon guest-provided memory status information.
 #
 # @committed: the amount of memory in use inside the guest plus the
 #     amount of the memory unusable inside the guest (ballooned out,
@@ -1230,9 +1200,8 @@
 
 ##
 # @query-hv-balloon-status-report:
-#
-# Return the hv-balloon driver data contained in the last received
-# "STATUS" message from the guest.
+#     Return the hv-balloon driver data contained in the last received
+#     "STATUS" message from the guest.
 #
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
@@ -1273,8 +1242,7 @@
 
 ##
 # @MemoryInfo:
-#
-# Actual memory information in bytes.
+#     Actual memory information in bytes.
 #
 # @base-memory: size of "base" memory specified with command line
 #     option -m.
@@ -1307,8 +1275,7 @@
 
 ##
 # @PCDIMMDeviceInfo:
-#
-# PCDIMMDevice state information
+#     PCDIMMDevice state information
 #
 # @id: device's ID
 #
@@ -1343,8 +1310,7 @@
 
 ##
 # @VirtioPMEMDeviceInfo:
-#
-# VirtioPMEM state information
+#     VirtioPMEM state information
 #
 # @id: device's ID
 #
@@ -1366,8 +1332,7 @@
 
 ##
 # @VirtioMEMDeviceInfo:
-#
-# VirtioMEMDevice state information
+#     VirtioMEMDevice state information
 #
 # @id: device's ID
 #
@@ -1401,8 +1366,7 @@
 
 ##
 # @SgxEPCDeviceInfo:
-#
-# Sgx EPC state information
+#     Sgx EPC state information
 #
 # @id: device's ID
 #
@@ -1427,8 +1391,7 @@
 
 ##
 # @HvBalloonDeviceInfo:
-#
-# hv-balloon provided memory state information
+#     hv-balloon provided memory state information
 #
 # @id: device's ID
 #
@@ -1557,8 +1520,7 @@
 
 ##
 # @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
+#     Union containing information about a memory device
 #
 # @type: memory device type
 #
@@ -1579,8 +1541,7 @@
 
 ##
 # @SgxEPC:
-#
-# Sgx EPC cmdline information
+#     Sgx EPC cmdline information
 #
 # @memdev: memory backend linked with device
 #
@@ -1596,8 +1557,7 @@
 
 ##
 # @SgxEPCProperties:
-#
-# SGX properties of machine types.
+#     SGX properties of machine types.
 #
 # @sgx-epc: list of ids of memory-backend-epc objects.
 #
@@ -1609,8 +1569,7 @@
 
 ##
 # @query-memory-devices:
-#
-# Lists available memory devices and their state
+#     Lists available memory devices and their state
 #
 # Since: 2.1
 #
@@ -1660,8 +1619,7 @@
 
 ##
 # @BootConfiguration:
-#
-# Schema for virtual machine boot configuration.
+#     Schema for virtual machine boot configuration.
 #
 # @order: Boot order (a=floppy, c=hard disk, d=CD-ROM, n=network)
 #
@@ -1745,8 +1703,7 @@
 
 ##
 # @x-query-irq:
-#
-# Query interrupt statistics
+#     Query interrupt statistics
 #
 # Features:
 #
@@ -1762,8 +1719,7 @@
 
 ##
 # @x-query-jit:
-#
-# Query TCG compiler statistics
+#     Query TCG compiler statistics
 #
 # Features:
 #
@@ -1780,8 +1736,7 @@
 
 ##
 # @x-query-numa:
-#
-# Query NUMA topology information
+#     Query NUMA topology information
 #
 # Features:
 #
@@ -1797,8 +1752,7 @@
 
 ##
 # @x-query-ramblock:
-#
-# Query system ramblock information
+#     Query system ramblock information
 #
 # Features:
 #
@@ -1814,8 +1768,7 @@
 
 ##
 # @x-query-roms:
-#
-# Query information on the registered ROMS
+#     Query information on the registered ROMS
 #
 # Features:
 #
@@ -1831,8 +1784,7 @@
 
 ##
 # @x-query-usb:
-#
-# Query information on the USB devices
+#     Query information on the USB devices
 #
 # Features:
 #
@@ -1863,8 +1815,7 @@
 
 ##
 # @MemorySizeConfiguration:
-#
-# Schema for memory size configuration.
+#     Schema for memory size configuration.
 #
 # @size: memory size in bytes
 #
@@ -1881,8 +1832,7 @@
 
 ##
 # @dumpdtb:
-#
-# Save the FDT in dtb format.
+#     Save the FDT in dtb format.
 #
 # @filename: name of the dtb file to be created
 #
@@ -1900,8 +1850,7 @@
 
 ##
 # @x-query-interrupt-controllers:
-#
-# Query information on interrupt controller devices
+#     Query information on interrupt controller devices
 #
 # Features:
 #
@@ -1931,8 +1880,7 @@
 
 ##
 # @query-firmware-log:
-#
-# Find firmware memory log buffer in guest memory, return content.
+#     Find firmware memory log buffer in guest memory, return content.
 #
 # @max-size: limit the amount of log data returned.  Up to 1 MiB of
 #     log data is allowed.  In case the amount of log data is larger
@@ -1946,8 +1894,7 @@
 
 ##
 # @dump-skeys:
-#
-# Dump the storage keys for an s390x guest
+#     Dump the storage keys for an s390x guest
 #
 # @filename: the path to the file to dump to
 #
@@ -1985,8 +1932,7 @@
 
 ##
 # @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
+#     An enumeration of CPU model expansion types.
 #
 # @static: Expand to a static CPU model, a combination of a static
 #     base model name and property delta changes.  As the static base
@@ -2043,8 +1989,7 @@
 
 ##
 # @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
+#     The result of a CPU model baseline.
 #
 # @model: the baselined `CpuModelInfo`.
 #
@@ -2055,8 +2000,7 @@
 
 ##
 # @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
+#     The result of a CPU model comparison.
 #
 # @result: The result of the compare operation.
 #
@@ -2187,8 +2131,7 @@
 
 ##
 # @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
+#     The result of a cpu model expansion.
 #
 # @model: the expanded `CpuModelInfo`.
 #
@@ -2257,8 +2200,7 @@
 
 ##
 # @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
+#     Virtual CPU definition.
 #
 # @name: the name of the CPU definition
 #
@@ -2319,8 +2261,7 @@
 
 ##
 # @query-cpu-definitions:
-#
-# Return a list of supported virtual CPU definitions
+#     Return a list of supported virtual CPU definitions
 #
 # Since: 1.2
 ##
-- 
2.55.0


