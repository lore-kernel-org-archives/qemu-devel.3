Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9FC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 00:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkvx-0005Hi-1U; Mon, 27 May 2024 20:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkvv-0005HW-Cg; Mon, 27 May 2024 20:43:19 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBkvt-0001jx-Hz; Mon, 27 May 2024 20:43:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so2597925ad.0; 
 Mon, 27 May 2024 17:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716856995; x=1717461795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYItAgXfmEMBJST21EhnFhl+vIQAb1/uVlcExgVfNw0=;
 b=jjRYIaBXdID1JDjnR4kmA+pPHM62JvmNLkrodip1wxESkxveDYZt6n0k5XEDM0yZbq
 3wxEU5Lw3Oy0nb1fsJqhw7a6KB75CodGb/yzrMEd35wTEY2fbopCA3MlWV6ZXjmv6U+1
 yBQiXaIkHLpgG3V9g7PcasJ0KI5POnYpxRBEO5epjCZNg82tuaGvGxjIZuvWH2FUf9iP
 s8Azvhyv9ynUfSlspY3qrdHUQzBAFYJAgoznb5d2SXO0WW3yNAS/rgCHyFex7C/nD0e6
 RKo7LXubSFgL3NL4n2G7GuusABKkV44tpEBCrbeXST6nFcChSplBOIveOFW9HiMOJbOa
 tWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716856995; x=1717461795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYItAgXfmEMBJST21EhnFhl+vIQAb1/uVlcExgVfNw0=;
 b=J/nk0aXRw61AuiyoMJGkhWBXKEVQdQVm9m8g9aQVJu3GLtreloPfau62RyCCrLO9kj
 mtnpbkqaPRqluqXvT91Z89R9Xr60gXxWRifVdNjNZd5wetILxcBAxglCmmEoIuz9kRoF
 k1wxrlJkOy0VUv90QEKxDbPL6ci23VADNAcmlfSFYNHXXqvfRL0r5IFINsRVoCcklnju
 NgLzrPnoVELo3ELv2erdghM/F9hdzhVz1/xgZVj7ZjKgeoiqpjf78VoPcI1HQ+uV7H7Y
 9lSRpQjF5zfbSqSG1MXRS/oZ8ncW/CPpMSXNIXJRv2OAzPlYfv+uhQR5Bdv+Djy2T304
 pwmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR62zemtHGG4WuJp5V6lxb23v9Ea7TkO3M4Hnl1MxFak6/lULzDzPJPloSAdiAK0kqmC1TnX6zLw6Ab0hdbtQtzZDB
X-Gm-Message-State: AOJu0YyfAysjkAsDTNY97nJAiALsd+aeciPt1vzDiGyB21VGbhlsbB9B
 GFPXuK+Mi8PPOaCcpNGG783A8jvx/nxau7LbWVUBr68cOfiC6dv8I/WedA==
X-Google-Smtp-Source: AGHT+IETu27bxGuH1BrCNHOGJpzmyaXNt272m2myqcXdcu3cWyT5FUoxJXzkjaUBezJ2EpfRtVj9Pw==
X-Received: by 2002:a17:902:d2d1:b0:1f4:8a14:f4cd with SMTP id
 d9443c01a7336-1f48a14fa90mr52370325ad.39.1716856995425; 
 Mon, 27 May 2024 17:43:15 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm67613595ad.23.2024.05.27.17.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 17:43:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 1/6] tests/qtest/migration: Run test_mode_reboot outside
 gitlab CI
Date: Tue, 28 May 2024 10:42:05 +1000
Message-ID: <20240528004211.564010-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528004211.564010-1-npiggin@gmail.com>
References: <20240528004211.564010-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

As Fabiano points out, this test isn't flaky it just can't run under
gitlab CI since runners have a very small shm size.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7e3406471..04bf1c0092 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -706,6 +706,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
             g_test_skip("/dev/shm is not supported");
             return -1;
         }
+        if (getenv("GITLAB_CI")) {
+            /*
+             * Gitlab runners are limited to 64MB shm size. See:
+             * https://lore.kernel.org/all/87ttq5fvh7.fsf@suse.de/
+             */
+            g_test_skip("/dev/shm is not supported in Gitlab CI environment");
+            return -1;
+        }
     }
 
     dst_state = (QTestMigrationState) { };
@@ -3506,15 +3514,7 @@ int main(int argc, char **argv)
                        test_precopy_file_offset);
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
-
-    /*
-     * Our CI system has problems with shared memory.
-     * Don't run this test until we find a workaround.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/mode/reboot", test_mode_reboot);
-    }
-
+    migration_test_add("/migration/mode/reboot", test_mode_reboot);
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
-- 
2.43.0


