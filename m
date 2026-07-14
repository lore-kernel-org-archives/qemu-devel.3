Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA4C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwx-0006f1-V1; Tue, 14 Jul 2026 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwu-0006XX-9N
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdws-0002fA-OM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so3517081a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038645; x=1784643445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVg3v8CNWYJMVnr2dIbwlnL/I8cway67EWY5NeiWAvo=;
 b=Trq+jcGFvPJySROpB/D9HvlBINMugKCHXFHuW6WQGA69tLT3vztc7xt0cYFkwOs46D
 /q8CtqZwtzVhyRTxn/G45XfIg+rnhlzvjPTwlm3BSgOY/stRXA8/wt2Jgti40oC/he5u
 WeKStIZEyywbLRzBOcsqWGzTv7qEsZuTjPSVd93HdZ8aDFVVH8Ra7rMCb55PhYWOin/S
 AL9j4VG5hlYUFlOiCJ969MsdazAxoou+C6eabZ/0HDlb+HAmn/cxNTDJsuif7Hnw+bA4
 kTdTt9w95PFDErFXf5ZeBWy1T1uTrQXvXPfKkiuD5wZW2oP/GaFCAZdGHNOUm1yChIRU
 ojew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038645; x=1784643445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVg3v8CNWYJMVnr2dIbwlnL/I8cway67EWY5NeiWAvo=;
 b=BfPj3214yzLB9fgrWJVqYQAEqCRCSNeMNAJtdQ8G9biMFlsppC9TqLkpwuatDpsvTg
 yAUHYTzsel04tTwtSm5+tPGQf5vV0fJD2iCM/BstHacCYcewslFmt0DC5caQmYlDi6Au
 7cUrbkTKjq8Nh9oh5Bu50x2p8lleQUx761wcHbO7cgHFvH+/3LOMWjl2OX17ce8qmoco
 /D4uB3JV+adMI95aP7JZLze8q6Z0uQte/bTNBSnfMXacCRxXOWKtIsteWX2NWrxam84s
 EmMgIeE3nybLCSIutZAcvo8bdZYZ7wxES24O7roSlcTbEGu8kS0L64QzXS3swjrVn8LE
 GCHA==
X-Gm-Message-State: AOJu0Ywvr0m3xkXJ1UNk+RL4ufW8dkVaHM408pf6sCh4dajna1YCH01M
 oI76ruAHDSk9175D65+TItpkfu8A7bSKARo1J0o1dx71F5ro2dt0eNWX76CNZ/6+
X-Gm-Gg: AfdE7ckxQ2Jy4WW6L5diT8ObrYTtJGRwrmlOgV1deu+6a22EkGUoewselN5k/bGGv7h
 04oc3aZ50bNVvHUVJFOK0Leeg1dJT8L0ZUCXSgyy3//AFGOBWYoHJROx1RuO2lf5R/jJSY7hCOb
 iEIbJ4JFdQSAW/uuxrRxuFg83eQ5VDa8YI6UX83/9bqtKlzKPbGMPxXokb0J/Nzk7oRg2FbojkJ
 DWpyKApoHDWmX5rSpNFLSaPqGd+0M9ZlwOigOarBqNlIc2Qum/YybYEb8fznr02B3LDIAvEN78H
 U635rJQqeHH5IGjKVi7MZYzX+R7qRDmpHYRT4SnU7WYrkJEM5sYAtUk8wolSAKilyTgzV5LhDPz
 bP4ZgMVkomX1YbFAo2t+OqXPV7XP7hFewbQdjsiF/m8IIF11gbxLN/kSFCgb4FhNScOECSq426f
 azjVT1R7+Zrw7CegKOuTCNExeAoIkOAa1f3umA4MBofxYPmvACeufC
X-Received: by 2002:a17:90b:1d52:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-38e1ae5f663mr3032527a91.4.1784038645017; 
 Tue, 14 Jul 2026 07:17:25 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:23 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 10/11] migration/tests: Add test for fast snapshot load
Date: Tue, 14 Jul 2026 19:45:46 +0530
Message-ID: <20260714141547.1268000-11-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x1031.google.com
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


