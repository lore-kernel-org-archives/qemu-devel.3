Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E65DCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrk1-0003XA-6x; Wed, 30 Sep 2026 06:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001cq-Ax
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qO-Bf
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODrhMjBJM3Xg0TZxv/hvqzHKfYdTg1EtwNlYQkU5Ew8=;
 b=SUe7J5ZOyjshDpZOMFQaS1X+1AxwTsTL49vj/j1yK5pB0cqOqsFRJYV0vDoxhpl0/BQAhf
 XkFQ7YjwkOhHBvyosozw13bb1fK2CKYXZqqoLrAEtN92lTBXjgDoWUHFUYoh0+5s3NDTVm
 uqOZTpC2R3DOSYoDnZTjsTVOHo1mfWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-Da2HP9iRNDectKV064gYWg-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: Da2HP9iRNDectKV064gYWg-1
X-Mimecast-MFC-AGG-ID: Da2HP9iRNDectKV064gYWg_1790764770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CDFD1953977; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B43C1800361; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B04221E5B81; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 104/105] qapi: split intro sections for data structs
Date: Wed, 30 Sep 2026 12:39:09 +0200
Message-ID: <20260930103910.3934848-105-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The structs of concern in this patch are those for which no other QAPI
definition (currently) uses as a data type to describe its own
arguments or as a branch of a union: i.e. they are not currently
eligible to be inlined and as such the precise semantics of their
intro/details split is *currently* of less concern.

Of course, they could be inlined in the future, so the semantics of
this split are still worth investigating.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-10-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/acpi.json       | 3 +--
 qapi/block-core.json | 5 ++---
 qapi/compat.json     | 5 ++---
 qapi/machine.json    | 9 ++++-----
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 291a04a7ea..82e82d7cf8 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -13,8 +13,7 @@
 
 ##
 # @AcpiTableOptions:
-#
-# Specify an ACPI table on the command line to load.
+#     Specify an ACPI table on the command line to load.
 #
 # At most one of @file and @data can be specified.  The list of files
 # specified by any one of them is loaded and concatenated in order.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 13981d7e69..741c8165c0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -843,9 +843,8 @@
 
 ##
 # @BlockMeasureInfo:
-#
-# Image file size calculation information.  This structure describes
-# the size requirements for creating a new image file.
+#     Image file size calculation information.  This structure
+#     describes the size requirements for creating a new image file.
 #
 # The size requirements depend on the new image file format.  File
 # size always equals virtual disk size for the 'raw' format, even for
diff --git a/qapi/compat.json b/qapi/compat.json
index a512c77ffd..0f90ea1f52 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -53,10 +53,9 @@
 
 ##
 # @CompatPolicy:
+#     Policy for handling deprecated management interfaces.
 #
-# Policy for handling deprecated management interfaces.
-#
-# This is intended for testing users of the management interfaces.
+#     This is intended for testing users of the management interfaces.
 #
 # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
 # with feature 'deprecated' or 'unstable'.  We may want to extend it
diff --git a/qapi/machine.json b/qapi/machine.json
index 75cbeca185..d09424b870 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1634,9 +1634,9 @@
 
 ##
 # @SMPConfiguration:
-#
-# Schema for CPU topology configuration.  A missing value lets QEMU
-# figure out a suitable value based on the ones that are provided.
+#     Schema for CPU topology configuration.  A missing value lets
+#     QEMU figure out a suitable value based on the ones that are
+#     provided.
 #
 # The members other than @cpus and @maxcpus define a topology of
 # containers.
@@ -1895,8 +1895,7 @@
 
 ##
 # @CpuModelInfo:
-#
-# Virtual CPU model.
+#     Virtual CPU model.
 #
 # A CPU model consists of the name of a CPU definition, to which delta
 # changes are applied (e.g. features added/removed).  Most magic
-- 
2.55.0


