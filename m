Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6939BCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRC1-0000Xi-Oy; Thu, 15 Oct 2026 15:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBW-0008Qc-Mg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Zt-Ek
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FDYP8L3462832
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xMCoJbO9p6UAuRhkY55xnydtPILkSya5jm1EbfDEjV4=; b=bJF7Z1IofTLndqex
 H5QomTlX508nUX2z2I+MvWZLlay34ttyF+SqsqF7JPy0ZkPGKtOap4xupmxw/u/K
 6W/cUnwWPKNGVRHbc9pFO8GWmrVIK1ViYAlvjLVC6P5V4HRomwn0ZPeiO41SNSev
 hQ3yPlt7uIKfbGHUIDdxwtBGZV81ZD44OUU7+sSdwQvkaIowk3+/aq1teXqoDhFg
 cyH55QfzmWwgINli4rdocU4dTs4Rc2d9I6bpj8F1SG+JD9NHhpV1Of05FgB3LGkr
 qp9bHzTQJ/b95y/5JRR8n1Td4f6kAHzKbvl3MOl0ujI0EtpFD75pdOdoHvBSKiFk
 J5cQWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69ew8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7331803eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092723; x=1792697523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xMCoJbO9p6UAuRhkY55xnydtPILkSya5jm1EbfDEjV4=;
 b=U3PRQMO4pGebh/EDzDftGrEzijbZajfdSLMc6Cftml2TgprLv0v0njfFY+6toYIGgW
 Ham0lMFTYHo+Kqq0FWH5Vx6SjNkMbyLi9inAF3i71OaPKI+8qfkbYNvjXSrgHY8xhzwa
 bUGZZCl+lYuyUD8k0mUA7mCHp5UWJusAGbsulfdRwRZXS5zFnur8NV0FkWrCi1FuDyet
 Qov3rmjHNT8FW1ldguKgMTCdGCjOmLGUkQE855bjdwltAPOyAGxIW2Iu9/Ksp3SXo8Qd
 TtbOnDeX6b6Qn8Ln0bGXTj12Ftm5GoGNfV7uRZ+UhQ+fuPVoAd29euiHv1zeJuPBQ5ta
 F6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092723; x=1792697523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xMCoJbO9p6UAuRhkY55xnydtPILkSya5jm1EbfDEjV4=;
 b=ROoxWaPHxobiwtt1cPGdL6zMMAn8pM17zaXVOf6tEDWt4DXjl49+r6I7YZ1RVPqKul
 2y2aVY4gqrOOOzWCtMnm1iNkDgp3M9LuvC4MMI6vvR+xNvAw0kjAKq9rBY46st9J8+mT
 bgotTFcXNCv4VSEfFksQoEmIgefTNd7uXeX6NNfRis9rHW/1b1SgK8uES2qYXH8ibWEi
 lo2U8ag+roOikelKtHzP/KqflQ055fW3KEZkkSQ9DK9tDke00H/kgKTfelV+eU4PJrWa
 C0CBTZm9gLl+mWMyZDhZNNCm3uUfkwrfZrUSBeF/akJCjApCq0oLQjDaRYXekgZ88TC5
 Gltw==
X-Gm-Message-State: AFq9FYKxGrRfO+aVfv1H2pOEdabOZvDqEBHzAoTYZBM7TRMW/bfWPE6G
 7m/O2KX+SFPbTS26BjN6iZbiBsAmLKrOpqU+x9jqh8vXJ2L+EDP4t6qn0CIcOU/PJWoLIzlXf0U
 +9Ebi02+eg3Nirs30i/EH2q6qfkOv7MTRJzeKuHjDlhpQGAyLhC1BvXsRizEKOZ6yXw==
X-Gm-Gg: AYBFou0AduPXH+UkY848jtN0Mm6VwF1ijYxVhsubsrztl6MLk1m8n5A8J0EN1PRLSDu
 16NpxNJ7tWCupGDGKiCryyA7Jzc4w/qBb658A/OijXJlWFCPVwNswfs+ueeoOc7A4nJ7R1o0aC6
 d1i/wj9NB9Ob/VyXfJzvA0+vpVepizJK6JkZvC6fiVUWSjiF1SxU6C35kDCZMkzhkVBEDCJ7hW1
 ZxJST9a+aa2ki5EgNiBZ02XwEdQ4FotGq8djdFwfYSLgakyMJk/aTGNW005DGhLaqj1e3jw+53n
 4+meC+xzL2nfURNd9hZTXRk3HkHkgPzenZlfQFSBqWzPQfNZABBi8+SahxWydlnryud9Adjy2dH
 Iy0WGugvq+Hg+0fbCC9OzWcvP0cGk/hvcBgdHHhx3tWKC8KJpuynAyviHBWPS
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id
 5a478bee46e88-3537e033341mr27022654eec.11.1792092722598; 
 Thu, 15 Oct 2026 12:32:02 -0700 (PDT)
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id
 5a478bee46e88-3537e033341mr27022610eec.11.1792092721795; 
 Thu, 15 Oct 2026 12:32:01 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:32:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 16/20] target/mips: rename qmp_query_cpu_definitions to
 qmp_query_mips_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:08 +0000
Message-ID: <20261015193112.145326-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KRjtUQZ-yBZ9l0w8ouYTNLyfzIQLYAfl
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad12a33 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=Sd2LGMzgzO9WI1_litEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: KRjtUQZ-yBZ9l0w8ouYTNLyfzIQLYAfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX+uEFWcaAyu/5
 tn6Asar+zM7mIrkYNpAnlY/kCfCEawFF8cbZ1bLScmMONaGjboZJ5jUXvVswge2p3OQibWptGf/
 zDe0V+EuHERdBpBZn8nzrlXXj1oNxLUVnFdCWEcpTntPTUuO3b3wJ/5bTlYk8xDuBJ/ekcu8Ugu
 5VSKKNYj3C/2Y1n1z1rzDGAW9Gtkk1I5JlXEdrC+3AmspTEcqpFCTdOCiYy+TsX2l7jNBFvGeG3
 7wSdDv/A+rLEoQs9mgvGu2yJZXrOkePoGS9TuzQwiGSGahRNWvaJMLbZF2NNM5mKhCYcKMePK68
 A3L0dayzaa5vsSUfR28Bcz1cqqhvbKsTpS8be+r8HYBH4X5IQc3p1DV8o5KixSnIP4AThkZBH0Z
 oQRujDqR4cXfuM5UkouHiFWdI4UMRLiWG2bA/lB0CYCEeUuXlPdkCDTCyDOYdHum1mlsTKI+emY
 xb3H6M4QoYfIHY9Z6qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX3UVY7oIN2Hnu
 bFxPRGpvOYmC/BXnVLNmJtkYY3Vc/hM7/j18XNkrX6f9S4dW2qgOH+9REdXMqZ3LIqK/7B6l35k
 OmJpA6s4Q1+wrDG39SAi7G9UA1vAe8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-5-pierrick.bouvier@oss.qualcomm.com
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


