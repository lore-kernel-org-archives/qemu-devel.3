Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD84CC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001UA-Nx; Fri, 21 Aug 2026 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1K-0001FU-8H
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1I-0007aA-G4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso15561495e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310163; x=1787914963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0NxFCkEldwQjcxLWI46OxLZ680eyIUHopOPMJytmotE=;
 b=cTk99GGzURY4sACqdEgophtH8zcSEt9j++GyeayZYGxZGKDrC6qknRKTq/2/u3mBnc
 pwH/og8BXnV41O4oiGKRdjOT+Noat9kybiA5gQXKc5QIpajjuEfgn4xnfgp1nzPusRex
 NWoKrGelW+TnN2OGqK+1sU+sRpqndyOkWj1RB6CFrjh52ppZ3ic3rsUCGORkn+0WNPey
 dMEMV2pPNfb1ofoHhFh4dVmtNVnjer6bnw6rJ/2d3rcfx8G6/0tVA3oE/OFipWEpsu5X
 U/Cm57RZpgzRNjLsLTBkDZPTi6/pusTcZdC8H1hUzwzLhFSHOG1fLHGtZl5Oa8KoZ00z
 3Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310163; x=1787914963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0NxFCkEldwQjcxLWI46OxLZ680eyIUHopOPMJytmotE=;
 b=M3tcrf4x+b6tN+rL5EzdYRzpDyp7Y/KZ+3bpzX2NMvtH3nmzC+Mo0EkM4bNikwOjQ1
 +BKrL7GrdYG5zGUqh1qff4LOl+uEKh0TZ6HkYXzeRwO+NAGoFdso77veJdicrUoPPMgA
 tbLQ3vAa1d/d/i+z9i6NI3aG0bqQDjDwSnDhToPJoW+QmNUTt/3sIaZZs07sV26vuocP
 fGX53fRk+dkCyN8w3B+J6NWXiUX78tZunVsMsex60ZpvQEBOstMR2nD/lAIEj8LBGOSL
 Vl+e9thdqdy6qY1zEFhL7ZWorTkkVFpqb8YOY5l8C7QWL//Mbm0o6XbXltKqac7drbX9
 ncKg==
X-Gm-Message-State: AOJu0Ywsf6r9X6lFwRbTrAddSSSVWZzmVs/JW7baFc2tcC7qc4sZtzvb
 hH3KoAhzlR8J0lVdidZA5ICFmxE0feU6bMMjIvSdVMu8RJXV7uCLW86et2fN3xznxwcKB7NpOp0
 cTpNA
X-Gm-Gg: AR+sD11wFtseb3Gx+8s0afo6Wpqttlv7n+l1DqdfWA9gGtzxf07ye1Xh3+8X3JDA1eu
 4D+cFeQ2MlLAwrRzEJefAbDELFvRcYLf3RTxC/Cv1LuwpN/6sJvChTLUWuWlq1/D388feZzW+1Z
 x8/0ZYLovUiHuHNspPpidgj4vzi+vZS91vD9cHX/oXND9iKsblwoZz94wpqsDnJbhfQaSoWNaXB
 rXiWHVnGeND3W0tmli84kV9ql+PcUh/UIe9/yWrA8s7eKDThmktdSid2V0KkaBfZR7NCVW48BzV
 SoyTYsT+AHtyan+vnKRkdzbDU/IE3onf/fQHLBF1t9U3WDAp+QvZeTsxG585JWHU3YRFO5LJ074
 YcKn9BSKCQmR6B08JUv4WwIPYxkIy6jXpUIfUpnrSKSVCBvtxY3PfPnmYBZh2PnnepebdaN0fPG
 Xj5BrA6DxhQoP5U5MAav4oTl/4pNPAPD2txj+7u2AmnTUDX/QThNaUQZm8a/Xg437sAWmFaVS59
 6uQYr9/w+PnoSZ2kT9DZbbDs1LkgmbrYQcTl2bpzmKwLiZvjtglcnEaHubCmwKkzkN+qg==
X-Received: by 2002:a05:600c:4e94:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-499b9198005mr40901795e9.6.1787310162936; 
 Fri, 21 Aug 2026 04:02:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] hw/arm: sabrelite: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:59 +0100
Message-ID: <20260821110101.3971391-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing SabreliteMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260816131300.51799-19-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sabrelite.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 84bbc2f9798..140b2ecb9e2 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -25,18 +25,12 @@ struct SabreliteMachineState {
 
     FslIMX6State soc;
     CanBusState *canbus[FSL_IMX6_NUM_CANS];
+    struct arm_boot_info bootinfo;
 };
 
 #define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
 OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
 
-static struct arm_boot_info sabrelite_binfo = {
-    /* DDR memory start */
-    .loader_start = FSL_IMX6_MMDC_ADDR,
-    /* No board ID, we boot from DT tree */
-    .board_id = -1,
-};
-
 /* No need to do any particular setup for secondary boot */
 static void sabrelite_write_secondary(ARMCPU *cpu,
                                       const struct arm_boot_info *info)
@@ -110,13 +104,17 @@ static void sabrelite_init(MachineState *machine)
         }
     }
 
-    sabrelite_binfo.ram_size = machine->ram_size;
-    sabrelite_binfo.secure_boot = true;
-    sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
-    sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
+    /* DDR memory start */
+    s->bootinfo.loader_start = FSL_IMX6_MMDC_ADDR;
+    /* No board ID, we boot from DT tree */
+    s->bootinfo.board_id = -1;
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.secure_boot = true;
+    s->bootinfo.write_secondary_boot = sabrelite_write_secondary;
+    s->bootinfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &s->bootinfo);
     }
 }
 
-- 
2.43.0


