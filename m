Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CF5CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrij-0001JZ-Hd; Wed, 30 Sep 2026 06:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0001GM-Bs
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBric-0006i8-Ac
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vBVNQu4d1hQhCSG0R+yEYky2jf3vRQ49UXlVbqONmA=;
 b=faZUb7pzNIgxO9OaPxrKnBJTrQHxsUAmyEmfJZh0L96ayorqCnGWqigomij5BSUfzGQrKL
 V0pYVnKDp1erPxbb674T03D1gLVv332ZMNTZTNuJm7A6nkc3P9uRy5y8Sn9JzB/OVxBZ6Q
 bN+a6rbYJvElbcDkHtX+4soMH0Z7KJ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-iu_eUcuFPUKvphi5Q5BOpw-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: iu_eUcuFPUKvphi5Q5BOpw-1
X-Mimecast-MFC-AGG-ID: iu_eUcuFPUKvphi5Q5BOpw_1790764759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A3EC185FE55; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F008419560AB; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDF0221E6898; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 020/105] qapi: convert trivial intro sections for common.json
Date: Wed, 30 Sep 2026 12:37:45 +0200
Message-ID: <20260930103910.3934848-21-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Message-ID: <20260831201945.287730-21-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a..c1bbed21e7 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -9,8 +9,7 @@
 
 ##
 # @IoOperationType:
-#
-# An enumeration of the I/O operation types
+#     An enumeration of the I/O operation types
 #
 # @read: read operation
 #
@@ -23,8 +22,7 @@
 
 ##
 # @OnOffAuto:
-#
-# An enumeration of three options: on, off, and auto
+#     An enumeration of three options: on, off, and auto
 #
 # @auto: QEMU selects the value between on and off
 #
@@ -39,8 +37,7 @@
 
 ##
 # @OnOffSplit:
-#
-# An enumeration of three values: on, off, and split
+#     An enumeration of three values: on, off, and split
 #
 # @on: Enabled
 #
@@ -72,8 +69,7 @@
 
 ##
 # @OffAutoPCIBAR:
-#
-# An enumeration of options for specifying a PCI BAR
+#     An enumeration of options for specifying a PCI BAR
 #
 # @off: The specified feature is disabled
 #
@@ -98,8 +94,7 @@
 
 ##
 # @PCIELinkSpeed:
-#
-# An enumeration of PCIe link speeds in units of GT/s
+#     An enumeration of PCIe link speeds in units of GT/s
 #
 # @2_5: 2.5GT/s
 #
@@ -120,8 +115,7 @@
 
 ##
 # @PCIELinkWidth:
-#
-# An enumeration of PCIe link width
+#     An enumeration of PCIe link width
 #
 # @1: x1
 #
@@ -144,8 +138,7 @@
 
 ##
 # @HostMemPolicy:
-#
-# Host memory policy types
+#     Host memory policy types
 #
 # @default: restore default policy, remove any nondefault policy
 #
@@ -164,9 +157,8 @@
 
 ##
 # @NetFilterDirection:
-#
-# Indicates whether a netfilter is attached to a netdev's transmit
-# queue or receive queue or both.
+#     Indicates whether a netfilter is attached to a netdev's transmit
+#     queue or receive queue or both.
 #
 # @all: the filter is attached both to the receive and the transmit
 #     queue of the netdev (default).
@@ -184,8 +176,7 @@
 
 ##
 # @GrabToggleKeys:
-#
-# Key combinations to toggle input-linux between host and guest.
+#     Key combinations to toggle input-linux between host and guest.
 #
 # @ctrl-ctrl: left and right control key
 #
-- 
2.55.0


