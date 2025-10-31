Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DDFCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElk4-0000UE-KX; Fri, 31 Oct 2025 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljv-0000Sd-8e
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljl-0006hO-Jt
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tATASxGfW61hEQwJ6kcx1aJXf3z68XWwHzPj1UjaIE=;
 b=SP56MKShl5NrZUwh6ZvPbopKO4kik9OtoI3UHVOhB9kySe2SMZl7wTR5diG1fI6iDi0Bg/
 KEsYW7U7hJOh3MqcvRLJVRGHLnwiFjR07n+75XSs3pbG5zgPp/XKq81aVtQFQwomtyXJvO
 i02MOeni8tT15Xf/QA1TsOQAE+3g3fA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-XsfOFzP0NPWSmGcRZIqYQw-1; Fri,
 31 Oct 2025 05:47:56 -0400
X-MC-Unique: XsfOFzP0NPWSmGcRZIqYQw-1
X-Mimecast-MFC-AGG-ID: XsfOFzP0NPWSmGcRZIqYQw_1761904075
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF02D1955EBB; Fri, 31 Oct 2025 09:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6DF5180058D; Fri, 31 Oct 2025 09:47:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34ED721E6935; Fri, 31 Oct 2025 10:47:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 3/8] qapi: Clean up whitespace between definitions
Date: Fri, 31 Oct 2025 10:47:46 +0100
Message-ID: <20251031094751.2817932-4-armbru@redhat.com>
In-Reply-To: <20251031094751.2817932-1-armbru@redhat.com>
References: <20251031094751.2817932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Consistently separate definitions with a single blank line.
Consistently separate member descriptions with a blank line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/acpi-hest.json | 1 -
 qapi/char.json      | 1 -
 qapi/crypto.json    | 1 +
 qapi/cxl.json       | 1 -
 qapi/migration.json | 3 +++
 qapi/misc-i386.json | 2 --
 qapi/net.json       | 3 ---
 qapi/qom.json       | 3 ---
 qapi/run-state.json | 1 -
 qapi/ui.json        | 2 +-
 qapi/virtio.json    | 2 --
 11 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
index 88c53eaf1b..a01f1dee09 100644
--- a/qapi/acpi-hest.json
+++ b/qapi/acpi-hest.json
@@ -11,7 +11,6 @@
 # https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
 ##
 
-
 ##
 # @inject-ghes-v2-error:
 #
diff --git a/qapi/char.json b/qapi/char.json
index aaedbbb36c..5218a2e76b 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -694,7 +694,6 @@
 { 'struct': 'ChardevRingbufWrapper',
   'data': { 'data': 'ChardevRingbuf' } }
 
-
 ##
 # @ChardevPtyWrapper:
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 72ac718147..2b55befef9 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -547,6 +547,7 @@
   'base': 'TlsCredsProperties',
   'data': { '*sanity-check': 'bool',
             '*passwordid': 'str' } }
+
 ##
 # @QCryptoAkCipherAlgo:
 #
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 52cc5d4f33..eeddb58d1d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -262,7 +262,6 @@
 #
 # Since: 8.0
 ##
-
 { 'enum': 'CxlUncorErrorType',
   'data': ['cache-data-parity',
            'cache-address-parity',
diff --git a/qapi/migration.json b/qapi/migration.json
index 4dd1098219..022ac0c4ed 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -177,6 +177,7 @@
             'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
+
 ##
 # @VfioStats:
 #
@@ -523,6 +524,7 @@
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
+#
 # @deprecated: Member @zero-blocks is deprecated as being part of
 #     block migration which was already removed.
 #
@@ -1702,6 +1704,7 @@
 # The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
+#
 # @cpr: Checkpoint and restart state channel.
 #
 # Since: 8.1
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index d1ce8caf25..05a94d6c41 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -122,7 +122,6 @@
       'sev': 'SevGuestInfo',
       'sev-snp': 'SevSnpGuestInfo' } }
 
-
 ##
 # @query-sev:
 #
@@ -418,7 +417,6 @@
            'pending': 'bool',
            'masked': 'bool'} }
 
-
 ##
 # @xen-event-list:
 #
diff --git a/qapi/net.json b/qapi/net.json
index 23911b75cd..70c0411837 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1065,7 +1065,6 @@
 #
 # Since: 4.0
 ##
-
 { 'struct': 'AnnounceParameters',
   'data': { 'initial': 'int',
             'max': 'int',
@@ -1181,7 +1180,6 @@
 #     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
 #          "event": "NETDEV_VHOST_USER_CONNECTED",
 #          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
-#
 ##
 { 'event': 'NETDEV_VHOST_USER_CONNECTED',
   'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
@@ -1200,7 +1198,6 @@
 #     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
 #          "event": "NETDEV_VHOST_USER_DISCONNECTED",
 #          "data": { "netdev-id": "netdev0" } }
-#
 ##
 { 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
diff --git a/qapi/qom.json b/qapi/qom.json
index d7dceaf2f8..6f5c9de0f0 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -75,7 +75,6 @@
 { 'struct': 'ObjectPropertiesValues',
   'data': { 'properties': [ 'ObjectPropertyValue' ] }}
 
-
 ##
 # @qom-list:
 #
@@ -244,7 +243,6 @@
 #
 # @typename: the type name of an object
 #
-#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
@@ -1169,7 +1167,6 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
-
 ##
 # @ObjectType:
 #
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 2872bee06e..a6bc94a44b 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -618,7 +618,6 @@
 #     error information, as zero-terminated string.  Present when the
 #     "GPA valid" bit (bit 63) is set in @error-code.
 #
-#
 # Since: 10.1
 ##
 {'struct': 'GuestPanicInformationTdx',
diff --git a/qapi/ui.json b/qapi/ui.json
index 804b1ecc3b..e3da77632a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -682,6 +682,7 @@
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo',
   'if': 'CONFIG_VNC' }
+
 ##
 # @query-vnc-servers:
 #
@@ -1094,7 +1095,6 @@
 { 'enum'  : 'InputMultiTouchType',
   'data'  : [ 'begin', 'update', 'end', 'cancel', 'data' ] }
 
-
 ##
 # @InputKeyEvent:
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 72790bcfb0..cd67c4f52e 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -964,7 +964,6 @@
 #
 # Since: 9.0
 ##
-
 { 'struct': 'IOThreadVirtQueueMapping',
   'data': { 'iothread': 'str', '*vqs': ['uint16'] } }
 
@@ -989,7 +988,6 @@
 #
 # Since: 9.0
 ##
-
 { 'struct': 'DummyVirtioForceArrays',
   'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'],
             'unused-virtio-gpu-output': ['VirtIOGPUOutput'] } }
-- 
2.49.0


