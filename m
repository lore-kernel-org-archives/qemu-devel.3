Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1D5C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrRC-0000mj-Eb; Tue, 13 Aug 2024 09:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1sdrR7-0000lT-Hk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:19:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiago.pasqualini@canonical.com>)
 id 1sdrR3-0002RE-IL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:19:40 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3A84402BF
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723555174;
 bh=mBM+Tsxy29VlzXQX6//MA7mjOxtPqNxXlctklGtGshs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XUasOQ2H9sc9gZ7eAHWDd1Xq5j2+AiW5w1pPArT3s+w/2/Li8XU8XztOeJhMesLK/
 EBpYOlOxhNkSdZJiqU2spWAQFaW/Wk4zeZLgDD/B4KCq6vZuJ3hWhZRWSIdk4DJ3A8
 x+PVNQeEtJyKEjg64Qo2ZFJhzZVv2dRtjUTtDJALAvD343b1L65E72EbIv39QLXVxh
 Ix0P80/3j+7wGy7NFV+faNZ7Eu0Ol4E1ZGZqv32sqjyjLJi9Ki4zKVVSqT49H2tjek
 TAfWTB39rKhGts5+exPlkvJMD7fXkHQnX1TSuNmPBk6OZmTovXPSgG47EaPbK0YIKq
 cpnEFxiQagz6w==
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb639aa911so5831888a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723555173; x=1724159973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBM+Tsxy29VlzXQX6//MA7mjOxtPqNxXlctklGtGshs=;
 b=RyFguGPYDxiFEAMUFLpLLC4Khc/ALGM2f+Nx6VCI/614hvaszJISbctjN9YnBINPHu
 8KTPi7fcYgxeFtuU1HoBpcaq0q527KCC5QIHBvmjtbSaxt+qUfjsAVJcMpxzoySo9PEv
 iUr3b6d8BxvabodLqF14B16Lp687UQriwt6cjQzNfckcUpgdaJEtU/1XvjvOn+NhZPCB
 w22Cn56j8o7Rzqxc8lOTgFlqFWEB/b3D7z6YSjSjemcndRJyuBqOP0AKElB0nkAnYqxI
 yNo57liqmloD9I+4hd+GN2vq7AwxzXgXbKs41lXg3ucUwyNxIthJydl3Yv7C2oryYeTB
 MPmA==
X-Gm-Message-State: AOJu0Yxp85g1z9R7P9NZRk0irEgtibqGAufp/s1Wwk9V01wDghZQ7qEQ
 vvCshyZJoM2s51v/52W8En12uMJLu/cWqIHPmRXnkq5CAgEcAbqdX91GsYU5mKpnPD0k8bPVX4c
 QxOUaoj3z1EF7tz22GdbQlZ2+glkT9pKX/g1BzH3GjhNX5kDGGe9KVYWRRROCvd7A0ORsXaNJsC
 25
X-Received: by 2002:a17:90b:4b0a:b0:2c9:984d:958d with SMTP id
 98e67ed59e1d1-2d392539a18mr4093168a91.22.1723555173108; 
 Tue, 13 Aug 2024 06:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0c9uJifaFp8hNo4C3wSaxswEymIHCDyxotm9VaTchq3f+85aRKmtruF1S5NdS49B3qVVsQA==
X-Received: by 2002:a17:90b:4b0a:b0:2c9:984d:958d with SMTP id
 98e67ed59e1d1-2d392539a18mr4093150a91.22.1723555172698; 
 Tue, 13 Aug 2024 06:19:32 -0700 (PDT)
Received: from gram.. ([189.5.22.75]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fcea97d7sm7343011a91.18.2024.08.13.06.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:19:32 -0700 (PDT)
From: Tiago Pasqualini <tiago.pasqualini@canonical.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH] crypto: run qcrypto_pbkdf2_count_iters in a new thread
Date: Tue, 13 Aug 2024 10:19:28 -0300
Message-ID: <20240813131928.842265-1-tiago.pasqualini@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=tiago.pasqualini@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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
 crypto/pbkdf.c         | 42 +++++++++++++++++++++++++++++++++++-------
 include/crypto/pbkdf.h | 10 ++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
index 8d198c152c..4c4e1e3cd3 100644
--- a/crypto/pbkdf.c
+++ b/crypto/pbkdf.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/thread.h"
 #include "qapi/error.h"
 #include "crypto/pbkdf.h"
 #ifndef _WIN32
@@ -85,12 +86,17 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned long long *val_ms,
 #endif
 }
 
-uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
-                                    const uint8_t *key, size_t nkey,
-                                    const uint8_t *salt, size_t nsalt,
-                                    size_t nout,
-                                    Error **errp)
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
@@ -114,7 +120,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
         delta_ms = end_ms - start_ms;
 
-        if (delta_ms > 500) {
+        if (delta_ms == 0) { /* sanity check */
+            error_setg(errp, "Unable to get accurate CPU usage");
+            goto cleanup;
+        } else if (delta_ms > 500) {
             break;
         } else if (delta_ms < 100) {
             iterations = iterations * 10;
@@ -129,5 +138,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
 
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
+        hash, key, nkey, salt, nsalt, nout, errp
+    };
+    QemuThread thread;
+
+    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_iters,
+                       &data, QEMU_THREAD_JOINABLE);
+    qemu_thread_join(&thread);
+
+    return data.iterations;
 }
diff --git a/include/crypto/pbkdf.h b/include/crypto/pbkdf.h
index 2c31a44a27..b3757003e4 100644
--- a/include/crypto/pbkdf.h
+++ b/include/crypto/pbkdf.h
@@ -153,4 +153,14 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
                                     size_t nout,
                                     Error **errp);
 
+typedef struct CountItersData {
+    QCryptoHashAlgorithm hash;
+    const uint8_t *key;
+    size_t nkey;
+    const uint8_t *salt;
+    size_t nsalt;
+    size_t nout;
+    Error **errp;
+    uint64_t iterations;
+} CountItersData;
 #endif /* QCRYPTO_PBKDF_H */
-- 
2.43.0


