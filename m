Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D986BC531DC
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scpDk-0004u9-C9; Sat, 10 Aug 2024 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDj-0004tT-06
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:35 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDg-0003m2-80
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:34 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d9e13ef8edso2237415b6e.2
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723308330; x=1723913130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=po1864G9kxPIA1SrB2pXf4Sek2hkmspEAs0nvNAI8ZI=;
 b=fpwhHfiRDGzYODmmkdRrfnlmSbB3qY3HJ7Auu+BxNpY5WMwQG34ifILAQYXkvaKiN9
 cEYTLFlHdpUfbv+BvWcaTmdWU61BYk8Sa3uyNYnSH2jsQF+GsWkcu73Q9xKo0vyxLAQp
 U9Vo6wnsFRvTOk37JrgRgO6Su6fJYK4piNPA048jwXa6EmYWoIMHah2WPhzPv/vXk4FW
 kt3jeT1qZzOTLf3DW+/p1Y2TCRLagMYixwxsK/fFlhmzqFW2LwriMdCTHKO2I6k9Jd35
 JPWE+JAcVQfGUy9p/z+Xyo3oIvLjqYlhTJ8KPUHUx8DnPDLWvP84GrIWm5XMkPVMIhHB
 mbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723308330; x=1723913130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=po1864G9kxPIA1SrB2pXf4Sek2hkmspEAs0nvNAI8ZI=;
 b=vWjOzDZDrPivo2LndztADOMW2O3pYpfnV5IYOEcq2TFBv/4vm2lTSa6RRJtFaHPhGI
 lv2Tf8nDKBYBGVTGje5+lonSbF2u1iUtZrpD4vn4qV5yUNWIAmYzGes6VHoURYU74vkt
 uwDrOefo+gew7NSODzY1xv+hBsqIbum8ZKqekKgzeDU+KVQ1qbQyG4Gw5GZy1N9UXkCS
 eArJTcx2ona5oUGuL61cVGMdQYtMUOiT3NPTFWzgFurDVoR4Wj739twj8898H2b6jlf8
 W+LFxlF4XuwfGFWTNajtXJIPyNVPw4Yro+Usqhr5gJ9Z8ngch78K8eEVuRyjlCg3Pdfl
 Lx/g==
X-Gm-Message-State: AOJu0Yz2VkVMZKns9XR3LJQkAa9bU/RHxiKkvdlxUTj0JCIO4UnKHh+9
 PPox0uLaQn54mqMVioHSQu6eTqu3dh94KxZNnavySDXlyAqgRNQQvjVTkIEW
X-Google-Smtp-Source: AGHT+IHmJxD4jt9iTwfzD8rkevSYchcJ7oCY1wImU9aeBeBRQA4jniG3tWdnQGkeEALAhQXujWCl6w==
X-Received: by 2002:a05:6808:2019:b0:3d9:2986:5a3b with SMTP id
 5614622812f47-3dc416da611mr6678963b6e.37.1723308330459; 
 Sat, 10 Aug 2024 09:45:30 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58735e2sm1424397b3a.30.2024.08.10.09.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 09:45:30 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Date: Sat, 10 Aug 2024 22:45:01 +0600
Message-Id: <20240810164502.19693-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240810164502.19693-1-dorjoychy111@gmail.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A new optional nitro-enclave machine option 'id' has been added which will
be the enclave identifier reflected in the module-id of the NSM device.
Otherwise, the device will have a default id set.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 hw/core/eif.c                   | 205 +++++++++++++++++++++++++++++++-
 hw/core/eif.h                   |   5 +-
 hw/core/meson.build             |   4 +-
 hw/i386/Kconfig                 |   1 +
 hw/i386/nitro_enclave.c         |  85 ++++++++++++-
 include/hw/i386/nitro_enclave.h |  19 +++
 6 files changed, 310 insertions(+), 9 deletions(-)

diff --git a/hw/core/eif.c b/hw/core/eif.c
index 5558879a96..d2c65668ef 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -12,6 +12,9 @@
 #include "qemu/bswap.h"
 #include "qapi/error.h"
 #include <zlib.h> /* for crc32 */
+#include <cbor.h>
+#include <gnutls/gnutls.h>
+#include <gnutls/x509.h>
 
 #include "hw/core/eif.h"
 
@@ -180,6 +183,8 @@ static void safe_unlink(char *f)
  * Upon success, the caller is reponsible for unlinking and freeing *kernel_path
  */
 static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
+                            GChecksum *image_hasher,
+                            GChecksum *bootstrap_hasher,
                             uint32_t *crc, Error **errp)
 {
     size_t got;
@@ -213,6 +218,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     }
 
     *crc = crc32(*crc, kernel, size);
+    g_checksum_update(image_hasher, kernel, size);
+    g_checksum_update(bootstrap_hasher, kernel, size);
     g_free(kernel);
     fclose(tmp_file);
 
@@ -230,6 +237,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
 }
 
 static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
+                             GChecksum *image_hasher,
+                             GChecksum *bootstrap_hasher,
                              uint32_t *crc, Error **errp)
 {
     size_t got = fread(cmdline, 1, size, f);
@@ -239,10 +248,14 @@ static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
     }
 
     *crc = crc32(*crc, (uint8_t *)cmdline, size);
+    g_checksum_update(image_hasher, (uint8_t *)cmdline, size);
+    g_checksum_update(bootstrap_hasher, (uint8_t *)cmdline, size);
     return true;
 }
 
 static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
+                             GChecksum *image_hasher,
+                             GChecksum *bootstrap_or_app_hasher,
                              uint32_t *crc, Error **errp)
 {
     size_t got;
@@ -261,6 +274,8 @@ static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
     }
 
     *crc = crc32(*crc, ramdisk, size);
+    g_checksum_update(image_hasher, ramdisk, size);
+    g_checksum_update(bootstrap_or_app_hasher, ramdisk, size);
     g_free(ramdisk);
     return true;
 
@@ -269,6 +284,125 @@ static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
     return false;
 }
 
+static bool get_fingerprint_sha384_from_cert(uint8_t *cert, size_t size,
+                                             uint8_t *sha384, Error **errp)
+{
+    gnutls_x509_crt_t crt;
+    size_t hash_size = 48;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    gnutls_global_init();
+    gnutls_x509_crt_init(&crt);
+
+    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_fingerprint(crt, GNUTLS_DIG_SHA384, sha384,
+                                        &hash_size) != 0) {
+        error_setg(errp, "Failed to compute SHA384 fingerprint");
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    gnutls_x509_crt_deinit(crt);
+    gnutls_global_deinit();
+    return false;
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
+    if (!get_fingerprint_sha384_from_cert(cert, len, sha384, errp)) {
+        goto cleanup;
+    }
+
+    return true;
+
+ cleanup:
+    g_free(sig);
+    g_free(cert);
+    if (pcr0) {
+        cbor_decref(&pcr0);
+    }
+    if (item) {
+        cbor_decref(&item);
+    }
+    return false;
+}
+
 /* Expects file to have offset 0 before this function is called */
 static long get_file_size(FILE *f, Error **errp)
 {
@@ -299,7 +433,9 @@ static long get_file_size(FILE *f, Error **errp)
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
@@ -308,9 +444,33 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
     uint32_t crc = 0;
     EifHeader eif_header;
     bool seen_sections[EIF_SECTION_MAX] = {false};
-
+    /* kernel + ramdisks + cmdline sha384 hash */
+    GChecksum *image_hasher = NULL;
+    /* kernel + boot ramdisk + cmdline sha384 hash */
+    GChecksum *bootstrap_hasher = NULL;
+    /* application ramdisk(s) hash */
+    GChecksum *app_hasher = NULL;
+    size_t digest_len;
+
+    *signature_found = false;
     *kernel_path = *initrd_path = *cmdline = NULL;
 
+    image_hasher = g_checksum_new(G_CHECKSUM_SHA384);
+    if (image_hasher == NULL) {
+        error_setg(errp, "Failed to initialize sha384 hash for image");
+        goto cleanup;
+    }
+    bootstrap_hasher = g_checksum_new(G_CHECKSUM_SHA384);
+    if (bootstrap_hasher == NULL) {
+        error_setg(errp, "Failed to initialize sha384 hash for bootstrap");
+        goto cleanup;
+    }
+    app_hasher = g_checksum_new(G_CHECKSUM_SHA384);
+    if (app_hasher == NULL) {
+        error_setg(errp, "Failed to initialize sha384 hash for app");
+        goto cleanup;
+    }
+
     f = fopen(eif_path, "rb");
     if (f == NULL) {
         error_setg_errno(errp, errno, "Failed to open %s", eif_path);
@@ -374,7 +534,7 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
             if (!read_eif_kernel(f, section_header.section_size, kernel_path,
-                                 &crc, errp)) {
+                                 image_hasher, bootstrap_hasher, &crc, errp)) {
                 goto cleanup;
             }
 
@@ -389,7 +549,8 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             }
             size = section_header.section_size;
             *cmdline = g_malloc(size + 1);
-            if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
+            if (!read_eif_cmdline(f, size, *cmdline, image_hasher,
+                                  bootstrap_hasher, &crc, errp)) {
                 goto cleanup;
             }
             (*cmdline)[size] = '\0';
@@ -398,7 +559,13 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         }
         case EIF_SECTION_RAMDISK:
         {
+            /*
+             * If it's the first ramdisk, we need to hash it into bootstrap,
+             * otherwise we need to hash it into app.
+             */
+            GChecksum *hasher = app_hasher;
             if (!seen_sections[EIF_SECTION_RAMDISK]) {
+                hasher = bootstrap_hasher;
                 /*
                  * If this is the first time we are seeing a ramdisk section,
                  * we need to create the initrd temporary file.
@@ -415,12 +582,21 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             }
 
             if (!read_eif_ramdisk(f, initrd_path_f, section_header.section_size,
-                                  &crc, errp)) {
+                                  image_hasher, hasher, &crc, errp)) {
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
@@ -484,17 +660,34 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         }
 
         if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
-                              machine_initrd_size, &crc, errp)) {
+                              machine_initrd_size, image_hasher, app_hasher,
+                              &crc, errp)) {
             goto cleanup;
         }
     }
 
+    digest_len = 48;
+    g_checksum_get_digest(image_hasher, image_sha384, &digest_len);
+    g_checksum_free(image_hasher);
+
+    digest_len = 48;
+    g_checksum_get_digest(bootstrap_hasher, bootstrap_sha384, &digest_len);
+    g_checksum_free(bootstrap_hasher);
+
+    digest_len = 48;
+    g_checksum_get_digest(app_hasher, app_sha384, &digest_len);
+    g_checksum_free(app_hasher);
+
     fclose(f);
     fclose(initrd_path_f);
     safe_fclose(machine_initrd_f);
     return true;
 
  cleanup:
+    g_checksum_free(image_hasher);
+    g_checksum_free(bootstrap_hasher);
+    g_checksum_free(app_hasher);
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
index f32d1ad943..7e7a14ee00 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -12,6 +12,8 @@ hwcore_ss.add(files(
   'qdev-clock.c',
 ))
 
+libcbor = dependency('libcbor', version: '>=0.8.0')
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
index 280ab4cc9b..b34e8399ee 100644
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
@@ -87,10 +106,46 @@ static void nitro_enclave_machine_state_init(MachineState *machine)
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
@@ -103,9 +158,13 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
     Error *err;
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
@@ -176,6 +235,22 @@ static void nitro_enclave_set_vsock_chardev_id(Object *obj, const char *value,
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
 static void nitro_enclave_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -190,6 +265,9 @@ static void nitro_enclave_class_init(ObjectClass *oc, void *data)
     nemc->parent_init = mc->init;
     mc->init = nitro_enclave_machine_state_init;
 
+    nemc->parent_reset = mc->reset;
+    mc->reset = nitro_enclave_machine_reset;
+
     mc->create_default_memdev = create_memfd_backend;
 
     object_class_property_add_str(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
@@ -198,6 +276,11 @@ static void nitro_enclave_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
                                           "Set chardev id for vhost-user-vsock "
                                           "device");
+
+    object_class_property_add_str(oc, NITRO_ENCLAVE_ID, nitro_enclave_get_id,
+                                  nitro_enclave_set_id);
+    object_class_property_set_description(oc, NITRO_ENCLAVE_ID,
+                                          "Set enclave identifier");
 }
 
 static const TypeInfo nitro_enclave_machine_info = {
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
index 3e302de851..1a95191d76 100644
--- a/include/hw/i386/nitro_enclave.h
+++ b/include/hw/i386/nitro_enclave.h
@@ -13,14 +13,19 @@
 
 #include "hw/i386/microvm.h"
 #include "qom/object.h"
+#include "hw/virtio/virtio-nsm.h"
+
+#define SHA384_BYTE_LEN 48
 
 /* Machine type options */
 #define NITRO_ENCLAVE_VSOCK_CHARDEV_ID "vsock"
+#define NITRO_ENCLAVE_ID    "id"
 
 struct NitroEnclaveMachineClass {
     MicrovmMachineClass parent;
 
     void (*parent_init)(MachineState *state);
+    void (*parent_reset)(MachineState *machine, ShutdownCause reason);
 };
 
 struct NitroEnclaveMachineState {
@@ -28,6 +33,20 @@ struct NitroEnclaveMachineState {
 
     /* Machine type options */
     char *vsock;
+    char *id;
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


