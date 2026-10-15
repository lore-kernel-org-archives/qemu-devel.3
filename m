Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB2CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBY-0008VZ-E7; Thu, 15 Oct 2026 15:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBW-0008Qu-Va
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0000Yo-FB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDPmv4126286
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +dDl2QDf2I0OUMkrTsygEIS9M5TU5SHiYK3OmS7ZgDg=; b=NXTGAQP1VdTgD1TA
 1TeW9Ons9sH1WkErCIO6jdW2BQ3fTHvUKwEa2N1wEo6jkLsiqmcEDXsl1aiC1enb
 Rm8U3dX9xPOWXuCWtXeRYD+2FVR+MPPG8bqkg0MewKXbzsujne6W/o6yHmWe1qdE
 1Zw4n+CFnrL4X9TDUIJR5mk7Eb2igZPOBUfRTAufSglmbVB9N9atoXivTWxD8TUx
 6ebEQS/VUmHYbm9FZdG9WN5RRGWrsxGQl1+raLoiS/bsDiQ+io6mCwktk9p1OQAv
 1F8yw6eceCi/+CaeCS6L4spsbzbMYl6moE3e1YdvuZkDUimXC1tFR+PbI6ZM5kc1
 /0CgmA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m0yvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so15755197eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092716; x=1792697516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+dDl2QDf2I0OUMkrTsygEIS9M5TU5SHiYK3OmS7ZgDg=;
 b=gjwPjjnhw8fEsUW6QZ5xWq19T0lKoHfW8rMo45lrRrXLvUpvxMMWMOERjJ4M5VwRFe
 25zK3b5Kdydyyq8PSYoktBtksHzyMmloP1xGygC+r0Y25Nx4hHjwRE5UvuXlb/4PIaNO
 MkZb+gmk5z4HY8fZKE7G5qmP0unkPrf9+R6B6CWFJ6808C1m+UOWyePibtKlDceluqt6
 Sk3ok08kEUFm30r8ymVG4wbmT5nwOkguceGGcJuBp0wIgTvalLr5GPPUEHH8AVTxDGbN
 +7Er1TSRU1FkjTJtH3sUngbzrKFvKvgMHg5KBD/XicZE6sjHQLwHmDnbcVCOJ1yPGbhD
 ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092716; x=1792697516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+dDl2QDf2I0OUMkrTsygEIS9M5TU5SHiYK3OmS7ZgDg=;
 b=en6REortHCsL33Fi/7rXm19jNV0Oi2uDcAiU2akyjz7bnBGZuS32m0LMrlatr/3qgL
 lZUm8Aq0BIY5mPE9N8FQI50NAzr1Kl0G48tvjKS06d0HbKxgTtYAcMpb7Dctp8l2Q8wb
 6xT0FIoR3AxdTyoeh5VWlZ4FkVSS+FPwivvJ1zxckFZSL03bzEkCKQDiXI9Pwiy1L82a
 L4LI80BEuaCzlq54mTMpj3hn0cGmNTJwFCqbjS1MRNoqD7b0bxjijsfOHFgL5lfe248D
 rgRkndtF4Ub2p3FNByL9celTEvw91fjG9cCbl5/lZvAmcqYIgnTqn7CjuvuAq7ipf4US
 MXMA==
X-Gm-Message-State: AFq9FYKTi9L/SJFRSaSqXfL/btLgWbzUsdHrPNp9BmVjSGE44Goijcao
 g9yl3X7LOLg6/azmm4zIRgGWSW2r/HftLPRwtLWmUGtpVn47ytvczBtv0b+cYJ4zubZf/z6mOYx
 JVjyr+V0WYT8Yl3og+jVm7oh8Bc0BQhksA4HsrBuof2TtRWhT/6G/4bkl9Omny6jUAQ==
X-Gm-Gg: AYBFou0sYbTmUNmAeijrkYBwnkNGtXBZkw028w7IydY4Wefx+x/6N6Kp76EGaLcCRcK
 KcQ8KGqm26ylri1HLQcYQoZOZm5Ho/hN35qc8cIlRU16z2pMalAjlZcPrP8u5i8i1IkxqSLGb4C
 kPCjzEa755W757VTw+heIToi5OoH4UxLRpbr91R3Ne/hFTbTsopkA0bY6zpit5lYgpUtw+K2M6I
 mmBzZ28p63jHUv9QJPdlmA4pXdN0iT+R21wtVOuj+GGOdZNmwGnN9mITbRisS6Oqsd4Q99EKbYm
 KoQP3mToCcx7V6U+doIfydOpjoGXYAnZFJZr/ROHEL7saHqbMAXD1uv+AooGrASbpedCZueu0op
 gHATkANXZ823GsQY0UE1o3r89232pwsL0cmOGnU4Bnz7TaorKyBZrBv76aTeE
X-Received: by 2002:a05:7300:de47:b0:35c:fc90:f6f8 with SMTP id
 5a478bee46e88-35cfc90fb31mr10160619eec.33.1792092716055; 
 Thu, 15 Oct 2026 12:31:56 -0700 (PDT)
X-Received: by 2002:a05:7300:de47:b0:35c:fc90:f6f8 with SMTP id
 5a478bee46e88-35cfc90fb31mr10160564eec.33.1792092715174; 
 Thu, 15 Oct 2026 12:31:55 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/20] target/arm: rename qmp_query_cpu_definitions to
 qmp_query_arm_cpu_definitions
Date: Thu, 15 Oct 2026 19:31:05 +0000
Message-ID: <20261015193112.145326-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad12a2d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=QXq0fTImmi5I3yB8GwIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gQy8HmBXJpxaebG6PVdXDnsZi_Y3IVea
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX5WkmjSCRxecl
 WkEGZxPlzeSzbM3zZllHf+c1EDLIxtJRbQQ5x1rTG4METAfjo/zsBiBEdjzPFM+dDXy2xXx33iW
 0Q0jtqohy/GIqLXuEVLkJG1qnhVD6B4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX5NbTtBu4qJvG
 xdkjD5BtmTRJ/DIWafiOV0bdIZb5MhoW0R7AM2MJ8Hwq+8fJgNqzmrIMIa961SHRO5pZLtsSYjd
 rPQT2fS6bfk6TkM3ldqsORbm0A+DTUiBJgQAUGdrB601jrTUPVD486aT7MOoFw8pVEHZdEDuyIu
 9tZ5rYoAekXtS1F5pXlR5KMYa4q6lXcYsOOpED3zvZMhmVGopMc6iFYIQP1+tQPJvSFaBopLwGY
 uriP2ShiiorUkHinJBEUHgsqDToOQRzRnOw0NSWv/svI5IHoBxLiJnh/e1nwRFZe4021eJSg+ip
 qCMLVnlx9osiWgdzMJPFgDs2Nerep9M7maBrmjW1oGUj6/laqAVRFuZ72kmpY8nkszQ+hz8tCgl
 kLp0mchvQYMf32VQZOKeSQcXOGlKC/IlfrZfiX/dPRVpv2bMYpwQV8VJycddXEqQUQs6XIC+8Y5
 GN4wi4PItyfxMRAWucQ==
X-Proofpoint-GUID: gQy8HmBXJpxaebG6PVdXDnsZi_Y3IVea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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

In a future commit, a single target-agnostic qmp_query_cpu_definitions()
will dispatch call to the per-architecture implementations based on
target_arch(). Introduce the header holding those declarations and
rename the arm implementation.

We keep the existing qmp_query_cpu_definitions() function to not break
the build.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-2-pierrick.bouvier@oss.qualcomm.com
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


