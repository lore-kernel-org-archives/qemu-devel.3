Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F3C52CDC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQJh-0005nF-KK; Mon, 29 Jul 2024 09:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJf-0005eX-Hl; Mon, 29 Jul 2024 09:21:31 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJd-00028x-2B; Mon, 29 Jul 2024 09:21:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C4C30CE0B2D;
 Mon, 29 Jul 2024 13:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1586FC4AF0F;
 Mon, 29 Jul 2024 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722259281;
 bh=c7zw+YFhj6uS64hOqzQNjWgop6AVDFMab3GmXvFntiw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DeTBCHM/uddoUM9+jRoKAADz4Zf0ML1GGk2xYwBmJ1SL/d9rUyZ/eJ0baswfpV3ci
 u9f/gIPg3lAG6rim+OsqcoYU8aSEgmfkj1Oiz6SSrNn/J3uhpDaVVUgjyK6pQjTo20
 Xc/9kd8D3vpEVZAnOavMc7bJk7oeyRsrZvoONkj3umL5QOIvkcMlIJWZEgmYKbhbI9
 dj3sY+VQcts1rFt3miM+5eN6W9LaeDOA4Xrz20dPtOUkpDgZlrePOPkkjx4XV3izP5
 3n4LcDmDSeQuxxrRO500jZKE8lD4gTpYCiA7aBDmDxc3PiqBHxY5F8H5PAhbErmuF3
 hM1SGa3ndqIdw==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYQJT-000000030Vf-0c7Q; Mon, 29 Jul 2024 15:21:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] acpi/ghes: update comments to point to newer ACPI specs
Date: Mon, 29 Jul 2024 15:21:08 +0200
Message-ID: <6771b76dbdf23317a3b1f432e467ee3478d83887.1722259246.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722259246.git.mchehab+huawei@kernel.org>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is one reference to ACPI 4.0 and several references
to ACPI 6.x versions.

Update them to point to ACPI 6.5 whenever possible.

There's one reference that was kept pointing to ACPI 6.4,
though, with HEST revision 1.

ACPI 6.5 now defines HEST revision 2, and defined a new
way to handle source types starting from 12. According
with ACPI 6.5 revision history:

	2312 Update to the HEST table and adding new error
	     source descriptor - Table 18.2.

Yet, the spec doesn't define yet any new source
descriptors. It just defines a different behavior when
source type is above 11.

I also double-checked GHES implementation on an open
source project (Linux Kernel). Currently upstream
doesn't currently handle HEST revision, ignoring such
field.

In any case, revision 2 seems to be backward-compatible
with revison 1 when type <= 11 and just one error is
contained on a HEST record.

So, while it is probably safe to update it, there's no
real need. So, let's keep the implementation using
an ACPI 6.4 compatible table, e. g. HEST revision 1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f71..8816af8280be 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -44,9 +44,9 @@
 #define GAS_ADDR_OFFSET 4
 
 /*
- * The total size of Generic Error Data Entry
- * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-343 Generic Error Data Entry
+ * The total size of Generic Error Data Entry before data field
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 Generic Error Data Entry
  */
 #define ACPI_GHES_DATA_LENGTH               72
 
@@ -58,8 +58,8 @@
 
 /*
  * Total size for Generic Error Status Block except Generic Error Data Entries
- * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
- * Table 18-380 Generic Error Status Block
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 Generic Error Status Block
  */
 #define ACPI_GHES_GESB_SIZE                 20
 
@@ -75,7 +75,8 @@ enum AcpiGenericErrorSeverity {
 
 /*
  * Hardware Error Notification
- * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ * ACPI 6.5: 18.3.2.9 Hardware Error Notification,
+ * Table 18.14 - Hardware Error Notification Structure
  * Composes dummy Hardware Error Notification descriptor of specified type
  */
 static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
@@ -105,7 +106,8 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
 
 /*
  * Generic Error Data Entry
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.12 - Generic Error Data Entry
  */
 static void acpi_ghes_generic_error_data(GArray *table,
                 const uint8_t *section_type, uint32_t error_severity,
@@ -141,7 +143,8 @@ static void acpi_ghes_generic_error_data(GArray *table,
 
 /*
  * Generic Error Status Block
- * ACPI 6.1: 18.3.2.7.1 Generic Error Data
+ * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
+ * Table 18.11 - Generic Hardware Error Source Structure
  */
 static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
                 uint32_t raw_data_offset, uint32_t raw_data_length,
@@ -286,15 +289,18 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
         0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
 }
 
-/* Build Generic Hardware Error Source version 2 (GHESv2) */
+/*
+ * Build Generic Hardware Error Source version 2 (GHESv2)
+ * ACPI 6.5: 18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10),
+ * Table 18.13: Generic Hardware Error Source version 2 (GHESv2)
+ */
 static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
 {
     uint64_t address_offset;
-    /*
-     * Type:
-     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
-     */
+    /* Type: (GHESv2 - Type 10) */
     build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
+
+    /* ACPI 6.5: Table 18.10 - Generic Hardware Error Source Structure */
     /* Source Id */
     build_append_int_noprefix(table_data, source_id, 2);
     /* Related Source Id */
@@ -335,11 +341,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
 
-    /*
-     * Read Ack Register
-     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
-     * version 2 (GHESv2 - Type 10)
-     */
+    /* ACPI 6.5: fields defined at GHESv2 table */
+    /* Read Ack Register */
     address_offset = table_data->len;
     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                      4 /* QWord access */, 0);
@@ -358,11 +361,16 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
     build_append_int_noprefix(table_data, 0x1, 8);
 }
 
-/* Build Hardware Error Source Table */
+/*
+ * Build Hardware Error Source Table
+ * ACPI 6.4: 18.3.2 ACPI Error Source
+ * Table 18.2: Hardware Error Source Table (HEST)
+ */
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
                      const char *oem_id, const char *oem_table_id)
 {
-    AcpiTable table = { .sig = "HEST", .rev = 1,
+    AcpiTable table = { .sig = "HEST",
+                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.45.2


