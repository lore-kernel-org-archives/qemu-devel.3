Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A3FE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqcV-0007bD-GY; Sat, 07 Dec 2024 03:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcN-0007WZ-Qe; Sat, 07 Dec 2024 03:56:52 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcK-0002TJ-QB; Sat, 07 Dec 2024 03:56:51 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2C56E5C4B49;
 Sat,  7 Dec 2024 08:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE4C4CEEA;
 Sat,  7 Dec 2024 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733561805;
 bh=pgakqgvEh0nG6+NLZ9+IaRjALlaeiQhSzDCOXxqHdyA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IMh9DxJzdWA/AcMvDukZWxsyKZgm8GnQFY4r5kHTALUpL/hhob++GLnintJGSguI7
 402jdQ4hbLb+q6okpVBEAzjuMSQY1XjkaazAsThSWAGlShlu/JESb3+scUeh+Pa0Vn
 CXzkeLEWusIQQjuKtibsTy52ZNAqQ1Faz3wZ74RmPZM8IzZreoV7IG729XPcjQtjjy
 WPa4pJG+ytLsUrDZC1k7qJQ6Qn4ZdCbHUgEAl/55qQvR4eW5+67/xglFLqdCVRXrLS
 /qI342lxqC2RKCmNdwI5R/rp0YtA7jhkZgbM0BxjwSXeAJu+My3+BArPJZzP12v2ZW
 WO+HjO7w8rlag==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcF-00000005j5K-15Pl; Sat, 07 Dec 2024 09:56:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 13/16] acpi/ghes: better name the offset of the hardware
 error firmware
Date: Sat,  7 Dec 2024 09:54:19 +0100
Message-ID: <20b003136d8c008fd54e8d40c806f13867336e13.1733561462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733561462.git.mchehab+huawei@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

The hardware error firmware is where HEST error structures are
stored. Those can be GHESv2, but they can also be other types.

Better name the location of the hardware error.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 4 ++--
 hw/acpi/ghes.c                 | 4 ++--
 include/hw/acpi/ghes.h         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 663d9cb09380..17baf36132a8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.hw_error_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 52c2b69d3664..90d76b9c2d8c 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
 
     /* Create a read-write fw_cfg file for Address */
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
+        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
     ags->present = true;
 }
@@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
+    start_addr = le64_to_cpu(ags->hw_error_le);
 
     start_addr += source_id * sizeof(uint64_t);
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 21666a4bcc8b..39619a2457cb 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,7 +65,7 @@ enum {
 };
 
 typedef struct AcpiGhesState {
-    uint64_t ghes_addr_le;
+    uint64_t hw_error_le;
     bool present; /* True if GHES is present at all on this board */
 } AcpiGhesState;
 
-- 
2.47.1


