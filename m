Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFF606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HYzCWxEo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoMB-0004jP-G9; Fri, 30 Oct 2026 11:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLv-0004V1-5s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:14 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLq-0008UJ-W9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:10 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-170135e43c7so1229241c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373424; x=1793978224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8a2b4rCQZ/Ri0eDvVEGx78IoeAx/tMieqM2WVNnANN8=;
 b=HYzCWxEofrFoim3bt4ZLgV6v42AKGyv3H8RWtdxWXT+4ebON233iplDbnbqKnvmtkN
 4qRNXNwqPQ/vKHMFVVL+TB86X0v5iM6xCkimRM9BrrK2GezRHe6XkwjohYTb0z7DKFI+
 PxU/cMPlO96vnKt05mf20iiaQr3DWZ44VLCKztI9+Dhb98WghJpS3wqnFiKzMd5IDpSf
 smFcTJ3vz5uJZNty81YSxakb1QjHv+AAKEK1aPhxzELK3tYEmRZQpRAN5DMmSe014PYH
 AIg5OHPDk+R7r73mcWwlmruxGUkFU0z4LwEfnk6fPGzO8tGGbGQBUpckii0Tc6Q1A+/8
 d0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373424; x=1793978224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8a2b4rCQZ/Ri0eDvVEGx78IoeAx/tMieqM2WVNnANN8=;
 b=CpbX9C/hrSWexJnOwqFQHmEEs+ds5Ya9kVQLDy5t2DjS5HLQXGpX4qsEe4kkNf2utB
 AirVdLmWjYJJcM7edYFzG0vSKK7ehXf9wRgstBRk2GbQv+lmRqYw8cgRDIEC6JqQLr6g
 +NSYTRlkrtrVGp18PkuNZoojOS1oyUl8RMf6iVdLTyZx+v5Fxk5LuQNDscFu9KNxZdEr
 mbVAkPdi0Y5MAuCKKHNdUrf2Ubaqee4FDrUEUUgrKXlKVseirvXlFAzY19WGUb22Qh/9
 6KEJq5UnHkaW2Pks17A1PukWLlfsh1fZLDcUMGhd7ZE+B8zXD6EbK4nHGl0ay0KhpMxO
 0lvQ==
X-Gm-Message-State: AFq9FYLJFtY/VSbMulkQ6HCL5Awz6yCHteogUczTEWZgwaA3hl/edR40
 gisdXISwQr3lDkiuZ5ffc1Gkf0V/lJaWa3AKp8AiK5zoiC2vfaa2YARwZS2KeTc2p6w=
X-Gm-Gg: AYBFou3DahrgWLHwHsAcXObIdmJ5kzFc3ByJWF+6EmbfQ3tY4mFbP1L5MYs+LFYoh9y
 4HxOnjiHV1D1Qtm2FIsRZsHWTrou1XxPm1Sj00CVnQ+Vi3yu53pPdmIu0WCv6IGUM22Hk/N8+XC
 J84yROoRWMD6dArdxXrczxeky64Rj25HKRHZ6pdFGQQxTeawbJQulaqIENZb/eBMZJ81p4Cej5N
 Or7pQVKfjAldMZ1zO8Vb/EOXZ6231n3ZZLRdelizBSQfnO4VwV0s8QN44UA0V76qQGT//cYH48B
 WR17aQABepJaiSynj0bkJea2uJmHxhSfg0LycD6Uc2uZckUl/NaOQMlinTdaiGVxLlrwgm9jZjs
 Nn69hth9f/lhPTqPVqq4EJf55OSul1QhJjaMdGcMAFbL8w3efnIxKmQIOoo6bcWqPIJv1RRLWoe
 qVMHl72ryCDu2a8e/Cq6WYXnLEZR7+J7K9yFUJdFXiW5YobDc8f/vGuIaomVyUHtuRcvkaj+DuO
 0i+JjvJSIT4WQ8YzliMQLKstxeAGnChYcOmTblDEYHZtXgb23qY6AVOVjVHPIngJyT/2iDCb/c/
 xnuc0V1UCcCxpP0t4CvD+W/jmJ0LbluR/P/qfDK8IQcOm81/69RDIbOkRTB9/pOeOox+nA==
X-Received: by 2002:a05:7022:eb50:10b0:1ac:9da7:e881 with SMTP id
 a92af1059eb24-1ac9dc67142mr3312715c88.36.1793373423386; 
 Fri, 30 Oct 2026 08:17:03 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:17:02 -0700 (PDT)
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
Subject: [PATCH 06/15] hw/riscv: expand DEFINE_MACHINE for RISC-V machines
Date: Fri, 30 Oct 2026 23:15:27 +0800
Message-ID: <20261030151539.1872-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
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

Expand DEFINE_MACHINE() in hw/riscv/boston-aia.c and
hw/riscv/microblaze-v-generic.c to explicit TypeInfo and type_init()
functions calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/riscv/boston-aia.c           | 18 ++++++++++++++++--
 hw/riscv/microblaze-v-generic.c | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index b90da096ea8..54979eae86e 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -462,8 +462,10 @@ static void boston_mach_init(MachineState *machine)
     }
 }
 
-static void boston_mach_class_init(MachineClass *mc)
+static void boston_mach_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "MIPS Boston-aia";
     mc->init = boston_mach_init;
     mc->block_default_type = IF_IDE;
@@ -473,4 +475,16 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE("boston-aia", boston_mach_class_init)
+static const TypeInfo boston_mach_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("boston-aia"),
+    .parent     = TYPE_MACHINE,
+    .class_init = boston_mach_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void boston_mach_register_types(void)
+{
+    type_register_static(&boston_mach_typeinfo);
+}
+
+type_init(boston_mach_register_types)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index b0494b1ac50..b0f837b6ee7 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -176,8 +176,10 @@ static void mb_v_generic_init(MachineState *machine)
     create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
 }
 
-static void mb_v_generic_machine_init(MachineClass *mc)
+static void mb_v_generic_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "AMD Microblaze-V generic platform";
     mc->init = mb_v_generic_init;
     mc->min_cpus = 1;
@@ -186,4 +188,16 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+static const TypeInfo mb_v_generic_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("amd-microblaze-v-generic"),
+    .parent     = TYPE_MACHINE,
+    .class_init = mb_v_generic_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void mb_v_generic_machine_register_types(void)
+{
+    type_register_static(&mb_v_generic_machine_typeinfo);
+}
+
+type_init(mb_v_generic_machine_register_types)
-- 
2.55.0.windows.3


