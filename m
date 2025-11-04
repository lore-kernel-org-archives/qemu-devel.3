Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F7CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGzx-00011V-IP; Tue, 04 Nov 2025 08:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyg-0000DJ-TE
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyf-0001XA-1h
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJBTANZrox/EOxgJEjxHDEWqXov+5Bm5C6u5yx+hH2s=;
 b=QXK/y8OJoUWqbe0p5fM00JqMKx00CI+C06Da7zRBEZITIwc6FAxSAc32+0dUtklGnaSi/m
 RZjqWo0DgUtvL6Umar13jEDzFRyk0s0H892NVUijXYBDA/ofwbXd3pPO2SEAey4eUFx7Bg
 e67rj3zt6mqVQrwUT2m6IbJf14b0hSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-aEU22SXqNDqike1YTD7bPw-1; Tue,
 04 Nov 2025 08:21:33 -0500
X-MC-Unique: aEU22SXqNDqike1YTD7bPw-1
X-Mimecast-MFC-AGG-ID: aEU22SXqNDqike1YTD7bPw_1762262492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B0871956095; Tue,  4 Nov 2025 13:21:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C51D1956056; Tue,  4 Nov 2025 13:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 717F621E6773; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 05/12] qapi: Clean up whitespace between definitions
Date: Tue,  4 Nov 2025 14:21:18 +0100
Message-ID: <20251104132125.4134730-6-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20251103082354.3273027-4-armbru@redhat.com>
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
index b07e3bb827..140614f82c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -681,7 +681,6 @@
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
index 4c6cc5ca8d..118bd34965 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1055,7 +1055,6 @@
 #
 # Since: 4.0
 ##
-
 { 'struct': 'AnnounceParameters',
   'data': { 'initial': 'int',
             'max': 'int',
@@ -1171,7 +1170,6 @@
 #     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
 #          "event": "NETDEV_VHOST_USER_CONNECTED",
 #          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
-#
 ##
 { 'event': 'NETDEV_VHOST_USER_CONNECTED',
   'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
@@ -1190,7 +1188,6 @@
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


