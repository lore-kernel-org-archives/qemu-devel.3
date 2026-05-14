Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D86ACD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmR-0003cj-Bn; Thu, 14 May 2026 13:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmK-0003bK-5m
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmH-0005iw-G1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeXAu2241739
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YT2tyTyZY3pjT45Atqj6B2IVwPHfvfmCb9TBLDMZRU4=; b=QFDbADXtaghiDdv0
 u8XGNmNte6mbb/zZDkZDHZoay3V6vh5+SzCeXnVTE4MAPY6lWqOdGk1onbZHwYiM
 isWoyvqv1IdSY1cSJmGH3WR0rovzRa244zsCm2LqaItCSUx0dgqhN7Px9paOftxu
 CFbPtKMqXBsHSruE9Dlm2HAhttkr84wFq2FSQsXlMWYzagLdNES1b1I0urlhlQgv
 6Fo8DA+dGFnNriBXmWedb8kzhGQc1mjZBy7883A+gLsbaUR8rTpO/BA5LObwxMp4
 J0bxH1hxE8fG/887azOMrX8QdLlLVq6XZsCNPKXNwgZaFu4vAKTpkYQ+Cq67LZvf
 U/I5JA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gbtan-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30230e64087so1987466eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779395; x=1779384195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YT2tyTyZY3pjT45Atqj6B2IVwPHfvfmCb9TBLDMZRU4=;
 b=RzLLf5or3TO+nJcKxCgMKZbcM8fflSosiZnouXhaayMAARDjNCXo0AHNhEyISFsvYA
 dOYU0z048jjYcQI6E231JPKFZHhm969/ei1FTIh87XUrMVsBv8wG5jmT6mgLYmXskBuU
 awf78+MGPe0YiK2X/9k3ud1R8a62Vj3qCAal+cOkxBPSGRApX4eFuZcJLvVUgBC5eGoh
 36X8JkKbUU6wJUAk4glgynAimoQKj+casw9rbk+JL9Hsfs1jPxwSqIB0e8PyHPcvGyar
 hi1F124yhGIzSKUJ/FoLPQDG5D3Ps3WXMhAf4YvdqIK8jCyzh8Y08buse+4vyTAWnJ+Z
 Y+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779395; x=1779384195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YT2tyTyZY3pjT45Atqj6B2IVwPHfvfmCb9TBLDMZRU4=;
 b=Rn+QXPUgikaiveAS621e3QWkKBcs1nVpEMB4MAbbpEE2E1wAPkWpaO/Hv7jcprsCUN
 Ye4WBjDHCVxm5scbpZLlsjViyn73bZ5mpPVKQXWOiRGGA/k4VPSFgtFZyRdVV2oiEy+f
 usEFUgkIMXA6gzgfC243y1DVO9cO+686e6wIxF7bE+7UWervazpTWT2FJiBtNrX16F1Q
 ysjqGsKXWO9A9vPSCqWyVS2D/kl1UIXgjc8m/q16KQ/m7p3jJUakJm59W2EwQurNwSoq
 3lt2/H4rU/GKS594pS84hvqSM9wL3NwdJF6XXoiAHA8XwMMWGijR6WUgoyErwrttcIIJ
 gOdQ==
X-Gm-Message-State: AOJu0YzcPOuROcT3/gM9LYqf6/+dLUG+2ObaSSkC4jfvvA3rFffguhdI
 wIEpvQpYc1WvxguNc5SsguBFDgk3fJ5A8kzPz043CdTI/qM0Z3Tosp7RRFzq/q8KPqHVGipDcqi
 B0NAQrHlTs2Ph/VBQDNz2VP8nbPImni3jAp3Si9TmDLSS8w8eSJy4uZttZUJWf8Vj9Q1F
X-Gm-Gg: Acq92OG4aGj0C+HK7hjgoll/bzLjvz93jj2H4AJbxeH3gK9ggEAZuxW7suI3BMkC4nZ
 ugQR4dJzpQ5G1WomHs8wraz/iBYXCPUJFX62Jhf9eDQ7Bh20APXQAWsFxkCmiq8mDRLMThkJ+Cr
 TczHHCDjHnyCB4ZwzeSzcp1pCj7vzuvOevAUFgnsH3yqVllLDfn1zcs4HmzKy6jyGR9UgCZnc/h
 Zf56TPiyS2sZG5jQ8RImsPT99xwRe/J5eb8+RX1SXtdQMCjGi1P2GALEPHTWdpdJ1zBZqetXiTd
 PInXKjJ+P4DaeewmicFbtSUABbOt2245Bil0bRcjqoTuV+iQnwzsrJVgopDSMTaYMuxfq4MJM5g
 41jveKa4hQIFxYm+CdVT6Jk5VE4sRof3+Np2yaWZlnca/Li1o7OrIL3zTI44zTgnIAJKpY3pxQ2
 mWwQ+E2Q==
X-Received: by 2002:a05:7301:688:b0:2e2:5bc5:f8eb with SMTP id
 5a478bee46e88-303982c04demr250744eec.9.1778779394989; 
 Thu, 14 May 2026 10:23:14 -0700 (PDT)
X-Received: by 2002:a05:7301:688:b0:2e2:5bc5:f8eb with SMTP id
 5a478bee46e88-303982c04demr250709eec.9.1778779394444; 
 Thu, 14 May 2026 10:23:14 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v7 4/5] target-info-qom: detect target from QOM
Date: Thu, 14 May 2026 10:23:02 -0700
Message-ID: <20260514172303.1484273-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfX+kUv4wd39JR8
 psVSwW4XANOTse96L0y/wfhdhhraAFBMqadVuDYRfpbQKB6ASSffILjqQM4ZoIR9KYvjEuxyPKl
 GHW2j/4PIVoQJoa/ubMslmvBHok2um0gYGuRUXJDy3izjdBaGc7nevBf926JmgVmoeS//H+mhty
 Fj3lKW+yuRaONBL0scMC88bd7pshw3OBU0aLrQO8bQw53CtPwbidqGIKO5vtwoGFRTpKeoddEmx
 n3uqk4l4P86J80LvFMYTh0M88O5jBfpCAgPYK4ZCrUefuZtYae5TT+VmCwjXwCKJsI5Sf5OO6YJ
 YXLL+nvROVYdrO3ZEIKhUnzH5/9H0mWOs7e57FiA2/kbKC6sAGf8r1i1+c+/8HpO+pvWa1Fo46N
 379jL8gF42UdS5q7oTAwi08OI94s30Kkze205H3HPIXsdRQI81a41zgloq16HGA3WrjBBeYuFtd
 yRSJ15u2XcU+njT2Cmw==
X-Proofpoint-ORIG-GUID: RJP3l10lwrhzQnwesQkJbCTDKibkZakN
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a060503 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ta8ybb0yH1EomjxcGswA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RJP3l10lwrhzQnwesQkJbCTDKibkZakN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140174
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

For now, we expect only one target to be available at runtime. This will
change with the single-binary and we'll detect which one to use
dynamically.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 16 ++++++++++++++++
 tests/qtest/fuzz/fuzz.c        |  2 ++
 4 files changed, 22 insertions(+)

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
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index de230d20e0f..a3a131c80f8 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -22,6 +22,7 @@
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
+#include "qemu/target-info-qom.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
@@ -173,6 +174,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Initialize qgraph and modules */
     qos_graph_init();
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.43.0


