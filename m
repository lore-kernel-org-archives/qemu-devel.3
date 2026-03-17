Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C616F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEM-0006y2-RP; Tue, 17 Mar 2026 04:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDu-0004d5-1N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDq-0007Ye-Oe
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8f/MrTFsI13Xy/4oaaD45EfqL69PEH6L1W1Oztn73fU=;
 b=WJ49ILi5iEsLpW52vhf6JhgQGLG4uNDgQPkeBzcXQX+LlAH2cqtE8LQNkDlauasfCscuj3
 Ijxxbyn1lEjbhsgwxpG8RCvDEM2lZCwb7OjgdzI1T7CbJpyzyPQrI9mzK4tS1MRaV7IkEl
 JKvTnFOo3gEdxlfvrN0q/W//s9TuRuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-klZk8HIPPqez1vwMeebwDw-1; Tue,
 17 Mar 2026 04:56:16 -0400
X-MC-Unique: klZk8HIPPqez1vwMeebwDw-1
X-Mimecast-MFC-AGG-ID: klZk8HIPPqez1vwMeebwDw_1773737775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEBC71954B23
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95D151955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:12 +0400
Subject: [PATCH 58/60] tests/qtest: fix dbus-vmstate-test compilation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-58-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hF96GHtpSZxgrTbAMaUASqNvy0ihSke9RgQRhVtrfxg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXdEL3VPPjPSo9piF4jMfMs1vziZyGhgV3pl
 wNlZRuguYCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3QAKCRDa6OEJdZac
 5cU0D/0dh24YwfI7HXCIB0OIylQjF3domL+edU1UGzUBXigq3SmNHS0TiVcE/a3r9VKQHYE/Zpl
 BHytx7fM4atFEiEKPCvz1ItZnt5WZ1rI9cGFMqdvFONbTTAV8S4Wq8vDHjowIAtrLkGhJ0yzYws
 7YwsXCTA4qUjG0HjUirHTYMx3CvCdOL96UgZS1ZBJr7l29XSg9LM8vjg0KF9v2+0Voh+sRDGwuS
 7ZHaiIU/JodCLxBiyrlVHg9BrX7UI08pz4IucRkGlGX8mvhswHq9UDFgLtw3KZaYK4zIO8R5QzB
 Cx3hg/1Y99qHcmxSohpILjYOTRbh1zkwEYaiaipNcT+KbTeDuoU1xjZPmAAWoC+OAJHA4Qm+uI1
 bJc0A7bOtskcP39a3DukZQz3TMPfC5SyZCZKK/x5QwatfhCfXqLnjc/x1V/j/xuk61w1oZNsC2f
 DQsx7VLQK2+ujpktObILdzQHqw3fqVwufzbv5sJ13ktWUs60G0hwrZQZKCqzpdifPSMBfXSh/xR
 xXiBLCdzaTt+XkZrPZFo8nPSCCOXIGLZ9tzzZ2jiZAlxMvSB3GtrlDtUCBsnx5I4jWL1f0ZnQqt
 x+cpNxC8qM87KgHQX3yPVMCA1FucvtWJ1AFnVVXANquAJd+1gTzjcy7lduhhn0ZpEnfV6p7ueiK
 J1//ptbSyerLs8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The test is still disabled, and trying to compile it will fail now.

Fix it, and remove the G_TEST_DBUS_DAEMON setting, since it is passed by
meson test. Fwiw, the test passes here.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 11 ++---------
 tests/qtest/meson.build         |  3 ++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 6c990864e3e..ed4a52d0255 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -3,7 +3,7 @@
 #include <gio/gio.h>
 #include "libqtest.h"
 #include "dbus-vmstate1.h"
-#include "migration-helpers.h"
+#include "migration/migration-qmp.h"
 
 static char *workdir;
 
@@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
 
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
-    migrate_qmp(src_qemu, uri, "{}");
+    migrate_qmp(src_qemu, dst_qemu, uri, NULL, "{}");
     test->src_qemu = src_qemu;
     if (test->migrate_fail) {
         wait_for_migration_fail(src_qemu, true);
@@ -342,15 +342,8 @@ int
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


