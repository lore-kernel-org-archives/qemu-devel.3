Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A309CC9831E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9j1h-0005cZ-Qt; Thu, 24 Sep 2026 08:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1e-0005bX-LM
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:11 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9j1c-00025v-3g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 08:58:10 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so12552565e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790254687; x=1790859487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kTl/s+CabqsH7RAws9IcJ4z7WxUGXogCHXB1u6FofjA=;
 b=K07wjqfBHVn2cF4HAvQPlpvjPMb65XFYPbNzxclGHfVV4Ok2W+HRspLrnYuexIW3Wz
 7baBhbloTHs3+vZXRCh85jbV6DDVRpJk7b7R8XLCC9BzH9FSUNaEOc2cyxF1OhQzsqD8
 96CYUe0mruzkhknqrgl8t8oZHH4IKpKQb9j73RSHmz9feTnXCfErs1V4J+M3jtqmOj70
 svzzw1XiKmwLefUIla1T7kOnBmTAPAPDjprJ2GK2kKKqDQYnPdjOogg+nkY8ZRPPdWJE
 6FhMtnLXJX3Mc5o21LPFXgIP3CfdWgWhgh8gG1e/rGo+kJfwdniTQYf9Ji6mLHngTOPx
 UkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254687; x=1790859487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kTl/s+CabqsH7RAws9IcJ4z7WxUGXogCHXB1u6FofjA=;
 b=KEKsCi2WMDMN+7iy5FEvrAdrcdmJtt/XLh1KPbJvXJTlLFn44xV7x2kpwUWB5ielmm
 CRBdtWK47Kv9mQNr0awfmxdQJusUN1H8Ut4JYps3sMxz6LdWZ1STDernOMtOAz4WjhEz
 N/Mbkhh9XFtrkbpBkcA9QWHq/Mn0tB1X34Pg05tYvTWCR9r9cfja3Zt4+iPlWcfg63ua
 J52EAFMamlOjAsOLSwagkajkZBhi8Cy+mjm96I4CUtqO1c+HcbAn7hO8w0sp4k5SMZt8
 dv8cAf60x1QVauMgz2N35/Loe4DMGvZ5eIZ/M1MECPJxeejgN/fbRNP/1Xb3/i66WOxN
 vz3Q==
X-Gm-Message-State: AFuF++m7rm98GA1YAErHOYSrLhnSTInteh2wPXoLDqCaihvtCFRYM8+e
 hJImxRYxP/wvOjiYJiROHkKuElkXqXYiPdnehnlhVoAnwVEA/JdIDuMX2JMeshSZKK3oey1u8DV
 7Myuo
X-Gm-Gg: AYBFou35hw+XtWI6uzNbktkqiSR8eV1qSivxPWm+Av57ZaccMMG7O0f+FnzHCz0i1oH
 K8kfePmhpeXaLClugXMd1+h0rIJzIcJyCXxYPw4v4y57xwMAlHR0Ut51p2D9eJHdIEOlwY+kw1J
 bpXwoJsM1Ura3AHiAbSDZbRE/DBl/vCFp96Hkk4CY6o7S771PVJxNoGV/xwnb9cj9JRUiGoXsKz
 X3+JyCxMrnjVbTkpBn+XRPXkJ8ZM4LM27jRQgmEQo458FcmYhFEaxhch9xEiYrIg61mvMXDUO9D
 aNn81/G1vkRFDtFMVnNTVNe1hzcyZLjvMpVGvKpR/M7ucXAOBMuoyyRX1zPB5DtZqPoYIFv4Uze
 K18J+TqwwaDCbTt2DE/XmHx/8Ylovf7RdKB5TZzDJXLJ9s1n6OzPeKXmD7E9tmxw07epV0MMVN0
 KsxiNY/JpC5V8+FHt8d/3GRAOiKB3VFoFcnJeOOtZcBivluev0XbBzYdbokLFknqMiWmI=
X-Received: by 2002:a05:600c:1c08:b0:49f:e0f4:1aac with SMTP id
 5b1f17b1804b1-49fe66fd431mr46282415e9.25.1790254686603; 
 Thu, 24 Sep 2026 05:58:06 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868486408sm13260821f8f.9.2026.09.24.05.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:58:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] tests/qtest/migration: add a cpr-exec test for bound
 guest memory
Date: Thu, 24 Sep 2026 14:58:00 +0200
Message-ID: <20260924125800.4188406-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125800.4188406-1-den@openvz.org>
References: <20260924125800.4188406-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

Add /migration/mode/exec/numa. The source VM has a memory backend bound
to host node 0 and the exec'd QEMU asks for host node 127 on the same
backend. mbind() rejects that node just as it rejects one the cpuset
dropped while the VM ran, so the new QEMU survives only if it leaves the
inherited memory alone. This reproduces the failure without root or a
cgroup.

set_cpr_exec_args() now uses opts_target, unused by cpr-exec tests so
far, as the options of the exec'd QEMU.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/migration/cpr-tests.c | 38 ++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4a..9217783659 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -169,6 +169,7 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
     g_autofree char *to_args = NULL;
     g_autofree char *exec_args = NULL;
     g_auto(GStrv) argv = NULL;
+    MigrateStart start = args->start;
     char *from_str, *src, *dst;
     int ret;
 
@@ -179,7 +180,11 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
      */
     g_assert(args->start.hide_stderr == false);
 
-    ret = migrate_args(&from_args, &to_args, &args->start);
+    /* opts_target, if set, replaces opts_source for the exec'd QEMU */
+    if (start.opts_target) {
+        start.opts_source = start.opts_target;
+    }
+    ret = migrate_args(&from_args, &to_args, &start);
     g_assert(!ret);
     qtest_from_args = qtest_qemu_args(from_args);
 
@@ -276,7 +281,8 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *opts_source,
+                                  const char *opts_target)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
@@ -284,12 +290,35 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts_source;
+    args->start.opts_target = opts_target;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, "-machine aux-ram-share=on -nodefaults", NULL);
+}
+
+#ifdef CONFIG_NUMA
+/*
+ * mbind() rejects host node 127 as it would a node the cpuset dropped
+ * while the VM ran.
+ */
+static void test_mode_exec_numa(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args,
+                          "-machine aux-ram-share=on -nodefaults "
+                          "-object memory-backend-memfd,id=numa0,size=2M,"
+                          "policy=bind,host-nodes=0",
+                          "-machine aux-ram-share=on -nodefaults "
+                          "-object memory-backend-memfd,id=numa0,size=2M,"
+                          "policy=bind,host-nodes=127");
+}
+#endif
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -313,5 +342,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         migration_test_add("/migration/mode/transfer/defer",
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
+#ifdef CONFIG_NUMA
+        migration_test_add("/migration/mode/exec/numa", test_mode_exec_numa);
+#endif
     }
 }
-- 
2.53.0


