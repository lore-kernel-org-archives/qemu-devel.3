Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FA0C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 08:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8F78-00051c-1q; Sat, 18 May 2024 04:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8F75-00051O-Hy
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:08:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8F72-0006oL-OG
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:08:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1edf506b216so30044735ad.2
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716019695; x=1716624495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8c72JCj/fo4PaM5dFLZ4yyk+qQg0pqTvI2LIpLtCm4=;
 b=CGoUBhRCDqPoTs19H25AFDD0Tb7yhWnVCvEVutMs6arT5LiiJlVsIW+tCc76dIXBp2
 G75Wzaqe1OqTTowkj2xo7u3NEP2EeH0OLPNra+yJVwcnj4ObB0D0545tRYS63DaIdRUQ
 5I836oCayaGpTC5DbCGYx4Gzfw/PiqJ9CgLoXQmE7Z5uGNm46gzNFxLugKvljyhCmhh9
 /Fn1z2BtQzCKA7j4fQDGq4aVHG86nCpJKppBdMlcRQ3eS7wFz9sFbpRdk39yVpY4e9sl
 LpkYaOx1y6HYqaX+aR0U5a2WaEcoCWd+rgY8tqqIzD+LgWVIv23MgV0iwCFVo+jn/FR7
 Nv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716019695; x=1716624495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8c72JCj/fo4PaM5dFLZ4yyk+qQg0pqTvI2LIpLtCm4=;
 b=GtZSUMoxuN7IbFWyJ+W3xafwnvFjv1/YCL9Z5QKZYrC9MAPf0LStUbxg30pybVchHP
 BwZEhUGCMIbTrF+QClY/3Lb2ni8q5xAbIlbaEXdLvnZAiXYkuxsRoF9ZtEtjD1SKNV/X
 TzIy8WKfTDNPzLO/jPJJmcELa7kxi9WtJi9CaWcn+GqI+QBeXCwrHCisgK+NSGzhwxCf
 8zvgQxSHAfnlRTNhLLtqL6bOVLR1lnRnS6vyEhQLpzMdqaMsE+OBbfow064sZOIQYvrD
 FnEPsee8t8kLnTZdLwBQlfVoW+pUAeHEUw7JN1lwqQ+2kcURxJb69Idrz4ol+i+uc0ew
 H3IA==
X-Gm-Message-State: AOJu0YwGnuUlnIwJqF5iCixhwqVM4YKxm0wOYYgi96zZIrWypCx3q056
 ZLrC7TONMBi0LnLRKlFF23U2tZ1iSi7YibWNXVpi0L3BJ5XSC1eW2fCNTu6i
X-Google-Smtp-Source: AGHT+IGzcM8qnMwadyOm8XlZ5fVDPkBL8BVajZhTUCOX3DmZEDqTau8jYvGwmh5+1Ht5Vct+8lC5dQ==
X-Received: by 2002:a17:902:bf06:b0:1e7:b6f4:971 with SMTP id
 d9443c01a7336-1ef43e354cbmr174661215ad.27.1716019694697; 
 Sat, 18 May 2024 01:08:14 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f0cb2141b0sm45247265ad.285.2024.05.18.01.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 01:08:14 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v1 1/2] machine/microvm: support for loading EIF image
Date: Sat, 18 May 2024 14:07:52 +0600
Message-Id: <20240518080753.7083-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240518080753.7083-1-dorjoychy111@gmail.com>
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x634.google.com
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

An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
enclave[2] virtual machine. The EIF file contains the necessary
kernel, cmdline, ramdisk(s) sections to boot.

This commit adds support for loading EIF image using the microvm
machine code. For microvm to boot from an EIF file, the kernel and
ramdisk(s) are extracted into a temporary kernel and a temporary
initrd file which are then hooked into the regular x86 boot mechanism
along with the extracted cmdline.

Although not useful for the microvm machine itself, this is needed
as the following commit adds support for a new machine type
'nitro-enclave' which uses the microvm machine type as parent. The
code for checking and loading EIF will be put inside a 'nitro-enclave'
machine type check in the following commit so that microvm cannot load
EIF because it shouldn't.

[1] https://github.com/aws/aws-nitro-enclaves-image-format
[2] https://aws.amazon.com/ec2/nitro/nitro-enclaves/

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 hw/i386/eif.c       | 486 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/eif.h       |  20 ++
 hw/i386/meson.build |   2 +-
 hw/i386/microvm.c   | 134 +++++++++++-
 4 files changed, 640 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/eif.c
 create mode 100644 hw/i386/eif.h

diff --git a/hw/i386/eif.c b/hw/i386/eif.c
new file mode 100644
index 0000000000..761c489d33
--- /dev/null
+++ b/hw/i386/eif.c
@@ -0,0 +1,486 @@
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
+#include <zlib.h> /* for crc32 */
+
+#include "hw/i386/eif.h"
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
+                            uint32_t *crc, Error **errp)
+{
+    size_t got;
+    FILE *tmp_file = NULL;
+    uint8_t *kernel = NULL;
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
+    kernel = g_malloc(size);
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
+    g_free(kernel);
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
+    g_free(kernel);
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
+                             uint32_t *crc, Error **errp)
+{
+    size_t got;
+    uint8_t *ramdisk = g_malloc(size);
+
+    got = fread(ramdisk, 1, size, eif);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to read EIF ramdisk section data");
+        goto cleanup;
+    }
+
+    got = fwrite(ramdisk, 1, size, initrd);
+    if ((uint64_t) got != size) {
+        error_setg(errp, "Failed to write EIF ramdisk data to temporary file");
+        goto cleanup;
+    }
+
+    *crc = crc32(*crc, ramdisk, size);
+    g_free(ramdisk);
+    return true;
+
+ cleanup:
+    g_free(ramdisk);
+    return false;
+}
+
+/*
+ * Upon success, the caller is reponsible for unlinking and freeing
+ * *kernel_path, *initrd_path and freeing *cmdline.
+ */
+bool read_eif_file(const char *eif_path, char **kernel_path, char **initrd_path,
+                   char **cmdline, Error **errp)
+{
+    FILE *f = NULL;
+    FILE *initrd_f = NULL;
+    uint32_t crc = 0;
+    EifHeader eif_header;
+    bool seen_sections[EIF_SECTION_MAX] = {false};
+
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
+        EifSectionHeader section_header;
+        uint16_t section_type;
+
+        if (fseek(f, eif_header.section_offsets[i], SEEK_SET) != 0) {
+            error_setg_errno(errp, errno, "Failed to offset to %lu in EIF file",
+                             eif_header.section_offsets[i]);
+            goto cleanup;
+        }
+
+        if (!read_eif_section_header(f, &section_header, &crc, errp)) {
+            goto cleanup;
+        }
+
+        if (section_header.flags != 0) {
+            error_setg(errp, "Expected EIF section header flags to be 0");
+            goto cleanup;
+        }
+
+        if (eif_header.section_sizes[i] != section_header.section_size) {
+            error_setg(errp, "EIF section size mismatch between header and "
+                       "section header: header %lu, section header %lu",
+                       eif_header.section_sizes[i],
+                       section_header.section_size);
+            goto cleanup;
+        }
+
+        section_type = section_header.section_type;
+
+        switch (section_type) {
+        case EIF_SECTION_KERNEL:
+            if (seen_sections[EIF_SECTION_KERNEL]) {
+                error_setg(errp, "Invalid EIF image. More than 1 kernel "
+                           "section");
+                goto cleanup;
+            }
+            if (!read_eif_kernel(f, section_header.section_size, kernel_path,
+                                 &crc, errp)) {
+                goto cleanup;
+            }
+
+            break;
+        case EIF_SECTION_CMDLINE:
+        {
+            uint64_t size;
+            if (seen_sections[EIF_SECTION_CMDLINE]) {
+                error_setg(errp, "Invalid EIF image. More than 1 cmdline "
+                           "section");
+                goto cleanup;
+            }
+            size = section_header.section_size;
+            *cmdline = g_malloc(size + 1);
+            if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
+                goto cleanup;
+            }
+            (*cmdline)[size] = '\0';
+
+            break;
+        }
+        case EIF_SECTION_RAMDISK:
+            if (!seen_sections[EIF_SECTION_RAMDISK]) {
+                /*
+                 * If this is the first time we are seeing a ramdisk section,
+                 * we need to create the initrd temporary file.
+                 */
+                if (!get_tmp_file("eif-initrd-XXXXXX", initrd_path, errp)) {
+                    goto cleanup;
+                }
+                initrd_f = fopen(*initrd_path, "wb");
+                if (initrd_f == NULL) {
+                    error_setg_errno(errp, errno, "Failed to open file %s",
+                                     *initrd_path);
+                    goto cleanup;
+                }
+            }
+
+            if (!read_eif_ramdisk(f, initrd_f, section_header.section_size,
+                                  &crc, errp)) {
+                goto cleanup;
+            }
+
+            break;
+        default:
+            /* other sections including invalid or unknown sections */
+        {
+            uint8_t *buf;
+            size_t got;
+            uint64_t size = section_header.section_size;
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
+    fclose(f);
+    fclose(initrd_f);
+    return true;
+
+ cleanup:
+    safe_fclose(f);
+    safe_fclose(initrd_f);
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
+
+bool check_if_eif_file(const char *path, bool *is_eif, Error **errp)
+{
+    size_t got;
+    uint8_t buf[4];
+    FILE *f = NULL;
+
+    f = fopen(path, "rb");
+    if (f == NULL) {
+        error_setg_errno(errp, errno, "Failed to open file %s", path);
+        goto cleanup;
+    }
+
+    got = fread(buf, 1, 4, f);
+    if (got != 4) {
+        error_setg(errp, "Failed to read magic value from %s", path);
+        goto cleanup;
+    }
+
+    fclose(f);
+    *is_eif = !memcmp(buf, ".eif", 4);
+    return true;
+
+ cleanup:
+    safe_fclose(f);
+    return false;
+}
diff --git a/hw/i386/eif.h b/hw/i386/eif.h
new file mode 100644
index 0000000000..b71a27062d
--- /dev/null
+++ b/hw/i386/eif.h
@@ -0,0 +1,20 @@
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
+#ifndef HW_I386_EIF_H
+#define HW_I386_EIF_H
+
+bool read_eif_file(const char *eif_path, char **kernel_path, char **initrd_path,
+                    char **kernel_cmdline, Error **errp);
+
+bool check_if_eif_file(const char *path, bool *is_eif, Error **errp);
+
+#endif
+
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7..e398fc1d74 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,7 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
-i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
+i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c', 'eif.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index fec63cacfa..d52d85bd01 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -34,6 +34,7 @@
 #include "hw/irq.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/i386/microvm.h"
+#include "hw/i386/eif.h"
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
@@ -281,6 +282,127 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
 }
 
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
+static void load_eif(MicrovmMachineState *mms, FWCfgState *fw_cfg)
+{
+    Error *err;
+    char *eif_kernel, *eif_initrd, *eif_cmdline;
+    MachineState *machine = MACHINE(mms);
+    X86MachineState *x86ms = X86_MACHINE(mms);
+
+    if (!read_eif_file(machine->kernel_filename, &eif_kernel, &eif_initrd,
+                       &eif_cmdline, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    g_free(machine->kernel_filename);
+    machine->kernel_filename = eif_kernel;
+
+    /*
+     * If an initrd argument was provided, let's concatenate it to the
+     * extracted EIF initrd temporary file.
+     */
+    if (machine->initrd_filename) {
+        long size;
+        size_t got;
+        uint8_t *buf;
+        FILE *initrd_f, *eif_initrd_f;
+
+        initrd_f = fopen(machine->initrd_filename, "rb");
+        if (initrd_f == NULL) {
+            error_setg_errno(&err, errno, "Failed to open initrd file %s",
+                             machine->initrd_filename);
+            goto cleanup;
+        }
+
+        size = get_file_size(initrd_f, &err);
+        if (size == -1) {
+            goto cleanup;
+        }
+
+        buf = g_malloc(size);
+        got = fread(buf, 1, size, initrd_f);
+        if ((uint64_t) got != (uint64_t) size) {
+            error_setg(&err, "Failed to read initrd file %s",
+                       machine->initrd_filename);
+            goto cleanup;
+        }
+
+        eif_initrd_f = fopen(eif_initrd, "ab");
+        if (eif_initrd_f == NULL) {
+            error_setg_errno(&err, errno, "Failed to open EIF initrd file %s",
+                             eif_initrd);
+            goto cleanup;
+        }
+        got = fwrite(buf, 1, size, eif_initrd_f);
+        if ((uint64_t) got != (uint64_t) size) {
+            error_setg(&err, "Failed to append initrd %s to %s",
+                       machine->initrd_filename, eif_initrd);
+            goto cleanup;
+        }
+
+        fclose(initrd_f);
+        fclose(eif_initrd_f);
+
+        g_free(buf);
+        g_free(machine->initrd_filename);
+
+        machine->initrd_filename = eif_initrd;
+    } else {
+        machine->initrd_filename = eif_initrd;
+    }
+
+    /*
+     * If kernel cmdline argument was provided, let's concatenate it to the
+     * extracted EIF kernel cmdline.
+     */
+    if (machine->kernel_cmdline != NULL) {
+        char *cmd = g_strdup_printf("%s %s", eif_cmdline,
+                                    machine->kernel_cmdline);
+        g_free(eif_cmdline);
+        g_free(machine->kernel_cmdline);
+        machine->kernel_cmdline = cmd;
+    } else {
+        machine->kernel_cmdline = eif_cmdline;
+    }
+
+    x86_load_linux(x86ms, fw_cfg, 0, true);
+
+    unlink(machine->kernel_filename);
+    unlink(machine->initrd_filename);
+    return;
+
+ cleanup:
+    error_report_err(err);
+    unlink(eif_kernel);
+    unlink(eif_initrd);
+    exit(1);
+}
+
 static void microvm_memory_init(MicrovmMachineState *mms)
 {
     MachineState *machine = MACHINE(mms);
@@ -330,7 +452,17 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        x86_load_linux(x86ms, fw_cfg, 0, true);
+        Error *err;
+        bool is_eif = false;
+        if (!check_if_eif_file(machine->kernel_filename, &is_eif, &err)) {
+            error_report_err(err);
+            exit(1);
+        }
+        if (is_eif) {
+            load_eif(mms, fw_cfg);
+        } else {
+            x86_load_linux(x86ms, fw_cfg, 0, true);
+        }
     }
 
     if (mms->option_roms) {
-- 
2.39.2


