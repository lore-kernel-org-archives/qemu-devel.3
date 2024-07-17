Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6724C3DA5E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Do-0003ts-3e; Wed, 17 Jul 2024 06:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dm-0003n2-DR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dk-0001UG-C5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyMXqeIfYoaC0ASGnku26qnhme9E9ZpMtbbH6V7xfnU=;
 b=H7z6Pf/TBDf2Yd0z9ocw2X/bkdBEXUZQh/q4nRSCPzxh8GKB61pjzGYlHP4YMrWikIo5w6
 k39pD9Qk7LVbHefn3TnG151Erd81kSZ1i2MZeJtN506egfRyOKChCFTXjqbPUOnwHtfxlp
 7EUHwCLikTPDb51bNDopr5z0K8D9JY4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-J0d1sdWQOjy9wH6XOWJiTw-1; Wed,
 17 Jul 2024 06:49:14 -0400
X-MC-Unique: J0d1sdWQOjy9wH6XOWJiTw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D6B1955EB4; Wed, 17 Jul 2024 10:49:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B989C1955F65; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD1E021F4B92; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/14] qapi: convert "Example" sections with titles
Date: Wed, 17 Jul 2024 12:49:05 +0200
Message-ID: <20240717104907.2962784-13-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When an Example section has a brief explanation, convert it to a
qmp-example:: section using the :title: option.

Rule of thumb: If the title can fit on a single line and requires no rST
markup, it's a good candidate for using the :title: option of
qmp-example.

In this patch, trailing punctuation is removed from the title section
for consistent headline aesthetics. In just one case, specifics of the
example are removed to make the title read better.

See commit-4: "docs/qapidoc: create qmp-example directive", for a
              detailed explanation of this custom directive syntax.

See commit+2: "qapi: remove "Example" doc section" for a detailed
              explanation of why.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240717021312.606116-8-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 24 ++++++++++++------------
 qapi/block.json      | 13 ++++++-------
 qapi/migration.json  | 25 ++++++++++++++-----------
 qapi/qom.json        |  8 ++++----
 qapi/ui.json         | 11 ++++++-----
 qapi/virtio.json     | 19 ++++++++++---------
 6 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 84a020aa9e..f400b334c8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5881,9 +5881,8 @@
 #
 # Since: 2.7
 #
-# Examples:
-#
-#     1. Add a new node to a quorum
+# .. qmp-example::
+#    :title: Add a new node to a quorum
 #
 #     -> { "execute": "blockdev-add",
 #          "arguments": {
@@ -5897,7 +5896,8 @@
 #                         "node": "new_node" } }
 #     <- { "return": {} }
 #
-#     2. Delete a quorum's node
+# .. qmp-example::
+#    :title: Delete a quorum's node
 #
 #     -> { "execute": "x-blockdev-change",
 #          "arguments": { "parent": "disk1",
@@ -5933,16 +5933,16 @@
 #
 # Since: 2.12
 #
-# Examples:
-#
-#     1. Move a node into an IOThread
+# .. qmp-example::
+#    :title: Move a node into an IOThread
 #
 #     -> { "execute": "x-blockdev-set-iothread",
 #          "arguments": { "node-name": "disk1",
 #                         "iothread": "iothread0" } }
 #     <- { "return": {} }
 #
-#     2. Move a node into the main loop
+# .. qmp-example::
+#    :title: Move a node into the main loop
 #
 #     -> { "execute": "x-blockdev-set-iothread",
 #          "arguments": { "node-name": "disk1",
@@ -6018,16 +6018,16 @@
 #
 # Since: 2.0
 #
-# Examples:
-#
-#     1. Read operation
+# .. qmp-example::
+#    :title: Read operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
 #          "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
 #                    "type": "read" },
 #          "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
 #
-#     2. Flush operation
+# .. qmp-example::
+#    :title: Flush operation
 #
 #     <- { "event": "QUORUM_REPORT_BAD",
 #          "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
diff --git a/qapi/block.json b/qapi/block.json
index c8e52bc2d2..5ddd061e96 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -342,9 +342,8 @@
 #
 # Since: 2.5
 #
-# Examples:
-#
-#     1. Change a removable medium
+# .. qmp-example::
+#    :title: Change a removable medium
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "ide0-1-0",
@@ -352,7 +351,8 @@
 #                         "format": "raw" } }
 #     <- { "return": {} }
 #
-#     2. Load a read-only medium into a writable drive
+# .. qmp-example::
+#    :title: Load a read-only medium into a writable drive
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
@@ -577,9 +577,8 @@
 #                         "boundaries-write": [1000, 5000] } }
 #     <- { "return": {} }
 #
-# Example:
-#
-#     Remove all latency histograms:
+# .. qmp-example::
+#    :title: Remove all latency histograms
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
diff --git a/qapi/migration.json b/qapi/migration.json
index 3c65720238..74968a1417 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -287,14 +287,14 @@
 #
 # Since: 0.14
 #
-# Examples:
-#
-#     1. Before the first migration
+# .. qmp-example::
+#    :title: Before the first migration
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": {} }
 #
-#     2. Migration is done and has succeeded
+# .. qmp-example::
+#    :title: Migration is done and has succeeded
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": {
@@ -314,12 +314,14 @@
 #          }
 #        }
 #
-#     3. Migration is done and has failed
+# .. qmp-example::
+#    :title: Migration is done and has failed
 #
 #     -> { "execute": "query-migrate" }
 #     <- { "return": { "status": "failed" } }
 #
-#     4. Migration is being performed:
+# .. qmp-example::
+#    :title: Migration is being performed
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -340,7 +342,8 @@
 #           }
 #        }
 #
-#     5. Migration is being performed and XBZRLE is active:
+# .. qmp-example::
+#    :title: Migration is being performed and XBZRLE is active
 #
 #     -> { "execute": "query-migrate" }
 #     <- {
@@ -2131,15 +2134,15 @@
 #
 # Since: 5.2
 #
-# Examples:
-#
-#     1. Measurement is in progress:
+# .. qmp-example::
+#    :title: Measurement is in progress
 #
 #     <- {"status": "measuring", "sample-pages": 512,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
 #         "calc-time-unit": "second"}
 #
-#     2. Measurement has been completed:
+# .. qmp-example::
+#    :title: Measurement has been completed
 #
 #     <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
 #         "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10,
diff --git a/qapi/qom.json b/qapi/qom.json
index 46096a8fa4..ae947e0fd9 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -104,16 +104,16 @@
 #
 # Since: 1.2
 #
-# Examples:
-#
-#     1. Use absolute path
+# .. qmp-example::
+#    :title: Use absolute path
 #
 #     -> { "execute": "qom-get",
 #          "arguments": { "path": "/machine/unattached/device[0]",
 #                         "property": "hotplugged" } }
 #     <- { "return": false }
 #
-#     2. Use partial path
+# .. qmp-example::
+#    :title: Use partial path
 #
 #     -> { "execute": "qom-get",
 #          "arguments": { "path": "unattached/sysbus",
diff --git a/qapi/ui.json b/qapi/ui.json
index 6bda98417b..5daca5168c 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1270,9 +1270,8 @@
 #    property, so it is possible to map which console belongs to which
 #    device and display.
 #
-# Examples:
-#
-#     1. Press left mouse button.
+# .. qmp-example::
+#    :title: Press left mouse button
 #
 #     -> { "execute": "input-send-event",
 #         "arguments": { "device": "video0",
@@ -1286,7 +1285,8 @@
 #                        "data" : { "down": false, "button": "left" } } ] } }
 #     <- { "return": {} }
 #
-#     2. Press ctrl-alt-del.
+# .. qmp-example::
+#    :title: Press ctrl-alt-del
 #
 #     -> { "execute": "input-send-event",
 #          "arguments": { "events": [
@@ -1298,7 +1298,8 @@
 #               "key": {"type": "qcode", "data": "delete" } } } ] } }
 #     <- { "return": {} }
 #
-#     3. Move mouse pointer to absolute coordinates (20000, 400).
+# .. qmp-example::
+#    :title: Move mouse pointer to absolute coordinates
 #
 #     -> { "execute": "input-send-event" ,
 #       "arguments": { "events": [
diff --git a/qapi/virtio.json b/qapi/virtio.json
index f4323cc35e..d965c98ad2 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -690,9 +690,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Get vhost_virtqueue status for vhost-crypto
+# .. qmp-example::
+#    :title: Get vhost_virtqueue status for vhost-crypto
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
@@ -715,7 +714,8 @@
 #          }
 #        }
 #
-#     2. Get vhost_virtqueue status for vhost-vsock
+# .. qmp-example::
+#    :title: Get vhost_virtqueue status for vhost-vsock
 #
 #     -> { "execute": "x-query-virtio-vhost-queue-status",
 #          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
@@ -839,9 +839,8 @@
 #
 # Since: 7.2
 #
-# Examples:
-#
-#     1. Introspect on virtio-net's VirtQueue 0 at index 5
+# .. qmp-example::
+#    :title: Introspect on virtio-net's VirtQueue 0 at index 5
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend",
@@ -870,7 +869,8 @@
 #          }
 #        }
 #
-#     2. Introspect on virtio-crypto's VirtQueue 1 at head
+# .. qmp-example::
+#    :title: Introspect on virtio-crypto's VirtQueue 1 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend",
@@ -898,7 +898,8 @@
 #          }
 #        }
 #
-#     3. Introspect on virtio-scsi's VirtQueue 2 at head
+# .. qmp-example::
+#    :title: Introspect on virtio-scsi's VirtQueue 2 at head
 #
 #     -> { "execute": "x-query-virtio-queue-element",
 #          "arguments": { "path": "/machine/peripheral-anon/device[2]/virtio-backend",
-- 
2.45.0


