Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102CC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGM9-00024o-9z; Wed, 12 Aug 2026 17:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLf-0001Ka-89
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLc-0007qB-Ps
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2N3p245892
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uq1aVaFQbnVSJ9aDVRI9epnWVGLRe5HWP3zqUmbSIy4=; b=EklcCRhOtJXvb9Ee
 23/ySgjB6ZUiRkWr8TQWLhzTj9Ilk15QqAnD6YqAx5RWAVh2HVefVFjB+8hrnzd6
 iNkLJbHE6ul409apeMcMK77G+cigQOBPzGWWO+vleWxLPPp3hZOiOiG9KwlyF81O
 UIgjMl/mAUVnFtqQyVS9IjkWoaVnKXk8Jykz7kOeIQJh3Yhn92SRRJZBT2JlXzg3
 qSiiUT0FLsKckCpdraRCOc2Uv7vAG0T49SMb9x0ZWKEdkAN2DnuniB9lnSrnGO46
 HZ8x1WtLgeV9zkk3l69Q5eVPKucaQ60xGHLusbzcE6QULR0TroDvQmutQ+mMQnZE
 8PxSPA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts1er2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:18:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso13620171cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569530; x=1787174330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uq1aVaFQbnVSJ9aDVRI9epnWVGLRe5HWP3zqUmbSIy4=;
 b=FYjvDHTW0P2f5iERCVUlOr2kHhGqojMyaR5oOFIeiPRayKjmtVIeWWVNUdCPtZWZTk
 xoHys5BTDlLY1WHFM24Iyu+Eh3rW5QChk4ZWDaw39mW2ffosNjbgAknW8VsjI7rQvT69
 +r2wm0VDDmlCY60oK7AixJhWEsxmTfXiFR5vw1M6siWhgr5KMtKHobeefI5E/qJY3E9X
 g3lePCdp0dY0EqORDUDyVI+TbM3vwmKelBPIWvpPcNAO6uQaS4VV5quxOIYioDraN0MK
 VK75nJMrhmH6/Dp0V5rpstXKcqBilYwmxepY+QNFHZ+y0Y8SR9zbRQqzEFrKZ2sQiCoM
 mYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569530; x=1787174330;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uq1aVaFQbnVSJ9aDVRI9epnWVGLRe5HWP3zqUmbSIy4=;
 b=PotnQy+pEdXltAqV7n70f6UYfVoiGwbQk4sp8q0TlZA42s/IMUux+o9kn0wqZYRDsT
 Di2uPv/0EY9xxjx95Kge5im4DcBkAooRQqljL2NrzLTQ43rAETzDqNPb3Gv6hnsTIRCX
 blT1NXbT4wt2C7X91Jw/CzZ2watMocTeN+VcBXYajW4wPZLWQ0bWJAqzv1z70KSljL+n
 YbSOP8LPvi/pLEFljVRnBXcjvP5VCP1b/khjmLsim7Kd1Zp7b70txEH8LnXjopCGO/OG
 SNPU0fby/ZT4hisWahruOzrH4qalEVN/KgRKSWsIC+tWogMWGirQQ7vwwFCt9awHFDAK
 klMQ==
X-Gm-Message-State: AOJu0YxlJMWyXe44QWBYEbH44vIf78xDaQnC73X6CR3deJvCsEYKEmq4
 WrGfrbX7NIWeZ3661HhHc9fC0IvCmWu4vaCYtelVRYfG4W+swqyp+9w2WsCu6YOJqNe3uflx2tt
 Aj7h4AvyyYDBN5xTFcCSmEoyjEO5Cwa+dm+UPeJJB0KlLFpukizqONTFD+jzNuhT4tg==
X-Gm-Gg: AR+sD13G0WtwLiC4f6CILSI5J7kyNZJc/M8A1NBPcOUZqYt+3wts16KSBbI+jmcT42E
 PP0b82q0xPtAIIFhvVt2lHQ/qa6j2t+ye/+gzjvmJAgqgeuKJ9EECcBEEs/Azt4gaGoTYd/Diws
 1YlaDN/hJzM06W6H6qnbEECNTG2PJOvWK0Rny7UAQo25JNkYWorS9Q95DbsBSuYY/zZxDydEc4r
 xYqzPRzeIcQdADi8bYR9LRIzmh+iVjVNJPrtdsqi3DalaphOFd4ednU/BJjuqzUZheEotDVSAFe
 5Mqzo4PbhBZhtHcf3Pa1y3kGbpykfMvWBNxjz7n7HWOljjlTzfvoNHY7IbWytCvkyhg3eNGgmiT
 ymu4gIPiE5ZsRQmjhhTpAIImtNJ16yXaAVWb1cHzmeg==
X-Received: by 2002:a05:622a:4d0b:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-52d73d151a2mr11480091cf.25.1786569530093; 
 Wed, 12 Aug 2026 14:18:50 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0b:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-52d73d151a2mr11479561cf.25.1786569529654; 
 Wed, 12 Aug 2026 14:18:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499820c2897sm15013935e9.0.2026.08.12.14.18.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:18:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Subject: [PATCH v3 13/23] system/dirtylimit: Extract HMP code to
 dirtylimit-hmp-cmds.c
Date: Wed, 12 Aug 2026 23:16:57 +0200
Message-ID: <20260812211708.92824-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GFQwnQKM0jaJ5XMOkAMyQndNFMHK7Ni6
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7ce33b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=zCLxbh44AAAA:8 a=WRxKY6twSJXuwc0U0koA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=tlNt8cdNSqtyJh_VpUlY:22
X-Proofpoint-ORIG-GUID: GFQwnQKM0jaJ5XMOkAMyQndNFMHK7Ni6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX0wnjoQ3Z47D6
 SlSCq1dTME5jiQwMSxjCG7IP8VbApvOeWAgQnWdpyXaZmC8CbHHpkqxP+1apOwpkL8BoNDa4biy
 urznCyl+k8SQT4aoLFRACDuVxeYc3Ss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX6JPHsQNjzE+K
 KG1HznFjJqFn5bODKn+02GoqbCu6g8c116DvJv7NlrMw5gl/GxbfHqOVc7+L7J2vlcx7HofEeun
 5XMxtSYz4EfzfPfWKDi5JoONNGkKZvqWMNu6rOOvT02O3qUHcCZM6Ntfq5ubSF7wOnrlFBw/QrC
 S8H3tHqG7UkxloNTPGBL/ESfbd0xCE8LBBq6uBYD5OF2HXUcil5J4Vb5v/bt0B80RET02f8/jQM
 s2e9xGTwSJFQGYtuskV5D/Koa+TmYgMilfnNXV4plEsNiywqriX6AlWyqE534kXnWh+yF+nHToA
 oNpS4QUOBq+6cNQNeIgq4o0/Z7uK3YKgmZhZkK7ptTkgHSHe77NHBH37qChvaiLeqXn6Z04MlMY
 edsKakRG/g9HIxpFO7+rLf+D+Vk0iAwNgdUk8EkpTOUh8ArjOIZ6sYSQyV4MPe/T6X3VcWCwl0+
 5BtO0QxaWfdZ/9Okavw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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
---
 MAINTAINERS                  |  1 +
 system/dirtylimit-hmp-cmds.c | 74 ++++++++++++++++++++++++++++++++++++
 system/dirtylimit.c          | 60 -----------------------------
 system/meson.build           |  1 +
 4 files changed, 76 insertions(+), 60 deletions(-)
 create mode 100644 system/dirtylimit-hmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4628793dde6..a33fbeebf61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3858,6 +3858,7 @@ Migration dirty limit and dirty page rate
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


