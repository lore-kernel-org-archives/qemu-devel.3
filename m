Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED8606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k3P9lMGL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoM9-0004iF-QY; Fri, 30 Oct 2026 11:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLo-0004T7-VN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:10 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLf-0008Th-Ba
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:00 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2022634c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373412; x=1793978212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPp4K8SpYewvoGkZt5YpU/W5aoKsUCXebK5ekrwOnQY=;
 b=k3P9lMGLfNIhD3ZBFsXwRWIqRI1o2V6hiXKxgRmuHfvAR+NMbO2UZvRk0Msh+U4PAy
 byvjhZ2JvOijeFlweJ/nlbV12EjPNubvh7yITCa5IqS6Lzidxdrm9PWmKMFqTeVgxTZx
 ctfkRvCnTW7Y4C8M/AGZ6iNGC6ef3ZcC5J6sSULl04Gd8i82tFc8n4W0oh73mtGm8S6+
 OKksdmIyVrcDqdKWMYCyQ3RIUZvPtf6GYhbgnzFiq+7wzHh/cr4b2IKuV7rbVD/nbl8L
 NJEkB3dUwjMuad60c4z1huvTFM805szaFvFvheqLEpz06ATllHVlChuLuxfrsMkHAfen
 q3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373412; x=1793978212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HPp4K8SpYewvoGkZt5YpU/W5aoKsUCXebK5ekrwOnQY=;
 b=yDmyHrTdEHUgjSV6MO4rQRRbkzaZlprFk7gvyJuRFOppTl4JfqvNCNR/54QBZ+m2rZ
 RnOceJwlnDAXQGOnm715LQgWucz9+yCXFJMLuAxtwdjC+vWYAsjolvX4ox59S0n3eMgI
 isGhlHtkB7FBWM3+FTgsQ2ScRX8QXSAkvrB6uBSPtArveo3ntF7SWJ6UBPN1aXwV418U
 X+x0O5pG60jqndg4q/15C4s6ULCrd9WN+9oAigxlO7rlRkpYZ4Vsfjuxt2FNHaRv3jcK
 JsKyCPQ7TUoebKhT96zZW8msjSUtjG/c2iRJS+0AiriLZvllA6LcJNYH+wnUGfWix+UY
 nVew==
X-Gm-Message-State: AFq9FYLOGaHgdW7D/K4v2fxOmYU+Rlz0mkEtCwKBESlPeB4Rq6gmjmfP
 MyNg1I8jaUgJOv9kVpsQFED0vY+Z5+/tfeGiN2GcmcFD9Q+jrEpQ8Z9SwBtFtVxz6g8=
X-Gm-Gg: AYBFou0NZg8aas9Oe4UIZTdk/L2Mae/ygamNjeuS3RdFos9zoTYvN9u0ksfuQCSGFaB
 LY/vuZeXQTRORMF7y+32C11wralYcNdhk8j3qM/3VvqdrsNKCy7sZck3JOen05rioaUxodoMX6Y
 i8cbIz6s2HC932+1AetqD8UH7ulHcRXcgo/yGbylrunLjXh8rJETaiKDQHujirZkg+TT/kYDeck
 j86l0e3mu/m6OT3Fg8BvLjHokevvQIe2GL8hnC11ZuSopICsbFTt0MukkwTFBE2cjc9xky0qToH
 2/pyD1cGWefr1E5ImvpGm7in8GEdrgYB+CPtEhJY7kmvHiyjoO9Rzzc6SmdIJ5lcHO/PxYy7q9U
 xw2hVAkdzDRFgGIVgJsPDOLtv7TvPJd3ekF6cwH8q01bwfMtKiuzNNi8V+xgzXmUEzEM6Sihjjv
 8yYtpCeT78vrQKJi1EmfELkCYv/Rbk4IZqPr4e0pfGgUOBZGe7uwXPlU2bs70SmPvaPTEUIMv6n
 d6A99D2XvrxJkmMA9CZK4cGttujtV5xbZMefLKXdTEbrRxRfQNZUdwvqUuoIa7wDrc7kRKXSfUi
 G+bQNxqRUq4CSybWjWx82pkl+2ONvLZnDVsbXwvDZJ2JfNtlf3ipCgct1THo//zdrDgmUQ==
X-Received: by 2002:a05:7022:120c:b0:164:8e14:4939 with SMTP id
 a92af1059eb24-1ac59dd190bmr3344211c88.10.1793373412205; 
 Fri, 30 Oct 2026 08:16:52 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:16:51 -0700 (PDT)
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
Subject: [PATCH 05/15] hw/arm: expand DEFINE_MACHINE for ARM machines
Date: Fri, 30 Oct 2026 23:15:26 +0800
Message-ID: <20261030151539.1872-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() and DEFINE_MACHINE_EXTENDED() to explicit
TypeInfo and type_register_static() calls for the ARM machine types,
reusing integratorcp_register_types() in hw/arm/integratorcp.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/bananapi_m2u.c      | 18 +++++++++++++++---
 hw/arm/cubieboard.c        | 19 +++++++++++++++----
 hw/arm/digic_boards.c      | 18 ++++++++++++++++--
 hw/arm/imx25_pdk.c         | 18 ++++++++++++++++--
 hw/arm/imx8mm-evk.c        | 20 ++++++++++++++++----
 hw/arm/integratorcp.c      | 14 ++++++++++----
 hw/arm/kzm.c               | 18 ++++++++++++++++--
 hw/arm/max78000fthr.c      | 17 +++++++++++++++--
 hw/arm/mcimx6ul-evk.c      | 18 ++++++++++++++++--
 hw/arm/mcimx7d-sabre.c     | 20 ++++++++++++++++----
 hw/arm/msf2-som.c          | 17 +++++++++++++++--
 hw/arm/netduino2.c         | 17 +++++++++++++++--
 hw/arm/netduinoplus2.c     | 17 +++++++++++++++--
 hw/arm/olimex-stm32-h405.c | 18 ++++++++++++++++--
 hw/arm/orangepi.c          | 19 +++++++++++++++----
 hw/arm/stm32vldiscovery.c  | 18 ++++++++++++++++--
 16 files changed, 243 insertions(+), 43 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index ccf60ba2955..ad30e34d718 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -133,8 +133,9 @@ static void bpim2u_init(MachineState *machine)
     arm_load_kernel(&r40->cpus[0], machine, &bpms->bootinfo);
 }
 
-static void bpim2u_machine_init(MachineClass *mc)
+static void bpim2u_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -152,5 +153,16 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, false, NULL)
+static const TypeInfo bpim2u_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("bpim2u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = bpim2u_machine_class_init,
+    .instance_size = sizeof(Bpim2uMachineState),
+};
+
+static void bpim2u_machine_register_types(void)
+{
+    type_register_static(&bpim2u_machine_typeinfo);
+}
+
+type_init(bpim2u_machine_register_types)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index e4fef9cd76b..66610d495bc 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -113,8 +113,9 @@ static void cubieboard_init(MachineState *machine)
     arm_load_kernel(&a10->cpu, machine, &cbs->bootinfo);
 }
 
-static void cubieboard_machine_init(MachineClass *mc)
+static void cubieboard_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a8"),
         NULL
@@ -132,6 +133,16 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
-                        cubieboard_machine_init, false, false,
-                        NULL)
+static const TypeInfo cubieboard_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("cubieboard"),
+    .parent     = TYPE_MACHINE,
+    .class_init = cubieboard_machine_class_init,
+    .instance_size = sizeof(CubieboardMachineState),
+};
+
+static void cubieboard_machine_register_types(void)
+{
+    type_register_static(&cubieboard_machine_typeinfo);
+}
+
+type_init(cubieboard_machine_register_types)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 90c19106ad0..49e71f71e97 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -136,8 +136,10 @@ static void canon_a1100_init(MachineState *machine)
     digic4_board_init(machine, &digic4_board_canon_a1100);
 }
 
-static void canon_a1100_machine_init(MachineClass *mc)
+static void canon_a1100_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Canon PowerShot A1100 IS (ARM946)";
     mc->init = &canon_a1100_init;
     mc->ignore_memory_transaction_failures = true;
@@ -145,4 +147,16 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
+static const TypeInfo canon_a1100_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("canon-a1100"),
+    .parent     = TYPE_MACHINE,
+    .class_init = canon_a1100_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void canon_a1100_machine_register_types(void)
+{
+    type_register_static(&canon_a1100_machine_typeinfo);
+}
+
+type_init(canon_a1100_machine_register_types)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a33050788c3..546d8002662 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -140,8 +140,10 @@ static void imx25_pdk_init(MachineState *machine)
     }
 }
 
-static void imx25_pdk_machine_init(MachineClass *mc)
+static void imx25_pdk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM i.MX25 PDK board (ARM926)";
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
@@ -149,4 +151,16 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
+static const TypeInfo imx25_pdk_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("imx25-pdk"),
+    .parent     = TYPE_MACHINE,
+    .class_init = imx25_pdk_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void imx25_pdk_machine_register_types(void)
+{
+    type_register_static(&imx25_pdk_machine_typeinfo);
+}
+
+type_init(imx25_pdk_machine_register_types)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6de0d9c4a2e..ba1b603081b 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -122,8 +122,10 @@ static const char *imx8mm_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mm_evk_machine_init(MachineClass *mc)
+static void imx8mm_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8MM EVK Board";
     mc->init = imx8mm_evk_init;
     mc->max_cpus = FSL_IMX8MM_NUM_CPUS;
@@ -133,6 +135,16 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
-                        imx8mm_evk_machine_init, false, false,
-                        NULL)
+static const TypeInfo imx8mm_evk_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("imx8mm-evk"),
+    .parent     = TYPE_MACHINE,
+    .class_init = imx8mm_evk_machine_class_init,
+    .instance_size = sizeof(Imx8mmEvkMachineState),
+};
+
+static void imx8mm_evk_machine_register_types(void)
+{
+    type_register_static(&imx8mm_evk_machine_typeinfo);
+}
+
+type_init(imx8mm_evk_machine_register_types)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b766edeeee1..9736795b243 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -691,8 +691,10 @@ static void integratorcp_init(MachineState *machine)
     arm_load_kernel(cpu, machine, &icms->bootinfo);
 }
 
-static void integratorcp_machine_init(MachineClass *mc)
+static void integratorcp_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
@@ -703,9 +705,12 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
-                        integratorcp_machine_init, false, false,
-                        NULL)
+static const TypeInfo integratorcp_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("integratorcp"),
+    .parent     = TYPE_MACHINE,
+    .class_init = integratorcp_machine_class_init,
+    .instance_size = sizeof(IntegratorcpMachineState),
+};
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
@@ -760,6 +765,7 @@ static const TypeInfo icp_ctrl_regs_info = {
 
 static void integratorcp_register_types(void)
 {
+    type_register_static(&integratorcp_machine_typeinfo);
     type_register_static(&icp_pic_info);
     type_register_static(&core_info);
     type_register_static(&icp_ctrl_regs_info);
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index e9cc53ce017..6196d40cb2e 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -129,12 +129,26 @@ static void kzm_init(MachineState *machine)
     }
 }
 
-static void kzm_machine_init(MachineClass *mc)
+static void kzm_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init)
+static const TypeInfo kzm_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("kzm"),
+    .parent     = TYPE_MACHINE,
+    .class_init = kzm_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void kzm_machine_register_types(void)
+{
+    type_register_static(&kzm_machine_typeinfo);
+}
+
+type_init(kzm_machine_register_types)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index ed50bb91979..33c1ccbd3c8 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -35,8 +35,9 @@ static void max78000_init(MachineState *machine)
                        0x00000000, FLASH_SIZE);
 }
 
-static void max78000_machine_init(MachineClass *mc)
+static void max78000_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -47,4 +48,16 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init)
+static const TypeInfo max78000_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("max78000fthr"),
+    .parent     = TYPE_MACHINE,
+    .class_init = max78000_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void max78000_machine_register_types(void)
+{
+    type_register_static(&max78000_machine_typeinfo);
+}
+
+type_init(max78000_machine_register_types)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 53d221b4a9a..a4cdaac1176 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -68,8 +68,10 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 }
 
-static void mcimx6ul_evk_machine_init(MachineClass *mc)
+static void mcimx6ul_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
@@ -78,4 +80,16 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+static const TypeInfo mcimx6ul_evk_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("mcimx6ul-evk"),
+    .parent     = TYPE_MACHINE,
+    .class_init = mcimx6ul_evk_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void mcimx6ul_evk_machine_register_types(void)
+{
+    type_register_static(&mcimx6ul_evk_machine_typeinfo);
+}
+
+type_init(mcimx6ul_evk_machine_register_types)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 55c23061b0a..5a868af6c1f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -76,8 +76,10 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 }
 
-static void mcimx7d_sabre_machine_init(MachineClass *mc)
+static void mcimx7d_sabre_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
@@ -87,6 +89,16 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
-                        mcimx7d_sabre_machine_init, false, false,
-                        NULL)
+static const TypeInfo mcimx7d_sabre_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("mcimx7d-sabre"),
+    .parent     = TYPE_MACHINE,
+    .class_init = mcimx7d_sabre_machine_class_init,
+    .instance_size = sizeof(Mcimx7dSabreMachineState),
+};
+
+static void mcimx7d_sabre_machine_register_types(void)
+{
+    type_register_static(&mcimx7d_sabre_machine_typeinfo);
+}
+
+type_init(mcimx7d_sabre_machine_register_types)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1372d7f628a..938ccab05c4 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -96,8 +96,9 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
                        0, soc->envm_size);
 }
 
-static void emcraft_sf2_machine_init(MachineClass *mc)
+static void emcraft_sf2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -108,4 +109,16 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
+static const TypeInfo emcraft_sf2_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("emcraft-sf2"),
+    .parent     = TYPE_MACHINE,
+    .class_init = emcraft_sf2_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void emcraft_sf2_machine_register_types(void)
+{
+    type_register_static(&emcraft_sf2_machine_typeinfo);
+}
+
+type_init(emcraft_sf2_machine_register_types)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 0db8798b4bd..3f95672670e 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -52,8 +52,9 @@ static void netduino2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduino2_machine_init(MachineClass *mc)
+static void netduino2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -65,4 +66,16 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init)
+static const TypeInfo netduino2_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("netduino2"),
+    .parent     = TYPE_MACHINE,
+    .class_init = netduino2_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void netduino2_machine_register_types(void)
+{
+    type_register_static(&netduino2_machine_typeinfo);
+}
+
+type_init(netduino2_machine_register_types)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 5ac0eb81637..169e7b80b3c 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -53,8 +53,9 @@ static void netduinoplus2_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void netduinoplus2_machine_init(MachineClass *mc)
+static void netduinoplus2_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -65,4 +66,16 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
+static const TypeInfo netduinoplus2_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("netduinoplus2"),
+    .parent     = TYPE_MACHINE,
+    .class_init = netduinoplus2_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void netduinoplus2_machine_register_types(void)
+{
+    type_register_static(&netduinoplus2_machine_typeinfo);
+}
+
+type_init(netduinoplus2_machine_register_types)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index de9ac4978ce..4e415a420c4 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -56,8 +56,10 @@ static void olimex_stm32_h405_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void olimex_stm32_h405_machine_init(MachineClass *mc)
+static void olimex_stm32_h405_machine_class_init(ObjectClass *oc,
+                                                 const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
@@ -71,4 +73,16 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+static const TypeInfo olimex_stm32_h405_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("olimex-stm32-h405"),
+    .parent     = TYPE_MACHINE,
+    .class_init = olimex_stm32_h405_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void olimex_stm32_h405_machine_register_types(void)
+{
+    type_register_static(&olimex_stm32_h405_machine_typeinfo);
+}
+
+type_init(olimex_stm32_h405_machine_register_types)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 18ed174032b..ec1d19b6034 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -111,8 +111,9 @@ static void orangepi_init(MachineState *machine)
     arm_load_kernel(&h3->cpus[0], machine, &opms->bootinfo);
 }
 
-static void orangepi_machine_init(MachineClass *mc)
+static void orangepi_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
@@ -132,6 +133,16 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
-                        orangepi_machine_init, false, false,
-                        NULL)
+static const TypeInfo orangepi_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("orangepi-pc"),
+    .parent     = TYPE_MACHINE,
+    .class_init = orangepi_machine_class_init,
+    .instance_size = sizeof(OrangePiMachineState),
+};
+
+static void orangepi_machine_register_types(void)
+{
+    type_register_static(&orangepi_machine_typeinfo);
+}
+
+type_init(orangepi_machine_register_types)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index d899a134b38..ab9116ccc1d 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -56,8 +56,10 @@ static void stm32vldiscovery_init(MachineState *machine)
                        0, FLASH_SIZE);
 }
 
-static void stm32vldiscovery_machine_init(MachineClass *mc)
+static void stm32vldiscovery_machine_class_init(ObjectClass *oc,
+                                                const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
@@ -68,4 +70,16 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
+static const TypeInfo stm32vldiscovery_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("stm32vldiscovery"),
+    .parent     = TYPE_MACHINE,
+    .class_init = stm32vldiscovery_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void stm32vldiscovery_machine_register_types(void)
+{
+    type_register_static(&stm32vldiscovery_machine_typeinfo);
+}
+
+type_init(stm32vldiscovery_machine_register_types)
-- 
2.55.0.windows.3


