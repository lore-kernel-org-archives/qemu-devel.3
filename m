Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F92F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTx-0007vw-6E; Fri, 10 Apr 2026 15:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTv-0007pT-75
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTr-00038I-Kc
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgwc+N0yjaNA5essMR4duloCYDqsIlwU6/zTCk4Cxuk=;
 b=OCJYgabYGIXQAXWU4uOOTtSU9Lxfs1U8VG4oRRv5yeWGvmcyggnq8PHi9y1RwKdaaierip
 y35xYUJGuRiIkfvNr0Nugff8P21RjBXtByE5UmBJknIuoIQ3Gklil3hrtHL4bLvDPQdBaX
 BrapeSR/VDYqtfq1d8umBkTlTDnFN5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-CB5_MAHfPsWKajYmJxYsEg-1; Fri,
 10 Apr 2026 15:25:24 -0400
X-MC-Unique: CB5_MAHfPsWKajYmJxYsEg-1
X-Mimecast-MFC-AGG-ID: CB5_MAHfPsWKajYmJxYsEg_1775849124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17D8F180057A
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:25:24 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD0471801ACB; Fri, 10 Apr 2026 19:25:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:27 +0400
Subject: [PATCH v2 65/67] tests/qtest: fix dbus-vmstate-test compilation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-65-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2534;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AOLvl3KfosfDJbEbxdB9wrP2jcATXQDS62ur3cuRiFY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0XOSWttPnZQT2G7JRBB9lZ0dMbBcwCka+fo
 AqEINRhr+eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFwAKCRDa6OEJdZac
 5TUtD/0R4M3EpT/7pPTt7mfMtQEn9SEVFjJOpU3PV012RyX2F/lZ2dwnH/vtVuoXCJAWqw5Qj1g
 /eXoH9qMcfoThWtN+opV/1wrfV9jSiq16U06rRa3lWHannLXOeWdNQ4Ut/QkFSEH9tBsGyMmkTp
 r2dp66OFO6X+RIpfMiQQOnzNk/lDe+L/m5WhDT8Ix1z9bESTGU3MAn1/gWk+y8a+7pzc+UelQHi
 49QoW+NyWQhYYJxwvgooSlsulx9xOjaaefBlcZvm+9iEdOlejrPotoQ/YVBYHQ5WImXnFvLCd9G
 j8VZhRDngkUvdwNpDA20FBSSDdlKd7fONedr5EuHtFFe9NjAZIDsgO8klPQr6tO2UKCHccVHAL3
 IDH3POuarpwiYcvP/svRfaIpbDcaqt4fE2zCRDWt2Il5QTt/GRiqTjbPJ2zWFSTfFa2hC01E/cJ
 rZT4UghZbgIO4pRbFx9dkJH4XaAJhpCkR1xVcQyOkRkaTdwuUVFvKs57/PpBg/X5tPDzlIen/s7
 3WRprfQ/JH8RuyYQ7s7O6rE6Dxsr2rcuJJ+9Y+/Sn/BSoUeRkEyNBPTNV5YoipvvhX1jxfk7HSd
 dJ3sihPbPN4Mv1M48y55CKnOAftq4Qc4u/1gc38pQM9RAgXWkhlusQOiyObU+2Uc6j9K7zdKRVi
 NWZNkF3l4DbTeLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The test is still disabled, and trying to compile it will fail now.

Fix it, and remove the G_TEST_DBUS_DAEMON setting, since it is passed by
meson test. Fwiw, the test passes here.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 11 ++---------
 tests/qtest/meson.build         |  3 ++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 0a82cc9f935..5c80bb303b6 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -3,7 +3,7 @@
 #include <gio/gio.h>
 #include "libqtest.h"
 #include "dbus-vmstate1.h"
-#include "migration-helpers.h"
+#include "migration/migration-qmp.h"
 
 static char *workdir;
 
@@ -230,7 +230,7 @@ test_dbus_vmstate(Test *test)
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
     migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
-    migrate_qmp(src_qemu, uri, "{}");
+    migrate_qmp(src_qemu, dst_qemu, uri, NULL, "{}");
     test->src_qemu = src_qemu;
     if (test->migrate_fail) {
         wait_for_migration_fail(src_qemu, true);
@@ -343,15 +343,8 @@ int
 main(int argc, char **argv)
 {
     GError *err = NULL;
-    g_autofree char *dbus_daemon = NULL;
     int ret;
 
-    dbus_daemon = g_build_filename(G_STRINGIFY(SRCDIR),
-                                   "tests",
-                                   "dbus-vmstate-daemon.sh",
-                                   NULL);
-    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
-
     g_test_init(&argc, &argv, NULL);
 
     workdir = g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b735f55fc40..5f8cff172c8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -130,7 +130,8 @@ if dbus_daemon.found() and gdbus_codegen.found()
                                 input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
                                 command: [gdbus_codegen, '@INPUT@',
                                           '--interface-prefix', 'org.qemu',
-                                          '--generate-c-code', '@BASENAME@']).to_list()
+                                          '--generate-c-code', '@BASENAME@',
+                                          '--output-directory', meson.current_build_dir()]).to_list()
 else
   dbus_vmstate1 = []
 endif

-- 
2.53.0


