Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FDC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMOg-0003Oy-Au; Thu, 03 Jul 2025 12:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMOe-0003Oi-8H
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:48 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXMOa-0004C0-S0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:47 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.82])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 295674021F;
 Thu,  3 Jul 2025 17:02:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751558562;
 bh=qmlW3Z5QCXHE5ePvFVOcjhpzJkJyU9swd+7iqwXlp3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V6vS6dntl7yDk4GaTwc3llADjMFj7POC95Kv9/yc5X8DEdoHhVN8gffoB18Vl/RRI
 GdFe2jgX0Gghet2OmFEpgGOs4HGDSFLBXdYi7oNXMRQ3HKO1yC7Xj5/ifWJfrfu+Ws
 euMpkEZ/8iqPrnpB1Mj7vUGWOJqepVx4DEGe335c=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id A731BC0961;
 Thu,  3 Jul 2025 17:02:37 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 11/16] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Date: Thu,  3 Jul 2025 17:02:19 +0100
Message-ID: <2eca2611d372facbffa65ee8244cf2d321eb9d17.1751554099.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Create an enum entry within FirmwareDevice for 'igvm' to describe that
an IGVM file can be used to map firmware into memory as an alternative
to pre-existing firmware devices.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 docs/interop/firmware.json | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 745d21d822..0711b6f323 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -57,10 +57,17 @@
 #
 # @memory: The firmware is to be mapped into memory.
 #
+# @igvm: The firmware is defined by a file conforming to the IGVM
+#        specification and mapped into memory according to directives
+#        defined in the file. This is similar to @memory but may
+#        include additional processing defined by the IGVM file
+#        including initial CPU state or population of metadata into
+#        the guest address space. Since: 10.1
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareDevice',
-  'data' : [ 'flash', 'kernel', 'memory' ] }
+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
 
 ##
 # @FirmwareArchitecture:
@@ -377,6 +384,24 @@
 { 'struct' : 'FirmwareMappingMemory',
   'data'   : { 'filename' : 'str' } }
 
+##
+# @FirmwareMappingIgvm:
+#
+# Describes loading and mapping properties for the firmware executable,
+# when @FirmwareDevice is @igvm.
+#
+# @filename: Identifies the IGVM file containing the firmware executable
+#            along with other information used to configure the initial
+#            state of the guest. The IGVM file may be shared by multiple
+#            virtual machine definitions. This corresponds to creating
+#            an object on the command line with "-object igvm-cfg,
+#            file=@filename".
+#
+# Since: 10.1
+##
+{ 'struct' : 'FirmwareMappingIgvm',
+  'data'   : { 'filename' : 'str' } }
+
 ##
 # @FirmwareMapping:
 #
@@ -393,7 +418,8 @@
   'discriminator' : 'device',
   'data'          : { 'flash'  : 'FirmwareMappingFlash',
                       'kernel' : 'FirmwareMappingKernel',
-                      'memory' : 'FirmwareMappingMemory' } }
+                      'memory' : 'FirmwareMappingMemory',
+                      'igvm'   : 'FirmwareMappingIgvm' } }
 
 ##
 # @Firmware:
-- 
2.43.0


