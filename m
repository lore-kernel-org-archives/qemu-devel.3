Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EE3C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfseW-00041V-UC; Thu, 29 Feb 2024 21:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseV-00040t-AM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:35 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseS-0005Py-M3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:35 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5a0deaf21efso913834eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260171; x=1709864971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMtilp2rV73+XgiHl3BV7scdj6VbpaZuDbPLXK6KWJY=;
 b=E8NnPrC45Sg5DcH3s6I3tYlI65LFCLAOV/E6evkF4iCiERAJcbEDSpgZHKLeE6YsTh
 hVRHUru/Z2xxmoxLU2L4Kfg99sO03ei18rbA0zEH5mGJM9jTtytAxrAHRB3zuEI/zmsd
 0zNV32oyQ3rL/6YAv/viCojCyAdi8bae/q0T8oilY+V0lF6l1xwjVo9zBZQJYUSKuljU
 8bns89Oijfbskwy4S0roWw5EfZBD+fvZkABPqWiv7XP/ZYxC5nvK42p3G2xVcuDbtqXI
 nR2vYA3YpBfKc/FmMs6ALsH6opSuq+kMKFtVEKNaVxecbtRT1+wMbIGAMeba7vrpyQMM
 uHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260171; x=1709864971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMtilp2rV73+XgiHl3BV7scdj6VbpaZuDbPLXK6KWJY=;
 b=wieopX7cO8f9vK3PIlaja6Uh6PzXT7juQ7Kyl1wVskhLThY245KbV6XhYJHO3xTGAS
 YawXisYiAEFQTCof9XMsNEre/lZ0Y/yU/u6rVXA9OZcdpKpsIwgtGBaECJAkBttqfr8p
 dDY/Bqjsi0RcGURD2qEowWTtKM74pGUrjFt8tWS3Iy3qYxDqSJjDGD4p5Z6huLMyWXDl
 Ed3VJAo6jTip5Aqyh7AYGS67j5YPrmAGhQhMB/ZWD/5/4nE/QwwyxjNUACkqcgVaXvZe
 8o7fb48AHQ7SV8gu1MC+lBjqs6KG4G3gdFTEimEBpqSYiFrpCPSq+lQFV4wdP4J/5u7A
 TnSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtSwiOKPhS8+aaoCZ9/5IaA50wfbKgtPZECNpif/IZbbY//oed8POyqA8cojEaY7FAu8cKZClGC//I6C+45VQQviqb53Q=
X-Gm-Message-State: AOJu0YwuSVY1g3SiX/fUs68cqHdCTQ1gcEp6qkFTslXKkqz9hH61Jh5q
 d8iEGMELNQk2yj1CzP4AJvXZN1VIDYep7vxvEl69ja4Y/SMLsIQIgC4b/+KuoL0=
X-Google-Smtp-Source: AGHT+IGW3CviKShkGk7LY0aFrVPrjPSYmVm6r8+4vnqkx5REQcCSBztCIUk/qpWzmXFMXt7L3b43mQ==
X-Received: by 2002:a05:6358:6383:b0:17b:f319:9449 with SMTP id
 k3-20020a056358638300b0017bf3199449mr331677rwh.7.1709260171451; 
 Thu, 29 Feb 2024 18:29:31 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:31 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 5/7] migration/multifd: Add new migration test cases for
 legacy zero page checking.
Date: Fri,  1 Mar 2024 02:28:27 +0000
Message-Id: <20240301022829.3390548-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022829.3390548-1-hao.xiang@bytedance.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now that zero page checking is done on the multifd sender threads by
default, we still provide an option for backward compatibility. This
change adds a qtest migration test case to set the zero-page-detection
option to "legacy" and run multifd migration with zero page checking on the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 83512bce85..8a966364b5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2660,6 +2660,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+                                                        QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
+    return NULL;
+}
+
+static void *
+test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
+                                                      QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "none");
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2691,6 +2709,36 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_zero_page_legacy(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_no_zero_page(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3592,6 +3640,10 @@ int main(int argc, char **argv)
     }
     migration_test_add("/migration/multifd/tcp/plain/none",
                        test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
+                       test_multifd_tcp_zero_page_legacy);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
+                       test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.30.2


