Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D122DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dq-00042y-55; Wed, 17 Jul 2024 06:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dp-0003z8-AZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dm-0001UZ-5I
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbcDEEaPE919fjyUmul4O3sjbuQsff1pD0ZkfL6adD4=;
 b=FCU2Qdq5H3sT5p47ctLn+/8B3/ALke5wtXAH3PRrHFBIbxLLzSpod0hzPYnx53v7vOTTFi
 wRtHsrpWisCtKaKpSrXsk36qbjfBi+zvBfuaueu/4N7FmJM45edCkAvtR/MxbBLUKwokqE
 8mg6XolGwN92OcvOeT+IiJ17u073LJ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-_65XdBNcPK-COzbPo71HUg-1; Wed,
 17 Jul 2024 06:49:14 -0400
X-MC-Unique: _65XdBNcPK-COzbPo71HUg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E705B1955BEF; Wed, 17 Jul 2024 10:49:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E9BE1955F6B; Wed, 17 Jul 2024 10:49:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E020021F4B93; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 13/14] qapi: convert "Example" sections with longer prose
Date: Wed, 17 Jul 2024 12:49:06 +0200
Message-ID: <20240717104907.2962784-14-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These examples require longer explanations or have explanations that
require markup to look reasonable when rendered and so use the longer
form of the ".. qmp-example::" directive.

By using the :annotated: option, the content in the example block is
assumed *not* to be a code block literal and is instead parsed as normal
rST - with the exception that any code literal blocks after `::` will
assumed to be a QMP code literal block.

Note: There's one title-less conversion in this patch that comes along
for the ride because it's part of a larger "Examples" block that was
better to convert all at once.

See commit-5: "docs/qapidoc: create qmp-example directive", for a
              detailed explanation of this custom directive syntax.

See commit+1: "qapi: remove "Example" doc section" for a detailed
              explanation of why.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240717021312.606116-9-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json     | 30 +++++++++++++++++++-----------
 qapi/machine.json   | 30 ++++++++++++++++++++----------
 qapi/migration.json |  7 +++++--
 qapi/virtio.json    | 24 ++++++++++++++++++------
 4 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 5ddd061e96..ce9490a367 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -545,31 +545,37 @@
 #
 # Since: 4.0
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histograms for all io types with intervals
-#     [0, 10), [10, 50), [50, 100), [100, +inf):
+#    Set new histograms for all io types with intervals
+#    [0, 10), [10, 50), [50, 100), [100, +inf)::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histogram only for write, other histograms will remain
-#     not changed (or not created):
+#    Set new histogram only for write, other histograms will remain
+#    not changed (or not created)::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
 #                         "boundaries-write": [10, 50, 100] } }
 #     <- { "return": {} }
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     Set new histograms with the following intervals:
-#       read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
-#       write: [0, 1000), [1000, 5000), [5000, +inf)
+#    Set new histograms with the following intervals:
+#
+#    - read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
+#    - write: [0, 1000), [1000, 5000), [5000, +inf)
+#
+#    ::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0",
@@ -578,7 +584,9 @@
 #     <- { "return": {} }
 #
 # .. qmp-example::
-#    :title: Remove all latency histograms
+#    :annotated:
+#
+#    Remove all latency histograms::
 #
 #     -> { "execute": "block-latency-histogram-set",
 #          "arguments": { "id": "drive0" } }
diff --git a/qapi/machine.json b/qapi/machine.json
index 193b2b7c16..f9ea6b3e97 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1045,10 +1045,11 @@
 #
 # Since: 2.7
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     For pseries machine type started with -smp 2,cores=2,maxcpus=4
-#     -cpu POWER8:
+#    For pseries machine type started with
+#    ``-smp 2,cores=2,maxcpus=4 -cpu POWER8``::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1058,7 +1059,10 @@
 #            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
 #        ]}
 #
-#     For pc machine type started with -smp 1,maxcpus=2:
+# .. qmp-example::
+#    :annotated:
+#
+#    For pc machine type started with ``-smp 1,maxcpus=2``::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1073,8 +1077,11 @@
 #          }
 #        ]}
 #
-#     For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2
-#     -cpu qemu (Since: 2.11):
+# .. qmp-example::
+#    :annotated:
+#
+#    For s390x-virtio-ccw machine type started with
+#    ``-smp 1,maxcpus=2 -cpu qemu`` (Since: 2.11)::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
@@ -1128,12 +1135,15 @@
 #
 # Since: 0.14
 #
-# Example:
+# .. qmp-example::
+#    :annotated:
 #
-#     -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-#     <- { "return": {} }
+#    ::
 #
-#     With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#      -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+#      <- { "return": {} }
+#
+#    With a 2.5GiB guest this command inflated the ballon to 3GiB.
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 74968a1417..073b67c052 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2106,13 +2106,16 @@
 #
 # Since: 5.2
 #
-# Example:
+# .. qmp-example::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
 #                                                     "sample-pages": 512} }
 #     <- { "return": {} }
 #
-#     Measure dirty rate using dirty bitmap for 500 milliseconds:
+# .. qmp-example::
+#    :annotated:
+#
+#    Measure dirty rate using dirty bitmap for 500 milliseconds::
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
 #         "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
diff --git a/qapi/virtio.json b/qapi/virtio.json
index d965c98ad2..26df8b3064 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -203,9 +203,11 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     1. Poll for the status of virtio-crypto (no vhost-crypto active)
+#    Poll for the status of virtio-crypto (no vhost-crypto active)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral/crypto0/virtio-backend" }
@@ -261,7 +263,11 @@
 #          }
 #        }
 #
-#     2. Poll for the status of virtio-net (vhost-net is active)
+# .. qmp-example::
+#    :annotated:
+#
+#    Poll for the status of virtio-net (vhost-net is active)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[1]/virtio-backend" }
@@ -568,9 +574,11 @@
 #
 # Since: 7.2
 #
-# Examples:
+# .. qmp-example::
+#    :annotated:
 #
-#     1. Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#    Get VirtQueueStatus for virtio-vsock (vhost-vsock running)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral/vsock0/virtio-backend",
@@ -593,7 +601,11 @@
 #          }
 #        }
 #
-#     2. Get VirtQueueStatus for virtio-serial (no vhost)
+# .. qmp-example::
+#    :annotated:
+#
+#    Get VirtQueueStatus for virtio-serial (no vhost)
+#    ::
 #
 #     -> { "execute": "x-query-virtio-queue-status",
 #          "arguments": { "path": "/machine/peripheral-anon/device[0]/virtio-backend",
-- 
2.45.0


