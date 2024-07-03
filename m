Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B22FC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mt-0004rD-L9; Wed, 03 Jul 2024 18:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mq-0004fg-7e
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8me-0005iU-TW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXwifnBJIBh3zju1O5LT6q/8nalot/g3k4ePiwaH62E=;
 b=ZVTCsj1mlm79tsobKDPMb5xT4y3tuQkEReBQz+DGvCjpSw37h4QtXOJdScUUITYEXTUdVE
 EQjSvnVLMmOELlOyPIIS9rMnyAK6bHHi9AJwzT/bQ1m2SjT/qengMP5MN4fuJQ8X74qdYR
 iQ5O/OcgGRQTuu/2YCba7Yqgb2172kM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-biRXV3JaNEO04Rmtgfk6IQ-1; Wed, 03 Jul 2024 18:49:01 -0400
X-MC-Unique: biRXV3JaNEO04Rmtgfk6IQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-425685183edso104365e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046939; x=1720651739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXwifnBJIBh3zju1O5LT6q/8nalot/g3k4ePiwaH62E=;
 b=FAXtf+GH5J119YUN7j2pZ74wS1z5eyLAmV3JXsXq7AKCpX1QsMcedf09DQiqlQ2l43
 oAW0BsZdeIOOrX0JR7gcsXpauq6oUtNxrzwlpeoDBVLqJTTBSjzw2qNSl44PBE1edVVC
 lpoVVu2+CXuyGScaUXn3u+2iaGpy0pb0d5lkZovpuKEAlnLxRowFBA3I1u8h50wKqMwR
 oDxgrXCzCdAa5WTVmV4GaTXNY9DTUb1rqtG7bZIeBDz7EN7xueljd0EnOJGtT/uLvqb8
 wn2G4oW3nNTQD9x4SwIeQMGZ1JzffaQhd+PZRVM2ZEjbD1Hox4r8/5NLVBwZf72rqG56
 z4Ag==
X-Gm-Message-State: AOJu0YyctfvLwejaXw84eaTdF8F3B4wE+JvD10poT0F7acGEPLBIVR5g
 Q+yHulngYuEpZHg+7Pu9Fc/Ppn2NI3j8pAMLeukPdm4ghnwb5b924PVWBjAAuV1XURBDRBSwgwd
 VQZTEQjSqZDgP2kmmje85EcFOgZrgq7zzWMdHcfrowJtm20ar3xRAcxxB9yAVeRWCrohuazMe7E
 gvQXHRYvvPmnLWWpdA3BzaLmxl6NmE5w==
X-Received: by 2002:a05:600c:1d01:b0:424:a823:51d7 with SMTP id
 5b1f17b1804b1-4264a3d98edmr343105e9.5.1720046938874; 
 Wed, 03 Jul 2024 15:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSkQI1Qx2aVlbsBEWx5hEBMzJWxGE8eTgPoQwJ7lVZrkUmZoWytvo3wHaUROOtX8hQwMEaWQ==
X-Received: by 2002:a05:600c:1d01:b0:424:a823:51d7 with SMTP id
 5b1f17b1804b1-4264a3d98edmr342935e9.5.1720046937884; 
 Wed, 03 Jul 2024 15:48:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21d2adsm1174445e9.29.2024.07.03.15.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:57 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL v3 59/85] hw/arm/virt-acpi-build: Fix id_count in
 build_iort_id_mapping
Message-ID: <5786827f47a0721bb997ad3f653d2b843ba3fd76.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


