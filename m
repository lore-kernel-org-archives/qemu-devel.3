Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7ECCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBris-0001S7-Iv; Wed, 30 Sep 2026 06:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrim-0001Lz-33
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kw-QD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGR4Tyfx7QhGKadtxr4UMZx3zvJWBxzi9RE3Zu7aoSw=;
 b=Kszbb8cyl2J2rW2mxKKj6K5qEq5Cr1h99YhdavfvezH/eFWuOh50fh/XwB8IzNbEQn4LBi
 bXDjuF+omOewYrRMSp+ncb3201PNXDNPropmfSBfhPBaPCXILKnzVQGjXpmyYXtzXuQ+2i
 bIlOR5e+gMaygo3ioDC2h3O1l5mR6CE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-sRYkU_HqNS-MYgdsnFkpKg-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: sRYkU_HqNS-MYgdsnFkpKg-1
X-Mimecast-MFC-AGG-ID: sRYkU_HqNS-MYgdsnFkpKg_1790764762
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55F54195F158; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C92421800586; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 370E121E6821; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 039/105] qapi: convert trivial intro sections for qom.json
Date: Wed, 30 Sep 2026 12:38:04 +0200
Message-ID: <20260930103910.3934848-40-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260831201945.287730-40-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json | 150 +++++++++++++++++---------------------------------
 1 file changed, 51 insertions(+), 99 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 5895c97750..59e523e3bf 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -77,8 +77,7 @@
 
 ##
 # @qom-list:
-#
-# List properties of a object given a path in the object model.
+#     List properties of a object given a path in the object model.
 #
 # @path: the path within the object model.  See `qom-get` for a
 #     description of this parameter.
@@ -103,8 +102,7 @@
 
 ##
 # @qom-get:
-#
-# Get a property value.
+#     Get a property value.
 #
 # @path: The path within the object model.  There are two forms of
 #     supported paths--absolute and partial paths.
@@ -154,9 +152,8 @@
 
 ##
 # @qom-list-get:
-#
-# List properties and their values for each object path in the input
-# list.
+#     List properties and their values for each object path in the
+#     input list.
 #
 # @paths: The absolute or partial path for each object, as described
 #     in `qom-get`.
@@ -176,8 +173,7 @@
 
 ##
 # @qom-set:
-#
-# Set a property value.
+#     Set a property value.
 #
 # @path: see `qom-get` for a description of this parameter
 #
@@ -202,8 +198,7 @@
 
 ##
 # @ObjectTypeInfo:
-#
-# This structure describes a search result from `qom-list-types`
+#     This structure describes a search result from `qom-list-types`
 #
 # @name: the type name found in the search
 #
@@ -225,8 +220,7 @@
 
 ##
 # @qom-list-types:
-#
-# Return a list of types given search parameters.
+#     Return a list of types given search parameters.
 #
 # @implements: if specified, only return types that implement this
 #     type name
@@ -247,8 +241,7 @@
 
 ##
 # @qom-list-properties:
-#
-# List properties associated with a QOM object.
+#     List properties associated with a QOM object.
 #
 # @typename: the type name of an object
 #
@@ -267,8 +260,7 @@
 
 ##
 # @CanHostSocketcanProperties:
-#
-# Properties for can-host-socketcan objects.
+#     Properties for can-host-socketcan objects.
 #
 # @if: interface name of the host system CAN bus to connect to
 #
@@ -284,8 +276,7 @@
 
 ##
 # @ColoCompareProperties:
-#
-# Properties for colo-compare objects.
+#     Properties for colo-compare objects.
 #
 # @primary_in: name of the character device backend to use for the
 #     primary input (incoming packets are redirected to @outdev)
@@ -332,9 +323,8 @@
 
 ##
 # @CryptodevBackendProperties:
-#
-# Properties for cryptodev-backend and cryptodev-backend-builtin
-# objects.
+#     Properties for cryptodev-backend and cryptodev-backend-builtin
+#     objects.
 #
 # @queues: the number of queues for the cryptodev backend.  Ignored
 #     for cryptodev-backend and must be 1 for
@@ -353,8 +343,7 @@
 
 ##
 # @CryptodevVhostUserProperties:
-#
-# Properties for cryptodev-vhost-user objects.
+#     Properties for cryptodev-vhost-user objects.
 #
 # @chardev: the name of a Unix domain socket character device that
 #     connects to the vhost-user server
@@ -368,8 +357,7 @@
 
 ##
 # @DBusVMStateProperties:
-#
-# Properties for dbus-vmstate objects.
+#     Properties for dbus-vmstate objects.
 #
 # @addr: the name of the DBus bus to connect to
 #
@@ -384,9 +372,8 @@
 
 ##
 # @NetfilterInsert:
-#
-# Indicates where to insert a netfilter relative to a given other
-# filter.
+#     Indicates where to insert a netfilter relative to a given other
+#     filter.
 #
 # @before: insert before the specified filter
 #
@@ -399,8 +386,7 @@
 
 ##
 # @NetfilterProperties:
-#
-# Properties for objects of classes derived from netfilter.
+#     Properties for objects of classes derived from netfilter.
 #
 # @netdev: id of the network device backend to filter
 #
@@ -432,8 +418,7 @@
 
 ##
 # @FilterBufferProperties:
-#
-# Properties for filter-buffer objects.
+#     Properties for filter-buffer objects.
 #
 # @interval: a non-zero interval in microseconds.  All packets
 #     arriving in the given interval are delayed until the end of the
@@ -447,8 +432,7 @@
 
 ##
 # @FilterDumpProperties:
-#
-# Properties for filter-dump objects.
+#     Properties for filter-dump objects.
 #
 # @file: the filename where the dumped packets should be stored
 #
@@ -464,8 +448,7 @@
 
 ##
 # @FilterMirrorProperties:
-#
-# Properties for filter-mirror objects.
+#     Properties for filter-mirror objects.
 #
 # @outdev: the name of a character device backend to which all
 #     incoming packets are mirrored
@@ -507,8 +490,7 @@
 
 ##
 # @FilterRewriterProperties:
-#
-# Properties for filter-rewriter objects.
+#     Properties for filter-rewriter objects.
 #
 # @vnet_hdr_support: if true, vnet header support is enabled
 #     (default: false)
@@ -521,8 +503,7 @@
 
 ##
 # @InputBarrierProperties:
-#
-# Properties for input-barrier objects.
+#     Properties for input-barrier objects.
 #
 # @name: the screen name as declared in the screens section of
 #     barrier.conf
@@ -554,8 +535,7 @@
 
 ##
 # @InputLinuxProperties:
-#
-# Properties for input-linux objects.
+#     Properties for input-linux objects.
 #
 # @evdev: the path of the host evdev device to use
 #
@@ -578,8 +558,7 @@
 
 ##
 # @EventLoopBaseProperties:
-#
-# Common properties for event loops
+#     Common properties for event loops
 #
 # @aio-max-batch: maximum number of requests in a batch for the AIO
 #     engine, 0 means that the engine will use its default.
@@ -600,8 +579,7 @@
 
 ##
 # @IothreadProperties:
-#
-# Properties for iothread objects.
+#     Properties for iothread objects.
 #
 # @poll-max-ns: the maximum number of nanoseconds to busy wait for
 #     events.  0 means polling is disabled (default: 32768 on POSIX
@@ -635,8 +613,7 @@
 
 ##
 # @MainLoopProperties:
-#
-# Properties for the main-loop object.
+#     Properties for the main-loop object.
 #
 # Since: 7.1
 ##
@@ -646,8 +623,7 @@
 
 ##
 # @MemoryBackendProperties:
-#
-# Properties for objects of classes derived from memory-backend.
+#     Properties for objects of classes derived from memory-backend.
 #
 # @merge: if true, mark the memory as mergeable (default depends on
 #     the machine type)
@@ -705,8 +681,7 @@
 
 ##
 # @MemoryBackendFileProperties:
-#
-# Properties for memory-backend-file objects.
+#     Properties for memory-backend-file objects.
 #
 # @align: the base address alignment when QEMU mmap(2)s @mem-path.
 #     Some backend stores specified by @mem-path require an alignment
@@ -766,8 +741,7 @@
 
 ##
 # @MemoryBackendMemfdProperties:
-#
-# Properties for memory-backend-memfd objects.
+#     Properties for memory-backend-memfd objects.
 #
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
@@ -822,8 +796,7 @@
 
 ##
 # @PrManagerHelperProperties:
-#
-# Properties for pr-manager-helper objects.
+#     Properties for pr-manager-helper objects.
 #
 # @path: the path to a Unix domain socket for connecting to the
 #     external helper
@@ -836,8 +809,7 @@
 
 ##
 # @QtestProperties:
-#
-# Properties for qtest objects.
+#     Properties for qtest objects.
 #
 # @chardev: the chardev to be used to receive qtest commands on.
 #
@@ -851,8 +823,7 @@
 
 ##
 # @RemoteObjectProperties:
-#
-# Properties for x-remote-object objects.
+#     Properties for x-remote-object objects.
 #
 # @fd: file descriptor name previously passed via `getfd` command
 #
@@ -866,8 +837,7 @@
 
 ##
 # @VfioUserServerProperties:
-#
-# Properties for x-vfio-user-server objects.
+#     Properties for x-vfio-user-server objects.
 #
 # @socket: socket to be used by the libvfio-user library
 #
@@ -880,8 +850,7 @@
 
 ##
 # @IOMMUFDProperties:
-#
-# Properties for iommufd objects.
+#     Properties for iommufd objects.
 #
 # @fd: file descriptor name previously passed via `getfd` command,
 #     which represents a pre-opened /dev/iommu.  This allows the
@@ -896,8 +865,7 @@
 
 ##
 # @AcpiGenericInitiatorProperties:
-#
-# Properties for acpi-generic-initiator objects.
+#     Properties for acpi-generic-initiator objects.
 #
 # @pci-dev: PCI device ID to be associated with the node
 #
@@ -911,8 +879,7 @@
 
 ##
 # @AcpiGenericPortProperties:
-#
-# Properties for acpi-generic-port objects.
+#     Properties for acpi-generic-port objects.
 #
 # @pci-bus: QOM path of the PCI bus of the hostbridge associated with
 #     this SRAT Generic Port Affinity Structure.  This is the same as
@@ -950,8 +917,7 @@
 
 ##
 # @RngProperties:
-#
-# Properties for objects of classes derived from rng.
+#     Properties for objects of classes derived from rng.
 #
 # @opened: if true, the device is opened immediately when applying
 #     this option and will probably fail when processing the next
@@ -970,8 +936,7 @@
 
 ##
 # @RngEgdProperties:
-#
-# Properties for rng-egd objects.
+#     Properties for rng-egd objects.
 #
 # @chardev: the name of a character device backend that provides the
 #     connection to the RNG daemon
@@ -984,8 +949,7 @@
 
 ##
 # @RngRandomProperties:
-#
-# Properties for rng-random objects.
+#     Properties for rng-random objects.
 #
 # @filename: the filename of the device on the host to obtain entropy
 #     from (default: "/dev/urandom")
@@ -999,8 +963,7 @@
 
 ##
 # @IgvmCfgProperties:
-#
-# Properties common to objects that handle IGVM files.
+#     Properties common to objects that handle IGVM files.
 #
 # @file: IGVM file to use to configure guest
 #
@@ -1012,8 +975,7 @@
 
 ##
 # @SevCommonProperties:
-#
-# Properties common to objects that are derivatives of sev-common.
+#     Properties common to objects that are derivatives of sev-common.
 #
 # @sev-device: SEV device to use (default: "/dev/sev")
 #
@@ -1047,8 +1009,7 @@
 
 ##
 # @SevGuestProperties:
-#
-# Properties for sev-guest objects.
+#     Properties for sev-guest objects.
 #
 # @dh-cert-file: guest owners DH certificate (encoded with base64)
 #
@@ -1145,8 +1106,7 @@
 
 ##
 # @TdxGuestProperties:
-#
-# Properties for tdx-guest objects.
+#     Properties for tdx-guest objects.
 #
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
@@ -1190,8 +1150,7 @@
 
 ##
 # @ThreadContextProperties:
-#
-# Properties for thread context objects.
+#     Properties for thread context objects.
 #
 # @cpu-affinity: the list of host CPU numbers used as CPU affinity for
 #     all threads created in the thread context (default: QEMU main
@@ -1211,8 +1170,7 @@
 
 ##
 # @MonitorProperties:
-#
-# Properties for all monitors
+#     Properties for all monitors
 #
 # @chardev: ID of the character device providing the monitor transport
 #
@@ -1223,8 +1181,7 @@
 
 ##
 # @MonitorHMPProperties:
-#
-# Properties for the HMP monitor
+#     Properties for the HMP monitor
 #
 # @readline: whether to enable readline for line editing
 #      (default: true)
@@ -1238,8 +1195,7 @@
 
 ##
 # @MonitorQMPCloseAction:
-#
-# Action to take when the character device backend is closed.
+#     Action to take when the character device backend is closed.
 #
 # @none: take no action
 #
@@ -1253,8 +1209,7 @@
 
 ##
 # @MonitorQMPProperties:
-#
-# Properties for the QMP monitor
+#     Properties for the QMP monitor
 #
 # @pretty: whether to pretty print JSON responses (default: false)
 #
@@ -1347,8 +1302,7 @@
 
 ##
 # @ObjectOptions:
-#
-# Describes the options of a user creatable QOM object.
+#     Describes the options of a user creatable QOM object.
 #
 # @qom-type: the class name for the object to be created
 #
@@ -1425,8 +1379,7 @@
 
 ##
 # @object-add:
-#
-# Create a QOM object.
+#     Create a QOM object.
 #
 # Errors:
 #     - If @qom-type is not a valid class name
@@ -1445,8 +1398,7 @@
 
 ##
 # @object-del:
-#
-# Remove a QOM object.
+#     Remove a QOM object.
 #
 # @id: the name of the QOM object to remove
 #
-- 
2.55.0


