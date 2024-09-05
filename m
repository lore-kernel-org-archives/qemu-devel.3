Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B85CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcK-0006aZ-0B; Thu, 05 Sep 2024 15:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcF-0006Gk-5y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcD-0005QX-Gb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2068acc8a4fso13378055ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566280; x=1726171080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeAwo6rJ9Ssp7fNXqJixt1EPPvNs6AeUb8bCCXYa7xY=;
 b=acchDRBzTJLX9tcu5FzPzczRpRgyjNkj9QJB1+W0z+RW2BHjJV/bVWzlmNpEpmCl09
 OWReFs42bB6isHHc9HNxJgplc62d+keUZYklCEbpFyYAVEVowUeJUmR4rtF964HkHMWh
 YkkU9zCqKevlxKNQ3hiFoSOfdH91lshZEvhDriqQ2BuK6fRJ68o5cKuZzWvjsQsaB3lp
 yLj9IWeddXW4jRM0Lu1ckzWKvGKAVXy5aNf1jiBHqoE1VLIngAUpxv2+uRPJJqgvAojY
 0p1DhKe/fsZm5PSvUkoxpt+c6xCF/CqKimJzYjTErY0dDm8ELEDbRDevvezYGOd5EfzU
 26DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566280; x=1726171080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeAwo6rJ9Ssp7fNXqJixt1EPPvNs6AeUb8bCCXYa7xY=;
 b=sYNxDVBOOTP8GlRV71O+N8LDx2MBw+LpFcvXNCJTvHSjqB/aJS3IYjBFV3sg9V2/TY
 Q598XlJu8gPWKjw2bFMLCuwkjjHcGxGTEWGmnxLC1dJAIBu06c8yiFNyqjWHabjIW4Ed
 Be/vhf4rcIT6Eu00bIgKP1dYcvKo841WjiFP5mG45idOEY1DHYjmXR8MSu32U1OdEqq3
 4BcVLirQ6gnJQgNOtb/VONQHH8IxmYWiOnRqgmkqByMlNP+LHYvUOi7LjXSN51RJMWK+
 KDoWVv9zV5PVn0i+CJzfZ+gXIIFZrADPNrpSEIt0I/Wae8vYwyn7i9PEHG4cOjvg3ncr
 wI8w==
X-Gm-Message-State: AOJu0YxJi+cjSq+tvLZHS4GzuSKkRuN76XJs6t1L/a/ZUroKwaTxnu9/
 3tmuFLYs3wwqqafjpqCRTWo7qyyPgPQ8lrXO772V6ibNZj04qByZ5dJk4A==
X-Google-Smtp-Source: AGHT+IGg0TfIFOSdLL4hFIcd0WGVIetWjVWBsEcowrYrwMNnTjiH+TKyHcB7CrJzD4BiI4UD0EnLpA==
X-Received: by 2002:a17:903:2285:b0:205:4e15:54c8 with SMTP id
 d9443c01a7336-2054e15577fmr203687775ad.61.1725566279731; 
 Thu, 05 Sep 2024 12:57:59 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.145])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea5554dsm32031355ad.235.2024.09.05.12.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:57:59 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v6 3/8] crypto: Introduce x509 utils
Date: Fri,  6 Sep 2024 01:57:30 +0600
Message-Id: <20240905195735.16911-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x636.google.com
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


