Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF3DC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YT-0001LD-QV; Fri, 28 Aug 2026 19:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YS-0001IR-4V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YP-0005pT-BC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTCuQ3665672
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rT1TNI4nyyj
 Fa2TmSsXf12bEzyRWuDfamSyO6S/wR88=; b=AQiV0FsK3vc4KtElWFV0jvmTCRm
 LlRO1GGtn+OIS97u9f2ksYu6Zmu/w/BNCsGLQ8bprqN3mjoEqkoiKZCL8UW8iQ27
 i/0j9h5drZpI0+YBsKXAyPnsve1WQ6gz4Z0UlvKYVctN9bSMEH2GyKufSiKrmDPa
 ncEkHLhsgTNgo2lOmMqzDvNvcw9qHnU7bqQhiV87QnB+/uzGTQ9R34DdbtOcUBfx
 k0PHAsZdtOwlqXCXVJuOah+EzXDBnH0RQvnJDsB4kHH/dY/H0624AdH0ubDv12a4
 uU7jeigoOfkFOfCOCmLL1YnMRRpzFLrTJUjE+S9bjJc511fm2oMOlUvDsBA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubsy5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so2822362a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957997; x=1788562797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rT1TNI4nyyjFa2TmSsXf12bEzyRWuDfamSyO6S/wR88=;
 b=jqjrZvGBz28VeIQJkh0xCd72zQARI431KhIWu1W45fpZNgMvUR3MJS21UV+TZ8AUVN
 7OIEZi/94RZaYsFBxfTNSip6ciDdD8OFQnLeNaPKW1C1JMze2PKkbombcDrEAxEI86IJ
 MNvkj4E0UIXByPHCeG/m4NkrUu4fEdL0DEyrpmOwZ85MZy52bnGI0Pm34mUHEhpVQj4L
 NzWObVJnwQYoJkUsaPdPwM8UuTr5pGlE1zd0jjsi/ZQ7jYp5TN///vo9S5I80nQn7bDY
 87QqFZDrw20KR/bym89NF6WHCCxyY7CKJv7dqiMkAzz7xmADcwPo7uENVYKLuSs56JjI
 w1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957997; x=1788562797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rT1TNI4nyyjFa2TmSsXf12bEzyRWuDfamSyO6S/wR88=;
 b=rTmORJt5Add/COZOViN1rHsiAIpuU65w7waVbpYbhYudC7vftodPFxGS3Pg03e4lCL
 kE9o5RVbxI3S0WE+wMUjy6EbOXpSK4zgepCgkao9KkMaCTRK7bPGwTd8OQXuQgULNH+8
 t8ASi5ivv2ulbwIx3bW3NRiZrZb9IMVvW15XR80OjuU2uCYJ88lS7EoyYGtO8oAO7+k+
 mwsfoYcyzMrKZtiAMHFo8zFDQPNF8PU7X37SRItWtclZsnluR2bZ3jowv1C6a8rxgSnr
 g4lLWdT5CvEeDbkev/VAdcNBZxWukv1cUscRVT7kZUYoYmybxOHY8JxYKiOuYSN02I7i
 ia5A==
X-Gm-Message-State: AFuF++nGCMByWmN+ucn3iWcv+RjW+XoJ88vsjAtrEbZ3dpRg/m83QUoM
 jNvNKMuz/baL5ygUQ6S0bdh1A/APawbTaNRJwRJYGbUwX+SlWxmCPvP82vgTo1f52lGb0vS2/kN
 bix2WAMtYoPo9bOLlJaV/sLUOprIsW1b7iz0+PHRm7DXCzW8H8Sq2Okvp5OBAuwSpnQ==
X-Gm-Gg: AYBFou0dLsBUG1kBPa7uMD6FFF01uFzTFwgPSnQfofHZJ6WBuG79+tWuMXuuWTNg/pp
 xQ2QWgYfGhJkVsDi7Yyr9syApV/A4Mth5Sa6tECFG3A/j9eI+tb0fhrnXfjBTZLpqTd2mPR0h5o
 ByEIM9pVME80/iSif9BkzWFTSGPmKYEp6rkDRpuIOft+6Tm4Qvugy9PwM6v9JCNvJjlR8qNv9pf
 7+yyj5T4E4II+hhV7A9dy+7KgMvksalA0dMw4Trw+ToS3Whoxe47RIvC6yW/qFjNkHutrCeKhEU
 c7PPEcX42vEgwJt4n4B7JoyOpL1q3ZRVrAGQ2+5OMNl/KFtT7i7PbATaBsYCr0ayZeD3ukWbuIY
 W3a+xea9T1UpATBpuMegGxw3LGsoLzdkMiIrSe2FVXjhKPYWjQzSaNjuGLTM=
X-Received: by 2002:a17:90b:1806:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-3989be8eaafmr3667057a91.21.1787957997260; 
 Fri, 28 Aug 2026 15:59:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1806:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-3989be8eaafmr3667005a91.21.1787957996755; 
 Fri, 28 Aug 2026 15:59:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 39/47] hw/core/boards.h: add available callback to
 DEFINE_MACHINE
Date: Fri, 28 Aug 2026 22:58:53 +0000
Message-ID: <20260828225901.367438-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212ee cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zoqp7TUp9j7u2cceVAMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: vsbSupxyZ4pV7C095R9PHccyuvaMW0jS
X-Proofpoint-GUID: vsbSupxyZ4pV7C095R9PHccyuvaMW0jS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXyFfbmw7/kvE5
 7inG2DGWHwc20dme5F9oz7FEb+QjoNyRRUkckiYlkHWEXMRicKMluEF1HzaB0LE1YkKVosZPsyV
 MfpjPZNBkUY8URd1kieapYYmFr8WXH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXw/X1dBnKKBU6
 XKSmYAd9q8RBDbgNvkQHJs4x96bkVwc8B+aNB+WKDsiSNVDmdYKxu8Q4WnoSYyeitvdRbPfkhcl
 odII8GuFCylyyA5D/YKEhbYOc3lf05cb6ZyBnJlvmogRvCEu2u1hbPTlyR7NYDQeFnM5JjHSbsC
 4MCW1ocPH9jMZZJHWM3qeVDGQDO2TeiAHPrfot1mSWCk57Y6GAG02j7ei2V6SpP2KOMy86Tlh/e
 30ZusBjF5r33HLdgFnhCFxo4LMAxXEwB+9I/1la+SKAlbTGybcoNWmiUjLaefoNnEP2eFd4AyuM
 5SqUMzFi4POgFj/xcOyoW9b3d3B+E44t4i8ICstHWzwtjLUVeDbi+uzmb8O0Ag4pAaPb8CGr6ds
 7acBG5P9Xcbe+xV8iM3XtA3sWeW/90uC5phg2onbkLKHfaBOzwMxG3ZOA08iNAukuzup+71PosA
 PR2i/xRacCiAPHu0D+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 hw/core/null-machine.c              | 2 +-
 hw/m68k/an5206.c                    | 2 +-
 hw/m68k/mcf5208.c                   | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
 hw/mips/boston.c                    | 2 +-
 hw/mips/fuloong2e.c                 | 2 +-
 hw/mips/malta.c                     | 2 +-
 hw/ppc/amigaone.c                   | 2 +-
 hw/ppc/ppc440_bamboo.c              | 2 +-
 hw/ppc/prep.c                       | 2 +-
 hw/ppc/sam460ex.c                   | 2 +-
 hw/ppc/virtex_ml507.c               | 2 +-
 hw/riscv/boston-aia.c               | 2 +-
 hw/riscv/microblaze-v-generic.c     | 2 +-
 hw/sh4/r2d.c                        | 2 +-
 hw/sparc/leon3.c                    | 2 +-
 hw/tricore/tricore_testboard.c      | 2 +-
 hw/xenpv/xen_machine_pv.c           | 2 +-
 hw/xtensa/sim.c                     | 2 +-
 hw/xtensa/virt.c                    | 2 +-
 include/hw/core/boards.h            | 4 ++--
 33 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index f928e0cee82..b145a76dc61 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,4 +213,4 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("clipper", clipper_machine_init)
+DEFINE_MACHINE("clipper", clipper_machine_init, NULL)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 90c19106ad0..5fd7ed5dc42 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -145,4 +145,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
+DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init, NULL)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e7..50e53585447 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -149,4 +149,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
+DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init, NULL)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 387bf54ced1..2353e73b243 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,4 +137,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init)
+DEFINE_MACHINE("kzm", kzm_machine_init, NULL)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index ed50bb91979..a182e1379b9 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -47,4 +47,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE("max78000fthr", max78000_machine_init, NULL)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b9..f7e654b6228 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -77,4 +77,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init, NULL)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1372d7f628a..92f36ce3785 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -108,4 +108,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
+DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init, NULL)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 0db8798b4bd..47e9e55213c 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -65,4 +65,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init)
+DEFINE_MACHINE("netduino2", netduino2_machine_init, NULL)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 5ac0eb81637..40701f47f09 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -65,4 +65,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init, NULL)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index de9ac4978ce..4630f78617b 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -71,4 +71,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init, NULL)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index d899a134b38..35c16bda411 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -68,4 +68,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
+DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init, NULL)
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 60254913019..c95ac0aba38 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -55,4 +55,4 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+DEFINE_MACHINE("none", machine_none_machine_init, NULL)
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 1acd2fbdfb3..3d8d63bc68b 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -101,4 +101,4 @@ static void an5206_machine_init(MachineClass *mc)
     mc->default_ram_id = "an5206.ram";
 }
 
-DEFINE_MACHINE("an5206", an5206_machine_init)
+DEFINE_MACHINE("an5206", an5206_machine_init, NULL)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a8068c91f24..379ff2e68fc 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,4 +398,4 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->default_ram_id = "mcf5208.ram";
 }
 
-DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
+DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init, NULL)
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 8f9f54ff1e2..240f5a31aa5 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,4 +220,4 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->init = petalogix_ml605_init;
 }
 
-DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
+DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init, NULL)
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 00154236bf8..59d34f5846e 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -185,4 +185,4 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
+DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init, NULL)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4579df23eb7..dcb23b6f558 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -850,4 +850,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
 }
 
-DEFINE_MACHINE("boston", boston_mach_class_init)
+DEFINE_MACHINE("boston", boston_mach_class_init, NULL)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 9a712ee9309..a72b10b46b9 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -339,4 +339,4 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
+DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init, NULL)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 38c71f66f2e..aabe18dcdeb 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1301,7 +1301,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
-DEFINE_MACHINE("malta", mips_malta_machine_init)
+DEFINE_MACHINE("malta", mips_malta_machine_init, NULL)
 
 static void mips_malta_register_types(void)
 {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 2e94e80b569..9cf789ddec8 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -427,4 +427,4 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_ram_size = 512 * MiB;
 }
 
-DEFINE_MACHINE("amigaone", amigaone_machine_init)
+DEFINE_MACHINE("amigaone", amigaone_machine_init, NULL)
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2dde008b0e4..64ecb5b2281 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -265,4 +265,4 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("bamboo", bamboo_machine_init)
+DEFINE_MACHINE("bamboo", bamboo_machine_init, NULL)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2672eb9e7a7..6f155f5af05 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -456,4 +456,4 @@ static void ibm_40p_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("40p", ibm_40p_machine_init)
+DEFINE_MACHINE("40p", ibm_40p_machine_init, NULL)
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index b13dd224ba1..5031022e244 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -519,4 +519,4 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_ram_id = "ppc4xx.sdram";
 }
 
-DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
+DEFINE_MACHINE("sam460ex", sam460ex_machine_init, NULL)
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 09686360e16..0e7257ad4a7 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -289,4 +289,4 @@ static void virtex_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
+DEFINE_MACHINE("virtex-ml507", virtex_machine_init, NULL)
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index b90da096ea8..d90216eb4b1 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -473,4 +473,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE("boston-aia", boston_mach_class_init, NULL)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index b0494b1ac50..d6f3a8ce635 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -186,4 +186,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init, NULL)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 99afe3618e8..9c68ccdcf00 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -387,4 +387,4 @@ static void r2d_machine_init(MachineClass *mc)
     mc->default_nic = "rtl8139";
 }
 
-DEFINE_MACHINE("r2d", r2d_machine_init)
+DEFINE_MACHINE("r2d", r2d_machine_init, NULL)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d4a6e917598..30d9bb7adab 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -443,4 +443,4 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->max_cpus = MAX_CPUS;
 }
 
-DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
+DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init, NULL)
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index d5d796c8eec..40d8dd76324 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -113,4 +113,4 @@ static void ttb_machine_init(MachineClass *mc)
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
 }
 
-DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
+DEFINE_MACHINE("tricore_testboard", ttb_machine_init, NULL)
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index c406821c34c..02bd32dd0f4 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -69,4 +69,4 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+DEFINE_MACHINE("xenpv", xenpv_machine_init, NULL)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 835cd04fe01..7649bde9cdb 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -131,4 +131,4 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-DEFINE_MACHINE("sim", xtensa_sim_machine_init)
+DEFINE_MACHINE("sim", xtensa_sim_machine_init, NULL)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..4f6418ff44a 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -124,4 +124,4 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+DEFINE_MACHINE("virt", xtensa_virt_machine_init, NULL)
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index a745187847c..d51b49ec860 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -536,9 +536,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE(namestr, machine_initfn, available_cb) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, NULL, NULL)
+                            false, available_cb, NULL)
 
 /*
  * Helper for dispatching different macros based on how
-- 
2.43.0


