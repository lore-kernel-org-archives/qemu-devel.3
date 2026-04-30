Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B45FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJDA-0002dP-DI; Thu, 30 Apr 2026 00:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJD5-0002cC-Jr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:41:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJD2-0006mq-K3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:41:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TNefiP832062
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RiVU/WTlRr3z497hKz8kbA0vmcn0TrtrN+apFOVls3A=; b=E7eWh7dsanOkBP3l
 eUMbZjt3npGHbgratNQ5NImRUUe4f+Y8pAQRU7S91Jo2EfY0Wp22OHeLqCeR3g1R
 bZgPkQrjFGBPU8jKxFZKkrLUmSuhRvrIAgRGQC/aJe5KIoBuk9jO7qk3tqXNB+pt
 lk2018BUUH5MuFMs8aRoUaapzW8LgU6On8Kz7X/MufwMxTocmGgVaXYbvO2flAXG
 iYQTrtVgDWulGuOI4DPEPiSqnu08rmzNFynT7LCjIIPYh/5D62ii8hceUMJGEDl4
 H4trhhK/ua8/bTwokn41Gvn0SA2Xu2LhD40mRDYi/k8a081sI0eXLwVK9R82IiQj
 GrVcTw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duuvb0q2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so745897eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521398; x=1778126198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiVU/WTlRr3z497hKz8kbA0vmcn0TrtrN+apFOVls3A=;
 b=I0cx07eDDa/1cUW4qPqQdT2VO/tLMEQG2+yurQzDn8eVNuE7XbQWDpQCOKODY/wK+y
 noVWS28BkjZxkOfvNg6/z9Y2oJSRm8NwiWkDVOLLaydFAyOLVSeNjXSU0d0fvpgQgTig
 fyFawv/nJ9RlZDZsvlRrSqR6qMukJFq4M5BFMUdJMQF3ofpDeq9I687ald7oIcUKkDmA
 9mTiRiQ2IYtNJpK9Q7uMg9c6CBufdGK6jGcdQMgee3/DMPBToyBA+rGRHmUnhP8fDYq2
 rrsjyd4DxYRCihc/oXrQ7hU/quyvNGS89IoXgbo3JSKnhlQ1DHLw6a18v8rKzmaB0oDL
 wX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521398; x=1778126198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RiVU/WTlRr3z497hKz8kbA0vmcn0TrtrN+apFOVls3A=;
 b=b0vBAXMGQWB5uAXSvHBYajbhZn7NBWzzMqbLWsDQipM1dq2tzuD4k4Ais5kX5VJB44
 DqBF3tx806JOfRTBXYHVd6KLHi/TYRIreMCOtTpxHEqh8q+Gb9lfsaEJYkLOzoKFsh8y
 2V98yDOo0rMG2QNFfY9YPGE2Yy3/3gm9K98m+jiSgtHBSmRD5Di4gWAOVAJ8mtqUkQoa
 uQJNjB6U1XwkJoE79mavVjp/P0kfGh96O5elX3ilYcdfXrGbw42rQv09W3tslit2Hu21
 ZRzdjO8no4Keun6UmsT72VVNW46x3T3IxIFog2VBx4RKXCalB6r9gU0R4ZdhKipP0awS
 calg==
X-Gm-Message-State: AOJu0Yycm3N0nY3UPNThoGA7hHHv2lKaQbLgOY5Aa6a0DcrHeebidzuw
 cht94zzMbY4IP06qmzzPUfqE19vhDoJRVggF0xa6xCGxDWKWHZsS6ltxV2kNMVpXbmF2UwdUecN
 aJBgXqJOY+VR5gKkoZtfv5LMSUcoTT/nXprkMKSubzS8vVHLj0O03ekNejgcJWmkvot6g
X-Gm-Gg: AeBDievJhnBdgIhfmYIZDMwwt6bTZndU/d8v1qcfAU0/0UTOLa5BYJcKcMV8zx3qtvL
 IHOZK8P9UgsSues5fJiB5nJlXjvtZ5/r7QDUVr2/TUCTj8cBa3r+iK/zVOa3Jv1klvug8y/GmBP
 7g5KI4tT1BS7AbUoYtxWfBK0sgPiaZAFjT+Ums962f2xgnopi0co9vz2YYP6K9HtOuK1f38IJZF
 b0pOpoLXmx9G18Fg7sKUot5aHmhBC4UHFjZV2OUOveSE9XKSII5m/DaqRV1V4UxY0Z7r8noJPPY
 /+Q0u6DxpeNg/R5MguvNOFO7646FkNc1L0Iv5uH/j9E7U0oerdvlw5oWXB2O+30f33r3jXMpkHT
 CxB9+NSCytf/iuvQX3PbW8IALBs4Lq3IiGI0RwCs1cDeh5D0CMLqAXzC2gtvMEKvN+TPAoIVaxt
 nfq89xWdrMf1pAUDxY
X-Received: by 2002:a05:7022:1603:b0:12d:c3fb:14a7 with SMTP id
 a92af1059eb24-12deac8fc66mr641864c88.18.1777521397834; 
 Wed, 29 Apr 2026 20:56:37 -0700 (PDT)
X-Received: by 2002:a05:7022:1603:b0:12d:c3fb:14a7 with SMTP id
 a92af1059eb24-12deac8fc66mr641851c88.18.1777521397267; 
 Wed, 29 Apr 2026 20:56:37 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/7] target-info-qom: detect target from QOM
Date: Wed, 29 Apr 2026 20:56:25 -0700
Message-ID: <20260430035626.3511676-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JFnj3U-8AZ9GesKpdWkKgaCApLPsnWC_
X-Proofpoint-ORIG-GUID: JFnj3U-8AZ9GesKpdWkKgaCApLPsnWC_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfXzVyGj5oXiuwS
 syx51PmdqahWHXtU167n9tl1SQiJmKUBqH6J6kfHrq9B57MHZ71OiFMoNNiV3Rs5hh2wMk+l647
 zz9ZpbvXQLJ0Vio8k6fd3DtF7MxKts988Xvl0QPuXN+iMXh+zLWHU8LkdXjEI5DhpkFcUXyLs7+
 MLR6cq+IIQ/+cM3p8yVGeX72kxWteHmqP6bEBmsN1C62xwKwuOu1sS2KMyjnDi9VxWVMmgIS9QJ
 JPNXs0dzeoh4rpmhcZ8hR7epfDR762Zkf7z0OwX63DMCJQNMV2yFnzYNWhgmLi0hGMq/6JD3huU
 +SYwHDdyBMMN/waojOQvjjoVC9G9kJHTmt27DyXPQqvVBZq33r4W3LJSOjeokpTADs1Gid/KKHV
 gpIKhqipspyzftpZX7yIGMIczt5GEGaybUAMyVM8KiSCmuAUTUgeWDO3d1jfL1GD2pPHA6k3Lca
 rtt81oAYmE9UnsJWC+Q==
X-Authority-Analysis: v=2.4 cv=V+JNF+ni c=1 sm=1 tr=0 ts=69f2d2f7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0wc84GFNkZAXjcWhtbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300036
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
index dce1170203f..f98fa030d08 100644
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
 
     /* ensure target-info types are registered before selecting target */
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
 
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
diff --git a/target-info-qom.c b/target-info-qom.c
index ba2c7923760..9d1f50ffcab 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -36,3 +36,19 @@ static const TypeInfo target_info_parent_type = {
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


