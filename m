Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCE3C9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVW-0000mG-6e; Sat, 26 Sep 2026 03:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSO-0005hQ-F4
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:25 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSK-0000jR-AY
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:23 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-34182b58d00so864397eec.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406257; x=1791011057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cvIXglGfRA1jXahprL6v2Lr8S2XJ1LC0LkB99mN9UQ=;
 b=g8HP5f8Y3E3rv9A4nPR1P6S3rkakcXp0sTY0h2Y3LyOZKlGiBw9BFBO2fe3/prTLgY
 xCSZtBRbaGi071H+Sb1VdTaa6f8737jqdtjBtyqkHrRbNifszl+OWBKUI267XsBt4Qen
 EA9wPyk6ut+VFfTrB9qEcxkKtXOnz8ggrqCsoqW/R/JeWoExHFEcvp2ZCglgaRvqDbmO
 xySBTCxuae6OiY4hPGuRvRdj5Ta/gw9UzamzGEjReKsaMNZzscKbCY+pUCttSx0KNX7i
 iJg39S71cn6CMy5X0egTOGpETI4mElTqnlXz7reNmefWVJP4+EQ8eEI+QsF8B509Nfup
 XULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406257; x=1791011057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cvIXglGfRA1jXahprL6v2Lr8S2XJ1LC0LkB99mN9UQ=;
 b=e2EgtzAPScW+894KG5u5dgYF0FYrEEEz0ayBg3xNniz+3mqF53O0mmE7Xc+b19pVTw
 /IYto5F+cGtbQJSggIxYZCfElqagI31efIC4++4IV4pXCPTWGjKwj8ImhE1i3l5czqEO
 1et9/mTPjVg8DANIXo9s9wunihzFXNayA5b475LU3CJlvhiB/iQJVruMdP5KQFx1kvyc
 wdEn56PVQ25/BalXUw3j6v9MkxDUI8Arm0U3kWXdGXdFPvyYJfFRofc22A9SNwjQx8lZ
 xbRYvKrbUH/aDRUAVBkRlWl/4YW6b/dKMlbkaTy9q8sRlNG7Zzm2esFbBx4UrXS9Ta41
 cMng==
X-Gm-Message-State: AFuF++kRMRAd1kIRvBupNjERU15rMw0JYyPw2HCzwLPL1VglNTxlRSMT
 Y++A1pTlb/4KwhOGMgVxdQWNNVmHpqF6Zs/OOPavKlUgi7QMlyoVQQQ1yrP7jzXT
X-Gm-Gg: AYBFou1PXT0N8dTC1WpYvJ1XmrLWJPFNHjLG8WUoCQH8WbJ8UuYFYwLPOncvw2UNvOT
 SALH1pkBTd3T9wEBYYkhyRdyo2qEDLABK9ge8GnE4hLKAC3H+TaBoHV33ZUOtx8c3oH7Zq2VSsm
 IgTsUo8vBBG7cOJrORs98egil49sVKrxtIjlFl5Oh+NXzsQJcTxbpeQNyU33cYPv/m0HxhKZHmV
 dwXFo+k0nh3Em0LmriRBO8MWk3CXvaOmRs3xCVG/4lpM10GC7Tgd6LdtTWdEgn9RqNqZkartw0B
 nnJj9n3yG9Y3/dwUcsWrecGrtxupXwrQDzukjesUfBnTc+7rvzcRfKPw9X5W2XbHXlR1unIZCPI
 4vvY0TcrpIV+0/ABy1YkFRhA1N3LkKkNuXWZpPl476IthgibG4Wn7HYhe5NbO6zQe4ouxStT/FV
 xhn6ir+B2MiS88zRl17Va2YELE0Kqem0fV478xVLkcV8WnDwoA03hdceiJDGSLG7TqBjsH0lXSs
 vnhC/5wPC3YwgJDAbpwRTvWs+61sHc=
X-Received: by 2002:a05:7300:8a24:b0:33c:c0e:76ec with SMTP id
 5a478bee46e88-342742360a7mr2334739eec.35.1790406256679; 
 Sat, 26 Sep 2026 00:04:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:04:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 49/55] hw/microblaze: expand petalogix-ml605 and
 xlnx-zynqmp-pmu to TypeInfo
Date: Sat, 26 Sep 2026 15:00:48 +0800
Message-ID: <20260926070057.1234-50-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace DEFINE_MACHINE with TypeInfo. Rename *_machine_init to
*_machine_class_init and set is_available to target_is_microblaze.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_ml605_mmu.c | 19 +++++++++++++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c     | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8f9f54ff1e2..508a8005a63 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "target/microblaze/cpu.h"
@@ -214,10 +215,24 @@ petalogix_ml605_init(MachineState *machine)
 
 }
 
-static void petalogix_ml605_machine_init(MachineClass *mc)
+static void petalogix_ml605_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
+static const TypeInfo petalogix_ml605_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("petalogix-ml605"),
+    .parent = TYPE_MACHINE,
+    .class_init = petalogix_ml605_machine_class_init,
+    .is_available = target_is_microblaze,
+};
+
+static void petalogix_ml605_machine_class_init_register_types(void)
+{
+    type_register_static(&petalogix_ml605_machine_class_init_typeinfo);
+}
+
+type_init(petalogix_ml605_machine_class_init_register_types)
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 00154236bf8..79b70eb5ad7 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
@@ -179,10 +180,24 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                            NULL);
 }
 
-static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
+static void xlnx_zynqmp_pmu_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
+static const TypeInfo xlnx_zynqmp_pmu_machine_class_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("xlnx-zynqmp-pmu"),
+    .parent = TYPE_MACHINE,
+    .class_init = xlnx_zynqmp_pmu_machine_class_init,
+    .is_available = target_is_microblaze,
+};
+
+static void xlnx_zynqmp_pmu_machine_class_init_register_types(void)
+{
+    type_register_static(&xlnx_zynqmp_pmu_machine_class_init_typeinfo);
+}
+
+type_init(xlnx_zynqmp_pmu_machine_class_init_register_types)
-- 
2.52.0.windows.1


