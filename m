Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BC8C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMO-0002WM-4I; Wed, 12 Aug 2026 17:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMA-0002Ew-1d
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGM6-0007tY-UH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2QUM1165252
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +BCKk2lGMbJUaVoi4AJMm9GxmkkQjGgn2BvCt1jmRkA=; b=bgYvGoJq49ckn2fN
 I6ykKST8ueu1IeT/mjMCdU81L9tCzhEu5zzVe6aHp+62w/2jaIshnLJ065cZwOSQ
 p+Xn0Wv/IJdWtTOM7mdmoEeNXUv2oRELUAWzBPWrntzOLI2rxA+naPR07bacajhh
 +QV8r00h63c+GFx2vSvbI520nQBOtFAgZYfoEfRHg3B0wow9Gk0d+IHAAnYtqrzu
 aTeo6QjPqqiR7f3HaRXQFkyR8R9ExOE/Mm9NJhtwdLYLY+O3jWgATYW4dIwC3Gjy
 FJkqhhoTfAePaPe88HLN/odaL8eeH5+6A6RU+RScTRtmvRekGinfq5Tfq0ai9mRW
 U94ASw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk427ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so13636361cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569560; x=1787174360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+BCKk2lGMbJUaVoi4AJMm9GxmkkQjGgn2BvCt1jmRkA=;
 b=NAyMaKxeQRDkp3zpToayl1gYs8tSHpgWOjA5zxce6aOrPHkrjKdlOb16kD3E1Snlk8
 jA4p6R8+XhsWXM8itMu3tNQpTXCnb1VvvJmElP8+SezxNWWGjCDdiBP/ejXLzv0j5mdf
 ooCrWEEdr8ONRmXwegNIQWLrN2P1ZEHKn7pbIUt/aH92u6LHkjV2LADYBmHDblPEeD59
 F3jThRU56WDQmULz3luAgfayLv9id+Gr8KLUKBSPqGCFTTKwlFKJ7ajl8K+IdyGrf0QV
 dNqS0I2S/x6T0N8DNOxjrCqnFKjaUH9AO+yZC5fTFZFwDWiLr5pVvWNZM+SppnR7fcdk
 Y9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569560; x=1787174360;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+BCKk2lGMbJUaVoi4AJMm9GxmkkQjGgn2BvCt1jmRkA=;
 b=N4GW3S2ZXCBNuUgM2zT90gyUOfk5C+42QsEfzA3tyWufEaJ4nfS5DS3G9JRvn7cwVy
 K31RhQTvYMVJdA634p5gKRpSJ6uAPC2b+Y/YmAAm95IsewX4vR3kSykhxGIC7puAlB0b
 SJlakQ7Nz29+WgTu5iCR/WQ8DgnhDNITD3iKu3WuE4TawqzdvHRgqgFrldiFJv0c+lU0
 TVz8ff6jB/mTWnOuZCLwrI7eIFl7+p8B6f/DVbU9cN1z/xSCEdn8RwVIYWPTTQ6zyiED
 FyQNGrHud+WvOzm5rWNq/ctEATukflhXbQ8onO8kJGZiq+zLpTEJvgMYqOXjDDY3RZZO
 2pGQ==
X-Gm-Message-State: AOJu0Yx+e7R3OqFk9pRetV0kSguiGHG76O5EwtsVluV9mhwphAcwAH8r
 WbCor4EztzZRqm0HSfCh4pPbfMxBQT5dGrYd469mgIKCActzGQoG+x7f0WzspMG+DppUnBbVAvD
 awMUwO++PO7XgPkgKUGTcNNicHkaUnVMWBo5iTX5FeulRX6rbtmXzqaoCG+TI/LbARg==
X-Gm-Gg: AR+sD10pJlg9WzefB5ah04UVj+96Hwl+YsqOIrQTwMDwj/EIyOTujt+lZukah1fgzIF
 k057g8L8xy7BRf1AM0pXBMM5CeC22gnETKxkUm1t0U0YILyB+jsg8xRqpDYYG/PlcokMaLrS/3Q
 zqH84+RDJ/Zy3wZyIzkvpNtDzNDYOhkrO4BcGLKV8ml3htfLJ11U1Ew6B6wMWROh1wgCvm4pKKa
 r1HC8/3FNjZMzhmkoLZRO/NJZz0NclmHZ/Fxqc41Jfrygthw+AKP8CsOdueWVpokixerk4yCu+6
 qiGy4wiB6hayo8Xnza1oG3Ij93uT6J63uX4lZJtjs2UCE7hXkJZwt9MGdqmpy8GNP7EV+OufUB4
 3Af1RZsouOsI4B9PsqUZIKiG0ZzcPdxtxXH6pMOxWdw==
X-Received: by 2002:a05:622a:2294:b0:517:8a18:7624 with SMTP id
 d75a77b69052e-52d73be13a6mr13991741cf.3.1786569559799; 
 Wed, 12 Aug 2026 14:19:19 -0700 (PDT)
X-Received: by 2002:a05:622a:2294:b0:517:8a18:7624 with SMTP id
 d75a77b69052e-52d73be13a6mr13990951cf.3.1786569559090; 
 Wed, 12 Aug 2026 14:19:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2837sm637097f8f.37.2026.08.12.14.19.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
Date: Wed, 12 Aug 2026 23:17:01 +0200
Message-ID: <20260812211708.92824-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i50CADaw_gfsZBweIMP1vao5vTuSph7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX19Z6NYQ6TESi
 Osqb6mJcagZs3R2xX/swaTbgxiGf6vck30YxyqbhcxzAV3bKWBIjUWU2DJb+w84IyiSLQMz/Czj
 thlKa/sKU4t5TpeZtWTk6oRj2h9VlwgpyH1xg49BI8VTFVmichjHaIkm+hn6S9uWTBpZhC2c2Zr
 Jr9+mHp8EUZSXXN731/pFKlefyVviX7Sj5NpTZJbwFdj8XqsVN5EeaZxlUthMKmPP189Y3ilJw/
 DsnA/jLHsfByTtTGJEWfLa+gOgvAmKKhbOE5FFw3BtzRnbUALvU80XeuJGhSmCW9xV+b57rsZn7
 Cqf5MmPzm49ys3iyXubp6+KivuBPN7HTcRU7UUz02ncL4ifEH2Hg9fiwMtWJOEr4TZA8ek0/Kbe
 vXG0A952zgJLVn9O5quYUCT/wEt0duBvyMTkrBR5IVr0LK746UFcGxT2LdSBWkwSCeki+hGtCmH
 ysghNbq/I+hpoLiduPw==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7ce359 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eGoNBsedGaBmCx4Gi5QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX6rwcpxVlqHYS
 DcIYzRSCFdrWjnP1/Y9W9qTVfyIWeE3PxN0CSPqAYAZiGLe/e5CqznHZCHJYIUavzOISE7Wfa8l
 /pbVI4bBlkQheEtLHaEgNt1bAaGRODI=
X-Proofpoint-ORIG-GUID: i50CADaw_gfsZBweIMP1vao5vTuSph7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
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

Mechanical change to sanitize using the following patterns:

  MonitorQMP *qmon  (this patch)
  MonitorHMP *hmon  (following one)
  Monitor *mon

Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/monitor-internal.h |   4 +-
 monitor/qmp-cmds-control.c |  18 +--
 monitor/qmp.c              | 256 ++++++++++++++++++-------------------
 3 files changed, 139 insertions(+), 139 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index bc0932c425a..cfbb3e5ecea 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -216,8 +216,8 @@ void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
 int monitor_set_cpu(Monitor *mon, int cpu_index);
 
-void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
-void monitor_data_destroy_qmp(MonitorQMP *mon);
+void qmp_send_response(MonitorQMP *qmon, const QDict *rsp);
+void monitor_data_destroy_qmp(MonitorQMP *qmon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 8fe0876a3da..45f4fe4f6fb 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -39,7 +39,7 @@
  * On success, set mon->qmp.capab[], and return true.
  * On error, set @errp, and return false.
  */
-static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
+static bool qmp_caps_accept(MonitorQMP *qmon, QMPCapabilityList *list,
                             Error **errp)
 {
     GString *unavailable = NULL;
@@ -48,7 +48,7 @@ static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
     memset(capab, 0, sizeof(capab));
 
     for (; list; list = list->next) {
-        if (!mon->capab_offered[list->value]) {
+        if (!qmon->capab_offered[list->value]) {
             if (!unavailable) {
                 unavailable = g_string_new(QMPCapability_str(list->value));
             } else {
@@ -65,27 +65,27 @@ static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
         return false;
     }
 
-    memcpy(mon->capab, capab, sizeof(capab));
+    memcpy(qmon->capab, capab, sizeof(capab));
     return true;
 }
 
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(monitor_cur());
+    MonitorQMP *qmon = MONITOR_QMP(monitor_cur());
 
-    if (mon->commands == &qmp_commands) {
+    if (qmon->commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
                   "ignored");
         return;
     }
 
-    if (!qmp_caps_accept(mon, enable, errp)) {
+    if (!qmp_caps_accept(qmon, enable, errp)) {
         return;
     }
 
-    mon->commands = &qmp_commands;
+    qmon->commands = &qmp_commands;
 }
 
 VersionInfo *qmp_query_version(Error **errp)
@@ -118,9 +118,9 @@ static void query_commands_cb(const QmpCommand *cmd, void *opaque)
 CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list = NULL;
-    MonitorQMP *mon = MONITOR_QMP(monitor_cur());
+    MonitorQMP *qmon = MONITOR_QMP(monitor_cur());
 
-    qmp_for_each_command(mon->commands, query_commands_cb, &list);
+    qmp_for_each_command(qmon->commands, query_commands_cb, &list);
 
     return list;
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750..d6ce734916e 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -79,44 +79,44 @@ static MonitorQMP *qmp_dispatcher_current_mon;
 
 OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
 
-static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
+static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *qmon);
 
 static void monitor_qmp_finalize(Object *obj)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    json_message_parser_destroy(&mon->parser);
-    qemu_mutex_destroy(&mon->qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    g_queue_free(mon->qmp_requests);
+    json_message_parser_destroy(&qmon->parser);
+    qemu_mutex_destroy(&qmon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(qmon);
+    g_queue_free(qmon->qmp_requests);
 }
 
 static bool monitor_qmp_get_pretty(Object *obj, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    return mon->pretty;
+    return qmon->pretty;
 }
 
 static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    mon->pretty = val;
+    qmon->pretty = val;
 }
 
 static int monitor_qmp_get_close_action(Object *obj, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    return mon->close_action;
+    return qmon->close_action;
 }
 
 static void monitor_qmp_set_close_action(Object *obj, int val, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    mon->close_action = val;
+    qmon->close_action = val;
 }
 
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
@@ -150,25 +150,25 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 static void handle_qmp_command(void *opaque, QObject *req, Error *err);
 static void monitor_qmp_init(Object *obj)
 {
-    MonitorQMP *mon = MONITOR_QMP(obj);
+    MonitorQMP *qmon = MONITOR_QMP(obj);
 
-    qemu_mutex_init(&mon->qmp_queue_lock);
-    mon->qmp_requests = g_queue_new();
+    qemu_mutex_init(&qmon->qmp_queue_lock);
+    qmon->qmp_requests = g_queue_new();
 
-    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
+    json_message_parser_init(&qmon->parser, handle_qmp_command, qmon, NULL);
 }
 
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict)
 {
-    MonitorQMP *qmp = MONITOR_QMP(mon);
+    MonitorQMP *qmon = MONITOR_QMP(mon);
 
     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
-        if (qmp->commands == &qmp_cap_negotiation_commands) {
+        if (qmon->commands == &qmp_cap_negotiation_commands) {
             return;
         }
     }
 
-    qmp_send_response(qmp, qdict);
+    qmp_send_response(qmon, qdict);
 }
 
 static bool monitor_qmp_requires_iothread(const Monitor *mon)
@@ -177,17 +177,17 @@ static bool monitor_qmp_requires_iothread(const Monitor *mon)
                                 QEMU_CHAR_FEATURE_GCONTEXT);
 }
 
-static bool qmp_oob_enabled(MonitorQMP *mon)
+static bool qmp_oob_enabled(MonitorQMP *qmon)
 {
-    return mon->capab[QMP_CAPABILITY_OOB];
+    return qmon->capab[QMP_CAPABILITY_OOB];
 }
 
-static void monitor_qmp_caps_reset(MonitorQMP *mon)
+static void monitor_qmp_caps_reset(MonitorQMP *qmon)
 {
-    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
-    memset(mon->capab, 0, sizeof(mon->capab));
-    mon->capab_offered[QMP_CAPABILITY_OOB] =
-        monitor_requires_iothread(MONITOR(mon));
+    memset(qmon->capab_offered, 0, sizeof(qmon->capab_offered));
+    memset(qmon->capab, 0, sizeof(qmon->capab));
+    qmon->capab_offered[QMP_CAPABILITY_OOB] =
+        monitor_requires_iothread(MONITOR(qmon));
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -198,22 +198,22 @@ static void qmp_request_free(QMPRequest *req)
 }
 
 /* Caller must hold mon->qmp.qmp_queue_lock */
-static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
+static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *qmon)
 {
-    while (!g_queue_is_empty(mon->qmp_requests)) {
-        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
+    while (!g_queue_is_empty(qmon->qmp_requests)) {
+        qmp_request_free(g_queue_pop_head(qmon->qmp_requests));
     }
 }
 
-static void monitor_qmp_drain_queue(MonitorQMP *mon)
+static void monitor_qmp_drain_queue(MonitorQMP *qmon)
 {
-    QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
+    QEMU_LOCK_GUARD(&qmon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(qmon);
 }
 
-static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
+static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *qmon)
 {
-    QEMU_LOCK_GUARD(&mon->qmp_queue_lock);
+    QEMU_LOCK_GUARD(&qmon->qmp_queue_lock);
 
     /*
      * Same condition as in monitor_qmp_dispatcher_co(), but before
@@ -221,11 +221,11 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
      * Also, the queue should not be empty either, otherwise the
      * monitor hasn't been suspended yet (or was already resumed).
      */
-    bool need_resume = (!qmp_oob_enabled(mon) ||
-        mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX)
-        && !g_queue_is_empty(mon->qmp_requests);
+    bool need_resume = (!qmp_oob_enabled(qmon) ||
+        qmon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX)
+        && !g_queue_is_empty(qmon->qmp_requests);
 
-    monitor_qmp_cleanup_req_queue_locked(mon);
+    monitor_qmp_cleanup_req_queue_locked(qmon);
 
     if (need_resume) {
         /*
@@ -237,22 +237,22 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
          * when we get here while the monitor is suspended.  An
          * unfortunately timed CHR_EVENT_CLOSED can do the trick.
          */
-        monitor_resume(&mon->parent_obj);
+        monitor_resume(&qmon->parent_obj);
     }
 
 }
 
-void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
+void qmp_send_response(MonitorQMP *qmon, const QDict *rsp)
 {
     const QObject *data = QOBJECT(rsp);
     GString *json;
 
-    json = qobject_to_json_pretty(data, mon->pretty);
+    json = qobject_to_json_pretty(data, qmon->pretty);
     assert(json != NULL);
-    trace_monitor_qmp_respond(mon, json->str);
+    trace_monitor_qmp_respond(qmon, json->str);
 
     g_string_append_c(json, '\n');
-    monitor_puts(&mon->parent_obj, json->str);
+    monitor_puts(&qmon->parent_obj, json->str);
 
     g_string_free(json, true);
 }
@@ -262,10 +262,10 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
  * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
  * Nothing is emitted then.
  */
-static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
+static void monitor_qmp_respond(MonitorQMP *qmon, QDict *rsp)
 {
     if (rsp) {
-        qmp_send_response(mon, rsp);
+        qmp_send_response(qmon, rsp);
     }
 }
 
@@ -273,15 +273,15 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
  * Runs outside of coroutine context for OOB commands, but in
  * coroutine context for everything else.
  */
-static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
+static void monitor_qmp_dispatch(MonitorQMP *qmon, QObject *req)
 {
     QDict *rsp;
     QDict *error;
 
-    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
-                       &mon->parent_obj);
+    rsp = qmp_dispatch(qmon->commands, req, qmp_oob_enabled(qmon),
+                       &qmon->parent_obj);
 
-    if (mon->commands == &qmp_cap_negotiation_commands) {
+    if (qmon->commands == &qmp_cap_negotiation_commands) {
         error = qdict_get_qdict(rsp, "error");
         if (error
             && !g_strcmp0(qdict_get_try_str(error, "class"),
@@ -293,7 +293,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
         }
     }
 
-    monitor_qmp_respond(mon, rsp);
+    monitor_qmp_respond(qmon, rsp);
     qobject_unref(rsp);
 }
 
@@ -313,22 +313,22 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
 {
     QMPRequest *req_obj = NULL;
     Monitor *mon;
-    MonitorQMP *qmp_mon;
+    MonitorQMP *qmon;
 
     QTAILQ_FOREACH(mon, &mon_list, entry) {
-        qmp_mon = MONITOR_QMP(
+        qmon = MONITOR_QMP(
             object_dynamic_cast(OBJECT(mon), TYPE_MONITOR_QMP));
-        if (!qmp_mon) {
+        if (!qmon) {
             continue;
         }
 
-        qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
-        req_obj = g_queue_pop_head(qmp_mon->qmp_requests);
+        qemu_mutex_lock(&qmon->qmp_queue_lock);
+        req_obj = g_queue_pop_head(qmon->qmp_requests);
         if (req_obj) {
             /* With the lock of corresponding queue held */
             break;
         }
-        qemu_mutex_unlock(&qmp_mon->qmp_queue_lock);
+        qemu_mutex_unlock(&qmon->qmp_queue_lock);
     }
 
     if (req_obj) {
@@ -391,7 +391,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
     QMPRequest *req_obj;
     QDict *rsp;
     bool oob_enabled;
-    MonitorQMP *mon;
+    MonitorQMP *qmon;
 
     while ((req_obj = monitor_qmp_dispatcher_pop_any()) != NULL) {
         trace_monitor_qmp_in_band_dequeue(req_obj,
@@ -401,8 +401,8 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          * @req_obj has a request, we hold req_obj->mon->qmp_queue_lock
          */
 
-        mon = req_obj->mon;
-        qmp_dispatcher_current_mon = mon;
+        qmon = req_obj->mon;
+        qmp_dispatcher_current_mon = qmon;
 
         /*
          * We need to resume the monitor if handle_qmp_command()
@@ -415,17 +415,17 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          * We need to save qmp_oob_enabled() for later, because
          * qmp_qmp_capabilities() can change it.
          */
-        oob_enabled = qmp_oob_enabled(mon);
+        oob_enabled = qmp_oob_enabled(qmon);
         if (oob_enabled
-            && mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_resume(&mon->parent_obj);
+            && qmon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
+            monitor_resume(&qmon->parent_obj);
         }
 
         /*
          * Drop the queue mutex now, before yielding, otherwise we might
          * deadlock if the main thread tries to lock it.
          */
-        qemu_mutex_unlock(&mon->qmp_queue_lock);
+        qemu_mutex_unlock(&qmon->qmp_queue_lock);
 
         if (qatomic_xchg(&qmp_dispatcher_co_busy, true) == true) {
             /*
@@ -448,18 +448,18 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
                 trace_monitor_qmp_cmd_in_band(id_json->str);
                 g_string_free(id_json, true);
             }
-            monitor_qmp_dispatch(mon, req_obj->req);
+            monitor_qmp_dispatch(qmon, req_obj->req);
         } else {
             assert(req_obj->err);
             trace_monitor_qmp_err_in_band(error_get_pretty(req_obj->err));
             rsp = qmp_error_response(req_obj->err);
             req_obj->err = NULL;
-            monitor_qmp_respond(mon, rsp);
+            monitor_qmp_respond(qmon, rsp);
             qobject_unref(rsp);
         }
 
         if (!oob_enabled) {
-            monitor_resume(&mon->parent_obj);
+            monitor_resume(&qmon->parent_obj);
         }
 
         qmp_request_free(req_obj);
@@ -481,7 +481,7 @@ void qmp_dispatcher_co_wake(void)
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
-    MonitorQMP *mon = opaque;
+    MonitorQMP *qmon = opaque;
     QDict *qdict = qobject_to(QDict, req);
     QMPRequest *req_obj;
 
@@ -489,7 +489,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 
     if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
         GString *req_json = qobject_to_json(req);
-        trace_handle_qmp_command(mon, req_json->str);
+        trace_handle_qmp_command(qmon, req_json->str);
         g_string_free(req_json, true);
     }
 
@@ -503,18 +503,18 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
             trace_monitor_qmp_cmd_out_of_band(id_json->str);
             g_string_free(id_json, true);
         }
-        monitor_qmp_dispatch(mon, req);
+        monitor_qmp_dispatch(qmon, req);
         qobject_unref(req);
         return;
     }
 
     req_obj = g_new0(QMPRequest, 1);
-    req_obj->mon = mon;
+    req_obj->mon = qmon;
     req_obj->req = req;
     req_obj->err = err;
 
     /* Protect qmp_requests and fetching its length. */
-    WITH_QEMU_LOCK_GUARD(&mon->qmp_queue_lock) {
+    WITH_QEMU_LOCK_GUARD(&qmon->qmp_queue_lock) {
 
         /*
          * Suspend the monitor when we can't queue more requests after
@@ -523,9 +523,9 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
          * Note that when OOB is disabled, we queue at most one command,
          * for backward compatibility.
          */
-        if (!qmp_oob_enabled(mon) ||
-            mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_suspend(&mon->parent_obj);
+        if (!qmp_oob_enabled(qmon) ||
+            qmon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
+            monitor_suspend(&qmon->parent_obj);
         }
 
         /*
@@ -533,10 +533,10 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
          * handled in time order.  Ownership for req_obj, req,
          * etc. will be delivered to the handler side.
          */
-        trace_monitor_qmp_in_band_enqueue(req_obj, mon,
-                                          mon->qmp_requests->length);
-        assert(mon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
-        g_queue_push_tail(mon->qmp_requests, req_obj);
+        trace_monitor_qmp_in_band_enqueue(req_obj, qmon,
+                                          qmon->qmp_requests->length);
+        assert(qmon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
+        g_queue_push_tail(qmon->qmp_requests, req_obj);
     }
 
     /* Kick the dispatcher routine */
@@ -545,12 +545,12 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorQMP *mon = opaque;
+    MonitorQMP *qmon = opaque;
 
-    json_message_parser_feed(&mon->parser, (const char *) buf, size);
+    json_message_parser_feed(&qmon->parser, (const char *) buf, size);
 }
 
-static QDict *qmp_greeting(MonitorQMP *mon)
+static QDict *qmp_greeting(MonitorQMP *qmon)
 {
     QList *cap_list = qlist_new();
     QObject *ver = NULL;
@@ -562,7 +562,7 @@ static QDict *qmp_greeting(MonitorQMP *mon)
     qobject_unref(args);
 
     for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (mon->capab_offered[cap]) {
+        if (qmon->capab_offered[cap]) {
             qlist_append_str(cap_list, QMPCapability_str(cap));
         }
     }
@@ -574,10 +574,10 @@ static QDict *qmp_greeting(MonitorQMP *mon)
 
 static void monitor_qmp_self_delete_bh(void *opaque)
 {
-    MonitorQMP *mon = opaque;
+    MonitorQMP *qmon = opaque;
     const char *mon_id = object_get_canonical_path_component(
-        OBJECT(mon));
-    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
+        OBJECT(qmon));
+    g_autofree char *chardev_id = g_strdup(qmon->parent_obj.chardev_id);
     Error *local_error = NULL;
 
     if (!mon_id) {
@@ -587,13 +587,13 @@ static void monitor_qmp_self_delete_bh(void *opaque)
          * mon from monitor_qmp_event but it is already
          * unparented.
          */
-        object_unref(mon);
+        object_unref(qmon);
         return;
     }
 
     user_creatable_del(mon_id, &local_error);
     /* Pairs with ref from monitor_qmp_event */
-    object_unref(mon);
+    object_unref(qmon);
     if (local_error != NULL) {
         error_report_err(local_error);
     } else {
@@ -604,25 +604,25 @@ static void monitor_qmp_self_delete_bh(void *opaque)
 static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 {
     QDict *data;
-    MonitorQMP *mon = opaque;
+    MonitorQMP *qmon = opaque;
 
     /*
      * Protect against race if a client drops & quickly
      * reconnects - we'll have the delete BH scheduled
      * so must not honour a new open request
      */
-    if (mon->delete_pending) {
+    if (qmon->delete_pending) {
         return;
     }
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
-            mon->commands = &qmp_cap_negotiation_commands;
-            monitor_qmp_caps_reset(mon);
+        WITH_QEMU_LOCK_GUARD(&qmon->parent_obj.mon_lock) {
+            qmon->commands = &qmp_cap_negotiation_commands;
+            monitor_qmp_caps_reset(qmon);
         }
-        data = qmp_greeting(mon);
-        qmp_send_response(mon, data);
+        data = qmp_greeting(qmon);
+        qmp_send_response(qmon, data);
         qobject_unref(data);
         break;
     case CHR_EVENT_CLOSED:
@@ -632,16 +632,16 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
          * stdio, it's possible that stdout is still open when stdin
          * is closed.
          */
-        monitor_qmp_cleanup_queue_and_resume(mon);
-        json_message_parser_destroy(&mon->parser);
-        json_message_parser_init(&mon->parser, handle_qmp_command,
-                                 mon, NULL);
+        monitor_qmp_cleanup_queue_and_resume(qmon);
+        json_message_parser_destroy(&qmon->parser);
+        json_message_parser_init(&qmon->parser, handle_qmp_command,
+                                 qmon, NULL);
         monitor_fdsets_cleanup();
-        switch (mon->close_action) {
+        switch (qmon->close_action) {
         case MONITOR_QMP_CLOSE_ACTION_NONE:
             break;
         case MONITOR_QMP_CLOSE_ACTION_DELETE:
-            mon->delete_pending = true;
+            qmon->delete_pending = true;
             /*
              * Do NOT run in the AIO context associated with the
              * monitor. We need to run in the default AIO context
@@ -652,9 +652,9 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
              * with the BH by processing an explicit 'object-del'.
              * Will be released by monitor_qmp_self_delete_bh
              */
-            object_ref(mon);
+            object_ref(qmon);
             aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                    monitor_qmp_self_delete_bh, mon);
+                                    monitor_qmp_self_delete_bh, qmon);
             break;
         default:
             g_assert_not_reached();
@@ -668,24 +668,24 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon)
+static bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *qmon)
 {
-    return qmp_dispatcher_current_mon == mon;
+    return qmp_dispatcher_current_mon == qmon;
 }
 
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
-    MonitorQMP *mon = opaque;
+    MonitorQMP *qmon = opaque;
     GMainContext *context;
 
-    assert(monitor_requires_iothread(MONITOR(mon)));
+    assert(monitor_requires_iothread(MONITOR(qmon)));
     context = iothread_get_g_main_context(mon_iothread);
     assert(context);
-    qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
+    qemu_chr_fe_set_handlers(&qmon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
-                             NULL, &mon->parent_obj, context, true);
-    monitor_list_append(&mon->parent_obj);
-    qatomic_set(&mon->setup_pending, false);
+                             NULL, &qmon->parent_obj, context, true);
+    monitor_list_append(&qmon->parent_obj);
+    qatomic_set(&qmon->setup_pending, false);
 }
 
 void monitor_new_qmp(const char *id, const char *chardev_id,
@@ -703,11 +703,11 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
 
 static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(uc);
+    MonitorQMP *qmon = MONITOR_QMP(uc);
     UserCreatableClass *ucc_parent =
         USER_CREATABLE_CLASS(
             object_class_get_parent(
-                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(mon))));
+                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(qmon))));
     ERRP_GUARD();
 
     ucc_parent->complete(uc, errp);
@@ -715,33 +715,33 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
+    qemu_chr_fe_set_echo(&qmon->parent_obj.chr, true);
 
-    if (monitor_requires_iothread(MONITOR(mon))) {
+    if (monitor_requires_iothread(MONITOR(qmon))) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
          */
-        remove_fd_in_watch(mon->parent_obj.chr.chr);
+        remove_fd_in_watch(qmon->parent_obj.chr.chr);
         /*
          * Clean up listener IO sources early to prevent racy fd
          * handling between the main thread and the I/O thread.
          */
-        remove_listener_fd_in_watch(mon->parent_obj.chr.chr);
+        remove_listener_fd_in_watch(qmon->parent_obj.chr.chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        mon->setup_pending = true;
+        qmon->setup_pending = true;
         aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
-                                monitor_qmp_setup_handlers_bh, mon);
+                                monitor_qmp_setup_handlers_bh, qmon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-        qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
+        qemu_chr_fe_set_handlers(&qmon->parent_obj.chr, monitor_can_read,
                                  monitor_qmp_read, monitor_qmp_event,
-                                 NULL, &mon->parent_obj, NULL, true);
-        monitor_list_append(&mon->parent_obj);
+                                 NULL, &qmon->parent_obj, NULL, true);
+        monitor_list_append(&qmon->parent_obj);
     }
 }
 
@@ -753,14 +753,14 @@ static void monitor_qmp_iothread_quiesce(void *opaque)
 static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    MonitorQMP *qmp = MONITOR_QMP(uc);
+    MonitorQMP *qmon = MONITOR_QMP(uc);
 
-    if (monitor_qmp_dispatcher_is_servicing(qmp)) {
+    if (monitor_qmp_dispatcher_is_servicing(qmon)) {
         error_setg(errp, "Cannot delete the current QMP monitor");
         return false;
     }
 
-    if (qatomic_read(&qmp->setup_pending)) {
+    if (qatomic_read(&qmon->setup_pending)) {
         error_setg(errp, "monitor is still initializing");
         return false;
     }
@@ -779,7 +779,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
                              NULL, NULL, true);
 
     /* Drain requests from any in-flight monitor_qmp_read(). */
-    monitor_qmp_drain_queue(qmp);
+    monitor_qmp_drain_queue(qmon);
 
     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
         /* Disable flushes before cancel -- gcontext is already wrong. */
@@ -794,7 +794,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     }
 
     /* Catch requests from a racing monitor_qmp_read(). */
-    monitor_qmp_drain_queue(qmp);
+    monitor_qmp_drain_queue(qmon);
     monitor_fdsets_cleanup();
 
     return true;
-- 
2.53.0


