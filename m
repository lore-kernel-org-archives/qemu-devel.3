Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECD1CD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyw-0000gV-42; Fri, 08 May 2026 20:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyQ-0000Tm-8b
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyO-0005yt-Mh
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648N7wHQ257853
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EqWj9/dq2Uc
 CMjZDn8X5RDV+nwKrGwJ6F1azjrIAg+o=; b=NQzRrFKPwGwrPo5MUbx8jjSoYQJ
 32aOiruPL6CaoH6n/nEhHh63kA2/kdchAkpmEXTNvWF5mpJ5/OpjkChEYDeUcGAz
 ardwXSaM59Zj513LJaI8hCaCpHtO2QviQvtpUskVhQgq0GLYBuyJl76d1GYFvcYu
 awkmrAEYIzFGwOCrU3oKWRnnF5n/OSn6KkCfIQdldWR8XWEuwBSWOyxKzFCw8adK
 8PUFeiqtTMenRotYdDdy+nZ7MXXfHzbqmXJbtZjLixhqTFjDKbTQk6pMKVHzoTSa
 2dJtPr7bTHI5k6HX8DbY5+CaAaM+T3NOPVZall93ABITXMB5M7SBL0sa9Ww==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auekkjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f485961555so7056605eec.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288114; x=1778892914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqWj9/dq2UcCMjZDn8X5RDV+nwKrGwJ6F1azjrIAg+o=;
 b=Zp0ZzPVx9IzgCLZhkfe9Xveo1N9HIsPdoF0Pa2e9Zuo2840/y/iB1akMbuuRg5yc7L
 ti3t3gs+NNmvXH9Q4x9MRYiOLgtdSrXdN0uKMqUUcfnIVWfxDK+D0Jh+kaKUwLjlDh7J
 SuG/n/YuFxV5kqYzXgLokJbp1EWTSi5NlBhOliIbzYNOogyOQLUJ/LP1q26jrWxiAO8K
 G/c2o7KebTUJP6ctNUzqUxeSR0YAC71rBK06TVD53pbjiZxto/tnfGFxYVOWxopQ0ThE
 lNTTEQCR5F582NTtJRA2AV4uSm+fIQV7KlhoDFlkgOzlb/ZhTTYgA1ZK6dabbtv8Fw5V
 xT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288114; x=1778892914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqWj9/dq2UcCMjZDn8X5RDV+nwKrGwJ6F1azjrIAg+o=;
 b=oNY/h2YFsHG4DgQMNHmKYilj6wOSdKln2Lqxyks3JjGuE+1L8Hq3k1kViN/3pMiXKU
 edyMMtz0scmxSCttguMWz3rkx+zFTF/eGTxXGf6Onxkv0B3DOUSEhU8sUsnJiAU/EvUm
 lDdfBkGm2qJi6ITtux22BtWSIcVZMinOoYiOLvASuA1PaHa+yxqrdRxs/BUSXMioL4kB
 5rTXZhBUZfDdd4akgNR7CcKsIOaH1HIVYRZdnP/3y+pOBvDOQd/8+zuYWiuH1DGM9h7c
 q5vtWza9FCN2rmxK8Us5HSSMbnyCiJbWEB21Yi1996ox5BZ+W1RLgFkzxDq/uoa4EZo8
 DhXg==
X-Gm-Message-State: AOJu0YxLKqAwkuHjntcyTb4JK8orkfPD4rm4b+Uch7C1Aq4l+gVydddN
 2kUQREYjyPHQda7ovaJRudgb5bsBx+3k5TNa9bC/8plAW1RktYS/Bhzaq/27i0eWgLnvNnDepH5
 5wQb0QmAX73puTVjuv2SJndsMjCeHFMY2GBlsvQTnGEuMplDMucSvs+EoIrWLqcEtmsEU
X-Gm-Gg: Acq92OFETJUmBk1SMj/5oZf/Gme6UxMZhERewD3OWhKgegeRF9850qk2hUayS5I7BtJ
 l+7Ip6He8rH81us5HXOkn5YnwNZGIQHeyI3gokHHtJKxvSmVWc5+QDokeMGdnsvq99hMFWcylYM
 J55tWHYFCt0VGwN1XmfnnG2UM3ATV8TdhFwBTSag2OaWytJDdHbWhQoL0feryTN1Dxu3kVbXUwR
 Y02B6iemIDS5BXEC98kwwuvzv7xBQkQlXsddUR2uy8oJlYPDdE+7pKN6ZOgggNiijbtoCVtSSyf
 RuqRJrHsbLC3KG3I0ZwS+JnOYo8Ir4HNJUfXtbl8k8fdFCOQagjcdNh/AoB5cNC24XsTAhUsnhM
 rWgltY9kxQvhQKRbqqmTNCQ/04Qg1vXTaQHux+DMjPX8rz21AS0bCBQnHeKCwzLz2zAsCrCNFFr
 3z0GyVzg==
X-Received: by 2002:a05:7301:1687:b0:2ed:7e1:975 with SMTP id
 5a478bee46e88-2fb3dbf9718mr215135eec.1.1778288114101; 
 Fri, 08 May 2026 17:55:14 -0700 (PDT)
X-Received: by 2002:a05:7301:1687:b0:2ed:7e1:975 with SMTP id
 5a478bee46e88-2fb3dbf9718mr215118eec.1.1778288113561; 
 Fri, 08 May 2026 17:55:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 6/6] target-info-qom: use a single class_init for
 target-info-* classes
Date: Fri,  8 May 2026 17:54:53 -0700
Message-ID: <20260509005453.3984184-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfXym5VHBwU6LNE
 Husk8KCpVdekKrio21C3C/f7yGbkHWIVAlMhT4xO+Tu4vz2HD3y2rRuVraAA66207d4K24AhVn8
 jL2qduOAzc7sjJIo9EA9vjt86lOLWOfBD2H5SZzfo3dXvf9obe4NzcbcukMZlDzl+yYuOImCjkk
 4v6JTpzBEfvgd5m7kBqd2A0+cuyctlJmTncOohGhXqbJi9p2a0wxWv9JfYAaPsNkpIKJ25zxAsc
 Uslx4mBYgSimvTfCSxJ6KqC1Kx5yx9gla9CeHaeg1Tn6Q7Jy74IUgY86uYRfMB+k0WXqSBmLM/p
 T4kWeeRCXv286UcF3XJiMu4ypulVJI0gp8sF9qfzJdx7AfKKQtUxudfJdMg5zARpr9RFbF9tRXX
 MSi0pQJO2HU97f1jHtjhqTVsA/BWNKzTcEDrenq3MUzDhcqfyHAlrRep3w+43+vZhhuTWfwFOEq
 Jce0gQBxzqsmHw2lHfw==
X-Proofpoint-GUID: IMgB8tJgEpCiZstKI3c_DWORWmLmPKFJ
X-Proofpoint-ORIG-GUID: IMgB8tJgEpCiZstKI3c_DWORWmLmPKFJ
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fe85f3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ilk2Vr1kweFqPRpfcZEA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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

Instead of defining a class_init per class, just use a common
constructor and set class_data to corresponding TargetInfo structure.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 14 ++------------
 include/qemu/target-info-qom.h  |  1 +
 target-info-qom.c               |  6 ++++++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 176fd975a16..3945f2998e0 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -37,8 +37,6 @@ const TargetInfo *target_info(void)     \
 #include "qemu/target-info-qom.h"
 #include "qom/object.h"
 
-#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
-
 typedef struct TargetInfoQomTarget {
     TargetInfoQom parent;
 } TargetInfoQomTarget;
@@ -47,24 +45,16 @@ typedef struct TargetInfoQomTargetClass {
     TargetInfoQomClass parent_class;
 } TargetInfoQomTargetClass;
 
-OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
-
 #define target_info_init(ti_var)                                            \
-static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
-{                                                                           \
-    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
-    klass->parent_class.target_info = &ti_var;                              \
-}                                                                           \
-                                                                            \
 static const TypeInfo target_info_qom_target_type_info = {                  \
-    .name = TYPE_TARGET_INFO_TARGET,                                        \
+    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
     .parent = TYPE_TARGET_INFO,                                             \
     .instance_size = sizeof(TargetInfoQomTarget),                           \
     .class_size = sizeof(TargetInfoQomTargetClass),                         \
     .class_init = target_info_qom_class_init,                               \
+    .class_data = &ti_var,                                                  \
     .abstract = false,                                                      \
 };                                                                          \
-                                                                            \
 DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..a37c3e101e0 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -25,6 +25,7 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
+void target_info_qom_class_init(ObjectClass *oc, const void * data);
 void target_info_qom_set_target(void);
 
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/target-info-qom.c b/target-info-qom.c
index cc470b3b4d6..5b0498ca654 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -37,6 +37,12 @@ static const TypeInfo target_info_parent_type = {
 
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
+void target_info_qom_class_init(ObjectClass *oc, const void * data)
+{
+    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
+    klass->target_info = data;
+}
+
 static const TargetInfo *target_info_ptr;
 
 const TargetInfo *target_info(void)
-- 
2.43.0


