Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F673F99365
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtU-0006LB-Mv; Thu, 23 Apr 2026 06:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtM-0006Iv-8u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtK-0001xW-KN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6632686f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938557; x=1777543357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DbK55rulsKaDcNgAtsD5u3wXEZM2mu5kv3ncCIfe2Yk=;
 b=YLSoPJo7/OczbEwKcIwvmXNOtRuWi/4g8h4Rq5tk17WDu2NxwjDODM04LhzTm8SdG+
 NrXA22CenWd983xdUH92ELGiy9IfHg2E92totN4it1TFBOFS2r3YTbTO95ojPiYXI779
 NPDqCzU5x6lQ0/zzZUr8Av+uz333bV4+san76Fxjlu+kf9F5vYFZDiV1gxjz3DJc+hI/
 iQBEsNyjd3BkHBdLln7cwuGL0mgFIRqZu4gJtwVuG4llki4QsI6hfgfs5vuM9qaEwFsN
 +JGW8gNtVVTB/9B5GKusj7A72R2H7PnKIQSbXyg8GHsvlcNakSL0x1od6Uc3tShqDs7y
 siLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938557; x=1777543357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DbK55rulsKaDcNgAtsD5u3wXEZM2mu5kv3ncCIfe2Yk=;
 b=AB4mGeyNE6Ac0+6D/jezsldX82coNPybX3PF1ELgraZNXsGpFuoC4LyczZQR/FgneX
 tztpp8VpVUn7QRWZ8czfu8OxJLqyP9TxAZtD00EnGyWngiuplJt3PdXAYxLD/QdDGa/0
 H8x9X7hzsvKsh1eDCf65O/YPrk6G4y4DuSSkSG3xPkkQgCCSY3c1MWW/b2iAZrYtSmXy
 vbFic027xEWtAg3WfQ6ubXBE/zwVMEFN5D9KOrvYPNFyXzOdVUbo9mjRQfVpOqbXAEkn
 AC6zXU4gmY3+ZWdnh7mdaVv0qqTceJYa+9n0+5QLth4NiC2aPYSImHarlqCcSGtKg3Ce
 UUtQ==
X-Gm-Message-State: AOJu0Yx7wOOihqSo7FGHpPQkFtgr3bDhNfJmaL91CM1cxRchnhjgILO4
 VsWuE9I6cHDmAnz40gx1EQwlnpwN1/mcpglpaQVzUnts4WxMgoAgQpzBPxM1s1RZWhE3MGOjOPp
 UShtu
X-Gm-Gg: AeBDievoFMx1SfCOSPKJn431j05Feucf51UkDBGDYjwe6jaAeqkZfOTLp8Z4ASDYFa4
 mtIBwz3Renzjx2BGuxeXSV2Aax3+NyCE7c1klDe3vKhmbKbKdsYeyjDYzubNAMP/XSPz7M08CBe
 YZgnXBb8K2Ru9qMJ9W07jzV1e+yAB91VkzT0i+HSChj2LsuOFJQfSd5wLe1AmfR3upNheC0Ty2a
 pFlw9kwg6G+Fk7jhdEhFFZPGS+VU8lp7Oq3QVYhdXohM6bCAYtJVvNQLjANVaGfkrIfW9xLkMSD
 msT3JafEfqHT6ZJP5I6rOK2/EIDdJtYlfmvysgPfxC7f/lkne/m29f+T/2Zs2vUavbidlYhcsx2
 Z5xbfKEQdFLTyFRUGCLUTKcrkwrPD45m3KFkQy/luK4+LTWe7XGsXs3WPD6x0emQVH5l+w0P+Sh
 1ROZswTSEhtjZYuu4BqUg8EgErOVYiwKquIiVuk/5AVl07HtLHhV+tEPuM1OR+nccNKB76xmy20
 2uYA2Ky3KOd5FP3TVmI9wmL+bW8eYUZHSDsTh5MEg==
X-Received: by 2002:a05:6000:420a:b0:43c:4810:dc4a with SMTP id
 ffacd0b85a97d-43fe3e14f81mr41168144f8f.38.1776938556401; 
 Thu, 23 Apr 2026 03:02:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/59] acpi: Add parameters to pass cache descriptions to ACPI
 build_pptt()
Date: Thu, 23 Apr 2026 11:01:35 +0100
Message-ID: <20260423100229.2941820-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Add optional parameters to pass cache descriptions to build_pptt().
Update ARM and Loongarch callers to pass none for now.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-id: 20260311160609.358-6-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/aml-build.c            | 3 ++-
 hw/arm/virt-acpi-build.c       | 2 +-
 hw/loongarch/virt-acpi-build.c | 4 ++--
 include/hw/acpi/aml-build.h    | 4 +++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4b37405088..b0ea8a5d5d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2155,7 +2155,8 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, CPUCoreCaches *caches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c..cd0700416e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1277,7 +1277,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id);
+                   vms->oem_id, vms->oem_table_id, 0, NULL);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 3e34bedcd6..a0b445f297 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -538,8 +538,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     build_madt(tables_blob, tables->linker, lvms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_pptt(tables_blob, tables->linker, machine,
-               lvms->oem_id, lvms->oem_table_id);
+    build_pptt(tables_blob, tables->linker, machine, lvms->oem_id,
+               lvms->oem_table_id, 0, NULL);
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e129719..e70e0643b1 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -3,6 +3,7 @@
 
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/core/cpu.h"
 
 #define ACPI_BUILD_APPNAME6 "BOCHS "
 #define ACPI_BUILD_APPNAME8 "BXPC    "
@@ -499,7 +500,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, CPUCoreCaches *caches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
-- 
2.43.0


