Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27414C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSb-0007mD-5F; Fri, 02 May 2025 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSY-0007l6-AX
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSW-0006Ry-4a
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGqTxK8VkxjZdabvpw9weeNFfQPKj3cmubMFJOmZiMc=;
 b=F6N30hxzbq9213TDKoqVbs+KeCcxjtlg0xg9hBnDSqUDJPcW+XBe5x89/doWkL2r/VVQK+
 gxhUgRXg6OsLem1otHkbsxeY9mGeOtViYAK6qVleVrcDfsCuHCGLSPnBMZd+CpM9bFRIL8
 QBTvMVfXj0SsQIbuuN7TttETe4Z4Q+Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-gACs0j0XPre2c-Vu6Jnm4Q-1; Fri, 02 May 2025 12:41:53 -0400
X-MC-Unique: gACs0j0XPre2c-Vu6Jnm4Q-1
X-Mimecast-MFC-AGG-ID: gACs0j0XPre2c-Vu6Jnm4Q_1746204113
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c53e316734so374560385a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204112; x=1746808912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGqTxK8VkxjZdabvpw9weeNFfQPKj3cmubMFJOmZiMc=;
 b=K5SL+obf1FusYQxbvnqerX2s+q1p9p6En0v/jHaaqHkMA8K8XMKHsSLNxnRDy1By/F
 WtdkgmeqWAae+46hKPDV2sbDmMf1Bj7y8Kn3zITlTIYhBoXk0ZDo7IESXSEgG3RX/GrZ
 KkQFRW2gXNz+ado2GlcsKRFr4r4P1i/HCwn2XV+WoXa7mRgtvoAeJRGpvEdzkuzu+eyI
 9zHXvLY32Uz9XBKVSBBPqugn/ThADsC9/O7ELLAAbJlfa9BUNatdc5OPHUreyV4509GC
 74xhmWWrTHSEJu13aVVWUsdp+u1P1jeXjUKjcdD/ay3sxMnQAiqL8pYv4R81TlvYCLP0
 3MRw==
X-Gm-Message-State: AOJu0YxltmEwEPv65CrEG5i3ermFdiWZPLA08Bv0+ExapV1MhB06dO1s
 HQmMFFqBWy5xDcoTy4vpNbhGSYyjeA6F6u/Zku4dj63rS71SbMRkWKqo0/M1Xb4Ky4SdwBaoWes
 36nr7o6bdS3jJdJOpjLAxDDf4DQeQrMZI6rnExRJlc/d9KWPTEjIsvQtGghjt5ua90OptIAXs41
 7M431htQtLaApTO2l8BeJAlxktpv3xld+Tig==
X-Gm-Gg: ASbGncvRPRVfd1bPYHqNNbQi4jgO1nTRk+mll/ZxWjlhILS+W7GY8Isv7v8xaljtfVo
 XWgu2M4im7dhLOXO0StFiUvMTKoCShPnhKwQOMsgxp25JSz/oRqH4BdpR6Pw8bFWLR6lwqTsoGi
 O4MPRsX+xlxgn34wQ3FQ3WF0EuQDMo96aTR3d42VoZZ7tQ13I/OuDcFUirKuKqad/aokH6UP9qz
 g+c6ejc7lb/6eQdYRD7H5thHjQYvg0wk2TUd1cwOP1sJRdUMWvn7Pimql3csDwQzq0PbdtYF7TO
X-Received: by 2002:a05:620a:172b:b0:7c7:a62f:341b with SMTP id
 af79cd13be357-7cad5b2e160mr502783385a.8.1746204112645; 
 Fri, 02 May 2025 09:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/VtIAKGfw9Yb3Z7+cxJmnOHHz7emruv0lZSHQxIIu4tFew5jLm9hIf0E1T6YeqbKyF1iwg==
X-Received: by 2002:a05:620a:172b:b0:7c7:a62f:341b with SMTP id
 af79cd13be357-7cad5b2e160mr502779885a.8.1746204112276; 
 Fri, 02 May 2025 09:41:52 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: [PULL 05/14] migration: Add qtest for migration over RDMA
Date: Fri,  2 May 2025 12:41:32 -0400
Message-ID: <20250502164141.747202-6-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

From: Li Zhijian <lizhijian@fujitsu.com>

This qtest requires there is a RDMA(RoCE) link in the host.
In order to make the test work smoothly, introduce a
scripts/rdma-migration-helper.sh to detect existing RoCE link before
running the test.

Test will be skipped if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link available
 # To enable the test:
 # Run 'scripts/rdma-migration-helper.sh setup' with root to setup a new rdma/rxe link and rerun the test
 # Optional: run 'scripts/rdma-migration-helper.sh clean' to revert the 'setup'

 # End of rdma tests

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250311024221.363421-1-lizhijian@fujitsu.com>
[add 'head -1' to script, reformat test message]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                           |  1 +
 tests/qtest/migration/precopy-tests.c | 66 +++++++++++++++++++++++++
 scripts/rdma-migration-helper.sh      | 70 +++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index b3f9f2680b..8cd96269b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3538,6 +3538,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
+F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9..565630dddf 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,68 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer)
+{
+    char cmd[256];
+    bool verbose = g_getenv("QTEST_LOG");
+
+    snprintf(cmd, sizeof(cmd), "%s detect %s", RDMA_MIGRATION_HELPER,
+             verbose ? "" : "2>/dev/null");
+
+    FILE *pipe = popen(cmd, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return -1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+        return -1;
+    } else if (WIFEXITED(status)) {
+        return WEXITSTATUS(status);
+    }
+
+    return -1;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+
+    if (new_rdma_link(buffer)) {
+        g_test_skip("No rdma link available\n"
+                    "# To enable the test:\n"
+                    "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root to "
+                    "setup a new rdma/rxe link and rerun the test\n"
+                    "# Optional: run 'scripts/rdma-migration-helper.sh clean' "
+                    "to revert the 'setup'");
+        return;
+    }
+
+    /*
+     * TODO: query a free port instead of hard code.
+     * 29200=('R'+'D'+'M'+'A')*100
+     **/
+    g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+#endif
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1124,6 +1186,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+#ifdef CONFIG_RDMA
+    migration_test_add("/migration/precopy/rdma/plain",
+                       test_precopy_rdma_plain);
+#endif
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
new file mode 100755
index 0000000000..a39f2fb0e5
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr()
+{
+    ip -4 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        head -1 | tr -d '\n'
+}
+
+# existing rdma interfaces
+rdma_interfaces()
+{
+    rdma link show | sed -nE 's/^link .* netdev ([^ ]+).*$/\1 /p'
+}
+
+# existing valid ipv4 interfaces
+ipv4_interfaces()
+{
+    ip -o addr show | awk '/inet / {print $2}' | grep -v -w lo
+}
+
+rdma_rxe_detect()
+{
+    for r in $(rdma_interfaces)
+    do
+        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
+    done
+
+    return 1
+}
+
+rdma_rxe_setup()
+{
+    for i in $(ipv4_interfaces)
+    do
+        rdma_interfaces | grep -qw $i && continue
+        rdma link add "${i}_rxe" type rxe netdev "$i" && {
+            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
+            return
+        }
+    done
+
+    echo "Failed to setup any new rdma/rxe link" >&2
+    return 1
+}
+
+rdma_rxe_clean()
+{
+    modprobe -r rdma_rxe
+}
+
+operation=${1:-detect}
+
+command -v rdma >/dev/null || {
+    echo "Command 'rdma' is not available, please install it first." >&2
+    exit 1
+}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "clean" ]; then
+    [ "$UID" == 0 ] || {
+        echo "Root privilege is required to setup/clean a rdma/rxe link" >&2
+        exit 1
+    }
+    rdma_rxe_"$operation"
+elif [ "$operation" == "detect" ]; then
+    rdma_rxe_detect
+else
+    echo "Usage: $0 [setup | detect | clean]"
+fi
-- 
2.48.1


