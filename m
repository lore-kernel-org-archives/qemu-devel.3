Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0668CCEB2C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOd3-0003NE-UA; Mon, 30 Sep 2024 18:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOd2-0003MF-Ng
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOd1-0002fi-0s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so558028366b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734345; x=1728339145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grjpT5kTsMGjq3j1/lhkj4QBsxYe83DKBpMh5569Dgk=;
 b=oSF4xcxeKpE9rOxFKXgwYX/rgsKqXmEebX3rX+TPysuaXUbwll4HfpAr9tDt8ugRZ1
 QbLlLPuC5APuBkiiEpF71ap/Ry8PeWohncBn0Dw4FekV78+YuDOwkMfyz9fotNg1RGb7
 Av2+7KEB9zVA+M/TWs+JLLhQ27RGKjjUxRnem1Bwmqy7oc4vuHoeluQHBXQTLgbcWtP/
 yMtfv8an3VCF5hAHWco6y3J2bdXCSsv68umCbCp9+1M0OwrknQxkyMZfsSQbQt49iZmd
 PBTP8BoXKiojN3ghkZzU1eyfeX2XoXuyVWEkAtaXA3gwt5uNYUlGqSnGh7vpJfgeWNWT
 0Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734345; x=1728339145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grjpT5kTsMGjq3j1/lhkj4QBsxYe83DKBpMh5569Dgk=;
 b=OKi7Zl/qH9HKov04XGwsy6ohN+34NO/+Bu1YrrHDPcuZjyHzC3UocdSBh8O6HbjeT+
 gkltoAiXeuf69ekI0N91TjeICiX4QQ2I8KifVwhXWfucUT+9rvZlw5o7ioDaUVLbhjWD
 povbnMxt0nGuH69tdmFln32o1kiPyTvjhfx3mSkC1UTBEI8lZVLwPpcNDzBwwkliXQ1x
 K8hAqtD2cOpgvlfvmxEMxxnoDS841wbgr8J74YJtYfMBh+dhDp4doD8XfFfWo7SaZ99n
 muTuv5FgYBR2EXiAkDuO8WV+ntDRi5SNxykFvcIUStwxxz0xAr7t0pacj6/wHJMmLimn
 vZXQ==
X-Gm-Message-State: AOJu0YzYAcvJACtVIf3nvTUxS7lPfJbu8ra8Jgp+oLKaKw4DosfDogbG
 MJjtX7WYgd3hTlZG2o4HGGSLls1qVPcKYNj1qdl9JuJ2mvkLK+jaBlkxxNFutwT3lkf6TLNyi1L
 DnIE=
X-Google-Smtp-Source: AGHT+IEPcXLt1smhJ29KzmCwdkPXbe7bSABmFoFrN9SDqqX5WbSIEsUbxQdEZD9tZa3e3hF5oGDGhA==
X-Received: by 2002:a17:907:928b:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a93c48f0902mr1722277466b.1.1727734344660; 
 Mon, 30 Sep 2024 15:12:24 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c299ac60sm596492866b.221.2024.09.30.15.12.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:12:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Laurent Vivier <laurent@vivier.eu>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 2/3] hw/arm: Have arm_write_bootloader() take a ARMCPU argument
Date: Tue,  1 Oct 2024 00:12:03 +0200
Message-ID: <20240930221205.59101-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930221205.59101-1-philmd@linaro.org>
References: <20240930221205.59101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The next commit will replace tswap32() calls by stl_endian_p()
ones in bootloader.c. In order to do that, we'll need to know
the vCPU endianness. This information is retrievable with
arm_cpu_code_is_big_endian(), but we need to access CPUARMState.
As a first step, pass ARMCPU as argument to arm_write_bootloader()
so it'll be able to access cpu->env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/boot.h | 9 ++++++---
 hw/arm/aspeed.c       | 3 +--
 hw/arm/boot.c         | 9 +++++----
 hw/arm/raspi.c        | 4 ++--
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d742..3d1226ab00 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -206,13 +206,15 @@ typedef struct ARMInsnFixup {
 /**
  * arm_write_bootloader - write a bootloader to guest memory
  * @name: name of the bootloader blob
- * @as: AddressSpace to write the bootloader
+ * @cpu: handle to the first CPU object
+ * @info: handle to the boot info struct
  * @addr: guest address to write it
  * @insns: the blob to be loaded
  * @fixupcontext: context to be used for any fixups in @insns
  *
  * Write a bootloader to guest memory at address @addr in the address
- * space @as. @name is the name to use for the resulting ROM blob, so
+ * space returned by @arm_boot_address_space().
+ * @name is the name to use for the resulting ROM blob, so
  * it should be unique in the system and reasonably identifiable for debugging.
  *
  * @insns must be an array of ARMInsnFixup structs, each of which has
@@ -228,7 +230,8 @@ typedef struct ARMInsnFixup {
  * the entries that @insns refers to.
  */
 void arm_write_bootloader(const char *name,
-                          AddressSpace *as, hwaddr addr,
+                          ARMCPU *cpu, const struct arm_boot_info *info,
+                          hwaddr addr,
                           const ARMInsnFixup *insns,
                           const uint32_t *fixupcontext);
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cf0c6c580b..cf5fb92238 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -217,7 +217,6 @@ struct AspeedMachineState {
 static void aspeed_write_smpboot(ARMCPU *cpu,
                                  const struct arm_boot_info *info)
 {
-    AddressSpace *as = arm_boot_address_space(cpu, info);
     static const ARMInsnFixup poll_mailbox_ready[] = {
         /*
          * r2 = per-cpu go sign value
@@ -244,7 +243,7 @@ static void aspeed_write_smpboot(ARMCPU *cpu,
     };
     static const uint32_t fixupcontext[FIXUP_MAX] = { 0 };
 
-    arm_write_bootloader("aspeed.smpboot", as, info->smp_loader_start,
+    arm_write_bootloader("aspeed.smpboot", cpu, info, info->smp_loader_start,
                          poll_mailbox_ready, fixupcontext);
 }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318..6efd21f9c2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -131,10 +131,12 @@ static const ARMInsnFixup smpboot[] = {
 };
 
 void arm_write_bootloader(const char *name,
-                          AddressSpace *as, hwaddr addr,
+                          ARMCPU *cpu, const struct arm_boot_info *info,
+                          hwaddr addr,
                           const ARMInsnFixup *insns,
                           const uint32_t *fixupcontext)
 {
+    AddressSpace *as = arm_boot_address_space(cpu, info);
     /* Fix up the specified bootloader fragment and write it into
      * guest memory using rom_add_blob_fixed(). fixupcontext is
      * an array giving the values to write in for the fixup types
@@ -185,7 +187,6 @@ static void default_write_secondary(ARMCPU *cpu,
                                     const struct arm_boot_info *info)
 {
     uint32_t fixupcontext[FIXUP_MAX];
-    AddressSpace *as = arm_boot_address_space(cpu, info);
 
     fixupcontext[FIXUP_GIC_CPU_IF] = info->gic_cpu_if_addr;
     fixupcontext[FIXUP_BOOTREG] = info->smp_bootreg_addr;
@@ -195,7 +196,7 @@ static void default_write_secondary(ARMCPU *cpu,
         fixupcontext[FIXUP_DSB] = CP15_DSB_INSN;
     }
 
-    arm_write_bootloader("smpboot", as, info->smp_loader_start,
+    arm_write_bootloader("smpboot", cpu, info, info->smp_loader_start,
                          smpboot, fixupcontext);
 }
 
@@ -1128,7 +1129,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        arm_write_bootloader("bootloader", as, info->loader_start,
+        arm_write_bootloader("bootloader", cpu, info, info->loader_start,
                              primary_loader, fixupcontext);
 
         if (info->write_board_setup) {
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40d..84fffe2a02 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -137,7 +137,7 @@ static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
     QEMU_BUILD_BUG_ON((BOARDSETUP_ADDR & 0xf) != 0
                       || (BOARDSETUP_ADDR >> 4) >= 0x100);
 
-    arm_write_bootloader("raspi_smpboot", arm_boot_address_space(cpu, info),
+    arm_write_bootloader("raspi_smpboot", cpu, info,
                          info->smp_loader_start, smpboot, fixupcontext);
 }
 
@@ -172,7 +172,7 @@ static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
         0, 0, 0, 0
     };
 
-    arm_write_bootloader("raspi_smpboot", as, info->smp_loader_start,
+    arm_write_bootloader("raspi_smpboot", cpu, info, info->smp_loader_start,
                          smpboot, fixupcontext);
     rom_add_blob_fixed_as("raspi_spintables", spintables, sizeof(spintables),
                           SPINTABLE_ADDR, as);
-- 
2.45.2


