Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C5EC982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8l0A-0007Lc-8i; Mon, 21 Sep 2026 16:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l06-0007HV-K1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l05-0002Uu-57
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbTXbi2v0zTkwi8r44EEN84EGkaiyjPWQ1x+oKv7biI=;
 b=EK6H3C+oeKhDXW08F6J+VaCwranemg1cDtTd6Sg+lKcQXLSq1Lbl4rNOGe2+mLN0l4tmQy
 ym+Du85P8qG/tk8rIA2NRA5g2oMp3dYvnM3Fm8+WxKx73cyYV9OEITTdkhbsa9N7ED9nb+
 rEyskF4EP6jFA4BFvSEtvnuaF3t3aKU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-hbECGmAAOcC2Cmg2_sX8sQ-1; Mon,
 21 Sep 2026 16:52:28 -0400
X-MC-Unique: hbECGmAAOcC2Cmg2_sX8sQ-1
X-Mimecast-MFC-AGG-ID: hbECGmAAOcC2Cmg2_sX8sQ_1790023947
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB892185BE92; Mon, 21 Sep 2026 20:52:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A20BB40E; Mon, 21 Sep 2026 20:52:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 8/9] qapi: convert intro sections for
 docs/interop/vhost-user.json
Date: Mon, 21 Sep 2026 16:51:46 -0400
Message-ID: <20260921205147.1857168-9-jsnow@redhat.com>
In-Reply-To: <20260921205147.1857168-1-jsnow@redhat.com>
References: <20260921205147.1857168-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All conversions in this patch do not add a new insertion point, except
for the very last conversion.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/vhost-user.json | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index 29c84e86e55..65e681a166a 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -17,8 +17,7 @@
 
 ##
 # @VHostUserBackendType:
-#
-# List the various vhost user backend types.
+#     List the various vhost user backend types.
 #
 # @9p: 9p virtio console
 #
@@ -75,8 +74,7 @@
 
 ##
 # @VHostUserBackendBlockFeature:
-#
-# List of vhost user "block" features.
+#     List of vhost user "block" features.
 #
 # @read-only: The --read-only command line option is supported.
 #
@@ -91,8 +89,7 @@
 
 ##
 # @VHostUserBackendCapabilitiesBlock:
-#
-# Capabilities reported by vhost user "block" backends
+#     Capabilities reported by vhost user "block" backends
 #
 # @features: list of supported features.
 #
@@ -107,8 +104,7 @@
 
 ##
 # @VHostUserBackendInputFeature:
-#
-# List of vhost user "input" features.
+#     List of vhost user "input" features.
 #
 # @evdev-path: The --evdev-path command line option is supported.
 #
@@ -123,8 +119,7 @@
 
 ##
 # @VHostUserBackendCapabilitiesInput:
-#
-# Capabilities reported by vhost user "input" backends
+#     Capabilities reported by vhost user "input" backends
 #
 # @features: list of supported features.
 #
@@ -139,8 +134,7 @@
 
 ##
 # @VHostUserBackendGPUFeature:
-#
-# List of vhost user "gpu" features.
+#     List of vhost user "gpu" features.
 #
 # @render-node: The --render-node command line option is supported.
 #
@@ -155,8 +149,7 @@
 
 ##
 # @VHostUserBackendCapabilitiesGPU:
-#
-# Capabilities reported by vhost user "gpu" backends.
+#     Capabilities reported by vhost user "gpu" backends.
 #
 # @features: list of supported features.
 #
@@ -171,8 +164,7 @@
 
 ##
 # @VHostUserBackendCapabilities:
-#
-# Capabilities reported by vhost user backends.
+#     Capabilities reported by vhost user backends.
 #
 # @type: The vhost user backend type.
 #
@@ -190,8 +182,7 @@
 
 ##
 # @VhostUserBackend:
-#
-# Describes a vhost user backend to management software.
+#     Describes a vhost user backend to management software.
 #
 # It is possible for multiple @VhostUserBackend elements to match the
 # search criteria of management software.  Applications thus need
-- 
2.55.0


