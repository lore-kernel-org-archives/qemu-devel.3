Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35E4ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snelV-0002EL-I6; Mon, 09 Sep 2024 09:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelT-0001yF-Im
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelR-0000CO-Sd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:49:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7163489149eso3490940a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889748; x=1726494548;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3t+rJYL+OLNJsbkNL6rt5vBSdNx9BVxn2HZsRTYOAAc=;
 b=Vk5g3uuJKmWRiPeNB1SKeckjqi9j4WFAI4DbheuCZnr67K48RZXa//dR/OUgGmU9hr
 odVRKKD8e+F31n4y3X2q4Rx8GM85RTT9ArpuY1DKHpR+GVt0/neTZB9pQXIuQsQuXa3K
 hP7qZ1C7JGdZ03A7oL8ez29VH5cHJ465EhSqHuAQnNwE2GFoaBhaPrbu121g+ML6XaRV
 Fdee78uraHCnAdRam4fPGypuGF/EW8M7MQVdR+/GlNxRWxszVIzo+26g6i51ZDgtS7xP
 hEdILDHIN4ZlVWP8yGW37/m2rG7uRdzV80UgI+iIBKXRjkK9gUogSlKpFHA6uXPpogcY
 xNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889748; x=1726494548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3t+rJYL+OLNJsbkNL6rt5vBSdNx9BVxn2HZsRTYOAAc=;
 b=w9T53o3S4e6OoKhM0xN7NIeMxX440SYSqsVMgWd5V7XiLChEbowoEQIPKWdgBIR8y7
 xP6gE8eqzfGpqzSiDQwxXepXjIfmRfH9cU3Zqyrx2MYgJVqVgjbmcgOsSibo2E7BEZ+W
 NPLXy303l0cxbxNpS7HIUf2E2pRmablKAmMm6IZTkeGvDMTeF2NeAdIP9vIFa0Eho5E8
 AoLPqy+zN/TEwp100YJi3MviloNs3COY/qgxVyD1MM9d5O1pS1NJEogeVnHzaATksMaF
 M9jyAlhH8Ndfy6dDxZjy+FhE9NsClSB9mKXy6zLgb7ZlIrNubqSnXx9hRitbJXm7acZf
 BaDw==
X-Gm-Message-State: AOJu0Ywu/r4g8IP+2H3+MXZ5XYdnBk1Z7CSMh097lElgFwNHEzkg/f2l
 iqXlF2lzMjj9Kok6q8TfIo76S3O3/s84MkkktwmZG5F0k50Yi5JHetY1rpKcLZiTy2bf6HhUjk7
 WXpdw4g==
X-Google-Smtp-Source: AGHT+IEIHouTQrQxgz/J2sEL4N1nMmDwA/0cnxC2g3gQYu8nJi+33wGAmO0AA91dNxDkkL4OiicYUQ==
X-Received: by 2002:a05:6a20:cf8f:b0:1cf:39ee:f259 with SMTP id
 adf61e73a8af0-1cf39eef59emr5103855637.5.1725889747596; 
 Mon, 09 Sep 2024 06:49:07 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:49:07 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 10/10] tests/migration-tests: Add test case for responsive
 CPU throttle
Date: Mon,  9 Sep 2024 21:47:22 +0800
Message-Id: <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725889277.git.yong.huang@smartx.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Despite the fact that the responsive CPU throttle is enabled,
the dirty sync count may not always increase because this is
an optimization that might not happen in any situation.

This test case just making sure it doesn't interfere with any
current functionality.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/qtest/migration-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4626301435..cf0b1dcb50 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -718,6 +718,7 @@ typedef struct {
 typedef struct {
     /* CPU throttle parameters */
     bool periodic;
+    bool responsive;
 } AutoConvergeArgs;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -2795,6 +2796,7 @@ static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
     QTestState *from, *to;
     int64_t percentage;
     bool periodic = (input_args && input_args->periodic);
+    bool responsive = (input_args && input_args->responsive);
 
     /*
      * We want the test to be stable and as fast as possible.
@@ -2820,6 +2822,16 @@ static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
                 periodic_throttle_interval);
     }
 
+    if (responsive) {
+        /*
+         * The dirty-sync-count may not always go down while using responsive
+         * throttle because it is an optimization and may not take effect in
+         * any scenario. Just making sure this feature doesn't break any
+         * existing functionality by turning it on.
+         */
+        migrate_set_parameter_bool(from, "cpu-responsive-throttle", true);
+    }
+
     /*
      * Set the initial parameters so that the migration could not converge
      * without throttling.
@@ -2902,6 +2914,12 @@ static void test_migrate_auto_converge_periodic_throttle(void)
     test_migrate_auto_converge_args(&args);
 }
 
+static void test_migrate_auto_converge_responsive_throttle(void)
+{
+    AutoConvergeArgs args = {.responsive = true};
+    test_migrate_auto_converge_args(&args);
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
                                               QTestState *to,
@@ -3955,6 +3973,8 @@ int main(int argc, char **argv)
                            test_migrate_auto_converge);
         migration_test_add("/migration/auto_converge_periodic_throttle",
                            test_migrate_auto_converge_periodic_throttle);
+        migration_test_add("/migration/auto_converge_responsive_throttle",
+                           test_migrate_auto_converge_responsive_throttle);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
             migration_test_add("/migration/dirty_limit",
-- 
2.39.1


