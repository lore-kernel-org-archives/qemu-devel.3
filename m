Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA7AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEt-0002vC-8C; Sun, 16 Aug 2026 10:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEr-0002t1-CN
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEo-0002YO-RT
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkkBu2760247
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wn16rRvE8n9RTiq0RjbJ1LnxMtKnPezXBKOnODR7kFo=; b=TMJBOXeYr+ZrcY2C
 MPPsaZxGeIf0EPvO3/wvMwWbgSMUjwD9PRHpYNmlUvxerOWQxOLEls4M7WQrUiY4
 Kw+m+JpuLryo3BM57IQayfqdxbW4udGvYf77pK3ECQJXcv8HwgVsRhcG2ZL5wRb3
 EBbfw/0+gh8jz+t82QAYt844jv7GyYQsiNoX+FUR0sqWy4rD/oyzKG6R3gWsi3ZL
 u0SAwlOVjyIY1Au+47HYO54zyn8YEeaAjJvYNH0QRhQ5mBvHkWJaEfwv55KqJb4V
 pwvahyEAk9zOFEaSa1Uq/pfKgrgKBRG6vssJh+OCF8comngVi1jJrwdIGBAzP9m3
 qDUBZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkhd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso24415281cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892003; x=1787496803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wn16rRvE8n9RTiq0RjbJ1LnxMtKnPezXBKOnODR7kFo=;
 b=ZNabHEzPqWPjziOkYUtKuX6E5J9sSEdJqgAHUU5b+duJ20qj+7EVCoCuZIo5bD92Cx
 Mup3yaR7OgMRH6IJw9pehrCdn8YIXCCsm1IJPy4qVWEOK0ygdFquAT1cTdQCVzFMNu7Q
 +iUQDA0oLOPyng7jWw/9pFP7L+86umDIwChKW/fWnAi28OMjyti1T0lEPojSeXqJ0Upl
 tfUnDyRgxE7iJi8gDlqyIAkFgBAdeIrStAXP9MmQxVa//iAFazjOhmbrAmiVTX117cM7
 3LHAREC3qA2ChZF5XPw4XWNkGZ8Ah5W7K+4CS/Jpy5lyZyQIulbi27p5RJiFOfrZtIAD
 04OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892003; x=1787496803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wn16rRvE8n9RTiq0RjbJ1LnxMtKnPezXBKOnODR7kFo=;
 b=cJ8Gc6sitysFzOh9oRh1jvhACUtJ1ucL27T/00Dc2EnUITrBkUHr8zZ8ugemBumz6E
 6WHEiSfkXJyrkDtCPxVAabby0gslLvOafWvQ4MSwE0pyuYXXAXWrZ0qluUd5Rn3gYRYG
 GN2gbbRIwqsSRBGeplRAYeNsg88/gaPoLeSaUhAIpGGBPXDjumBPywDvztxjumJAhY0I
 lqZFAFKAkQkCBQlaRABmfrTG7h5MynVT4MJX+vTLliC3mAtTwoVI7beb9oKJ4iW8H/BH
 mxOny9ngCd1elj7ENwoiaZU4Z9w7OL7A955T3DrnLOI5bVOGvFnhdVcvCCZ039yMgRR4
 FDWg==
X-Gm-Message-State: AOJu0YwYAAd4stOx7pOptc3U46Aq1xvRH0Lz578gael6OhrILeXXVSXk
 Pn+mbVeXoJky3/vc12gKc1yiLK9mH/dbnfKSQ0lE8cQgBPSFMkHCgkugSxnbl/DiSoaxsW89/48
 JnsrukIbkQemL7cS9ueRxTZC47hlvy/VlupbLtXYWy5ZYM6dIodW2BqSHJ314zzfgmg==
X-Gm-Gg: AR+sD11TThMAqkaor4k7QHKb/0x82ejm5Dm/ijeqoss/teny6r9QAhrf8PTvckYMjW5
 BIQcyOv/iKxrR/ZJ0BLom7oCl4SH0PKrSu4LUkKO1lBwPRUCdW6Kzm1nk5pZYWnQesGy+D9s0if
 U+mDGZ3z5IbIh5T/nFA4DARlpu70oohpif3zukO6vroCgt7pw7ZaJgvrHxtdH6Q5RenQJZ3P55U
 ZwlFLy8XfEzi031tctGUu1sjhMBs+h1iN9qlxFKTAVFuvYOiu6H+MnROSvO0e5h7Q9iNBe9Nlr9
 XYBUAXpt33XrvvIedSvQZxndsBxuzZL1kXVsFgzrbJVAj8SvKg8huxsBDqcrKuhkcSslRspfVzL
 13E2q4L4rR14x9LL/JHrXsQTgJzdMbu0y4dSjSZ3x0Q==
X-Received: by 2002:ac8:7f8b:0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d8530e04emr200706181cf.9.1786892002847; 
 Sun, 16 Aug 2026 07:53:22 -0700 (PDT)
X-Received: by 2002:ac8:7f8b:0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d8530e04emr200705781cf.9.1786892002093; 
 Sun, 16 Aug 2026 07:53:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999611bf65sm47974725e9.13.2026.08.16.07.53.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/56] monitor: Rename MonitorHMP @mon -> @hmp
Date: Sun, 16 Aug 2026 16:45:51 +0200
Message-ID: <20260816144556.69009-53-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PvaX7efe37SlZ5nQau9FJfiakXyu7oiB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX3qb+iEoP/VrQ
 7rA0YDNT0k/rYOzKwXjQYUw5ouL3RXeJuDvm7BqQV9DAiE+11TnXHYQm4bb+9tsLM2n4RDWeSoY
 ww2XCuZCBFppg7y0Lh5ABwnBg1EjtNU=
X-Proofpoint-GUID: PvaX7efe37SlZ5nQau9FJfiakXyu7oiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX2H/2YCKBFeI3
 vzIvJKatIAlu9JqgwVoFDRR2005Nbdkljzvih/qsM0GrPlsu59LgIr6wcFWuLwofTUoc/W4imeo
 g/ZeJL4uPuUzoygQ03ReiJhhzANzd9frbaeUUMbe1SvuVYRcG9J+Vit3ypEHV8ZSSunxolcnh9K
 zz4Dpayxohl0QQbgVHA+KY8gQl1laYTH97lRUAM9ut7v2C45h/D1PSIE1w7LDpQoJC3pb9YTUSi
 XW58/JCWw6dhTqRETJ87qVScsdUtIpbBu7q19rMV+NW00DC/spJEGiL7y61pxZ2TtaeNTBJbErI
 tPmnKhmYfDP/Eh2fVFXvqWQ7AdnhQrbXcqLm8on0enzjNcSpN19M8Zlti+4cjfJVUVa+CQldWvT
 T4Y3tPghYk+bHa/iVIlkjYKFJjPuWD0MuLNVpO2aPSUYirLkYk24cyImZHBW4jSVsR9HQRYAR1A
 X0gPxNMn/OvuyPRSjzQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cee4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=wEi9R27ph0kDrfoOIwAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
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

Mechanical change to sanitize using the following patterns:

  MonitorQMP *qmp
  MonitorHMP *hmp
  Monitor *mon

Rename @mon (and @hmp_mon) as @hmp when the type is MonitorHMP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260812211708.92824-19-philmd@oss.qualcomm.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h  |   4 +-
 monitor/monitor-internal.h |   2 +-
 monitor/hmp-cmds.c         |   6 +-
 monitor/hmp.c              | 135 +++++++++++++++++++------------------
 ui/ui-hmp-cmds.c           |   4 +-
 5 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fd98ee2c71d..54134f2aa4f 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -55,8 +55,8 @@ void monitor_flush_locked(Monitor *mon);
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
 
-void monitor_read_command(MonitorHMP *mon, int show_prompt);
-int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
+void monitor_read_command(MonitorHMP *hmp, int show_prompt);
+int monitor_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
                           void *opaque);
 
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index bc0932c425a..e0a124a317a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -221,7 +221,7 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
+void handle_hmp_command(MonitorHMP *hmp, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
 /*
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a0..bcd0a1fc878 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -290,16 +290,16 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
     int i;
     const char *str;
 
-    if (!hmp_mon->rs) {
+    if (!hmp->rs) {
         return;
     }
     i = 0;
     for(;;) {
-        str = readline_get_history(hmp_mon->rs, i);
+        str = readline_get_history(hmp->rs, i);
         if (!str) {
             break;
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 71a18882491..cbf7a114c0c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -49,24 +49,24 @@ OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 
 static void monitor_hmp_finalize(Object *obj)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
-    if (mon->rs) {
-        readline_free(mon->rs);
+    MonitorHMP *hmp = MONITOR_HMP(obj);
+    if (hmp->rs) {
+        readline_free(hmp->rs);
     }
 }
 
 static bool monitor_hmp_get_readline(Object *obj, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
+    MonitorHMP *hmp = MONITOR_HMP(obj);
 
-    return mon->use_readline;
+    return hmp->use_readline;
 }
 
 static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
+    MonitorHMP *hmp = MONITOR_HMP(obj);
 
-    mon->use_readline = val;
+    hmp->use_readline = val;
 }
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -128,34 +128,34 @@ static void monitor_hmp_accept_input(Monitor *mon)
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmp = opaque;
 
-    monitor_suspend(&mon->parent_obj);
-    handle_hmp_command(mon, cmdline);
-    monitor_resume(&mon->parent_obj);
+    monitor_suspend(&hmp->parent_obj);
+    handle_hmp_command(hmp, cmdline);
+    monitor_resume(&hmp->parent_obj);
 }
 
-void monitor_read_command(MonitorHMP *mon, int show_prompt)
+void monitor_read_command(MonitorHMP *hmp, int show_prompt)
 {
-    if (!mon->rs) {
+    if (!hmp->rs) {
         return;
     }
 
-    readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
+    readline_start(hmp->rs, "(qemu) ", 0, monitor_command_cb, NULL);
     if (show_prompt) {
-        readline_show_prompt(mon->rs);
+        readline_show_prompt(hmp->rs);
     }
 }
 
-int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
+int monitor_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
                           void *opaque)
 {
-    if (mon->rs) {
-        readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
+    if (hmp->rs) {
+        readline_start(hmp->rs, "Password: ", 1, readline_func, opaque);
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
-        monitor_printf(&mon->parent_obj,
+        monitor_printf(&hmp->parent_obj,
                        "terminal does not support password prompting\n");
         return -ENOTTY;
     }
@@ -772,12 +772,12 @@ static const HMPCommand *search_dispatch_table(const HMPCommand *disp_table,
  * Do not assume the return value points into @table!  It doesn't when
  * the command is found in a sub-command table.
  */
-static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
+static const HMPCommand *monitor_parse_command(MonitorHMP *hmp,
                                                const char *cmdp_start,
                                                const char **cmdp,
                                                HMPCommand *table)
 {
-    Monitor *mon = &hmp_mon->parent_obj;
+    Monitor *mon = &hmp->parent_obj;
     const char *p;
     const HMPCommand *cmd;
     char cmdname[256];
@@ -809,7 +809,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
     *cmdp = p;
     /* search sub command */
     if (cmd->sub_table != NULL && *p != '\0') {
-        return monitor_parse_command(hmp_mon, cmdp_start, cmdp, cmd->sub_table);
+        return monitor_parse_command(hmp, cmdp_start, cmdp, cmd->sub_table);
     }
 
     return cmd;
@@ -1254,15 +1254,15 @@ static void handle_hmp_command_co(void *opaque)
     data->done = true;
 }
 
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
+void handle_hmp_command(MonitorHMP *hmp, const char *cmdline)
 {
     QDict *qdict;
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
 
-    trace_handle_hmp_command(mon, cmdline);
+    trace_handle_hmp_command(hmp, cmdline);
 
-    cmd = monitor_parse_command(mon, cmdline, &cmdline,
+    cmd = monitor_parse_command(hmp, cmdline, &cmdline,
                                 hmp_cmds_for_target(false));
     if (!cmd) {
         return;
@@ -1270,17 +1270,17 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     if (!cmd->cmd && !cmd->cmd_info_hrt) {
         /* FIXME: is it useful to try autoload modules here ??? */
-        monitor_printf(&mon->parent_obj, "Command \"%.*s\" is not available.\n",
+        monitor_printf(&hmp->parent_obj, "Command \"%.*s\" is not available.\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-    qdict = monitor_parse_arguments(&mon->parent_obj, &cmdline, cmd);
+    qdict = monitor_parse_arguments(&hmp->parent_obj, &cmdline, cmd);
     if (!qdict) {
         while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
             cmdline--;
         }
-        monitor_printf(&mon->parent_obj,
+        monitor_printf(&hmp->parent_obj,
                        "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
@@ -1289,18 +1289,18 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
         Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(),
-                                           &mon->parent_obj);
-        handle_hmp_command_exec(&mon->parent_obj, cmd, qdict);
+                                           &hmp->parent_obj);
+        handle_hmp_command_exec(&hmp->parent_obj, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &mon->parent_obj,
+            .mon = &hmp->parent_obj,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &mon->parent_obj);
+        monitor_set_cur(co, &hmp->parent_obj);
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1308,7 +1308,8 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     qobject_unref(qdict);
 }
 
-static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
+static void cmd_completion(MonitorHMP *hmp,
+                           const char *name, const char *list)
 {
     const char *p, *pstart;
     char cmd[128];
@@ -1324,7 +1325,7 @@ static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
         }
         memcpy(cmd, pstart, len);
         cmd[len] = '\0';
-        readline_add_completion_of(mon->rs, name, cmd);
+        readline_add_completion_of(hmp->rs, name, cmd);
         if (*p == '\0') {
             break;
         }
@@ -1332,7 +1333,7 @@ static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
     }
 }
 
-static void file_completion(MonitorHMP *mon, const char *input)
+static void file_completion(MonitorHMP *hmp, const char *input)
 {
     DIR *ffs;
     struct dirent *d;
@@ -1384,7 +1385,7 @@ static void file_completion(MonitorHMP *mon, const char *input)
             if (stat(file, &sb) == 0 && S_ISDIR(sb.st_mode)) {
                 pstrcat(file, sizeof(file), "/");
             }
-            readline_add_completion(mon->rs, file);
+            readline_add_completion(hmp->rs, file);
         }
     }
     closedir(ffs);
@@ -1396,7 +1397,7 @@ static const char *next_arg_type(const char *typestr)
     return (p != NULL ? ++p : typestr);
 }
 
-static void monitor_find_completion_by_table(MonitorHMP *mon,
+static void monitor_find_completion_by_table(MonitorHMP *hmp,
                                              const HMPCommand *cmd_table,
                                              char **args,
                                              int nb_args)
@@ -1414,10 +1415,10 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         } else {
             cmdname = args[0];
         }
-        readline_set_completion_index(mon->rs, strlen(cmdname));
+        readline_set_completion_index(hmp->rs, strlen(cmdname));
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
             if (cmd_available(cmd)) {
-                cmd_completion(mon, cmdname, cmd->name);
+                cmd_completion(hmp, cmdname, cmd->name);
             }
         }
     } else {
@@ -1434,12 +1435,12 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
 
         if (cmd->sub_table) {
             /* do the job again */
-            monitor_find_completion_by_table(mon, cmd->sub_table,
+            monitor_find_completion_by_table(hmp, cmd->sub_table,
                                              &args[1], nb_args - 1);
             return;
         }
         if (cmd->command_completion) {
-            cmd->command_completion(mon->rs, nb_args, args[nb_args - 1]);
+            cmd->command_completion(hmp->rs, nb_args, args[nb_args - 1]);
             return;
         }
 
@@ -1461,20 +1462,20 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         switch (*ptype) {
         case 'F':
             /* file completion */
-            readline_set_completion_index(mon->rs, strlen(str));
-            file_completion(mon, str);
+            readline_set_completion_index(hmp->rs, strlen(str));
+            file_completion(hmp, str);
             break;
         case 'B':
             /* block device name completion */
-            readline_set_completion_index(mon->rs, strlen(str));
+            readline_set_completion_index(hmp->rs, strlen(str));
             while ((blk = blk_next(blk)) != NULL) {
-                readline_add_completion_of(mon->rs, str, blk_name(blk));
+                readline_add_completion_of(hmp->rs, str, blk_name(blk));
             }
             break;
         case 's':
         case 'S':
             if (!strcmp(cmd->name, "help|?")) {
-                monitor_find_completion_by_table(mon, cmd_table,
+                monitor_find_completion_by_table(hmp, cmd_table,
                                                  &args[1], nb_args - 1);
             }
             break;
@@ -1487,7 +1488,7 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
 static void monitor_find_completion(void *opaque,
                                     const char *cmdline)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmp = opaque;
     char *args[MAX_ARGS];
     int nb_args, len;
 
@@ -1509,7 +1510,7 @@ static void monitor_find_completion(void *opaque,
     }
 
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, hmp_cmds_for_target(false),
+    monitor_find_completion_by_table(hmp, hmp_cmds_for_target(false),
                                      args, nb_args);
 
 cleanup:
@@ -1518,18 +1519,18 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *mon = container_of(opaque, MonitorHMP, parent_obj);
+    MonitorHMP *hmp = container_of(opaque, MonitorHMP, parent_obj);
     int i;
 
-    if (mon->rs) {
+    if (hmp->rs) {
         for (i = 0; i < size; i++) {
-            readline_handle_byte(mon->rs, buf[i]);
+            readline_handle_byte(hmp->rs, buf[i]);
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&mon->parent_obj, "corrupted command\n");
+            monitor_printf(&hmp->parent_obj, "corrupted command\n");
         } else {
-            handle_hmp_command(mon, (char *)buf);
+            handle_hmp_command(hmp, (char *)buf);
         }
     }
 }
@@ -1598,17 +1599,17 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
 static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
                                                        const char *fmt, ...)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmp = opaque;
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(&mon->parent_obj, fmt, ap);
+    monitor_vprintf(&hmp->parent_obj, fmt, ap);
     va_end(ap);
 }
 
 static void monitor_readline_flush(void *opaque)
 {
-    MonitorHMP *mon = opaque;
-    monitor_flush(&mon->parent_obj);
+    MonitorHMP *hmp = opaque;
+    monitor_flush(&hmp->parent_obj);
 }
 
 void monitor_new_hmp(const char *id, const char *chardev_id,
@@ -1626,11 +1627,11 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
 
 static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(uc);
+    MonitorHMP *hmp = MONITOR_HMP(uc);
     UserCreatableClass *ucc_parent =
         USER_CREATABLE_CLASS(
             object_class_get_parent(
-                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(mon))));
+                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(hmp))));
     ERRP_GUARD();
 
     ucc_parent->complete(uc, errp);
@@ -1638,21 +1639,21 @@ static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (mon->parent_obj.chardev_id) {
-        if (mon->use_readline) {
-            mon->rs = readline_init(monitor_readline_printf,
+    if (hmp->parent_obj.chardev_id) {
+        if (hmp->use_readline) {
+            hmp->rs = readline_init(monitor_readline_printf,
                                     monitor_readline_flush,
-                                    mon,
+                                    hmp,
                                     monitor_find_completion);
-            monitor_read_command(mon, 0);
+            monitor_read_command(hmp, 0);
         }
 
-        qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
+        qemu_chr_fe_set_handlers(&hmp->parent_obj.chr,
                                  monitor_can_read,
                                  monitor_read,
                                  monitor_event, NULL,
-                                 &mon->parent_obj, NULL, true);
-        monitor_list_append(&mon->parent_obj);
+                                 &hmp->parent_obj, NULL, true);
+        monitor_list_append(&hmp->parent_obj);
     }
 }
 
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 06f4030ce4f..24cf3a67104 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -343,8 +343,8 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
-        monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
+        MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
+        monitor_read_password(hmp, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
     }
-- 
2.53.0


