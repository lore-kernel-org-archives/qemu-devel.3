Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343FCD3423
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA9-0002vT-9R; Thu, 30 Apr 2026 16:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA1-0002nd-Vd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9z-0000v8-Cs
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UHY7VT1820428
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4wn6h6lW+Df2kPOULV11iyA2ydeEow8w6OKOA1pJM/s=; b=GRlyk0Mtg9f7sIw1
 T10Qmokj19iPK4UqC+r7/2jsRenCjJxyzohvc0qFdIaqaxeZjO5AMlDKdWDl2qHQ
 lhuKc+p9rOUcmYGdn/+XIzFnO5UbRqEzv/caWYpGWSw1pM3edmGGeD4UB3ymHayh
 s5VqQ9zqBfOoT5+eLLtQYd8cRahZxh/IcEoZnNBB0Acooz/RI/IqSj8DmKUxVnYy
 rrfoD2ktWn3sW2l4V7s5KQlkrC8UxUvsMPFrIlAkOjVC4kBkUa1BIgjxSoFMlpgR
 xlU9U8g+C4MMWzaKymU4RKp2lgrZpgMP6YXD9jUGPojVWUeSYo8SRsjEoLMdDYng
 ZnvhwA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv6getgfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so2171703eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581536; x=1778186336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wn6h6lW+Df2kPOULV11iyA2ydeEow8w6OKOA1pJM/s=;
 b=YO3XxeQT95lPtBMymF2eY73m+OKAncd9EA5zecOS2XxR1bOb3M+OAd++0cd0TNKwQi
 6ouSPlekqRtHEkBIyErhHibm4SrKvbcBqo4nwrNZ6Csd76lLR6uYPMWuzv2yRWqGgTH8
 t6sVdmhMX40MOD1VQNqTgXyiro3KV/H+4U3/aBDmR+IOOeNL5tAQHnpJa6QegRete1GN
 NmW9bB2rdt2rwn9RQhvbbVBDdbSOzZBKjuPJg++3qSMCUUufmAiv/osfq/63lRx1DyMv
 /NJ3dsCzEPpYBElQWhvBs7In96v/88lDYgpHHHdRu9+DEGmIOq/+DT2XBtDlCYzk5tM4
 XLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581536; x=1778186336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wn6h6lW+Df2kPOULV11iyA2ydeEow8w6OKOA1pJM/s=;
 b=PoDeKEFIgWLBU8SrH5ehqkyTDQPP8FQehiBXubM5f3dOI3DDbTEgYfRgKasnK6gApE
 b6ebyqtcKnXQCSHWymaxpT5xja7QVIBGxh4Cj5+E9eGnkzbgIZnxBidO9hMl95rtBSBY
 Xjpxkz6JQLW15aEhj/Sv3CutpZw45BhODPe2KBRHzfonpPB9xAMIth0GiPMQ9C5Na28G
 Zf1wW8SSIikn6MUaR1e8p+kmP6JBPJ2EXvwt68bENaVNMsTE7pkuH/Z0zH4gSNyFZI2f
 m7SZjpndZ58RdhQYO1tMc6TG6Cc6pHcNBrLjc8VJnOLjO4kun7Bal3KvH0aNfHMSkVVb
 GGcw==
X-Gm-Message-State: AOJu0YwqGiCJMKoPu/3y5w0eeNss83ipBRMKcdfKMVYkMXkDMPirwAbm
 k/SYRaZ3w4N1QaJ3fCMzurjxIcL9Ni76Enc0ryJiYmPtU+JGZ2QLy1t4j3oEfnhDlNytZ3ZYnXV
 GFXDZ2Ydl12BbDrSvX8xP7b3uV8HkCfjUzh4Az1nJct9tOkv3NX15AxY/pmvPynQDMHGe
X-Gm-Gg: AeBDieuZkxx8ibUd5S7DAWS1TKY404v6nLqLSFCB3aNqOuLu9mgipfWrDTZ/JcU2UTD
 ySGpNpu/T7gUqA+AoGtEgcmGvkXhZVXcj1aNVcYsuSx1S6IF1KT+RuFOXp+jglWPw/drlVHsyJu
 iNGEkvVvI2qEFupeogr/zMe2XHD1Q+lGUcqvmmw/bShO4j3IAb8TvhJGLR/lndkgE0dlWbZ66Bn
 09SfBc/EKd2MpobBrW2OsPxjPNHV2xmobZ2xRNdfwk9ZvrvCUJ0GXbQnWj3luCnrsGShGK+oTzi
 2E/YNtbUjTPgZ00zKcIqcfO+qMgD+f7VZhYFuRlF4CRhEDLJwG4oCXIp7N97WFpOGgELAdZuut2
 /OVfbIsP673ZXjI5Dw8FGvuCmJWX7tGyEv7BYni4uYLs8dixvTahDTmWiCEO+pP+gXEEW9kljPV
 ScWWxD+cCXHhptIKnP
X-Received: by 2002:a05:7301:4e04:b0:2ca:9b08:e7d2 with SMTP id
 5a478bee46e88-2ed3e486e43mr2592732eec.22.1777581536299; 
 Thu, 30 Apr 2026 13:38:56 -0700 (PDT)
X-Received: by 2002:a05:7301:4e04:b0:2ca:9b08:e7d2 with SMTP id
 5a478bee46e88-2ed3e486e43mr2592722eec.22.1777581535835; 
 Thu, 30 Apr 2026 13:38:55 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/8] target-info-qom: detect target from QOM
Date: Thu, 30 Apr 2026 13:38:41 -0700
Message-ID: <20260430203842.29156-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6V4wuyM c=1 sm=1 tr=0 ts=69f3bde1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0wc84GFNkZAXjcWhtbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: rr4Je6_OaZr8qDwNXXJQu0FWyMAxC_ts
X-Proofpoint-ORIG-GUID: rr4Je6_OaZr8qDwNXXJQu0FWyMAxC_ts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX6ZD/MCH25dki
 n4BiNPS8qnUojoeSLQY0nmeueV+sqYVAqMK7BbQcYEuT/jTQopRw6RB9/UVkJLurvb5mfWpQfqd
 ttGTEoXRjzCMup39b0LRd+2cQHIBfFbgR1V2FHRyHtAlz35ACZeNzE69WKOEPIzVdg0vzNj02/i
 uu3MHcAo5pHxF6FnPRQa3irjc0mnzD/7qjBKLFE8hdTK455bTjybDA6pl+LF/w1oem+hQtXmrUW
 cgX98+j0WTqGs1yITJ47ymD8wXL8Y1LY3qT4KIcDwGZ55uE4xfR+2FJlcNj42okNGc22oL7glrt
 Y+CcIRNIHR9+NGVbjlb7UM2YuSPlFG1fUV1Ttngj9jBAOb1IjCFxL39S9K8Z0uC882BLfiylf2X
 FGjvSac8eeD4Re+BcxQcrdasoAF5AazRr3Di6pp5TJ+1FSVpzKwdHbcO8Va8PkmI38WCsghU/nd
 S+SGTk2r2XVVdQJ5FMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300213
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
index f777a6da1ce..b19ea4448ab 100644
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
 
     /* We initialize early QOM types, which include target-info types. */
     module_call_init(MODULE_INIT_QOM_EARLY);
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


