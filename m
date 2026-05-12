Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65252CD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrtQ-0001U2-B1; Tue, 12 May 2026 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrse-0001Gn-Am
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsW-00017d-LL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CGLKAW739995
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qibsWY3Da6eimjGJh1/wpFGvGp/SMa3Z/HjdgH87Xz4=; b=kYNj5oTiz8ADai4W
 OZ/xjblU90l8NiDr4jtNlpRd7bAKtecrFWHNvzFin4+H13UQAT5z2fXLe3Z86BMU
 gHl3xHAz4yITvOtop6BflH3Et9wZi4ixy0qWftqlKHYrUoziJRGByRPeYNwxN/fY
 5RHG53Atvfojo1ORu7szVd8GAWYyOG7xjRXLcCfJanWCL4G0RGr2AjQOlhfVM34Z
 6t5/4OQRfEOHWutNR5eAIbjCiqNZLODXSwcHznPifq/OgzyWFk3N3xugPit8WV39
 TifHpl4SRMOsdYytaDqLdORqH8nJYgG8jBufblyRck5g+40mq0Dl2s+EOPG8VWrj
 4keiEA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhsyuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dc1c0b7ccso6314376c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610645; x=1779215445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qibsWY3Da6eimjGJh1/wpFGvGp/SMa3Z/HjdgH87Xz4=;
 b=FOIusgaMK1CQOvEAbRmgSZ5+ZBwC2GTm8O980qTUScdGaxdz+w5SchzF4bGGLwZs1i
 r4b9L641jb7yyn96lstkgnWs7L6chZa0bwRE1jlSjrHhRZ3rb9WEHooE+tBG2aGVhscm
 WhaLQErtRdopbOTb4BruVcr35VWvh8HtSG1hEYbzpDT/95l2fbwi1IW96bbfMO0gJLzq
 3eP6t26WOM2fpSdpYuuMG2Rq+bDKrJ2H7gQlM73KJ4NlCUeeXamBSdXwM3ubprqOdXbq
 tE9V+dqrScO767tmY1QOAhDLtSWd7LCBGa19p9ynbpLekmiHxO/70A8+1e76Hy/Tx3t9
 JqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610645; x=1779215445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qibsWY3Da6eimjGJh1/wpFGvGp/SMa3Z/HjdgH87Xz4=;
 b=G4zvxgVz/2KA5BGr/hY2lAnDPwK8M6Cdm4NPc147nz4CJLfqTbASXOCC6/od0qa3Im
 51iOs4J/IhU7qWhEOyHIAwruKvdXOJZQ96LgJ+TBHkfZXrlld/8fye7TXM9DR33PPmg+
 mwcC2vfBVbZ94rTCYG6ctifS0K+ujzVcXZ+QwbJB+2pXrXyGofIJgvOjsOQVN376XA1t
 cWdKWqT16NneV5ajGeQRPd1kundrvx+HkM39K5bJkULBkOrIVh+dd8B5rfEoDEeDTAqi
 S+dn8iih9ZjfU61s2Ir2LNM8vncg/jfZJXqcU4aVhnbStrjdUgqC+nqLygccJyrydEzW
 DGZw==
X-Gm-Message-State: AOJu0Yzuh9IboxtuBbnqV4lwUDOLiz2lTi0GcLe1N3W2S2jblL+BhKlS
 TpFSibqpqqzceRAZTcZuJ1fSBXyfZ3t3EWLIqY4LQZ2+tTK3CmnAa7sE6qrlfCaNqnKzMZt2SJF
 A/xFbvq2xuaDG8QGCXpTUvwbzwIgfUa1Yj5qHJdfuGbPoRz05q/w4z6RWrAf83hKrtpB9
X-Gm-Gg: Acq92OGtt5j/LA18iRQLyP8SnOnA8My83mxxVZ5+ShSqS7lcfE3sqQuJbFQwP87lTzG
 p1u+MpiA1gZibfRSI3qiDJ/u9h2qLuYACSBiiBGw3KaEl+ST5Fz0N2LEnIYsw6y2LK56Qjd30gU
 AJPtT22uQmIGS1m27x1CA3D3U34Rm2ExCBe5jNNCDzQKcIjwiG0ArfZjHFVdrk9sXpRvfpVaDGB
 j09aKzIVKdFN0BjKJaWBZsH0h/bD7lO0zCrbnK/A5/bQzxJbGWACPtvH2XCQJizGKKkprKdjcRc
 q8QZzP3hotaGMuK6ubNpXdAEgUY2kZjnaA4TFKgftM0bbgbNzvsjP0ojVTBgxV3f+lC1tsjEs3K
 8X7zlyTPjOwQpSWF7bHj311+RjDJ6w0iTuRwf4HjtDOXxzuznE4DFSDeD56CSs0c9HyJJQ6f2tF
 uBIDO4sQ==
X-Received: by 2002:a05:7022:920:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-1341ebd8328mr103806c88.16.1778610645363; 
 Tue, 12 May 2026 11:30:45 -0700 (PDT)
X-Received: by 2002:a05:7022:920:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-1341ebd8328mr103787c88.16.1778610644815; 
 Tue, 12 May 2026 11:30:44 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/5] target-info-qom: detect target from QOM
Date: Tue, 12 May 2026 11:30:29 -0700
Message-ID: <20260512183030.1431103-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MiBTYWx0ZWRfX1egyfFuXLka0
 aSHSbvQiXu6DwqmtGa2XdBi+Pkv8s3RYsG2OyM4b/xpZUuZ+sMYEUExU+VaKwyphyDy+kN19uOG
 xRLyYaRIfKHPazfDCyMvfnoexsEr8xYRqsfmqnqxYCfSmaBsokHqWzWogtAWLIOMAsC2/N8rcS5
 NYV3V1ZzwlijEE8cMnGZfkbGC4a0awlMS1JQbq6ussyFofviA4RhJr2hIOpoCAWA69FM2xUmwMT
 aog5RJDRBhjzN/LvVck2w4kTsw3yVqL4kxblDBhQDUiW0knLDlzkmze0VUIOyfZQoFj+1J9xrqQ
 Eqo/15UdL26cUjKxl5wWRSxZGM/DnfJu89w2kEzCETUnwk2tUo7CfcnnVA7FVpW71dp03fQeTMH
 An9WdPYL9gDwh735xFvwZOUn9HU7/5u72moyX2uaWZSxb14htDLSuKsa59n923O7iTZacOztlBb
 s/rFnNzXvDnde69Z53g==
X-Proofpoint-GUID: FyAP_WjoYb8MedRWHh9cbhJIbLGwbo8x
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a0371d6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FyAP_WjoYb8MedRWHh9cbhJIbLGwbo8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120192
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

For now, we expect only one target to be available at runtime. This will
change with the single-binary and we'll detect which one to use
dynamically.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 585995c7ad0..91be415ed33 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -25,4 +25,6 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
+void target_info_qom_set_target(void);
+
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/system/vl.c b/system/vl.c
index e44da0941d4..e690aa3ed8c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -2890,6 +2891,7 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
 
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
diff --git a/target-info-qom.c b/target-info-qom.c
index 79752366b61..9947fcc9922 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -46,3 +46,19 @@ static const TypeInfo target_info_parent_type = {
 };
 
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
+
+static const TargetInfo *target_info_ptr;
+
+void target_info_qom_set_target(void)
+{
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+
+    size_t num_found = g_slist_length(targets);
+    if (num_found != 1) {
+        error_setg(&error_fatal, num_found == 0 ?
+                                 "no target-info is available" :
+                                 "more than one target-info is available");
+    }
+
+    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+}
-- 
2.43.0


