Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11032C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uye-0002LK-Hf; Tue, 01 Sep 2026 16:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyd-0002L0-4a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyb-0003WB-8j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgFS92623022
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qc9JH3sKH10
 m6l2azd877++QjvYXSajPRX0RNPFg1hU=; b=kUdMyc6Y/PT7AI4IWowLgrabRFo
 WcJI5tBGQWMK/ai129Ow4rZ2Qgc3hgyjHXNYIsf48wZZE69jUFjDqLX+Zq7EdWS+
 29yZhmDEnVWsL0gqkdaOVlLwTU36po2q+qE1kJfr46CeqXXCSORSJkzP5UU4PTa9
 CLg3wbjqYdicP1XZJc8gIQC5ZW37LAaz79phZOxDzjYB/AXrbYXR6wBBGYv3e4fc
 Kz+O8xVvRFSDyXJfRIzkwHtYBdWi/495mphYU8nXomrRCv7eeO4bp34LX9+HOQJM
 xwbSJXxcq1a91Rt/hdVgeOFXIfqyMEB4eqCMJ4RtvB4ItfWxkqyqXi0cY0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k0p7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0aso373554a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294059; x=1788898859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qc9JH3sKH10m6l2azd877++QjvYXSajPRX0RNPFg1hU=;
 b=O9MH7ACIRBe8besRWArOWVQcYwv+odWfqL4wvZ+Ix1Q0GrCGX4xDO7yb998w/9m2Ur
 vuEGZIoWjoVing8nns4VG6CLJveQ880fiZ63MFOHY8l39CYUHh+u5jwfn02tIyDvy7u7
 fmdKSzDAucyBwz9pAMbSAKXR5yOJRF6NTGD0HDR+7tdELTg+icHv+rARz4UsXC+tWNbd
 kkBxzlXO748mkjpDklbybxw3hg1dkpYS33jAKda6tLNrmsB9Xsh4kDtkb2brHpG70QBq
 6f6b3FG4CXdlGbrMih6ZYVOHiZ8hqBFCObsBM++h2aa1Wl+WpO6ybrHOCZfWNf4dool8
 EgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294059; x=1788898859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qc9JH3sKH10m6l2azd877++QjvYXSajPRX0RNPFg1hU=;
 b=sZwDJwv4hmFq9GT5LG2P4jU3ymkpwTnfSWICfszJNP7IgYkeGz7+Qq19aAdCb5UPFe
 OwxzmyhJFT6H3kH7RXctGJKUt9m4y+Lw+SUfcfDyQ86OVYge/JhFUTWhprsYsMIZCzRF
 JLtZfCQnxIXJxYfEAVAgXRyTactUZt21vYUlM4N8knuyq9xZFUh3Kz2wA411UC36jlQ/
 Xixh4BLxwmyOGbL4zxtenlw0qG8cKVCt/ykSMxfCAiUfYZ5Zdjg0x7xXN816r9auOWZb
 mO+wPRttou6R9UfXYxrupzMEVwMwH3fPzoiP6dF4thjvmqLDzPIrXmPHnFkv47zGEMKI
 O7WQ==
X-Gm-Message-State: AFuF++nIqecobQCu9lVW9H+4a+IrTJKidkGP+TvNbPVDlB8L24ZI2kC5
 UJAutdiu3WCqW9sf/1Cr7f+ZC6APwSmYIBK8cvoj+5jVio1q4aFHqdFZ6Bc7R+rP19GM5lgDGgb
 uy7Tjn2Oj53X+PPw5v2WvsknUZQbVFC6c8kL9yIanvqSKwIMvLeKacc40pKt2ihwYgg==
X-Gm-Gg: AYBFou3sXSWXiCZByT6mgvpNCIs1kHkhRijr5Z3uPoplJRa+AGAO7N2cC+cQnTQJect
 Vue1uAMWiFbsYMQbK7sIkwGL5XhWaIM2e7KGXsUEz8gQ0+nWewCKuvXQ8xkoqYvWPPwJuBQ6rpq
 qPNZHEFO7qTS+EkLALmd7X4TG8R2UN2UtOj70L+cJHNmCLaSJUtkvF7YfmYMj0wi3ZEbzc8Efml
 8tFyYrnI/TAjr3as5r/r5JjL9JS2j8fhS80KsQhdF94HvqANoYmjuPfGZ3FtpRxd2qBX9lADkZd
 5rRW6gZqljSPJiSIaVZD8MAkCCNg+WO+OhpllF7nC8J08buvHuCLsn/PYgB4vko0SJICKe7kkSr
 2Zf+FxOHvsVemUHFr3yMHdOL3aXjXlPsdgRXqLDDX2b2cDk+w2MWMIkMqcDM=
X-Received: by 2002:a17:90b:5803:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3990f734c66mr8898310a91.8.1788294059087; 
 Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5803:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3990f734c66mr8898262a91.8.1788294058633; 
 Tue, 01 Sep 2026 13:20:58 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/14] hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
Date: Tue,  1 Sep 2026 20:20:38 +0000
Message-ID: <20260901202043.26532-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX27tBkzCZte9W
 Ah9zpy1ZX2vu4rd9Gr9PMCeqeBccvmAr5lN2FhE86Noi2+OxqPbKvTZuIJXLQz6PChLD3p5Zv5z
 BAXPZ5ajcr/57z66fHq93yP8PxPMOIZD4BK1HJXIiGk8ZPdIGY/8rXxVpwsLSLw6+v2jA/hLrFf
 xo54ZyXalszPIaxyhecTxuenm+23xImB8MW3BOK0b6UcDAvc4qXZxufI5hyRbnjZZ2X9WZ9ytDZ
 HcKKv9vbcKZRuk22yTS47vJDggvpK31gJOmLTE5k2nf/j2lMk5Q1O0QBnThEGy6CbcvbE6+s42D
 lJ2aqPxQ1AM7G9m2k13pqf7wE57sid8XQQ2RwUgmOV656Eypwfu3yDDe8F2mzT9f980Syn06nVp
 JYlzMda4y/pY68oYm9YJBFTN0uR6e4yDc7yuKUo/JtqMe+h5KyoBTbfqP5l8XFqkA3pHzaaMm2z
 6LQE4dMwfrLFO/AVEMw==
X-Proofpoint-GUID: SFfvkO7qRF6gxjjoieYJv-8qyieWmiT_
X-Proofpoint-ORIG-GUID: SFfvkO7qRF6gxjjoieYJv-8qyieWmiT_
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a9733ab cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=vQY24nbS3a5ORmXlo28A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXy6kFtTBRZdkZ
 VjA5PY0vMznKYXJqzhDDvb4siZDtlZAeKHEEo45EvINi18vLzMFi0ld9D4bopwEaF49Dx6GQPiF
 x6KnP+17CHeHTF8usRNuTRlCgwYDNHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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
 hw/arm/digic_boards.c         |  2 +-
 hw/arm/imx25_pdk.c            |  2 +-
 hw/arm/kzm.c                  |  2 +-
 hw/arm/max78000fthr.c         |  2 +-
 hw/arm/mcimx6ul-evk.c         |  2 +-
 hw/arm/msf2-som.c             |  2 +-
 hw/arm/netduino2.c            |  2 +-
 hw/arm/netduinoplus2.c        |  2 +-
 hw/arm/olimex-stm32-h405.c    |  2 +-
 hw/arm/stm32vldiscovery.c     |  2 +-
 include/hw/arm/machines-qom.h | 14 --------------
 11 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ed12f542001..c7ecf22a958 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -146,4 +146,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE_ARM("canon-a1100", canon_a1100_machine_init)
+DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index f7a51481af0..3246512c214 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -150,4 +150,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("imx25-pdk", imx25_pdk_machine_init)
+DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1aa5b49de92..909dd929e63 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -138,4 +138,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE_ARM("kzm", kzm_machine_init)
+DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 530ca9dd964..290a14c8ad9 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -48,4 +48,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE("max78000fthr", max78000_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 6e9d92b1f1d..a3dafb20131 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -78,4 +78,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1ada1a13613..8d00fef43b0 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -109,4 +109,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("emcraft-sf2", emcraft_sf2_machine_init)
+DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index c32deaf43ba..6a639264d61 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -66,4 +66,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE_ARM("netduino2", netduino2_machine_init)
+DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index a90dcbe8c26..d04ab8aeea4 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -66,4 +66,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("netduinoplus2", netduinoplus2_machine_init)
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index e801e4308ed..154501fc3c7 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -72,4 +72,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE_ARM("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 8f93c0036a3..0b39543c1ff 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -69,4 +69,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("stm32vldiscovery", stm32vldiscovery_machine_init)
+DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 449592beda0..e3eebbdefbc 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,18 +11,4 @@
 
 #include "hw/core/boards.h"
 
-/*
- * A machine defined with the DEFINE_MACHINE_ARM() macro will be
- * available in both qemu-system-arm and qemu-system-aarch64 binaries.
- *
- * One defined with DEFINE_MACHINE_AARCH64() will only be available in
- * the qemu-system-aarch64 binary.
- */
-#define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
 #endif
-- 
2.43.0


