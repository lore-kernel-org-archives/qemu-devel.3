Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541AAC25B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 13:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sArD1-00016c-Lb; Sat, 25 May 2024 09:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArD0-000162-CZ; Sat, 25 May 2024 09:13:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sArCy-0007Gh-PC; Sat, 25 May 2024 09:13:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f3469382f2so19528095ad.0; 
 Sat, 25 May 2024 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716642791; x=1717247591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMBZRk5DaM+sm3AueYuXflAX4KvkNhNyU5gkYTdSzFE=;
 b=B+zgyQk2pj+hjnUmc0/Yo51syW1DosfLE5Z/bxLTv3Tz+nwkOGtR6bEeWomWOoUe4O
 ZsosqRmtQIXBMienw0bBPk8JNtiJtre82UXKuKH9qcr0z5eliHL1r8zTfy70X8DLfwqu
 DQ/hh+V8GYI+PeTHAX3gTNVii5vzETqT7pKoY8EaIiXzQ6tCj4083FZdqdDzjFY2NT67
 XBsGShqhBuTx2eDIbAd2vXQi2hjQS0Nj8Gk8cyIkqQT3YRH7Nexbtxyg2SoSA39qeK8B
 y/imRHKkiFXN7mHGydQKtuInWDYihYmhDKJNh0kj8ldWWmVs2UalvC3//HirDHc5qhdB
 sqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716642791; x=1717247591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMBZRk5DaM+sm3AueYuXflAX4KvkNhNyU5gkYTdSzFE=;
 b=IzwSAi91AfbeeVkVPIYNEfBqy7lwgb1dt8iFz5cB4yduCiMhwmiGbHoTZIH0aSe6z3
 hq4vAL8E6mnGKn3w+e6S23blk8Abjk/BAwsX+L2Sh7wbpw/MG+xNU+Z4k0etag/Nn3ih
 4rwvfHzj39nMIeClxyGifmabX624uFkTX5GXo/NOLfIr0mWC+IQUd37kR/1kkWebGtIr
 2U2J/rIBw0Pm4btYgsiXRFB0ef6vc2EXT0p2GIoqQDyiJxlS4x6P3DKux8nxDrUkiS8D
 ICjk0V03h3/sSDC8z88mLY5Vk7OrQ+N65OhCyeB6xIJIwWsF1VuYxbkst45niILDldg1
 k7ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgw+DJZiDmRLbkWPTohYzCylYYVhVe8Lzlziafj9w9dFVOwJA8MFSsmg9SWy91ThkJsRg+3H8nm8QRC4Xn34gaBTznIb8=
X-Gm-Message-State: AOJu0YxIAGAHM8EvM+JqTi8IyroBBp+x/Hf/sW7DfURaK34sSoCMOi+p
 6odcRNOJLZHwSvbeKWIFCK3r71jLtGB7XPlAOuKt3E8UFldQmEYj+hEZ8Q==
X-Google-Smtp-Source: AGHT+IF8sfK/n1Q/HRSrp01nsiZucotYi7rUrYOSYG7qnbGhaC0KHHhi2mA3sEcmqO0yZuiCjm+XWw==
X-Received: by 2002:a17:903:1c4:b0:1f3:7a3:8fc9 with SMTP id
 d9443c01a7336-1f4486c56f1mr63599785ad.3.1716642790912; 
 Sat, 25 May 2024 06:13:10 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dd1efsm29653525ad.291.2024.05.25.06.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 06:13:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [RFC PATCH 3/3] tests/qtest/migration-test: Enable test_ignore_shared
Date: Sat, 25 May 2024 23:12:40 +1000
Message-ID: <20240525131241.378473-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525131241.378473-1-npiggin@gmail.com>
References: <20240525131241.378473-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This was said to be broken on aarch64, but if it works on others,
let's try enable it. It's already starting to bitrot...

Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7987faaded..2bcdc33b7c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1862,14 +1862,15 @@ static void test_precopy_unix_tls_x509_override_host(void)
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
 
@@ -1898,7 +1899,6 @@ static void test_ignore_shared(void)
 
     test_migrate_end(from, to, true);
 }
-#endif
 
 static void *
 test_migrate_xbzrle_start(QTestState *from,
@@ -3537,7 +3537,10 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
+    if (strcmp(arch, "aarch64") == 0) { /* Currently upset on aarch64 TCG */
+        migration_test_add("/migration/ignore_shared", test_ignore_shared);
+    }
+
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
                        test_migrate_precopy_fd_socket);
-- 
2.43.0


