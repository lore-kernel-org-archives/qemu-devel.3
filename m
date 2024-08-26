Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E246C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 09:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWGO-0002tC-A0; Mon, 26 Aug 2024 05:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGI-0002n2-Nq
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGH-0006yb-A2
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724665424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MueVzebHUueA9JcsPbFzZ51hTKOiPz11tmEWnXoY7Q=;
 b=ZoRuUcvLBchtEIlVVsC1KzksKLKDZh8lkZAa8lBW54PX8lvXfe9gdN57rbU1w1qPhzbizw
 IT48HAH5/uVEF8hqbTmykt/0KxigRxcwhI90LkoUXRmdCIG0r3S6ZfB2kYPxHCSZu4KVuP
 r2EjcZwbsaHg/ep2fJV2dmCt3QirT6w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-zMo9AZmXPMu2feVILJd5GQ-1; Mon,
 26 Aug 2024 05:43:41 -0400
X-MC-Unique: zMo9AZmXPMu2feVILJd5GQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C81301955D57; Mon, 26 Aug 2024 09:43:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.178])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E4DA19560AA; Mon, 26 Aug 2024 09:43:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/3] tests/qtest: Delete previous boot file
Date: Mon, 26 Aug 2024 11:43:30 +0200
Message-ID: <20240826094330.276592-4-thuth@redhat.com>
In-Reply-To: <20240826094330.276592-1-thuth@redhat.com>
References: <20240826094330.276592-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A test run may create boot files several times. Delete the previous boot
file before creating a new one.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240823-san-v4-7-a24c6dfa4ceb@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..6c06100d91 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -144,12 +144,23 @@ static char *bootpath;
 #include "tests/migration/ppc64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
+static void bootfile_delete(void)
+{
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
 static void bootfile_create(char *dir, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
     size_t len;
 
+    if (bootpath) {
+        bootfile_delete();
+    }
+
     bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -177,13 +188,6 @@ static void bootfile_create(char *dir, bool suspend_me)
     fclose(bootfile);
 }
 
-static void bootfile_delete(void)
-{
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
-- 
2.46.0


