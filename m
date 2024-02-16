Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B25C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tQ-000544-3d; Fri, 16 Feb 2024 17:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tN-0004vQ-Mv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:13 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tM-0007K6-0k
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:13 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4c0375d438eso973150e0c.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123271; x=1708728071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwX0gK/0yCJN5W3TVY6lm3Na3nSQLdooSPqXCUs7/Kk=;
 b=b7tFT5hgGieqV1KXZtA/UJanWiYIjN4nMc/QtT70k0zZSYNYQ4FZ93t3Ersse1ghZQ
 AUDcvHj349z2pTzgukv2Osa7LbvcNsY2fMTOxcBI/5TVdQIJuTgAu+obAmTS2Ps3ty+i
 uaGHrbRnaQ3ywjTi1cfakdE52/P8sMDeVIsSeyHe2XXZZokYENBJ7KFkidWkoAtPLTb1
 xL81AL48Jv3iAPBuPglIrKXC8ZjsRaqxjrfDUC0z+7VkruUs0yP95Lwgx0UYqpHVJQfa
 aw3tmDm6ds6ULok5WbOegtxP+fwAkDi1FWsugLXThauHOB1W0gGiU9U4gyZmKZaCn164
 nfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123271; x=1708728071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwX0gK/0yCJN5W3TVY6lm3Na3nSQLdooSPqXCUs7/Kk=;
 b=QCiZgtL7P9+rERTsNyslsQlIkk85pcZLCO8z7sAktF4FwJPnyS8H1tZTxELdEiuDoq
 MrSl+lbbG2yqek27VWtpnapM/LWegWcH/YXtww5Us36CJwBWb7drohfxfMmfzzdpGS/a
 iMTik0ry3DtQk01Gnum75eToGSC4N2j1LGYwboMBIN8UWxPqo/DwMuuQWSbfiyt8qCXO
 Vzua1ThbI4utBAPmDC5uyAtmPsOM0gV7YI4xWmqp8o0MYDXmkxjIYV0BBAp168TMUKVT
 njutF2HeyHio6B1Sp/H7LFNsBm15bacwx2XPpYbVy1HFksGGCc6dWnbgvF2Xew8VB2Ii
 HMKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXatWiLqZ5hxpeUKRK3gs4/NiEpkddg/8EacYtv8zmV5W43MfIlZJnOI/K9NKcC+dGJyreh45unDTjh3Gge9yNMEdNzimc=
X-Gm-Message-State: AOJu0YzTQtC8V0ccB8nBLbqhGOTy68cCOVYaafQipKFs75ZeH/NsU4zH
 kOhXJSZoBKX3s2jd6SxoCL/d3VleVVpJAh5s75Zd4uk6zm6KbONOKUvR3PYGguQ=
X-Google-Smtp-Source: AGHT+IHFI/KudF8hUc+21IzrFrXYJ/N3FkmT7UjkcCVElptK5eXuuHo+YTx5537KczEFSg077WT9ew==
X-Received: by 2002:a1f:cc86:0:b0:4c0:e29:c438 with SMTP id
 c128-20020a1fcc86000000b004c00e29c438mr7308132vkg.8.1708123270926; 
 Fri, 16 Feb 2024 14:41:10 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:10 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 5/7] migration/multifd: Add new migration test cases for
 legacy zero page checking.
Date: Fri, 16 Feb 2024 22:40:00 +0000
Message-Id: <20240216224002.1476890-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa36.google.com
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
index 8a5bb1752e..c27083110a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2621,6 +2621,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
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
@@ -2652,6 +2670,36 @@ static void test_multifd_tcp_none(void)
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
@@ -3550,6 +3598,10 @@ int main(int argc, char **argv)
     }
     migration_test_add("/migration/multifd/tcp/plain/none",
                        test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero_page_legacy",
+                       test_multifd_tcp_zero_page_legacy);
+    migration_test_add("/migration/multifd/tcp/plain/no_zero_page",
+                       test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.30.2


