Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2A0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YP-00015D-FV; Fri, 28 Aug 2026 19:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YC-0000ex-H0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YA-0005mL-Nd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMUQmi3188763
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MPke/FrRqqv
 joPk4kAXg27sB+UyqhKwA4oS7m5OSx8E=; b=ke3jaN90r4OECPlZzpggTRc92gd
 taPrPK/ED7GXuglmcOMVMmFxSmY7v3cX1twT57UNtSz5BvLU9ZNCBZDu9Tqo6q0v
 eYtaR7uuSMQdD3ycZQhwRBVLQ3BVb0YqnOyWm36zHip11J7NMecqQ81KeGtvfvUu
 XfFnb3mofxw7IeAsOmv3J9P+UG+bKYuTBftnjdPxohLUdXxrp+NAXC/6oHvEh/sq
 awq8gGURFP523E/5IDM3jM90CfJWLftioW8iIRllvX0YQ8qb9iWvEyjBWkJp7ICn
 oodAZvcEeT0xgsmHJUoI6sBCcZN9vMYSXLO49exsQxoCYYoXkt4AnmgApLQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9t2rs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso3258829a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957982; x=1788562782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MPke/FrRqqvjoPk4kAXg27sB+UyqhKwA4oS7m5OSx8E=;
 b=QNorCUNpFDD9JWv01+EpkN4VewLcQ159nENImc8FansSlkeq1NxvBd0kDN/8izEOVW
 xh2tm6pDP2lv4uUfLmzVLJPr/mcAiUq+ZsI3KdOlEPIEhrTn5Jum+jZQmoisyqdenNpN
 wxHVonWUJH8k3HSHKhzer7F+mOWZlyKcnIOJOLsnKAZvMMzxcHvxMGKIeBMhbhOnchJv
 5ShP1NyDekMOJwVQiAwzDEq2rfqwUyYCFYri/0rnYciQI4mpumZiUc/2shp8yR0xxV1I
 zKdCYWcJCIs+Ui3kf5ge5DnmBsW5L9k/wnmr1gXo0kRmC+V34MxpgrJr54FpmE/LUtZM
 ABqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957982; x=1788562782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MPke/FrRqqvjoPk4kAXg27sB+UyqhKwA4oS7m5OSx8E=;
 b=oKQNczPBCQcM8tAEqo+yLucGwoCOaZkg0i8Zvd3ZxDpbkRoGO7HiOXwaBGLTSva4nh
 ET5np5aQSHRc6mM2YK8ZVw6sxxyS+OjgHKQPal0EoC4TqZTN2WsHUM5prjt+sDLUOOau
 9i/A2DnBRu1BeqHFecssWqtJKFUwNn8nppUFFfkd9Qtr4CjLJV/7ixxsdnqASrkARA+O
 zm+mQVnu3jnFYAOb09mjWWsdpHFHT5yJFuK3Jt8Mrw6eK50/sGd9ZJxUICcElQlFHC5v
 ps/Nr6kiiPAlsXd1O21FQ1h0ARcPSLdjQQio0Xt6dpM99yeZq/m1Aou29CuayzaBRbgv
 /hXg==
X-Gm-Message-State: AFuF++nA2iY7d1GT7OoY6F7MtrtciBPHpcWwnbgGx0Gg2spachapl4bO
 Po3W2kwnC/u5di3GSt6H3S5URHrM6XVH+WaZx/ZFaEVkroxhk6sK960iaLAO6keHMTXx7FHwAKY
 cXqO1X4SURogOVAu5/i3N4u5A3LARSwWysNWsCjPxXLgLEcEXqCIv5nLhS0Sb2kFoEg==
X-Gm-Gg: AR+sD11K5hiQ4JgB/fvN/GmP5EcdKxAVoDUqSWd+x5jgRV1rRlk1o0NFDmYBwPC8BQc
 afTrET+XPKvcaktl6pcJEZO01lTV1MvVw54k6MLcmeS67UkNXcRttP3/YdjvOYIfotY/fOP6aEK
 HGlmtSDRmb1sVh6enHzngRpp3fXcx5nLxZH90x6ilFLpTskYLdRRMaWHSropcdjvDJQnVczpJ4S
 7CNMHgjqMQohMFR84hOmRw1CDR6ZsRjtJ/I41Bqk7frSpGQS7tp6Z0rgsx9mUKsNZ52iOiR2ow7
 5KH1fsVC/Pa9vTNlAm0PUflJiuvFwY+70eFa9V9PzPcfnK5W+oqLuyhWzhI4zKkOm8Nl9LYhKt3
 6Ho7hqDjvRVJmXa1R0EUutp9BPZVp37lyGW9sWdiV0hUaULm8lzHrK/2QtbY=
X-Received: by 2002:a05:6a20:2d22:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3d265a33636mr22384903637.5.1787957982405; 
 Fri, 28 Aug 2026 15:59:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d22:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3d265a33636mr22384846637.5.1787957981987; 
 Fri, 28 Aug 2026 15:59:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 27/47] hw/arm: filter aarch64 only machines
Date: Fri, 28 Aug 2026 22:58:41 +0000
Message-ID: <20260828225901.367438-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a9212df cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=a9BU0SSPyKAHbAg0NpwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX0rXy91u7QQ9L
 VnFIfzxbTRevXTX7LfZYe7lBxiuzy27h3gkR+Kg6/+Cha2Rald9QOkukNCUBqAVYBKIds8rGgl7
 RZxsq8B4p8W+2cpe+dNIFgJ53rBb6rQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1TVEpdHdZziV
 65cCkrJkvGIfph5/Us82x6jgxo8WETGhYAuEipWdQIcHGTSzTaPPvpISLPGPYfrEmdT6oqWLpZD
 YSkZwavFGX9h0HyyH4odpaElHBzvFZA8DbI6T1+wmPpYRzXbIzA8IFYZiKmyRl69lL11y4TUR8E
 4IAb8G6WiVjvss8VA4qiz+IHyruZ+X6wNHyfCPyDSKITt1areNMZWC8x1lUqPSpdWCx8YbtWB8O
 wjRTNVMdGODJgpQoTspLO5dZD6OGURUfFBE2Fv65GYGf1EuX+EQ8X9PjaHUrohE0rJn2bm9+OMD
 gVsywzKaDN4AYacpgvIS/ZpM/t4rPTrGs8VYO3ipWi6W9jpR3ppzjHZMMTi+eeqU7hqWUct55Xl
 jJhxbYozDOuOcINFh/TRZsbk4vakM9etAqOseD5WgOZfdvNFabzD1TeiXlhhr5Z6+1Cp7lRdORP
 ZjFjN87OiRtdjHWa6Dg==
X-Proofpoint-ORIG-GUID: 1iDTTYExGQ925Kzq9ia52GLjgOKBZBok
X-Proofpoint-GUID: 1iDTTYExGQ925Kzq9ia52GLjgOKBZBok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

We know have all the machines correctly filtered when mixing arm and
aarch64 targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/ax3000-evk.c       |  1 +
 hw/arm/imx8mm-evk.c       | 18 ++++++++++++++----
 hw/arm/imx8mp-evk.c       |  1 +
 hw/arm/npcm8xx_boards.c   |  1 +
 hw/arm/sbsa-ref.c         |  1 +
 hw/arm/xlnx-versal-virt.c |  2 ++
 hw/arm/xlnx-zcu102.c      |  1 +
 7 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
index a1708488710..191610fc075 100644
--- a/hw/arm/ax3000-evk.c
+++ b/hw/arm/ax3000-evk.c
@@ -21,6 +21,7 @@ static const TypeInfo ax3000_evk_types[] = {
         .name          = MACHINE_TYPE_NAME("axiado-scm3003"),
         .parent        = TYPE_AX3000_MACHINE,
         .class_init    = axiado_scm3003_class_init,
+        .is_available  = target_aarch64,
     }
 };
 
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 8a5737502fd..d1f8c8ee215 100644
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
@@ -133,6 +135,14 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
-                        imx8mm_evk_machine_init, false,
-                        NULL)
+static const TypeInfo imx8mm_evk_machine_types[] = {
+    {
+        .name = TYPE_IMX8MM_EVK_MACHINE,
+        .parent = TYPE_MACHINE,
+        .class_init = imx8mm_evk_machine_class_init,
+        .instance_size = sizeof(Imx8mmEvkMachineState),
+        .is_available = target_aarch64,
+    },
+};
+
+DEFINE_TYPES(imx8mm_evk_machine_types)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3f376f86d91..a16243a1e4a 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -161,6 +161,7 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .class_init = imx8mp_evk_machine_class_init,
         .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
+        .is_available = target_aarch64,
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 4b3af165034..ca12ba2d6cb 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -248,6 +248,7 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
+        .is_available   = target_aarch64,
     },
 };
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 158b461eb48..e7e1f93e367 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -945,6 +945,7 @@ static const TypeInfo sbsa_ref_info = {
     .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .is_available = target_aarch64,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 4018f2bf7d1..02fe4794a5e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -401,12 +401,14 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
+    .is_available = target_aarch64,
 };
 
 static const TypeInfo versal2_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal2_virt_machine_class_init,
+    .is_available = target_aarch64,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bb596218540..04903b59e2b 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -302,6 +302,7 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .is_available = target_aarch64,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.43.0


