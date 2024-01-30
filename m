Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C92C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUr7b-0001a5-BT; Tue, 30 Jan 2024 11:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUr7Y-0001QA-UK
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:38:00 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rUr7V-0005pu-HA
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:38:00 -0500
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-lx7CQVTENWK2PYxOROMCVg-1; Tue,
 30 Jan 2024 11:37:48 -0500
X-MC-Unique: lx7CQVTENWK2PYxOROMCVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 517113C2E0B7;
 Tue, 30 Jan 2024 16:37:47 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 609D3ABFD;
 Tue, 30 Jan 2024 16:37:45 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 1/3] hw/i386: Add `\n` to hint message
Date: Tue, 30 Jan 2024 17:37:39 +0100
Message-ID: <20240130163741.145925-2-groug@kaod.org>
In-Reply-To: <20240130163741.145925-1-groug@kaod.org>
References: <20240130163741.145925-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

error_printf() doesn't add newlines.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c03..e990b0ae927f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2697,7 +2697,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                         " migration may not work",
                         tables_blob->len, legacy_table_size);
             error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.");
+                         " or PCI bridges.\n");
         }
         g_array_set_size(tables_blob, legacy_table_size);
     } else {
@@ -2709,7 +2709,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                         " migration may not work",
                         tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
             error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.");
+                         " or PCI bridges.\n");
         }
         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
     }
-- 
2.43.0


