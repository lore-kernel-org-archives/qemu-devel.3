Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CC4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu81L-0001FU-9G; Wed, 12 Aug 2026 08:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu81J-00011s-2H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu81F-00029V-JR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:25:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4Ad03319967
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=; b=EajcjJXWigcc5OC5
 +x4UQl+bb7xHIiygA57aJSMhOBnRI1qUJjxAGTQhGV6nmJt6D6mEW+W6dnrRoYF5
 YvCsSqZT2J+H3E0MwENiAyf1c51O1ItSTWjX9mDoFFWlqp1LT4uFUZKfQT0/5kpG
 oCkBsMZJGPrmm2gwxnKy7yYuIUtnxn5wT2r3OoqAosMeamLR6McuC78XRM132ILj
 zo9UK+X5h++fJ1obEExCV9eGjCjCmmV8pNqfE2+k6jJc+JZ6/NqtCRwTaJ5de1xb
 Ww8h9/ODQiabQbWUxKY9G4C5RRgYbtP4iHXvN7LOePgmnTBQLhObNEJj25lgOql3
 rwv2kg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrgsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:25:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a23afcbso12369951cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537515; x=1787142315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=;
 b=i6HGS2TGc+DoxohBz8VHY+7VonfKB3lTuTROaBA9GidfkCWafZREqUJWNPt8ylTVM3
 EiVxB20lfPZDdXn3vSOxfdXOvpyTJoJBbgCCmxeUPnklnLZ+7yesy9f/E28hXxxhcGlz
 B7F0moBFzCGytV2o4D2UBj1CjE2R+W35b9jkPLTDdFdK8SSSAA0upD6Is+1CZHTxTBFx
 HDsOzFqEhzEoxYOX6nTMLJ2HyOsuHhKM5MGymCYenGQsh2Ejyh1vs5pcegb6SVoSvCfO
 EIpI48xoIsicAGbtn4zqYGnx0osU6oW4pRUoZhZxOSrbtj9wFtm0fEaT/xC8oL0zs6/0
 VTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537515; x=1787142315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTsdtC7baAuSEzhZYry+TRKvtm+XXIUHPe/4MsSmoVU=;
 b=gO44MSje3pasDTAq3bzOpBtxEeJJfMPBxntMO7cNpCmOzfGV/6PEOYngVeEPUbE7oe
 tBRRaMNv0zIFvxo9bU9uHHp2lSE/NQpyGwcugW8i+49OKmDTX4YFAW6qaGhZCUPRuBjx
 l23KbyeTn8/DX+TvQlCHaO2yIXrxwC+AeuUWUqmghb5/jg+mX0ONj538xGFMPY1wdYFs
 Wi3eSPON/UanqEb3CAlk9D4P4OtS7cOEgMeGriG9Jy15TXy/lBl0LawT/DY5tE3/p5s+
 /JTnbGx2mzTLg5LvIoV0JR/httn9X1J8R1N0QONHS/ZCT2qNOfJDzW9aR/WDU65C16Qs
 rU+Q==
X-Gm-Message-State: AOJu0YxMjj4gR5SQ+2ySXBaIEFrQjjU3KEc39F2/G6vgjegLjuTITNyM
 9XMMtHnVUDxD659Lscu8qPXfTA2BJEsaGbi+OHxNXMnNOe7YlB4JLG3elTvDDncRWdCTrSj9VFc
 hqtYRH6C/eiMa6lpV8Y16bTPdEjkqAghJtOl76itf36xIR8NUNwrwVwKWe1cZ1cuf/A==
X-Gm-Gg: AR+sD12TXG7KMrSPSWU7+itReEnnTazxi8kKGPDQUFt+mfjlPgRz3jb4pQ0uKsESjMS
 i4tJDaNjWZH4cElOvmGezx/eyG8s0pDHX6EmzziM7ejhRcPUcnBj+SJsAo6pJpuDGAHLMH0GjgC
 cc0hq4sdA97kvHg6k9cjzkTYKp0B2OA2q6NO8vy85yVjodhyZVISq7sqmyWnLd/urH9c4AYlmFB
 McGgG4e19FqJjEUzUHxPsN5IKx+sSAktpXvInFyVLLmJzEDcJM0BReUdd9Psc/AyPlUjQx5sMYU
 qpg8C6sU9GWtD/y2L+0R/D10yapnrPHqq+9MqlWkD8aR14lxA3Jxn3Yfyo2aykjpS45rVxf3jEM
 xSO0AGtBDCZJiQMIQywekdecrzk69vLcDe6rSNAGT1A==
X-Received: by 2002:a05:622a:4816:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d64817b7amr36770881cf.37.1786537515046; 
 Wed, 12 Aug 2026 05:25:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4816:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d64817b7amr36770351cf.37.1786537514490; 
 Wed, 12 Aug 2026 05:25:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d702c9sm7148915f8f.34.2026.08.12.05.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:25:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PATCH 14/14] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
Date: Wed, 12 Aug 2026 14:23:31 +0200
Message-ID: <20260812122332.72975-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX5mxkbuWLEGbe
 HJLsGrYB6MBtwp5lpZ0enJYGkMqCZSH3F5JCpfuurKRTnq34PYr1AN2zQXtpJZ2eeOw6ECvc0ZB
 xPRxC5k9ioYVEO8LgnjWd4NeUvK1Wq8=
X-Proofpoint-ORIG-GUID: ZNHUrgnN8pGEh1NuLeX8dy2d5Lzj4CD9
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c662c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=O7a0paeZM6m8OBaPhdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: ZNHUrgnN8pGEh1NuLeX8dy2d5Lzj4CD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX7BfeA6jLb0R0
 e0+TchPh6AOFzOEK++dIoUocVJmbhkmK30B7RmiMuKZdJ63+fF9CLiaXglpizPSAErVbdbXoGif
 8MvKVlG3q1D7QqnpgxW1nY1hG4/rdSQa49n6tFFGTivnFSpwdHOTUUozIgRF17TPfPIZvE2TKVX
 MPK3jJWwX+oRrmjDVMv5sfvDKhXHMX26oaPAamToikymFEiqqnqNSoRn/JxfKNBvyCUoa3RA6GZ
 B1iz0HMs1b/yAnZMQb4rvNv1FfqCAhQaGcel9r9owSgC0GRVPGEpQFXyu2N+NeH+d+d0H1e27Ep
 HE35QAOjkPsqNudUcGIjU40TqTE+EbqVwLxbIiOU92WPDVt8/bXkdyaylWFraeGLO6mBJISCBpe
 74jlpAEZYHDp1vzbNw0v1hIWCXzBFJdcITGNyylqoP4TueKyziNtB4y4mzsg0b7iBELkVk0lLvl
 yNG3mQYpc663d4Obvkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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


