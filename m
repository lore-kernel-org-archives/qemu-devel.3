Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29287606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kky5W2Ev
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoMj-0005I2-Hs; Fri, 30 Oct 2026 11:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMR-0004x6-2h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:47 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMO-00007f-Ba
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:42 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso88106eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373457; x=1793978257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGfzDRU1LJ6XJUC1FoxM7ZI/nsagUrCZ0XaVKskAYMY=;
 b=kky5W2EvPUOaj5JYr0Nh9nG5Hxdp0n7cqt69aoaov6YE/ZxHP7QpFvVlS6j23VJyrh
 +Y1sRP6q/PpD2yVSKlRAoTDFyrWJ8K71KldSPaH1z1/85SwiDLVSIeOA/R1APkEnAh/P
 AZ9UcDw1QBBTiHkAqy0N9VKKHQUM3wqBO6YkBB+WtxoXhs5Vwp3HtAmhBzDaRSuTnExs
 fU0SFq80K+EHMiMvOIPtRf4dFRr65tXmbipoBUxzQRZt8lip9cOBbOo11G6PBFxiIC9C
 3d2IopQVZw2AqG5upTdcv4I6+A7+ohZ/CzpPX6/Mr+DKkhJKn9GgREPeFEdSMIwNX25h
 74mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373457; x=1793978257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gGfzDRU1LJ6XJUC1FoxM7ZI/nsagUrCZ0XaVKskAYMY=;
 b=kkPsd8RM7NiehYKeN1p8LBe5uvdGZtU1aH07Zca6y6xpttMV69B6q+SW6qnbS1g1Zl
 74Loyk1pt94IeaxAMjYUvTW9dTX6gNrhlTHIOZCgVLT0veezKuf4fmblIpth82alOtNI
 Zaur/V7scYabJNt9gzXdIy60WJSCISDY9FF9X3ufx2otrUHpgjjMufntnSpHj177vYd+
 l9i3AhIfrfaEEqeEbhYZGP7LR9I+SH6oOaxOmxnqkb1ZfvR2m4qQQAR8B1FgREQPGHTo
 8SSOZ+9evobk2K+wuQBrVT30mioxD1K8hDIwE/iNusGbbE7GrgbZFnVS/H6xvxZbuhck
 vmkw==
X-Gm-Message-State: AFq9FYKnbtASuUdw2M+uabtDFjCyS5n3MF12t1zPwa9HM5w94vR3mAE6
 pad93Vz/d098lPbdwpPXV2vc9Z7siS2tIUUB3lOK34b51Ub1Ao8yagVucnBWKIAeRgM=
X-Gm-Gg: AYBFou1PgRhsBAUAYLA1zsQdvYid117QA0lEBQfIaHwj+k56F95KQ4l2IwUD2wJ21eZ
 qpkFpeb2sjuQhV+9zOQlIRTCmHL1oejQX6u5g7R4gG7xjLoqpPYA3UwbtrIRz7aaeQw3UZhsvuO
 5OXLl1g5mCXIMHPkqxu8EJSR7/QK6Y1LFTWC5kIG+jaPl4e3t/mjWoyEij3P8NdtP40Un1eUDnu
 BpOFBIzqkpccVHmEiwHGh0VtgsjFqImcXjQpSFbxQvH1ivNP8dqwGNa+63VfZJokdL4Y9DUPcgs
 1ufjUZzplFIBcTkCp2BruuExtfXnrbvbIxx7U8O/yx2m/pSZZsH2L23DQdX4P7Yb7kSaOiTTG7Z
 RtfQslWuVnXTeehGwNemkEQBcA1bIPlOAXsCFhYuDUts5zr8r/OWCZtPmaFg6gcdr2SyoQnnX0F
 nts/vlgQYaRm8tAycetkxbuCEBQrC8yqXHR7bZ5kYJgEGUKkHirrm5IgEsZ1s+capEFxb9GbxQQ
 PEjPoLo2+2+u7CgtWvj1I/9vpv8t+aVz0usdxS1rbOzbSvqa81WCSh0k5yd4AAxF5SqCex1oUtk
 JhAoR0N9gKEHRcYkX4QGeegcsdEeJdYqQ5LKOU4iSL1x5MeG
X-Received: by 2002:a05:701b:4589:b0:19b:39f4:88c9 with SMTP id
 a92af1059eb24-1ac5bbb487bmr3398481c88.10.1793373456937; 
 Fri, 30 Oct 2026 08:17:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:17:36 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 09/15] hw/ppc: expand DEFINE_MACHINE for PowerPC machines
Date: Fri, 30 Oct 2026 23:15:30 +0800
Message-ID: <20261030151539.1872-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() and DEFINE_MACHINE_EXTENDED() in the PowerPC
machine files to explicit TypeInfo and type_register_static() calls,
adding the pegasos base machine to pegasos_machine_types[] in
hw/ppc/pegasos.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/ppc/amigaone.c      | 18 ++++++++++++++++--
 hw/ppc/pegasos.c       | 21 ++++++++++++++-------
 hw/ppc/ppc440_bamboo.c | 18 ++++++++++++++++--
 hw/ppc/prep.c          | 18 ++++++++++++++++--
 hw/ppc/sam460ex.c      | 18 ++++++++++++++++--
 hw/ppc/virtex_ml507.c  | 18 ++++++++++++++++--
 6 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 2e94e80b569..3cd3e92d2d8 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -416,8 +416,10 @@ static void amigaone_init(MachineState *machine)
     }
 }
 
-static void amigaone_machine_init(MachineClass *mc)
+static void amigaone_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Eyetech AmigaOne/Mai Logic Teron";
     mc->init = amigaone_init;
     mc->block_default_type = IF_IDE;
@@ -427,4 +429,16 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_ram_size = 512 * MiB;
 }
 
-DEFINE_MACHINE("amigaone", amigaone_machine_init)
+static const TypeInfo amigaone_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("amigaone"),
+    .parent     = TYPE_MACHINE,
+    .class_init = amigaone_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void amigaone_machine_register_types(void)
+{
+    type_register_static(&amigaone_machine_typeinfo);
+}
+
+type_init(amigaone_machine_register_types)
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index fba2a558905..ffa63456320 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -732,8 +732,9 @@ static bool pegasos_setprop(MachineState *ms, const char *path,
     return true;
 }
 
-static void pegasos_machine_init(MachineClass *mc)
+static void pegasos_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(mc);
     VofMachineIfClass *vmc = VOF_MACHINE_CLASS(mc);
 
@@ -787,13 +788,19 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
 }
 
-DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
-                        pegasos_machine_init, true, false,
-                        (const InterfaceInfo[]) {
-                        { TYPE_PPC_VIRTUAL_HYPERVISOR },
-                        { TYPE_VOF_MACHINE_IF }, { } })
-
 static const TypeInfo pegasos_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("pegasos"),
+        .parent        = TYPE_MACHINE,
+        .class_init    = pegasos_machine_class_init,
+        .instance_size = sizeof(PegasosMachineState),
+        .abstract      = true,
+        .interfaces    = (const InterfaceInfo[]) {
+            { TYPE_PPC_VIRTUAL_HYPERVISOR },
+            { TYPE_VOF_MACHINE_IF },
+            { }
+        },
+    },
     {
         .name          = MACHINE_TYPE_NAME("pegasos1"),
         .parent        = TYPE_PEGASOS_MACHINE,
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2dde008b0e4..401f7bee572 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -256,8 +256,10 @@ static void bamboo_init(MachineState *machine)
     }
 }
 
-static void bamboo_machine_init(MachineClass *mc)
+static void bamboo_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "bamboo";
     mc->init = bamboo_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
@@ -265,4 +267,16 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("bamboo", bamboo_machine_init)
+static const TypeInfo bamboo_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("bamboo"),
+    .parent     = TYPE_MACHINE,
+    .class_init = bamboo_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void bamboo_machine_register_types(void)
+{
+    type_register_static(&bamboo_machine_typeinfo);
+}
+
+type_init(bamboo_machine_register_types)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2672eb9e7a7..4afc4e20c67 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -441,8 +441,10 @@ static void ibm_40p_init(MachineState *machine)
     }
 }
 
-static void ibm_40p_machine_init(MachineClass *mc)
+static void ibm_40p_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "IBM RS/6000 7020 (40p)",
     mc->init = ibm_40p_init;
     mc->max_cpus = 1;
@@ -456,4 +458,16 @@ static void ibm_40p_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("40p", ibm_40p_machine_init)
+static const TypeInfo ibm_40p_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("40p"),
+    .parent     = TYPE_MACHINE,
+    .class_init = ibm_40p_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void ibm_40p_machine_register_types(void)
+{
+    type_register_static(&ibm_40p_machine_typeinfo);
+}
+
+type_init(ibm_40p_machine_register_types)
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b13dd224ba1..934ae3874c3 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -509,8 +509,10 @@ static void sam460ex_init(MachineState *machine)
     boot_info->entry = entry;
 }
 
-static void sam460ex_machine_init(MachineClass *mc)
+static void sam460ex_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "aCube Sam460ex";
     mc->init = sam460ex_init;
     mc->block_default_type = IF_IDE;
@@ -519,4 +521,16 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_ram_id = "ppc4xx.sdram";
 }
 
-DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
+static const TypeInfo sam460ex_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sam460ex"),
+    .parent     = TYPE_MACHINE,
+    .class_init = sam460ex_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void sam460ex_machine_register_types(void)
+{
+    type_register_static(&sam460ex_machine_typeinfo);
+}
+
+type_init(sam460ex_machine_register_types)
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 09686360e16..2a4c8c9fc93 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -281,12 +281,26 @@ static void virtex_init(MachineState *machine)
     env->load_info = &boot_info;
 }
 
-static void virtex_machine_init(MachineClass *mc)
+static void virtex_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx Virtex ML507 reference design";
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
+static const TypeInfo virtex_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("virtex-ml507"),
+    .parent     = TYPE_MACHINE,
+    .class_init = virtex_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void virtex_machine_register_types(void)
+{
+    type_register_static(&virtex_machine_typeinfo);
+}
+
+type_init(virtex_machine_register_types)
-- 
2.55.0.windows.3


