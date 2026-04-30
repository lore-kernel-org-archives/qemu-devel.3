Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF72FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIwH-0007QN-GE; Thu, 30 Apr 2026 00:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIwF-0007Nv-6E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:23:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIwD-0002GJ-Fp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:23:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TNvMaZ3733700
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IFcxnBKVAgB
 1MK7c4GA0GzJHutJaaZT1qBsCJEhah18=; b=CSYBgWJcVRJRjODKgKxYUicDkfw
 QYZyVRMA+M00Rszlk7t5BPVx2DKjLbqIFWkz13A6yz6XFgkGlQCvMgYwTnokBp0f
 2ErsCF/o2VJGmb72KDKoxAEucj0z5aytJk9ocXSOk0UxL2qse6NNte1y3OQq8wF4
 sqbgdfmg+e4+Yn+tjC/91kT+FfxRw2UVVqJ9mTJZejfUYNkhUb/eyP248Qw2ByOa
 l3nwFy0dh+WnQLko6Cv+lua1cQR5RSqjQAm7yrseW5Gh+9YFSGvGu3htYmmQ9wER
 6seNTVyy66WwkAVjiu4eBk12WwVH6ZlK10LwOE5c2jZ+CqrKixNM9D98uSQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3x8p5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dece274b1so269650c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521397; x=1778126197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFcxnBKVAgB1MK7c4GA0GzJHutJaaZT1qBsCJEhah18=;
 b=XldI9drCiLw/xG9dGwynnmxPEJazYEUNV9yjzpxorVV3v3qqK9CTvb7pEPoBS0FbIQ
 NmfYrj6EoYIj3gGc3TAq/nyAnfAl7iCcVATLNu0ZkNpto4902rWmUBy6Y9+WkRW53vpT
 e1jVQRASYndNcRu1bp0TgDuesIIugctRmq0dd2r5EFwmubu7yW/jAjZMkGZ3BuV1WAo1
 Sin9gWuUXTdGonFR+a545/cLem1xYDOBBYsFwtGlXE7KTFabmgDA/guWM8Uah/P2WfK/
 B5ZMdBU5HbW9SQBT+sJt+pF/i5mAtpSISuo6E1MVtIAqyufoCrVZ/YoLYMYeyBhhRqpL
 Doow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521397; x=1778126197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFcxnBKVAgB1MK7c4GA0GzJHutJaaZT1qBsCJEhah18=;
 b=GeARzPHbP0S6GZ9Twx1TSaLNMRjmdTxuF2J2Hk9F8Id/SWDo9qFnBodlKWH+8clKmN
 8RVRt41FzK6MkECWuxVAO3n5hLjZ0hGmBzm/L1WoZq1hEZIiT0vyftXHnNt/oyIhUoVA
 Lkp7nP6amiTvFS9CqeL9AX+fUnThLACJ6G1/LYRu6rlp1+G72KGOoniNrudj/Pkatmg1
 CvvWxeXNwWg1yNj07ZQcgMW0oYkK7DGnxFOPKt0LI0VlXGciD2iUaNz/2VC3FbWJ+ust
 2aySpsRqfFmnDS7a+itzzf30qLiP5Rc/mRdRxCH8J5EsaFGkO5x2z/xvVI1Amec6+3/q
 UwSA==
X-Gm-Message-State: AOJu0Ywpoc449wVTQ51BIcghAOpuyLoWWpe828LXHObOA0hNVAOH6aJf
 Q26pRCgi0ecYkhj3eMiVEUMAKuHMpLOpypRsfWaBOjgXojj9Uk39/yxOcJOXRsQx7gAvxMOKx3g
 rRVlxM6NnbYMn9N9tCQB1bC0xtxp93aMP1S6Uf35F+h4862oC69ex1JObUc0NU+IdmYB+
X-Gm-Gg: AeBDievBmemQyF48xrQmDbWCD5RukDjq+PUwtrI9xUiHebRy16gsb4mDcs++OaV8NT/
 S60oud3+1EazHtWfhDRPUHrepuq5KUIX94Fm5ooEfwcRKn5iQVHuG9l4d8IpQSMzm9iHRgcnFpM
 FBkfh5Q8EGIItMXq01BI/AV2qaWVpXznNfqU77HwiS3nrfrFsCjCLODD3wE/i6cRKCg2YjJH17O
 yCyoHQgHoOaA8xBzoZZU0AUJffe/rbT6RGnvp2pwQH125K0DFAfI4ilCbhT1oaCQGtOwy1A2FaK
 UNn+LpsVP93DJ1u/lCSzeCELau/zasIqkkbgCYRRKouXIraTq3ujqAXjW389cdyxtMaXGxC4z/W
 QwiQIKHcPArhpjQuVQlifBrpxNSs189Jxs1AECAWEA1vaf0nLmLKwr6PbEG7x1rQFFxKffG9IlW
 nbImQ/iO9o050x2uQL
X-Received: by 2002:a05:7022:ea32:b0:128:d23d:81aa with SMTP id
 a92af1059eb24-12deace029bmr507811c88.27.1777521396942; 
 Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
X-Received: by 2002:a05:7022:ea32:b0:128:d23d:81aa with SMTP id
 a92af1059eb24-12deace029bmr507793c88.27.1777521396444; 
 Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/7] system/vl: register target info types first in qom
Date: Wed, 29 Apr 2026 20:56:24 -0700
Message-ID: <20260430035626.3511676-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfXzOhNw39crr/k
 IvOBZGdIucLc6we7eYLCEDK9hDCXf7Y8w28r/NPKBvD16hsT/nMZYKAv5zM3F2ZKWfsedLGconb
 /NOpb6hBbtyjxA/HQ+ovFk39SeLrsj1Isk01Al6p99XcGypd9b26QJapGTJOzbJT6tlKfGUnR8i
 nrOftN6btd7Ty5ZjJ08IuxWZHm3hcwwjMxu8zdydyE8Jbg+wSz+A7+qjQm7tK+WDcOc3tN+qSIP
 xMGrJuz5od41HGUuTbTkQxH9G+5i1ro++CcLMrFT5icoCYBgPXcIV+tk/2ArogUCn9e+K+DJHvx
 nNOw6kqwuCs3GPYZd20Ki7Yd/9bwJxgTXZ0EMnltLzvkJ20Nb2hA6obYB6Ks08SM5RWL2aiz402
 YGEnu4wxbH8B4mzywhXrqlaU27Tg9KK1bIL58bwgXSwCjvs8E2etZQDaqwmnP7ipAOnQkd8Krwn
 IF0GdmzmtKfJrAlSOjQ==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f2d2f6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2T1URBfsDFyyNY1JCakA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: EivZTAzCmZpbRVdjdPPd6k7X748LWSCu
X-Proofpoint-ORIG-GUID: EivZTAzCmZpbRVdjdPPd6k7X748LWSCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
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

We will introduce detection of target from QOM, so we need to make sure
those types are registered. As well, it ensure no other types are
registered yet, so we can safely call object_class_get_list.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/module.h           |  1 +
 include/qemu/target-info-init.h | 17 +++++++++++++----
 system/vl.c                     |  3 +++
 target-info-qom.c               | 18 +++++++++++-------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 9885ac9afb3..fccf017bf9e 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -43,6 +43,7 @@ typedef enum {
     MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
+    MODULE_INIT_TARGET_INFO,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 1e52ad62820..859451c672e 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -12,6 +12,14 @@
 #ifndef TARGET_INFO_DEF_H
 #define TARGET_INFO_DEF_H
 
+#define DEFINE_TARGET_INFO_TYPE(info)                                       \
+static void do_qemu_init_target_info(void)                                  \
+{                                                                           \
+    type_register_static(&info);                                            \
+}                                                                           \
+module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
+
+#ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_USER_ONLY
 
 /*
@@ -53,17 +61,18 @@ static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
     klass->parent_class.target_info = &ti_var;                              \
 }                                                                           \
                                                                             \
-static const TypeInfo target_info_qom_target_type_info[] = {                \
-{                                                                           \
+static const TypeInfo target_info_qom_target_type_info = {                  \
     .name = TYPE_TARGET_INFO_TARGET,                                        \
     .parent = TYPE_TARGET_INFO,                                             \
     .instance_size = sizeof(TargetInfoQomTarget),                           \
     .class_size = sizeof(TargetInfoQomTargetClass),                         \
     .class_init = target_info_qom_class_init,                               \
     .abstract = false,                                                      \
-} };                                                                        \
-DEFINE_TYPES(target_info_qom_target_type_info)
+};                                                                          \
+                                                                            \
+DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
 
 #endif /* CONFIG_USER_ONLY */
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* TARGET_INFO_DEF_H */
diff --git a/system/vl.c b/system/vl.c
index 0e1fc217b4f..dce1170203f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2888,6 +2888,9 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
+    /* ensure target-info types are registered before selecting target */
+    module_call_init(MODULE_INIT_TARGET_INFO);
+
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-qom.c b/target-info-qom.c
index 5ce29f80301..ba2c7923760 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -10,17 +10,11 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
-    {
-        .name = TYPE_TARGET_INFO,
-        .parent = TYPE_OBJECT,
-        .instance_size = sizeof(TargetInfoQom),
-        .class_size = sizeof(TargetInfoQomClass),
-        .abstract = true,
-    },
     {
         .name           = TYPE_TARGET_ARM_MACHINE,
         .parent         = TYPE_INTERFACE,
@@ -32,3 +26,13 @@ static const TypeInfo target_info_types[] = {
 };
 
 DEFINE_TYPES(target_info_types)
+
+static const TypeInfo target_info_parent_type = {
+    .name = TYPE_TARGET_INFO,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TargetInfoQom),
+    .class_size = sizeof(TargetInfoQomClass),
+    .abstract = true,
+};
+
+DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
-- 
2.43.0


