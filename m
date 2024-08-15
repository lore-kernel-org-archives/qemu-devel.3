Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09279C531DC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 00:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOFK-00056I-5i; Wed, 14 Aug 2024 20:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1seOFI-00050J-He
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:21:40 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1seOFG-0004HF-Sq
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:21:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so312610b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 17:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1723681297; x=1724286097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70tmt7SXXA8xNV/GOXmAHGlkd6Y3uEXM0oMIn+MfWWk=;
 b=iHIxtynnJrMF5Y2BEuW4k8tsxIqy03xUQeWOubIq7mOVabANL4rtB4kSaLF3NEvzOh
 Z6elE+jr+4CyfBVC3gvBTNdYDchrOHYRK6nuZsj3MQcyCnMsSHLuLAFHMCokEI7lIUQ7
 nF4IIEvhE4SBNnMV7x/jPWXfeC2ErzaKFWdy5cLvyc17vN5+7jdsEW3Sw0UMPRuG74Hr
 sBtOFe+gCFSwR2CR9afx54qYpPCtjJ8X1uxeh4zly1ls0NjqH8/b2io49upwr/pWSEWN
 kzkWRwURnSVk/PFokckS+zQR2CgDx4GdcC7S9AWv9LiPr+11VvT8bGs1lHEftTGVy9py
 0aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723681297; x=1724286097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70tmt7SXXA8xNV/GOXmAHGlkd6Y3uEXM0oMIn+MfWWk=;
 b=Spf3O4VSJBvbz7JHjWck/5kecoz5hlJrHg9CMIr5N/pYxAZvTsQO4iLDxOb8v8+y29
 wHzHp5axTKOfZk1/fNupAs11zyI8zO5TVuMH6Br2LOXj2EE2Az2AOLy4GT5uwlrt6emb
 IjJ7mV7cuHS8NwuBxKbAZqIt4kCDC1eL4xlGyN+BkRyNMjC2A2qm0g3YeJlsfvn+gVlu
 75mTAGzDVpX/4Rm11U8WBfwKzCBDvCHgzuOsRiZZK6trylr3qwBF2McpOLChACO8HgAF
 qeFu5dnKfPaRGpR4z7anktjVtyKlW1VNMzm9jkDgaw2a+7N2aPEEk0CjlSca7Jlkjcht
 3Vag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpae2U7Erqk0A5d+K5KVAyLyKpyeri0u9vcufm3swM5gxz1FJJrMx9gfsoXDDdzVPPkHDm/ACtGozQBTgWnGY6CCxVeus=
X-Gm-Message-State: AOJu0YyWkavz0ZehTNK3AJr6VnFVKDdt5LViRTR3jQ70sUlCSQQOx6pi
 hdsyxIzMSc4DO9XLFxTGaseGWbLrtC23FDZ3+BqqXUBv/yBB92n+iCQm0y/nwRA=
X-Google-Smtp-Source: AGHT+IHcFOepqsH/6Q/9F/rNl7zNg+U6jP63+E2fx8QnWHphBOzjOXT1z63hJy2uE17YXxm6B1svVw==
X-Received: by 2002:a05:6a20:c6c2:b0:1c6:a83c:d5db with SMTP id
 adf61e73a8af0-1c8eae97feamr3442947637.31.1723681297382; 
 Wed, 14 Aug 2024 17:21:37 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02faa03sm1961185ad.19.2024.08.14.17.21.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 17:21:37 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v7 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Wed, 14 Aug 2024 17:21:24 -0700
Message-Id: <20240815002124.65384-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240815002124.65384-1-yichen.wang@bytedance.com>
References: <20240815002124.65384-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yichen.wang@bytedance.com; helo=mail-pf1-x42c.google.com
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..3aed5441f7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2992,6 +2992,18 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QATZIP
+static void *
+test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                              QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3089,6 +3101,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QATZIP
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void test_multifd_tcp_qpl(void)
 {
@@ -3992,6 +4015,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                test_multifd_tcp_qatzip);
+#endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
                        test_multifd_tcp_qpl);
-- 
Yichen Wang


