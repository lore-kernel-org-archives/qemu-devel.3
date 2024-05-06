Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA5BC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Ju-0007kD-O3; Mon, 06 May 2024 11:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jr-0007hw-DE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jo-0003RL-OQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 30A421800153;
 Mon,  6 May 2024 11:31:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 06 May 2024 11:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715009514;
 x=1715095914; bh=nPIbGPamlN+9KKqIN+ZYNQjFTgy446GDwC+t8kWt5Mo=; b=
 SU1pVRz5c/o04E/X/JByliBslJhzlKM+tTD3yrwnGCp49ncYw7tfR1Q0peVVBHkI
 y9YuEHh3L2jES6Wd+qxLoDOa0g5xQcChKlVCWzCS9qYQ7is3V74qWY8QCaATTYot
 XXLEyKqcqcFpfO2dKCy4RWNMRdxVLORqgKDX5K1v5y1ElMOGFZD14bDcOhrAcUt6
 i4Hos4ZyUGJPvzWc4Gz6S+DDzUZefxQQg1V+s7PJSQIBOw83X3tPGnbYeE/zG/B4
 /FwiivgakzSCQVdF3KHb3+gH8vPqEkTxiGxNgRcoSoHCA8HUl/qlgJ6vLGn5IgwC
 RtRsjrrEObihHdStNWwn2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715009514; x=
 1715095914; bh=nPIbGPamlN+9KKqIN+ZYNQjFTgy446GDwC+t8kWt5Mo=; b=N
 AKwTAZEBRSGe6n4t7CHZvE0q+VnsqImdiVgdUGw8VFhuuE0ARt3QAJb7Taq5Kppv
 mjGmpRvGHh2/oLjJr/M12X4MrLOpqc5qyJtYV4Ko88R8Vq1Swji7GLW/yk8ayBxl
 yjcKo0llzQRaCSfK7yacUHY6lK7+IKDfFnX84lA7envgGIs7ryczTCBdf2+Aeyro
 0ggHfWq7gg6ZJ7jXJn6vOteku55ImzWXNBkIjZ0Nt0jjn8bOSANQjZ0a7yeN74zL
 In5B6zo2QRB+EwNVV6XbWg8xvWwRcDO3QfgdBGCmGg90NOQaUkswTFITMv0iRSSy
 0qgRgy8vsLbMFOWHK0RcQ==
X-ME-Sender: <xms:6vc4ZqD6A1bbNJZgmgNRs_8Q06yITop_6-SOgs5sUMmld1yGuTTsWg>
 <xme:6vc4ZkiSU0Ywr-OzyssdekxQGSdO8Ke4xQiJvqWLnVEK743UCdRrUmsk5FF0nahzQ
 NFxKX3wCGHyvUpXw3I>
X-ME-Received: <xmr:6vc4ZtlQwkjkX3RYPPhTKkPI0T7a61clPa8crWrXJ46oFQ3VKWGFMIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6vc4ZozOTor1Zfcs9jlK_YwFKO6NtFM7zhg47GSVywnnM5R5WsuWNw>
 <xmx:6vc4ZvR9c77_9Raz3m7tyZajI344mZbi0r2wYVyLtX75QQSWwzAieA>
 <xmx:6vc4ZjZ1LBD4fcPIGWauzR5a1VM5VX9lBogKG2C0Hh6xZWuw0wxTeA>
 <xmx:6vc4ZoT9oSjh2Cp0q7pXAwoGd1TchczTKYWMaxCOh76hbI2d7Lho6Q>
 <xmx:6vc4ZpcL_hK-DotKrOI3J9qvyXTvVwukAQT7Z45qi_f10fFXbnn2-uaB>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 06 May 2024 16:31:38 +0100
Subject: [PATCH 4/5] hw/mips/cps: Implement multi core support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mips-smp-v1-4-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6178;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/FjpNTd8i6ZiVBgPVy4jFS2xatx8RS7XQ1Hw3unLW38=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL748PM0v6eK1lFHq3YKrZUlXOrc9mlD511q9NrOae6
 nL7cjJTRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkFR/DHx7LnpULs/+HzLp2
 /tflc1Y3ziSfdd9qGBgpE2SlzZa8tpGR4RbfoktF179eVZmbNEt6UoTIywOfVpaWemaefLxLwqn
 flRkA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Implement multiple physical core support by creating
CPU devices accorading to the new topology and passing
pcore/vp information to CPC and CMGCR sub-devices.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/cps.c         | 66 +++++++++++++++++++++++++++++++--------------------
 include/hw/mips/cps.h |  1 +
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 07b73b0a1f..6cf02379a9 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -73,31 +73,43 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (int i = 0; i < s->num_vp; i++) {
-        MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
-        CPUMIPSState *env = &cpu->env;
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
 
-        /* All VPs are halted on reset. Leave powering up to CPC. */
-        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
-                                 &error_abort);
+    for (int corenum = 0; corenum < s->num_pcore; corenum++) {
+        for (int vpid = 0; vpid < s->num_vp; vpid++) {
+            int vpnum = corenum * s->num_vp + vpid;
+            int32_t globalnumber = (corenum << CP0GN_CoreNum) | vpid;
 
-        /* All cores use the same clock tree */
-        qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
+            MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
+            CPUMIPSState *env = &cpu->env;
 
-        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
-            return;
-        }
+            /* All VPs are halted on reset. Leave powering up to CPC. */
+            object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                    &error_abort);
+
+            object_property_set_int(OBJECT(cpu), "globalnumber", globalnumber,
+                                    &error_abort);
+
+            /* All cores use the same clock tree */
+            qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
+
+            if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+                return;
+            }
+
+            g_assert(vpnum == CPU(cpu)->cpu_index);
 
-        /* Init internal devices */
-        cpu_mips_irq_init_cpu(cpu);
-        cpu_mips_clock_init(cpu);
+            /* Init internal devices */
+            cpu_mips_irq_init_cpu(cpu);
+            cpu_mips_clock_init(cpu);
 
-        if (cpu_mips_itu_supported(env)) {
-            itu_present = true;
-            /* Attach ITC Tag to the VP */
-            env->itc_tag = mips_itu_get_tag_region(&s->itu);
+            if (cpu_mips_itu_supported(env)) {
+                itu_present = true;
+                /* Attach ITC Tag to the VP */
+                env->itc_tag = mips_itu_get_tag_region(&s->itu);
+            }
+            qemu_register_reset(main_cpu_reset, cpu);
         }
-        qemu_register_reset(main_cpu_reset, cpu);
     }
 
     /* Inter-Thread Communication Unit */
@@ -119,8 +131,12 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_MIPS_CPC);
     object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
                             &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-pcore", s->num_pcore,
+                            &error_abort);
     object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
                             &error_abort);
+    object_property_set_link(OBJECT(&s->cpc), "gcr", OBJECT(&s->gcr),
+                            &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
         return;
     }
@@ -130,7 +146,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Global Interrupt Controller */
     object_initialize_child(OBJECT(dev), "gic", &s->gic, TYPE_MIPS_GIC);
-    object_property_set_uint(OBJECT(&s->gic), "num-vp", s->num_vp,
+    object_property_set_uint(OBJECT(&s->gic), "num-vp", s->num_vp * s->num_pcore,
                             &error_abort);
     object_property_set_uint(OBJECT(&s->gic), "num-irq", 128,
                             &error_abort);
@@ -141,16 +157,13 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, 0,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gic), 0));
 
-    /* Global Configuration Registers */
-    gcr_base = MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
-
-    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
+    gcr_base = GCR_BASE_ADDR;
+    object_property_set_uint(OBJECT(&s->gcr), "num-pcores", s->num_pcore,
+                            &error_abort);
     object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
                             &error_abort);
     object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0x800,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->gcr), "gcr-base", gcr_base,
-                            &error_abort);
     object_property_set_link(OBJECT(&s->gcr), "gic", OBJECT(&s->gic.mr),
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
@@ -164,6 +177,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 }
 
 static Property mips_cps_properties[] = {
+    DEFINE_PROP_UINT32("num-pcore", MIPSCPSState, num_pcore, 1),
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 04d636246a..ea184b46a9 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MIPSCPSState, MIPS_CPS)
 struct MIPSCPSState {
     SysBusDevice parent_obj;
 
+    uint32_t num_pcore;
     uint32_t num_vp;
     uint32_t num_irq;
     char *cpu_type;

-- 
2.34.1


