Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFAC531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UQ-0004j6-4C; Thu, 23 Jul 2026 20:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UK-0004h1-KR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UF-0005tl-VD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeEwZ1069141
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cjEacicm7mB
 hmnwqthB6X7fTX5IMYyFBNAYcAqPL+CI=; b=CtmARL4OCw2P+vVPki31d3lvTYc
 Q7Isc2YSG83XtQ0lr064v8u+GUODGVVC/4qCHKH5yyG7bST96Uh/oSVZetLULeyB
 ThR+wBOxSksi5AOuN72KNVf7wub/9RR1vRQc0QiVrt1LuPHslNQnbDQnRyHtN9S3
 A9QBKkMamP547gIdOpigDCVsKauYAqibrGSje84jQId+VT09Nq2gzk5R1O//US6Q
 Iv3/PUD50q5JWcrtWso4s6+93WPtJXG8VnYRitptx1Ysrr7ro7xWByErC38F8dvb
 ZyJcD5K8YWd5rf8bnXhwy2K3OBjShNUGZPva0Co4ms+yUGfnyJ98K0uxKpQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg523f27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5cc1e13f8so1497353a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851798; x=1785456598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjEacicm7mBhmnwqthB6X7fTX5IMYyFBNAYcAqPL+CI=;
 b=iXsShGjVURZp7UhPlK2PfEME+KGuRcFafqOEs1MF0Hn2rsEkuJB6FI6JoJvu0hEz5/
 j7BtrsadAKIgBtpKfTFG3xNzQY9x3m2I8o5V8+4EflCReyMsCp5EfXv/Yk+p5G8BDw24
 8TmHIs4CgxQ7sz8lNU9XjddBQuzXZ3eOhyf+FHwcPbxueKKy29hWPOKeLhWB+/IbyAqs
 c80ct+gT5GF0Neguo0eZN7U+m/2pRtcf6zoDLuWTCpphcvQgawwDUVUNaYZPYKvGEG4c
 g9OEmD8rmAvQLFaikRVcoZ+P3jR9aKLGQsZ5t11YgqFm6i4sJkMHha2FBT2Y/8j3zuuR
 1oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851798; x=1785456598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjEacicm7mBhmnwqthB6X7fTX5IMYyFBNAYcAqPL+CI=;
 b=UlvQWzXPMYxnnj3Mx8+yLbXjVCoW0MOboRQCJhvMODnamUCupv0lgk0wy8BWc6Okbi
 G+OvYbun5SfjIToppc6HNDhw7I02Lt+kpMW95eiChM0s1itJLCuRp/XoelGSbSpJYpF4
 zwA1xcVTCtpHk9ePsTPcIB1Bvelis7ZdZk99y18Y73oFlTUSAlsRr9aMxcPHj6QfOgSN
 0JHW7xl772X3dNQ8hmtpe57wFBFboeypDcC5WtqKdvb+E2o98kUB69M3tE0tHylcRcQL
 WqQ1vcdONum/9ppyCSKHSCvvmOisTIGkjMkwXLGYcBrqijUvcGBqijRDbVJvvnX4xBuB
 xruA==
X-Gm-Message-State: AOJu0YzSdQ0bZnHrL0mbuHZomnEaGLm3hmHNMK6RUTRYcXJ/D3CLo2ei
 n4AXvUhAa2R3KdLrrfajzlOy58XbxM2uXaOSUM2/H5oval/ZMU9bCE3IntOepXZe6t0YfwXLzWs
 7dnFId2IuDnlRwIZ0s87/dfTeEkyiKzsQzp6xmJmRQ3Qty49rs7NhMsmRVGKIbkLhdA==
X-Gm-Gg: AR+sD125paHXpHzh0NYQRhJh+EA9AdmoG9YWmraPikkttHx7NjSJjaE/ef7ku0Cj3JC
 cDSPI/XbTm9pLoTeTHvKw/gwgoPW7BNfaxBgfRY+rf2oQ08QuzlRXPiXuRu9A+zbWauN/ZBqljU
 Ah/1FQ33Oyipis/0RDWRZfwpv8Hf/RyTLi6dmuN+ymByxwjorIVU9Dlp2sPgJ22O7lqoSkKgJ3p
 bd26PmSouOLfquIcpCTW/GKF+AtKCgOjxVRg6J1X7IaflzTznKvw7aog3zkecWBzsgMdutbrvkg
 WDxMDTfGDThSaBH0reeQVSSEhyQkmE5RFq+z8oNerRSg5Z+ROsvxQbB0IUVe5uFLp3yZZS3fEzb
 Iv3VUPHhgyJ8LvCPZDBwmj5YD3FwVH467Qp8E56+9U+3Z1Mkwtdyelho4WX+aBHcgoomHv7k=
X-Received: by 2002:a05:6300:4049:b0:3b4:8880:2089 with SMTP id
 adf61e73a8af0-3c44b0039b9mr5394747637.16.1784851797461; 
 Thu, 23 Jul 2026 17:09:57 -0700 (PDT)
X-Received: by 2002:a05:6300:4049:b0:3b4:8880:2089 with SMTP id
 adf61e73a8af0-3c44b0039b9mr5394690637.16.1784851796580; 
 Thu, 23 Jul 2026 17:09:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:09:55 -0700 (PDT)
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
Subject: [PATCH 02/27] hw/arm: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:22 +0000
Message-ID: <20260724000948.234657-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a62ad56 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ODOR55bGXPoUJ9Ge_p4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwsQN+3ju+GXm
 C9MKTsoRPcSPTTUtz47RfPWr7Y2srjVbshUCdIAsp9UA6Jy4xXyKPCp9nVh6NrTPYP5nwt+cfye
 vlEOZnKbR3cutGaa73NrraL/QQD0u+8=
X-Proofpoint-GUID: 7PCAyWJQrcVBCEtf0xNrTu3S82eeWEZE
X-Proofpoint-ORIG-GUID: 7PCAyWJQrcVBCEtf0xNrTu3S82eeWEZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXzcwYzTLgm1Wl
 Pm6Y/tIMIXlUYR1tc/FHUo8y9Qa1F+NJ5tLIPrJxmXuiYAa6FA9urhRR2f/MKR7rw7Myj7aYIsS
 dy64rGyUNYs1MJe3tnB4iKP8VJqLOVsqX9ScnTiqn7nJjnH0IThzV/BEvEbpQkaNJjvNXyq072J
 kR6tFtKGiZmd7cWRdVY09mgF42IRv5+5m8QhZu9ZGlCsBKhCh8lag9gkEsGKont442gWvgwbxI4
 B41QHoOPECQyAkGNgVGxNayMoMP2cbV5ArTnDBeoD+FrZS/zPfBVK4bV7rI5J6fVmitSD39A5Km
 WDQaD+4X60AmgcHnaejfFBR4fuAPiZ3n21WWGpUmz+cOtDrb7ErlTvyqJOh40UCF2UxvRHBfRHg
 m0fEbrQUVwxa5uqUdz32moa7z9/jsGh6TtRuJqu6nlDxJ0iZ9YLJ8ApTUoRx4lQwiAaXaK0cUv5
 tx7Xd/rD3yKxS01u5xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
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

For now, we still keep existing TYPE_TARGET_.*_MACHINE mechanic to not
break existing binaries. As a result, we add TYPE_TARGET_SPECIFIC to
list of interfaces *_machine_interfaces.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed_ast1040_evb.c               | 1 +
 hw/arm/aspeed_ast10x0_evb.c               | 2 ++
 hw/arm/aspeed_ast2400_palmetto.c          | 1 +
 hw/arm/aspeed_ast2400_quanta-q71l.c       | 1 +
 hw/arm/aspeed_ast2400_supermicrox11.c     | 1 +
 hw/arm/aspeed_ast2500_evb.c               | 1 +
 hw/arm/aspeed_ast2500_g220a.c             | 1 +
 hw/arm/aspeed_ast2500_romulus.c           | 1 +
 hw/arm/aspeed_ast2500_supermicro-x11spi.c | 1 +
 hw/arm/aspeed_ast2500_tiogapass.c         | 1 +
 hw/arm/aspeed_ast2500_witherspoon.c       | 1 +
 hw/arm/aspeed_ast2500_yosemitev2.c        | 1 +
 hw/arm/aspeed_ast2600_anacapa.c           | 1 +
 hw/arm/aspeed_ast2600_bletchley.c         | 1 +
 hw/arm/aspeed_ast2600_catalina.c          | 1 +
 hw/arm/aspeed_ast2600_evb.c               | 1 +
 hw/arm/aspeed_ast2600_fby35.c             | 1 +
 hw/arm/aspeed_ast2600_fuji.c              | 1 +
 hw/arm/aspeed_ast2600_gb200nvl.c          | 1 +
 hw/arm/aspeed_ast2600_rainier.c           | 1 +
 hw/arm/aspeed_ast27x0-fc.c                | 1 +
 hw/arm/aspeed_ast27x0_evb.c               | 2 ++
 hw/arm/b-l475e-iot01a.c                   | 1 +
 hw/arm/bananapi_m2u.c                     | 1 +
 hw/arm/collie.c                           | 1 +
 hw/arm/cubieboard.c                       | 1 +
 hw/arm/digic_boards.c                     | 1 +
 hw/arm/exynos4_boards.c                   | 2 ++
 hw/arm/imx25_pdk.c                        | 1 +
 hw/arm/imx8mm-evk.c                       | 1 +
 hw/arm/imx8mp-evk.c                       | 1 +
 hw/arm/integratorcp.c                     | 1 +
 hw/arm/kzm.c                              | 1 +
 hw/arm/max78000fthr.c                     | 1 +
 hw/arm/mcimx6ul-evk.c                     | 1 +
 hw/arm/mcimx7d-sabre.c                    | 1 +
 hw/arm/microbit.c                         | 1 +
 hw/arm/mps2-tz.c                          | 4 ++++
 hw/arm/mps2.c                             | 4 ++++
 hw/arm/mps3r.c                            | 1 +
 hw/arm/msf2-som.c                         | 1 +
 hw/arm/musca.c                            | 2 ++
 hw/arm/musicpal.c                         | 1 +
 hw/arm/netduino2.c                        | 1 +
 hw/arm/netduinoplus2.c                    | 1 +
 hw/arm/npcm7xx_boards.c                   | 5 +++++
 hw/arm/npcm8xx_boards.c                   | 1 +
 hw/arm/olimex-stm32-h405.c                | 1 +
 hw/arm/omap_sx1.c                         | 2 ++
 hw/arm/orangepi.c                         | 1 +
 hw/arm/raspi.c                            | 5 +++++
 hw/arm/raspi4b.c                          | 1 +
 hw/arm/realview.c                         | 4 ++++
 hw/arm/sabrelite.c                        | 1 +
 hw/arm/sbsa-ref.c                         | 1 +
 hw/arm/stellaris.c                        | 2 ++
 hw/arm/stm32vldiscovery.c                 | 1 +
 hw/arm/versatilepb.c                      | 2 ++
 hw/arm/vexpress.c                         | 2 ++
 hw/arm/virt.c                             | 1 +
 hw/arm/xilinx_zynq.c                      | 1 +
 hw/arm/xlnx-versal-virt.c                 | 2 ++
 hw/arm/xlnx-zcu102.c                      | 1 +
 include/hw/arm/machines-qom.h             | 2 ++
 target/arm/machine.c                      | 4 ++++
 65 files changed, 95 insertions(+)

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 2b93d4dfbc5..0b52612432e 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -61,6 +61,7 @@ static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index c19563d1f0a..ed858a35b52 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -79,6 +79,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
                                                           const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
@@ -99,6 +100,7 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
 static void aspeed_minibmc_machine_ast1060_evb_class_init(ObjectClass *oc,
                                                           const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 776aa43a45d..b3dcb559b4e 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -54,6 +54,7 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
                                                const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index 42ad2a2303f..04d5445bae6 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -60,6 +60,7 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 88cdb01fc76..ab16ffa4e3a 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -54,6 +54,7 @@ static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
                                                         const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 8b5cb67be9b..76b1d8dc5cf 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -41,6 +41,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3f979a78e57..e0ba88c47a5 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -65,6 +65,7 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 91b660e74bb..5031539f288 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -36,6 +36,7 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_romulus_class_init(ObjectClass *oc,
                                               const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index a2450aa9623..b2362d45d8f 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -50,6 +50,7 @@ static void supermicro_x11spi_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
                                                             const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 186dbc1da30..de0129a4991 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -63,6 +63,7 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
                                                 const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 28d437fec08..e77bbc6a697 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -86,6 +86,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index eaa75bcccbb..3ceda60c0f2 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -64,6 +64,7 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
                                                  const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index a1c8111a934..5ef86e175f7 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -334,6 +334,7 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
                                                const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index b7e84db1438..e3f3a383113 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -69,6 +69,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
                                                 const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 65495a524ea..269a2ac8332 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -637,6 +637,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
                                                const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1c..4c0dc6b625f 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -34,6 +34,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index f6244270704..bca31e5a0bf 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -153,6 +153,7 @@ static void fby35_reset(MachineState *state, ResetType type)
 
 static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e276..2790bee6ca2 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -111,6 +111,7 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index ad9a10110b8..5286d03428c 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -79,6 +79,7 @@ static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
                                                const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8f0a412ddcf..189cc4d2560 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -169,6 +169,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7d9fade68da..8915bfbc6fa 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -207,6 +207,7 @@ static void ast2700fc_init(MachineState *machine)
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ast2700 full core support";
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0ff1bebeb0e..8a1b2b22fae 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -31,6 +31,7 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
                                                     const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
@@ -52,6 +53,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
 static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
                                                     const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index ee789c8df94..d31ad5d9e04 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -113,6 +113,7 @@ static void bl475e_init(MachineState *machine)
 
 static void bl475e_machine_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char *machine_valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9b468cd8ac8..4fb19a83657 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -128,6 +128,7 @@ static void bpim2u_init(MachineState *machine)
 
 static void bpim2u_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 91f0a94b6ff..99482fb425f 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -72,6 +72,7 @@ static void collie_init(MachineState *machine)
 
 static void collie_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Sharp SL-5500 (Collie) PDA (SA-1110)";
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a643ae4e27d..234c1ea37fc 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -109,6 +109,7 @@ static void cubieboard_init(MachineState *machine)
 
 static void cubieboard_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a8"),
         NULL
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ed12f542001..fbcabaa3362 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -139,6 +139,7 @@ static void canon_a1100_init(MachineState *machine)
 
 static void canon_a1100_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "Canon PowerShot A1100 IS (ARM946)";
     mc->init = &canon_a1100_init;
     mc->ignore_memory_transaction_failures = true;
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 1b8c9b618f8..2caeb420246 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -157,6 +157,7 @@ static const char * const valid_cpu_types[] = {
 
 static void nuri_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Samsung NURI board (Exynos4210)";
@@ -178,6 +179,7 @@ static const TypeInfo nuri_type = {
 
 static void smdkc210_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Samsung SMDKC210 board (Exynos4210)";
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7ebd6c8eb9c..e60a7e672a4 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -144,6 +144,7 @@ static void imx25_pdk_init(MachineState *machine)
 
 static void imx25_pdk_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "ARM i.MX25 PDK board (ARM926)";
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e25..031f9348626 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -118,6 +118,7 @@ static const char *imx8mm_evk_get_default_cpu_type(const MachineState *ms)
 
 static void imx8mm_evk_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_aarch64;
     mc->desc = "NXP i.MX 8MM EVK Board";
     mc->init = imx8mm_evk_init;
     mc->max_cpus = FSL_IMX8MM_NUM_CPUS;
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 16e9722d146..897f1b91d0a 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -144,6 +144,7 @@ static void imx8mp_evk_machine_init(Object *obj)
 
 static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "NXP i.MX 8M Plus EVK Board";
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index c25bbf3c82a..cf95c3f57d4 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -686,6 +686,7 @@ static void integratorcp_init(MachineState *machine)
 
 static void integratorcp_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "ARM Integrator/CP (ARM926EJ-S)";
     mc->init = integratorcp_init;
     mc->ignore_memory_transaction_failures = true;
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 168ecf35d09..b49841ca87a 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -134,6 +134,7 @@ static void kzm_init(MachineState *machine)
 
 static void kzm_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 530ca9dd964..4453868e562 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -38,6 +38,7 @@ static void max78000_init(MachineState *machine)
 
 static void max78000_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 6e9d92b1f1d..299e797fd48 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -71,6 +71,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
 
 static void mcimx6ul_evk_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index a0ac647c3df..a94218ac1b1 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -71,6 +71,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
 
 static void mcimx7d_sabre_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 9d5c4898469..50d561aa246 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -63,6 +63,7 @@ static void microbit_init(MachineState *machine)
 
 static void microbit_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "BBC micro:bit (Cortex-M0)";
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f101c1b7c3b..91e66f82b69 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1307,6 +1307,7 @@ static void mps2tz_set_default_ram_info(MPS2TZMachineClass *mmc)
 
 static void mps2tz_an505_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -1341,6 +1342,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, const void *data)
 
 static void mps2tz_an521_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -1375,6 +1377,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, const void *data)
 
 static void mps3tz_an524_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -1414,6 +1417,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, const void *data)
 
 static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ac9366d8447..55fd22a85d2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -481,6 +481,7 @@ static void mps2_class_init(ObjectClass *oc, const void *data)
 
 static void mps2_an385_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -500,6 +501,7 @@ static void mps2_an385_class_init(ObjectClass *oc, const void *data)
 
 static void mps2_an386_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -519,6 +521,7 @@ static void mps2_an386_class_init(ObjectClass *oc, const void *data)
 
 static void mps2_an500_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
@@ -538,6 +541,7 @@ static void mps2_an500_class_init(ObjectClass *oc, const void *data)
 
 static void mps2_an511_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index caad820d3bc..687f74f9ec0 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -593,6 +593,7 @@ static void mps3r_class_init(ObjectClass *oc, const void *data)
 
 static void mps3r_an536_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MPS3RMachineClass *mmc = MPS3R_MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1ada1a13613..44c68bffac6 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -99,6 +99,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
 
 static void emcraft_sf2_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 75d82eebcac..e6736efa8dd 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -612,6 +612,7 @@ static void musca_class_init(ObjectClass *oc, const void *data)
 
 static void musca_a_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
@@ -626,6 +627,7 @@ static void musca_a_class_init(ObjectClass *oc, const void *data)
 
 static void musca_b1_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 69e83bdd973..d9aeb98b6f0 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1347,6 +1347,7 @@ static void musicpal_init(MachineState *machine)
 
 static void musicpal_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     mc->desc = "Marvell 88w8618 / MusicPal (ARM926EJ-S)";
     mc->init = musicpal_init;
     mc->ignore_memory_transaction_failures = true;
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index c32deaf43ba..a721da02ce0 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -55,6 +55,7 @@ static void netduino2_init(MachineState *machine)
 
 static void netduino2_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index a90dcbe8c26..ee5f1679426 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -56,6 +56,7 @@ static void netduinoplus2_init(MachineState *machine)
 
 static void netduinoplus2_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e6..573180f873a 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -475,6 +475,7 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, const void *data)
  */
 static void npcm750_evb_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -488,6 +489,7 @@ static void npcm750_evb_machine_class_init(ObjectClass *oc, const void *data)
 
 static void gsj_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -501,6 +503,7 @@ static void gsj_machine_class_init(ObjectClass *oc, const void *data)
 
 static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -514,6 +517,7 @@ static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
 
 static void kudo_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
@@ -527,6 +531,7 @@ static void kudo_bmc_machine_class_init(ObjectClass *oc, const void *data)
 
 static void mori_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857c..c8335091a7e 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -227,6 +227,7 @@ static void npcm8xx_machine_class_init(ObjectClass *oc, const void *data)
 
 static void npcm845_evb_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     NPCM8xxMachineClass *nmc = NPCM8XX_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index e801e4308ed..58a124d3c06 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -59,6 +59,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
 
 static void olimex_stm32_h405_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index bcb7105323f..59670d31af8 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -205,6 +205,7 @@ static void sx1_init_v2(MachineState *machine)
 
 static void sx1_machine_v2_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Siemens SX1 (OMAP310) V2";
@@ -225,6 +226,7 @@ static const TypeInfo sx1_machine_v2_type = {
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Siemens SX1 (OMAP310) V1";
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d84443bb7b3..53366a76334 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -106,6 +106,7 @@ static void orangepi_init(MachineState *machine)
 
 static void orangepi_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a7"),
         NULL
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428c..e0e597d55ef 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -339,6 +339,7 @@ static void raspi_machine_class_init(MachineClass *mc,
 
 static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
@@ -349,6 +350,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
@@ -359,6 +361,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
 
 static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
@@ -369,6 +372,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
 
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
@@ -379,6 +383,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
 
 static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 06aeb8db014..c8a2463ec8d 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -108,6 +108,7 @@ static void raspi4b_machine_init(MachineState *machine)
 
 static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2b9f3271d62..005f737b68c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -415,6 +415,7 @@ static void realview_pbx_a9_init(MachineState *machine)
 
 static void realview_eb_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM926EJ-S)";
@@ -436,6 +437,7 @@ static const TypeInfo realview_eb_type = {
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Emulation Baseboard (ARM11MPCore)";
@@ -458,6 +460,7 @@ static const TypeInfo realview_eb_mpcore_type = {
 
 static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard for Cortex-A8";
@@ -478,6 +481,7 @@ static const TypeInfo realview_pb_a8_type = {
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 84bbc2f9798..4ea4cda36ee 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -137,6 +137,7 @@ static void sabrelite_machine_instance_init(Object *obj)
 
 static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e8..5608263a810 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -905,6 +905,7 @@ static void sbsa_ref_instance_finalize(Object *obj)
 
 static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a57"),
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 56ecc828f4f..4b7dc5c45a3 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1416,6 +1416,7 @@ static void lm3s6965evb_init(MachineState *machine)
  */
 static void lm3s811evb_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Stellaris LM3S811EVB (Cortex-M3)";
@@ -1437,6 +1438,7 @@ static const TypeInfo lm3s811evb_type = {
  */
 static void lm3s6965evb_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Stellaris LM3S6965EVB (Cortex-M3)";
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 8f93c0036a3..53b4632c013 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -59,6 +59,7 @@ static void stm32vldiscovery_init(MachineState *machine)
 
 static void stm32vldiscovery_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m3"),
         NULL
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c6991a52e65..3437e014cd4 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -414,6 +414,7 @@ static void vab_init(MachineState *machine)
 
 static void versatilepb_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile/PB (ARM926EJ-S)";
@@ -436,6 +437,7 @@ static const TypeInfo versatilepb_type = {
 
 static void versatileab_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "ARM Versatile/AB (ARM926EJ-S)";
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f26d8c6f8d1..13d76597893 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -797,6 +797,7 @@ static void vexpress_class_init(ObjectClass *oc, const void *data)
 
 static void vexpress_a9_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a9"),
         NULL
@@ -813,6 +814,7 @@ static void vexpress_a9_class_init(ObjectClass *oc, const void *data)
 
 static void vexpress_a15_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a15"),
         NULL
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 219597cabd0..f55366b4d07 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -119,6 +119,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         ObjectClass *oc, \
         const void *data) \
     { \
+        TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm; \
         MachineClass *mc = MACHINE_CLASS(oc); \
         arm_virt_compat_default_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c834390174..6861fe91774 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -455,6 +455,7 @@ static void zynq_init(MachineState *machine)
 
 static void zynq_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a9"),
         NULL
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2b04513ba2e..c40b8376947 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -367,6 +367,7 @@ static void versal_virt_machine_class_init_common(ObjectClass *oc)
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
 
@@ -379,6 +380,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 
 static void versal2_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
     VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4e489702743..ff98827f83a 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -269,6 +269,7 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
 
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_aarch64;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs based on " \
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 3ed39384e59..37fb64bf479 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -10,6 +10,8 @@
 #define HW_ARM_MACHINES_QOM_H
 
 #include "hw/core/boards.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 89127e5d83c..60501d17911 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -10,6 +10,7 @@
 #include "cpu-features.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
+#include "qemu/target-info-qom.h"
 #include "target/arm/gtimer.h"
 #include "hw/arm/machines-qom.h"
 
@@ -1348,18 +1349,21 @@ const VMStateDescription vmstate_arm_cpu = {
 };
 
 const InterfaceInfo arm_machine_interfaces[] = {
+    { TYPE_TARGET_SPECIFIC },
     { TYPE_TARGET_ARM_MACHINE },
     { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo arm_aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_SPECIFIC },
     { TYPE_TARGET_ARM_MACHINE },
     { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_SPECIFIC },
     { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
-- 
2.43.0


