Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A94FC5B54E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouM-00042I-5Z; Tue, 27 May 2025 03:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouK-00041W-Ri
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007r3-Vg
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ewf66Al5C3RfYoFXB3spnpREuZg4JBuQ+HSzgbGtVc=;
 b=i78F3f/rRTSX0yqv799KC4hRn6lpHnnOwnd6+CRGE9uAwv6kDX0jjpIDU6SjGPqUlCaILQ
 z6Jp6ufIhLrilzUxJGcApIESATsimMcCCQIUQQgInpM2u7mXWEK3skDde1He68B/3UqNyK
 GwCzqWkKGDuPN3qN1DWZ/eOt7zUlP3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-oWHNWWHEMEaCBuesbCINUw-1; Tue,
 27 May 2025 03:39:23 -0400
X-MC-Unique: oWHNWWHEMEaCBuesbCINUw-1
X-Mimecast-MFC-AGG-ID: oWHNWWHEMEaCBuesbCINUw_1748331563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD78C1800256; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5022E180010A; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C0CA21E65E0; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 07/13] qapi: Fix capitalization in doc comments
Date: Tue, 27 May 2025 09:39:10 +0200
Message-ID: <20250527073916.1243024-8-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json  | 6 +++---
 qapi/block.json       | 2 +-
 qapi/cryptodev.json   | 2 +-
 qapi/cxl.json         | 2 +-
 qapi/machine.json     | 2 +-
 qapi/misc-target.json | 2 +-
 qapi/run-state.json   | 2 +-
 qapi/transaction.json | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b6447e847e..f0faca1054 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1337,7 +1337,7 @@
 # bitmap when used for data copy operations.
 #
 # @on-success: The bitmap is only synced when the operation is
-#     successful.  This is the behavior always used for 'INCREMENTAL'
+#     successful.  This is the behavior always used for incremental
 #     backups.
 #
 # @never: The bitmap is never synchronized with the operation, and is
@@ -1589,7 +1589,7 @@
 #
 # @bitmap-mode: Specifies the type of data the bitmap should contain
 #     after the operation concludes.  Must be present if a bitmap was
-#     provided, Must NOT be present otherwise.  (Since 4.2)
+#     provided, must NOT be present otherwise.  (Since 4.2)
 #
 # @compress: true to compress data, if the target format supports it.
 #     (default: false) (since 2.8)
@@ -1840,7 +1840,7 @@
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error.  'ignore' means that the
-#     request should be retried.  (default: report; Since: 5.0)
+#     request should be retried.  (default: report; since: 5.0)
 #
 # @filter-node-name: the node name that should be assigned to the
 #     filter driver that the commit job inserts into the graph above
diff --git a/qapi/block.json b/qapi/block.json
index e66666f5c6..c07941ee5b 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -48,7 +48,7 @@
 ##
 # @FloppyDriveType:
 #
-# Type of Floppy drive to be emulated by the Floppy Disk Controller.
+# Type of floppy drive to be emulated by the Floppy Disk Controller.
 #
 # @144: 1.44MB 3.5" drive
 #
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 04d0e21d20..4d4428a25a 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -15,7 +15,7 @@
 #
 # @sym: symmetric encryption
 #
-# @asym: asymmetric Encryption
+# @asym: asymmetric encryption
 #
 # Since: 8.0
 ##
diff --git a/qapi/cxl.json b/qapi/cxl.json
index dd947d3bbc..8f2e9237b1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -117,7 +117,7 @@
 # @nibble-mask: Identifies one or more nibbles that the error affects
 #
 # @bank-group: Bank group of the memory event location, incorporating
-#     a number of Banks.
+#     a number of banks.
 #
 # @bank: Bank of the memory event location.  A single bank is accessed
 #     per read or write of the memory.
diff --git a/qapi/machine.json b/qapi/machine.json
index ab4e0585f8..d1e37ebcb2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -811,7 +811,7 @@
 #
 # @policy: the write policy, none/write-back/write-through.
 #
-# @line: the cache Line size in bytes.
+# @line: the cache line size in bytes.
 #
 # Since: 5.0
 ##
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index f7ec695caa..7ed972493c 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -186,7 +186,7 @@
 #
 # @cbitpos: C-bit location in page table entry
 #
-# @reduced-phys-bits: Number of physical Address bit reduction when
+# @reduced-phys-bits: Number of physical address bit reduction when
 #     SEV is enabled
 #
 # Since: 2.12
diff --git a/qapi/run-state.json b/qapi/run-state.json
index eee61edff4..dbf25c7392 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -62,7 +62,7 @@
 ##
 # @ShutdownCause:
 #
-# An enumeration of reasons for a Shutdown.
+# An enumeration of reasons for a shutdown.
 #
 # @none: No shutdown request pending
 #
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 5c3394919e..9d9e7af26c 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -21,7 +21,7 @@
 ##
 # @ActionCompletionMode:
 #
-# An enumeration of Transactional completion modes.
+# An enumeration of transactional completion modes.
 #
 # @individual: Do not attempt to cancel any other Actions if any
 #     Actions fail after the Transaction request succeeds.  All
-- 
2.48.1


