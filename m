Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADC9C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFf0-0007To-6p; Mon, 18 Mar 2024 12:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFew-0007QX-9z
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFes-0004ej-Mz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PP1fbOrCM8+i+U1CUJ7OlG1bOMoCZY0hrHdBMs68YuA=;
 b=J7TQ4eBbvGt5cAS2exTALjwrEzPJigAX4cmEy17OSAiEFPE1CnoETt1qhqaLMSPnwPBnWx
 /u0OUlXW546P0MyAR1fKA3MIT4P8ckHCQ4ziXxPiSWgv1rigCnuDRPmDhW4mpL9T/QX1zp
 irjckd55D3bWTnj0nMZW74rrblp87zg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-c_r_p_8kMmuE04AL8Jv7-Q-1; Mon, 18 Mar 2024 12:16:07 -0400
X-MC-Unique: c_r_p_8kMmuE04AL8Jv7-Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ecc0f0c95so2389339f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778566; x=1711383366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PP1fbOrCM8+i+U1CUJ7OlG1bOMoCZY0hrHdBMs68YuA=;
 b=TQibSYcWEupThbUT9OmWHAEnaWGCR8SUKJpQSfl8U0J+VmE6lVx3zULOf9ZU5p2JqQ
 xlWebYSimjRmd6Lps38uPJgUd3oTwesn4nWNhrs3pmA3RBNjhLxfeIuhYEm0ZSpv6pTU
 42nPn2sCqnuKU6cTriPPQAaUyb4NRoUxKBndbabF3aM6r2K4z06rhE/okh4eEuAuel6K
 BRYEzWsbOeAQEfSVk1FKRwH0obexhwFBz5PCALd53kQQtweqHVEgmCIJT1ACmlJX60CQ
 YchQ+gWYLUeLFYR3akFdEhsG6Hc5ujQLG9Xv+E7uTvuWH65p9VJI2rezcxorlydFop7k
 O4lg==
X-Gm-Message-State: AOJu0YxLhkhGSFlYYZfZ0Ogz8HbCUMjToVkmNgtME3Za/ecsHvh7MXU2
 19MhgZiMzPIiTImDs+Bc9EijCvmMndNISdYJtdsOzPYUZqwbskoyMez8HPpH2zObsunE8ZdiHlj
 s6JhPTkkq4dsIvH0n+7PHZqKnrI9+7w81ZV7J0IT+KIGgT6NdMrPx+c5cMjnLdZfDyJ41GyVbIM
 fQ8RrI+Gv9PjJ+rB9s1wjGcKMTMGYHtw==
X-Received: by 2002:adf:ec03:0:b0:33e:b6d6:c342 with SMTP id
 x3-20020adfec03000000b0033eb6d6c342mr7212468wrn.34.1710778565795; 
 Mon, 18 Mar 2024 09:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpLwNzHuAq/3nqQ/zTo12xUMGEUX6lLgf9+myynA24W7GgsSxsSFE5HVvNeufXyOG3c5Nupg==
X-Received: by 2002:adf:ec03:0:b0:33e:b6d6:c342 with SMTP id
 x3-20020adfec03000000b0033eb6d6c342mr7212442wrn.34.1710778565191; 
 Mon, 18 Mar 2024 09:16:05 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4002000000b0033e93e00f68sm10122137wrp.61.2024.03.18.09.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:04 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/24] smbios: avoid mangling user provided tables
Message-ID: <cba59fe38a2bc2b1888892539d0c4688e07aa356.1710778506.git.mst@redhat.com>
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

currently smbios_entry_add() preserves internally '-smbios type='
options but tables provided with '-smbios file=' are stored directly
into blob that eventually will be exposed to VM. And then later
QEMU adds default/'-smbios type' entries on top into the same blob.

It makes impossible to generate tables more than once, hence
'immutable' guard was used.
Make it possible to regenerate final blob by storing user provided
blobs into a dedicated area (usr_blobs) and then copy it when
composing final blob. Which also makes handling of -smbios
options consistent.

As side effect of this and previous commits there is no need to
generate legacy smbios_entries at the time options are parsed.
Instead compose smbios_entries on demand from  usr_blobs like
it is done for non-legacy SMBIOS tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-8-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 187 +++++++++++++++++++++++----------------------
 1 file changed, 96 insertions(+), 91 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 9f9087601c..aab4ffb4cb 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -57,6 +57,14 @@ static size_t smbios_entries_len;
 static bool smbios_uuid_encoded = true;
 /* end: legacy structures & constants for <= 2.0 machines */
 
+/*
+ * SMBIOS tables provided by user with '-smbios file=<foo>' option
+ */
+uint8_t *usr_blobs;
+size_t usr_blobs_len;
+static GArray *usr_blobs_sizes;
+static unsigned usr_table_max;
+static unsigned usr_table_cnt;
 
 uint8_t *smbios_tables;
 size_t smbios_tables_len;
@@ -67,7 +75,6 @@ static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 static SmbiosEntryPoint ep;
 
 static int smbios_type4_count = 0;
-static bool smbios_immutable;
 static bool smbios_have_defaults;
 static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
@@ -632,9 +639,8 @@ static void smbios_build_type_1_fields(void)
 
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
-    /* drop unwanted version of command-line file blob(s) */
-    g_free(smbios_tables);
-    smbios_tables = NULL;
+    int i;
+    size_t usr_offset;
 
     /* also complain if fields were given for types > 1 */
     if (find_next_bit(have_fields_bitmap,
@@ -644,12 +650,33 @@ uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
         exit(1);
     }
 
-    if (!smbios_immutable) {
-        smbios_build_type_0_fields();
-        smbios_build_type_1_fields();
-        smbios_validate_table(expected_t4_count);
-        smbios_immutable = true;
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
     }
+
+    smbios_build_type_0_fields();
+    smbios_build_type_1_fields();
+    smbios_validate_table(expected_t4_count);
     *length = smbios_entries_len;
     return smbios_entries;
 }
@@ -1217,69 +1244,69 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
-    /* drop unwanted (legacy) version of command-line file blob(s) */
-    g_free(smbios_entries);
-    smbios_entries = NULL;
+    g_free(smbios_tables);
+    smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
+    smbios_tables_len = usr_blobs_len;
+    smbios_table_max = usr_table_max;
+    smbios_table_cnt = usr_table_cnt;
 
-    if (!smbios_immutable) {
-        smbios_build_type_0_table();
-        smbios_build_type_1_table();
-        smbios_build_type_2_table();
-        smbios_build_type_3_table();
+    smbios_build_type_0_table();
+    smbios_build_type_1_table();
+    smbios_build_type_2_table();
+    smbios_build_type_3_table();
 
-        assert(ms->smp.sockets >= 1);
+    assert(ms->smp.sockets >= 1);
 
-        for (i = 0; i < ms->smp.sockets; i++) {
-            smbios_build_type_4_table(ms, i);
-        }
+    for (i = 0; i < ms->smp.sockets; i++) {
+        smbios_build_type_4_table(ms, i);
+    }
 
-        smbios_build_type_8_table();
-        smbios_build_type_9_table(errp);
-        smbios_build_type_11_table();
+    smbios_build_type_8_table();
+    smbios_build_type_9_table(errp);
+    smbios_build_type_11_table();
 
 #define MAX_DIMM_SZ (16 * GiB)
 #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
                                         : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
 
-        dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
+    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
+               MAX_DIMM_SZ;
 
-        /*
-         * The offset determines if we need to keep additional space between
-         * table 17 and table 19 header handle numbers so that they do
-         * not overlap. For example, for a VM with larger than 8 TB guest
-         * memory and DIMM like chunks of 16 GiB, the default space between
-         * the two tables (T19_BASE - T17_BASE = 512) is not enough.
-         */
-        offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
-                 dimm_cnt - (T19_BASE - T17_BASE) : 0;
+    /*
+     * The offset determines if we need to keep additional space between
+     * table 17 and table 19 header handle numbers so that they do
+     * not overlap. For example, for a VM with larger than 8 TB guest
+     * memory and DIMM like chunks of 16 GiB, the default space between
+     * the two tables (T19_BASE - T17_BASE = 512) is not enough.
+     */
+    offset = (dimm_cnt > (T19_BASE - T17_BASE)) ? \
+             dimm_cnt - (T19_BASE - T17_BASE) : 0;
 
-        smbios_build_type_16_table(dimm_cnt);
+    smbios_build_type_16_table(dimm_cnt);
 
-        for (i = 0; i < dimm_cnt; i++) {
-            smbios_build_type_17_table(i, GET_DIMM_SZ);
-        }
-
-        for (i = 0; i < mem_array_size; i++) {
-            smbios_build_type_19_table(i, offset, mem_array[i].address,
-                                       mem_array[i].length);
-        }
-
-        /*
-         * make sure 16 bit handle numbers in the headers of tables 19
-         * and 32 do not overlap.
-         */
-        assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
-
-        smbios_build_type_32_table();
-        smbios_build_type_38_table();
-        smbios_build_type_41_table(errp);
-        smbios_build_type_127_table();
-
-        smbios_validate_table(ms->smp.sockets);
-        smbios_entry_point_setup();
-        smbios_immutable = true;
+    for (i = 0; i < dimm_cnt; i++) {
+        smbios_build_type_17_table(i, GET_DIMM_SZ);
     }
 
+    for (i = 0; i < mem_array_size; i++) {
+        smbios_build_type_19_table(i, offset, mem_array[i].address,
+                                   mem_array[i].length);
+    }
+
+    /*
+     * make sure 16 bit handle numbers in the headers of tables 19
+     * and 32 do not overlap.
+     */
+    assert((mem_array_size + offset) < (T32_BASE - T19_BASE));
+
+    smbios_build_type_32_table();
+    smbios_build_type_38_table();
+    smbios_build_type_41_table(errp);
+    smbios_build_type_127_table();
+
+    smbios_validate_table(ms->smp.sockets);
+    smbios_entry_point_setup();
+
     /* return tables blob and entry point (anchor), and their sizes */
     *tables = smbios_tables;
     *tables_len = smbios_tables_len;
@@ -1378,13 +1405,10 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
 
-    assert(!smbios_immutable);
-
     val = qemu_opt_get(opts, "file");
     if (val) {
         struct smbios_structure_header *header;
-        int size;
-        struct smbios_table *table; /* legacy mode only */
+        size_t size;
 
         if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
             return;
@@ -1401,9 +1425,9 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
          * (except in legacy mode, where the second '\0' is implicit and
          *  will be inserted by the BIOS).
          */
-        smbios_tables = g_realloc(smbios_tables, smbios_tables_len + size);
-        header = (struct smbios_structure_header *)(smbios_tables +
-                                                    smbios_tables_len);
+        usr_blobs = g_realloc(usr_blobs, usr_blobs_len + size);
+        header = (struct smbios_structure_header *)(usr_blobs +
+                                                    usr_blobs_len);
 
         if (load_image_size(val, (uint8_t *)header, size) != size) {
             error_setg(errp, "Failed to load SMBIOS file %s", val);
@@ -1424,34 +1448,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             smbios_type4_count++;
         }
 
-        smbios_tables_len += size;
-        if (size > smbios_table_max) {
-            smbios_table_max = size;
+        if (!usr_blobs_sizes) {
+            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
         }
-        smbios_table_cnt++;
-
-        /* add a copy of the newly loaded blob to legacy smbios_entries */
-        /* NOTE: This code runs before smbios_set_defaults(), so we don't
-         *       yet know which mode (legacy vs. aggregate-table) will be
-         *       required. We therefore add the binary blob to both legacy
-         *       (smbios_entries) and aggregate (smbios_tables) tables, and
-         *       delete the one we don't need from smbios_set_defaults(),
-         *       once we know which machine version has been requested.
-         */
-        if (!smbios_entries) {
-            smbios_entries_len = sizeof(uint16_t);
-            smbios_entries = g_malloc0(smbios_entries_len);
+        g_array_append_val(usr_blobs_sizes, size);
+        usr_blobs_len += size;
+        if (size > usr_table_max) {
+            usr_table_max = size;
         }
-        smbios_entries = g_realloc(smbios_entries, smbios_entries_len +
-                                                   size + sizeof(*table));
-        table = (struct smbios_table *)(smbios_entries + smbios_entries_len);
-        table->header.type = SMBIOS_TABLE_ENTRY;
-        table->header.length = cpu_to_le16(sizeof(*table) + size);
-        memcpy(table->data, header, size);
-        smbios_entries_len += sizeof(*table) + size;
-        (*(uint16_t *)smbios_entries) =
-                cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
-        /* end: add a copy of the newly loaded blob to legacy smbios_entries */
+        usr_table_cnt++;
 
         return;
     }
-- 
MST


