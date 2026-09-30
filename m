Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE92CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBric-0001F0-CM; Wed, 30 Sep 2026 06:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrib-0001EQ-IJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriZ-0006gY-F9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YHdv6ZyKGaGIEw0jfAX+qfSZYgSvBi7LRUaiMCFofPU=;
 b=LCZS0cDBC9gbnWL87mnpx4ib67nEcrw6W/70x7cK6YwEP1oj0ES/KtK17GdZvqlSarPCWl
 PzZtnGYSVYT6ZHW6sZdt1qFaS4MZPrIfOancjjIllVY4xDRIan3Lh1hIl7/khGIuUOb1cP
 wO+JEYXX/vZ+SG40K2tiBnmzipwqIc4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-YEYo0ZU2PNOV0HdRQo0xmw-1; Wed,
 30 Sep 2026 06:39:17 -0400
X-MC-Unique: YEYo0ZU2PNOV0HdRQo0xmw-1
X-Mimecast-MFC-AGG-ID: YEYo0ZU2PNOV0HdRQo0xmw_1790764756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624841801238; Wed, 30 Sep 2026 10:39:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 176B53000218; Wed, 30 Sep 2026 10:39:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5D4421E688A; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 010/105] qapi: convert trivial intro sections for
 accelerator.json
Date: Wed, 30 Sep 2026 12:37:35 +0200
Message-ID: <20260930103910.3934848-11-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260831201945.287730-11-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/accelerator.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index b59df37866..efc0fa8141 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -13,8 +13,7 @@
 
 ##
 # @KvmInfo:
-#
-# Information about support for KVM acceleration
+#     Information about support for KVM acceleration
 #
 # @enabled: true if KVM acceleration is active
 #
@@ -26,8 +25,7 @@
 
 ##
 # @query-kvm:
-#
-# Return information about KVM acceleration
+#     Return information about KVM acceleration
 #
 # Features:
 #
@@ -46,8 +44,7 @@
 
 ##
 # @x-accel-stats:
-#
-# Query accelerator statistics
+#     Query accelerator statistics
 #
 # Features:
 #
@@ -63,8 +60,7 @@
 
 ##
 # @Accelerator:
-#
-# Information about support for MSHV acceleration
+#     Information about support for MSHV acceleration
 #
 # @hvf: Apple Hypervisor.framework
 #
@@ -88,8 +84,7 @@
 
 ##
 # @AcceleratorInfo:
-#
-# Information about support for various accelerators
+#     Information about support for various accelerators
 #
 # @enabled: the accelerator that is in use
 #
@@ -102,8 +97,7 @@
 
 ##
 # @query-accelerators:
-#
-# Return information about accelerators
+#     Return information about accelerators
 #
 # Returns: @AcceleratorInfo
 #
-- 
2.55.0


