Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B18C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexa-0008PO-IE; Sun, 16 Aug 2026 13:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexZ-0008Nq-Lb
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexY-0003Cd-6T
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbeea240819so1369551a12.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902467; x=1787507267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6naBanft5dzX6viSmmU3Uw6eq1ZNfugHG1TUba3f5YE=;
 b=UCj2BuwBHuVRpl37UJAKBNKdSMLb7tw8OrLuE0fsEWSZHqlpQv6LiAlEjrJcVjZWJM
 He1qAu7nkE1Cp5E6p/4M9XX81oo7MkgDWwwBloKVHI8Q0UwwKiMOgmBUHrEzH6q9NYoO
 MPiAzHct30PUe6uYBEfq8HAv4Px/qOpEvgkTWJEj0BIWDsbZdiBff4fxkWuO1W6csYIt
 7E08X2OozuEmGTAID3IofiQS/shhA90G9rbVK1bmVwpd17OppIHuPfdYsnuHQp6XxuHi
 c6mnB4a6j5VZEaCV9C7IbCf6v2qSup6gU44vCL6IOv0JNyOC1/U74lMz8ngKoyGP7835
 L5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902467; x=1787507267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6naBanft5dzX6viSmmU3Uw6eq1ZNfugHG1TUba3f5YE=;
 b=NcbGb3eZDGFaYPZv3Qft3xBtEZ5Z1GcNDH/3h/y5wLxovXc5HEWRLY4Pph49gguLmE
 gQca02JxapWVF5UEFKztA9j0BWGbrdZIRIoRgGPKfP7b6uHMkJBCCjZ4UTtGZl0g9g+N
 glX82WnLHcDsI16n2P8TevPQRxj8xNkuZHd5OPyy8mRR2/xT5i/yOilZ2FVqhWkbg/OK
 XJt95j4x8lc/bQRvelFFjVc3ZeCHTWl5xO7riOqDf/w98ULZUPHbRpHwDAAW0jN6/VvI
 +NxkktUtycG+m8Xz/qOBmTuT8V6zpzeNOQMLid3GoDqQZSfkeGdDoQT8md6grwMOoGr9
 OAXQ==
X-Gm-Message-State: AOJu0YxNoPyid896KrSI+tYBpTnhxbqFchXGtHYVqxkUNRfvKKGk1pPj
 r5ds2s1qm1x98fmfrEfA9UmoEXEfX5Md5z+Ni9ryeVO156f6/caFM+R2b/QNRQ==
X-Gm-Gg: AR+sD12XTUzj/08KZelAAbwVOeJax0YquhptC6obglg2POQ76l5Bcj8eY4QIarmQWLH
 hwJFPVahBPLtoiSyAGHa3nPdwAA1gD35w/yfgKNcpchQ+DT5csCqP0/NPUKZb5Dqi0uQh0bI7dX
 LvqcuNRrlIOXyn3b6Vkut31VO4trpJ1RjbWeOaQSSmnflhkwym0iW2cE8sDTWiMA+zo22jODOnv
 FdsN6m4Vj45q0AMsELBFSvXCkLBePwezrElAX2dv5ElBww28glclUeHvkjEJkMPtV2V/2n3hHCz
 X5BRL/kRijQrtcugUvK56Vj5+ab6s6qehrVc13OzsEV6wlt5bWfPL7fbvufW/qa845G2j8kGgcH
 /rTdSD5HK3/Ow0pc3H34vNQ5Z18eB5beyT4cZkiX/VJpdWYwRgUN8co4xq+Et33V3FAImYOk/yK
 4Sga4+faKzsS8QPAF9hTtQoKcaLgMPAItLtRFyZ+48MFtO6bKPs3FwR5ORmqDROPPIdvI5QBE5G
 AbU9YhIR7WE+8o=
X-Received: by 2002:a05:6a20:9183:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3cc71de5b86mr21332452637.35.1786902466786; 
 Sun, 16 Aug 2026 10:47:46 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:46 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 10/11] migration/tests: Add test for fast snapshot load
Date: Sun, 16 Aug 2026 23:16:30 +0530
Message-ID: <20260816174631.1547811-11-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add test_postcopy_file_mapped_ram() to test for saving a snapshot in
mapped ram format and loading it using postcopy/fast snapshot load.

Test is similar to test_precopy_file_mapped_ram() with additional
start_hook to set postcopy capabilities on the receiving end.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/migration/file-tests.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5118d9dec9..c7e4b05c61 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -190,6 +190,25 @@ static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
     test_file_common(args, true);
 }
 
+static void *migrate_hook_start_postcopy_mapped_ram(QTestState *from,
+                                                    QTestState *to)
+{
+    migrate_set_capability(
+        to, MigrationCapability_lookup.array[MIGRATION_CAPABILITY_POSTCOPY_RAM],
+        true);
+
+    return NULL;
+}
+
+static void test_postcopy_file_mapped_ram(char *name, MigrateCommon *args)
+{
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+
+    args->start_hook = migrate_hook_start_postcopy_mapped_ram;
+
+    test_file_common(args, false);
+}
+
 #ifndef _WIN32
 static void migrate_hook_end_multifd_mapped_ram_fdset(QTestState *from,
                                                       QTestState *to,
@@ -330,6 +349,11 @@ void migration_test_add_file(MigrationTestEnv *env)
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
 
+    if (env->has_uffd) {
+        migration_test_add("/migration/postcopy/file/mapped-ram",
+                           test_postcopy_file_mapped_ram);
+    }
+
 #ifndef _WIN32
     migration_test_add("/migration/multifd/file/mapped-ram/fdset",
                        test_multifd_file_mapped_ram_fdset);
-- 
2.55.0


