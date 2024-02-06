Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjv-0006DL-DY; Tue, 06 Feb 2024 18:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjt-0006CF-0h
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:29 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjm-0005nf-Nj
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:28 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7d5bddb0f4cso2286941241.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261621; x=1707866421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpkOjImJK+FSoyIVEziU9Gl/0F3Bqogyd5w1Dik58Qw=;
 b=hPC2a57WoIZ1Z9vtAcwWSvzVvdosl0KNvpPV8NV+jShrEFi1R+ARl3VVnN6CleDcI4
 ZA1oJy8fmIeEzeQtUr8EMkb60bJVSUD2Om9lwT/4NFgOLhnAJ4Y2xzFxc506n9zQdeht
 jtRjyuPF0eCZJm8BoGMFIHbVAvMgBEO4s1NGDzX1QaPF5vxdxRYReEeGpVf15GsNhLcE
 vsinzgagxnoGIfZNLozIt2lbLMfvhmlv+qRNs6GW3VnG4mjXIeempW3Jxxwb2BGA/x+U
 +FciptfHzF/qc/Pz2TnMEvm9vF5ctINWXx0J5oRcS759Rxx4Qvd/IDMrQXbqK4E9VbES
 kcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261621; x=1707866421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpkOjImJK+FSoyIVEziU9Gl/0F3Bqogyd5w1Dik58Qw=;
 b=MgKhDMhpMG5EO6SPV45ZoJSMZfSzh0MqRaQb75kn9XJ3qSVyPw1bzsAJPn1e/9vDm0
 ptzjbBUNPqg7tV8zo6OsmWvuLW5kgQcMMejKDYVWlHb3eaHchuot+dhCgN6mTOFk7m0l
 CcIdpxQshpNwUEOkh5nIVY5OOp6l6UkR8BmDHph3b2sJJ902zbWgaFYOqzXGKcJBJZh4
 9dwhA5W1vZ8oiJ/GhsHD7LrGYgAoq4KYtd+uIMAUURxLAwUouuj/eEusucpsrujF6qmK
 438aQ9rmouoVvkN9CkUqs5o3TdQXin/89bt6/0L9dGFL5tX1dIuUJvuUySP6hFrzCez9
 vvcQ==
X-Gm-Message-State: AOJu0YzPLMDInP+/3XwRbpysuZMnkZsk1dhQYd1VcBqxMb6Ro61bNSUh
 4JQXgIFsE1oCVt0+KxWYf9MSpEpS0o0VPO5/rIeEYC017hlcdBRBTIgkVy56tqnv3GlJxS9Ax59
 iErg=
X-Google-Smtp-Source: AGHT+IGK6v7quUmYPNzLqEgzOsHH+O6f8yujk+X1Lu/Lk3iHOgStbsXDt4H1srKfgcLSJymCPFH14g==
X-Received: by 2002:a05:6102:5f5a:b0:46d:1785:426c with SMTP id
 il26-20020a0561025f5a00b0046d1785426cmr1177438vsb.0.1707261620891; 
 Tue, 06 Feb 2024 15:20:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzKqLpi2f3ZEutclyNlE0g23N/egQMDhhywflO2Ht6Nv0s2HiyK5SfnRXykAwQ7Q7CInDnvCQxprJQZJJ9+JaQ2bDJ2edPLHpbe0DZcrYUHJjr
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:20 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 6/6] migration/multifd: Add a new migration test case for
 legacy zero page checking.
Date: Tue,  6 Feb 2024 23:19:08 +0000
Message-Id: <20240206231908.1792529-7-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x92e.google.com
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
change adds a qtest migration test case to set the multifd-zero-page
option to false and run multifd migration with zero page checking on the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7675519cfa..2c13df04c3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2621,6 +2621,15 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+                                                        QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_bool(from, "multifd-zero-page", false);
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2652,6 +2661,21 @@ static void test_multifd_tcp_none(void)
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
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3550,6 +3574,8 @@ int main(int argc, char **argv)
     }
     migration_test_add("/migration/multifd/tcp/plain/none",
                        test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero_page_legacy",
+                       test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.30.2


