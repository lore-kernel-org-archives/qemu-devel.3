Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93198606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XYa9XwNH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoM7-0004fm-3r; Fri, 30 Oct 2026 11:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLM-0004NH-1M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:39 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLH-0008Ra-Sx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:34 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1347350c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373390; x=1793978190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CnMqBd/JBHGwVaxrghEFIqcYT1aAnIXyDuq/h1Z92iw=;
 b=XYa9XwNHiCWwU5AOcRS/9/X8JXg/ZfgtC4in4141COJc4Uh7TXAqKY0pzBDuWxSTYa
 jcyPRO+fKoiWbA4wp0r9bcwJZ5cE96j3S+t8DP0RfRVlbU/QTBVBO4ZEVRetaGD5O+2w
 wN7WNr8PXuKSmNswrpV/XLSn7ReuO4Lp2BiM111ykcKVjKXxVOZZRSRIukdQYWZThLW/
 1e6hamrZTIGN+0HHe6qP5LEv29irhHZgzy8rsD3n7zvE+f26K1prBKp0am+87ExI83ck
 /UknRd9hl/b0GZE8fXm3JbOebAXcQEzhQMQp3oecXFbdhMS5GYqrXV8CX3ZLhppHjeHW
 ++rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373390; x=1793978190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CnMqBd/JBHGwVaxrghEFIqcYT1aAnIXyDuq/h1Z92iw=;
 b=GIyJpLFE0ZPiVELPdcVgRIkOuiAQ2kBnSD7p1OP/VUfbLUe//9P/ENn6urYYIjGMrX
 U1Fsq+ApApEKBOhwDiDW3qo3MA1tqVoAtpOr54nnAPZKuivQt+6r42RxNH92z2CeRXKA
 VTo0+lEAo654A48mTdA1eeAOFF29b1n8fn1CbBMgvYrJv9zTWZgQzfYGrKG3hXoKudTV
 gNyFg5JN32h2Qfm8s9p2JrU8+ll6uZ0bA4G6Xlo6I3/VAhfTIYxcgkzEBuKf4PQHi78W
 PyPtWuYsrUoDM9cUXN7GBGLokklZo7aZjjqjmEoctW4jM2X+cCPIOYhen/4h431i2FEw
 mRhw==
X-Gm-Message-State: AFq9FYKOD8k1JPP0x+4zH8F4AJsMoK6rcwssB0LJn9d4B+t0UO5D2hyC
 ufnbcOn8IrEe0Eqe8fpvkXtI5ISQJYeyW5vxGwy9ICLmSPieHFGlkO2vj1jXsNRCs2g=
X-Gm-Gg: AYBFou33o47okBNx88bOHbvGqMIFZOPa8XtrwdzrEopqwpEUsfhbTRcmBIsmvpA3pMg
 CPMPKLs4vhgvNPniRDd5llqAbzByxnyoQ/MSgqDQv07cCVJuQrzh+q+Zuouj7fqsG0wCkk0jNhs
 IDBbe3uufnmnE7irzVbSPvGfW7HWWio9ZnLjikjA//7GnbVYjxK2gMsCN3qDw78rshTvywZ0cD4
 JDACRJCzdqTdJI1L+GpfLEwY0CnrVl+L5GySqDv94ZEVYrI94HmpgWq8gKQZsJ15/KnyFKmulFu
 ciswzVL4ww3rkgqte+z82d5Fs2SLtmrimpPYtXH1SIPxd6uIaEE/JDsh4znOkcVOUNVb7E3cZR+
 jFgm34bbNvkSm+Y9TtMfWtnZieEiDUM78pNyu6NmoafnERTBfNleTKA14eWgPZlJfpVzTcDumwg
 E0HWT0WLtFwvcePNc3ZQ8uW+bpkKGi8UtyqGINQj8Nx9LTRQtAdZACwwlNt4DThVp2SD/KbmL2m
 vkdk9/aNif5eSN8Uxw49ttzKBr14jGzS3Qya/bA+jC1+YhLfEf2Iz5czwoThCMSVqbzpVPnWBU8
 ZsH1CPMJvKFzndZrBQUMpoe5ZN9NrCx+Lwy+NyBoX3r0I15T
X-Received: by 2002:a05:701b:4502:10b0:163:fd28:5658 with SMTP id
 a92af1059eb24-1ac5b02289fmr3445161c88.22.1793373390156; 
 Fri, 30 Oct 2026 08:16:30 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:16:29 -0700 (PDT)
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
Subject: [PATCH 03/15] hw/microblaze: expand DEFINE_MACHINE for MicroBlaze
Date: Fri, 30 Oct 2026 23:15:24 +0800
Message-ID: <20261030151539.1872-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
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

Expand DEFINE_MACHINE() in hw/microblaze/petalogix_ml605_mmu.c and
hw/microblaze/xlnx-zynqmp-pmu.c to explicit TypeInfo and type_init()
functions calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_ml605_mmu.c | 19 +++++++++++++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c     | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8f9f54ff1e2..393eeba76f5 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -214,10 +214,25 @@ petalogix_ml605_init(MachineState *machine)
 
 }
 
-static void petalogix_ml605_machine_init(MachineClass *mc)
+static void petalogix_ml605_machine_class_init(ObjectClass *oc,
+                                               const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
+static const TypeInfo petalogix_ml605_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("petalogix-ml605"),
+    .parent     = TYPE_MACHINE,
+    .class_init = petalogix_ml605_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void petalogix_ml605_machine_register_types(void)
+{
+    type_register_static(&petalogix_ml605_machine_typeinfo);
+}
+
+type_init(petalogix_ml605_machine_register_types)
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 00154236bf8..d3ade9faeee 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -179,10 +179,25 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                            NULL);
 }
 
-static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
+static void xlnx_zynqmp_pmu_machine_class_init(ObjectClass *oc,
+                                               const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
+static const TypeInfo xlnx_zynqmp_pmu_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("xlnx-zynqmp-pmu"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xlnx_zynqmp_pmu_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void xlnx_zynqmp_pmu_machine_register_types(void)
+{
+    type_register_static(&xlnx_zynqmp_pmu_machine_typeinfo);
+}
+
+type_init(xlnx_zynqmp_pmu_machine_register_types)
-- 
2.55.0.windows.3


