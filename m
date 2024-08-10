Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D02CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 16:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scpDa-0004Wg-9X; Sat, 10 Aug 2024 12:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDY-0004VM-5C
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:24 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDU-0003lW-R6
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:23 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-25e3bc751daso1944632fac.3
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723308319; x=1723913119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFD7ygxAqCPa8FhU2vwYGDFav6zFKvK19Ly3bSNumEU=;
 b=ieVVxx9s4+gnvbm12LkHIwphxGHUQXRFPtVexGW8JiYYZxgXIWbl3X6dbdDQ7Ry2ov
 qlQgDuhHDb/6LRth2rm8pPL24dJKgAtEwfKEMt9qmqscozXpyKPfEb1G8NIi7a42FR08
 At0KAQdSuKvf2eknONo4ivvnTWGxWPbMjMHmKBfUIPB+oCZXnLkrXWfI3bjTHc7mYbpI
 fZiZM+4PiykaFlbVJKVt1uZ7dZOuvxn89x5ZvArGYYgMs+YgPJJ9NR3HQRqOJnzwuDnL
 yUcQ8LBzzGhIqBtIFN8Y+ki3ypaWffelqqJouvocjBe4eTueO5cyEtLTa5q3ey0DjAPm
 GG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723308319; x=1723913119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFD7ygxAqCPa8FhU2vwYGDFav6zFKvK19Ly3bSNumEU=;
 b=aADvcNBnL+KQHk2n4xbB6n9FknfraRGLvz44Vtf3WNw7nSv/yRpJu9bv8UdxBF6+s7
 osiybZShNphaXlwxpf3hFcLXuPANaw9XBg2nIckrchlzbsv+NqVpfoYSC7ImxR5syawh
 TBBunDPEkdBXSVVMpnp7DkHtRr+ScuTX07gybwFwfceEI4J0p9ULLHQCD8ucr3mHp+Nw
 mM/F18keVWbgcyMGoIKbtjjdV7Ouazj0mVGGdnqYpLyybhcSM9Eio7jppytm0rbIFYG9
 xwT1KWv/wDaJrB+HRUS9zNVVvo1i3PN5dcZP09gGLrMl3dTgpqDKx3WIHjOb4zufCRAB
 g47g==
X-Gm-Message-State: AOJu0YxxQLaHZQXw1BPJVmbJoK4n7ZFD4Y517tKJxzgTxnIdsDG89s9K
 zH5Feo3Df8qSUQ/JFPpGzTt34NilcGA2f1rPdF+pXAMW5WoYycqzgWR1haDX
X-Google-Smtp-Source: AGHT+IGEMtzo5qg00C5cWzrf1saUMkX5yAmkwODX45FgOxCmT4sgXU5vm8xJU/w98UNtl2CBvEdZiQ==
X-Received: by 2002:a05:6870:a10d:b0:261:e19:4587 with SMTP id
 586e51a60fabf-26c62c428b5mr6215470fac.6.1723308318794; 
 Sat, 10 Aug 2024 09:45:18 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58735e2sm1424397b3a.30.2024.08.10.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 09:45:18 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v3 1/5] machine/nitro-enclave: New machine type for AWS Nitro
 Enclaves
Date: Sat, 10 Aug 2024 22:44:58 +0600
Message-Id: <20240810164502.19693-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240810164502.19693-1-dorjoychy111@gmail.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oa1-x2f.google.com
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

AWS nitro enclaves[1] is an Amazon EC2[2] feature that allows creating
isolated execution environments, called enclaves, from Amazon EC2
instances which are used for processing highly sensitive data.
Enclaves have no persistent storage and no external networking. The
enclave VMs are based on Firecracker microvm with a vhost-vsock
device for communication with the parent EC2 instance that spawned
it and a Nitro Secure Module (NSM) device for cryptographic attestation.
The parent instance VM always has CID 3 while the enclave VM gets a
dynamic CID.

An EIF (Enclave Image Format)[3] file is used to boot an AWS nitro
enclave virtual machine. The EIF file contains the necessary kernel,
cmdline, ramdisk(s) sections to boot.

This commit adds support for limited AWS nitro enclave emulation using
a new machine type option '-M nitro-enclave'. This new machine type is
based on the 'microvm' machine type, similar to how real nitro enclave
VMs are based on Firecracker microvm. For nitro-enclave to boot from
an EIF file, the kernel and ramdisk(s) are extracted into a temporary
kernel and a temporary initrd file which are then hooked into the
regular x86 boot mechanism along with the extracted cmdline. The EIF
file path should be provided using the '-kernel' QEMU option.

The vsock and NSM devices will be implemented so that they are available
automatically in nitro-enclave machine type in the following commits.

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://aws.amazon.com/ec2/
[3] https://github.com/aws/aws-nitro-enclaves-image-format

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                              |   9 +
 configs/devices/i386-softmmu/default.mak |   1 +
 hw/core/eif.c                            | 514 +++++++++++++++++++++++
 hw/core/eif.h                            |  19 +
 hw/core/meson.build                      |   1 +
 hw/i386/Kconfig                          |   4 +
 hw/i386/meson.build                      |   1 +
 hw/i386/microvm.c                        |   6 +-
 hw/i386/nitro_enclave.c                  |  93 ++++
 include/hw/i386/microvm.h                |   2 +
 include/hw/i386/nitro_enclave.h          |  29 ++
 11 files changed, 678 insertions(+), 1 deletion(-)
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 include/hw/i386/nitro_enclave.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 10af212632..f8d63031f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1877,6 +1877,15 @@ F: hw/i386/microvm.c
 F: include/hw/i386/microvm.h
 F: pc-bios/bios-microvm.bin
 
+nitro-enclave
+M: Alexander Graf <graf@amazon.com>
+M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
+S: Maintained
+F: hw/core/eif.c
+F: hw/core/eif.h
+F: hw/i386/nitro_enclave.c
+F: include/hw/i386/nitro_enclave.h
+
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 448e3e3b1b..4faf2f0315 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,3 +29,4 @@
 # CONFIG_I440FX=n
 # CONFIG_Q35=n
 # CONFIG_MICROVM=n
+# CONFIG_NITRO_ENCLAVE=n
diff --git a/hw/core/eif.c b/hw/core/eif.c
new file mode 100644
index 0000000000..5558879a96
--- /dev/null
+++ b/hw/core/eif.c
@@ -0,0 +1,514 @@
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
+/*
+ * Upon success, the caller is reponsible for unlinking and freeing
+ * *kernel_path, *initrd_path and freeing *cmdline.
+ */
+bool read_eif_file(const char *eif_path, const char *machine_initrd,
+                   char **kernel_path, char **initrd_path, char **cmdline,
+                   Error **errp)
+{
+    FILE *f = NULL;
+    FILE *machine_initrd_f = NULL;
+    FILE *initrd_path_f = NULL;
+    long machine_initrd_size;
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
+            if (!read_eif_ramdisk(f, initrd_path_f, section_header.section_size,
+                                  &crc, errp)) {
+                goto cleanup;
+            }
+
+            break;
+        }
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
+        if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
+                              machine_initrd_size, &crc, errp)) {
+            goto cleanup;
+        }
+    }
+
+    fclose(f);
+    fclose(initrd_path_f);
+    safe_fclose(machine_initrd_f);
+    return true;
+
+ cleanup:
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
index 0000000000..7063974d93
--- /dev/null
+++ b/hw/core/eif.h
@@ -0,0 +1,19 @@
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
+                   char **kernel_cmdline, Error **errp);
+
+#endif
+
diff --git a/hw/core/meson.build b/hw/core/meson.build
index a3d9bab9f4..f32d1ad943 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -24,6 +24,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
+system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib])
 
 system_ss.add(files(
   'cpu-sysemu.c',
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..eba8eaa960 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -129,6 +129,10 @@ config MICROVM
     select USB_XHCI_SYSBUS
     select I8254
 
+config NITRO_ENCLAVE
+    default y
+    depends on MICROVM
+
 config X86_IOMMU
     bool
     depends on PC
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 03aad10df7..10bdfde27c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -15,6 +15,7 @@ i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
+i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 40edcee7af..869c177642 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -283,6 +283,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
 static void microvm_memory_init(MicrovmMachineState *mms)
 {
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_GET_CLASS(mms);
     MachineState *machine = MACHINE(mms);
     X86MachineState *x86ms = X86_MACHINE(mms);
     MemoryRegion *ram_below_4g, *ram_above_4g;
@@ -328,7 +329,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        x86_load_linux(x86ms, fw_cfg, 0, true);
+        mmc->x86_load_linux(x86ms, fw_cfg, 0, true);
     }
 
     if (mms->option_roms) {
@@ -637,9 +638,12 @@ GlobalProperty microvm_properties[] = {
 static void microvm_class_init(ObjectClass *oc, void *data)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    mmc->x86_load_linux = x86_load_linux;
+
     mc->init = microvm_machine_state_init;
 
     mc->family = "microvm_i386";
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
new file mode 100644
index 0000000000..98690c6373
--- /dev/null
+++ b/hw/i386/nitro_enclave.c
@@ -0,0 +1,93 @@
+/*
+ * AWS nitro-enclave machine
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+#include "hw/core/eif.h"
+#include "hw/i386/x86.h"
+#include "hw/i386/microvm.h"
+#include "hw/i386/nitro_enclave.h"
+
+static void nitro_enclave_machine_initfn(Object *obj)
+{
+    MicrovmMachineState *mms = MICROVM_MACHINE(obj);
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    /* AWS nitro enclaves have PCIE and ACPI disabled */
+    mms->pcie = ON_OFF_AUTO_OFF;
+    x86ms->acpi = ON_OFF_AUTO_OFF;
+}
+
+static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
+                         int acpi_data_size, bool pvh_enabled)
+{
+    Error *err;
+    char *eif_kernel, *eif_initrd, *eif_cmdline;
+    MachineState *machine = MACHINE(x86ms);
+
+    if (!read_eif_file(machine->kernel_filename, machine->initrd_filename,
+                       &eif_kernel, &eif_initrd, &eif_cmdline, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    g_free(machine->kernel_filename);
+    machine->kernel_filename = eif_kernel;
+    g_free(machine->initrd_filename);
+    machine->initrd_filename = eif_initrd;
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
+}
+
+static void nitro_enclave_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
+
+    mmc->x86_load_linux = x86_load_eif;
+
+    mc->family = "nitro_enclave_i386";
+    mc->desc = "AWS Nitro Enclave";
+}
+
+static const TypeInfo nitro_enclave_machine_info = {
+    .name          = TYPE_NITRO_ENCLAVE_MACHINE,
+    .parent        = TYPE_MICROVM_MACHINE,
+    .instance_size = sizeof(NitroEnclaveMachineState),
+    .instance_init = nitro_enclave_machine_initfn,
+    .class_size    = sizeof(NitroEnclaveMachineClass),
+    .class_init    = nitro_enclave_class_init,
+};
+
+static void nitro_enclave_machine_init(void)
+{
+    type_register_static(&nitro_enclave_machine_info);
+}
+type_init(nitro_enclave_machine_init);
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index fad97a891d..b9ac34a3ef 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -78,6 +78,8 @@ struct MicrovmMachineClass {
     X86MachineClass parent;
     HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
+                        int acpi_data_size, bool pvh_enabled);
 };
 
 struct MicrovmMachineState {
diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
new file mode 100644
index 0000000000..a1dada9371
--- /dev/null
+++ b/include/hw/i386/nitro_enclave.h
@@ -0,0 +1,29 @@
+/*
+ * AWS nitro-enclave machine
+ *
+ * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef HW_I386_NITRO_ENCLAVE_H
+#define HW_I386_NITRO_ENCLAVE_H
+
+#include "hw/i386/microvm.h"
+#include "qom/object.h"
+
+struct NitroEnclaveMachineClass {
+    MicrovmMachineClass parent;
+};
+
+struct NitroEnclaveMachineState {
+    MicrovmMachineState parent;
+};
+
+#define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
+OBJECT_DECLARE_TYPE(NitroEnclaveMachineState, NitroEnclaveMachineClass,
+                    NITRO_ENCLAVE_MACHINE)
+
+#endif
-- 
2.39.2


