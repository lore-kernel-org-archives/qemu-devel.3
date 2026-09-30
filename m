Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DA9CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrip-0001O5-MA; Wed, 30 Sep 2026 06:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrii-0001JB-Nz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jo-Q1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nz/PyBpYnRfdB4jrpIZcsjnwdyDqDaxZPa6U8FF27Cc=;
 b=WeQkHS/Pq4DxQpjqL87XZUys62oMSQEfrGn0k79d1tIorQfwqj9FOE1oJ+DbXGui4g+LXM
 D1k18vZklWgIV+hn03b8fB9RJj399RNZ2eGmSVHVX2/lfVLV3jOd9GZ/R+iV3tfn7FW1ux
 JLYYoVDrCZowvQwoAQpbuAHI0Lji0nQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-YtMiUqX0OGKuNSj8ReVYiA-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: YtMiUqX0OGKuNSj8ReVYiA-1
X-Mimecast-MFC-AGG-ID: YtMiUqX0OGKuNSj8ReVYiA_1790764759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DE319539B5; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EF331956045; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDA9621E689C; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 024/105] qapi: convert trivial intro sections for job.json
Date: Wed, 30 Sep 2026 12:37:49 +0200
Message-ID: <20260930103910.3934848-25-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260831201945.287730-25-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/job.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 31618e6ebc..b68d729242 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -9,8 +9,7 @@
 
 ##
 # @JobType:
-#
-# Type of a background job.
+#     Type of a background job.
 #
 # @commit: block commit job type, see `block-commit`
 #
@@ -42,8 +41,7 @@
 
 ##
 # @JobStatus:
-#
-# Indicates the present state of a given job in its lifetime.
+#     Indicates the present state of a given job in its lifetime.
 #
 # @undefined: Erroneous, default state.  Should not ever be visible.
 #
@@ -90,8 +88,7 @@
 
 ##
 # @JobVerb:
-#
-# Represents command verbs that can be applied to a job.
+#     Represents command verbs that can be applied to a job.
 #
 # @cancel: see `job-cancel`
 #
@@ -117,8 +114,7 @@
 
 ##
 # @JOB_STATUS_CHANGE:
-#
-# Emitted when a job transitions to a different status.
+#     Emitted when a job transitions to a different status.
 #
 # @id: The job identifier
 #
@@ -259,8 +255,7 @@
 
 ##
 # @JobInfo:
-#
-# Information about a job.
+#     Information about a job.
 #
 # @id: The job identifier
 #
@@ -294,8 +289,7 @@
 
 ##
 # @query-jobs:
-#
-# Return information about jobs.
+#     Return information about jobs.
 #
 # Returns: a list with info for each active job
 #
-- 
2.55.0


