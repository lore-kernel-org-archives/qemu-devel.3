Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE411D6A248
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhut-0003SS-5j; Thu, 14 Nov 2024 17:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuk-0003Qh-MG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:10 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuj-0007gr-1g
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:02:10 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b13ff3141aso72509885a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621728; x=1732226528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxaPcDi0GvROdbHCP2XrpVAr3pG96W88atG3C9gr0r0=;
 b=FtLTfvvsoPIGg/50MCaXAV9JT1ssP+pFDVd/3EQzJ2QzA+3GEcx0mTc+J2wcENZ2Sr
 AoXVN41zANHEpHVhc+YZl7XBYvDIiDHxyKTs1OzTXPdoNpI3ttJcypAOWlpv88m+8YgM
 HXl1umOUKYBXvvKQQMe2sJoLNTI0AygxPHrWfkFoRyQyTiqrUHTA3wqi8YSKgc8ozPga
 6X91sTL+b8wX1kFEUsWm9b1apZPj/auXdon4h2vssJUreqT1IT+lxkwlsHiDebcmZp+e
 2viSSjgZeQ+f+/y/ss5JssLetL5JX+Eg/yfWC/kAwNRYxY9uGz8DJdY00vzbuP7qd8kD
 ckPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621728; x=1732226528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxaPcDi0GvROdbHCP2XrpVAr3pG96W88atG3C9gr0r0=;
 b=jRZTFps5Narvr3yW8dson65TeNIx6EWPleOkgywPkxUvc2jaGA1B2EDJOx3jqfPUgq
 UwY3F6CHYnV5wWJpn56f2FHLChOyNEFjkNZVeMT4ugL6mhUJdoDnuH3uV/4Si+EkPScZ
 731kC+273Cl4WY0SZPGai6V83o3ZtwbC1LathLClYFpta5V0VO/toFBPxp66BADrDAac
 gkU1tWHKtpD3rcgaeNQKGArFMA8WsuRQvYl1b4ZmpxzF01DMV0qfsh8sMd7cZjw9NHpg
 Bdvyjj3hynecLqwG8YAqoLBaN67n4KQV77leBXWbv7BLzgSTPuOfNXxVrdXf3RMluQAT
 UIpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeXdY2jGv17eYdL0JZtBe7zMZVBf9d/soV+SWjiQ0pg3xQUUUT+GT3k6tDYvRTh+/55OboX4Jn2w2v@nongnu.org
X-Gm-Message-State: AOJu0Yzhgx/a1ZLyCNreU+wJw3usO9KTiEfIa4GIAvpTfvM4CJwAyr59
 5UJXUkjJz+FZbdRZduDeJK2elLqUny7QxmJSrJwqHvg4G/2BcoDSUXnYWekQiVo=
X-Google-Smtp-Source: AGHT+IE1flOo8GUuiBFeSBKTr2iYCSF0phHR9gfIh8/Ngv56jyN7hKPftARShzppOjSZ6PmsvTnO7w==
X-Received: by 2002:a05:620a:1a28:b0:7b1:52a0:48eb with SMTP id
 af79cd13be357-7b3622b5e03mr67182685a.22.1731621728057; 
 Thu, 14 Nov 2024 14:02:08 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:02:07 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v7 11/12] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Thu, 14 Nov 2024 14:01:31 -0800
Message-Id: <20241114220132.27399-12-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@linux.dev>

* Add test case to start and complete multifd live migration with DSA
offloading enabled.
* Add test case to start and cancel multifd live migration with DSA
offloading enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 tests/qtest/migration-test.c | 80 +++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e6a2803e71..cd551ce70c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -611,6 +611,12 @@ typedef struct {
     bool suspend_me;
 } MigrateStart;
 
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char *dsa_dev_path_p = "['dsa:/dev/dsa/wq4.0']";
+
 /*
  * A hook that runs after the src and dst QEMUs have been
  * created, but before the migration is started. This can
@@ -3262,7 +3268,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -3282,6 +3288,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+        migrate_set_parameter_str(from, "accel-path", dsa_dev_path_p);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -3340,6 +3351,49 @@ static void test_multifd_tcp_cancel(void)
     test_migrate_end(from, to2, true);
 }
 
+/*
+ * This test does:
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       launch another target
+ *     migrate
+ *
+ *  And see that it works
+ */
+static void test_multifd_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel_common(false);
+}
+
+#ifdef CONFIG_DSA_OPT
+
+static void *test_migrate_precopy_tcp_multifd_start_dsa(QTestState *from,
+                                                        QTestState *to)
+{
+    migrate_set_parameter_str(from, "zero-page-detection", "dsa-accel");
+    migrate_set_parameter_str(from, "accel-path", dsa_dev_path_p);
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+}
+
+static void test_multifd_tcp_zero_page_dsa(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_dsa,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_cancel_dsa(void)
+{
+    test_multifd_tcp_cancel_common(true);
+}
+
+#endif
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -3767,6 +3821,20 @@ static bool kvm_dirty_ring_supported(void)
 #endif
 }
 
+#ifdef CONFIG_DSA_OPT
+static const char *dsa_dev_path = "/dev/dsa/wq4.0";
+static int test_dsa_setup(void)
+{
+    int fd;
+    fd = open(dsa_dev_path, O_RDWR);
+    if (fd < 0) {
+        return -1;
+    }
+    close(fd);
+    return 0;
+}
+#endif
+
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
@@ -3979,6 +4047,16 @@ int main(int argc, char **argv)
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
+
+#ifdef CONFIG_DSA_OPT
+    if (g_str_equal(arch, "x86_64") && test_dsa_setup() == 0) {
+        migration_test_add("/migration/multifd/tcp/plain/zero-page/dsa",
+                       test_multifd_tcp_zero_page_dsa);
+        migration_test_add("/migration/multifd/tcp/plain/cancel/dsa",
+                       test_multifd_tcp_cancel_dsa);
+    }
+#endif
+
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
Yichen Wang


