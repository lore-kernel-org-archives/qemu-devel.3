Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95193CF0428
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHad-0000y0-15; Tue, 08 Oct 2024 17:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHab-0000xO-0z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:53 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaX-0000Io-8p
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71df468496fso3434367b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422268; x=1729027068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24zRmHMMhcdSJx2V4bVQhsa1ucVSimwSzc0CPtF1cac=;
 b=ZX5ak0yFs6k7/BMT5J/mIGMCbttSHMt+mC0yKSbF+jep9A/g6ZvunZN1QMGpNXhnYg
 fosDGdCibT1FPeKJm/ndTS+y3KFJYz3mdIIRmIvISmC2jilRhbp2VI8oHUsx7pj3yoh7
 OPaGrD5Pxht2YVW0TeRciC/cn70kgIvQiAqkXxTeLhBKWpU0qCpCfixb//gHQvSJL5jr
 Nu4ZDJiOyDOPIq6tMDfYvxD5dvUmi3AIHZVP8HNYmxY9mzyNkKI5DWCn97fI15ELQYx/
 iiGCaa2wsL3vRYB4vlF1jzZ4eb13UmdzFLcdrX/1OyikU0Psn0HJyIea5+KB1McAjlD2
 Tzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422268; x=1729027068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24zRmHMMhcdSJx2V4bVQhsa1ucVSimwSzc0CPtF1cac=;
 b=osIf8jRmUQmI/wQa4KhI4+RnDn7vNcUn9P0An4X5Er7rXXxGNy6yv/vnazCvmTrB2k
 MyvRO0Za6+NKcp0uWet83y+FwZnSaXIMmm0bfGJlQ/3H/Tc9ftnZEZmBMI6l6ah0Ocm7
 oa7y67bnYD3MYDtRV6Npngs8DZo3sWSKqQXL+I/3d6ype6t85vBEkQvDIeeAz9EIJJwB
 4oQ7AS5EKfuZ5SwJfzCq/V1dKbq8NYSklJEqK+o8AkMI3SCTaCEkqGUPQPOPMT3WOu9S
 NfyM1RNxxhTqzr2ZON9kMrB2qy8wc0MSjBH7wbmVrtxkoTrsYJrQM2hqQSoq03r+2zDA
 ylPg==
X-Gm-Message-State: AOJu0YxnNRF4OGtnYoUQtQXLTydK0xap0bmr1Oa105CWIIe2bY/OdGg7
 j3te3nlTIdiWXnoH58HmxJXEJVgPOJ6PQzPcwScx37gsB87ADoz6dJKPIQ==
X-Google-Smtp-Source: AGHT+IHjmd2MOXScdk2L8Ky5VTQXeV0C1wNoi87fj8ovIuPYE5Q9QeUB/wt4wojixjzUfMIjAGlMEQ==
X-Received: by 2002:a05:6a21:3511:b0:1d6:c98f:fd44 with SMTP id
 adf61e73a8af0-1d8a3be06f8mr489024637.2.1728422267590; 
 Tue, 08 Oct 2024 14:17:47 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6254dsm6549078b3a.153.2024.10.08.14.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:17:47 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v8 3/6] hw/core: Add Enclave Image Format (EIF) related helpers
Date: Wed,  9 Oct 2024 03:17:24 +0600
Message-Id: <20241008211727.49088-4-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008211727.49088-1-dorjoychy111@gmail.com>
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x42b.google.com
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

An EIF (Enclave Image Format)[1] file is used to boot an AWS nitro
enclave[2] virtual machine. The EIF file contains the necessary kernel,
cmdline, ramdisk(s) sections to boot.

Some helper functions have been introduced for extracting the necessary
sections from an EIF file and then writing them to temporary files as
well as computing SHA384 hashes from the section data. These will be
used in the following commit to add support for nitro-enclave machine
type in QEMU.

The files added in this commit are not compiled yet but will be added
to the hw/core/meson.build file in the following commit where
CONFIG_NITRO_ENCLAVE will be introduced.

[1] https://github.com/aws/aws-nitro-enclaves-image-format
[2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS   |   7 +
 hw/core/eif.c | 719 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/core/eif.h |  22 ++
 3 files changed, 748 insertions(+)
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ca1cbc7118..54e985bc19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1819,6 +1819,13 @@ F: hw/i386/microvm.c
 F: include/hw/i386/microvm.h
 F: pc-bios/bios-microvm.bin
 
+nitro-enclave
+M: Alexander Graf <graf@amazon.com>
+M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
+S: Maintained
+F: hw/core/eif.c
+F: hw/core/eif.h
+
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
diff --git a/hw/core/eif.c b/hw/core/eif.c
new file mode 100644
index 0000000000..d737d7f23c
--- /dev/null
+++ b/hw/core/eif.c
@@ -0,0 +1,719 @@
+/*
+ * EIF (Enclave Image Format) related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qapi/error.h"
+#include "crypto/hash.h"
+#include "crypto/x509-utils.h"
+#include <zlib.h> /* for crc32 */
+#include <cbor.h>
+
+#include "hw/core/eif.h"
+
+#define MAX_SECTIONS 32
+
+/* members are ordered according to field order in .eif file */
+typedef struct EifHeader {
+    uint8_t  magic[4]; /* must be .eif in ascii i.e., [46, 101, 105, 102] */
+    uint16_t version;
+    uint16_t flags;
+    uint64_t default_memory;
+    uint64_t default_cpus;
+    uint16_t reserved;
+    uint16_t section_cnt;
+    uint64_t section_offsets[MAX_SECTIONS];
+    uint64_t section_sizes[MAX_SECTIONS];
+    uint32_t unused;
+    uint32_t eif_crc32;
+} QEMU_PACKED EifHeader;
+
+/* members are ordered according to field order in .eif file */
+typedef struct EifSectionHeader {
+    /*
+     * 0 = invalid, 1 = kernel, 2 = cmdline, 3 = ramdisk, 4 = signature,
+     * 5 = metadata
+     */
+    uint16_t section_type;
+    uint16_t flags;
+    uint64_t section_size;
+} QEMU_PACKED EifSectionHeader;
+
+enum EifSectionTypes {
+    EIF_SECTION_INVALID = 0,
+    EIF_SECTION_KERNEL = 1,
+    EIF_SECTION_CMDLINE = 2,
+    EIF_SECTION_RAMDISK = 3,
+    EIF_SECTION_SIGNATURE = 4,
+    EIF_SECTION_METADATA = 5,
+    EIF_SECTION_MAX = 6,
+};
+
+static const char *section_type_to_string(uint16_t type)
+{
+    const char *str;
+    switch (type) {
+    case EIF_SECTION_INVALID:
+        str = "invalid";
+        break;
+    case EIF_SECTION_KERNEL:
+        str = "kernel";
+        break;
+    case EIF_SECTION_CMDLINE:
+        str = "cmdline";
+        break;
+    case EIF_SECTION_RAMDISK:
+        str = "ramdisk";
+        break;
+    case EIF_SECTION_SIGNATURE:
+        str = "signature";
+        break;
+    case EIF_SECTION_METADATA:
+        str = "metadata";
+        break;
+    default:
+        str = "unknown";
+        break;
+    }
+
+    return str;
+}
+
+static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
+                            Error **errp)
+{
+    size_t got;
+    size_t header_size = sizeof(*header);
+
+    got = fread(header, 1, header_size, f);
+    if (got != header_size) {
+        error_setg(errp, "Failed to read EIF header");
+        return false;
+    }
+
+    if (memcmp(header->magic, ".eif", 4) != 0) {
+        error_setg(errp, "Invalid EIF image. Magic mismatch.");
+        return false;
+    }
+
+    /* Exclude header->eif_crc32 field from CRC calculation */
+    *crc = crc32(*crc, (uint8_t *)header, header_size - 4);
+
+    header->version = be16_to_cpu(header->version);
+    header->flags = be16_to_cpu(header->flags);
+    header->default_memory = be64_to_cpu(header->default_memory);
+    header->default_cpus = be64_to_cpu(header->default_cpus);
+    header->reserved = be16_to_cpu(header->reserved);
+    header->section_cnt = be16_to_cpu(header->section_cnt);
+
+    for (int i = 0; i < MAX_SECTIONS; ++i) {
+        header->section_offsets[i] = be64_to_cpu(header->section_offsets[i]);
+    }
+
+    for (int i = 0; i < MAX_SECTIONS; ++i) {
+        header->section_sizes[i] = be64_to_cpu(header->section_sizes[i]);
+    }
+
+    header->unused = be32_to_cpu(header->unused);
+    header->eif_crc32 = be32_to_cpu(header->eif_crc32);
+    return true;
+}
+
+static bool read_eif_section_header(FILE *f, EifSectionHeader *section_header,
+                                    uint32_t *crc, Error **errp)
+{
+    size_t got;
+    size_t section_header_size = sizeof(*section_header);
+
+    got = fread(section_header, 1, section_header_size, f);
+    if (got != section_header_size) {
+        error_setg(errp, "Failed to read EIF section header");
+        return false;
+    }
+
+    *crc = crc32(*crc, (uint8_t *)section_header, section_header_size);
+
+    section_header->section_type = be16_to_cpu(section_header->section_type);
+    section_header->flags = be16_to_cpu(section_header->flags);
+    section_header->section_size = be64_to_cpu(section_header->section_size);
+    return true;
+}
+
+/*
+ * Upon success, the caller is responsible for unlinking and freeing *tmp_path.
+ */
+static bool get_tmp_file(const char *template, char **tmp_path, Error **errp)
+{
+    int tmp_fd;
+
+    *tmp_path = NULL;
+    tmp_fd = g_file_open_tmp(template, tmp_path, NULL);
+    if (tmp_fd < 0 || *tmp_path == NULL) {
+        error_setg(errp, "Failed to create temporary file for template %s",
+                   template);
+        return false;
+    }
+
+    close(tmp_fd);
+    return true;
+}
+
+static void safe_fclose(FILE *f)
+{
+    if (f) {
+        fclose(f);
+    }
+}
+
+static void safe_unlink(char *f)
+{
+    if (f) {
+        unlink(f);
+    }
+}
+
+/*
+ * Upon success, the caller is reponsible for unlinking and freeing *kernel_path
+ */
+static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
+                            uint8_t *kernel, uint32_t *crc, Error **errp)
+{
+    size_t got;
+    FILE *tmp_file = NULL;
+
+    *kernel_path = NULL;
+    if (!get_tmp_file("eif-kernel-XXXXXX", kernel_path, errp)) {
+        goto cleanup;
+    }
+
+    tmp_file = fopen(*kernel_path, "wb");
+    if (tmp_file == NULL) {
+        error_setg_errno(errp, errno, "Failed to open temporary file %s",
+                         *kernel_path);
+        goto cleanup;
+    }
+
+    got = fread(kernel, 1, size, f);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to read EIF kernel section data");
+        goto cleanup;
+    }
+
+    got = fwrite(kernel, 1, size, tmp_file);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to write EIF kernel section data to temporary"
+                   " file");
+        goto cleanup;
+    }
+
+    *crc = crc32(*crc, kernel, size);
+    fclose(tmp_file);
+
+    return true;
+
+ cleanup:
+    safe_fclose(tmp_file);
+
+    safe_unlink(*kernel_path);
+    g_free(*kernel_path);
+    *kernel_path = NULL;
+
+    return false;
+}
+
+static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
+                             uint32_t *crc, Error **errp)
+{
+    size_t got = fread(cmdline, 1, size, f);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to read EIF cmdline section data");
+        return false;
+    }
+
+    *crc = crc32(*crc, (uint8_t *)cmdline, size);
+    return true;
+}
+
+static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
+                             uint8_t *ramdisk, uint32_t *crc, Error **errp)
+{
+    size_t got;
+
+    got = fread(ramdisk, 1, size, eif);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to read EIF ramdisk section data");
+        return false;
+    }
+
+    got = fwrite(ramdisk, 1, size, initrd);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to write EIF ramdisk data to temporary file");
+        return false;
+    }
+
+    *crc = crc32(*crc, ramdisk, size);
+    return true;
+}
+
+static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
+                                             uint8_t *sha384,
+                                             uint32_t *crc,
+                                             Error **errp)
+{
+    size_t got;
+    g_autofree uint8_t *sig = NULL;
+    g_autofree uint8_t *cert = NULL;
+    cbor_item_t *item = NULL;
+    cbor_item_t *pcr0 = NULL;
+    size_t len;
+    size_t hash_len = QCRYPTO_HASH_DIGEST_LEN_SHA384;
+    struct cbor_pair *pair;
+    struct cbor_load_result result;
+    bool ret = false;
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
+    if (qcrypto_get_x509_cert_fingerprint(cert, len, QCRYPTO_HASH_ALGO_SHA384,
+                                          sha384, &hash_len, errp)) {
+        goto cleanup;
+    }
+
+    ret = true;
+
+ cleanup:
+    if (pcr0) {
+        cbor_decref(&pcr0);
+    }
+    if (item) {
+        cbor_decref(&item);
+    }
+    return ret;
+}
+
+/* Expects file to have offset 0 before this function is called */
+static long get_file_size(FILE *f, Error **errp)
+{
+    long size;
+
+    if (fseek(f, 0, SEEK_END) != 0) {
+        error_setg_errno(errp, errno, "Failed to seek to the end of file");
+        return -1;
+    }
+
+    size = ftell(f);
+    if (size == -1) {
+        error_setg_errno(errp, errno, "Failed to get offset");
+        return -1;
+    }
+
+    if (fseek(f, 0, SEEK_SET) != 0) {
+        error_setg_errno(errp, errno, "Failed to seek back to the start");
+        return -1;
+    }
+
+    return size;
+}
+
+static bool get_SHA384_digest(GList *list, uint8_t *digest, Error **errp)
+{
+    size_t digest_len = QCRYPTO_HASH_DIGEST_LEN_SHA384;
+    size_t list_len = g_list_length(list);
+    struct iovec *iovec_list = g_new0(struct iovec, list_len);
+    bool ret = true;
+    GList *l;
+    int i;
+
+    for (i = 0, l = list; l != NULL; l = l->next, i++) {
+        iovec_list[i] = *(struct iovec *) l->data;
+    }
+
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALGO_SHA384, iovec_list, list_len,
+                            &digest, &digest_len, errp) < 0) {
+        ret = false;
+    }
+
+    g_free(iovec_list);
+    return ret;
+}
+
+static void free_iovec(struct iovec *iov)
+{
+    if (iov) {
+        g_free(iov->iov_base);
+        g_free(iov);
+    }
+}
+
+/*
+ * Upon success, the caller is reponsible for unlinking and freeing
+ * *kernel_path, *initrd_path and freeing *cmdline.
+ */
+bool read_eif_file(const char *eif_path, const char *machine_initrd,
+                   char **kernel_path, char **initrd_path, char **cmdline,
+                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
+                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
+                   bool *signature_found, Error **errp)
+{
+    FILE *f = NULL;
+    FILE *machine_initrd_f = NULL;
+    FILE *initrd_path_f = NULL;
+    long machine_initrd_size;
+    uint32_t crc = 0;
+    EifHeader eif_header;
+    bool seen_sections[EIF_SECTION_MAX] = {false};
+    /* kernel + ramdisks + cmdline sha384 hash */
+    GList *iov_PCR0 = NULL;
+    /* kernel + boot ramdisk + cmdline sha384 hash */
+    GList *iov_PCR1 = NULL;
+    /* application ramdisk(s) hash */
+    GList *iov_PCR2 = NULL;
+    uint8_t *ptr = NULL;
+    struct iovec *iov_ptr = NULL;
+
+    *signature_found = false;
+    *kernel_path = *initrd_path = *cmdline = NULL;
+
+    f = fopen(eif_path, "rb");
+    if (f == NULL) {
+        error_setg_errno(errp, errno, "Failed to open %s", eif_path);
+        goto cleanup;
+    }
+
+    if (!read_eif_header(f, &eif_header, &crc, errp)) {
+        goto cleanup;
+    }
+
+    if (eif_header.version < 4) {
+        error_setg(errp, "Expected EIF version 4 or greater");
+        goto cleanup;
+    }
+
+    if (eif_header.flags != 0) {
+        error_setg(errp, "Expected EIF flags to be 0");
+        goto cleanup;
+    }
+
+    if (eif_header.section_cnt > MAX_SECTIONS) {
+        error_setg(errp, "EIF header section count must not be greater than "
+                   "%d but found %d", MAX_SECTIONS, eif_header.section_cnt);
+        goto cleanup;
+    }
+
+    for (int i = 0; i < eif_header.section_cnt; ++i) {
+        EifSectionHeader hdr;
+        uint16_t section_type;
+
+        if (fseek(f, eif_header.section_offsets[i], SEEK_SET) != 0) {
+            error_setg_errno(errp, errno, "Failed to offset to %lu in EIF file",
+                             eif_header.section_offsets[i]);
+            goto cleanup;
+        }
+
+        if (!read_eif_section_header(f, &hdr, &crc, errp)) {
+            goto cleanup;
+        }
+
+        if (hdr.flags != 0) {
+            error_setg(errp, "Expected EIF section header flags to be 0");
+            goto cleanup;
+        }
+
+        if (eif_header.section_sizes[i] != hdr.section_size) {
+            error_setg(errp, "EIF section size mismatch between header and "
+                       "section header: header %lu, section header %lu",
+                       eif_header.section_sizes[i],
+                       hdr.section_size);
+            goto cleanup;
+        }
+
+        section_type = hdr.section_type;
+
+        switch (section_type) {
+        case EIF_SECTION_KERNEL:
+            if (seen_sections[EIF_SECTION_KERNEL]) {
+                error_setg(errp, "Invalid EIF image. More than 1 kernel "
+                           "section");
+                goto cleanup;
+            }
+
+            ptr = g_malloc(hdr.section_size);
+
+            iov_ptr = g_malloc(sizeof(struct iovec));
+            iov_ptr->iov_base = ptr;
+            iov_ptr->iov_len = hdr.section_size;
+
+            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
+            iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
+
+            if (!read_eif_kernel(f, hdr.section_size, kernel_path, ptr, &crc,
+                                 errp)) {
+                goto cleanup;
+            }
+
+            break;
+        case EIF_SECTION_CMDLINE:
+        {
+            uint64_t size;
+            uint8_t *cmdline_copy;
+            if (seen_sections[EIF_SECTION_CMDLINE]) {
+                error_setg(errp, "Invalid EIF image. More than 1 cmdline "
+                           "section");
+                goto cleanup;
+            }
+            size = hdr.section_size;
+            *cmdline = g_malloc(size + 1);
+            if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
+                goto cleanup;
+            }
+            (*cmdline)[size] = '\0';
+
+            /*
+             * We make a copy of '*cmdline' for putting it in iovecs so that
+             * we can easily free all the iovec entries later as we cannot
+             * free '*cmdline' which is used by the caller.
+             */
+            cmdline_copy = g_memdup2(*cmdline, size);
+
+            iov_ptr = g_malloc(sizeof(struct iovec));
+            iov_ptr->iov_base = cmdline_copy;
+            iov_ptr->iov_len = size;
+
+            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
+            iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
+            break;
+        }
+        case EIF_SECTION_RAMDISK:
+        {
+            if (!seen_sections[EIF_SECTION_RAMDISK]) {
+                /*
+                 * If this is the first time we are seeing a ramdisk section,
+                 * we need to create the initrd temporary file.
+                 */
+                if (!get_tmp_file("eif-initrd-XXXXXX", initrd_path, errp)) {
+                    goto cleanup;
+                }
+                initrd_path_f = fopen(*initrd_path, "wb");
+                if (initrd_path_f == NULL) {
+                    error_setg_errno(errp, errno, "Failed to open file %s",
+                                     *initrd_path);
+                    goto cleanup;
+                }
+            }
+
+            ptr = g_malloc(hdr.section_size);
+
+            iov_ptr = g_malloc(sizeof(struct iovec));
+            iov_ptr->iov_base = ptr;
+            iov_ptr->iov_len = hdr.section_size;
+
+            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
+            /*
+             * If it's the first ramdisk, we need to hash it into bootstrap
+             * i.e., iov_PCR1, otherwise we need to hash it into app i.e.,
+             * iov_PCR2.
+             */
+            if (!seen_sections[EIF_SECTION_RAMDISK]) {
+                iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
+            } else {
+                iov_PCR2 = g_list_append(iov_PCR2, iov_ptr);
+            }
+
+            if (!read_eif_ramdisk(f, initrd_path_f, hdr.section_size, ptr,
+                                  &crc, errp)) {
+                goto cleanup;
+            }
+
+            break;
+        }
+        case EIF_SECTION_SIGNATURE:
+            *signature_found = true;
+            if (!get_signature_fingerprint_sha384(f, hdr.section_size,
+                                                  fingerprint_sha384, &crc,
+                                                  errp)) {
+                goto cleanup;
+            }
+            break;
+        default:
+            /* other sections including invalid or unknown sections */
+        {
+            uint8_t *buf;
+            size_t got;
+            uint64_t size = hdr.section_size;
+            buf = g_malloc(size);
+            got = fread(buf, 1, size, f);
+            if ((uint64_t) got != size) {
+                g_free(buf);
+                error_setg(errp, "Failed to read EIF %s section data",
+                           section_type_to_string(section_type));
+                goto cleanup;
+            }
+            crc = crc32(crc, buf, size);
+            g_free(buf);
+            break;
+        }
+        }
+
+        if (section_type < EIF_SECTION_MAX) {
+            seen_sections[section_type] = true;
+        }
+    }
+
+    if (!seen_sections[EIF_SECTION_KERNEL]) {
+        error_setg(errp, "Invalid EIF image. No kernel section.");
+        goto cleanup;
+    }
+    if (!seen_sections[EIF_SECTION_CMDLINE]) {
+        error_setg(errp, "Invalid EIF image. No cmdline section.");
+        goto cleanup;
+    }
+    if (!seen_sections[EIF_SECTION_RAMDISK]) {
+        error_setg(errp, "Invalid EIF image. No ramdisk section.");
+        goto cleanup;
+    }
+
+    if (eif_header.eif_crc32 != crc) {
+        error_setg(errp, "CRC mismatch. Expected %u but header has %u.",
+                   crc, eif_header.eif_crc32);
+        goto cleanup;
+    }
+
+    /*
+     * Let's append the initrd file from "-initrd" option if any. Although
+     * we pass the crc pointer to read_eif_ramdisk, it is not useful anymore.
+     * We have already done the crc mismatch check above this code.
+     */
+    if (machine_initrd) {
+        machine_initrd_f = fopen(machine_initrd, "rb");
+        if (machine_initrd_f == NULL) {
+            error_setg_errno(errp, errno, "Failed to open initrd file %s",
+                             machine_initrd);
+            goto cleanup;
+        }
+
+        machine_initrd_size = get_file_size(machine_initrd_f, errp);
+        if (machine_initrd_size == -1) {
+            goto cleanup;
+        }
+
+        ptr = g_malloc(machine_initrd_size);
+
+        iov_ptr = g_malloc(sizeof(struct iovec));
+        iov_ptr->iov_base = ptr;
+        iov_ptr->iov_len = machine_initrd_size;
+
+        iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
+        iov_PCR2 = g_list_append(iov_PCR2, iov_ptr);
+
+        if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
+                              machine_initrd_size, ptr, &crc, errp)) {
+            goto cleanup;
+        }
+    }
+
+    if (!get_SHA384_digest(iov_PCR0, image_sha384, errp)) {
+        goto cleanup;
+    }
+    if (!get_SHA384_digest(iov_PCR1, bootstrap_sha384, errp)) {
+        goto cleanup;
+    }
+    if (!get_SHA384_digest(iov_PCR2, app_sha384, errp)) {
+        goto cleanup;
+    }
+
+    /*
+     * We only need to free iov_PCR0 entries because iov_PCR1 and
+     * iov_PCR2 iovec entries are subsets of iov_PCR0 iovec entries.
+     */
+    g_list_free_full(iov_PCR0, (GDestroyNotify) free_iovec);
+    g_list_free(iov_PCR1);
+    g_list_free(iov_PCR2);
+    fclose(f);
+    fclose(initrd_path_f);
+    safe_fclose(machine_initrd_f);
+    return true;
+
+ cleanup:
+    g_list_free_full(iov_PCR0, (GDestroyNotify) free_iovec);
+    g_list_free(iov_PCR1);
+    g_list_free(iov_PCR2);
+
+    safe_fclose(f);
+    safe_fclose(initrd_path_f);
+    safe_fclose(machine_initrd_f);
+
+    safe_unlink(*kernel_path);
+    g_free(*kernel_path);
+    *kernel_path = NULL;
+
+    safe_unlink(*initrd_path);
+    g_free(*initrd_path);
+    *initrd_path = NULL;
+
+    g_free(*cmdline);
+    *cmdline = NULL;
+
+    return false;
+}
diff --git a/hw/core/eif.h b/hw/core/eif.h
new file mode 100644
index 0000000000..fed3cb5514
--- /dev/null
+++ b/hw/core/eif.h
@@ -0,0 +1,22 @@
+/*
+ * EIF (Enclave Image Format) related helpers
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef HW_CORE_EIF_H
+#define HW_CORE_EIF_H
+
+bool read_eif_file(const char *eif_path, const char *machine_initrd,
+                   char **kernel_path, char **initrd_path,
+                   char **kernel_cmdline, uint8_t *image_sha384,
+                   uint8_t *bootstrap_sha384, uint8_t *app_sha384,
+                   uint8_t *fingerprint_sha384, bool *signature_found,
+                   Error **errp);
+
+#endif
+
-- 
2.39.5


