Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E537CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jh-0005sX-V3; Wed, 14 Oct 2026 20:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jg-0005sH-K4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9je-0002r9-Uf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMXbgL644597
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4czxl0PGtfb
 3Ey7pQ0gYZRu9SltoImtnQ/3u+5Wab2c=; b=mZagvnUzYVXZ4r43uE7Xld7Paye
 d3msDXn4hvd253x2Mc37We67r3XwoKfRgsZWr419h4lhinu4Wyq7Qb+LQ22TZOXF
 hA1aj+pv5sOSRZBMtHA9Ur1hx7HxGnG/xLd8MunqGgVAm/fehFj+GkOiH5ptN40I
 4n9m1+lnY1HaBlv8jRXl7lLEYhCOgkGsyP25zLmH389F4/dLf8ZT0aSBPLu3JuKF
 0Jt4YYzTRLItWg6Xhbyl/mEkmC9hLhyYwIrDT4GSzyjA7svbkfjKYPmSFvZgUks1
 4js9rwCjCTMIE/sRzw2JxlfEj8m9cT+w72zW66oI9H4fiSRMhbMW0ziZOkA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy8chc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6948919eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025656; x=1792630456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4czxl0PGtfb3Ey7pQ0gYZRu9SltoImtnQ/3u+5Wab2c=;
 b=kUD8h9k6k7FmE3YVDHIKf2L/TNHWZ4ZHgvXpgo1lnExANrM6l13+Fm+hcP256Yj1Wy
 R8lrydahkRGkB7gAnSg6sTh3pFuvPSRCdxosrsvXHIWmNazbO4Io43ZmbuLoWuBYgfH+
 QS8jqpC58sh5HH4HFgb2dgJ59z7x4Wu30zMchFPyAKj7wkZuKT/3KO7NL/9g7+rm9Uaz
 kftvUJ9pAQ3oNGzwroNLYf4cQm7V2FZuchx1L0dTEcjuEsJr4/274qP2W6/qv8wQg5gU
 Ehh0Cf2pTfRnGnVtJwOGtFU+e9IpoqqO+n51fBvfFl5MPPk5nt0R91Jr7iZG0JPUEIeZ
 9asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025656; x=1792630456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4czxl0PGtfb3Ey7pQ0gYZRu9SltoImtnQ/3u+5Wab2c=;
 b=1gC05JALc6wlHtwQABr7lS5V+VdnUHLOYUG89NKXH9tDrdg5r9K42YWczWKYk6h3rA
 NAx6m8mVk1C/wEY7B4qsP1W+/4MQwIdTWMDKKE0RlpJyNAwINok5LRs2gQPiYxLFHOAt
 V8Epl6eJeYDTvxIMsjmjxXjgFHxnQj5n9WPOLN0VjbYB6sgqje3YxeVrK+WR7GKfNIoM
 nF0AMHdo6tWqPX9Y7bpVEVS4YXWvzudr9IysZDUbS2VOp2OBZT52GfFWcCkf/Kl05lFB
 bfDAwLlq89tJY635m4oiTQeHoKMGrF9pZdOPFrlTUCLwDJMHfeBULRi9F/XyyVMvWrAI
 wF9w==
X-Gm-Message-State: AFq9FYK5tgY3+UyeZjuy55NOtsyLAr86yYM28TMXaBcrZpsu3yuxKK2Q
 642MSD9a65keKAZZ1566uFoyhEI1rIxTYVnTlUcv8xpI0OwLZXkizpKy0vwI9z31oucUITqCvrm
 Mxa91ikayF1mPA07ahPQ+5Yp8LlIbDjAlle0aAxJVd/6vGz/gNhDPbok7EePR4mONtQ==
X-Gm-Gg: AYBFou0ZAiuQMoWUjTJFrm4cdkftGKfxORfrES64ENQMxjZ20SpwpMRHzaA7LAZf0d/
 PnQkqJUXfEeBB/KrX/8nO8rpYN7DMT+hLdcsejtbnkcyLIlcbmuI1+qpzx8p0nstSjdTUJY5QhC
 sflom5qRfmFotQnOCc3GENYOT1HQ85BEhe2NlxW2hXcHUeDbkU2T3c9d+g3iSC/6YpZG+H3r3n5
 NaTK6UER7Uvwe93gXG/aLLUBgX3ZC/gj1FqUti298PfoQdnEOqkhJS04AQ4NYWYFcmHaEhR9CIt
 6pIhsswdKa7v/eSPgwZBdbyTXflquG8noafPAbekWP0ZZ4DujRdqcoAdATWlhCF1hZEqjWkOGxg
 ngO1wvSW/z/A+J8kgAa/5WLmBiWpra/cKFG9kDaWmLDGnVr8zuaQp5YzSPWLp
X-Received: by 2002:a05:693c:414f:20b0:358:1eea:ffc with SMTP id
 5a478bee46e88-3581eea10ecmr23393535eec.19.1792025655784; 
 Wed, 14 Oct 2026 17:54:15 -0700 (PDT)
X-Received: by 2002:a05:693c:414f:20b0:358:1eea:ffc with SMTP id
 5a478bee46e88-3581eea10ecmr23393505eec.19.1792025655240; 
 Wed, 14 Oct 2026 17:54:15 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/8] target/arm: rename qmp_query_cpu_definitions to
 qmp_query_arm_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:48 +0000
Message-ID: <20261015005355.62406-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MCpqxSWsUHgzcbeAKNRjp_NolrsI_rKU
X-Proofpoint-ORIG-GUID: MCpqxSWsUHgzcbeAKNRjp_NolrsI_rKU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX47woqCO6aqmb
 +h0ArRhx6Fz1ifLEPlIlciTWpRCFz1gRZcI7c8X3XptbQqV+SOQbKsJPEdUr0aSZI852807HvYQ
 vYKjKER2SPfevc79kwg7/XxUdrZQ6pY=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad02438 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=QXq0fTImmi5I3yB8GwIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX9/8WRtsfeDxk
 Uziu4yqnjIyet+7cAYYtOLtP1fKdcJm7SVxxFdMgZUxxobPMarEK0jpfYLKWvjAW0PHVfZiKBzD
 vf5N0IimY0IUGbLJtf5OI67ZoWlrN+9Vqt3+TlsXT9aKpaD9ZitkiejurWHJk8cx9UVmv+kxXyD
 1N7ZQ/0MU7XN05EveWTn4YxvT+twHJUgsu0l5OyZ0ANypoMgCkVf1xTwxk6HpwMP0gTEqP18Ss0
 FAzPBpmJSHO4bdMTaovqh7+sw/pSIfD1A8xK1Mcth9cDv5k3CU3FDNx/uap6Q9mprwb1anB86dU
 emjslxHy88aAqxx2aD0R0RNTE0D84yVgN45TSFkwKsTElzgwebzIQXPWLLU+nnGTS4Wefzx32w9
 DZbZ8ClyO6lkDaeo4hfhcXTykv4W2vwC30XCHyQe7rqwUjac1WGTA2q+ifkPN/jfJL1qtw5XN7v
 zAGRd5fq+LybvIZRcvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150003
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

In a future commit, a single target-agnostic qmp_query_cpu_definitions()
will dispatch call to the per-architecture implementations based on
target_arch(). Introduce the header holding those declarations and
rename the arm implementation.

We keep the existing qmp_query_cpu_definitions() function to not break
the build.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h  | 14 ++++++++++++++
 target/arm/arm-qmp-cmds.c |  8 +++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/system/qmp-cpu.h

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
new file mode 100644
index 00000000000..e969aec667a
--- /dev/null
+++ b/include/system/qmp-cpu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Per-architecture implementations of CPU-related QMP commands.
+ */
+
+#ifndef SYSTEM_QMP_CPU_H
+#define SYSTEM_QMP_CPU_H
+
+#include "qapi/error.h"
+#include "qapi/qapi-types-machine.h"
+
+CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
+
+#endif
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290f..d227a06e2c6 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -28,6 +28,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
@@ -216,7 +217,7 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -227,3 +228,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_arm_cpu_definitions(errp);
+}
-- 
2.43.0


