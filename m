Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335FEC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkwB-0005LV-PK; Mon, 27 May 2024 20:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkw8-0005KT-AX; Mon, 27 May 2024 20:43:32 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkw6-0001kO-9K; Mon, 27 May 2024 20:43:32 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso237913a12.2; 
 Mon, 27 May 2024 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716857007; x=1717461807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mPEcT8P6LlsNxCea2gf8+eejmJ05T1RMXKOf/aIwTk=;
 b=C7Q823NIkmUvjUMQvT6bJfo3NVILYcJydMNUL9MD85PtcsxVYWG1iWAHyCifNZ9v+/
 2L1s5au+o4hCjBuM4oztKXAjvVXIBBhXp1EUMl0z56jg40k6xygop+uHMkMZkrRIIvxh
 l9lEzWpy7SEkL7o5klMgQRRgTboaa93nOF7IUW4AqsWApmiTZQbmNI94AvZzYRhgK35k
 /39zMEMyihj4hJgw07EA1Cl/jhoGlNIufUTJcbsxDIb+x1wWPLKRwNZCA4gslnAcp/ja
 TBNc8GQ0D99Y69JgEcDBdzIkmMpRsIJoNo3Cg2ImB+leSGqzq9zRYYSE0cKDgkZzhSpb
 OwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716857007; x=1717461807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mPEcT8P6LlsNxCea2gf8+eejmJ05T1RMXKOf/aIwTk=;
 b=pPd8SrZFoe1KL8UEOW9KUVhIQN3BqcWIwf8zWunGKkl5WmjVHi+F68UQd3aSh1URRO
 DkNBoo7TeKORROvfTJfTBybySzlQlF148RrkhiWrqygVrdwEMZN/jglAp8ztSn3jwOhB
 /FiQQeF5vJltu46/NmbkE+IXkRyaICcNtFReC8h74syfDB6pZVjkVCjonc5uQBZFJl9E
 rbPKyvgIBzmou2DDls/e+t2AXElxgER4YI3I1VgCyaGEki4Y6SRj6nLBRk0aVD4cffqe
 AZZgpS5s8vOmdcR7XZKznFlHptbg95VyQp8TJwDCOMwcKUABo9Je747nJeI42U/2uxIg
 RqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEeJIppNTrClPQeEWiTDjbQiVdTlmO8dR5NkhYetJw6FV32kAGOqJXMuBwrUN5Rronv+pxhFGBBGEKez69yCVPYc6+
X-Gm-Message-State: AOJu0YwUuKskgqpJ/gxx8XMspTAaydpjtTPO0rtei03TUGMMnJAWONjK
 q61Lb+Y/DYOaOg1bgsdg4fuAcOG3w+Xn7xy+/jFU6joSSwAsRFipPthPQQ==
X-Google-Smtp-Source: AGHT+IHqoFnHHbxx0Q63S8Sqvhn9jmI40SjLAPh8Vzn/zHVttsK5p2xvIBVaelNFNPF2Q/2xliuefA==
X-Received: by 2002:a17:903:1c3:b0:1f4:6dca:234e with SMTP id
 d9443c01a7336-1f46dca265cmr101261155ad.25.1716857007105; 
 Mon, 27 May 2024 17:43:27 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:43:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v2 2/6] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
Date: Tue, 28 May 2024 10:42:06 +1000
Message-ID: <20240528004211.564010-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528004211.564010-1-npiggin@gmail.com>
References: <20240528004211.564010-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This test is already starting to bitrot, so first remove it from ifdef
and fix compile issues. ppc64 transfers about 2MB, so bump the size
threshold too.

It was said to be broken on aarch64 but it may have been the limited shm
size under gitlab CI. The test is now excluded from running on CI so it
shouldn't cause too much annoyance.

So let's try enable it.

Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 04bf1c0092..8247ed98f2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1893,14 +1893,15 @@ static void test_precopy_unix_tls_x509_override_host(void)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-#if 0
-/* Currently upset on aarch64 TCG */
 static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
+    MigrateStart args = {
+        .use_shmem = true,
+    };
 
-    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (test_migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
@@ -1925,11 +1926,11 @@ static void test_ignore_shared(void)
     wait_for_migration_complete(from);
 
     /* Check whether shared RAM has been really skipped */
-    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
+    g_assert_cmpint(read_ram_property_int(from, "transferred"), <,
+                                                   4 * 1024 * 1024);
 
     test_migrate_end(from, to, true);
 }
-#endif
 
 static void *
 test_migrate_xbzrle_start(QTestState *from,
@@ -3580,7 +3581,8 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
+    migration_test_add("/migration/ignore_shared", test_ignore_shared);
+
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_migrate_precopy_fd_socket);
-- 
2.43.0


