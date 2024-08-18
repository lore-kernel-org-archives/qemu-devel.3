Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0837EC5321D
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeJo-0003Fv-Sv; Sun, 18 Aug 2024 07:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJm-0003Dk-Tb
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:30 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJj-0001as-RV
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:30 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e04196b7603so3794178276.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981406; x=1724586206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmaEaG5bthqsqLtM+Z+qXwtKYvpCfjXjg+k+g9NCttk=;
 b=I/8CSY4xwPbL4YNP9hCCcbqU/7zFtYL6OGJqskZ60SwzQyc6zXY7qvVMSu6XPah6Bn
 VxkkIWmwrSKq0qD7PA2QsY+9S1TFO6B5Gid8yjaZzMQuxnM8i6pg4sixBsZsHF3Bquk6
 vIaVmP72Q1gRMu1cSvSHWXAZUk+eIx1THI9PMd9j1wjaxz+zXUvRdPxV7iO8y6exs1r5
 Hw+yGBI+lvLAtZaz12+LTjtB+0VulMqh6sDXGkJCAWgvsOMMee1N/4+jhkhK7kAQUoUM
 3PhXpKohKynmu0EBn+Wkq7NAq4amqiW7Zh8mjUCTfoW3+LPZ3ySQaA+6IeqoiOkmRG2V
 f7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981406; x=1724586206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmaEaG5bthqsqLtM+Z+qXwtKYvpCfjXjg+k+g9NCttk=;
 b=p9Nz8pusGwAzfzk1KHV/cCZB2vcYYUuPG/+X/KstlwUrF585GueE/S8Ol0V+ziWoae
 9ZzHiVh0y+fLF11EykRud7ZB70VDP/mPZ56RvP1Sh25NUOP7LNnGketjTWEaIERLVfh9
 rRDwUZlajrdrk+tkIiVJSrjCtRdWxLaHDt4SiNsXC9XqsMFAk5aACqklLq9Q9z25pYzv
 72p4oz04r+OtbGpYK4GIU2Cw1oatPfpjWRMVZjRBPmeUkdNRsyRZSNUogJS9Pg8bzkOK
 zoG8zdqbCwHZd2ETvbgZRBPAFdUHcyenX9BrpAeYbuL67Nf8QYZpnRZOTHLtoDKAta1w
 FHgA==
X-Gm-Message-State: AOJu0Ywj5Q4gmD3xkUQ+oHqAJFYFiOXrI8US6fYGkzJSHDGuZfAsBZ+E
 ejuhi+0+4dUmngtgcSA41aHAnH3M5if6qodI0jVOp4lYUwGO8kGE1T/bPw==
X-Google-Smtp-Source: AGHT+IGKy9WGhyM4qzYXPVQYdAGNeUf8v2do38Pmfx69L7MV9RoPpA5wulgYzJScx51CTwUhDH0qtg==
X-Received: by 2002:a05:6902:120c:b0:e16:26e0:fbb5 with SMTP id
 3f1490d57ef6-e1626e102fbmr774317276.44.1723981406131; 
 Sun, 18 Aug 2024 04:43:26 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm5303617a91.4.2024.08.18.04.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 04:43:25 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Date: Sun, 18 Aug 2024 17:42:55 +0600
Message-Id: <20240818114257.21456-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818114257.21456-1-dorjoychy111@gmail.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=dorjoychy111@gmail.com; helo=mail-yb1-xb31.google.com
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

AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
is used for stripped down TPM functionality like attestation. This commit
adds the built-in NSM device in the nitro-enclave machine type.

In Nitro Enclaves, all the PCRs start in a known zero state and the first
16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
contain the SHA384 hashes related to the EIF file used to boot the
VM for validation.

Some optional nitro-enclave machine options have been added:
    - 'id': Enclave identifier, reflected in the module-id of the NSM
device. If not provided, a default id will be set.
    - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
of the NSM device.
    - 'parent-id': Parent instance identifier, reflected in PCR4 of the
NSM device.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/meson.build              |   2 +-
 crypto/x509-utils.c             |  73 +++++++++++
 hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++---
 hw/core/eif.h                   |   5 +-
 hw/core/meson.build             |   4 +-
 hw/i386/Kconfig                 |   1 +
 hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
 include/crypto/x509-utils.h     |  22 ++++
 include/hw/i386/nitro_enclave.h |  26 ++++
 9 files changed, 479 insertions(+), 20 deletions(-)
 create mode 100644 crypto/x509-utils.c
 create mode 100644 include/crypto/x509-utils.h

diff --git a/crypto/meson.build b/crypto/meson.build
index c46f9c22a7..09633194ed 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -62,7 +62,7 @@ endif
 if gcrypt.found()
   util_ss.add(gcrypt, files('random-gcrypt.c'))
 elif gnutls.found()
-  util_ss.add(gnutls, files('random-gnutls.c'))
+  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c'))
 elif get_option('rng_none')
   util_ss.add(files('random-none.c'))
 else
diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
new file mode 100644
index 0000000000..2422eb995c
--- /dev/null
+++ b/crypto/x509-utils.c
@@ -0,0 +1,73 @@
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
+static int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
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
+                                      uint8_t **result,
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
+    gnutls_x509_crt_init(&crt);
+
+    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+    if (*resultlen == 0) {
+        *resultlen = ret;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen < ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, ret);
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_fingerprint(crt,
+                                        qcrypto_to_gnutls_hash_alg_map[alg],
+                                        *result, resultlen) != 0) {
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
diff --git a/hw/core/eif.c b/hw/core/eif.c
index 5558879a96..8e15142d36 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -11,7 +11,10 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "qapi/error.h"
+#include "crypto/hash.h"
+#include "crypto/x509-utils.h"
 #include <zlib.h> /* for crc32 */
+#include <cbor.h>
 
 #include "hw/core/eif.h"
 
@@ -180,11 +183,10 @@ static void safe_unlink(char *f)
  * Upon success, the caller is reponsible for unlinking and freeing *kernel_path
  */
 static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
-                            uint32_t *crc, Error **errp)
+                            uint8_t *kernel, uint32_t *crc, Error **errp)
 {
     size_t got;
     FILE *tmp_file = NULL;
-    uint8_t *kernel = NULL;
 
     *kernel_path = NULL;
     if (!get_tmp_file("eif-kernel-XXXXXX", kernel_path, errp)) {
@@ -198,7 +200,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
         goto cleanup;
     }
 
-    kernel = g_malloc(size);
     got = fread(kernel, 1, size, f);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to read EIF kernel section data");
@@ -213,7 +214,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     }
 
     *crc = crc32(*crc, kernel, size);
-    g_free(kernel);
     fclose(tmp_file);
 
     return true;
@@ -225,7 +225,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     g_free(*kernel_path);
     *kernel_path = NULL;
 
-    g_free(kernel);
     return false;
 }
 
@@ -243,29 +242,115 @@ static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
 }
 
 static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
-                             uint32_t *crc, Error **errp)
+                             uint8_t *ramdisk, uint32_t *crc, Error **errp)
 {
     size_t got;
-    uint8_t *ramdisk = g_malloc(size);
 
     got = fread(ramdisk, 1, size, eif);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to read EIF ramdisk section data");
-        goto cleanup;
+        return false;
     }
 
     got = fwrite(ramdisk, 1, size, initrd);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to write EIF ramdisk data to temporary file");
-        goto cleanup;
+        return false;
     }
 
     *crc = crc32(*crc, ramdisk, size);
-    g_free(ramdisk);
+    return true;
+}
+
+static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
+                                             uint8_t *sha384,
+                                             uint32_t *crc,
+                                             Error **errp)
+{
+    size_t got;
+    uint8_t *sig = NULL;
+    uint8_t *cert = NULL;
+    cbor_item_t *item = NULL;
+    cbor_item_t *pcr0 = NULL;
+    size_t len;
+    size_t hash_len = 48;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+
+    sig = g_malloc(size);
+    got = fread(sig, 1, size, eif);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to read EIF signature section data");
+        goto cleanup;
+    }
+
+    *crc = crc32(*crc, sig, size);
+
+    item = cbor_load(sig, size, &result);
+    if (!item || result.error.code != CBOR_ERR_NONE) {
+        error_setg(errp, "Failed to load signature section data as CBOR");
+        goto cleanup;
+    }
+    if (!cbor_isa_array(item) || cbor_array_size(item) < 1) {
+        error_setg(errp, "Invalid signature CBOR");
+        goto cleanup;
+    }
+    pcr0 = cbor_array_get(item, 0);
+    if (!pcr0) {
+        error_setg(errp, "Failed to get PCR0 signature");
+        goto cleanup;
+    }
+    if (!cbor_isa_map(pcr0) || cbor_map_size(pcr0) != 2) {
+        error_setg(errp, "Invalid signature CBOR");
+        goto cleanup;
+    }
+    pair = cbor_map_handle(pcr0);
+    if (!cbor_isa_string(pair->key) || cbor_string_length(pair->key) != 19 ||
+        memcmp(cbor_string_handle(pair->key), "signing_certificate", 19) != 0) {
+        error_setg(errp, "Invalid signautre CBOR");
+        goto cleanup;
+    }
+    if (!cbor_isa_array(pair->value)) {
+        error_setg(errp, "Invalid signature CBOR");
+        goto cleanup;
+    }
+    len = cbor_array_size(pair->value);
+    if (len == 0) {
+        error_setg(errp, "Invalid signature CBOR");
+        goto cleanup;
+    }
+    cert = g_malloc(len);
+    for (int i = 0; i < len; ++i) {
+        cbor_item_t *tmp = cbor_array_get(pair->value, i);
+        if (!tmp) {
+            error_setg(errp, "Invalid signature CBOR");
+            goto cleanup;
+        }
+        if (!cbor_isa_uint(tmp) || cbor_int_get_width(tmp) != CBOR_INT_8) {
+            cbor_decref(&tmp);
+            error_setg(errp, "Invalid signature CBOR");
+            goto cleanup;
+        }
+        cert[i] = cbor_get_uint8(tmp);
+        cbor_decref(&tmp);
+    }
+
+    if (qcrypto_get_x509_cert_fingerprint(cert, len, QCRYPTO_HASH_ALG_SHA384,
+                                          &sha384, &hash_len, errp)) {
+        goto cleanup;
+    }
+
     return true;
 
  cleanup:
-    g_free(ramdisk);
+    g_free(sig);
+    g_free(cert);
+    if (pcr0) {
+        cbor_decref(&pcr0);
+    }
+    if (item) {
+        cbor_decref(&item);
+    }
     return false;
 }
 
@@ -299,7 +384,9 @@ static long get_file_size(FILE *f, Error **errp)
  */
 bool read_eif_file(const char *eif_path, const char *machine_initrd,
                    char **kernel_path, char **initrd_path, char **cmdline,
-                   Error **errp)
+                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
+                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
+                   bool *signature_found, Error **errp)
 {
     FILE *f = NULL;
     FILE *machine_initrd_f = NULL;
@@ -308,7 +395,19 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
     uint32_t crc = 0;
     EifHeader eif_header;
     bool seen_sections[EIF_SECTION_MAX] = {false};
-
+    /* kernel + ramdisks + cmdline sha384 hash */
+    struct iovec image_hash_iovecs[MAX_SECTIONS + 1];
+    int image_hash_iovec_cnt = 0;
+    /* kernel + boot ramdisk + cmdline sha384 hash */
+    struct iovec bootstrap_hash_iovecs[3];
+    int bootstrap_hash_iovec_cnt = 0;
+    /* application ramdisk(s) hash */
+    struct iovec app_hash_iovecs[MAX_SECTIONS + 1];
+    int app_hash_iovec_cnt = 0;
+    uint8_t *ptr = NULL;
+    size_t digest_len;
+
+    *signature_found = false;
     *kernel_path = *initrd_path = *cmdline = NULL;
 
     f = fopen(eif_path, "rb");
@@ -373,8 +472,18 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                            "section");
                 goto cleanup;
             }
+
+            ptr = g_malloc(section_header.section_size);
+
+            image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
+            image_hash_iovecs[image_hash_iovec_cnt++].iov_len =
+                section_header.section_size;
+            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base = ptr;
+            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len =
+                section_header.section_size;
+
             if (!read_eif_kernel(f, section_header.section_size, kernel_path,
-                                 &crc, errp)) {
+                                 ptr, &crc, errp)) {
                 goto cleanup;
             }
 
@@ -382,6 +491,7 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         case EIF_SECTION_CMDLINE:
         {
             uint64_t size;
+            uint8_t *cmdline_copy;
             if (seen_sections[EIF_SECTION_CMDLINE]) {
                 error_setg(errp, "Invalid EIF image. More than 1 cmdline "
                            "section");
@@ -394,6 +504,19 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             }
             (*cmdline)[size] = '\0';
 
+            /*
+             * We make a copy of '*cmdline' for putting it in iovecs so that
+             * we can easily free all the iovec entries later as we cannot
+             * free '*cmdline' which is used by the caller.
+             */
+            cmdline_copy = g_malloc(size);
+            memcpy(cmdline_copy, *cmdline, size);
+            image_hash_iovecs[image_hash_iovec_cnt].iov_base = cmdline_copy;
+            image_hash_iovecs[image_hash_iovec_cnt++].iov_len = size;
+            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base =
+                cmdline_copy;
+            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len = size;
+
             break;
         }
         case EIF_SECTION_RAMDISK:
@@ -414,13 +537,41 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 }
             }
 
+            ptr = g_malloc(section_header.section_size);
+
+            image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
+            image_hash_iovecs[image_hash_iovec_cnt++].iov_len =
+                section_header.section_size;
+            /*
+             * If it's the first ramdisk, we need to hash it into bootstrap,
+             * otherwise we need to hash it into app.
+             */
+            if (!seen_sections[EIF_SECTION_RAMDISK]) {
+                bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base = ptr;
+                bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len =
+                    section_header.section_size;
+            } else {
+                app_hash_iovecs[app_hash_iovec_cnt].iov_base = ptr;
+                app_hash_iovecs[app_hash_iovec_cnt++].iov_len =
+                    section_header.section_size;
+            }
+
             if (!read_eif_ramdisk(f, initrd_path_f, section_header.section_size,
-                                  &crc, errp)) {
+                                  ptr, &crc, errp)) {
                 goto cleanup;
             }
 
             break;
         }
+        case EIF_SECTION_SIGNATURE:
+            *signature_found = true;
+            if (!get_signature_fingerprint_sha384(f,
+                                                  section_header.section_size,
+                                                  fingerprint_sha384, &crc,
+                                                  errp)) {
+                goto cleanup;
+            }
+            break;
         default:
             /* other sections including invalid or unknown sections */
         {
@@ -483,18 +634,60 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             goto cleanup;
         }
 
+        ptr = g_malloc(machine_initrd_size);
+
+        image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
+        image_hash_iovecs[image_hash_iovec_cnt++].iov_len = machine_initrd_size;
+        app_hash_iovecs[app_hash_iovec_cnt].iov_base = ptr;
+        app_hash_iovecs[app_hash_iovec_cnt++].iov_len = machine_initrd_size;
+
         if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
-                              machine_initrd_size, &crc, errp)) {
+                              machine_initrd_size, ptr, &crc, errp)) {
             goto cleanup;
         }
     }
 
+    digest_len = 48;
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, image_hash_iovecs,
+                            image_hash_iovec_cnt, &image_sha384, &digest_len,
+                            errp) < 0) {
+        goto cleanup;
+
+    }
+
+    digest_len = 48;
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, bootstrap_hash_iovecs,
+                            bootstrap_hash_iovec_cnt, &bootstrap_sha384,
+                            &digest_len, errp) < 0) {
+        goto cleanup;
+
+    }
+
+    digest_len = 48;
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, app_hash_iovecs,
+                            app_hash_iovec_cnt, &app_sha384, &digest_len,
+                            errp) < 0) {
+        goto cleanup;
+
+    }
+
+    /*
+     * We only need to free image_hash_iovec entries because bootstrap and
+     * app iovec entries are subsets of image_hash_iovec entries.
+     */
+    for (int i = 0; i < image_hash_iovec_cnt; ++i) {
+        g_free(image_hash_iovecs[i].iov_base);
+    }
     fclose(f);
     fclose(initrd_path_f);
     safe_fclose(machine_initrd_f);
     return true;
 
  cleanup:
+    for (int i = 0; i < image_hash_iovec_cnt; ++i) {
+        g_free(image_hash_iovecs[i].iov_base);
+    }
+
     safe_fclose(f);
     safe_fclose(initrd_path_f);
     safe_fclose(machine_initrd_f);
diff --git a/hw/core/eif.h b/hw/core/eif.h
index 7063974d93..fed3cb5514 100644
--- a/hw/core/eif.h
+++ b/hw/core/eif.h
@@ -13,7 +13,10 @@
 
 bool read_eif_file(const char *eif_path, const char *machine_initrd,
                    char **kernel_path, char **initrd_path,
-                   char **kernel_cmdline, Error **errp);
+                   char **kernel_cmdline, uint8_t *image_sha384,
+                   uint8_t *bootstrap_sha384, uint8_t *app_sha384,
+                   uint8_t *fingerprint_sha384, bool *signature_found,
+                   Error **errp);
 
 #endif
 
diff --git a/hw/core/meson.build b/hw/core/meson.build
index f32d1ad943..8dc4552e35 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -12,6 +12,8 @@ hwcore_ss.add(files(
   'qdev-clock.c',
 ))
 
+libcbor = dependency('libcbor', version: '>=0.7.0')
+
 common_ss.add(files('cpu-common.c'))
 common_ss.add(files('machine-smp.c'))
 system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
@@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
-system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib])
+system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
 system_ss.add(files(
   'cpu-sysemu.c',
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 821532c4c8..63271bf915 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -133,6 +133,7 @@ config NITRO_ENCLAVE
     default y
     depends on MICROVM
     select VHOST_USER_VSOCK
+    select VIRTIO_NSM
 
 config X86_IOMMU
     bool
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 4f4da9dfc3..2e35cc58fc 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -20,6 +20,7 @@
 #include "hw/i386/microvm.h"
 #include "hw/i386/nitro_enclave.h"
 #include "hw/virtio/virtio-mmio.h"
+#include "hw/virtio/virtio-nsm.h"
 #include "hw/virtio/vhost-user-vsock.h"
 #include "sysemu/hostmem.h"
 
@@ -72,9 +73,27 @@ static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
     qdev_realize_and_unref(dev, bus, &error_fatal);
 }
 
+static void virtio_nsm_init(NitroEnclaveMachineState *nems)
+{
+    DeviceState *dev = qdev_new(TYPE_VIRTIO_NSM);
+    VirtIONSM *vnsm = VIRTIO_NSM(dev);
+    BusState *bus = find_free_virtio_mmio_bus();
+
+    if (!bus) {
+        error_report("Failed to find bus for virtio-nsm device.");
+        exit(1);
+    }
+
+    qdev_prop_set_string(dev, "module-id", nems->id);
+
+    qdev_realize_and_unref(dev, bus, &error_fatal);
+    nems->vnsm = vnsm;
+}
+
 static void nitro_enclave_devices_init(NitroEnclaveMachineState *nems)
 {
     vhost_user_vsock_init(nems);
+    virtio_nsm_init(nems);
 }
 
 static void nitro_enclave_machine_state_init(MachineState *machine)
@@ -87,10 +106,58 @@ static void nitro_enclave_machine_state_init(MachineState *machine)
     nitro_enclave_devices_init(ne_state);
 }
 
+static void nitro_enclave_machine_reset(MachineState *machine,
+                                        ShutdownCause reason)
+{
+    NitroEnclaveMachineClass *ne_class =
+        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
+    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
+
+    ne_class->parent_reset(machine, reason);
+
+    memset(ne_state->vnsm->pcrs, 0, sizeof(ne_state->vnsm->pcrs));
+
+    /* PCR0 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 0, ne_state->image_sha384,
+                               SHA384_BYTE_LEN);
+    /* PCR1 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 1, ne_state->bootstrap_sha384,
+                               SHA384_BYTE_LEN);
+    /* PCR2 */
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 2, ne_state->app_sha384,
+                               SHA384_BYTE_LEN);
+    /* PCR3 */
+    if (ne_state->parent_role) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 3,
+                                   (uint8_t *) ne_state->parent_role,
+                                   strlen(ne_state->parent_role));
+    }
+    /* PCR4 */
+    if (ne_state->parent_id) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 4,
+                                   (uint8_t *) ne_state->parent_id,
+                                   strlen(ne_state->parent_id));
+    }
+    /* PCR8 */
+    if (ne_state->signature_found) {
+        ne_state->vnsm->extend_pcr(ne_state->vnsm, 8,
+                                   ne_state->fingerprint_sha384,
+                                   SHA384_BYTE_LEN);
+    }
+
+    /* First 16 PCRs are locked from boot and reserved for nitro enclave */
+    for (int i = 0; i < 16; ++i) {
+        ne_state->vnsm->lock_pcr(ne_state->vnsm, i);
+    }
+}
+
 static void nitro_enclave_machine_initfn(Object *obj)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
     X86MachineState *x86ms = X86_MACHINE(obj);
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    nems->id = g_strdup("i-234-enc5678");
 
     /* AWS nitro enclaves have PCIE and ACPI disabled */
     mms->pcie = ON_OFF_AUTO_OFF;
@@ -103,9 +170,13 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
     Error *err = NULL;
     char *eif_kernel, *eif_initrd, *eif_cmdline;
     MachineState *machine = MACHINE(x86ms);
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(x86ms);
 
     if (!read_eif_file(machine->kernel_filename, machine->initrd_filename,
-                       &eif_kernel, &eif_initrd, &eif_cmdline, &err)) {
+                       &eif_kernel, &eif_initrd, &eif_cmdline,
+                       nems->image_sha384, nems->bootstrap_sha384,
+                       nems->app_sha384, nems->fingerprint_sha384,
+                       &(nems->signature_found), &err)) {
         error_report_err(err);
         exit(1);
     }
@@ -176,6 +247,54 @@ static void nitro_enclave_set_vsock_chardev_id(Object *obj, const char *value,
     nems->vsock = g_strdup(value);
 }
 
+static char *nitro_enclave_get_id(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->id);
+}
+
+static void nitro_enclave_set_id(Object *obj, const char *value,
+                                            Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->id);
+    nems->id = g_strdup(value);
+}
+
+static char *nitro_enclave_get_parent_role(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->parent_role);
+}
+
+static void nitro_enclave_set_parent_role(Object *obj, const char *value,
+                                          Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->parent_role);
+    nems->parent_role = g_strdup(value);
+}
+
+static char *nitro_enclave_get_parent_id(Object *obj, Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    return g_strdup(nems->parent_id);
+}
+
+static void nitro_enclave_set_parent_id(Object *obj, const char *value,
+                                        Error **errp)
+{
+    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
+
+    g_free(nems->parent_id);
+    nems->parent_id = g_strdup(value);
+}
+
 static void nitro_enclave_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -190,6 +309,9 @@ static void nitro_enclave_class_init(ObjectClass *oc, void *data)
     nemc->parent_init = mc->init;
     mc->init = nitro_enclave_machine_state_init;
 
+    nemc->parent_reset = mc->reset;
+    mc->reset = nitro_enclave_machine_reset;
+
     mc->create_default_memdev = create_memfd_backend;
 
     object_class_property_add_str(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
@@ -198,6 +320,23 @@ static void nitro_enclave_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
                                           "Set chardev id for vhost-user-vsock "
                                           "device");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_ID, nitro_enclave_get_id,
+                                  nitro_enclave_set_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_ID,
+                                          "Set enclave identifier");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_PARENT_ROLE,
+                                  nitro_enclave_get_parent_role,
+                                  nitro_enclave_set_parent_role);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_PARENT_ROLE,
+                                          "Set parent instance IAM role ARN");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_PARENT_ID,
+                                  nitro_enclave_get_parent_id,
+                                  nitro_enclave_set_parent_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_PARENT_ID,
+                                          "Set parent instance identifier");
 }
 
 static const TypeInfo nitro_enclave_machine_info = {
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
new file mode 100644
index 0000000000..602a056764
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
+                                      uint8_t **result,
+                                      size_t *resultlen,
+                                      Error **errp);
+
+#endif
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
index 3e302de851..0b82a2a628 100644
--- a/include/hw/i386/nitro_enclave.h
+++ b/include/hw/i386/nitro_enclave.h
@@ -13,14 +13,21 @@
 
 #include "hw/i386/microvm.h"
 #include "qom/object.h"
+#include "hw/virtio/virtio-nsm.h"
+
+#define SHA384_BYTE_LEN 48
 
 /* Machine type options */
 #define NITRO_ENCLAVE_VSOCK_CHARDEV_ID "vsock"
+#define NITRO_ENCLAVE_ID    "id"
+#define NITRO_ENCLAVE_PARENT_ROLE "parent-role"
+#define NITRO_ENCLAVE_PARENT_ID "parent-id"
 
 struct NitroEnclaveMachineClass {
     MicrovmMachineClass parent;
 
     void (*parent_init)(MachineState *state);
+    void (*parent_reset)(MachineState *machine, ShutdownCause reason);
 };
 
 struct NitroEnclaveMachineState {
@@ -28,6 +35,25 @@ struct NitroEnclaveMachineState {
 
     /* Machine type options */
     char *vsock;
+    /* Enclave identifier */
+    char *id;
+    /* Parent instance IAM role ARN */
+    char *parent_role;
+    /* Parent instance identifier */
+    char *parent_id;
+
+    /* Machine state */
+    VirtIONSM *vnsm;
+
+    /* kernel + ramdisks + cmdline sha384 hash */
+    uint8_t image_sha384[SHA384_BYTE_LEN];
+    /* kernel + boot ramdisk + cmdline sha384 hash */
+    uint8_t bootstrap_sha384[SHA384_BYTE_LEN];
+    /* application ramdisk(s) hash */
+    uint8_t app_sha384[SHA384_BYTE_LEN];
+    /* certificate fingerprint hash */
+    uint8_t fingerprint_sha384[SHA384_BYTE_LEN];
+    bool signature_found;
 };
 
 #define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
-- 
2.39.2


