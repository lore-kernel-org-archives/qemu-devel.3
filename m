Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF2CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBriq-0001Qt-UJ; Wed, 30 Sep 2026 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrii-0001JM-VY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kF-7w
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G2JGxtlGE0b0/dhDPGtPWvh3vl0LrlmHyOztjQN5Uw=;
 b=hPEgK1cMlDxegGXii4hk+Y6UOtR71o9WAlsWk30Y4PAghMnPZbc/NS2PRX9M/rRZsrNsRs
 cdsANe8PI761kSYnrOeaGJAR0MDvmtioxx+Hn3L5RnIBcy3onhUOURuf2wQ5JAlS357nQ/
 LLg8AC3OT3JQVMaE4yx0rox9DB3kWWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-m0irU2HAOFOGbkge7EKFmg-1; Wed,
 30 Sep 2026 06:39:22 -0400
X-MC-Unique: m0irU2HAOFOGbkge7EKFmg-1
X-Mimecast-MFC-AGG-ID: m0irU2HAOFOGbkge7EKFmg_1790764762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F25AF1801329; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF4E4195604D; Wed, 30 Sep 2026 10:39:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2EC6D21E681F; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 037/105] qapi: convert trivial intro sections for virtio.json
Date: Wed, 30 Sep 2026 12:38:02 +0200
Message-ID: <20260930103910.3934848-38-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260831201945.287730-38-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/virtio.json | 54 ++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44..9aafc3a212 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -10,8 +10,7 @@
 
 ##
 # @VirtioInfo:
-#
-# Basic information about a given VirtIODevice
+#     Basic information about a given VirtIODevice
 #
 # @path: The VirtIODevice's canonical QOM path
 #
@@ -25,8 +24,7 @@
 
 ##
 # @x-query-virtio:
-#
-# Return a list of all realized VirtIODevices
+#     Return a list of all realized VirtIODevices
 #
 # Features:
 #
@@ -189,8 +187,7 @@
 
 ##
 # @x-query-virtio-status:
-#
-# Poll for a comprehensive status of a given virtio device
+#     Poll for a comprehensive status of a given virtio device
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
@@ -442,9 +439,8 @@
 
 ##
 # @VirtioDeviceStatus:
-#
-# A structure defined to list the configuration statuses of a virtio
-# device
+#     A structure defined to list the configuration statuses of a
+#     virtio device
 #
 # @statuses: List of decoded configuration statuses of the virtio
 #     device
@@ -460,9 +456,8 @@
 
 ##
 # @VhostDeviceProtocols:
-#
-# A structure defined to list the vhost user protocol features of a
-# Vhost User device
+#     A structure defined to list the vhost user protocol features of
+#     a Vhost User device
 #
 # @protocols: List of decoded vhost user protocol features of a vhost
 #     user device
@@ -503,9 +498,8 @@
 
 ##
 # @VirtQueueStatus:
-#
-# Information of a VirtIODevice VirtQueue, including most members of
-# the VirtQueue data structure.
+#     Information of a VirtIODevice VirtQueue, including most members
+#     of the VirtQueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -556,8 +550,7 @@
 
 ##
 # @x-query-virtio-queue-status:
-#
-# Return the status of a given VirtIODevice's VirtQueue
+#     Return the status of a given VirtIODevice's VirtQueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -640,9 +633,8 @@
 
 ##
 # @VirtVhostQueueStatus:
-#
-# Information of a vhost device's vhost_virtqueue, including most
-# members of the vhost_dev vhost_virtqueue data structure.
+#     Information of a vhost device's vhost_virtqueue, including most
+#     members of the vhost_dev vhost_virtqueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this vhost_virtqueue
 #
@@ -682,8 +674,7 @@
 
 ##
 # @x-query-virtio-vhost-queue-status:
-#
-# Return information of a given vhost device's vhost_virtqueue
+#     Return information of a given vhost device's vhost_virtqueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -746,8 +737,7 @@
 
 ##
 # @VirtioRingDesc:
-#
-# Information regarding the vring descriptor area
+#     Information regarding the vring descriptor area
 #
 # @addr: Guest physical address of the descriptor area
 #
@@ -797,9 +787,8 @@
 
 ##
 # @VirtioQueueElement:
-#
-# Information regarding a VirtQueue's VirtQueueElement including
-# descriptor, driver, and device areas
+#     Information regarding a VirtQueue's VirtQueueElement including
+#     descriptor, driver, and device areas
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -822,8 +811,7 @@
 
 ##
 # @x-query-virtio-queue-element:
-#
-# Return the information about a VirtQueue's VirtQueueElement
+#     Return the information about a VirtQueue's VirtQueueElement
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -933,8 +921,7 @@
 
 ##
 # @IOThreadVirtQueueMapping:
-#
-# Describes the subset of virtqueues assigned to an IOThread.
+#     Describes the subset of virtqueues assigned to an IOThread.
 #
 # @iothread: the id of IOThread object
 #
@@ -973,9 +960,8 @@
 
 ##
 # @DummyVirtioForceArrays:
-#
-# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList and
-# VirtIOGPUOutputList internally
+#     Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
+#     and VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
-- 
2.55.0


