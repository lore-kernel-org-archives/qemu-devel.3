Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE73C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Ua-0004ue-Go; Thu, 23 Jul 2026 20:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UY-0004tb-EX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UW-00068r-FN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLej2n1069854
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7qBNQLZSMZC
 zzBeLLEpL+wIQxM0awoZvi2Nk8v58f+A=; b=iTnfu8UUoJJ3YnX7O6WvxKYh8xS
 msAUpEOyaRZ81splJmbkMjssCDvG56VYxfgZaXgPQ8DwwFR3tXU8dDdXLKfRucKe
 ep0yr2OrDfVBYDY6a0RSBKa6/JspG4j0D6Ez9Xo5QUzuaJOJ79SegASPlIANnbnN
 0aXFGCA2zoSGG5nJCCuvKfSjp2VUfBFbxSeKdciPItOeqWTCoLXt5jsbYWydI5/3
 SssXhPHO4uQrohl8nAKAiCfnidZiTRMfcvoljSDrtoF7pLBDbQK9YjBxf/A+nuqX
 eAWP6ksOXb8Zct1fZhZasmmt0Qa23X17+Y79WHrnM/59p5JU6PwPbJVkJJg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg523f33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso16993335ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851814; x=1785456614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qBNQLZSMZCzzBeLLEpL+wIQxM0awoZvi2Nk8v58f+A=;
 b=OjmdW+JhZxewuleD/91Pyllr1iBxS2gX7Oqdy5fOEtq87wXsDwiyHwtPo6U70Ogcmw
 mCOnxGKshiMN1W1pbPYXAUEf90T/KH0LUCK7gRjlCIbV6TiCAkz7fca6gfBNWl5KLg5E
 7GOfS/qXsKWdGbVRte7EICM+UgOcX/G6YQ4LBmQ4fC9pUZOTIe5PD/RDCRtdpiQkO6OP
 sd7rt85uwEoI3NOIctAyLVZ8Dur2o1wEVknGFAJ05FYZBFvwtI5QOqqL1JQHcduY+IIf
 vM/O219v/jAu7TBUG1i3qrykA/QciL9q7uI2hXbCGz5tePL8oKnNGAZKH6C6n4lpYoLV
 ZXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851814; x=1785456614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qBNQLZSMZCzzBeLLEpL+wIQxM0awoZvi2Nk8v58f+A=;
 b=csAVTQeMPeRTNy9bEy22US/toO/vMeJciplFiMbHdd7uZx0OKTsoq2akj+gCFe5pwt
 JBWYAbQ3SaHqu46YC0fmx9V3U7RPnmleRfTaWOu1T14hn1NBkg/nO6q5608/bGlOOdZk
 q9TIAeqWDaEs880frQ/OxOBlbe4YVZ+SKixIhmET1k2zBOLwxbme4VzR/4mfyRCwuMfV
 VLaSDL3xhOPTAYwNHbgkQlaPiApciDhXb6xGMh3fbFhuxYXwhVjk8yX7qAVYo9a2llcH
 HbFhyZCUZgNYzEVOonq/aN8QB6mRR8wcUUiugIi3YdlDWhOhJpA/D9yImMg8kaK5ixUy
 VNog==
X-Gm-Message-State: AOJu0YzVyEvHiFI8p3WEGHy5ELI6ycB4fRmV1dyouaBnXOp871f60zQC
 cDZEwsTm6dXTT8KQR9drKFFed9PQtZRLbBt/3SNGjX8xaihGyaHKH5lFTVglezZtyiYQi/63nTJ
 18oYGyhhhPvFjKVYdG/tyTCORW/XAjJLOoevqIQvDeHzTx8KqVQDW6gzre2QHHuEVUA==
X-Gm-Gg: AR+sD12YTb2joIwSrTEEy0Uj4YgghKgPcvDKKWdac4we6T2zxw/1W3Y4Vzxz6jP0Dmo
 UcC6qIAnf3283+w7q1/YTDkD6lTcqzyj8adC962BYezm43gAalJdSi/hBIX3oEspnNBxc45lgYk
 aQg4T0RUTeGmvsKoXur/ZnyWT9ODWDhPN3MTKN9LKMbVmEWVnoYRJJ7MBugQvrqlGcueou/iqjy
 HHoAOs0GpAt+mrZ2vByBJI9z5OloDk1x+k0gvoL6ORMXhVBMpFiNuEelk8CLPmTAbmmARlroHp3
 S9v/uW5rn5Hm/16K5tGivChs4UHciYcq3+zZGN/I/H7h+T2MRKo81x6v53JQs6BS0OVVPwzvxwJ
 trSjLhItv6gGcTYfV+c20CFXWcrCK1iCGpWP+dLGX9PqRXdrrJ4C0D4VHYgsGPpjBea7NfuU=
X-Received: by 2002:a17:902:dac7:b0:2c7:ebfb:618f with SMTP id
 d9443c01a7336-2cfa6b73a76mr61462645ad.14.1784851814459; 
 Thu, 23 Jul 2026 17:10:14 -0700 (PDT)
X-Received: by 2002:a17:902:dac7:b0:2c7:ebfb:618f with SMTP id
 d9443c01a7336-2cfa6b73a76mr61462275ad.14.1784851814019; 
 Thu, 23 Jul 2026 17:10:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 13/27] target-info-qom: implement new machine filtering per
 target
Date: Fri, 24 Jul 2026 00:09:33 +0000
Message-ID: <20260724000948.234657-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a62ad67 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=O4mqDDhjlV4vxgb4wgQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX6m6si8+RsuYs
 Of5T/MBJxq0IUNxzMSQvdwFggQ9ccqhJ/oo+rwS6Ahtk5vX3GcJ2Ta4B6tCMllBiz2MHgyjG+wM
 YOD5O3xglq7ZkkyWvMs8spLcDJA90m8=
X-Proofpoint-GUID: Y7b-6wy7bbBotkWh3Z7RN4nZHNEG58eG
X-Proofpoint-ORIG-GUID: Y7b-6wy7bbBotkWh3Z7RN4nZHNEG58eG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXxM4DC29bjZO5
 CSbnUX2jFYymdVqt6sBtVhcYM6rmtkJ0UMCdsKKIzngMGU/4cozTTs+ZRZOlkj3u3x+CUD5UVXx
 Ou9EwpQgpnUcdpXr+QyL3a6dS5U0nPp7HvVuMTVmwZYvQy/Nqou0WxS2hycaBv9rwBwiGIHC5Oi
 7h71KCwld0HwfNT45enyFOJHMKF4d4PnmKZiwww2tVwxJgM9MYBO0r2n638NuFAJOR3bsFWd5Ss
 SwJqZFNt6DSIvfNLP6mg5VoWCnlqVVoJbPejmvYyz0mO/Jx7bFqo/N9ZzRQOn1GtJFhr68jQMH6
 /sihJVl8eDbMsyMDKtg09XBGY/Zhjm9jYY4DVuE5VtmanZWMX58Uu0O9LZ9UZH6tN8yE398LPxJ
 mqjIgC+qWnUPuEWghAorONjVwWgC9cs1EHPcpc40ZoAeBq5SYz7zT07mOkz1fQyAG9mkDnkhTKj
 /F1q6sqXJSnLsmA0RVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

Now we tagged and implemented TYPE_TARGET_SPECIFIC for all boards, we
can implement the new filtering mechanic. We update all locations
querying list of machines accordingly.

We make sure that all machines implementing TYPE_TARGET_SPECIFIC have
is_available overriden.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c     |  3 ++-
 include/qemu/target-info-qom.h |  7 +++++++
 monitor/qemu-config-qmp.c      |  4 ++--
 system/vl.c                    |  5 ++---
 target-info-qom.c              | 31 +++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e62cb4ec888..e6e6ecc31e3 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -21,6 +21,7 @@
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
@@ -98,7 +99,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
     GSList *el, *machines;
     MachineInfoList *mach_list = NULL;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = get_machine_types_available();
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 83eb537333b..9f175bed057 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -42,4 +42,11 @@ OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
 void target_info_qom_set_target(void);
 
+/**
+ * get_machine_types_available:
+ *
+ * Returns: Machine classes available for the selected target.
+ */
+GSList *get_machine_types_available(void);
+
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 29801023564..3b06aea734f 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #include "qemu/osdep.h"
-#include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qobject/qlist.h"
@@ -129,7 +129,7 @@ static CommandLineParameterInfoList *query_all_machine_properties(void)
     ObjectProperty *prop;
     bool is_new;
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = get_machine_types_available();
     assert(machines);
 
     /* Loop over all machine classes */
diff --git a/system/vl.c b/system/vl.c
index 061cbdf860b..83b9425de9b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1570,7 +1570,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(target_machine_typename(), false);
+    machines = get_machine_types_available();
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
@@ -1682,8 +1682,7 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
     ERRP_GUARD();
     const char *machine_type = qdict_get_try_str(qdict, "type");
-    g_autoptr(GSList) machines = object_class_get_list(target_machine_typename(),
-                                                       false);
+    g_autoptr(GSList) machines = get_machine_types_available();
     MachineClass *machine_class = NULL;
 
     if (machine_type) {
diff --git a/target-info-qom.c b/target-info-qom.c
index 1388691657c..67102c31a80 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -41,6 +41,37 @@ static const TypeInfo target_info_types[] = {
 
 DEFINE_TYPES(target_info_types)
 
+static GSList *filter_types_available(GSList *types)
+{
+    GSList **link = &types;
+
+    while (*link) {
+        ObjectClass *oc = (*link)->data;
+        TargetSpecificClass *tsc = (TargetSpecificClass *)
+            object_class_dynamic_cast(oc, TYPE_TARGET_SPECIFIC);
+
+        if (tsc && !tsc->is_available) {
+            error_setg(&error_fatal,
+                       "%s is target specific, but does not "
+                       "implement interface", object_class_get_name(oc));
+        }
+        if (tsc && !tsc->is_available()) {
+            *link = g_slist_delete_link(*link, *link);
+        } else {
+            link = &(*link)->next;
+        }
+    }
+
+    return types;
+}
+
+GSList *get_machine_types_available(void)
+{
+    GSList *machines = object_class_get_list_sorted(target_machine_typename(), false);
+
+    return filter_types_available(machines);
+}
+
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
     TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
-- 
2.43.0


