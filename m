Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE6CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkf-0006uS-EE; Wed, 30 Sep 2026 06:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001cr-Ad
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qh-Rb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGVb+9BDQJ1K2qRAe99bP1RQ/41agCjxvO4UGR5aeng=;
 b=FKuyQ3E3vOdGgxIQMDLtECHQmNL8gPvs1gGTouuR0sX/RYFEmLQzrQDQroCEewCinMpBGz
 TtnDZ3fqWv2z/5DklaUByypgOP4R7bVFhNfPHoNzvK4ZZ1a96lUmFtc7q/VtrGo/CjxCLV
 JXzYrAPB45nURTATSVYR0aavMU5WRXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Plhmzg9pPzu_p9XZtdoZdg-1; Wed,
 30 Sep 2026 06:39:29 -0400
X-MC-Unique: Plhmzg9pPzu_p9XZtdoZdg-1
X-Mimecast-MFC-AGG-ID: Plhmzg9pPzu_p9XZtdoZdg_1790764768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 607F8195F173; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8D4130000E8; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2161121E657F; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 094/105] qapi: convert intro sections for
 docs/interop/firmware.json
Date: Wed, 30 Sep 2026 12:38:59 +0200
Message-ID: <20260930103910.3934848-95-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

All conversions in this patch do not create a new documentation
insertion point, except for one at the very end.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-8-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/firmware.json | 76 ++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5e..1efd32c631 100644
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


