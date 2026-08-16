Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E486AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEG-0001Rx-S2; Sun, 16 Aug 2026 10:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEF-0001IA-0n
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcED-00022U-3G
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlFg33161996
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SL8Lt4C14/DK3lNJomReeRhLYyBT4iIQEopvxRGlAEM=; b=OaQZj39Sj5R1BcJX
 hV8pZf53PKTKOp0vuyl0Q5hdlNRCqKugCNvFDz4/AnsKe/Kuu2Tm9FpgbfIo5ib2
 BzsFs9N45hXXLX7CxOp2bB1FvFB0VfWHII5VC/gFBWPAXyurFrf1lipzr6rxpg2t
 SxukDphi/sCbx6heQJYdjfWhEThnja3QVf+StLi95wfZAPMSTtCGjJOhGzrb+B/J
 n0nAbIKX5VMKb9//Mh3Rpn9f1DJ/8hWTyfU+Mql461HnXzMQKCEnPZc76mUl4oXW
 wkgn9NASM/Uh0vPkYYFsoYUnzCPZgimyK+OLRWi6Zm9bsmHEfM+YPFjavK+KVaXz
 h9taqA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7ugbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90a91f4c6f1so16361026d6.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891966; x=1787496766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SL8Lt4C14/DK3lNJomReeRhLYyBT4iIQEopvxRGlAEM=;
 b=Ygq3ZhmABtfyDr5TankuJOSX2v0rGef1S+6KeUnpc+5YbRvJzo1WUQ23ayuWHNPPkh
 s8/XpLZFgZMhuScTbEg6LVWXDNlLeWk61LljctIdwuzL+BMoUc+Gy3leHhkc0O/emtSz
 eR4UzzA6Nqmbj/DlMtGcsKd0BRwhucC82REn6O60v5DOJJ2aQQ7Oupvd01M+QSNFGGPW
 R5ySs587sSHM9dcUXZiUk/acbhPLciw93Z5WkqH5b6I0UVXCpLy+tuH01hpm5aIh3xEd
 uuGPZvX7KsGLsfZ/4R8J0BG+KHS/GpUk465C1oJZemAOO8ioc9Uaoz5Ef332OXufprVT
 J+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891966; x=1787496766;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SL8Lt4C14/DK3lNJomReeRhLYyBT4iIQEopvxRGlAEM=;
 b=b23p8ePtieZl1abilbaVY57QsvkZC2niwc1TcWmijfCiZQ3f2qKrg7CIdOYWn5woyf
 Kfj0NsPZxMaLV97pKHsKzfsuTbSp7aY1d6hOEZQBiE9eU7/Ef0yYJDZZFpfPzmd6KFS5
 w/2dhhbdShQU7pUpHGetjKdEfa6a0JXkQfHZTad0I30V780RqNkFP4bJgCMzd3xfh+mX
 2AyO32GMh57aFt6RhAspdFqA3rIKXwfrUwUQf3q2Yt5LOgDhxq3ULXzhfAVCgq7HUtmA
 72SBxaZ4BT+F1jPBmfoGfNGjx/mX9BAEej1Vvp04x98Je9ip4yxIRDRIP0Pbvo0/f4Lf
 P+dg==
X-Gm-Message-State: AOJu0Yz4ah7iDFhuFXwICTW4EFrdpBcCYtRJnUX+VZQHay1qUlPBYSy2
 PKC9DJSAihNWHlHN5NBcWcghXu+9cjAaGSwF00nU7QGKXNV2V7zneXcuJkkWaCLDcVurx8nIBGJ
 3Ojthsss6mqNFIsBtaqHxEQJXrwPgOgOe17FWSIrjoo5eektAaD6HjhipbyQAQqHBtg==
X-Gm-Gg: AR+sD10BbiI7cE0tP/2B3Id7n+6UG2RZfqa8s7m8YHBl3nvy9P1JtZE3n0EchDfJxfw
 Y3O8KxIm2PgtxO/sLOW9dYGQ0/oqiiUbxO48DYd4pgRVTfMWe4b0W++vUaNrpxB1vYN7SX8amRC
 fZDp2F3XIraSmYoPWk///gu9LyEo5MkuLVf8Wx3QnGIlIrap8QgLntMNqE3xlVZPb5cHuVMYKrB
 99EFhYiyQsxNp1pEVedsAVLkZTrvuy6bFpmjcs1TB+qB5g8mANDA/jB5IaPXO0y6aOLvBKBZ02T
 3GmlfKqAfH11QFAP7StGd+9wc3CSpU2hjcQzgyCZWdWwjTRlydQtqyG9d4nIdHL0k8veyE+Lzv4
 qW6b4jb/lU9C0z545p87FVX+JlyhXhcB/o/yUlKKsow==
X-Received: by 2002:a05:622a:e60f:20b0:52d:8596:a92d with SMTP id
 d75a77b69052e-52d8596aaacmr127021181cf.2.1786891966339; 
 Sun, 16 Aug 2026 07:52:46 -0700 (PDT)
X-Received: by 2002:a05:622a:e60f:20b0:52d:8596:a92d with SMTP id
 d75a77b69052e-52d8596aaacmr127021011cf.2.1786891965826; 
 Sun, 16 Aug 2026 07:52:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2005b0sm26436719f8f.8.2026.08.16.07.52.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/56] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
Date: Sun, 16 Aug 2026 16:45:47 +0200
Message-ID: <20260816144556.69009-49-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXwsz7eFx9elQy
 uXQRoA/Y16pUlDpM8M0e3GLj1IrFnxoIs3R2b3dl8G/XIvmeomH9pd4OD+PxHnf65dG/EurqqcL
 0tGLmQGdhq5q209QtsEZBgq5Szwoz8Nm3iWWNDRpELRLAIB/3zAn3gdqc2zZ0qJwltk9cTQxcXV
 4StB3LYMN9VgCnKQV/ZmI/hs2+KGuMucBd7q2+EqCHALG6u6qKn8cX23+IdUEvYuN/LpBO9RXTA
 oh+wYAsxdjivYsjlkvHtq3VMhvKSGZVIOVlVU7fZeCoYzBojj2B+xJrYgVx86c/Q+bWR6338ZzB
 FPnQgsAsRafyAtNdP69LzCmb+hdTuuh8s0bCa2zGuGgFVAsGgMto/Mew/XrWonnUOkou+etrNat
 884+zZ8IbyKvjm1NDfh6ZFybQ+52PQrUA+yYFNM8Wbq3nq9AbDOVATeJbxiv0gySZ/Drn0rJq+N
 PSnqtYlFinYIeoyyR0Q==
X-Proofpoint-GUID: dqdrykshFN9QdL7ITL7KfMO0NQ8pzb53
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a81cebf cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=zCLxbh44AAAA:8 a=WRxKY6twSJXuwc0U0koA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=tlNt8cdNSqtyJh_VpUlY:22
X-Proofpoint-ORIG-GUID: dqdrykshFN9QdL7ITL7KfMO0NQ8pzb53
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX6EIVVBOS+Lzc
 dahrs6AazYx2DtFv4BCH34WudIlZ7cEjroNb5MeLFk1dGCcM3X23PmAJUjiswzCsK32KfZt9Tjo
 A3ONi0HubSsjGZG1vkvV9fVtmqBFQG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Hyman Huang <yong.huang@bitdeer.com>
Message-Id: <20260812211708.92824-14-philmd@oss.qualcomm.com>
---
 MAINTAINERS                  |  1 +
 system/dirtylimit-hmp-cmds.c | 74 ++++++++++++++++++++++++++++++++++++
 system/dirtylimit.c          | 60 -----------------------------
 system/meson.build           |  1 +
 4 files changed, 76 insertions(+), 60 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c296dd5abfd..bad65aeda50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3875,6 +3875,7 @@ Migration dirty limit and dirty page rate
 M: Hyman Huang <infra.ai.cloud@bitdeer.com>
 S: Maintained
 F: system/dirtylimit.c
+F: system/dirtylimit-hmp-cmds.c
 F: include/system/dirtylimit.h
 F: migration/dirtyrate.c
 F: migration/dirtyrate.h
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


