Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94169C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMb-0003Kt-Ce; Wed, 12 Aug 2026 17:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMT-0002mG-RY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMR-0007wA-Qh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2clS301219
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7bGZ0SK8RPLUbVTujswQ6hzIxVh9SxT3gEkMZuKr30Y=; b=WZJuWX4tDI4h5a2h
 bd23kw/2+px722MA5wblQ6+FEV+0+eIk0Kdubp3vglwMrSFkA2kvA5vlC+ks6Qfq
 3teCFggQ62NaCyz+MJJgXkQ6ymhrSOoTVpPmosSDfi6oxLrsZYrPegreaYH5RDbU
 6LMHDJbb2WLa1KLafsFAJTlgj2CbypWI0jDJvRIbXoFv9ENwuwGU7pKu9P1mYKW7
 LHFhlE1Axi1vc8frQBpHqkEDB8kcgPdsZWFqmSko477Y3cfvqo1ABQ31WBHkCp+k
 8UBC0gMf611izJhvmHPZSGhXyuQmbqGed1QbAaASeYg1L3u4kK9bdobOINtlZ+Ci
 /0JKaQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmytxd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so16574946d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569581; x=1787174381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7bGZ0SK8RPLUbVTujswQ6hzIxVh9SxT3gEkMZuKr30Y=;
 b=EdPeLvvyGDEpVxAms/Q8EhIC3GaCU259d7BL3svYoQhm+wppWLuiwI5EJETsRlhK8t
 rZE+q/khyJHcJE97TG9ytR3KMIgLd6EMYNhLxdZITEO/VPIKJC+rmZkgHV51umTYoXV9
 u60v3pub51LI2zV/wClpEVULvH8wbJd818o2+qCOORjQwrjqsP10POmNfan/lMrSBV/9
 4q3Ex92a5IbaXEFiuML6t7Pzkd3t6TcvSPXMUV/dtvT0mjXLVf22ZFLKIa4ePdcGzCL0
 dZ8z4NcHqD3cFnsPSrilXNzNpG7Uwvlx0CYnAL+CBOCp6S9nXfk3ea/nUElMTiPrWSEr
 KPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569581; x=1787174381;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7bGZ0SK8RPLUbVTujswQ6hzIxVh9SxT3gEkMZuKr30Y=;
 b=GgmcFw+YywvOn//sDJ0PBoOS3UR/vKQpk8TcW1DOGQ2UpNMIj/XTa2Rr21UoQDF2u6
 9c01hZaol6Y0CK1j52As0QkhSKvbrDUSgC3DImUCReFMQZrY0dlLLzgEZwhWsmpyN2qO
 l2F7i7zXVAVc9iQjYa18Me6d1AMrfrhBoaq27jCZw1dLVFleTWzz7ewxVHYycgDoxd6C
 ii5hiZRpnrDpFE+qpTNVvUiFtChSy2nlZoZsJXJyBJ6kJThaiFmDD5uQfgJYvPRMTFqL
 9o7m2POdmQQWnLDAEqhaT+RgSg5ZCOnkSGdvwsk0UQnO8b+q/5serhTLFeEaTbLoYqjg
 fYxQ==
X-Gm-Message-State: AOJu0YwX1Y5SYKamtFVW90aJwEvQ2yBNAqopylOjZDLTbrUUhL/nM7AG
 So7ijLXpE0t1kIL0WPIGMS2dWb4TDdtsG2RV4SvaxJYHLzAPLb5R0aMua1px+KymZmse5z5k9Wr
 J4woATTU3jhNrWISpuZskitejxmuFC9xQmnc6sSz+pcr80rOgTphC//+vqg7CDspXXg==
X-Gm-Gg: AR+sD116pvyXhsvvaqTYgsQtuUgZc4uyoqv58aKsm4fKVBdseLVXYTfLur/ZYa5FhYP
 8TElPoDMHioYZQugg5sRhlWWdF6MKcxKndeoUu6mLCeJzldZIm5YC2gAS71pRIFpyJsRG1dmPvH
 FtQ/PwzRUxdc5i+ZYn7PUfXSGDQDOz6ADglKMJuf2vI0fCkW3gFjgn4y7sKxUyk60sH5RCX74If
 +IwnNYYWpRMjXc2B0sxi5IlL1nbhGfu7XpWnLFNDMH3f48qdI/g92OZx87y7JzLnTxFAxgshD8e
 x3pvO4VC6NZs9BsSv3QiMSuRiFYrltKMyYMfl3SgWYK7r4+2n4WGfi2YJLQ4FQnk+TQrlbkKJ70
 pbL/KmthFiyv5wyA7OSln57HsWbCfVLfLDH++28BJ8w==
X-Received: by 2002:a05:622a:58a:b0:528:3163:716b with SMTP id
 d75a77b69052e-52d73c37747mr12622491cf.3.1786569581236; 
 Wed, 12 Aug 2026 14:19:41 -0700 (PDT)
X-Received: by 2002:a05:622a:58a:b0:528:3163:716b with SMTP id
 d75a77b69052e-52d73c37747mr12621891cf.3.1786569580506; 
 Wed, 12 Aug 2026 14:19:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981d85953sm8819555e9.0.2026.08.12.14.19.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 20/23] monitor: Use QOM MONITOR() macro to access
 MonitorQMP->parent_obj
Date: Wed, 12 Aug 2026 23:17:04 +0200
Message-ID: <20260812211708.92824-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX862XXD4RZ3Wb
 rBjxnWcj1oZBlzVw+r0VOaWeMZxwDkO7FeUQVpyhF7tLTqwuevpaJkRwo5uax4ZvmYs0aQd/0ST
 Q3LULOwM7izENiA+LITcJkggKiWAFGU=
X-Proofpoint-ORIG-GUID: C6aB6veOR0gbYT3l71P21Z9tg8rf2kjv
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7ce36e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ePcbETNVwOqpRS83YfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: C6aB6veOR0gbYT3l71P21Z9tg8rf2kjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX+41PANN9jjIo
 Zpyef90wZYCsqd96vVZegpJmeT7q4giKoPP6V+Zt3jYG/9SFs0VSRx22UQy6OOHi2Qou5eknhCd
 jX7bjfDhvKHEivlQvHO51LDF3wj1n2TJY9X0DUiPJXYViq+WsL7pYNBm75FeNIlnlTnZfojh3rm
 a12ErtBRoXzoPyyeXJ9i5l+uyuakSsrihmmvwF/exMqo3OvIM+eIPRdrJiL0J4vAuFsIWemFzuk
 /4vPkbQD4bd0nf5ZawLclF2BfSjW7VG9sfKzrmrTty5Gl0gPZW1yRoChz+dQKPCPFBRHu7y12/8
 LiMP4VE7cpAVyjKx6vabiFFw0PfPKMwXgaTIIwl/PHHrDd4eSxtMcv69AszTaqh9p3KAUjEj0BI
 OIub8dXBzQnuO7D3k1iRYg3d4AezMRbhHWPsmmsgGcU99q7d2z/+Xw36fxQFLegla1AdXrKy1ZL
 PkqGaKJVQ543KllZn6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
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

MonitorQMP QOM parent is Monitor, so we can use the following
QOM-cast macro:

  MONITOR(qmon) == &qmon->parent_obj

When introducing a Monitor variable, name it @mon.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/qmp.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index d6ce734916e..0fed9f47213 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -213,6 +213,8 @@ static void monitor_qmp_drain_queue(MonitorQMP *qmon)
 
 static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *qmon)
 {
+    Monitor *mon = MONITOR(qmon);
+
     QEMU_LOCK_GUARD(&qmon->qmp_queue_lock);
 
     /*
@@ -237,7 +239,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *qmon)
          * when we get here while the monitor is suspended.  An
          * unfortunately timed CHR_EVENT_CLOSED can do the trick.
          */
-        monitor_resume(&qmon->parent_obj);
+        monitor_resume(mon);
     }
 
 }
@@ -245,6 +247,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *qmon)
 void qmp_send_response(MonitorQMP *qmon, const QDict *rsp)
 {
     const QObject *data = QOBJECT(rsp);
+    Monitor *mon = MONITOR(qmon);
     GString *json;
 
     json = qobject_to_json_pretty(data, qmon->pretty);
@@ -252,7 +255,7 @@ void qmp_send_response(MonitorQMP *qmon, const QDict *rsp)
     trace_monitor_qmp_respond(qmon, json->str);
 
     g_string_append_c(json, '\n');
-    monitor_puts(&qmon->parent_obj, json->str);
+    monitor_puts(mon, json->str);
 
     g_string_free(json, true);
 }
@@ -277,9 +280,10 @@ static void monitor_qmp_dispatch(MonitorQMP *qmon, QObject *req)
 {
     QDict *rsp;
     QDict *error;
+    Monitor *mon = MONITOR(qmon);
 
     rsp = qmp_dispatch(qmon->commands, req, qmp_oob_enabled(qmon),
-                       &qmon->parent_obj);
+                       mon);
 
     if (qmon->commands == &qmp_cap_negotiation_commands) {
         error = qdict_get_qdict(rsp, "error");
@@ -392,6 +396,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
     QDict *rsp;
     bool oob_enabled;
     MonitorQMP *qmon;
+    Monitor *mon;
 
     while ((req_obj = monitor_qmp_dispatcher_pop_any()) != NULL) {
         trace_monitor_qmp_in_band_dequeue(req_obj,
@@ -402,6 +407,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
 
         qmon = req_obj->mon;
+        mon = MONITOR(qmon);
         qmp_dispatcher_current_mon = qmon;
 
         /*
@@ -418,7 +424,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         oob_enabled = qmp_oob_enabled(qmon);
         if (oob_enabled
             && qmon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_resume(&qmon->parent_obj);
+            monitor_resume(mon);
         }
 
         /*
@@ -459,7 +465,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         }
 
         if (!oob_enabled) {
-            monitor_resume(&qmon->parent_obj);
+            monitor_resume(mon);
         }
 
         qmp_request_free(req_obj);
@@ -482,6 +488,7 @@ void qmp_dispatcher_co_wake(void)
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     MonitorQMP *qmon = opaque;
+    Monitor *mon = MONITOR(qmon);
     QDict *qdict = qobject_to(QDict, req);
     QMPRequest *req_obj;
 
@@ -525,7 +532,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
          */
         if (!qmp_oob_enabled(qmon) ||
             qmon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_suspend(&qmon->parent_obj);
+            monitor_suspend(mon);
         }
 
         /*
@@ -575,9 +582,10 @@ static QDict *qmp_greeting(MonitorQMP *qmon)
 static void monitor_qmp_self_delete_bh(void *opaque)
 {
     MonitorQMP *qmon = opaque;
+    Monitor *mon = MONITOR(qmon);
     const char *mon_id = object_get_canonical_path_component(
         OBJECT(qmon));
-    g_autofree char *chardev_id = g_strdup(qmon->parent_obj.chardev_id);
+    g_autofree char *chardev_id = g_strdup(mon->chardev_id);
     Error *local_error = NULL;
 
     if (!mon_id) {
@@ -605,6 +613,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 {
     QDict *data;
     MonitorQMP *qmon = opaque;
+    Monitor *mon = MONITOR(qmon);
 
     /*
      * Protect against race if a client drops & quickly
@@ -617,7 +626,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        WITH_QEMU_LOCK_GUARD(&qmon->parent_obj.mon_lock) {
+        WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
             qmon->commands = &qmp_cap_negotiation_commands;
             monitor_qmp_caps_reset(qmon);
         }
@@ -676,15 +685,16 @@ static bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *qmon)
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
     MonitorQMP *qmon = opaque;
+    Monitor *mon = MONITOR(qmon);
     GMainContext *context;
 
     assert(monitor_requires_iothread(MONITOR(qmon)));
     context = iothread_get_g_main_context(mon_iothread);
     assert(context);
-    qemu_chr_fe_set_handlers(&qmon->parent_obj.chr, monitor_can_read,
+    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
-                             NULL, &qmon->parent_obj, context, true);
-    monitor_list_append(&qmon->parent_obj);
+                             NULL, mon, context, true);
+    monitor_list_append(mon);
     qatomic_set(&qmon->setup_pending, false);
 }
 
@@ -704,6 +714,7 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
 static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 {
     MonitorQMP *qmon = MONITOR_QMP(uc);
+    Monitor *mon = MONITOR(qmon);
     UserCreatableClass *ucc_parent =
         USER_CREATABLE_CLASS(
             object_class_get_parent(
@@ -715,19 +726,19 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    qemu_chr_fe_set_echo(&qmon->parent_obj.chr, true);
+    qemu_chr_fe_set_echo(&mon->chr, true);
 
     if (monitor_requires_iothread(MONITOR(qmon))) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
          */
-        remove_fd_in_watch(qmon->parent_obj.chr.chr);
+        remove_fd_in_watch(mon->chr.chr);
         /*
          * Clean up listener IO sources early to prevent racy fd
          * handling between the main thread and the I/O thread.
          */
-        remove_listener_fd_in_watch(qmon->parent_obj.chr.chr);
+        remove_listener_fd_in_watch(mon->chr.chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
@@ -738,10 +749,10 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
                                 monitor_qmp_setup_handlers_bh, qmon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-        qemu_chr_fe_set_handlers(&qmon->parent_obj.chr, monitor_can_read,
+        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
                                  monitor_qmp_read, monitor_qmp_event,
-                                 NULL, &qmon->parent_obj, NULL, true);
-        monitor_list_append(&qmon->parent_obj);
+                                 NULL, mon, NULL, true);
+        monitor_list_append(mon);
     }
 }
 
-- 
2.53.0


