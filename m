Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F029C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1G-0000zL-Jp; Fri, 21 Aug 2026 07:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN18-0000mw-Ac
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN16-0007XA-EE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so6245265e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310151; x=1787914951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s/wyPsdg26Mcr2gBRpwr42/AQikAx4ixxJ47kYT8ulc=;
 b=TMoAWOUenJl6+F+sSkr0y2ykgHPYdaghqCGFtMzkQ51nSbKByaT6IErC7odEreBCPq
 qpu8aiDcgA/6MYaNaY1mSPd2+LaT4DnMKvpj2R7X53eC7Sy+2v84jeD96wyHIPVZlQMP
 TFuj+jeRrwY8EzNW8RNwM6vPQT91Wy8y/CLtbNHkOhJ5TSF023fiqgVNbAsJTQxHgjff
 D6siQhl5EzdJUPZwnipvKQwsn+ZEceA7TzdSVO/HxxBj5s5f8tJBO/AudhhwT2ZBwLCF
 3CJ7Wz20QSU9CsJsARkOH9QSf9vzQuHsnMeGTmdumB0yWbuVl10488Fp7+N3FTCwakgH
 x9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310151; x=1787914951;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s/wyPsdg26Mcr2gBRpwr42/AQikAx4ixxJ47kYT8ulc=;
 b=qtHxnZVpaSNis2RtNTkloZ9k2tX246xeXEOrb11l9a6SszAWRYQ+o1yOOctRtOpo/u
 TUdqqD9FehRBsTs7I9J7YSkSxo4uZOuW40n9/QXVqAHJG5MI+zyU8iKf22Tpn2Ewmb1U
 5goEXDNMO89mMJyQyGm9WQIeoUfJ5Mt4LeWkzaScqAdPeSzNjA9hAhKDLoyldpFvsyLj
 olSD9A+Phd/fVB/N+RmsU81i715FF87UFatdWA/7mrKlmrlY6xO2hRapzf+/clvxyfsP
 Zxm97miw0LAb3xzT+P4gMim0XWIr8c0EavDLcM206uJjiFHZUdViSM1P9c4WO7IJQ/+V
 gkWQ==
X-Gm-Message-State: AOJu0YwmzLLmVJCt8mpENOSs/Bzw2ueS90nPaI/28AsS1PIE8K3V6Np5
 GxoxJxpQMRLVLls+0evnQXVlW/alwByiCpVFCksCHLtzROfyp/0lLDp1ZGrs7hp7aOoWYWq2r5D
 Iin7x
X-Gm-Gg: AR+sD11KTbzeBOBq3ERxdPtuG1xJJIv6Y1DMNSICgfIjQLcqaieLhAshajaEf+XJrOP
 Z2Ln+PMHggqmAwo2Ll4FN7TP86a3Gm7vmUzRrtAFNtbWe/pZPgEVQ3ZYMWML7lOVvg7GD7LWJqW
 4nDTwl2L5iwxQCfdoS/l6E8RdRhAxjRARgORN/BYrpHRPDEO/QkkwUclyOoDxGl4nTnYHiDD8pn
 mJNIlXJCcHDeloVZH4lg/1/GiFCiKntrETVWRc5iMD8cbn8qC13V4Wgo9sop5kyTY7eGl9j0/bZ
 +ccbo/GvmSiVu/TwFcV0Wpsxrp4FeFmuxxymp7XQ7K6Kyynh6B0NPX1eOKjLBmajC0GWinV8kpQ
 3zi4FLZx1JSJYQyzOtCE3gjTlpVXWv5z+Bp9+e1yE/7hDvoO26Bn50K/C7LEHVV7yupItbiCPSk
 AAk5u00jGIa3kymO2V8mOKAx3fSXTFZkMQ6ol3hyrxNxJ5VfrXodWbbDqv1/tOdjndxhxeU3Qzn
 WcYsyiYXZQCsRb/DyW0Jkk8SPXkUmHWudv6raB0iot+sqHXTeXscc3gn997y9LTl+9t5w==
X-Received: by 2002:a05:600c:c16f:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-499b82e894emr82868985e9.10.1787310150999; 
 Fri, 21 Aug 2026 04:02:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/43] hw/arm: exynos4_boards: Store boot info in the board
 state
Date: Fri, 21 Aug 2026 12:00:47 +0100
Message-ID: <20260821110101.3971391-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The Exynos4BoardState struct is already allocated per machine
instance, so move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260816131300.51799-7-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b8c9b618f8..b7decdb2c7f 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -49,6 +49,7 @@ typedef struct Exynos4BoardState {
     Exynos4210State soc;
     MemoryRegion dram0_mem;
     MemoryRegion dram1_mem;
+    struct arm_boot_info bootinfo;
 } Exynos4BoardState;
 
 static int exynos4_board_id[EXYNOS4_NUM_OF_BOARDS] = {
@@ -66,12 +67,6 @@ static unsigned long exynos4_board_ram_size[EXYNOS4_NUM_OF_BOARDS] = {
     [EXYNOS4_BOARD_SMDKC210] = 1 * GiB,
 };
 
-static struct arm_boot_info exynos4_board_binfo = {
-    .loader_start     = EXYNOS4210_BASE_BOOT_ADDR,
-    .smp_loader_start = EXYNOS4210_SMP_BOOT_ADDR,
-    .write_secondary_boot = exynos4210_write_secondary,
-};
-
 static void lan9215_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
@@ -113,14 +108,15 @@ static Exynos4BoardState *
 exynos4_boards_init_common(MachineState *machine,
                            Exynos4BoardType board_type)
 {
-    Exynos4BoardState *s = g_new(Exynos4BoardState, 1);
+    Exynos4BoardState *s = g_new0(Exynos4BoardState, 1);
 
-    exynos4_board_binfo.ram_size = exynos4_board_ram_size[board_type];
-    exynos4_board_binfo.board_id = exynos4_board_id[board_type];
-    exynos4_board_binfo.smp_bootreg_addr =
-            exynos4_board_smp_bootreg_addr[board_type];
-    exynos4_board_binfo.gic_cpu_if_addr =
-            EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
+    s->bootinfo.loader_start = EXYNOS4210_BASE_BOOT_ADDR;
+    s->bootinfo.smp_loader_start = EXYNOS4210_SMP_BOOT_ADDR;
+    s->bootinfo.write_secondary_boot = exynos4210_write_secondary;
+    s->bootinfo.ram_size = exynos4_board_ram_size[board_type];
+    s->bootinfo.board_id = exynos4_board_id[board_type];
+    s->bootinfo.smp_bootreg_addr = exynos4_board_smp_bootreg_addr[board_type];
+    s->bootinfo.gic_cpu_if_addr = EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
 
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
@@ -137,7 +133,7 @@ static void nuri_init(MachineState *machine)
     Exynos4BoardState *s = exynos4_boards_init_common(machine,
                                                       EXYNOS4_BOARD_NURI);
 
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static void smdkc210_init(MachineState *machine)
@@ -147,7 +143,7 @@ static void smdkc210_init(MachineState *machine)
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &s->bootinfo);
 }
 
 static const char * const valid_cpu_types[] = {
-- 
2.43.0


