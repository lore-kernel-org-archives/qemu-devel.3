Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D867C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8qE-0000Sh-HC; Wed, 12 Aug 2026 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8ls-00041W-N7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8lq-0006pk-Gy
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4B623265902
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=; b=dsqFDOpRaAVnI0iE
 Pk/0nBiR6q+srCzy7mfuhOdemj0GGOaJXPwkF0kJv0LbFL6KEFTsNJw92vDG5z30
 CvIZmlAvBxB0QfiCy52HdAmo01mEVNJHgoNoZyd+5Phtk4n8fx/H+63z/3cxj60v
 GgVDL+b2u/wUrgSMQ2DHngZLGvQbXRdqD8EStWAWsjySALXlheMvGbuHZh92jPIY
 t3WQ8qZFWWwUid2iJTvuWgKCKFgnENxC6Njx/2oAFIqWJyzH+9eK5Rg5uFXA8y3r
 he1QkjfDtnK2j/cY39Ki2K+a/BW2tfRcFOlRhtGqPjc9qtRt4445bAZwg5pLp7Q5
 NSaP4w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrkxxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283fa0656dso26673091cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540403; x=1787145203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=;
 b=EizAhptWV9oO5rLbhdFOhHy87dI0kaJ7NFeMTBa3XGSPcrYccFLajzsbwLD1Ky70ef
 nvdFrduo3gxO4AsFhFOi3U8GmMR651wIZwnKNUuDh8RGxyUqWIqE8PkmcpwB2QnyjVja
 4vsatMo0CwKwVFx86MIZjlUe+m7cl5TwPoZdFdkwsOrLqKuXxffQM+N9S6342AZ4XZPG
 MPaJcljpjGpsiYyGRYbWVjLC1alBFki3vXm151rirC0kckTuvbjRfPcAMng89F/6ppo9
 wY+5eQfXE9yn2wP/r6c7EKYGqkHj87+YcfVJiohZZuiVYGoF+RpQvxkA9KwN4qAejtEl
 Gdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540403; x=1787145203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=;
 b=X50DZe7C28398Woy9JoHuv1tdYhwZlf9xWu7Q2/700LL5bzlWKfkhOcvKZbQI4zc3n
 SXqPCg0Df0nt6HP5h/H5eRUg/gPowL5uhFN7MbSjx0MlkKNcpf4XgRHMELrdQwJpptLb
 AXihfqCoLLGIvqBmThAMxD5SBKJFm9AxH/3CXUFTj6aVhcUK5APx9mrLkYRT62BZQzoT
 LB1NzYcjwsSnQvYGAz8iwZHb0KWx2KCCAmMgR82Ejw0bBo7C8jO847PhSvJXW8e/6nkh
 G1XSsFojhIHp1Th1QujhF7QfZLoZ+2QzE29bP0+AIQnvdTttl+RJJzu1fBjGYnHQWuIC
 SudQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0tbk41vn4pag6H5Jz1UTvUgXjoNqg4S7ttyReB4KquwwKnMzujxhrIAMv3gB2wHm/PVfF3VtAUsaP@nongnu.org
X-Gm-Message-State: AOJu0YzXTSpx1wI4kJ74AUUbv1VVqfiNgJJLByOpr8etBDKAZBfTrLep
 TX3b0AsfVl8cCuYaiC27BYRCdfuqO5ZsHr+4WQqOEMtaB2ffeldejpsI59gOOiBQ2Rnp85AsVDg
 Nv9ZSmaKE+ivfLyY2CxP4EJLv2ZahgENox7K4lQjIeZfXXBIjD3iEHr7B2Q==
X-Gm-Gg: AR+sD10ToIPVFZTr38ZJagHyOJ5UGE2paEvtsvF65Uux58FxjY0AUC1deOr3IhbnIa6
 R1ppPmtkD5Ap3AnN47MWICUGCbOzkFCqp9I4uCDuQsMgJUi6tNPiVNh5hE7MF2whDzNklA1NOkZ
 r2DHBSz5HKNe7m4YuCs/pSAGSRAQiw75xmWs4VgOtjP5gUUhAhiENQAEh8JfnDfgXWEGL+jRA36
 ZHz01yl+DkeoL3z7cUuyPceVZNugtFAOsPnEslHBfodLTm8m3m3gpj7+nN3jZMj/iYsIa63dCrH
 K0T8ayDvsuIJRmz++Iy17avjDM/Rdb6P8eRhCyx9REBIp6WTN1gQJtxw3o8zXdtZNu+UHFyCtXT
 1/jW1Ocgp24ywp86VzJjzqJeszKlRhP6ACPPK1P+kZg==
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67842591cf.21.1786540403092; 
 Wed, 12 Aug 2026 06:13:23 -0700 (PDT)
X-Received: by 2002:a05:622a:48a:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d60365125mr67842081cf.21.1786540402670; 
 Wed, 12 Aug 2026 06:13:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e29bsm7059485f8f.24.2026.08.12.06.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PATCH v2 13/16] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
Date: Wed, 12 Aug 2026 15:11:44 +0200
Message-ID: <20260812131147.83188-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gDDD-drcFKNNejXQyFpHzNYLR9HRFpQ4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxhw7Ej8wodOZ
 OKyFXupGAAzajhvIgM1kffHZmEh5aeHZYsIChM7xCRE7iLReWF1BmFwpTZp2L+6QJvFqt4NB4XW
 FyCnf5lVO+2vYA9FvbyccqAhIcBQN/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX4EvQNgztTGrh
 HdnMemzHdxofeLLttZgo/SlueV/U+sUnQD2ZOUym67YB2muSN7tJeRT4ZJfruCyOHDrT+4VoPfx
 L9WUJp8iGxt/zyRigosga92wXNEpJ2t/YEIta5oAXu1LICg0lXBw0D6Oi4GOo1glE2+7QlRz5Jo
 rao0xiMOPWMxwRqyT47Fgj3QyGB8+yQoJ3a2SaUS08oI5d3wAncaebxCRH3VxgJ0lD28+6M6gTF
 TaiGMKsBYrhSxniAe/hgss/nStSdlwP0d+WFn0UPBEEuFuKakSMeJOEZXuzin/GTaOMLr3fu2Bm
 ozuz+0U8p7F0uVIMw1YY4O4P3jF8DPmuNfVeMYf4JEknnJSmO1alEy+5aCX/OWJ86X9jC4Q2ZVA
 pXeWOcPHRywumtSY6omOrgitFIhGhBVu4lRL4WmdyqbP7gTn2d8UT+DwKcrId0xQDWKe+d/RPfn
 zaOeRb8WR6YY6pN8vYA==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c7174 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=O7a0paeZM6m8OBaPhdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gDDD-drcFKNNejXQyFpHzNYLR9HRFpQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/dirtylimit-hmp-cmds.c | 74 ++++++++++++++++++++++++++++++++++++
 system/dirtylimit.c          | 60 -----------------------------
 system/meson.build           |  1 +
 3 files changed, 75 insertions(+), 60 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c

diff --git a/system/dirtylimit-hmp-cmds.c b/system/dirtylimit-hmp-cmds.c
new file mode 100644
index 00000000000..4928d57cc8e
--- /dev/null
+++ b/system/dirtylimit-hmp-cmds.c
@@ -0,0 +1,74 @@
+/*
+ * HMP commands related to migration dirty page rate limit
+ *
+ * Copyright (c) 2022 CHINA TELECOM CO.,LTD.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qobject/qdict.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "system/dirtylimit.h"
+
+void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+{
+    int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
+    Error *err = NULL;
+
+    qmp_cancel_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, &err);
+    if (err) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
+                   "dirty limit for virtual CPU]\n");
+}
+
+void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+{
+    int64_t dirty_rate = qdict_get_int(qdict, "dirty_rate");
+    int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
+    Error *err = NULL;
+
+    if (dirty_rate < 0) {
+        error_setg(&err, "invalid dirty page limit %" PRId64, dirty_rate);
+        goto out;
+    }
+
+    qmp_set_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, dirty_rate, &err);
+
+out:
+    hmp_handle_error(mon, err);
+}
+
+void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+{
+    DirtyLimitInfoList *info;
+    g_autoptr(DirtyLimitInfoList) head = NULL;
+    Error *err = NULL;
+
+    if (!dirtylimit_in_service()) {
+        monitor_printf(mon, "Dirty page limit not enabled!\n");
+        return;
+    }
+
+    head = qmp_query_vcpu_dirty_limit(&err);
+    if (err) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    for (info = head; info != NULL; info = info->next) {
+        monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
+                            " current rate %"PRIi64 " (MB/s)\n",
+                            info->value->cpu_index,
+                            info->value->limit_rate,
+                            info->value->current_rate);
+    }
+}
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 50fa67f3d6a..70bb7bac2d0 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -17,8 +17,6 @@
 #include "qapi/error.h"
 #include "system/dirtyrate.h"
 #include "system/dirtylimit.h"
-#include "monitor/hmp.h"
-#include "monitor/monitor.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
 #include "hw/core/boards.h"
@@ -491,21 +489,6 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
     dirtylimit_state_unlock();
 }
 
-void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
-{
-    int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
-    Error *err = NULL;
-
-    qmp_cancel_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, &err);
-    if (err) {
-        hmp_handle_error(mon, err);
-        return;
-    }
-
-    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
-                   "dirty limit for virtual CPU]\n");
-}
-
 void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
                               int64_t cpu_index,
                               uint64_t dirty_rate,
@@ -548,23 +531,6 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
     dirtylimit_state_unlock();
 }
 
-void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
-{
-    int64_t dirty_rate = qdict_get_int(qdict, "dirty_rate");
-    int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
-    Error *err = NULL;
-
-    if (dirty_rate < 0) {
-        error_setg(&err, "invalid dirty page limit %" PRId64, dirty_rate);
-        goto out;
-    }
-
-    qmp_set_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, dirty_rate, &err);
-
-out:
-    hmp_handle_error(mon, err);
-}
-
 /* Return the max throttle time of each virtual CPU */
 uint64_t dirtylimit_throttle_time_per_round(void)
 {
@@ -646,29 +612,3 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(Error **errp)
 {
     return dirtylimit_query_all();
 }
-
-void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
-{
-    DirtyLimitInfoList *info;
-    g_autoptr(DirtyLimitInfoList) head = NULL;
-    Error *err = NULL;
-
-    if (!dirtylimit_in_service()) {
-        monitor_printf(mon, "Dirty page limit not enabled!\n");
-        return;
-    }
-
-    head = qmp_query_vcpu_dirty_limit(&err);
-    if (err) {
-        hmp_handle_error(mon, err);
-        return;
-    }
-
-    for (info = head; info != NULL; info = info->next) {
-        monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
-                            " current rate %"PRIi64 " (MB/s)\n",
-                            info->value->cpu_index,
-                            info->value->limit_rate,
-                            info->value->current_rate);
-    }
-}
diff --git a/system/meson.build b/system/meson.build
index cd3193d170b..377adce8035 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -9,6 +9,7 @@ system_ss.add(files(
   'cpus.c',
   'cpu-timers.c',
   'dirtylimit.c',
+  'dirtylimit-hmp-cmds.c',
   'dma-helpers.c',
   'exit-with-parent.c',
   'globals.c',
-- 
2.53.0


