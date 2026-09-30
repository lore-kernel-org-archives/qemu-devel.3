Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC5CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrih-0001Il-SR; Wed, 30 Sep 2026 06:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0001GJ-A4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBric-0006iC-9h
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGU43vtM029oHOjAOp+gEVOqO5wZxYeP/X2E9ZcXfW8=;
 b=OeBXrdBYG7HwNBnQOlZ0xjje0apRuNPqzjQ/5DjcSsCskOXAyc+67OgtEZOIHe0i/CUF5A
 JTrKRHGa9h+Ef37sWHhic5+90M4p30cCyG8MOFZTx5mnYrRLyzNksUepbS6Muoqj5OCj3M
 nbLh9PTxfd6ZJKYAvMzqOF1vQmeGKws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-GBJ_4N0hOGmgYs9q6VSPrA-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: GBJ_4N0hOGmgYs9q6VSPrA-1
X-Mimecast-MFC-AGG-ID: GBJ_4N0hOGmgYs9q6VSPrA_1790764759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C0941802143; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00BB195604F; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9B1721E689B; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 023/105] qapi: convert trivial intro sections for stats.json
Date: Wed, 30 Sep 2026 12:37:48 +0200
Message-ID: <20260930103910.3934848-24-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Message-ID: <20260831201945.287730-24-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/stats.json | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/qapi/stats.json b/qapi/stats.json
index a98624531c..af57ec0854 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -16,8 +16,7 @@
 
 ##
 # @StatsType:
-#
-# Enumeration of statistics types
+#     Enumeration of statistics types
 #
 # @cumulative: stat is cumulative; value can only increase.
 #
@@ -38,8 +37,7 @@
 
 ##
 # @StatsUnit:
-#
-# Enumeration of unit of measurement for statistics
+#     Enumeration of unit of measurement for statistics
 #
 # @bytes: stat reported in bytes.
 #
@@ -56,8 +54,7 @@
 
 ##
 # @StatsProvider:
-#
-# Enumeration of statistics providers.
+#     Enumeration of statistics providers.
 #
 # @kvm: since 7.1
 #
@@ -70,8 +67,7 @@
 
 ##
 # @StatsTarget:
-#
-# The kinds of objects on which one can request statistics.
+#     The kinds of objects on which one can request statistics.
 #
 # @vm: statistics that apply to the entire virtual machine or the
 #     entire QEMU process.
@@ -87,9 +83,8 @@
 
 ##
 # @StatsRequest:
-#
-# Indicates a set of statistics that should be returned by
-# `query-stats`.
+#     Indicates a set of statistics that should be returned by
+#     `query-stats`.
 #
 # @provider: provider for which to return statistics.
 #
@@ -113,10 +108,9 @@
 
 ##
 # @StatsFilter:
-#
-# The arguments to the `query-stats` command; specifies a target for
-# which to request statistics and optionally the required subset of
-# information for that target.
+#     The arguments to the `query-stats` command; specifies a target
+#     for which to request statistics and optionally the required
+#     subset of information for that target.
 #
 # @target: the kind of objects to query.  Note that each possible
 #     target may enable additional filtering options
@@ -200,8 +194,7 @@
 
 ##
 # @StatsSchemaValue:
-#
-# Schema for a single statistic.
+#     Schema for a single statistic.
 #
 # @name: name of the statistic; each element of the schema is uniquely
 #     identified by a target, a provider (both available in
@@ -236,8 +229,7 @@
 
 ##
 # @StatsSchema:
-#
-# Schema for all available statistics for a provider and target.
+#     Schema for all available statistics for a provider and target.
 #
 # @provider: provider for this set of statistics.
 #
@@ -255,8 +247,8 @@
 
 ##
 # @query-stats-schemas:
-#
-# Return the schema for all available runtime-collected statistics.
+#     Return the schema for all available runtime-collected
+#     statistics.
 #
 # @provider: a provider to restrict the query to.
 #
-- 
2.55.0


