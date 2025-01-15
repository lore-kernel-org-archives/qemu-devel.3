Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57558C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rl-0003il-Mb; Wed, 15 Jan 2025 13:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qJ-0007TA-E7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qF-0006wZ-FL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jusc2KOu8CYjh6OpTg0cDGaXqteaxjITOrBf0/V0A/Q=;
 b=IiF/sz3XYfmHb6Ljv6Ml2JY17KIiwuDdanwpJafBml/EPzjwA2Mdpey7ce5z9T16zC9VGC
 HO8BIxk431fzaJzmM6yXw0QHWnumbsX5gRSNhqzpB2mNDhWd8FNnLK9pteJCTCEfLSds/U
 b45r7F1YwiRE/2ohx3jqhLPjGb4thrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-8R_nRV4pMMyFnGihCQy_4Q-1; Wed, 15 Jan 2025 13:10:07 -0500
X-MC-Unique: 8R_nRV4pMMyFnGihCQy_4Q-1
X-Mimecast-MFC-AGG-ID: 8R_nRV4pMMyFnGihCQy_4Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436219070b4so33428605e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964606; x=1737569406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jusc2KOu8CYjh6OpTg0cDGaXqteaxjITOrBf0/V0A/Q=;
 b=f8YjMBlqZEfBVquz50Ex/RqdoIZFbtd0HM4v55xnTt2LbyUDtP5teidX0xLEyGnbfB
 cXwLsYOOmPzEiXFeVulWO/tQpnuUKziyT6+o7zEKXz2lYSROFqj6GXdG1+e35t8hXbw4
 WS/wTWvNJeYwbjAXoyjHvq4XbxifBJgw97mU4PknAEXdmABdUwAnkHpGgWqhOiZPTc8x
 5b+OGp1G7xol8vUKt+jqjuOizXmpF1pNaJHhB/SLLjFaQDkUP6vgMXwGhDjia0/F2EXD
 gEdpEYZ3wIKKk4erakzkgzWWOKkPTim5clibFDgfFx3Y2QN2NpxxrTUi92uuzhm+HUJY
 v0Mg==
X-Gm-Message-State: AOJu0Yy9tp163czLdyrhe6SEdPxMdKOC43BSb7UCFc3fTsLMDZy1w1iR
 TAJw8OeaNDSssniWz2p+1PvWzV3KCM5IkU2QJVez6mxNaOg1ewwzSj1Qmt2fuJQ4S2GV9kZgoL9
 e17snpTqoIlyeYvt3zB5CrQPUKq2n7Yul1hWawFxuBiDGMOBlzU5v3LqfTRlLlTeaY0ndIDGpCY
 pq+n35WnUz78BXt41aM7RlP8BlkMoDUw==
X-Gm-Gg: ASbGncuK/p2tyP5BfjMtvW64sdzgZO++D1T6mcWVicwzEyANI4KIxprCpqGrJ0GrZug
 J4RMYUk3HDu9N0mb/U67o0HMR6u8IJd6Mp/9qeNlxnVbVfyXJ7gZJr9Q4rnmsxRHWdeFgX4a71y
 +KNxieN0pIA/A5RRSqVoJxuQFVRm+ks8HyCFXJFxhOhI2FlyzjO8070idWRsKqdrMJbd+HD+9Pe
 +aQ6D5GvXJ37SCPRUz5ACFDkQ+w5RTnmsSlCe47tMiyLfghNN/B
X-Received: by 2002:a05:600c:a08b:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-436e26dda73mr234839525e9.24.1736964606403; 
 Wed, 15 Jan 2025 10:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+UcDHey3YB0GtuhXY5QsfCKDHAKeg3yXN/XZN/OL3wZvIhBOUPHNGcn6ffH9qMuK63nQxzA==
X-Received: by 2002:a05:600c:a08b:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-436e26dda73mr234839235e9.24.1736964606030; 
 Wed, 15 Jan 2025 10:10:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac712sm31122965e9.12.2025.01.15.10.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:05 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 30/48] acpi/ghes: better handle source_id and notification
Message-ID: <a85a3b729b3c31d8cc878017308997a8112655b2.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

GHES has two fields that are stored on HEST error source
blocks associated with notifications:

- notification type, which is a number defined at the ACPI spec
  containing several arch-specific synchronous and assynchronous
  types;
- source id, which is a HW/FW defined number, used to distinguish
  between different implemented sources.

There could be several sources with the same notification type,
which is dependent of the way each architecture maps notifications.

Right now, build_ghes_v2() hardcodes a 1:1 mapping between such
fields. Move it to two independent parameters, allowing the
caller function to fill both.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <133ff72ea1041fed7dbcf97b7a2b0f4dfacde31a.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4a6c45bcb4..29cd7e4d81 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
 }
 
 /* Build Generic Hardware Error Source version 2 (GHESv2) */
-static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+static void build_ghes_v2(GArray *table_data,
+                          BIOSLinker *linker,
+                          enum AcpiGhesNotifyType notify,
+                          uint16_t source_id)
 {
     uint64_t address_offset;
+
     /*
      * Type:
      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
@@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
         ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
 
-    switch (source_id) {
-    case ACPI_HEST_SRC_ID_SEA:
-        /*
-         * Notification Structure
-         * Now only enable ARMv8 SEA notification type
-         */
-        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
-        break;
-    default:
-        error_report("Not support this error source");
-        abort();
-    }
+    /* Notification Structure */
+    build_ghes_hw_error_notification(table_data, notify);
 
     /* Error Status Block Length */
     build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
@@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
 
     /* Error Source Count */
     build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
-    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+    build_ghes_v2(table_data, linker,
+                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
 }
-- 
MST


