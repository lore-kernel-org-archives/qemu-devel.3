Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IombVQIx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNy1Q-00071H-76; Mon, 02 Nov 2026 14:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNy1M-0006zq-7r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:48:44 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNy1J-00043J-BG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:48:43 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso5411249c88.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648919; x=1794253719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pCgkg+I+oIlWX98k1kiwueUjGptBoY/rogjfXbGmkGs=;
 b=IombVQIxC9YcneQseZnpM0q0tbhPuPpcYaK2wi1lPzdQOUJ4Q42gmZhIyVt3SZzTdH
 goc8PDQ696Xiz4f8WeD/8aY7fQ5Jd6lK1gk0G7OU3ImHULz43jBpLP8UgX9yrurySFdi
 1D5i7KU/cALRyAR6/4AcJV6cV7oP4JOjfyJEkZ1IcO0u5U2vBfi/jaKE2k7hmX3IEJi2
 5xDLbRkUB4U8cq3orY9Q7uluuY5/cLwSR4Ekyitq5mB81CMZpW4qs+ciO25e7raTABnQ
 orLgFXb7uVKMWzGfSnpP0XBRWR1SMVI0XQ32QNKrlwIbJOosrqO3VEzqtFR7daK8Ag97
 cVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648919; x=1794253719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pCgkg+I+oIlWX98k1kiwueUjGptBoY/rogjfXbGmkGs=;
 b=RhE9feXnY2iPtEA9KKdLQ2BAV8Xau0XS/fh6bZ/MAUZjVSiaoDD6FObrTYET7CPN8D
 QMnZJN1lfm8qgtztuczov/R6fqXjCzLeUQrWXxkjlJI9RVZz3xJ1501QG7Wl0fIg2866
 QTZxq91a3CI1ZUW+qbsDZLpljgEwPcgziOpYrjQQcx7u3r85taqekJhFsA9vPPd0Tp2e
 qCC8PS0w6AcyGXA3mudDg7VlSHhJjONrrz0P/0mNfi8KPgyJVhy0HXkgo+pBLaD0nWIz
 M6MajLwz4ecoiEGt2Gt+hFVcqQj7jrC45rncOzBvhZaOxDkJi2dE/ITCXnihzitGjzOA
 w73Q==
X-Gm-Message-State: AFq9FYJ2kug90LHFtgk14ntUvG1jwgvko84LlH27wN2obKMw8b6s9xKV
 8d1U4tWHp3vFAIT0DQaNWPWVjr5toBCsGRuCQ2/M1fJBFSfz4Nw4cBM8sDOG9QGN
X-Gm-Gg: AYBFou0K6+gsrsARS86H3A5NkUt+XiGEzhIEEmNCrSRcWaiV2ST2iEze2BtkBrLGd7D
 tn+oa0Yezqe8A1qr/8EF3gQsNCDZ+wNO6aweKEoJWJDUkVQUv1YG9+rCFnT6zQ19d3wWDqLFnz7
 hxRZbHybvwjJu4vU39ET14wNp8QYpVo5wSrSvwJvOoZmiaeEh2lOzqB2nnfZF2T01W13M5Hynxj
 O12w/kw7/QSulZcZ46q3JrsGni+1qJQBfThXk6DCKEiTLO/jwwO4wBJalXdEhny+ioAQE3TPklB
 cJk/J4dkNQAZ0Zod3v82tjoCw43viIhvZDBrntrqQGE3zCq3wKIvy1pbbK7Cfol61mGoottfyMg
 AqQtmdB7PKo2oZheP8+i0dq43vbyfo9zx9a/KCUr/BBrowcCg9LK7cSo4LFL80bmRLi5Z1i4H4g
 0SRrjmoftHCPBDjEXK2YRWVYthuM+S8MZioLgGEkEnmsa30HpoZMvC55dVql1G9Mj4LbB5HK5Ko
 7gr1G7dM7wfmbQQMeiVyWg6F2dewR6ljXjv7s/J6XHMDaczcl8KB15/dqK51SAbRG4bMvzCsnVM
 c+uvhuuSDWMvzRhDip7aMGRWc0CTFOmW/+MKZuyoA6vWWpmU
X-Received: by 2002:a05:701b:454f:20b0:167:d73a:e994 with SMTP id
 a92af1059eb24-1ac5ac4f0b9mr17340914c88.24.1793648918589; 
 Mon, 02 Nov 2026 11:48:38 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1aed79b3dfcsm36639389c88.12.2026.11.02.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:48:37 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Felipe Balbi <balbi@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>
Subject: [DRAFT PATCH 1/1] hw: set DEFINE_MACHINE target masks
Date: Tue,  3 Nov 2026 03:48:25 +0800
Message-ID: <20261102194826.1298-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
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

Pass each DEFINE_MACHINE its architecture mask instead of
QEMU_ARCH_ALL. ARM, Alpha, M68K, MicroBlaze, RISC-V, and TriCore
boards use the matching QEMU_ARCH_* value. boston-aia uses
QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV64).

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/alpha/dp264.c                    | 2 +-
 hw/arm/digic_boards.c               | 2 +-
 hw/arm/imx25_pdk.c                  | 2 +-
 hw/arm/kzm.c                        | 2 +-
 hw/arm/max78000fthr.c               | 2 +-
 hw/arm/mcimx6ul-evk.c               | 2 +-
 hw/arm/msf2-som.c                   | 2 +-
 hw/arm/netduino2.c                  | 2 +-
 hw/arm/netduinoplus2.c              | 2 +-
 hw/arm/olimex-stm32-h405.c          | 2 +-
 hw/arm/stm32vldiscovery.c           | 2 +-
 hw/m68k/an5206.c                    | 2 +-
 hw/m68k/mcf5208.c                   | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c | 3 ++-
 hw/microblaze/xlnx-zynqmp-pmu.c     | 3 ++-
 hw/riscv/microblaze-v-generic.c     | 2 +-
 hw/tricore/tricore_testboard.c      | 2 +-
 17 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index b0b1ad5cd1..098a457a7e 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,4 +213,4 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("clipper", clipper_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("clipper", clipper_machine_init, QEMU_ARCH_ALPHA)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 018f2e8070..59bbcc4826 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -145,4 +145,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 1a117e7806..6eb42cce3b 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -149,4 +149,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index d0090658a5..746e475888 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,4 +137,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("kzm", kzm_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index e3f48891de..11bb1028e8 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -47,4 +47,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("max78000fthr", max78000_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 786c4f1b53..901edaedc2 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -78,4 +78,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 219d66381a..1cd9de2bcc 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -108,4 +108,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 1a2352c038..4e38cce808 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -65,4 +65,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("netduino2", netduino2_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 627178d300..0b048e8be1 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -65,4 +65,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 44f27b84ec..40695fa50d 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -72,4 +72,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init,
-               QEMU_ARCH_ALL)
+               QEMU_ARCH_ARM)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index b61a11a5f4..1130d2d166 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -68,4 +68,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init, QEMU_ARCH_ARM)
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 50719e0b75..9d95c2a3e4 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -101,4 +101,4 @@ static void an5206_machine_init(MachineClass *mc)
     mc->default_ram_id = "an5206.ram";
 }
 
-DEFINE_MACHINE("an5206", an5206_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("an5206", an5206_machine_init, QEMU_ARCH_M68K)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 5fa54da7af..48a80c1922 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,4 +398,4 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->default_ram_id = "mcf5208.ram";
 }
 
-DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init, QEMU_ARCH_M68K)
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index c40ba899e5..2f6b92d30f 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,4 +220,5 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init,
+               QEMU_ARCH_MICROBLAZE)
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 2f38311b36..34161664c8 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -185,4 +185,5 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init,
+               QEMU_ARCH_MICROBLAZE)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 3caa93dd3e..3409e5323d 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -187,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init,
-               QEMU_ARCH_ALL)
+               QEMU_ARCH_RISCV)
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 196ff25c88..1042e2f258 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -113,4 +113,4 @@ static void ttb_machine_init(MachineClass *mc)
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
 }
 
-DEFINE_MACHINE("tricore_testboard", ttb_machine_init, QEMU_ARCH_ALL)
+DEFINE_MACHINE("tricore_testboard", ttb_machine_init, QEMU_ARCH_TRICORE)
-- 
2.55.0.windows.3


