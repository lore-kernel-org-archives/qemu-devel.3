Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6A8CD4F4C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 23:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slznq-0002q2-K3; Wed, 04 Sep 2024 19:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1slznp-0002pT-6m
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:52:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1slznm-0004T0-L3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:52:44 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72AB13F327
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2024 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725493958;
 bh=rxc1an2UPjPAtuBFdk2Bi6eUcOF8sWbbGVTIp90Oj9E=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kVK1qBZV4fzq4YnMIXyxIJI2exG8LGAdZCgqJx0ByEnmO6lhvKPKaurbDZLevCSd8
 bZIfZPVp9U7DQ5/hM5XI445MBm/eTjic8Xa2Fmr9YThPdR1w1KBx8iezQaL7wtoTc/
 DRs3164e7B7kZ+9gAbA0xp49kxi+0EipRCqjqcCo7iGdLoOH32oOngd4I7hHPE5CfL
 Zxd3Wl7uDkmXfAiVy/ePdUKn81GsMPFx3IGQ7ugOCyUCFSaB3Necaouk4hJdbBEnqD
 rHFdpdq4GL5zdoLLC9Ym8JuSbwYQz8dZ+12VN7JKPruI2n+6jv5rotQ6cveQHAKt1k
 8Ekwpy1iin6gQ==
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-715a16b4206so179637b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 16:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725493957; x=1726098757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxc1an2UPjPAtuBFdk2Bi6eUcOF8sWbbGVTIp90Oj9E=;
 b=UQULgv6vS7qiU+wPGxBmIAdUE1xQYyTDLSqvmUHfpzTC0iqrLTlbwkmolEONyNX5nj
 qLMxOsne6mfPsA+qLxn1GvXdrptNeiy0w5cMfp9zCD403/1QYGScGnwyE/TlBTwAiWke
 fHKvV0/Nfgss/YVUeR2aNaQwwFCVmmBo4JoAC+GBtGmWfJQ2T8LJafeigJhyaWh9I9BI
 ZjcRWYhddScBho7j/GX1MY+RRiBaXRu1/FcIFY9gihqEZWcikjphd1qDufYMaph4MW2V
 9PdQUpgQgoyXSitB+hIDtpHqOdCdVUj70PUJOJcyLgMmoCthHK+ckZIUKx4hfCyQTFVS
 bQeg==
X-Gm-Message-State: AOJu0YyUkEyqaWxJAmmXWHwAQeHhqypblZzOGDGnJQr06WL1uH9ZSMfg
 l3qadaRTd9FN3h4y9lHt2MMxQ0t28jOlKvg5b371ynSY967R8X/od7iM33QAtCrajCNrZCQKj+5
 YMdiC/38uYhFa5gqDMi/g4p4Nf0LYxA7aXsL5vzSLC55Am8u0QVoKTvbNM435/qKmT4C4sdkQZA
 jF
X-Received: by 2002:a05:6a21:1698:b0:1cc:e9bc:2559 with SMTP id
 adf61e73a8af0-1cce9bc26acmr22407812637.28.1725493956935; 
 Wed, 04 Sep 2024 16:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDdRrChnyg3PWwiAUTx/bwq8GOUrJ2aJUrgpFgkBcC9V8fj0IflTBtNcjSKroBLm8VuY0Awg==
X-Received: by 2002:a05:6a21:1698:b0:1cc:e9bc:2559 with SMTP id
 adf61e73a8af0-1cce9bc26acmr22407793637.28.1725493956362; 
 Wed, 04 Sep 2024 16:52:36 -0700 (PDT)
Received: from gram.. ([189.5.22.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7178a9482d1sm391314b3a.71.2024.09.04.16.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 16:52:36 -0700 (PDT)
From: Tiago Pasqualini <tiago.pasqualini@canonical.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH v2] crypto: run qcrypto_pbkdf2_count_iters in a new thread
Date: Wed,  4 Sep 2024 20:52:30 -0300
Message-ID: <20240904235230.199672-1-tiago.pasqualini@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=tiago.pasqualini@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

CPU time accounting in the kernel has been demonstrated to have a
sawtooth pattern[1][2]. This can cause the getrusage system call to
not be as accurate as we are expecting, which can cause this calculation
to stall.

The kernel discussions shows that this inaccuracy happens when CPU time
gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
in a fresh thread to avoid this inaccuracy. It also adds a sanity check
to fail the process if CPU time is not accounted.

[1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534

Resolves: #2398
Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
---
 crypto/pbkdf.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index 8d198c152c..d1c06ef3ed 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/thread.h"
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
 #ifndef _WIN32
@@ -85,12 +86,28 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned long long *val_ms,
 #endif
 }
 
-uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
-                                    const uint8_t *key, size_t nkey,
-                                    const uint8_t *salt, size_t nsalt,
-                                    size_t nout,
-                                    Error **errp)
+typedef struct CountItersData {
+    QCryptoHashAlgorithm hash;
+    const uint8_t *key;
+    size_t nkey;
+    const uint8_t *salt;
+    size_t nsalt;
+    size_t nout;
+    uint64_t iterations;
+    Error **errp;
+} CountItersData;
+
+static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
 {
+    CountItersData *iters_data = (CountItersData *) data;
+    QCryptoHashAlgorithm hash = iters_data->hash;
+    const uint8_t *key = iters_data->key;
+    size_t nkey = iters_data->nkey;
+    const uint8_t *salt = iters_data->salt;
+    size_t nsalt = iters_data->nsalt;
+    size_t nout = iters_data->nout;
+    Error **errp = iters_data->errp;
+
     uint64_t ret = -1;
     g_autofree uint8_t *out = g_new(uint8_t, nout);
     uint64_t iterations = (1 << 15);
@@ -114,7 +131,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
         delta_ms = end_ms - start_ms;
 
-        if (delta_ms > 500) {
+        if (delta_ms == 0) { /* sanity check */
+            error_setg(errp, "Unable to get accurate CPU usage");
+            goto cleanup;
+        } else if (delta_ms > 500) {
             break;
         } else if (delta_ms < 100) {
             iterations = iterations * 10;
@@ -129,5 +149,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
  cleanup:
     memset(out, 0, nout);
-    return ret;
+    iters_data->iterations = ret;
+    return NULL;
+}
+
+uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
+                                    const uint8_t *key, size_t nkey,
+                                    const uint8_t *salt, size_t nsalt,
+                                    size_t nout,
+                                    Error **errp)
+{
+    CountItersData data = {
+        hash, key, nkey, salt, nsalt, nout, 0, errp
+    };
+    QemuThread thread;
+
+    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_iters,
+                       &data, QEMU_THREAD_JOINABLE);
+    qemu_thread_join(&thread);
+
+    return data.iterations;
 }
-- 
2.43.0


