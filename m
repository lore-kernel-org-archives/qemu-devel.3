Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98C2CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9jm-0005uJ-E4; Wed, 14 Oct 2026 20:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jl-0005th-45
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9ji-0002rt-Kt
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMItm2301175
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xcWtgum64J3
 i6bo0k3bnkY6J+hQp0QG62oCNN3sK8o8=; b=PDTgwSXNqoXesTA3jAsT4XChCJ1
 kO36qDYc8ZfSiJuOShkp4SpIunbU4F7Wd00SY6ij+mE5SU1aLJC25tVCWquTu1/2
 sXZSRekWvyJRbccM8wQoNeLOmy5aheuGzvsqQE11TDRRyrqL9KbwM/A+NUcNlET7
 Uk0ogrzp39V/gtTz6NJKkbT/Co5j3FkZY3uTGUPRX7RqvZFR3G9ZGLa+uEpZGpf1
 USpSalg4WntRmymg4KsjTjrV7nmAFsKoCsH6TMe8JaQKwA/YKzItjidEHIoWtvAD
 UNAklaSNjmrk165X/qLw8fG2aUhn/Mv7jBxKcR2TGomvCaLcmL23QyRd7QA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46244yn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso9380334eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025660; x=1792630460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xcWtgum64J3i6bo0k3bnkY6J+hQp0QG62oCNN3sK8o8=;
 b=AN7OFMHj4192A+tv3dAMfAGuGknne2x2eBnzc5uotBCik2jUfHdPmbGeQ2nLbzVpUZ
 3D4YnBkiAXKbtPKSRW1ecU/9A8DBUG6x0i9KKZnIZAsYF58rj5Jj6N21A/KSB4w1Dqd8
 +R3s/GOHCbNNxb+h5583zvE9esDSDknxRffFkhT0PaVlUaJGObod/fQ84z6xfALM6m66
 J1RL8VjS10qANmL/3aweFGJJrYDJfyNtzx18G74sTImTB8Fg0srRUrzbn04ESaxuzXzT
 /0sspnHqq5/ZHIzPO7gEnfUXZfqoTspRuSpxWmmrrs41/MwyhFl0A8IfN19hK/mB/db4
 rgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025660; x=1792630460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xcWtgum64J3i6bo0k3bnkY6J+hQp0QG62oCNN3sK8o8=;
 b=MXlO3IkfFAmIm3ixBxV09vEWJK/LPEmtjGeiXyde7LozHdGTWYJUDtUj7BqoBJ3bXA
 19GpfrnbMuw6J+opm/pVK8tYR0pHR0RzM4glJZ+xuSb5pNWOSagnOqYRyrkgvKqPYizO
 /fNRlSz+ye1ZxrL8YXLP5RkEcJNSpqpwOwpmnLYw0hQO2zkIURGtbCneUkCXBtLlXFlZ
 jY8345gxuoUHJb0cS7sspEh/qiXJ1HgIu+6EXqexBXUqB8iP6a56N1zCdoeT2VnvXAUV
 dOrh8omvYolnazQiGwtOW/V92gm/bwmKAu3EB5IF9JHDDGDCljc3T10FLFmNW1UPsII6
 gdew==
X-Gm-Message-State: AFq9FYIc6ZvC7PgrMDyQsy1Jk2s6I0zhxFOy5QlvSmo8FBmLKB7ypEXV
 z+OiFA0iU/5xXlif+uwc+86BJ4yc4FtN1sNC8IrzLg1E3XzSjsCKmOOp93qnn7goonGRw91MTh8
 zaIgQIf/XnjBqkNCObmHi+47CVfZLsiSmYI0MdRCNmdutJIC8UHh6QBlSaHoE552NCQ==
X-Gm-Gg: AYBFou0ojFwu1RIAPIEakfhAcROwyRfMQhTPKHN3O6MdQosC0gKSG8e46G6g2E7uel1
 GTHcnI7oM49v7iuT8dwucnkefHLCNVG1u7OAUBl38FhWWD8SUNa9H8cR8GFca9XvCF1Fub/IHPj
 aFYb96031nxeVJGESZPElatLvrcXyDVHkN6L9l5TNqcip2xIZ3OEbs885hSA0pEbJYQEDYNXuqr
 lucbYpFgIee3wQuarilU1GlBneyx9/Pa53bjawOJBuE5NDqtn1pegc/MZTUJenHX6yg1omynI/7
 D8/UdcCI0GPhJctR7faBIJt90VvacM806caW9oOzQ/PLFA6VOiboGm6kHRTV8UD/0wmQpR1RWlT
 nfVk25WtQg4K2qogMERQVCMIJ/PDzUgIQbTWlzogrhoDQk6TqWBLGRT2YQsmH
X-Received: by 2002:a05:7301:90c:b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-35cde009921mr6926755eec.40.1792025660437; 
 Wed, 14 Oct 2026 17:54:20 -0700 (PDT)
X-Received: by 2002:a05:7301:90c:b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-35cde009921mr6926718eec.40.1792025659818; 
 Wed, 14 Oct 2026 17:54:19 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/8] target/mips: rename qmp_query_cpu_definitions to
 qmp_query_mips_cpu_definitions
Date: Thu, 15 Oct 2026 00:53:51 +0000
Message-ID: <20261015005355.62406-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pc7XLSUTNyMAEkIERRxyoZ6XswZ5w4Ri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfXzqIgFKbCayar
 s7jKxrUY03aSdFz51+/BsnrHY3q+udyuRUIAMgpNxL1NVN/QQ/VO84FPZaI+frDnEbbjeJIas9m
 hnq44wxUHTVZNUdISn4iqioAiHd3CB9n11QKQ97GoaK7rh+rJpPoEJMx0EKtSDl7EmlpKTG9V7W
 uR9JUW3rZ2xQTpCqeBBQv1nYcEl7ZboreQZjSmJbUpKNvMDbORlPjEnZpjLd2l3K8jrTlKn63qs
 8LlPCb406hFh1PTLGbjeBuDROD1YYTUAP7AfRQBxCvWSdTV2W57OuIRceB/+R3QmS4uYgiMwQJn
 FouOTbxB1NOZsaG53GsgvA3foraxsS9T8I9Lis0eM1QbB2oh2TNDK3KkLCw6vD9h6fWBi/G3WKv
 exKOSJwmoDD0/UP+cQTWgC89KWPPUE4xWjA4iQyhpEvWBrnkmQdjrVEhleIdGmHvXIVRl5WAYno
 HB77sOXW+JT++q40lLg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad0243d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX/i7JX8UnseeG
 mmwr18o/TPyiAoZtN/8MYQ0qiFdAQZ0pqRNMlMzf7bBi6o43NUJ6um5iCThVdBshH5929rwHgca
 JV8i7YzhSjESQCVSxNcZDI1A/mzUs54=
X-Proofpoint-GUID: pc7XLSUTNyMAEkIERRxyoZ6XswZ5w4Ri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150003
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
 include/system/qmp-cpu.h           | 1 +
 target/mips/system/mips-qmp-cmds.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index dbca230ac6f..4267adfdc03 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -12,5 +12,6 @@
 CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp);
+CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp);
 
 #endif
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index b6a2874f2dd..560c7915365 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -10,6 +10,7 @@
 #include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 #include "cpu.h"
 
 CpuModelExpansionInfo *
@@ -36,7 +37,7 @@ static void mips_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -47,3 +48,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    return qmp_query_mips_cpu_definitions(errp);
+}
-- 
2.43.0


