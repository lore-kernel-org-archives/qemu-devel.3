Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687BFC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyi-0002Me-1Z; Tue, 01 Sep 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyf-0002Lo-T3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uye-0003Wz-2j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgIfD2691984
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pDeRBxB6m3+
 iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=; b=SLbWmE7UqUkabCTiHZXLIR4uK6l
 MK/oMV64aZLbt2J3YAbdzw2HlOJgvKreL7FVVUmdcAKDkLF7BsHivjq1wqhD/i8q
 CrqBRhidXKHlxuozLfptsV5byq41giIWDlh9yJmW0SstfY6zZmCEiz1e/OIarOsy
 dlIu5lKSu6TNdgr340NcyVmUlueBjZ+DuQUhV4YsbOVQeennR6ZQ5XZjlyutnGoX
 3D9mkDHf05YqGndVGaSaAlyi1700OeyBILMQoXUxnqjNUrBHGmy9TMqo0yLSNVvG
 Fgm313eXxbfAj7sXpQA/Gx5BDs+2RoOQRoZFNRBmiEONxeP5H//jNMUblVQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3978kd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:21:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so341136a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294062; x=1788898862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pDeRBxB6m3+iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=;
 b=D9i/HimpE9Z/rHPj+Vzb1itChyEuiKI1ULCezauoGco3I4J860teOEBswB0uT+bkCI
 9kuqycktFtlB9eh9NtObtmJtNh8lqYKIxzUuY2wVU8QNt4wIh9hjnOxewGLXte6bJKVl
 rXbVDUCNnPhX4m9g83V0y8KbWfyj8zAI0wY7lekT9Bdy5N2xvNLZeWhNx7T019TRMDZ9
 3IsjfOf+enx0efp8i/DA90q//XDMKteZErxXVh6G0FmVgvSr17vOSIcR627CahPO3RNJ
 cD99UHXFJaTinzBEOaf7tNaS80SkYbC+mvu8qcbZalKg9JchG2l3guUlZLtaWEGGufkj
 BrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294062; x=1788898862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pDeRBxB6m3+iNa7JaKPFdusxJKbbtba5ZHP1UF2GRdE=;
 b=Hag8S+FBQeoqx9Ay0p28eJwZ7CoHNYPG3ja8bvkKXTaUw3X4IQGzNTAVMvGpuhjqkR
 ZqFbdq/iNGhS3qE+M6x75CTA28tucUtVt72yf0/Agn3qKHCDQ2JAvdz540PYnrl8PBqC
 xI5UZzfmTRqgG944vEDU44iZuiNs9CSMowbbIzErmTSP4zwRs6+izYs1U2Qziz2rOxYl
 YGfUWmweEJcJ3tWGHREZxax0QdPaECFA9vTrXc3trS30RwVVFPOV6GUK20YD8g0qRBwk
 Vtze//CcjNWpGXKHjdJWnXutadjTc36vVK7b5KbV6DdiF+98138zhk4D8YgepPxrRRo0
 8r0g==
X-Gm-Message-State: AFuF++lp9yGCRLSMNjFG3PT8GBNVS9yoFefcCqnZ7eXTkW0w5CzjXKbl
 rA7LpGBGqfyBYcOw6qnRy7ORe9uqvOcTB0SHtMWOwlAzxeCwF32G9J3s/XwkvsAZ98Z7xKclAiX
 pAo0kbESjC6Phg8P3fZNyBoplE8h176Be55Yyi2ZBv/RWaCI2UvlMt0qB9Zf3QrEZfA==
X-Gm-Gg: AYBFou2AdQQQoV9dXBKeS83qBwIqgs308VmsRZ1HKvEEpWc44nFMqt2I0PezTecU+UT
 IDhcf8CWZRR2XQKeT4R+CogvMUg/mVp//as+LkopY9UW8QphvX5y7XrpPu5Cfv8tA4//9qmyeYm
 vqF8T2mK6tYLgIr38+Psg0E2G8zqlq3UWpYgoDTmix3BsDTno3E3kvaJlLCqVRczwGX9bHdc469
 pFhoSm/LsGxKhOpNn2QUK/wtvrp90koTxzMyrXiZau8iQsKGxOIcR9/vDy/At2GBRcazHn6ERx9
 /METpNNZLaAnbQQ367HrQwLgs4zztlQOrvW1LaNO+lhIfnXn5WpGFOeKlhLY2/52icVVEfihcgS
 vYRuMvdHowpUe4hmaUstzRmQQYyvd3rV6pXrOBq/8EvTrugG5/09l3CP4Lz8=
X-Received: by 2002:a17:90b:582e:b0:398:9be9:ab8e with SMTP id
 98e67ed59e1d1-3989be9acb8mr40524188a91.19.1788294062032; 
 Tue, 01 Sep 2026 13:21:02 -0700 (PDT)
X-Received: by 2002:a17:90b:582e:b0:398:9be9:ab8e with SMTP id
 98e67ed59e1d1-3989be9acb8mr40524022a91.19.1788294061478; 
 Tue, 01 Sep 2026 13:21:01 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/14] hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
Date: Tue,  1 Sep 2026 20:20:40 +0000
Message-ID: <20260901202043.26532-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX/01pazEYa0Ww
 bkcmoHnZvZ+/7Oga0URl/jBl4UFN5O36T0n2Qk7IdIp5TV+2barzjtU5tdrugwSLu2oW4zuXkvF
 t8O881iqizd+JwhwMKtZg3cIRvMrwZ/zdiuNu7r+pNh2EIQl3BgY2g5LhsXt/rydLvsOfnHpEko
 ws0wZl9penqtj+tG+MTDs4TswhAGEILq4raUG6PBOleExDhXPizXzyOvZwvTxNhBmM4grkD6WLJ
 aaZA9CubdYjhEJpsOcPYq2u48Rhwepd/KIDRUG8xQSp94PkQgK/OJC9VGSh/HLa2k2CvLrkmwvr
 wujpbdNy72WDEm4RuSKK9CsLpk0s7dzJd2oUMQoZK2yWokT4Dw4b/cUZwIyb3Y8RRLq6RNdm5DL
 PXRx2Rk7p4Wcd6zKiDB8+vI6Ac9ZMfslWL1kM15Btd3pzFhd3VP4XjxYedMw3bFjWSsRGF7fSWN
 4Y2xoHYLDoASbAgwy4w==
X-Proofpoint-GUID: RIW-N1Bj0OGy_9I4stAapGAad8VRqsba
X-Proofpoint-ORIG-GUID: RIW-N1Bj0OGy_9I4stAapGAad8VRqsba
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a9733af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=w3swJZ6BnakM07JXKC0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX+hcEJGpLhSin
 V2Vm2SWFkAhbJT9C5onOwOS0Tw52WmG+yoWh660tkk9rTD0shOIyS2SB3889fkz71sIgUMhQwPD
 b2iyyych9Asf/91tWM/dgzV5fu88OMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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
 hw/core/null-machine.c          |  5 +----
 hw/riscv/virt.c                 |  2 --
 include/hw/riscv/machines-qom.h |  6 ------
 target-info-qom.c               | 13 -------------
 target/riscv/machine.c          |  4 ----
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2aa748233b3..2f008c4a702 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -56,7 +56,4 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_RISCV32_MACHINE },
-                               { TYPE_TARGET_RISCV64_MACHINE },
-                               { })
+DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d1..d2ae321a376 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1811,8 +1811,6 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_TARGET_RISCV32_MACHINE },
-         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index ee346227bb2..6c0bbdfc159 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,12 +11,6 @@
 
 #include "hw/core/boards.h"
 
-#define TYPE_TARGET_RISCV32_MACHINE \
-        "target-info-riscv32-machine"
-
-#define TYPE_TARGET_RISCV64_MACHINE \
-        "target-info-riscv64-machine"
-
 /*
  * Interfaces specifying whether a given QOM object is available in
  * qemu-system-riscv32, qemu-system-riscv64, or both.
diff --git a/target-info-qom.c b/target-info-qom.c
index 7959853e0da..f98d3d7698e 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -14,19 +14,6 @@
 #include "qemu/target-info-qom.h"
 #include "hw/riscv/machines-qom.h"
 
-static const TypeInfo target_info_types[] = {
-    {
-        .name           = TYPE_TARGET_RISCV32_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_RISCV64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-};
-
-DEFINE_TYPES(target_info_types)
-
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
     TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 31c49ca3e6a..59676c94470 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -582,17 +582,13 @@ const VMStateDescription vmstate_riscv_cpu = {
 };
 
 const InterfaceInfo riscv32_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
 
 const InterfaceInfo riscv32_64_machine_interfaces[] = {
-    { TYPE_TARGET_RISCV32_MACHINE },
-    { TYPE_TARGET_RISCV64_MACHINE },
     { }
 };
-- 
2.43.0


