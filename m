Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078DCA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBril-0001Ks-Dh; Wed, 30 Sep 2026 06:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrig-0001I1-Fv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jL-B4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9Ehh17+wTgva7+02DYQhqMZL87xITRCOLJ+p3hjswA=;
 b=AxAR1TlSAS2rLecjO9qG+Vc7i4rH2RSuRyYzwNvXGX6nKFuUNqpuAlOSW8gu6gL4z6PJ2/
 v2in2Pojad+2F1pCLrBhYkarIEYqyRy6urgMt3B9qPAvexdXFofxvm91SRweukXUk2SKaG
 dymUIotbHmNBonIljh4FVdFMknkdGxA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-chUUI2hPPQWpibPuurJtKQ-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: chUUI2hPPQWpibPuurJtKQ-1
X-Mimecast-MFC-AGG-ID: chUUI2hPPQWpibPuurJtKQ_1790764759
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FD401801239; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD88430001BE; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5DF221E689A; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 022/105] qapi: convert trivial intro sections for
 transaction.json
Date: Wed, 30 Sep 2026 12:37:47 +0200
Message-ID: <20260930103910.3934848-23-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
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
Message-ID: <20260831201945.287730-23-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/transaction.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf3..c0dc811ba6 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -12,8 +12,7 @@
 
 ##
 # @Abort:
-#
-# This action can be used to test transaction failure.
+#     This action can be used to test transaction failure.
 #
 # Since: 1.6
 ##
@@ -22,8 +21,7 @@
 
 ##
 # @ActionCompletionMode:
-#
-# An enumeration of transactional completion modes.
+#     An enumeration of transactional completion modes.
 #
 # @individual: Do not attempt to cancel any other Actions if any
 #     Actions fail after the Transaction request succeeds.  All
@@ -156,9 +154,8 @@
 
 ##
 # @TransactionAction:
-#
-# A discriminated record of operations that can be performed with
-# `transaction`.
+#     A discriminated record of operations that can be performed with
+#     `transaction`.
 #
 # @type: the operation to be performed
 #
@@ -184,8 +181,7 @@
 
 ##
 # @TransactionProperties:
-#
-# Optional arguments to modify the behavior of a Transaction.
+#     Optional arguments to modify the behavior of a Transaction.
 #
 # @completion-mode: Controls how jobs launched asynchronously by
 #     Actions will complete or fail as a group.  See
-- 
2.55.0


