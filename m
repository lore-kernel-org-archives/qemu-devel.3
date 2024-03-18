Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4FDC54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfD-0007t1-BC; Mon, 18 Mar 2024 12:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFf5-0007cx-PB
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFf3-0004ja-CQ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNFNyUZNdVz6oPVpBpM8Rnr81qSoFxR0/XMg3L8r+jU=;
 b=CkVXgVDFZbeZglBxhJGr0qz4c+8+THWAG7nCE+5D3ERFBdAG0bycr0/3RnDFExvuajEpKL
 5jLYw0CxGJ7yMPrCw1V4wHTZ4eGzHO7jRl6q8TRMY92gvtr7n9vbWHKNyGtduxyRkO8HZD
 k3NsSOjAfACvakOM0kmEQLLNgVaAfTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-nr0YfenROjKXWdtAuii15Q-1; Mon, 18 Mar 2024 12:16:27 -0400
X-MC-Unique: nr0YfenROjKXWdtAuii15Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33eca7270ccso1793675f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778584; x=1711383384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNFNyUZNdVz6oPVpBpM8Rnr81qSoFxR0/XMg3L8r+jU=;
 b=sLdJQTG4qwyLIMnktaevCwqnXT6WOpeg1KmOIvnD3+tvFczvLul5V+rjXKDpzIbDqY
 b5VX7n9jZjzszkmlaHwMVNrw5bATVlNnPZ7vRK1dAZsX1VlhmHSqnFF4XWHorzxuz2CM
 zhj8z60l4GQuZ/Vd67cfkp7Cq2Y7qyUf94PouMonujDwqBZjXMi67ddHDN/1iXBwtM4J
 pX8IQo8kY6pib+HhvpQ+RgMaZm1nfJjGv2ZMRfjUms8jXrhjmEF1KjQpvN3EavWZoJ+a
 uy9BJX+5NjLc6nixfYiTRRICx6AfeyO0WQ8I+nnZdDlCW1zs1piYgxONfKnCBrhDH/l0
 CZXg==
X-Gm-Message-State: AOJu0YxkyRioV4DOO2Uf6r6RZ4mOK39HOe/mQd2vgG+97tYYRr9qZSgd
 /V7j5Bqxuvzl4fAoFENbyGMyfXgFDr82uwlRnq4fS1+ZlIZb6SdQZ+eVvL2uo/D0ffUeRxdMxRj
 UEOjFpsw1k5SSXMPGvNFyi9xciPdpSqIPl8XuA9WUVlK6vJOqgac1rQmfIR1P99k/OHsu9Fs6Ze
 lGJhctMWx47hiflEg3w2o31NSn6XogfQ==
X-Received: by 2002:a5d:6a48:0:b0:33d:eb13:9e27 with SMTP id
 t8-20020a5d6a48000000b0033deb139e27mr68855wrw.23.1710778583722; 
 Mon, 18 Mar 2024 09:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6QxOVpLj0srGizqlduQc91CvqKRuiivQvHJDZYihaBnyi1fg426l5MuJOa64AoVh253bCxw==
X-Received: by 2002:a5d:6a48:0:b0:33d:eb13:9e27 with SMTP id
 t8-20020a5d6a48000000b0033deb139e27mr68826wrw.23.1710778583205; 
 Mon, 18 Mar 2024 09:16:23 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 h2-20020a5d6e02000000b0033e91e53e8fsm10223436wrz.24.2024.03.18.09.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:22 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 14/24] smbios: build legacy mode code only for 'pc' machine
Message-ID: <b42b0e4daaa543bc9f8e24662f94d65f6481c4a0.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

basically moving code around without functional change.
And exposing some symbols so that they could be shared
between smbbios.c and new smbios_legacy.c

plus some meson magic to build smbios_legacy.c only
for 'pc' machine and otherwise replace it with stub
if not selected.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-12-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h   |   5 +
 hw/smbios/smbios.c             | 164 +-----------------------------
 hw/smbios/smbios_legacy.c      | 179 +++++++++++++++++++++++++++++++++
 hw/smbios/smbios_legacy_stub.c |  15 +++
 hw/i386/Kconfig                |   1 +
 hw/smbios/Kconfig              |   2 +
 hw/smbios/meson.build          |   4 +
 7 files changed, 207 insertions(+), 163 deletions(-)
 create mode 100644 hw/smbios/smbios_legacy.c
 create mode 100644 hw/smbios/smbios_legacy_stub.c

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 05707c6341..ccc51e72f5 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -17,6 +17,9 @@
  *
  */
 
+extern uint8_t *usr_blobs;
+extern GArray *usr_blobs_sizes;
+
 typedef struct {
     const char *vendor, *version, *date;
     bool have_major_minor, uefi;
@@ -323,6 +326,8 @@ struct smbios_type_127 {
     struct smbios_structure_header header;
 } QEMU_PACKED;
 
+void smbios_validate_table(void);
+void smbios_add_usr_blob_size(size_t size);
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 6c24fb75d3..242106fd87 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -31,38 +31,12 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-/* legacy structures and constants for <= 2.0 machines */
-struct smbios_header {
-    uint16_t length;
-    uint8_t type;
-} QEMU_PACKED;
-
-struct smbios_field {
-    struct smbios_header header;
-    uint8_t type;
-    uint16_t offset;
-    uint8_t data[];
-} QEMU_PACKED;
-
-struct smbios_table {
-    struct smbios_header header;
-    uint8_t data[];
-} QEMU_PACKED;
-
-#define SMBIOS_FIELD_ENTRY 0
-#define SMBIOS_TABLE_ENTRY 1
-
-static uint8_t *smbios_entries;
-static size_t smbios_entries_len;
 static bool smbios_uuid_encoded = true;
-/* end: legacy structures & constants for <= 2.0 machines */
-
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
 uint8_t *usr_blobs;
 size_t usr_blobs_len;
-static GArray *usr_blobs_sizes;
 static unsigned usr_table_max;
 static unsigned usr_table_cnt;
 
@@ -546,7 +520,7 @@ static void smbios_check_type4_count(uint32_t expected_t4_count)
     }
 }
 
-static void smbios_validate_table(void)
+void smbios_validate_table(void)
 {
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
         smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
@@ -556,134 +530,6 @@ static void smbios_validate_table(void)
     }
 }
 
-
-/* legacy setup functions for <= 2.0 machines */
-static void smbios_add_field(int type, int offset, const void *data, size_t len)
-{
-    struct smbios_field *field;
-
-    if (!smbios_entries) {
-        smbios_entries_len = sizeof(uint16_t);
-        smbios_entries = g_malloc0(smbios_entries_len);
-    }
-    smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
-                                                  sizeof(*field) + len);
-    field = (struct smbios_field *)(smbios_entries + smbios_entries_len);
-    field->header.type = SMBIOS_FIELD_ENTRY;
-    field->header.length = cpu_to_le16(sizeof(*field) + len);
-
-    field->type = type;
-    field->offset = cpu_to_le16(offset);
-    memcpy(field->data, data, len);
-
-    smbios_entries_len += sizeof(*field) + len;
-    (*(uint16_t *)smbios_entries) =
-            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
-}
-
-static void smbios_maybe_add_str(int type, int offset, const char *data)
-{
-    if (data) {
-        smbios_add_field(type, offset, data, strlen(data) + 1);
-    }
-}
-
-static void smbios_build_type_0_fields(void)
-{
-    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, vendor_str),
-                         smbios_type0.vendor);
-    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, bios_version_str),
-                         smbios_type0.version);
-    smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
-                                     bios_release_date_str),
-                         smbios_type0.date);
-    if (smbios_type0.have_major_minor) {
-        smbios_add_field(0, offsetof(struct smbios_type_0,
-                                     system_bios_major_release),
-                         &smbios_type0.major, 1);
-        smbios_add_field(0, offsetof(struct smbios_type_0,
-                                     system_bios_minor_release),
-                         &smbios_type0.minor, 1);
-    }
-}
-
-static void smbios_build_type_1_fields(void)
-{
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, manufacturer_str),
-                         smbios_type1.manufacturer);
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, product_name_str),
-                         smbios_type1.product);
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, version_str),
-                         smbios_type1.version);
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, serial_number_str),
-                         smbios_type1.serial);
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, sku_number_str),
-                         smbios_type1.sku);
-    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, family_str),
-                         smbios_type1.family);
-    if (qemu_uuid_set) {
-        /* We don't encode the UUID in the "wire format" here because this
-         * function is for legacy mode and needs to keep the guest ABI, and
-         * because we don't know what's the SMBIOS version advertised by the
-         * BIOS.
-         */
-        smbios_add_field(1, offsetof(struct smbios_type_1, uuid),
-                         &qemu_uuid, 16);
-    }
-}
-
-uint8_t *smbios_get_table_legacy(size_t *length)
-{
-    int i;
-    size_t usr_offset;
-
-    /* also complain if fields were given for types > 1 */
-    if (find_next_bit(smbios_have_fields_bitmap,
-                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
-        error_report("can't process fields for smbios "
-                     "types > 1 on machine versions < 2.1!");
-        exit(1);
-    }
-
-    if (test_bit(4, smbios_have_binfile_bitmap)) {
-        error_report("can't process table for smbios "
-                     "type 4 on machine versions < 2.1!");
-        exit(1);
-    }
-
-    g_free(smbios_entries);
-    smbios_entries_len = sizeof(uint16_t);
-    smbios_entries = g_malloc0(smbios_entries_len);
-
-    for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
-         i++)
-    {
-        struct smbios_table *table;
-        struct smbios_structure_header *header;
-        size_t size = g_array_index(usr_blobs_sizes, size_t, i);
-
-        header = (struct smbios_structure_header *)(usr_blobs + usr_offset);
-        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
-                                                   size + sizeof(*table));
-        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
-        table->header.type = SMBIOS_TABLE_ENTRY;
-        table->header.length = cpu_to_le16(sizeof(*table) + size);
-        memcpy(table->data, header, size);
-        smbios_entries_len += sizeof(*table) + size;
-        (*(uint16_t *)smbios_entries) =
-            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
-        usr_offset += size;
-    }
-
-    smbios_build_type_0_fields();
-    smbios_build_type_1_fields();
-    smbios_validate_table();
-    *length = smbios_entries_len;
-    return smbios_entries;
-}
-/* end: legacy setup functions for <= 2.0 machines */
-
-
 bool smbios_skip_table(uint8_t type, bool required_table)
 {
     if (test_bit(type, smbios_have_binfile_bitmap)) {
@@ -1403,14 +1249,6 @@ static bool save_opt_list(size_t *ndest, char ***dest, QemuOpts *opts,
     return true;
 }
 
-static void smbios_add_usr_blob_size(size_t size)
-{
-    if (!usr_blobs_sizes) {
-        usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
-    }
-    g_array_append_val(usr_blobs_sizes, size);
-}
-
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
new file mode 100644
index 0000000000..21f143e738
--- /dev/null
+++ b/hw/smbios/smbios_legacy.c
@@ -0,0 +1,179 @@
+/*
+ * SMBIOS legacy support
+ *
+ * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
+ * Copyright (C) 2013 Red Hat, Inc.
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@hp.com>
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "hw/firmware/smbios.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+
+struct smbios_header {
+    uint16_t length;
+    uint8_t type;
+} QEMU_PACKED;
+
+struct smbios_field {
+    struct smbios_header header;
+    uint8_t type;
+    uint16_t offset;
+    uint8_t data[];
+} QEMU_PACKED;
+
+struct smbios_table {
+    struct smbios_header header;
+    uint8_t data[];
+} QEMU_PACKED;
+
+#define SMBIOS_FIELD_ENTRY 0
+#define SMBIOS_TABLE_ENTRY 1
+
+static uint8_t *smbios_entries;
+static size_t smbios_entries_len;
+GArray *usr_blobs_sizes;
+
+void smbios_add_usr_blob_size(size_t size)
+{
+    if (!usr_blobs_sizes) {
+        usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
+    }
+    g_array_append_val(usr_blobs_sizes, size);
+}
+
+static void smbios_add_field(int type, int offset, const void *data, size_t len)
+{
+    struct smbios_field *field;
+
+    if (!smbios_entries) {
+        smbios_entries_len = sizeof(uint16_t);
+        smbios_entries = g_malloc0(smbios_entries_len);
+    }
+    smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
+                                                  sizeof(*field) + len);
+    field = (struct smbios_field *)(smbios_entries + smbios_entries_len);
+    field->header.type = SMBIOS_FIELD_ENTRY;
+    field->header.length = cpu_to_le16(sizeof(*field) + len);
+
+    field->type = type;
+    field->offset = cpu_to_le16(offset);
+    memcpy(field->data, data, len);
+
+    smbios_entries_len += sizeof(*field) + len;
+    (*(uint16_t *)smbios_entries) =
+            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
+}
+
+static void smbios_maybe_add_str(int type, int offset, const char *data)
+{
+    if (data) {
+        smbios_add_field(type, offset, data, strlen(data) + 1);
+    }
+}
+
+static void smbios_build_type_0_fields(void)
+{
+    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, vendor_str),
+                         smbios_type0.vendor);
+    smbios_maybe_add_str(0, offsetof(struct smbios_type_0, bios_version_str),
+                         smbios_type0.version);
+    smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
+                                     bios_release_date_str),
+                         smbios_type0.date);
+    if (smbios_type0.have_major_minor) {
+        smbios_add_field(0, offsetof(struct smbios_type_0,
+                                     system_bios_major_release),
+                         &smbios_type0.major, 1);
+        smbios_add_field(0, offsetof(struct smbios_type_0,
+                                     system_bios_minor_release),
+                         &smbios_type0.minor, 1);
+    }
+}
+
+static void smbios_build_type_1_fields(void)
+{
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, manufacturer_str),
+                         smbios_type1.manufacturer);
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, product_name_str),
+                         smbios_type1.product);
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, version_str),
+                         smbios_type1.version);
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, serial_number_str),
+                         smbios_type1.serial);
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, sku_number_str),
+                         smbios_type1.sku);
+    smbios_maybe_add_str(1, offsetof(struct smbios_type_1, family_str),
+                         smbios_type1.family);
+    if (qemu_uuid_set) {
+        /*
+         * We don't encode the UUID in the "wire format" here because this
+         * function is for legacy mode and needs to keep the guest ABI, and
+         * because we don't know what's the SMBIOS version advertised by the
+         * BIOS.
+         */
+        smbios_add_field(1, offsetof(struct smbios_type_1, uuid),
+                         &qemu_uuid, 16);
+    }
+}
+
+uint8_t *smbios_get_table_legacy(size_t *length)
+{
+    int i;
+    size_t usr_offset;
+
+    /* complain if fields were given for types > 1 */
+    if (find_next_bit(smbios_have_fields_bitmap,
+                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
+        error_report("can't process fields for smbios "
+                     "types > 1 on machine versions < 2.1!");
+        exit(1);
+    }
+
+    if (test_bit(4, smbios_have_binfile_bitmap)) {
+        error_report("can't process table for smbios "
+                     "type 4 on machine versions < 2.1!");
+        exit(1);
+    }
+
+    g_free(smbios_entries);
+    smbios_entries_len = sizeof(uint16_t);
+    smbios_entries = g_malloc0(smbios_entries_len);
+
+    for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
+         i++)
+    {
+        struct smbios_table *table;
+        struct smbios_structure_header *header;
+        size_t size = g_array_index(usr_blobs_sizes, size_t, i);
+
+        header = (struct smbios_structure_header *)(usr_blobs + usr_offset);
+        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
+                                                   size + sizeof(*table));
+        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
+        table->header.type = SMBIOS_TABLE_ENTRY;
+        table->header.length = cpu_to_le16(sizeof(*table) + size);
+        memcpy(table->data, header, size);
+        smbios_entries_len += sizeof(*table) + size;
+        (*(uint16_t *)smbios_entries) =
+            cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
+        usr_offset += size;
+    }
+
+    smbios_build_type_0_fields();
+    smbios_build_type_1_fields();
+    smbios_validate_table();
+    *length = smbios_entries_len;
+    return smbios_entries;
+}
diff --git a/hw/smbios/smbios_legacy_stub.c b/hw/smbios/smbios_legacy_stub.c
new file mode 100644
index 0000000000..f29b15316c
--- /dev/null
+++ b/hw/smbios/smbios_legacy_stub.c
@@ -0,0 +1,15 @@
+/*
+ * IPMI SMBIOS firmware handling
+ *
+ * Copyright (c) 2024 Igor Mammedov, Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/firmware/smbios.h"
+
+void smbios_add_usr_blob_size(size_t size)
+{
+}
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a1846be6f7..a6ee052f9a 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -76,6 +76,7 @@ config I440FX
     select PIIX
     select DIMM
     select SMBIOS
+    select SMBIOS_LEGACY
     select FW_CFG_DMA
 
 config ISAPC
diff --git a/hw/smbios/Kconfig b/hw/smbios/Kconfig
index 553adf4bfc..8d989a2f1b 100644
--- a/hw/smbios/Kconfig
+++ b/hw/smbios/Kconfig
@@ -1,2 +1,4 @@
 config SMBIOS
     bool
+config SMBIOS_LEGACY
+    bool
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
index 7046967462..a59039f669 100644
--- a/hw/smbios/meson.build
+++ b/hw/smbios/meson.build
@@ -4,5 +4,9 @@ smbios_ss.add(when: 'CONFIG_IPMI',
               if_true: files('smbios_type_38.c'),
               if_false: files('smbios_type_38-stub.c'))
 
+smbios_ss.add(when: 'CONFIG_SMBIOS_LEGACY',
+              if_true: files('smbios_legacy.c'),
+              if_false: files('smbios_legacy_stub.c'))
+
 system_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
 system_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
-- 
MST


