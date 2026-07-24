Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3059BC531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Up-0004yI-Cf; Thu, 23 Jul 2026 20:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Un-0004xc-FM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Ul-0006A0-Qu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeV2L1237280
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hYirYAoBuHf
 G2QJM05Sl/s22RyNBX3SNqmBgTNzqJig=; b=R6v4HaJyCHM8ERPuwRegJoc7Dcj
 Ocvgq+KfR4yZHrzK2n2ctTH+sdl40vzt4d5pD6859OJAfotwCsBCkzXCjk6PlNvw
 fgGihisD3xJyNTxl5U/UsbKh/bPSA097x1LF9SP4I7GnK11qxh5oMWtiEYn+kvZ8
 sqlVAWIWcckil2KC4A8Hx97thsDyBl7NzUlMj3enwiyKFXRKkOxG+bepYzAQ8YMt
 uwtvAMBRQ0aiPTytsEqzg6/PGxPsU+2o3UfxoRfpfx3Shu+Zh8dcfZ3pJu4a2Q8/
 poBLR06JqDAl4hK+k0tu1CdpzpKGztSZq3HZ5QFPZWjWTCJY67y7iHdXOcA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so2304958a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851820; x=1785456620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYirYAoBuHfG2QJM05Sl/s22RyNBX3SNqmBgTNzqJig=;
 b=JpQm5NHInD84IDfX8DqZOq46wu4qtzAb8NBhxteMOzhZ3TQhpRh3MPImwoDy908fsJ
 F2Q1NsozyfNU0gT1dewCx+Lc1BViW8VVh+49JzDAG/ahEr5LJ+K3k41n2uKqL+ml/ybS
 v4qWVtlHkeaXF5+5ihaU5xBS+fGfxHSD6W8HNztvoHmiXPZ6+6OfQiFpvwbyg1Dpy+V2
 7KcVw3HYEOQ/u/msDLpcMXzSvXojZ/fUa45uxDHwYPwB2Yp1HLT0lAiTkR0dQh/biu2p
 Hf3zZKtcJs0t+dh/aQGTCwGKhft1HwORM4Jgx26k+C9zZyp54el9yODDy4SabysQL5uG
 cJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851820; x=1785456620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hYirYAoBuHfG2QJM05Sl/s22RyNBX3SNqmBgTNzqJig=;
 b=k8jRBAkO+oXnBqtXtjqmGp8D9nTgJj2qnIkQyct6ywlrfAFdfoFomG49CAN4DIFx9T
 HG/MUflVnTi4ixxRklw9Y6nELP3XDtVkktDeLmvdubtdh4XsrRNByuvLannx1yavgPMS
 qySNhxRB7gPn5QHBmVhsR0fsjmPCtFe2IaYIK8kojJSiFa8uJj+ZDa8fWyyTaZJ+EKP0
 0nyz1h6M2MraiwqqCEeIKCYUTzYnOZQQwtroJvZQXOi1VohQE2Lt+BAmffWgbMZ82veZ
 NT8YhwqghpPjnR/pZcEUFfOOpNlORpu5ED5TWQ8GevitESTL8uU30F04U+AVweLRbyBT
 pz1g==
X-Gm-Message-State: AOJu0YzrXZ07WvBkPoQD7RxYGxjXC8KtwyCO7929SIn9PGCZcOJFU9zT
 2yc7CaK4RmQyiPE1yBTfvANqLzkGy0+EdNhs0hYU41Gfq1wYMoCMlwYPmel9Ey2r99mDajF6LxW
 sRNQZ9fFvTldhkOVcwiHMCo3Lnd7FX0H5V/CDm7yyT1Z/9IvA4/6sZNqBCKQciyHkfQ==
X-Gm-Gg: AR+sD11S1yNAnZ5fP9u8egMMLZoowxjRlmggBtD04b6pL5WoG2K90Gm7E9EzVnV/VXy
 RJXwc3QBNoNPm7u/Fu7lIhzj9aW+743BmERrf7Zkb8Y/NPwUSQ6YdsRkOkEzDlAwrpJl2VL7cC9
 2BIMBIA4II5ZZ9la7FJe6sXyaTDH+dK+SsqfVKO5pzss31MA6o2vL95KwIj5E1N/f8QVVqZn82f
 LQ4okNkoZkyJCgLLP4RWYx9SFdTj5zWQ9plvCqS4cSoydYoTkc+cprAto2WY53HSE3r1lfc4rS5
 cnEsO//AlIRYn7+8C1LfgrSkkYJ5u0XWCSUWv+EXJme29qP2RykzD6OTb/E8/Xo9QAQvOLlF8fK
 NU0NO1oE05O4A+SWTAz+jgdhm+MaBy7abuk69UcFDy6Koypa9FUztDpzpJvc76FEwG9EY+GY=
X-Received: by 2002:a05:6a21:4c11:b0:3c3:8c88:7b29 with SMTP id
 adf61e73a8af0-3c44b005f54mr5908212637.16.1784851819936; 
 Thu, 23 Jul 2026 17:10:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c11:b0:3c3:8c88:7b29 with SMTP id
 adf61e73a8af0-3c44b005f54mr5908188637.16.1784851819616; 
 Thu, 23 Jul 2026 17:10:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:19 -0700 (PDT)
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
Subject: [PATCH 17/27] hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
Date: Fri, 24 Jul 2026 00:09:37 +0000
Message-ID: <20260724000948.234657-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/ZvZDmLa1hP/
 3pf+89Qvh9ZDsANRs7rpphDBo6Tk+/MbHBhidF+hVEgzcu66VtoIDrGIPZ8ZM0V1VD8XiH5CLbF
 TcuLdcvVPsRL/W5UxEGM94FvHWXSbiw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/8XyLbH+3d3A
 dbwAFsevsT/CHY8X3fTqFEd9gW/JVYl9D4S28XiFWhgcQeD+UyDzXwV60S4j50d10amIMsr3az4
 6Hc+vQnXm53SyU2bfpQjlnxG31n4bOCMhJtceCnA8CC8USBhGSmTowTwfhNBOQCH0op650vTQfB
 /EOAyIkkfS2XOZrbjPCSug+RTYwA65Ikxhm+kWxs52mKOuWrv4D/9y1bNNdOih29U0mKUpJk8QP
 8qyHySMV6yferJJJxYwhqf1IRvOVLwjvSAkrJAOaKfiGR3oKHFitIVasUEa536RIFnVupB8BlWr
 o1mlZDmAIJs8BSZsmMDt4vVFRecATgcXzmoFxyFklqhGWjzNC/n+4xNtfj2+52DwhCCK/ebSEyp
 /Z14udaGflthwFllOwnqFsYhNHLUFZhZjNRAJtOQu8cRLUxgUgcSyXXrv2uRORqVsFI+/+ZZA4i
 slNqwH8ZDhfb18CSUUA==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad6c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=SalYC_UygP5POjnEfZgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Du8IIL9p02BVZ6RMJvGU-FLSxhuOpXHu
X-Proofpoint-ORIG-GUID: Du8IIL9p02BVZ6RMJvGU-FLSxhuOpXHu
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
 hw/core/null-machine.c        | 2 --
 hw/nitro/machine.c            | 1 -
 hw/remote/machine.c           | 1 -
 include/hw/arm/machines-qom.h | 6 ------
 target-info-qom.c             | 8 --------
 target/arm/machine.c          | 5 -----
 6 files changed, 23 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f132a7b89b4..c1ecf3214fd 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -58,8 +58,6 @@ static void machine_none_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
-                               { TYPE_TARGET_AARCH64_MACHINE },
-                               { TYPE_TARGET_ARM_MACHINE },
                                { TYPE_TARGET_RISCV32_MACHINE },
                                { TYPE_TARGET_RISCV64_MACHINE },
                                { })
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 79d57664886..2d001a32fe2 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -266,7 +266,6 @@ static const TypeInfo nitro_machine_info = {
     .interfaces = (const InterfaceInfo[]) {
         /* x86_64 and aarch64 only */
         { TYPE_TARGET_SPECIFIC },
-        { TYPE_TARGET_AARCH64_MACHINE },
         { }
     },
 };
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fa750368df2..932d14e53e9 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -151,7 +151,6 @@ static const TypeInfo remote_machine = {
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_TARGET_SPECIFIC },
-        { TYPE_TARGET_AARCH64_MACHINE },
         { }
     }
 };
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 37fb64bf479..91b2c57c6d2 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -13,12 +13,6 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qom.h"
 
-#define TYPE_TARGET_ARM_MACHINE \
-        "target-info-arm-machine"
-
-#define TYPE_TARGET_AARCH64_MACHINE \
-        "target-info-aarch64-machine"
-
 /*
  * A machine filtered with arm_machine_interfaces[] or
  * arm_aarch64_machine_interfaces[] will be available
diff --git a/target-info-qom.c b/target-info-qom.c
index 9089ef336a7..d7b8fbd4fcd 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -27,14 +27,6 @@ static const TypeInfo target_info_types[] = {
         .parent         = TYPE_INTERFACE,
         .class_size     = sizeof(TargetSpecificClass),
     },
-    {
-        .name           = TYPE_TARGET_ARM_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
-    {
-        .name           = TYPE_TARGET_AARCH64_MACHINE,
-        .parent         = TYPE_INTERFACE,
-    },
     {
         .name           = TYPE_TARGET_RISCV32_MACHINE,
         .parent         = TYPE_INTERFACE,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 60501d17911..8f0d927ab63 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1350,20 +1350,15 @@ const VMStateDescription vmstate_arm_cpu = {
 
 const InterfaceInfo arm_machine_interfaces[] = {
     { TYPE_TARGET_SPECIFIC },
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo arm_aarch64_machine_interfaces[] = {
     { TYPE_TARGET_SPECIFIC },
-    { TYPE_TARGET_ARM_MACHINE },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
 
 const InterfaceInfo aarch64_machine_interfaces[] = {
     { TYPE_TARGET_SPECIFIC },
-    { TYPE_TARGET_AARCH64_MACHINE },
     { }
 };
-- 
2.43.0


