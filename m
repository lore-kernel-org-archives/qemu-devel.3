Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96613C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzcM-0002h2-9e; Fri, 31 Jul 2026 22:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzc1-0002Pt-Jf
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:10 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzc0-0002ZL-5k
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:38:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so923361a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551885; x=1786156685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Buj700lO1RUwuoSNslVesdLNoDjj+hRS++McAC+2AR4=;
 b=pE378p77xts9aKCuv1q9l8T5L/6nltdRGnE+oucUessT7y6y/QYgRXBB9nkCZjW5qD
 BNvNW5imA3dUKPwqbSrDMe5kQgsqzWB9+i5x1SDQuUXWF3DLvSVR/308yKVp697qlsnB
 1L49kZRtzakwE6B8rfjcrXZv97z+K4HeJy7iv4vBNn87ilTMVWLe+k8Cd8xvqDiOeGoD
 XSkug4JjLofuNTPVlu7KVjlHtD5sKEU2LKojSWn6qXORzNgcKfQL0SkHcZucryximYKK
 FJmUbc5tXRuP/1blkIe1yc+F/wOSE8m+dt6QpckBAl88uKZ/14FnubKcV+2C6NfS8Q0r
 s1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551885; x=1786156685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Buj700lO1RUwuoSNslVesdLNoDjj+hRS++McAC+2AR4=;
 b=AZhJK3n3cRxskMbBB673Halftu46/szvVi8ZJfAOqzTIKb1DszGTFTcdtVEaZsJqTJ
 ji0AGJ+28621S5fmZvi/3e6KYjckdPA/m4yOjkb32pjcqnaijICJHQvXe3pB//SP74Kj
 dUwdwTwDvo50a96+cjoqIlnf25RN/CdY3jUarN+LrPtlGw2TtEMgriAn6Eotpqaaj0Pd
 pV20goDVguN8JiqMCYnk9iiZPHiLeXEBhZ9hDaaNK0MM0RIYvH5N2KnM/alU8/mos14/
 Txv7aCtmmPXiiB7Aou+H9k0MP2Y9mYQ9yn4tSdazuddiHB3OcFadNaD7BlhDNn0KLg1q
 BV8w==
X-Gm-Message-State: AOJu0Yx0vlUII0ASxKx6B7AM3WVrjXUT+8ViLiY1YIUj/XVcSxeLlY7n
 dp3rIVhxOzXoA9TkY7HQoUXjbefqATKxbBMak7FD1MpZkT4Zf0WMhvw+Ck14gA==
X-Gm-Gg: AR+sD124Jix9IDTSgtKHZR3vbeDFe6af/7vGqJfy2CXrhvShdWbqMui1uVHtW7iidv4
 ebDIarppFV0rbiMl0BMtp40dDNDo1wrlr5e8coMOpdfnbo1FDefI18ue4N4bMxWfcwljov6oR7R
 W+AeP/xBIpi+usPNd456S/6KYdzDbSXdgvoKbpxO5IrxgMEMC3aI99xdigAYBUSe8eGZjV+P2hE
 0upyxC3DJw6sF3QLxX87J5VI/6aCwngk5U6szjSqo75JJIkQJ49Yx/IvwmZyS/dEaNoO6uo4WaZ
 4UfNoMuz6cJZAtfR2QOjX57h7VA1MdXNyRB84tp5OFULVCVdn/0rtoMsSwVYx7Cfk1fWPAwa2/m
 26T4cYklgh8DPApy2nEhIRDfZsJKoSwsJtAw4tLOuT2jHhjdttWicAydlXUyJ7Aa/KKAMP1vj9j
 COB2jG0aYo4mm2sY1kSCzclls7jrQTJePEpaAM0k7NLlL6lZJXWBk4oqe4drGEjmQJXFWF0aSuQ
 mui/qqmGqooxIa+
X-Received: by 2002:a05:6a20:2584:b0:3bf:b885:2fae with SMTP id
 adf61e73a8af0-3c92aa52cfbmr1871818637.56.1785551885248; 
 Fri, 31 Jul 2026 19:38:05 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:38:04 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 10/11] migration/tests: Add test for fast snapshot load
Date: Sat,  1 Aug 2026 08:06:27 +0530
Message-ID: <20260801023628.22665-11-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x530.google.com
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


