Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300FACA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrja-0002MD-6H; Wed, 30 Sep 2026 06:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrih-0001Ib-Bw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jk-LY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nG7sZBQv2L99QbVb/u2NcnDSXKCpVU1O/GHK4Vo4RLg=;
 b=bPoNhuzq885c+BcVjDW0+6ooibW3EB7C7DvpgKUyZNjRBDgcHMmDW3TS7Kt2TkXPjYvtGK
 tPKnkXTebtSAzkgpPJ4xaF+vJEctwF9c3NH/VUJ9G0XV2g1R3F01juUbJZlZzO+EOUAaIg
 OXleMZt06YFOafMBMiIW8J3vtNLBZwU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-OlST4qHFPwyzOm9rUYkfnQ-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: OlST4qHFPwyzOm9rUYkfnQ-1
X-Mimecast-MFC-AGG-ID: OlST4qHFPwyzOm9rUYkfnQ_1790764759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30B3F18011F8; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1D361800592; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0592D21E689F; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 027/105] qapi: convert trivial intro sections for rocker.json
Date: Wed, 30 Sep 2026 12:37:52 +0200
Message-ID: <20260930103910.3934848-28-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260831201945.287730-28-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/rocker.json | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd2603..7eb0a88daf 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -9,8 +9,7 @@
 
 ##
 # @RockerSwitch:
-#
-# Rocker switch information.
+#     Rocker switch information.
 #
 # @name: switch name
 #
@@ -25,8 +24,7 @@
 
 ##
 # @query-rocker:
-#
-# Return rocker switch information.
+#     Return rocker switch information.
 #
 # @name: switch name
 #
@@ -43,8 +41,7 @@
 
 ##
 # @RockerPortDuplex:
-#
-# An enumeration of port duplex states.
+#     An enumeration of port duplex states.
 #
 # @half: half duplex
 #
@@ -56,8 +53,7 @@
 
 ##
 # @RockerPortAutoneg:
-#
-# An enumeration of port autoneg states.
+#     An enumeration of port autoneg states.
 #
 # @off: autoneg is off
 #
@@ -69,8 +65,7 @@
 
 ##
 # @RockerPort:
-#
-# Rocker switch port information.
+#     Rocker switch port information.
 #
 # @name: port name
 #
@@ -93,8 +88,7 @@
 
 ##
 # @query-rocker-ports:
-#
-# Return rocker switch port information.
+#     Return rocker switch port information.
 #
 # @name: port name
 #
@@ -115,8 +109,7 @@
 
 ##
 # @RockerOfDpaFlowKey:
-#
-# Rocker switch OF-DPA flow key
+#     Rocker switch OF-DPA flow key
 #
 # @priority: key priority, 0 being lowest priority
 #
@@ -153,8 +146,7 @@
 
 ##
 # @RockerOfDpaFlowMask:
-#
-# Rocker switch OF-DPA flow mask
+#     Rocker switch OF-DPA flow mask
 #
 # @in-pport: physical input port
 #
@@ -182,8 +174,7 @@
 
 ##
 # @RockerOfDpaFlowAction:
-#
-# Rocker switch OF-DPA flow action
+#     Rocker switch OF-DPA flow action
 #
 # @goto-tbl: next table ID
 #
@@ -209,8 +200,7 @@
 
 ##
 # @RockerOfDpaFlow:
-#
-# Rocker switch OF-DPA flow
+#     Rocker switch OF-DPA flow
 #
 # @cookie: flow unique cookie ID
 #
@@ -230,8 +220,7 @@
 
 ##
 # @query-rocker-of-dpa-flows:
-#
-# Return rocker OF-DPA flow information.
+#     Return rocker OF-DPA flow information.
 #
 # @name: switch name
 #
@@ -261,8 +250,7 @@
 
 ##
 # @RockerOfDpaGroup:
-#
-# Rocker switch OF-DPA group
+#     Rocker switch OF-DPA group
 #
 # @id: group unique ID
 #
@@ -305,8 +293,7 @@
 
 ##
 # @query-rocker-of-dpa-groups:
-#
-# Return rocker OF-DPA group information.
+#     Return rocker OF-DPA group information.
 #
 # @name: switch name
 #
-- 
2.55.0


