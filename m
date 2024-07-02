Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69117C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeDG-0004Rq-UA; Tue, 02 Jul 2024 10:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeD8-0003rd-Ls
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeD5-0000Ii-FB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXwifnBJIBh3zju1O5LT6q/8nalot/g3k4ePiwaH62E=;
 b=F2YtbeKtlfbvVH+Rhm3sVZhEFHJD8GYAPiQyZOFHQ2x49BzX6yZIRCzlyKKw30uf9tsis7
 ANBVJoV0R4+VKZdLk3btlU6hu2uPdQiUHg6qlcTEoeU1hXrddSckK7VZn5Y2leGZOBgEjc
 FyvuYW0OA4dlYiEmfcuLnRxeW8LaVcQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-D2-eDGZOPKiRW9xgmHuuCA-1; Tue, 02 Jul 2024 10:10:15 -0400
X-MC-Unique: D2-eDGZOPKiRW9xgmHuuCA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso196164f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929414; x=1720534214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXwifnBJIBh3zju1O5LT6q/8nalot/g3k4ePiwaH62E=;
 b=J/yx5TK6e8+dRn4tuEbyuYjL0ByLswJvTpAEO6B8RB1rK/G54IP8MHE384hRj49e/3
 rXddElMaMTXcyI01z7QHLLny7wwhJ6dmpPAttEcIIjLGa5GC37Y8nFoGAbsnpLQimoDW
 g7O0OXhszH7uCO8WrYQdJjt477JJ2g9w7h8sJ+jWWfCii8KEeOZOi4KWCvwgWNjG1Mm+
 796UFGTLA0tUdUW7yuZ+pZwXqGPDhxhp1VDH0K+f9y5KrOrI8MWv24Iclc4dBEWAKeCl
 yI+NlaXejIlsk1rOws0G4UQUhQA4F3ybdtJRF8zJjUiIMGIj7I63E8V10YBjFwgBHlPC
 /F4g==
X-Gm-Message-State: AOJu0YzYkO3zF0beSPdrcJ48avk3ovJUNstgyBxBs0vbH91p/V+WOhw9
 YI8QUpbpizy7nNhtJKlp1ivbBIw3ZbnNYNfWqlLji3r2ZvIw7p7q62WigdyiAJQdMgVKgv6OYRH
 AiYwNg5FTYR7itNsDtRZSe8S+pkV/fC6xhgpd9uVhkrDZY9950febjYmuUKti648I+q3W2h7mL4
 pnIfRPFXE95fj01Iw+2P0Sjtm4oqmHgw==
X-Received: by 2002:adf:ec03:0:b0:367:8e63:4da4 with SMTP id
 ffacd0b85a97d-3678e634fa5mr750890f8f.14.1719929413934; 
 Tue, 02 Jul 2024 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqLGWe/UUyKylroPMXaPCxn4iIPB7sy9r6J/5ObEupwkwci/2EZYqSuhXQD3gPzyaiRDSpg==
X-Received: by 2002:adf:ec03:0:b0:367:8e63:4da4 with SMTP id
 ffacd0b85a97d-3678e634fa5mr750849f8f.14.1719929413359; 
 Tue, 02 Jul 2024 07:10:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b099c72sm198300495e9.37.2024.07.02.07.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:12 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 62/91] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <9bad72efc04a87e595aec1e9ac0c43ae3c0ad695.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

It's observed that Linux kernel booting with the VM reports a "conflicting
mapping for input ID" FW_BUG.

The IORT doc defines "Number of IDs" to be "the number of IDs in the range
minus one", while virt-acpi-build.c simply stores the number of IDs in the
id_count without the "minus one". Meanwhile, some of the callers pass in a
0xFFFF following the spec. So, this is a mismatch between the function and
its callers.

Fix build_iort_id_mapping() by internally subtracting one from the pass-in
@id_count. Accordingly make sure that all existing callers pass in a value
without the "minus one", i.e. change all 0xFFFFs to 0x10000s.

Also, add a few lines of comments to highlight this change along with the
referencing document for this build_iort_id_mapping().

Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Message-Id: <20240619201243.936819-1-nicolinc@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 102e2da934..e10cad86dd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -209,12 +209,19 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+/*
+ * Append an ID mapping entry as described by "Table 4 ID mapping format" in
+ * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
+ * Document number: ARM DEN 0049E.f, Apr 2024
+ *
+ * Note that @id_count gets internally subtracted by one, following the spec.
+ */
 static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
                                   uint32_t id_count, uint32_t out_ref)
 {
-    /* Table 4 ID mapping format */
     build_append_int_noprefix(table_data, input_base, 4); /* Input base */
-    build_append_int_noprefix(table_data, id_count, 4); /* Number of IDs */
+    /* Number of IDs - The number of IDs in the range minus one */
+    build_append_int_noprefix(table_data, id_count - 1, 4);
     build_append_int_noprefix(table_data, input_base, 4); /* Output base */
     build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
     /* Flags */
@@ -305,8 +312,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
 
         /* Append the last RC -> ITS ID mapping */
-        if (next_range.input_base < 0xFFFF) {
-            next_range.id_count = 0xFFFF - next_range.input_base;
+        if (next_range.input_base < 0x10000) {
+            next_range.id_count = 0x10000 - next_range.input_base;
             g_array_append_val(its_idmaps, next_range);
         }
 
@@ -365,7 +372,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_int_noprefix(table_data, 0, 4);
 
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
     /* Table 17 Root Complex Node */
@@ -418,7 +425,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     } else {
         /* output IORT node is the ITS group node (the first node) */
-        build_iort_id_mapping(table_data, 0, 0xFFFF, IORT_NODE_OFFSET);
+        build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
     }
 
     acpi_table_end(linker, &table);
-- 
MST


