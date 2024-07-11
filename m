Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449E2C3DA42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 02:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRjvO-0003vg-B5; Wed, 10 Jul 2024 22:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvM-0003oe-Bt
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:48 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvJ-0007sT-LK
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:48 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c9cc681ee0so246072b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720666364; x=1721271164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cApDvkpHgcDvEBUZlaSazyrta9dSUlvo1AUuexPKHyE=;
 b=J/9Qb5utnTsJEzweD4GsJ7f9zxwDWSN+jExcspMXxmf2NRaZSA1R8g+yYHdSQ9d+LX
 ddrdCBcL+Bf0JtTzm47D7lWwlMMmoblF1hV6Sp/CVeSdQel2QYxEJo+ZmOZOr8KiotdT
 5oswnmthMIf/02b26QquaaBdTb3e26VlHdp173VOMJsIm79aVksDLnNw/8UBp1delRNc
 l2V5aB+buWuqBK3SnyrQQ3SLxjgm0p7ceg3fuu9wJGwG3leACSVqfyoDu2FhM3jQkuXO
 QwPMYhFsyz0HFkI9k7u39IuVz3PDT49K1JhwcI8TgwAKYC4bXbeyl+plHkBB3CBmFFEP
 DAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720666364; x=1721271164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cApDvkpHgcDvEBUZlaSazyrta9dSUlvo1AUuexPKHyE=;
 b=pKN3/PApgpyI1zoIYwjJRDc+E4DzXbWB+gC4R+trzmn2Nke/MzyLiA1uBOel48jo5a
 vO3c86BZVBX+vQzqY4nUva9mtb6g6kHjkHK1ovEMy7aFFB2GOIWdmPbWlCsAOxkvs47y
 4LfPzy354iCWOBoSEkIwxlhFJg65yneloQdYucotx2cb7VR+iGEq0b0YdLBI/lHJRF8E
 LHFWZuv9Kmn0WzMcLAvWWRvE6vQPbVBIOn2RQsW7+RAWITsmN1mPW+Icm180MzHQ0LX2
 st6cA4Yt2PK9G82iKM7XGVupRg2A2iS8JwVltL9H+6bvv4Ut1JvPl/iygfnHLo1X2dTT
 vrbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOe0weEbgL/BEMm8z2PEcbcKfr8sQf9hGf2OXZgyhN9FIFQIcVeVPmZx/tT32JR6gPZBc91l16inw0/LO4f3+gZaFARZg=
X-Gm-Message-State: AOJu0YzmIEFWN4BdmwZJcrBLuakuIiOzCU76lXNyAzUk0BeyOjPCwfhV
 din4r5TnJo3R96okQ4rgfHX90TAQiwqGO0HNhy0Uq/qBh7CpQZqR+uNNCNjFa48=
X-Google-Smtp-Source: AGHT+IE/h/MdfIYVRq4e/+LOOcGb11ueLZ7gK1IFWztEhXtnnM7ZF2ogj6FebcLruoTEDnFX+IwwdQ==
X-Received: by 2002:a05:6808:8e4:b0:3da:a279:ac1 with SMTP id
 5614622812f47-3daa2793766mr566510b6e.52.1720666364359; 
 Wed, 10 Jul 2024 19:52:44 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3daa12f4f7csm117827b6e.41.2024.07.10.19.52.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 19:52:44 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v5 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Wed, 10 Jul 2024 19:52:29 -0700
Message-Id: <20240711025229.66260-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711025229.66260-1-yichen.wang@bytedance.com>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x230.google.com
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 tests/qtest/migration-test.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..b796dd21cb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -32,6 +32,10 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
+#ifdef CONFIG_QATZIP
+#include <qatzip.h>
+#endif /* CONFIG_QATZIP */
+
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
@@ -2992,6 +2996,22 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
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
+    /* SW fallback is disabled by default, so enable it for testing. */
+    migrate_set_parameter_bool(from, "multifd-qatzip-sw-fallback", true);
+    migrate_set_parameter_bool(to, "multifd-qatzip-sw-fallback", true);
+
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3089,6 +3109,17 @@ static void test_multifd_tcp_zstd(void)
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
@@ -3992,6 +4023,10 @@ int main(int argc, char **argv)
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


