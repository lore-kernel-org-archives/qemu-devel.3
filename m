Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD2606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TVOEWaSz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gmfRp8vr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPO8K-0002Zz-5G; Fri, 06 Nov 2026 12:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO8H-0002Z9-GP
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:53:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO8G-0007Pw-20
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:53:45 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HEGcf031517
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=RxV9FHh9ATPRKdYKbia//XdSdtX9EwHeEvR
 CvPu5ceE=; b=TVOEWaSzZ3ywG1TSDtw8e2ed2+FDu6ITE0w3anrzNKfew/R0T3S
 UDQALcRfxgZklDJAKSBOAHZMMz8RZ2374wOeK3XYGuoULsDgE3rkMuijxdKrrS+P
 cA8iWf/t8r3akm5YYzIJ1oxbg6whzMLuv5XBD0mqEfKA9HYI7vxo106PpfTzTWZx
 o9yTQ+onJdDNwKvi95PZcjYuxWfoa9+nyc1cmJ2BQHV7sRaA4MNfWfQ1TrdlMi2m
 ACGhdaMkvFr/3N3NjPUzpPLuGK1er/9PZof1N/YT4RPxp4eh3BuR+i4VIuUZG6dR
 1KeXqdoaZSqeEc2xU+Ut54ktJ4Vrd13AujQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48r5wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:53:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso904521a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793987621; x=1794592421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxV9FHh9ATPRKdYKbia//XdSdtX9EwHeEvRCvPu5ceE=;
 b=gmfRp8vr3PYq9CmuQigdiM+0V4h7ANOft0zdN+9gywyHBj7Mfvcahv1Qp6ouHHZQEB
 p3Qy+t5N/6JiAyeMZYfrStHIzT44wajcATtDcGubKsSp0uZMxPvN/mv16n4S6IueMcgV
 BMfq7W6bgE0HtsIqSyoVkxjrE1AaVKvqiU6Wmp6ASLwydEvJh9Jh8VMAGAv+z5Pn6eQ2
 3A3GZZ3F6lTsxMW5mY+tkIoo4gXHNnRVjlGHU6fGT6yTxzrHfgYZCGdjsJUVxKekfrPX
 27ATK8I7yWNbkohXEVXHZfcIsxJKoaNedneI2TkQPPekEVUz9InJzKWYeMe5UwInbuKc
 M5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987621; x=1794592421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RxV9FHh9ATPRKdYKbia//XdSdtX9EwHeEvRCvPu5ceE=;
 b=VnV630dgLhUodIXEAutmgWtg5nL3uMH2c8/6oWPl34VTaqDw/JG1zxa5BrYKKZ9JBB
 tK7IfvtZfFimv9oFAeRGTC/F/I1FvoCDwyB2Z2KIIRhclptrrXAEwBugS0OcD39yVL23
 Q9suEGmL6yXKickjw5crkvkw+39D9PKlpYc5Y5Q6dHmKhVGS0w0LecMNVNfq9yZ+btbH
 5H3GOGZSterWHIwe37IH6Af9Hzy3x7TkiTbOpF7pLmB83SFlRIf3dfjVPT1S9eNPiTXa
 fJBk/ormuHhvwSLlOcqnaD3siMWM0XAWOchpfZww33hR3m7yCN/2tTs36/omxyYsiITn
 hkNQ==
X-Gm-Message-State: APuU4Z+rNOf+B5n2GjqC8siwpMD+K4Q4eI8WWc5CctP0JBilyMf3FBxo
 hDAqQlQo/YEL+cAPxpSYUsUOIsaePHuKKnrSHBSfCeooXcZdBDbKcCyX5KU7hRFX+3fzWEsXdhj
 OvaTBn2pYXxTS99Y+uu5UFWXsl4/QxgspAYAEeqbw4v6kh2KnRnEMD5hHxvXJc4ZbBA==
X-Gm-Gg: AYBFou2ofgBIV8Oc4OLqi+vO8Yi3mR0S6ipcBi0B1/qxayX/NYqz3W+ZZToxnMmxpvc
 p39Vtc8shtTl2RPgy4rb9OSntSuXeyJw3AVLnAnySKFVcmAH8ymFx8pUsxKiuBG/9ofRlGK6IG+
 Weo2MNbOdxUStr4DSqC312TzDtL8wOrMKzZmgnsF3hVU+94RoiLkXMeQ0erI+EX9oicP2g7/nv5
 hudCIxJKaxHB7oZ82vvwaUZkCxrpZ6FLe76oYZG+llmN9rh/QsRrRgZGtgU+ScN4VGyMId0L/cA
 PC0k35yrA+h3au15YBKHmr4nKQQJhvmlBpCxisXgG/llqentcYyEOXQWlwyjRQe+qXLmVe4MUIj
 fLB7ZJnbcI25dOrrXRkZyGEZXJghv9Y41icbRV3+BFcSc3fYzYIvcdBESYJbaHuTPY1DC5MzbGX
 ZaGR3PYH0M6HKqcddidmmqYtMQO1Ximjek77Nq
X-Received: by 2002:a05:6a21:47c1:b0:3e2:99ef:ae93 with SMTP id
 adf61e73a8af0-3ebb276b08emr3303061637.1.1793987620626; 
 Fri, 06 Nov 2026 09:53:40 -0800 (PST)
X-Received: by 2002:a05:6a21:47c1:b0:3e2:99ef:ae93 with SMTP id
 adf61e73a8af0-3ebb276b08emr3303036637.1.1793987620127; 
 Fri, 06 Nov 2026 09:53:40 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb766b156csm548207a12.6.2026.11.06.09.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:53:39 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching target
Date: Fri,  6 Nov 2026 17:53:26 +0000
Message-ID: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MSBTYWx0ZWRfX9vSHW69FEFDn
 0cgZWDlE+gmoFDl1ZjwQ916n2EQr4vF7imhBnZYfM5GyFnMk9MFjRAWYR5Lcvi7JTTqFzDWi1sU
 EQ70D5FU2tFoRYt3KS1PODX8coH5V4+EDTj1WoGiTycJd8Cm1EXgHME6hTUe0CmfCmHxWo3ry/T
 70wmctTIixqWV8vuNyml4hoA3W1k75yW6IF2pW9+lO7AFaN2DsLoRHVMG83z2dHwppbzFPenr1R
 q9HEKUcKHt3M3NM29XiDnVu3k/hNAXJWTEn6aGC3IWZ5OhU0rwfoAr93Zpilq0Cdg4VdBYMy8GF
 diNIp2xM/1l6BTEyb9ZSdXyXTJLXzN5QwA6VflOsMVv5Q/6+Ow81fsFTYFtcF+TiVMywNMBkqDT
 cCEkAL6TLsRa+Y4GWX53QqQv4KN2QPHBb9djicDDVni+Rx1hvuFQAb7X3rw6Ta8yyef2yzsSKLB
 VZVEDJR1GKc4O4zbDiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MSBTYWx0ZWRfX9Co8j+S19FKr
 KGYkG0l02H+g3AWtXvbmI4bZvdyKgVU7GmSnfZfx7/Em2R85d7CBiMdfxacPuwADyfU1yn72tIy
 GmBuvFTOB0YEMkKEG187rXncVrnvzbs=
X-Proofpoint-ORIG-GUID: 8durYn9L1Pp9-za0BJnUMRBTHsR5JZL6
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee1425 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=3mmYAVufMbg0zkDCPNAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8durYn9L1Pp9-za0BJnUMRBTHsR5JZL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060071
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On windows x64 host:
$ ./build/tests/unit/test-multi-target
Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
(same for windows-arm64 hosts and whpx-accel-aarch64-cpu)

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Since whpx-common.c is shared between arm and x86_64 targets,
only register whpx accelerator cpu type when current target cpu type
matches the one it was compiled for.

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/whpx/whpx-common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 78d2827809b..20c684638b0 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -20,6 +20,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-type-infos-common.h"
@@ -492,11 +493,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
     acc->cpu_instance_init = whpx_cpu_instance_init;
 }
 
+/* TYPE_ACCEL_CPU is only registered for current target cpu type */
+static bool whpx_cpu_accel_is_available(void)
+{
+    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
+}
+
 static const TypeInfo whpx_cpu_accel_type = {
     .name = ACCEL_CPU_NAME("whpx"),
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = whpx_cpu_accel_class_init,
+    .is_available = whpx_cpu_accel_is_available,
     .abstract = true,
 };
 
-- 
2.43.0


