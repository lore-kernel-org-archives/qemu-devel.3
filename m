Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37443606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jEnz7967
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAv6-0005xu-S8; Thu, 19 Nov 2026 17:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv5-0005xP-0f
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:55 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv3-0004HB-5L
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:54 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22948411ED;
 Thu, 19 Nov 2026 22:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F99B1F000C0;
 Thu, 19 Nov 2026 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795128472;
 bh=qkTTHzbndTOnU3nRwO4Bp5hsQbpw1O0YqHKUKlELLl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jEnz7967n1Df9laYgoNksxinswpmXxG5/CXkxpjjWmJfR/KtoE66N+m8IqPzSQXqa
 Yu64/NPQH3eIUKCWriZS3pcdF5JL+QsQG9r3lHUfDTqvZl9u8TEwUOY+LZxmpqZJJI
 RZURfPJ8yu/wrwVSX2nyzDc8zigQ33aq+0co0XfrmsnIiFvY7qA7vLlxWG5tRQLq32
 bvHjsGmWRFdrlIe5TW7rEM4UgJajrlQQVMYJgIqxWGGmGKlDQZIN110F3syMPj8nWg
 fgQXFyknJCmzmpT8Q1OIMDNgCpYimzGEKTXrDXQHPesAT44n3kVjDB9OhGMiWA43VY
 yqOk3VBgsd1lg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/4] Revert "target/hppa: Move emulated power button into CPU
 I/O region"
Date: Thu, 19 Nov 2026 23:47:43 +0100
Message-ID: <20261119224744.31309-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119224744.31309-1-deller@kernel.org>
References: <20261119224744.31309-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

This reverts commit a524a188c0c01cc39d4af518ee7a39addcdc1091.

NetBSD 9.4, 10.1, 10.2 and 11.1 panic at boot on -M 715: power0 cannot
map the power switch register inside the CPU I/O page, and its polling
thread then reads through a NULL mapping.  HP-UX 9.05 is handled by a
BTLB entry for the power button page instead.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 13 ++++---------
 target/hppa/cpu.h |  2 --
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8a3f673daf..f23936fc5b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,6 +50,7 @@ struct HppaMachineState {
 
 #define MIN_SEABIOS_HPPA_VERSION 26 /* require at least this fw version */
 
+#define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
@@ -122,7 +123,6 @@ static time_t rtc_ref;
 
 static uint64_t io_cpu_read(void *opaque, hwaddr addr, unsigned size)
 {
-    HPPACPU *cpu = opaque;
     uint64_t val = 0;
 
     switch (addr) {
@@ -132,8 +132,6 @@ static uint64_t io_cpu_read(void *opaque, hwaddr addr, unsigned size)
         break;
     case 8:             /* DebugOutputPort */
         return 0xe9;    /* readback */
-    case 16:            /* Power switch button */
-        return cpu->env.power_btn;
     }
     return val;
 }
@@ -141,7 +139,6 @@ static uint64_t io_cpu_read(void *opaque, hwaddr addr, unsigned size)
 static void io_cpu_write(void *opaque, hwaddr addr,
                          uint64_t val, unsigned size)
 {
-    HPPACPU *cpu = opaque;
     unsigned char ch;
     Chardev *debugout;
 
@@ -158,9 +155,6 @@ static void io_cpu_write(void *opaque, hwaddr addr,
             fprintf(stderr, "%c", ch);
         }
         break;
-    case 16:
-        cpu->env.power_btn = val;
-        break;
     }
 }
 
@@ -318,6 +312,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine,
         ram_max = FIRMWARE_START;  /* 3.75 GB (32-bit CPU) */
     }
 
+    soft_power_reg = translate(NULL, HPA_POWER_BUTTON);
+
     for (unsigned int i = 0; i < smp_cpus; i++) {
         g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
         g_autofree char *cflush_name = NULL;
@@ -352,11 +348,10 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine,
     /* RTC and DebugOutputPort on CPU #0 */
     cpu_region = g_new(MemoryRegion, 1);
     memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops,
-                          cpu[0], "cpu0-io-rtc", 3 * sizeof(uint64_t));
+                          cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
     memory_region_add_subregion(addr_space,
                                 translate(NULL, cpu[0]->env.cpu_hpa + 16),
                                 cpu_region);
-    soft_power_reg = translate(NULL, cpu[0]->env.cpu_hpa + 16 + 16);
 
     /* Main memory region. */
     if (machine->ram_size > ram_max) {
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 22f8a1727d..7b708a564b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -269,8 +269,6 @@ typedef struct CPUArchState {
 
     HPPATLBEntry tlb[HPPA_TLB_ENTRIES];
 
-    target_ulong power_btn;    /* virtual power button (0 = reboot) */
-
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-- 
2.54.0


