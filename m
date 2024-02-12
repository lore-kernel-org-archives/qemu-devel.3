Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497C8C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOs-0006PQ-Eg; Mon, 12 Feb 2024 04:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOk-0006Kl-Et
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOh-0003cj-IR
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fs5e49/eujBwVgdsth8B4MhCT2F2iduF/a/e4lS/MH0=;
 b=OjP59dm8gZukEsyj+Fb3Ed+6JFvQsvviygRbwxfEa8KLE2B3W7oeixmN5t/vHFTmuiexNs
 I0xWexcjmgtslaLncC9EEAhdb/YVzjUbRRywNfZ6JclgkXBR9r7m/GcdfXjOdqeip2UwBB
 PknWx/3w2kCU9KBausG9i8rZnqnrZJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-X6V4iUmfOFanmAdeYuWsug-1; Mon, 12 Feb 2024 04:14:40 -0500
X-MC-Unique: X6V4iUmfOFanmAdeYuWsug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B81883B86F;
 Mon, 12 Feb 2024 09:14:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C030207ACDE;
 Mon, 12 Feb 2024 09:14:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9930621E5A47; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/18] qapi: Plug trivial documentation holes around former
 simple unions
Date: Mon, 12 Feb 2024 10:14:30 +0100
Message-ID: <20240212091436.688598-13-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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

The conversion of simple to flat unions left the @data members
undocumented.  Add documentation where it's trivial.  Copy verbatim
from the wrapped type's description where possible.

Leftovers: String (to be taken care of in the next commit), and
TransActionAction (left for another day).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-13-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/block-core.json | 10 ++++++++++
 qapi/char.json       | 26 ++++++++++++++++++++++++++
 qapi/machine.json    | 10 ++++++++++
 qapi/pragma.json     | 34 ----------------------------------
 qapi/sockets.json    |  6 ++++++
 qapi/tpm.json        |  4 ++++
 qapi/ui.json         | 12 ++++++++++++
 7 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 80ed4122f2..55b583f079 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -196,6 +196,8 @@
 ##
 # @ImageInfoSpecificQCow2Wrapper:
 #
+# @data: image information specific to QCOW2
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2Wrapper',
@@ -204,6 +206,8 @@
 ##
 # @ImageInfoSpecificVmdkWrapper:
 #
+# @data: image information specific to VMDK
+#
 # Since: 6.1
 ##
 { 'struct': 'ImageInfoSpecificVmdkWrapper',
@@ -212,6 +216,8 @@
 ##
 # @ImageInfoSpecificLUKSWrapper:
 #
+# @data: image information specific to LUKS
+#
 # Since: 2.7
 ##
 { 'struct': 'ImageInfoSpecificLUKSWrapper',
@@ -223,6 +229,8 @@
 ##
 # @ImageInfoSpecificRbdWrapper:
 #
+# @data: image information specific to RBD
+#
 # Since: 6.1
 ##
 { 'struct': 'ImageInfoSpecificRbdWrapper',
@@ -231,6 +239,8 @@
 ##
 # @ImageInfoSpecificFileWrapper:
 #
+# @data: image information specific to files
+#
 # Since: 8.0
 ##
 { 'struct': 'ImageInfoSpecificFileWrapper',
diff --git a/qapi/char.json b/qapi/char.json
index 6c6ad3b10c..e3e1b2c9f5 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -498,6 +498,8 @@
 ##
 # @ChardevFileWrapper:
 #
+# @data: Configuration info for file chardevs
+#
 # Since: 1.4
 ##
 { 'struct': 'ChardevFileWrapper',
@@ -506,6 +508,8 @@
 ##
 # @ChardevHostdevWrapper:
 #
+# @data: Configuration info for device and pipe chardevs
+#
 # Since: 1.4
 ##
 { 'struct': 'ChardevHostdevWrapper',
@@ -514,6 +518,8 @@
 ##
 # @ChardevSocketWrapper:
 #
+# @data: Configuration info for (stream) socket chardevs
+#
 # Since: 1.4
 ##
 { 'struct': 'ChardevSocketWrapper',
@@ -522,6 +528,8 @@
 ##
 # @ChardevUdpWrapper:
 #
+# @data: Configuration info for datagram socket chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevUdpWrapper',
@@ -530,6 +538,8 @@
 ##
 # @ChardevCommonWrapper:
 #
+# @data: Configuration shared across all chardev backends
+#
 # Since: 2.6
 ##
 { 'struct': 'ChardevCommonWrapper',
@@ -538,6 +548,8 @@
 ##
 # @ChardevMuxWrapper:
 #
+# @data: Configuration info for mux chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevMuxWrapper',
@@ -546,6 +558,8 @@
 ##
 # @ChardevStdioWrapper:
 #
+# @data: Configuration info for stdio chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevStdioWrapper',
@@ -554,6 +568,8 @@
 ##
 # @ChardevSpiceChannelWrapper:
 #
+# @data: Configuration info for spice vm channel chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpiceChannelWrapper',
@@ -563,6 +579,8 @@
 ##
 # @ChardevSpicePortWrapper:
 #
+# @data: Configuration info for spice port chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpicePortWrapper',
@@ -572,6 +590,8 @@
 ##
 # @ChardevQemuVDAgentWrapper:
 #
+# @data: Configuration info for qemu vdagent implementation
+#
 # Since: 6.1
 ##
 { 'struct': 'ChardevQemuVDAgentWrapper',
@@ -581,6 +601,8 @@
 ##
 # @ChardevDBusWrapper:
 #
+# @data: Configuration info for DBus chardevs
+#
 # Since: 7.0
 ##
 { 'struct': 'ChardevDBusWrapper',
@@ -590,6 +612,8 @@
 ##
 # @ChardevVCWrapper:
 #
+# @data: Configuration info for virtual console chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevVCWrapper',
@@ -598,6 +622,8 @@
 ##
 # @ChardevRingbufWrapper:
 #
+# @data: Configuration info for ring buffer chardevs
+#
 # Since: 1.5
 ##
 { 'struct': 'ChardevRingbufWrapper',
diff --git a/qapi/machine.json b/qapi/machine.json
index aa99fa333f..6a25e39f44 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1396,6 +1396,8 @@
 ##
 # @PCDIMMDeviceInfoWrapper:
 #
+# @data: PCDIMMDevice state information
+#
 # Since: 2.1
 ##
 { 'struct': 'PCDIMMDeviceInfoWrapper',
@@ -1404,6 +1406,8 @@
 ##
 # @VirtioPMEMDeviceInfoWrapper:
 #
+# @data: VirtioPMEM state information
+#
 # Since: 2.1
 ##
 { 'struct': 'VirtioPMEMDeviceInfoWrapper',
@@ -1412,6 +1416,8 @@
 ##
 # @VirtioMEMDeviceInfoWrapper:
 #
+# @data: VirtioMEMDevice state information
+#
 # Since: 2.1
 ##
 { 'struct': 'VirtioMEMDeviceInfoWrapper',
@@ -1420,6 +1426,8 @@
 ##
 # @SgxEPCDeviceInfoWrapper:
 #
+# @data: Sgx EPC state information
+#
 # Since: 6.2
 ##
 { 'struct': 'SgxEPCDeviceInfoWrapper',
@@ -1428,6 +1436,8 @@
 ##
 # @HvBalloonDeviceInfoWrapper:
 #
+# @data: hv-balloon provided memory state information
+#
 # Since: 8.2
 ##
 { 'struct': 'HvBalloonDeviceInfoWrapper',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index aea6384255..d5e3f6f142 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -52,19 +52,6 @@
         'BlockdevVmdkAdapterType',
         'ChardevBackend',
         'ChardevBackendKind',
-        'ChardevCommonWrapper',
-        'ChardevDBusWrapper',
-        'ChardevFileWrapper',
-        'ChardevHostdevWrapper',
-        'ChardevMuxWrapper',
-        'ChardevQemuVDAgentWrapper',
-        'ChardevRingbufWrapper',
-        'ChardevSocketWrapper',
-        'ChardevSpiceChannelWrapper',
-        'ChardevSpicePortWrapper',
-        'ChardevStdioWrapper',
-        'ChardevUdpWrapper',
-        'ChardevVCWrapper',
         'CpuS390Entitlement',
         'CpuS390Polarization',
         'CpuS390State',
@@ -77,24 +64,12 @@
         'GrabToggleKeys',
         'GuestPanicInformationHyperV',
         'HotKeyMod',
-        'HvBalloonDeviceInfoWrapper',
         'ImageInfoSpecific',
-        'ImageInfoSpecificFileWrapper',
         'ImageInfoSpecificKind',
-        'ImageInfoSpecificLUKSWrapper',
-        'ImageInfoSpecificQCow2Wrapper',
-        'ImageInfoSpecificRbdWrapper',
-        'ImageInfoSpecificVmdkWrapper',
-        'InetSocketAddressWrapper',
         'InputAxis',
-        'InputBtnEventWrapper',
         'InputButton',
-        'InputKeyEventWrapper',
-        'InputMoveEventWrapper',
         'InputMultiTouchEvent',
-        'InputMultiTouchEventWrapper',
         'InputMultiTouchType',
-        'IntWrapper',
         'IscsiHeaderDigest',
         'IscsiTransport',
         'JSONType',
@@ -107,18 +82,15 @@
         'NetClientDriver',
         'NumaOptions',
         'ObjectType',
-        'PCDIMMDeviceInfoWrapper',
         'PciMemoryRegion',
         'QCryptoAkCipherKeyType',
         'QCryptoAkCipherOptions',
         'QCryptodevBackendServiceType',
         'QKeyCode',
-        'QKeyCodeWrapper',
         'Qcow2OverlapCheckFlags',
         'RbdAuthMode',
         'RbdEncryptionCreateOptions',
         'RbdImageEncryptionFormat',
-        'SgxEPCDeviceInfoWrapper',
         'SocketAddressLegacy',
         'SshHostKeyCheck',
         'StatsFilter',
@@ -126,16 +98,10 @@
         'String',
         'StringWrapper',
         'SysEmuTarget',
-        'TPMEmulatorOptionsWrapper',
-        'TPMPassthroughOptionsWrapper',
         'ThrottleGroupProperties',
         'TransactionAction',
-        'UnixSocketAddressWrapper',
-        'VirtioMEMDeviceInfoWrapper',
-        'VirtioPMEMDeviceInfoWrapper',
         'VncPrimaryAuth',
         'VncVencryptSubAuth',
-        'VsockSocketAddressWrapper',
         'X86CPURegister32',
         'XDbgBlockGraph',
         'YankInstance',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 6213154525..c3b616731d 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -119,6 +119,8 @@
 ##
 # @InetSocketAddressWrapper:
 #
+# @data: internet domain socket address
+#
 # Since: 1.3
 ##
 { 'struct': 'InetSocketAddressWrapper',
@@ -127,6 +129,8 @@
 ##
 # @UnixSocketAddressWrapper:
 #
+# @data: UNIX domain socket address
+#
 # Since: 1.3
 ##
 { 'struct': 'UnixSocketAddressWrapper',
@@ -135,6 +139,8 @@
 ##
 # @VsockSocketAddressWrapper:
 #
+# @data: VSOCK domain socket address
+#
 # Since: 2.8
 ##
 { 'struct': 'VsockSocketAddressWrapper',
diff --git a/qapi/tpm.json b/qapi/tpm.json
index a754455ca5..f9c1e866e7 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -102,6 +102,8 @@
 ##
 # @TPMPassthroughOptionsWrapper:
 #
+# @data: Information about the TPM passthrough type
+#
 # Since: 1.5
 ##
 { 'struct': 'TPMPassthroughOptionsWrapper',
@@ -111,6 +113,8 @@
 ##
 # @TPMEmulatorOptionsWrapper:
 #
+# @data: Information about the TPM emulator type
+#
 # Since: 2.11
 ##
 { 'struct': 'TPMEmulatorOptionsWrapper',
diff --git a/qapi/ui.json b/qapi/ui.json
index a0158baf23..1eccad0a83 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -990,6 +990,8 @@
 ##
 # @IntWrapper:
 #
+# @data: a numeric key code
+#
 # Since: 1.3
 ##
 { 'struct': 'IntWrapper',
@@ -998,6 +1000,8 @@
 ##
 # @QKeyCodeWrapper:
 #
+# @data: An enumeration of key name
+#
 # Since: 1.3
 ##
 { 'struct': 'QKeyCodeWrapper',
@@ -1175,6 +1179,8 @@
 ##
 # @InputKeyEventWrapper:
 #
+# @data: Keyboard input event
+#
 # Since: 2.0
 ##
 { 'struct': 'InputKeyEventWrapper',
@@ -1183,6 +1189,8 @@
 ##
 # @InputBtnEventWrapper:
 #
+# @data: Pointer button input event
+#
 # Since: 2.0
 ##
 { 'struct': 'InputBtnEventWrapper',
@@ -1191,6 +1199,8 @@
 ##
 # @InputMoveEventWrapper:
 #
+# @data: Pointer motion input event
+#
 # Since: 2.0
 ##
 { 'struct': 'InputMoveEventWrapper',
@@ -1199,6 +1209,8 @@
 ##
 # @InputMultiTouchEventWrapper:
 #
+# @data: MultiTouch input event
+#
 # Since: 8.1
 ##
 { 'struct': 'InputMultiTouchEventWrapper',
-- 
2.43.0


