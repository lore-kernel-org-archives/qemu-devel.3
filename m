Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F6EC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Uv-0004yp-Ho; Thu, 23 Jul 2026 20:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Ut-0004yS-0c
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uq-0006AJ-B7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeYJH1237337
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CCDJhB4Rbzu
 gTnuj4BwwhurHLzaxe2H/PnELOpRjzXQ=; b=Nu/KsZhaS3rRKQHjV9odkDOWBew
 Y23Gtv3eCQD1z4eLkU0cwNPBFBCzpP6ASlX01Z031UtEC5S6eOKkS/ZL3FTEu0Hy
 cocpic7BvxRZQM/Sgailtgpqn+9I55eZkMGxPElNe+tmi2N1P6rgcOUWByrI1nLA
 VtVeut3fcXr7mzHFQY+dFoXoRfHkt22FELiDPn6iTUsiO9T67YiOT5lKgSui4Bi1
 0NfTQdlUOEn/5zE7smE8+fRAkZbADAr5laoiomHETb7k7aGzd1KKUDKlE/xdXq6u
 Tn1PZS3vBUkm0DbHBGJCkcbJg9oUJXm8lWhakBVnQjbu7jUg2uNz2Q8fkBQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso1185599a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851824; x=1785456624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCDJhB4RbzugTnuj4BwwhurHLzaxe2H/PnELOpRjzXQ=;
 b=GOHOUpIUGMBYulJebKKsBkXHijBZ1RnAbexaCX2qySr6vss/IfdhG88x00ZrDnGIH5
 CfTX/kbEU31Th/1AgOQ5tJce1ulEl9VHo7k/X+330EkI8G/jmIqMDyyG+wMALAuIJGh0
 t0JGSerS04T4Z+F7w8iHdI7M5Ty6me0kbK1i2oNrFQQ6RQPt42YS9H6FWO9EuVhH9VZN
 pEwxFo5WrxEoTnYWz1SGrkfpvOgqHfg44QY0gjnfoJHv8u5Eaza10ncxaC4+NulK+GKR
 QJrS72qV9pugy2x8EMDbLtgtNi6Pwa/UsPsahw8+7fYkdPLoV2X+4FYLCDtBLasrvfgl
 Xsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851824; x=1785456624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCDJhB4RbzugTnuj4BwwhurHLzaxe2H/PnELOpRjzXQ=;
 b=ciIpIvitlBL33wiGcmys0rpjCBcBA0W93pVQsKu7zxJGw/x4mXeJ/C0Xfo5rVfOZkM
 cPB0kBrigrLtYiTgzxp+73G+dcDwYzf30/OJxORH97ACjCER8NY6yWLRmPdFwxFz4FXz
 iZkBGj1INi92DdSTEU4HBsSwqKkiEpfzhCazWbKl22WItZGhKEx2Zn0oeSf4VUj8YJ6G
 zm9hIVdcsHzXrJetprLNSNodFBMS8y1X/gFdgYLH9jYWlBPa8uV/cdOTTFKV36s5xESq
 DTp5OZLFPpPJMcoTvWIUAD4dw5vs/Bhhz0CNLll5iiP/FWV3vSRukEW1IrY1bgR+yN5b
 Tfcg==
X-Gm-Message-State: AOJu0YzEj5vMKtVubK/tjCgsSg6MsJXLOhvWataOtrS7kXAtoiQf+olF
 f2Q2JoM5X16VOB9rwDHOW1ydnr1NcW3KeEFkkskssGepV1DRoOVl0hIa6yfPo4IMGXbNWEnp7zu
 dKq/b4L55JbEkdw6om35tEzwZM/9mmq7HR1rRtHbq5CdjM0y4sMv5e4HZWGrL6n6pLQ==
X-Gm-Gg: AR+sD10h0ueOTL+puk1NgaTlFp89vxBTdF160Az2dV9Z4KnMKM6tFvL/nn3pkaKBM0k
 EviDM0DIFsY4z3Y1espNFHFSkHGlVsTiXlzbrQlMnhE62Lr+P+EezjUPukj/VblMOqV1aMHTPAg
 IdVeIWSo5F3iQ87Vu5PQc5ITcyw/o6JlYqE8WabEi0SoucB2USL3e9aWofKdcen/xWTALt6y+B7
 ZvpCVaaCBzRroknAZt/vwInRAq5+llORNIqyxmuCPtneiLwVG2j8N+uoi6LMF7Cvg2P4EjSFcOi
 OmvLvP+QTK3NNIRwTTa/0JmIyW/hFAnEciwmDwXgBdFwES26s+jngSSt2x7PvcFEQo99h/2l54R
 +zs/hBC/79zah0nwiNpcUQpDAlAKwP1oU4SKONueJeh9Gz9V3UGD5xRz59OAJgMFeUhyk+jk=
X-Received: by 2002:a05:6a20:6716:b0:3c6:3c5b:f301 with SMTP id
 adf61e73a8af0-3c63c5c1916mr1984007637.68.1784851824255; 
 Thu, 23 Jul 2026 17:10:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:6716:b0:3c6:3c5b:f301 with SMTP id
 adf61e73a8af0-3c63c5c1916mr1983982637.68.1784851823758; 
 Thu, 23 Jul 2026 17:10:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 20/27] hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
Date: Fri, 24 Jul 2026 00:09:40 +0000
Message-ID: <20260724000948.234657-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX2k5lPx6adSFE
 j01ek4s3eO3zisWk3A9lYUBHldfZ2ZKig6ZxTX+AnIwraCxc4UKvklLTXIOjJVsguuvKiR+brRg
 Vvdf9KNPQ20kHvQyJi+6skxxqLm7nQ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX7qGAQXnww3Jy
 GtUXvEuL8eScwZz7fYHYFYg/RpzIchoAI6zXTErNucPZN+oCj5RdRtQTJ/PqXpjFs+yWZrGlhD7
 Ip0JBS/f7pHGX4vMJSuoB+6q1sNtSE9+EThfHySeiUL4hkgG6ayDinr7v7XbaTHpkAznucrv6XI
 A90+fuzFJjRVdA/cq6KAgWrrmPkgXFhPHCDcZ328/sn0y0dZUanIri6jZAIfSNVF/9J7VKtHRi3
 H8Tc+qN60mbgnLmy0Rj4XjRN4Nf7TIPV9TwPr9M5aqk2nTG1CFxYJhNnhL/a82t5f47QxZ42eBA
 qPQBH60dR3bLJ2bxvhAoVejOwN9MdiWpuU/JkHOye/YSzrn0Y/Ej5e0+M2faoTNZI9GXup98OUz
 LVhsbfA7BWdUzZHZBvJ2xnEx2ZgMzN/sn7ZVAp4mwQbuI/WzwvjOd5/xeulaWswGcA5GK9UXrE/
 j1tgx/kEevbbSyNqMGg==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad71 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0dbhwdPUfnL-ij2kYaIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: jvxRekdVkU4clNZsE7_4DLnBpPpZGOfs
X-Proofpoint-ORIG-GUID: jvxRekdVkU4clNZsE7_4DLnBpPpZGOfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 hw/arm/bananapi_m2u.c         |  2 +-
 hw/arm/cubieboard.c           |  2 +-
 hw/arm/digic_boards.c         |  2 +-
 hw/arm/imx25_pdk.c            |  2 +-
 hw/arm/imx8mm-evk.c           |  2 +-
 hw/arm/integratorcp.c         |  2 +-
 hw/arm/kzm.c                  |  2 +-
 hw/arm/max78000fthr.c         |  2 +-
 hw/arm/mcimx6ul-evk.c         |  2 +-
 hw/arm/mcimx7d-sabre.c        |  2 +-
 hw/arm/msf2-som.c             |  2 +-
 hw/arm/musicpal.c             |  2 +-
 hw/arm/netduino2.c            |  2 +-
 hw/arm/netduinoplus2.c        |  2 +-
 hw/arm/olimex-stm32-h405.c    |  2 +-
 hw/arm/orangepi.c             |  2 +-
 hw/arm/stm32vldiscovery.c     |  2 +-
 include/hw/arm/machines-qom.h | 14 --------------
 18 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 4fb19a83657..b96268ef0f3 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -146,4 +146,4 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("bpim2u", bpim2u_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 234c1ea37fc..b80cd4ade7a 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -127,4 +127,4 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("cubieboard", cubieboard_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index fbcabaa3362..1210a6a888e 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -147,4 +147,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE_ARM("canon-a1100", canon_a1100_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index e60a7e672a4..b9113ee983a 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -152,4 +152,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("imx25-pdk", imx25_pdk_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 031f9348626..f660015e207 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -128,4 +128,4 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("imx8mm-evk", imx8mm_evk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index cf95c3f57d4..489afdaf163 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -697,7 +697,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("integratorcp", integratorcp_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("integratorcp", integratorcp_machine_init)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b49841ca87a..b97ef4c932c 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -141,4 +141,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE_ARM("kzm", kzm_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("kzm", kzm_machine_init)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 4453868e562..a39cb001ce2 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -49,4 +49,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("max78000fthr", max78000_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 299e797fd48..cbd41056522 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -79,4 +79,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a94218ac1b1..f4e31407fe5 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -79,4 +79,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 44c68bffac6..67d7a8d00de 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -110,4 +110,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("emcraft-sf2", emcraft_sf2_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d9aeb98b6f0..a3f98ca95a2 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1358,7 +1358,7 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("musicpal", musicpal_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("musicpal", musicpal_machine_init)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index a721da02ce0..d9b74b9065a 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -67,4 +67,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE_ARM("netduino2", netduino2_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index ee5f1679426..c0ef997184c 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -67,4 +67,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("netduinoplus2", netduinoplus2_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 58a124d3c06..9dbae8238b3 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -73,4 +73,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE_ARM("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("olimex-stm32-h405", olimex_stm32_h405_machine_init)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 53366a76334..9cfc1e077e9 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -126,4 +126,4 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 53b4632c013..b87b57da61c 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -70,4 +70,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("stm32vldiscovery", stm32vldiscovery_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index f4d9a163220..f64de7bfc8d 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -13,18 +13,4 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qom.h"
 
-/*
- * A machine defined with the DEFINE_MACHINE_ARM() macro will be
- * available in both qemu-system-arm and qemu-system-aarch64 binaries.
- *
- * One defined with DEFINE_MACHINE_AARCH64() will only be available in
- * the qemu-system-aarch64 binary.
- */
-#define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            type_target_specific)
-#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            type_target_specific)
-
 #endif
-- 
2.43.0


