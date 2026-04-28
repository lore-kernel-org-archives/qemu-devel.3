Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B761FF8875
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7n-00034u-5J; Tue, 28 Apr 2026 19:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7k-00033y-2L
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7i-0000Ya-0z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsYJf863031
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3K2dEnlYeDY
 Bhpbj/w6Aq/r7KfXHq+f4EIoUrv7Okd0=; b=WFyuRzJQjADRwUQ0lBz6NTcdShe
 femch4NIdgNlnwxDT0DfaoeeSlFiHCdO+GImMReDfM6K/kYrMuuLl85pIR+2ITn3
 2hgECg+Ld4oBc6MpqdYbAI/uYRNwakjY7v97VBuXKmQxebANkIrjFTYMGWfFlZ+d
 DJB9tAQV5mXlYybdMIPxMIjYhY7PMqGFttxBrMZM4LMOHk83L8WOfoqcrBz8VsZh
 is+d4DbGwmMcvTKVVtvXm/8zvdsjU6xxA9lCiHWL1uKUbTI2P5iSJ6LTOKD2sdKD
 HPcCkbTQbYeAvmvLfLQuqIhMf0r1QEgUpE0BIaL/wPKsH/ML0fBxdTZIMUQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0kds4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so16597260eec.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419948; x=1778024748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K2dEnlYeDYBhpbj/w6Aq/r7KfXHq+f4EIoUrv7Okd0=;
 b=VBrx2Thez2OdmdRTXRv2DZD04o4jAfJ7N/IRZ1wiPiSPpn39xwaIsoI9QSAUTHdnE6
 aqMXFQuUDH1FdponwsEta3Ael4C4ujqshVQF/iMoaGZuSUtYhIQjbSvYBi+sCtdqV912
 /Q8o0dHBR25sbnGe4gkJPCCH0k4p6JvWKsTn8kROLAVM8DXjK3hb7sLRk45CgtS5ga1J
 +pJ4Bd1W4Dq7vbx3een7Fv+dWIwQG4wU164GOPnxuIQg2pEdnw6xIL0PHLaoeQ7vjhKn
 EfrkIbvpHDmIKWDxO5SQcbJzVHVXJ3io19cvEqN/E4xXbE4dLC2bmcqEXSaYmsXhaqL2
 J7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419948; x=1778024748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3K2dEnlYeDYBhpbj/w6Aq/r7KfXHq+f4EIoUrv7Okd0=;
 b=Ugm6R47b0jxECpxoFCcQju/M4sY56Z1ZDgaLrOTOwNZg/b/WleoFLISARV0Go4TV33
 yaYrq4H60vNM2x2bjttWl/UydsglCUDzgTRT2ps+mzQ/os1yGC/i+Qk3CScI6jiWy7a9
 d6DX4tDb1OS0rYB41PkWztMgYUAGeaB0+O7AwP6dRCGC5xqAVnxEfjJXMydlONJvroR/
 IGwzIyrqw8nmUYfK7QdpeyIm/Aa+eJUzmNlwCDID5M3yOgLcEG6vbF3QFFQLQrUXiIm3
 4II5AoHXa0ZVavPWT2gy3tcTapZrruEZ2AaDMSDC7JAbCTbEC3YPWpH2/c4i1qu9m7u5
 GXzg==
X-Gm-Message-State: AOJu0Yxgwdi+TSRnOzYVhwN9icISzq90twv10hAQG4ZUx+nwKFINA4ki
 YV0k+zs0IYN7cgLgbTQ8+WCNq2sZySwD6ngH8Vc8ddzPQhP95mW8Ij2R4MgzKCEvySuvkQ3nGcg
 nL1m15ytm4UDUwrjMbaxIzS954KBoBTD6LgRNsRwvgHftHTZTwxVZAz22PbEy+eC0zqMu
X-Gm-Gg: AeBDieufrlj3ET53VS0oDkW3BQ2DPYUETSROMKFYe6q+2lU0UTdQJ/S2kbwUZG6YsXO
 p4amsa2V0qgBLD/IRdn9wcMPMfc/6XlEIVcW/uHdIL01XzwsSDmc7RPnm9F/z5igts6yXUD93qk
 n2IzeIw9cBcw9iJzmffA53++frICILy9eJBjoavgWbGS/TRAIgyLNaZEUAx9zVNOJOaNcFgHt6g
 aGcTJFaI4uOeDwAHaP8rg2FjA7Ef8oMx738sVQO/4AecIYsitX/EDzxHn/XW9800RewWdmfaXXO
 9jnDlWtC9i2gCDqcc9bK78WUvA2AB4/5WStGiuwzbM0fjCFTdmjg+71SzFSrIE5mWqyZz/6/1Gj
 vVM1BVYbdn3yc71aFRF0kGkGLSKtE+3GW1jwV/6iBDj5U5x+O5/aoUkUEO0DMNyzfjE62mPBqFt
 XAHgSqb0qhdYUy93s3
X-Received: by 2002:a05:7300:2319:b0:2ed:e12:376b with SMTP id
 5a478bee46e88-2ed0e12877cmr1949043eec.33.1777419948014; 
 Tue, 28 Apr 2026 16:45:48 -0700 (PDT)
X-Received: by 2002:a05:7300:2319:b0:2ed:e12:376b with SMTP id
 5a478bee46e88-2ed0e12877cmr1949030eec.33.1777419947468; 
 Tue, 28 Apr 2026 16:45:47 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/6] target-info-qom: detect target from QOM
Date: Tue, 28 Apr 2026 16:45:18 -0700
Message-ID: <20260428234519.1812371-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f146ad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=n7PvVioabm-zFifqlqsA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: J6xve1gdV9H3Dz5fzK1pCTpVnXDRZ5UY
X-Proofpoint-ORIG-GUID: J6xve1gdV9H3Dz5fzK1pCTpVnXDRZ5UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfX6whz+b/ySceI
 Y9+lJnBUugBeWqUGRpMmj379y5P1uFF5E3Kc9QdMixY2Zg5QYlxLkRvn4mJOKEnM4+GmKPjWmEf
 91VEEfVcn+IwhyPxrgvvGL++2kH/LU41LlBNJgkXOufK68OVS8h1OH5YiqJeMnu01oDuSgzlPUF
 zZKVD8p0ZmFnwfK60TfY1rbEVDOng/CCTE246sBZfxjMQcz+xwKwLdwH1YFAoi1aUG04t3FJkMz
 kHFaEfSPP3I1iNPWEm/oC+CWHZvTRdn91tJNegpJMPT7dSXBJlEl2lFLkQNssQodnUukeR7QHgs
 bS2pXzwiMD7f3/78KJfklSMHOfAQwK+GRT3F4OwGy9uH05FL7hekSOytmJPqYC8jsxFTQwaPUVX
 mCEd8D/2lm7n/beupFBiwzUsqg1WrGESq2v4sf3uo9heLl8La2HoU0YIhxubU9be5YKid4MVwpz
 CK+0RSasNOlPHQifwWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280234
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index db069db718a..9549465aa64 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -21,3 +21,5 @@ typedef struct TargetInfoQomClass {
 } TargetInfoQomClass;
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
+
+void target_info_qom_set_target(void);
diff --git a/system/vl.c b/system/vl.c
index b4a5ea6f857..96a03ff2ff7 100644
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
@@ -2891,6 +2892,7 @@ void qemu_init(int argc, char **argv)
     module_init_info(qemu_modinfo);
     /* We need to initialize QOM first to detect target */
     module_call_init(MODULE_INIT_QOM);
+    target_info_qom_set_target();
 
     module_allow_arch(target_name());
 
diff --git a/target-info-qom.c b/target-info-qom.c
index 5ce29f80301..748fdd5a8fb 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -32,3 +32,20 @@ static const TypeInfo target_info_types[] = {
 };
 
 DEFINE_TYPES(target_info_types)
+
+static const TargetInfo *target_info_ptr;
+
+void target_info_qom_set_target(void)
+{
+    g_autoptr(GSList) targets =
+        object_class_get_list_by_name_prefix(TYPE_TARGET_INFO, false);
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


