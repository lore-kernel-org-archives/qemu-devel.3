Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0268C531DF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9RV-0007lT-AD; Thu, 22 Aug 2024 11:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9RQ-0007dq-0z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:36 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9RI-00052O-H5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:09:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso1547410a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339367; x=1724944167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeAwo6rJ9Ssp7fNXqJixt1EPPvNs6AeUb8bCCXYa7xY=;
 b=hB8yH1v1XsMIB+frIz8vnQpASVGzCH3uSy4Laj3zgqx4PE7PUVvnvKyGC7Bw88tGcj
 gbNM6x1LUqbzeYx20oO+GeiQ1qyuodwWQiUFfInTon3NOnLEv/2bjHfNtguhj4w3o9/w
 Tb+E0xMdbcydWHQgxYYHsEvCoHSPXUek4/wDJWD8tRY85CqClKdrCyP5iUcbXX3qSXvl
 o5WkvKtMWJT5m8o4tBE5hdW/qIODTjL+N9H8iBF5dqIP+RUF6wMDbe5HPmbbQQoyUIPJ
 8Org8LkXVShYlnuQwZzJLlv23Rruqe5nBA9np5RIA427LF4AwlbcbQJrjfb8S5ANnuYP
 ulaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339367; x=1724944167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeAwo6rJ9Ssp7fNXqJixt1EPPvNs6AeUb8bCCXYa7xY=;
 b=eq5rhUMZTQPajDbZ9HZjH0O62jFCIWtya+jGgEi3tHIOlnm9rRrL6XLogCSHcTDqC2
 T4VYXg6GaoIZIE8aCBFL33f1AbSYqd3hUIqSojy6whYUlbDxu1ZPEST8pEbBclrvvBOI
 DzXKKTsoddlNONan0zE6ujeRq+fj8FSUvq/PxuCYIGmnJYgc96GUVixSLWzW/aG53nj2
 +YI9w6+ivnbEjyN433yBYfmPwSH69itBltGD8yKeIjHCKGKSfNmojKxLj72FVaCH7B/l
 uIJTLLWjCnlNKO7VjBxy8U7CxntCAZkhenmwNs3gXzv+a4mbavZIX2PL54gs7t7kM3/D
 L3Mw==
X-Gm-Message-State: AOJu0YykvI3R+eY2YdpTuaC7/mSEKqy7bouJ7tyurgB50mnwzjqVjRh8
 N9GiAjYUHLkZhXAOaAUPPd/FLHs1lWmqcjCci1EhGvysK6hDpvEATCP+yQ==
X-Google-Smtp-Source: AGHT+IHTPFPRE9v35Z52EqGf1ZXU39olEwYHZBhKEzYW9SlscFqfSPhB8wCeUIhlzUDUnCsjDUtNqA==
X-Received: by 2002:a17:90a:70c4:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2d60a747c55mr5165797a91.0.1724339366847; 
 Thu, 22 Aug 2024 08:09:26 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.175])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613919fd2sm1991567a91.13.2024.08.22.08.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:09:26 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v5 3/8] crypto: Introduce x509 utils
Date: Thu, 22 Aug 2024 21:08:44 +0600
Message-Id: <20240822150849.21759-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

An utility function for getting fingerprint from X.509 certificate
has been introduced. Implementation only provided using gnutls.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/meson.build          |  4 ++
 crypto/x509-utils.c         | 75 +++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h | 22 +++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 crypto/x509-utils.c
 create mode 100644 include/crypto/x509-utils.h

diff --git a/crypto/meson.build b/crypto/meson.build
index c46f9c22a7..735635de1f 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -24,6 +24,10 @@ crypto_ss.add(files(
   'rsakey.c',
 ))
 
+if gnutls.found()
+  crypto_ss.add(files('x509-utils.c'))
+endif
+
 if nettle.found()
   crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
   if hogweed.found()
diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
new file mode 100644
index 0000000000..593eb8968b
--- /dev/null
+++ b/crypto/x509-utils.c
@@ -0,0 +1,75 @@
+/*
+ * X.509 certificate related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/x509-utils.h"
+#include <gnutls/gnutls.h>
+#include <gnutls/crypto.h>
+#include <gnutls/x509.h>
+
+static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+    [QCRYPTO_HASH_ALG_MD5] = GNUTLS_DIG_MD5,
+    [QCRYPTO_HASH_ALG_SHA1] = GNUTLS_DIG_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224] = GNUTLS_DIG_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256] = GNUTLS_DIG_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384] = GNUTLS_DIG_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512] = GNUTLS_DIG_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = GNUTLS_DIG_RMD160,
+};
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgorithm alg,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    int ret;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
+        error_setg(errp, "Unknown hash algorithm");
+        return -1;
+    }
+
+    if (result == NULL) {
+        error_setg(errp, "No valid buffer given");
+        return -1;
+    }
+
+    gnutls_x509_crt_init(&crt);
+
+    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+    if (*resultlen < ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, ret);
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_fingerprint(crt,
+                                        qcrypto_to_gnutls_hash_alg_map[alg],
+                                        result, resultlen) != 0) {
+        error_setg(errp, "Failed to get fingerprint from certificate");
+        goto cleanup;
+    }
+
+    return 0;
+
+ cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return -1;
+}
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
new file mode 100644
index 0000000000..4210dfbcfc
--- /dev/null
+++ b/include/crypto/x509-utils.h
@@ -0,0 +1,22 @@
+/*
+ * X.509 certificate related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QCRYPTO_X509_UTILS_H
+#define QCRYPTO_X509_UTILS_H
+
+#include "crypto/hash.h"
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgorithm hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp);
+
+#endif
-- 
2.39.2


