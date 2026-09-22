Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEC2C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Yy-0000ys-6c; Tue, 22 Sep 2026 16:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xj-0000P0-5N
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xf-00048B-4I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwFyc4zFN9EYqJtZf8lGRUeeM53lUzuwAg5LTlqUuaA=;
 b=UAEQRTXcnn3eVOKD+x1ErBcBqf3orJZWcJA+9q6loeKRPWkPC0VY781QFDhlFhyxdJzY6b
 guI4SWMkm6wlcRS41rmt89sAhClip65P9xgjCD0LxY6A3Wx2TUXv+5vqtXfxdw2G8ZkakA
 Nlpo4QmfDzt9NkKitsMy6hR0pXU2pU4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-iWM0fvXSMx6fD6iVxogo5g-1; Tue,
 22 Sep 2026 16:56:41 -0400
X-MC-Unique: iWM0fvXSMx6fD6iVxogo5g-1
X-Mimecast-MFC-AGG-ID: iWM0fvXSMx6fD6iVxogo5g_1790110599
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 609011956064; Tue, 22 Sep 2026 20:56:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63BF71956086; Tue, 22 Sep 2026 20:56:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 7/8] qapi: convert intro sections for
 docs/interop/firmware.json
Date: Tue, 22 Sep 2026 16:56:04 -0400
Message-ID: <20260922205605.501602-8-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

All conversions in this patch do not create a new documentation
insertion point, except for one at the very end.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/firmware.json | 76 ++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed..1efd32c6315 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -23,9 +23,8 @@
 
 ##
 # @FirmwareOSInterface:
-#
-# Lists the firmware-OS interface types provided by various firmware
-# that is commonly used with QEMU virtual machines.
+#     Lists the firmware-OS interface types provided by various
+#     firmware that is commonly used with QEMU virtual machines.
 #
 # @bios: Traditional x86 BIOS interface.  For example, firmware built
 #     from the SeaBIOS project usually provides this interface.
@@ -49,8 +48,7 @@
 
 ##
 # @FirmwareDevice:
-#
-# Defines the device types that firmware can be mapped into.
+#     Defines the device types that firmware can be mapped into.
 #
 # @flash: The firmware executable and its accompanying NVRAM file are
 #     to be mapped into a pflash chip each.
@@ -75,9 +73,8 @@
 
 ##
 # @FirmwareArchitecture:
-#
-# Enumeration of architectures for which Qemu uses additional firmware
-# files.
+#     Enumeration of architectures for which Qemu uses additional
+#     firmware files.
 #
 # @aarch64: 64-bit Arm.
 #
@@ -98,8 +95,7 @@
 
 ##
 # @FirmwareTarget:
-#
-# Defines the machine types that firmware may execute on.
+#     Defines the machine types that firmware may execute on.
 #
 # @architecture: Determines the emulation target (the QEMU system
 #     emulator) that can execute the firmware.
@@ -121,9 +117,8 @@
 
 ##
 # @FirmwareFeature:
-#
-# Defines the features that firmware may support, and the platform
-# requirements that firmware may present.
+#     Defines the features that firmware may support, and the platform
+#     requirements that firmware may present.
 #
 # @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as
 #     defined in the ACPI specification.  On the "pc-i440fx-*" machine
@@ -236,8 +231,7 @@
 
 ##
 # @FirmwareFormat:
-#
-# Formats that are supported for firmware images.
+#     Formats that are supported for firmware images.
 #
 # @raw: Raw disk image format.
 #
@@ -250,12 +244,11 @@
 
 ##
 # @FirmwareFlashFile:
-#
-# Defines common properties that are necessary for loading a firmware
-# file into a pflash chip.  The corresponding QEMU command line option
-# is "-drive file=@filename,format=@format".  Note however that the
-# option-argument shown here is incomplete; it is completed under
-# @FirmwareMappingFlash.
+#     Defines common properties that are necessary for loading a
+#     firmware file into a pflash chip.  The corresponding QEMU
+#     command line option is "-drive file=@filename,format=@format".
+#     Note however that the option-argument shown here is incomplete;
+#     it is completed under @FirmwareMappingFlash.
 #
 # @filename: Specifies the filename on the host filesystem where the
 #     firmware file can be found.
@@ -272,9 +265,8 @@
 
 ##
 # @FirmwareFlashMode:
-#
-# Describes how the firmware build handles code versus variable
-# persistence.
+#     Describes how the firmware build handles code versus variable
+#     persistence.
 #
 # @split: the executable file contains code while the NVRAM template
 #     provides variable storage.  The executable must be configured
@@ -298,9 +290,9 @@
 
 ##
 # @FirmwareMappingFlash:
-#
-# Describes loading and mapping properties for the firmware executable
-# and its accompanying NVRAM file, when @FirmwareDevice is @flash.
+#     Describes loading and mapping properties for the firmware
+#     executable and its accompanying NVRAM file, when @FirmwareDevice
+#     is @flash.
 #
 # @mode: Describes how the firmware build handles code versus variable
 #     storage.  If not present, it must be treated as if it was
@@ -357,9 +349,8 @@
 
 ##
 # @FirmwareMappingKernel:
-#
-# Describes loading and mapping properties for the firmware
-# executable, when @FirmwareDevice is @kernel.
+#     Describes loading and mapping properties for the firmware
+#     executable, when @FirmwareDevice is @kernel.
 #
 # @filename: Identifies the firmware executable.  The firmware
 #     executable may be shared by multiple virtual machine
@@ -373,9 +364,8 @@
 
 ##
 # @FirmwareMemoryUefiVars:
-#
-# Contains information needed to set up the "uefi-vars" device
-# to provide UEFI variable store access to the firmware.
+#     Contains information needed to set up the "uefi-vars" device to
+#     provide UEFI variable store access to the firmware.
 #
 # @template: The path to the UEFI JSON variable store template
 #     compatible with the firmware.  Management software instantiates
@@ -406,9 +396,8 @@
 
 ##
 # @FirmwareMappingMemory:
-#
-# Describes loading and mapping properties for the firmware
-# executable, when @FirmwareDevice is @memory.
+#     Describes loading and mapping properties for the firmware
+#     executable, when @FirmwareDevice is @memory.
 #
 # @filename: Identifies the firmware executable.  The firmware
 #     executable may be shared by multiple virtual machine
@@ -430,9 +419,8 @@
 
 ##
 # @FirmwareMappingIgvm:
-#
-# Describes loading and mapping properties for the firmware
-# executable, when @FirmwareDevice is @igvm.
+#     Describes loading and mapping properties for the firmware
+#     executable, when @FirmwareDevice is @igvm.
 #
 # @filename: Identifies the IGVM file containing the firmware
 #     executable along with other information used to configure the
@@ -448,9 +436,8 @@
 
 ##
 # @FirmwareMapping:
-#
-# Provides a discriminated structure for firmware to describe its
-# loading / mapping properties.
+#     Provides a discriminated structure for firmware to describe its
+#     loading / mapping properties.
 #
 # @device: Selects the device type that the firmware must be mapped
 #     into.
@@ -467,9 +454,8 @@
 
 ##
 # @Firmware:
-#
-# Describes a firmware (or a firmware use case) to management
-# software.
+#     Describes a firmware (or a firmware use case) to management
+#     software.
 #
 # It is possible for multiple @Firmware elements to match the search
 # criteria of management software.  Applications thus need rules to
-- 
2.55.0


