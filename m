Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634BCD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAhS-0008L2-Ms; Tue, 20 Jan 2026 07:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viAhJ-0008IL-MK
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viAhI-0007RH-4o
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768911537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LnQKGFufQx8qCGTBEBecJTKER7en+5CsY9AbB+5txRU=;
 b=Dzg54s+tlQGl+OmsaBnNbq3u0F38EFLEls6GTSNgMpl/9yqDLfi5angcsPIetycMAfN29k
 paSyKo8mxuvAt3L07jWCUpD/6/W26XEm35MeG/yMZNaVh6psL/FhN2EMndj8yiZZtvocqW
 rOFLt2a1eIZrUlRb/5tMy6YD8MOmiwM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-Lbz4G2gbNc6L-m6GDznILA-1; Tue,
 20 Jan 2026 07:18:55 -0500
X-MC-Unique: Lbz4G2gbNc6L-m6GDznILA-1
X-Mimecast-MFC-AGG-ID: Lbz4G2gbNc6L-m6GDznILA_1768911534
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7225918002C9; Tue, 20 Jan 2026 12:18:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AC2518004D8; Tue, 20 Jan 2026 12:18:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] scripts: Allow sha512 in clean_functional_cache.py, too
Date: Tue, 20 Jan 2026 13:18:49 +0100
Message-ID: <20260120121849.131604-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The functional testing frameworks also supports assets that are
identified by their sha512 checksum (instead of only using sha25),
and at least one of the tests (tests/functional/ppc64/test_fadump.py)
is already using such a checksum, so adjust the clean_functional_cache
script to support these checksums, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/clean_functional_cache.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
index c3370ffbb87..f0342b4b438 100755
--- a/scripts/clean_functional_cache.py
+++ b/scripts/clean_functional_cache.py
@@ -24,8 +24,8 @@
 os.chdir(cache_dir)
 
 for file in cache_dir.iterdir():
-    # Only consider the files that use a sha256 as filename:
-    if len(file.name) != 64:
+    # Only consider the files that use a sha256 or sha512 as filename:
+    if len(file.name) != 64 and len(file.name) != 128:
         continue
 
     try:
-- 
2.52.0


