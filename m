Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D73BCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrig-0001IB-SR; Wed, 30 Sep 2026 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0001GI-A9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBric-0006iE-82
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkQc4Zhb4kPWntv1tALkrIYHWpU/4az2LiZ9R6Fnltg=;
 b=bjYQyaiBxWHWz6eLXIO7dCT2Sgq599FBGmAekMBmdehWOVNJYJBnKm2OydJTKa2CcCadJT
 hObVwnStWz7K7pFuCqHFAEJeqztxXuc2zEh9mbIcS86ushHNwUpmw+X0HDSuaOtqeTO+kX
 ZVx4CSLnvl2RGx9H6y+rvQKRt4Qyhig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-MLpUX3TDM3aqkr0L8uR_kg-1; Wed,
 30 Sep 2026 06:39:19 -0400
X-MC-Unique: MLpUX3TDM3aqkr0L8uR_kg-1
X-Mimecast-MFC-AGG-ID: MLpUX3TDM3aqkr0L8uR_kg_1790764759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B60719540D5; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD419195604D; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA01E21E6897; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 019/105] qapi: convert trivial intro sections for dump.json
Date: Wed, 30 Sep 2026 12:37:44 +0200
Message-ID: <20260930103910.3934848-20-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260831201945.287730-20-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/dump.json | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 690f3963fe..520c58cbcd 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -12,8 +12,7 @@
 
 ##
 # @DumpGuestMemoryFormat:
-#
-# An enumeration of guest-memory-dump's format.
+#     An enumeration of guest-memory-dump's format.
 #
 # @elf: elf format
 #
@@ -116,8 +115,8 @@
 
 ##
 # @DumpStatus:
-#
-# Describe the status of a long-running background guest memory dump.
+#     Describe the status of a long-running background guest memory
+#     dump.
 #
 # @none: no `dump-guest-memory` has started yet.
 #
@@ -134,8 +133,7 @@
 
 ##
 # @DumpQueryResult:
-#
-# The result format for `query-dump`.
+#     The result format for `query-dump`.
 #
 # @status: enum of `DumpStatus`, which shows current dump status
 #
@@ -152,8 +150,7 @@
 
 ##
 # @query-dump:
-#
-# Query latest dump status.
+#     Query latest dump status.
 #
 # Returns: An object showing the dump status.
 #
@@ -169,8 +166,7 @@
 
 ##
 # @DUMP_COMPLETED:
-#
-# Emitted when background dump has completed
+#     Emitted when background dump has completed
 #
 # @result: final dump status
 #
@@ -203,8 +199,7 @@
 
 ##
 # @query-dump-guest-memory-capability:
-#
-# Return the available formats for `dump-guest-memory`
+#     Return the available formats for `dump-guest-memory`
 #
 # Returns: An object listing available formats for `dump-guest-memory`
 #
-- 
2.55.0


