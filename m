Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE27CC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnewj-0002qj-Qm; Thu, 27 Feb 2025 09:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@a3031119.bnc3.mailjet.com>)
 id 1tnewH-0001UR-5Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:38 -0500
Received: from o32.p25.mailjet.com ([185.189.236.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@a3031119.bnc3.mailjet.com>)
 id 1tnewC-0006Ll-LN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673942;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe-post:list-unsubscribe:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-transfer-encoding;
 bh=akdFEJLNVZasuPzCASIwnSvNTNsx/1vk+8n5aNiDGzg=;
 b=I2Bco9jB3TKhzvj8gsyRBbfCfW09IiHv2BB9goqAaKCuLZWpNFeiLidgu
 9IFHeSo3TTyK/lyhj9bstf6UalbZ7xvMfe2JdA4Z/OsEGA++48NQ0A8/gh19
 k9H2aGbZ857feUvXgPioRoX01cLbnGPtYnxJmNCn1vCu1wJAfFwa0tNPX1de
 jzQr9icXVRDFmSc2cv3llad5LPvyTh3yQHOX42VOlXIprdIVHDF7AGONEJgz
 j2KGecdZUvgMc9d3SHqaF+MohaAbyucToQxvbkRuPD0Cz+6XGChsFE6DPkYq
 /NA4z8CHt54wzVcAlCLe9QIeR87+8ZuxmzkD0OskaEGmg==
Message-Id: <61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/16] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Date: Thu, 27 Feb 2025 14:29:29 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2_sVhdlCSRgGN6huN-1NfAgAqgls
X-MJ-SMTPGUID: b5a4ec9e-4f21-4f30-93e3-968e37563de3
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.189.236.32;
 envelope-from=61dd66de.AVIAAGMvXh8AAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd2@a3031119.bnc3.mailjet.com;
 helo=o32.p25.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 docs/interop/firmware.json | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 57f55f6c54..70475e61e6 100644
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
+#        the guest address space. Since: 10.0
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareDevice',
-  'data' : [ 'flash', 'kernel', 'memory' ] }
+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
 
 ##
 # @FirmwareArchitecture:
@@ -367,6 +374,24 @@
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
+# Since: 10.0
+##
+{ 'struct' : 'FirmwareMappingIgvm',
+  'data'   : { 'filename' : 'str' } }
+
 ##
 # @FirmwareMapping:
 #
@@ -383,7 +408,8 @@
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


