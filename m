Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B8FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24wH-00020j-4I; Thu, 03 Sep 2026 06:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wE-0001xJ-T7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wC-0007B1-UU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHMsu3852411
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UmB+1TDKoh/4mI7SHzWs3U7JB4f7U8ULgqOxLqQwacg=; b=H1m0LBaUjMID5VHM
 yzoJkw1fcE8pLEMdasqI3Um+lqtxZMGo8V9WbqcJJ1dBLczU7sJodfamiFyKqHhn
 +V6P0Rv9DujmMbIPlpjjhBjAot4GQfVmswMNBqpcxxJlbwxicQo3wogpZ2pVTokk
 NFkq1JWzJFo+Xi1EOqcoWuPO4eypj3Uwc4h87jurlD0xou3xxwSgVXf0EiLtufWq
 DzraQJuJmnkNTBHAhFJmxga5kg9xAt2SKKNxHq/y/Bc0t2EssS/NYOMHRgBkJr3b
 wn70vQ6z8Fiu/6WpgYgf+uZGk9McntQhNYcAlAc/hdhyfbUt50hHsnHDR0SZm1lo
 AnhKNQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m0nkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so404667085a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432294; x=1789037094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UmB+1TDKoh/4mI7SHzWs3U7JB4f7U8ULgqOxLqQwacg=;
 b=VdO9HHLp2AsvLNsgpAm/TCP8MwiskUDPHhzreIiYgt3AGFh6gf/ePIXDjpP4okrfGI
 lhxteHg/wp5K/68bX/IQdsY/tr8GNLehM5OnRzBYNY2fuWKPfhh97Q/AxiTd2b/yNNWY
 54hvoUYILWjv3Mhuu88M2vdN3M/rLFucQvFsZWQ08rsjSj0R/PLzssUjdjU+X+jkHZi6
 yCtWBBdYCSFyXQbisyBYSh3SGwbVBlo4sL029sP1ZTxE30NtrApySQwhQPAOXtx4oCV4
 z70pAwUT35HhAdFnVnGRT42A51eNhXU9LzkLjLtWWxxjLqlt9ZuRB5/laC+nei3vCKgM
 939Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432294; x=1789037094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UmB+1TDKoh/4mI7SHzWs3U7JB4f7U8ULgqOxLqQwacg=;
 b=e/rSb+nI6rVKfgl/cmPNsOrcm8ue+pgnzaG6hfKQ7FO4nIC6uHlbIPuhQnQfKGg0Jm
 Yt/hK8+wvXeLMxSYpeqzyPmQetNn9bJLbsd2/Ha+KzergAfFRI0E+ir172Tg//yBcCqm
 pdGYR3b6GYK5JJfIg5o8MDiy8+t+sYgrE1faMiQaQx9xJPZEW7wwocKT6ApIMgPfyj+q
 0nvMjwnRHRwODAbvESTO0Z8zrQW6LYpeWUQJIbJoByKzsDwSUJwWLfOXrdG9DC1pat4Y
 U2yz4R+OM04G0rOPU7YTrU0C4gljahTLsq8H5T6rZL6hBiO7ew52Uur5/+ItdNnuD6rC
 R7nQ==
X-Gm-Message-State: AFuF++l/t5LTUsw5jv0/MzKy1dnF3BiiKGYhQ1J4seHe977lfz1XiIlw
 k3zteIYbtRMJnZwTXTM4jxtfEj1jIH0EVVn0wmsKqPcA4exigTwWO1sGH4cp97JySNOL3dgwDor
 nOYpmQGRbWFupNmkffJtb5CmXKovjmlfQuM5cFXUmBUHJ+b+rPeQbjoUonTz02VEoDg==
X-Gm-Gg: AYBFou1ig9d3d0p6ZI7qwUhv0OQ0NwHIDucAlN3vwrJBZzxLltILiHQxDzKkAu84PP8
 YIfA1JOysrivebTtzYfnN+9S4MBhtZqxRCtOuhfInUNsP93DBRCZHkUgftn/RyjJTMRiui1oDJt
 6dsunhAnEwzLlf9aJeD7nmBmNe2+FlFQ4EhAFXVBROSjrdQ4HBm0k3R5HUuMTBZN+6LYSzKPjLb
 Q4Fg4Ggr7t6t6GvCtSavNflM/hO3dXlFbgXgyZAqb5TDcUvlIa2P+IW2ONCzFLZ6iqROhpr8AjB
 u9zM3xS9yzsLnQ/CxhEXO6gGheXEGXyNEEu1J4syZoRBERF3z2/CVY0H3RlbTeuUAqmvKUrvCCI
 yZL7uyWVwtxN2mvXNDlrrN9mRWSvpmUP+XazxYG0X
X-Received: by 2002:a05:620a:2686:b0:939:75e9:7a60 with SMTP id
 af79cd13be357-93975e982aamr172105785a.12.1788432294393; 
 Thu, 03 Sep 2026 03:44:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:939:75e9:7a60 with SMTP id
 af79cd13be357-93975e982aamr172101385a.12.1788432293798; 
 Thu, 03 Sep 2026 03:44:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f9114sm59039355e9.5.2026.09.03.03.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/51] hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
Date: Thu,  3 Sep 2026 12:39:26 +0200
Message-ID: <20260903103936.62355-43-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: imq0lg18AanQCJcesxiJvy69wXCfKFB6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9LYMlBvdNoDw
 l/pXrKYTsihXkCYV0uKQ5WfWlTG//0z6ZBlkoM9DNiXTeMueCVA7JEOrN05Gq+ca7vbeqLBc28r
 +hn264V/D8jGj5GZG/VJT561JyleGsnOypvNLTtG/QWaKVTEdG/MJwLzGCL6N9A0v3sm2sSwdtk
 yc0qy9+wIf6C0h5BQXZY8ETML9IQNxgc7KCYZW09xWF793YJ44zZoCHEoAFkCqKtMcpN6o2cRh4
 XVgrFEw6dc+pAbXEHMjfuE2Qc3oVJ6u6DhlTbMqVIgGuZw3NcN9X47xF4W3gAQ2IM3cbL+NaBp2
 +oL3GVYwRByOIOXLQeEEd17JVEAXObaNTgVv8XiPULOBHHhHG+EWdOYeYWeXMqbJqE/8ZKI1WTq
 32SB8BBINSmtcj1EC7kPXrh01ZgvYm0fwaQRHTE1IZR0pPrI2OjrfzdOXclj+dyi8lEiYWX5y2w
 Lu0KaDGcFSegLHeDyDA==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a994fa7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4WwWt7SMaMprD5RLbn8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9Zj4tIeGA9M7
 P8wXsMv7NN5Zg9xf0Cp1P/EIzGkHgzsaUcRRnc0DyL3EYTt8Hn6C4X62ZoNDC6ZaRNOTsh79jMt
 MvwPSeVJqRH6DnkwqWY38mzVfBuEEG4=
X-Proofpoint-ORIG-GUID: imq0lg18AanQCJcesxiJvy69wXCfKFB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-10-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/machines-qom.h | 14 --------------
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
 11 files changed, 10 insertions(+), 24 deletions(-)

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
-- 
2.53.0


