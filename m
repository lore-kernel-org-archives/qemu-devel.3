Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED969109B469
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YwV-0005dN-22; Tue, 31 Mar 2026 09:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwN-0005aQ-1J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwL-00046V-5F
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so1073704f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962927; x=1775567727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bw5zi+GqCLVgCNxjiWNzvFBMTLyZs23V3pNqG3hK1yo=;
 b=U8yAYFmmZWszi7FZHk8qdW6lgKnmjMC5voQ64W+I8M71co0UjdnA3aTo936xZPNG/Q
 dCvJ+UGVYX5nOghu2y51K/dr3qd6QmzSgWsmnA1V1S2BJS8+FBMGb6CExFPjVVYCbkG8
 ImuOKSGG4TXwrX44+mdOQqIoWFdVh7cGaGV3RxnaTTatoloRJi3d9LCQrYfljkWd0ory
 8clEXHdPulzZ89/BXS5ME4yG9lJU6bMRJ4X4eJ4JZwfGbGobIM9HbvHf7LEqzB1JGklj
 VqZG69mY7rUO5Q/BFxQKXqwVO/Rj3AXSj08Fs2U1kc+yhssF7orCNdn3s0TMdz5+v6vS
 Jfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962927; x=1775567727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bw5zi+GqCLVgCNxjiWNzvFBMTLyZs23V3pNqG3hK1yo=;
 b=ihVRO9spboOyTW4mA972anoJCnQAUQkV8eZm8CeaEO+LkIgaLuZPyscLsa6FEB8YIY
 4Qlyajsl9SwPAiFHBz4UnSFT5ZUyCFVNd7Mg2YBE1NPoz4hIbiokbqyFmt1a59m9S7YS
 gCE7EvyTsfKFvkqIEaB4DmEZGiNthbP6HuGMYnDNLjuWaIP83LnrAXwr9Ymxm7Gn1ksc
 VpwE6qcSJYU47MUa28FGnbZUfbzPUkUF97FTZtTL09buGmdpoWwNiNpf+BiRgj377cy6
 jOefdJ6WulDa9KtK+HghUMmAvT5FFhunF++aO1juB/EdRt7QQ5jjSCJDvWBAcyUBMqNJ
 qIFw==
X-Gm-Message-State: AOJu0YyzAd2sxrSH1xoBhcOzCUJICn7gbdkKOGOZDYesLhUmWK+4z1hW
 cQoikS+6fQG8P28jigiescxUPExDRtrDuk5rSUG1zgUdTPW60XlAB8gkyc8usWlbTTe3hOtq7AB
 4ixoVFDE=
X-Gm-Gg: ATEYQzyrPbY9tcUeM/kZA2Mrqi2gUKizL+PGVZfcgpIy7A5TUofXRdXWXEO2IKK8h5u
 PY3amU4sR2pMiTSOruCG16lkxjsUoXCjQldB+24ofGbxfhTZ46JXEwR8V0N5QB98LAhWksw/pEe
 LTFGSzsd7EeyWj0qELU5Xy7u7I9dZK9Q5Vd7JyKh1SWX6JPJKljlBNvX58ByArK072x+DekfCqd
 ZeLRCsVciMNL6AFXJxtz2gNFWDHaDbZ62ApZ67YZuZOPucY+//Sxrh+29144bJNv5eRLLikuq1A
 Mrk2cTVRnkkCt+o7hKiXy6JgqyyoZUerOiyodyBhnZqmoJWNX+w29Kx+dB8EG6gKrvsEoF+Is6n
 beZEuUqBg2V9bOUSiPMzpvHXO3jbob8t3X5yw2ptExg7H3xjAQTLSNn6sgX8M/8yZqkRtsuin0F
 a8W1MtY86jhDI85o8ocE4MZ+EKTFxhLZRBSf7CO+KxasMhllZqEQJv1FMvFQVj/67J8PQ=
X-Received: by 2002:a05:6000:178a:b0:43c:f49f:9b7d with SMTP id
 ffacd0b85a97d-43cf49f9cdemr20519067f8f.17.1774962926486; 
 Tue, 31 Mar 2026 06:15:26 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eb95fsm28884567f8f.12.2026.03.31.06.15.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:15:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] ppc/pnv: generate dtb after machine initialization is
 complete
Date: Tue, 31 Mar 2026 15:15:03 +0200
Message-ID: <20260331131514.21152-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Currently, the machine dtb is generated in pnv_init(), before all devices
are fully initialized. This can result in an incomplete dtb for the system,
as seen in bug [1].

Fix this by deferring dtb generation until machine initialization is complete,
using the machine_init_done_notifier hook.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260327124136.983955-1-shivangu@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 58 +++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 24f8843a409..90028f974da 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -111,6 +111,8 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         lpar_per_core;
+
+    Notifier     machine_init_done;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7e54b6bc604..524563dcfc2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -748,31 +748,10 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
 
 static void pnv_reset(MachineState *machine, ResetType type)
 {
-    PnvMachineState *pnv = PNV_MACHINE(machine);
-    IPMIBmc *bmc;
     void *fdt;
 
     qemu_devices_reset(type);
 
-    /*
-     * The machine should provide by default an internal BMC simulator.
-     * If not, try to use the BMC device that was provided on the command
-     * line.
-     */
-    bmc = pnv_bmc_find(&error_fatal);
-    if (!pnv->bmc) {
-        if (!bmc) {
-            if (!qtest_enabled()) {
-                warn_report("machine has no BMC device. Use '-device "
-                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
-                            "to define one");
-            }
-        } else {
-            pnv_bmc_set_pnor(bmc, pnv->pnor);
-            pnv->bmc = bmc;
-        }
-    }
-
     fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
@@ -984,6 +963,37 @@ static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
     return chip_id == 0 ? 1 * GiB : QEMU_ALIGN_DOWN(ram_per_chip, 1 * MiB);
 }
 
+static void pnv_machine_init_done(Notifier *notifier, void *data)
+{
+    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
+    MachineState *machine = MACHINE(pnv);
+    IPMIBmc *bmc;
+
+    /*
+     * The machine should provide by default an internal BMC simulator.
+     * If not, try to use the BMC device that was provided on the command
+     * line.
+     */
+    bmc = pnv_bmc_find(&error_fatal);
+    if (!pnv->bmc) {
+        if (!bmc) {
+            if (!qtest_enabled()) {
+                warn_report("machine has no BMC device. Use '-device "
+                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
+                            "to define one");
+            }
+        } else {
+            pnv_bmc_set_pnor(bmc, pnv->pnor);
+            pnv->bmc = bmc;
+        }
+    }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
+}
+
 static void pnv_init(MachineState *machine)
 {
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
@@ -1244,10 +1254,8 @@ static void pnv_init(MachineState *machine)
         pmc->i2c_init(pnv);
     }
 
-    if (!machine->fdt) {
-        machine->fdt = pnv_dt_create(machine);
-        _FDT((fdt_pack(machine->fdt)));
-    }
+    pnv->machine_init_done.notify = pnv_machine_init_done;
+    qemu_add_machine_init_done_notifier(&pnv->machine_init_done);
 }
 
 /*
-- 
2.53.0


