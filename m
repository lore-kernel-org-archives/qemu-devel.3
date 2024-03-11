Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930BEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjniW-0003XF-FJ; Mon, 11 Mar 2024 18:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnh7-00018Z-9D
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnh0-0004Ip-0Q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REz2gEz/LcPOkgLWctbrSURC4iwk9Gc0HnBo9jeImt8=;
 b=edRgNGOQoQ9XIvmNOSyPG0uM7jZC2OEEhMcERd7PsN5VAyH4Nf6UlmwvA/5su3kNDg5NG+
 44Z4PLrMGT7pIOg05vbhFaU11KmCZ4qS4umqgqDejJ0G7tSRZ0xa7udBEMs7JSeNjR0wCo
 9q0kOc7//5DRNlMBuU9U/1TmPvaUMvg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-YSXwEwj6OUevg1LN2PyfCA-1; Mon, 11 Mar 2024 18:00:19 -0400
X-MC-Unique: YSXwEwj6OUevg1LN2PyfCA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690d3f5af86so4507026d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194418; x=1710799218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REz2gEz/LcPOkgLWctbrSURC4iwk9Gc0HnBo9jeImt8=;
 b=YaLPH+PmcbV72UMzZcRm0taaB88WuknCr+JhYHlckmeqPvE0A6Vxnjq1Ojos8YTwTr
 m3+gb1u9mIexbfgWiQfYP+Tks19c1+uXrO3oOXgiQ9Br4hDPbDHKpeEhcUYbTsG21CjV
 kIIHQV34Ody3ESKpfzoPkMawgr0Op5CaycDZp+B9NEKbbYhuwlz7psrKxMVkehNeYZck
 TYj8gZmol72tv7gf8+MFuLygrb564lqk/uUOrsZ2PCcaSreOwt7vm05saXPBIOtRwDbH
 NwmUm/+6z6LFOTlKBStY3GxEiI9boxEmsdNWoRT7WggMcjfVHR8yIeof48pKzVxnoeLJ
 pgLw==
X-Gm-Message-State: AOJu0YwD3jCsT/dRQaDE6CIoJZHARWsH6RCU2V5C46EfqnELW1ys7vol
 ICEEFdUpvwlKxhFDylLQLYSRa2o7Gwzq7r5uH8tRJ84IUz0YqPofdDrF8mxkgEfhLsJRMcJg51f
 DXgMnG/8CLoMotx4nrSWYIwCBuSkzKO8OmxfCs6z4oCDgy5YqxkP7kjQom7VWfe8PwJXuh1cLVp
 gNwRmXCKDgW7fdxsRb6XNIYZw7f2H2JBJU3A==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr408009qvc.4.1710194417626; 
 Mon, 11 Mar 2024 15:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqXBKIl4UNeZ9L8akaPDVFSXlHkTf69VoScNoH1FN1qove6x2Exrf9MVAVPijERX6oYaerCg==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr407959qvc.4.1710194417079; 
 Mon, 11 Mar 2024 15:00:17 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:16 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PULL 34/34] migration/multifd: Add new migration test cases for
 legacy zero page checking.
Date: Mon, 11 Mar 2024 17:59:25 -0400
Message-ID: <20240311215925.40618-35-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Hao Xiang <hao.xiang@bytedance.com>

Now that zero page checking is done on the multifd sender threads by
default, we still provide an option for backward compatibility. This
change adds a qtest migration test case to set the zero-page-detection
option to "legacy" and run multifd migration with zero page checking on the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240311180015.3359271-8-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4023d808f9..71895abb7f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2771,6 +2771,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
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
@@ -2812,6 +2830,36 @@ static void test_multifd_tcp_none(void)
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
@@ -3729,6 +3777,10 @@ int main(int argc, char **argv)
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
2.44.0


