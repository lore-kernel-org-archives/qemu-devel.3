Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686ABC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMX-0002qX-NZ; Wed, 12 Aug 2026 17:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMH-0002Pf-99
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGME-0007uc-En
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2T0t520534
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NG4KSBbNxvNRIZkFMRYfrR3abIcp/TjNZT5R6QRTgUA=; b=p3JX0SrUZXudAWPh
 L9l55FcBUP423nvEjmMAFptepteZaPlxOxhLwZGMSeAHOTvXf1ihuJhxkqkXZLVn
 omatTJz7sTlcqLIgrpJCD7dOBDEZtRrtLYy50ggH46MTAgKoXV4RW4r6n23/kPZ8
 0lbkCvbTyf8wFasOJcuwgIr1p5flMuXj0p0XSQPbBc6/k3PjVCmvi6vttnq/EAIe
 JRmoLDpspWUzClMgmfbxai3PXi4N9dCfur07O8JVdwBFLDgd2iDuVY2CMVEX4svo
 UPlj79rKNXthdstRfzlQpRmux1zhNLgCkVXXpqAaHUYgt9PL+r4z0zkkQCotinC+
 mQmCoA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xx1rdsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c01ff996dso21308741cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569567; x=1787174367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NG4KSBbNxvNRIZkFMRYfrR3abIcp/TjNZT5R6QRTgUA=;
 b=gOdymzEhYeTseaKd8mHwJsGB1+A5apLO3Nb2WtlqTwPNq1uWZMPsnb6K3znQicLnDN
 vOveW3ZJvke3r+IAh38AIxR7K2W/oB+E5vFmUSOmohHVxqSIH95mC4FjVvUMTqLuGBzI
 B9WgipXDvD1lDBfuoEUpkcXn9I22u2pIvgwjO1Tw6Umoys5FWzxug1BpyPqY6YXG8CxS
 I6K6wdj8X1GjYJec+xvlSewPm8tu3ESXfkSjEx98mrRWZcK+fk7pnfVQMdMG7H1raxgm
 hMCqNGAjOcE2NCbx2Xxi5ponVRgCerNiNtgI3TMSZOjFf4A+yT+1HeM4rfKFYKugAF8g
 dnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569567; x=1787174367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NG4KSBbNxvNRIZkFMRYfrR3abIcp/TjNZT5R6QRTgUA=;
 b=U2ovn2r3otUhr6xfnyYRN6BEZ0TK7b5x2pUgVgkuh5SyZbxpaorn4WpVPW38Wkzdko
 6l5iSdr+kaN6m5sWHNb47aMrNoGa8SAmc0d8I3d9kjywR8pyk+W0efHYNdUJ97F6uAAO
 rhXKkhWzj64X6j7Sg6gr6HDD+Ln239OYFuflnFKednyJspahzn7ifMVLYdY8YPRawff7
 DiNCFXUL/htq9OrQCjfsOY0t37HasAYP7Ja7uAR4BNLDzz+N1ktzIF8NHCQMWq+HCpzr
 ZQoyg7f3Y7qEgiVbyGbLhCbgEisCM+M0LDnPyouPLgUUCkVdg2QsDY9sGg5jWmZhpdjq
 FeTQ==
X-Gm-Message-State: AOJu0Ywt09PI5Z/juwCVdrCUxHPikpSWROVKDrco6wqbcmdM91Ngxmli
 e3nd51fuPpPkB03BHXT58Oh8WrQIBPFeoGcUP7qOU1Jl0I/5L/HPgItrSeap2FUtTKdNELD3JrN
 Zr2CrbI/JdZ0TK1AETqiuyURF3vJtEnxV6BQGGNI01LvEFpQsGIjWK2Qn+KGz0kXYyQ==
X-Gm-Gg: AR+sD12X5GudhzGujEA1+uFy8H4yW0dpt+xyZPbz8RHtqA+DeFr6ec2iyVNa6JODmgA
 C+HBhkmdPJZan+9aCAHopq3HSZtz5hJZdImcW+QlUtQIWlrC3tdz6PU+lyzkkOL8qNb6sv46zod
 GuO8ZdwNRmjVH13wF1OOw6xHYCGCcbRIxTrg3GhKnY9DPpEF1/grXAqoMPrcYwIcHjvFWRtUwLO
 k3mvMQqh8678O6ubCpH40eK4vrUQDpIUyHAIM7yBDtSDEL+FEQL2HVknezueC++JPT/Ieog7QuJ
 yCT+xutQRgEQRlZb7r3JqbiLFN0D3mBfwCxr0SRvK5t0eYloNV98mLtNIirZmDXwGX9sCtNpxbt
 dbB9JEw9oM+Sx1MuGfrBMOIKxt2Dwpe7mkdNgjkjvAQ==
X-Received: by 2002:ac8:5d03:0:b0:52d:4f43:d5b0 with SMTP id
 d75a77b69052e-52d73d614b1mr10349761cf.22.1786569567035; 
 Wed, 12 Aug 2026 14:19:27 -0700 (PDT)
X-Received: by 2002:ac8:5d03:0:b0:52d:4f43:d5b0 with SMTP id
 d75a77b69052e-52d73d614b1mr10349001cf.22.1786569566294; 
 Wed, 12 Aug 2026 14:19:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569c2bsm633199f8f.12.2026.08.12.14.19.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 18/23] monitor: Rename MonitorHMP @mon -> @hmon
Date: Wed, 12 Aug 2026 23:17:02 +0200
Message-ID: <20260812211708.92824-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jIZDt6rr6i14HyzmQqtc36ULdhfcj5j9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXwIzp1yeBXq3H
 jpkmJISWzKjm7Ou316jT7sSaPymrQK/cpZgFZTXqJMMbGOONlmatI00TVUGsAKLUhZxVm8fZ64S
 zKf3a3J7SOkVVelFdmd0oXSixu9oRdP8671WlktA94+k4uDN8Smb95xjUCvt5xIb/tK9jgPvfyl
 7NPu2gT2PWc9WaL3x0xvCtF96ogzP1wAKrfODF1v3IkPChJ4aHXIvCgM41NNBH0tCntU9YfJ75J
 Od5ucPY5Ml/z/zhSLgE7ZZej7s4z59jRJ6hin8fn4cId4J3ktK3uYblLIvFhQ32DPsC5cdB74y/
 onfxi4LtBSAReJnxudFFZ00DxTadK7r/EPCS4rJdlpxZI9IThrXJwtIVPmZ3seBB3fzZ4MziRJI
 EuG+hF6kaN05BumQHAdHfq6UnW2U6P2rQRxyB7JwXHcGOqK09MYP5ktzllSnh9CyPK4S88u/Fy/
 ZlSlRBhza6DZ4mDw79g==
X-Authority-Analysis: v=2.4 cv=J6KaKgnS c=1 sm=1 tr=0 ts=6a7ce360 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5WHFjD7YvRk6Re6qPwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8jWshnfT4/9i
 SoSPnUkvTwyfhtWBhRzhW2YBckzaQfBRXpP2D2MWPrXN/RE3Fwwk8TPouI3hIYXxZur1NyD+PYf
 ITRio4LFBxcnCEHlA90mqrO2lLUvu5U=
X-Proofpoint-ORIG-GUID: jIZDt6rr6i14HyzmQqtc36ULdhfcj5j9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

  MonitorQMP *qmon  (previous patch)
  MonitorHMP *hmon  (this patch)
  Monitor *mon

Rename @mon (and @hmp_mon) as @hmon when the type is MonitorHMP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h      |   4 +-
 monitor/monitor-internal.h     |   2 +-
 migration/migration-hmp-cmds.c |   4 +-
 monitor/hmp-cmds.c             |  10 +--
 monitor/hmp.c                  | 155 +++++++++++++++++----------------
 monitor/qmp-cmds.c             |  12 +--
 ui/ui-hmp-cmds.c               |   4 +-
 7 files changed, 96 insertions(+), 95 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fd98ee2c71d..e86b945350a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -55,8 +55,8 @@ void monitor_flush_locked(Monitor *mon);
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
 
-void monitor_read_command(MonitorHMP *mon, int show_prompt);
-int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
+void monitor_read_command(MonitorHMP *hmon, int show_prompt);
+int monitor_read_password(MonitorHMP *hmon, ReadLineFunc *readline_func,
                           void *opaque);
 
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index cfbb3e5ecea..65015409288 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -221,7 +221,7 @@ void monitor_data_destroy_qmp(MonitorQMP *qmon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
+void handle_hmp_command(MonitorHMP *hmon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
 /*
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 351512942af..d4ca67575ab 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -855,9 +855,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
     if (!detach) {
         HMPMigrationStatus *status;
-        MonitorHMP *hmp = MONITOR_HMP(mon);
+        MonitorHMP *hmon = MONITOR_HMP(mon);
 
-        if (!hmp->use_readline) {
+        if (!hmon->use_readline) {
             monitor_printf(mon, "terminal does not allow synchronous "
                            "migration, continuing detached\n");
             return;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a0..71d7df6d013 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -129,8 +129,8 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
 
 void hmp_quit(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
-    if (hmp->use_readline) {
+    MonitorHMP *hmon = MONITOR_HMP(mon);
+    if (hmon->use_readline) {
         monitor_suspend(mon);
     }
     qmp_quit(NULL);
@@ -290,16 +290,16 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
     int i;
     const char *str;
 
-    if (!hmp_mon->rs) {
+    if (!hmon->rs) {
         return;
     }
     i = 0;
     for(;;) {
-        str = readline_get_history(hmp_mon->rs, i);
+        str = readline_get_history(hmon->rs, i);
         if (!str) {
             break;
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 71a18882491..24076dc7c03 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -49,24 +49,24 @@ OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 
 static void monitor_hmp_finalize(Object *obj)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
-    if (mon->rs) {
-        readline_free(mon->rs);
+    MonitorHMP *hmon = MONITOR_HMP(obj);
+    if (hmon->rs) {
+        readline_free(hmon->rs);
     }
 }
 
 static bool monitor_hmp_get_readline(Object *obj, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
+    MonitorHMP *hmon = MONITOR_HMP(obj);
 
-    return mon->use_readline;
+    return hmon->use_readline;
 }
 
 static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(obj);
+    MonitorHMP *hmon = MONITOR_HMP(obj);
 
-    mon->use_readline = val;
+    hmon->use_readline = val;
 }
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -93,14 +93,14 @@ static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 
 static void monitor_hmp_init(Object *obj)
 {
-    MonitorHMP *hmp = MONITOR_HMP(obj);
+    MonitorHMP *hmon = MONITOR_HMP(obj);
 
     /*
      * Default to common case for external HMP use,
      * as opposed to non-interactive internal use
      * from gdbstub
      */
-    hmp->use_readline = true;
+    hmon->use_readline = true;
 }
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -113,12 +113,12 @@ static void monitor_hmp_accept_input(Monitor *mon)
 {
     qemu_mutex_lock(&mon->mon_lock);
     if (mon->reset_seen) {
-        MonitorHMP *hmp = MONITOR_HMP(mon);
-        assert(hmp->rs);
-        readline_restart(hmp->rs);
+        MonitorHMP *hmon = MONITOR_HMP(mon);
+        assert(hmon->rs);
+        readline_restart(hmon->rs);
         qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
-        readline_show_prompt(hmp->rs);
+        readline_show_prompt(hmon->rs);
     } else {
         qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
@@ -128,34 +128,34 @@ static void monitor_hmp_accept_input(Monitor *mon)
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmon = opaque;
 
-    monitor_suspend(&mon->parent_obj);
-    handle_hmp_command(mon, cmdline);
-    monitor_resume(&mon->parent_obj);
+    monitor_suspend(&hmon->parent_obj);
+    handle_hmp_command(hmon, cmdline);
+    monitor_resume(&hmon->parent_obj);
 }
 
-void monitor_read_command(MonitorHMP *mon, int show_prompt)
+void monitor_read_command(MonitorHMP *hmon, int show_prompt)
 {
-    if (!mon->rs) {
+    if (!hmon->rs) {
         return;
     }
 
-    readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
+    readline_start(hmon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
     if (show_prompt) {
-        readline_show_prompt(mon->rs);
+        readline_show_prompt(hmon->rs);
     }
 }
 
-int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
+int monitor_read_password(MonitorHMP *hmon, ReadLineFunc *readline_func,
                           void *opaque)
 {
-    if (mon->rs) {
-        readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
+    if (hmon->rs) {
+        readline_start(hmon->rs, "Password: ", 1, readline_func, opaque);
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
-        monitor_printf(&mon->parent_obj,
+        monitor_printf(&hmon->parent_obj,
                        "terminal does not support password prompting\n");
         return -ENOTTY;
     }
@@ -772,12 +772,12 @@ static const HMPCommand *search_dispatch_table(const HMPCommand *disp_table,
  * Do not assume the return value points into @table!  It doesn't when
  * the command is found in a sub-command table.
  */
-static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
+static const HMPCommand *monitor_parse_command(MonitorHMP *hmon,
                                                const char *cmdp_start,
                                                const char **cmdp,
                                                HMPCommand *table)
 {
-    Monitor *mon = &hmp_mon->parent_obj;
+    Monitor *mon = &hmon->parent_obj;
     const char *p;
     const HMPCommand *cmd;
     char cmdname[256];
@@ -809,7 +809,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
     *cmdp = p;
     /* search sub command */
     if (cmd->sub_table != NULL && *p != '\0') {
-        return monitor_parse_command(hmp_mon, cmdp_start, cmdp, cmd->sub_table);
+        return monitor_parse_command(hmon, cmdp_start, cmdp, cmd->sub_table);
     }
 
     return cmd;
@@ -1254,15 +1254,15 @@ static void handle_hmp_command_co(void *opaque)
     data->done = true;
 }
 
-void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
+void handle_hmp_command(MonitorHMP *hmon, const char *cmdline)
 {
     QDict *qdict;
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
 
-    trace_handle_hmp_command(mon, cmdline);
+    trace_handle_hmp_command(hmon, cmdline);
 
-    cmd = monitor_parse_command(mon, cmdline, &cmdline,
+    cmd = monitor_parse_command(hmon, cmdline, &cmdline,
                                 hmp_cmds_for_target(false));
     if (!cmd) {
         return;
@@ -1270,17 +1270,17 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     if (!cmd->cmd && !cmd->cmd_info_hrt) {
         /* FIXME: is it useful to try autoload modules here ??? */
-        monitor_printf(&mon->parent_obj, "Command \"%.*s\" is not available.\n",
+        monitor_printf(&hmon->parent_obj, "Command \"%.*s\" is not available.\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-    qdict = monitor_parse_arguments(&mon->parent_obj, &cmdline, cmd);
+    qdict = monitor_parse_arguments(&hmon->parent_obj, &cmdline, cmd);
     if (!qdict) {
         while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
             cmdline--;
         }
-        monitor_printf(&mon->parent_obj,
+        monitor_printf(&hmon->parent_obj,
                        "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
@@ -1289,18 +1289,18 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
         Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(),
-                                           &mon->parent_obj);
-        handle_hmp_command_exec(&mon->parent_obj, cmd, qdict);
+                                           &hmon->parent_obj);
+        handle_hmp_command_exec(&hmon->parent_obj, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &mon->parent_obj,
+            .mon = &hmon->parent_obj,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &mon->parent_obj);
+        monitor_set_cur(co, &hmon->parent_obj);
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1308,7 +1308,8 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     qobject_unref(qdict);
 }
 
-static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
+static void cmd_completion(MonitorHMP *hmon,
+                           const char *name, const char *list)
 {
     const char *p, *pstart;
     char cmd[128];
@@ -1324,7 +1325,7 @@ static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
         }
         memcpy(cmd, pstart, len);
         cmd[len] = '\0';
-        readline_add_completion_of(mon->rs, name, cmd);
+        readline_add_completion_of(hmon->rs, name, cmd);
         if (*p == '\0') {
             break;
         }
@@ -1332,7 +1333,7 @@ static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
     }
 }
 
-static void file_completion(MonitorHMP *mon, const char *input)
+static void file_completion(MonitorHMP *hmon, const char *input)
 {
     DIR *ffs;
     struct dirent *d;
@@ -1384,7 +1385,7 @@ static void file_completion(MonitorHMP *mon, const char *input)
             if (stat(file, &sb) == 0 && S_ISDIR(sb.st_mode)) {
                 pstrcat(file, sizeof(file), "/");
             }
-            readline_add_completion(mon->rs, file);
+            readline_add_completion(hmon->rs, file);
         }
     }
     closedir(ffs);
@@ -1396,7 +1397,7 @@ static const char *next_arg_type(const char *typestr)
     return (p != NULL ? ++p : typestr);
 }
 
-static void monitor_find_completion_by_table(MonitorHMP *mon,
+static void monitor_find_completion_by_table(MonitorHMP *hmon,
                                              const HMPCommand *cmd_table,
                                              char **args,
                                              int nb_args)
@@ -1414,10 +1415,10 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         } else {
             cmdname = args[0];
         }
-        readline_set_completion_index(mon->rs, strlen(cmdname));
+        readline_set_completion_index(hmon->rs, strlen(cmdname));
         for (cmd = cmd_table; cmd->name != NULL; cmd++) {
             if (cmd_available(cmd)) {
-                cmd_completion(mon, cmdname, cmd->name);
+                cmd_completion(hmon, cmdname, cmd->name);
             }
         }
     } else {
@@ -1434,12 +1435,12 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
 
         if (cmd->sub_table) {
             /* do the job again */
-            monitor_find_completion_by_table(mon, cmd->sub_table,
+            monitor_find_completion_by_table(hmon, cmd->sub_table,
                                              &args[1], nb_args - 1);
             return;
         }
         if (cmd->command_completion) {
-            cmd->command_completion(mon->rs, nb_args, args[nb_args - 1]);
+            cmd->command_completion(hmon->rs, nb_args, args[nb_args - 1]);
             return;
         }
 
@@ -1461,20 +1462,20 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
         switch (*ptype) {
         case 'F':
             /* file completion */
-            readline_set_completion_index(mon->rs, strlen(str));
-            file_completion(mon, str);
+            readline_set_completion_index(hmon->rs, strlen(str));
+            file_completion(hmon, str);
             break;
         case 'B':
             /* block device name completion */
-            readline_set_completion_index(mon->rs, strlen(str));
+            readline_set_completion_index(hmon->rs, strlen(str));
             while ((blk = blk_next(blk)) != NULL) {
-                readline_add_completion_of(mon->rs, str, blk_name(blk));
+                readline_add_completion_of(hmon->rs, str, blk_name(blk));
             }
             break;
         case 's':
         case 'S':
             if (!strcmp(cmd->name, "help|?")) {
-                monitor_find_completion_by_table(mon, cmd_table,
+                monitor_find_completion_by_table(hmon, cmd_table,
                                                  &args[1], nb_args - 1);
             }
             break;
@@ -1487,7 +1488,7 @@ static void monitor_find_completion_by_table(MonitorHMP *mon,
 static void monitor_find_completion(void *opaque,
                                     const char *cmdline)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmon = opaque;
     char *args[MAX_ARGS];
     int nb_args, len;
 
@@ -1509,7 +1510,7 @@ static void monitor_find_completion(void *opaque,
     }
 
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, hmp_cmds_for_target(false),
+    monitor_find_completion_by_table(hmon, hmp_cmds_for_target(false),
                                      args, nb_args);
 
 cleanup:
@@ -1518,18 +1519,18 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *mon = container_of(opaque, MonitorHMP, parent_obj);
+    MonitorHMP *hmon = container_of(opaque, MonitorHMP, parent_obj);
     int i;
 
-    if (mon->rs) {
+    if (hmon->rs) {
         for (i = 0; i < size; i++) {
-            readline_handle_byte(mon->rs, buf[i]);
+            readline_handle_byte(hmon->rs, buf[i]);
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&mon->parent_obj, "corrupted command\n");
+            monitor_printf(&hmon->parent_obj, "corrupted command\n");
         } else {
-            handle_hmp_command(mon, (char *)buf);
+            handle_hmp_command(hmon, (char *)buf);
         }
     }
 }
@@ -1537,14 +1538,14 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
 static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon = opaque;
-    MonitorHMP *hmp = MONITOR_HMP(mon);
+    MonitorHMP *hmon = MONITOR_HMP(mon);
 
     switch (event) {
     case CHR_EVENT_MUX_IN:
         qemu_mutex_lock(&mon->mon_lock);
         if (mon->mux_out) {
             mon->mux_out = 0;
-            if (hmp->use_readline) {
+            if (hmon->use_readline) {
                 monitor_resume(mon);
             }
         }
@@ -1559,7 +1560,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             } else {
                 monitor_flush_locked(mon);
             }
-            if (hmp->use_readline) {
+            if (hmon->use_readline) {
                 monitor_suspend(mon);
             }
             mon->mux_out = 1;
@@ -1572,7 +1573,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
                        "information\n", QEMU_VERSION);
         qemu_mutex_lock(&mon->mon_lock);
         mon->reset_seen = 1;
-        if (!mon->mux_out && hmp->use_readline) {
+        if (!mon->mux_out && hmon->use_readline) {
             /* Suspend-resume forces the prompt to be printed.  */
             monitor_suspend(mon);
             monitor_resume(mon);
@@ -1598,17 +1599,17 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
 static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
                                                        const char *fmt, ...)
 {
-    MonitorHMP *mon = opaque;
+    MonitorHMP *hmon = opaque;
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(&mon->parent_obj, fmt, ap);
+    monitor_vprintf(&hmon->parent_obj, fmt, ap);
     va_end(ap);
 }
 
 static void monitor_readline_flush(void *opaque)
 {
-    MonitorHMP *mon = opaque;
-    monitor_flush(&mon->parent_obj);
+    MonitorHMP *hmon = opaque;
+    monitor_flush(&hmon->parent_obj);
 }
 
 void monitor_new_hmp(const char *id, const char *chardev_id,
@@ -1626,11 +1627,11 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
 
 static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(uc);
+    MonitorHMP *hmon = MONITOR_HMP(uc);
     UserCreatableClass *ucc_parent =
         USER_CREATABLE_CLASS(
             object_class_get_parent(
-                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(mon))));
+                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(hmon))));
     ERRP_GUARD();
 
     ucc_parent->complete(uc, errp);
@@ -1638,21 +1639,21 @@ static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (mon->parent_obj.chardev_id) {
-        if (mon->use_readline) {
-            mon->rs = readline_init(monitor_readline_printf,
+    if (hmon->parent_obj.chardev_id) {
+        if (hmon->use_readline) {
+            hmon->rs = readline_init(monitor_readline_printf,
                                     monitor_readline_flush,
-                                    mon,
+                                    hmon,
                                     monitor_find_completion);
-            monitor_read_command(mon, 0);
+            monitor_read_command(hmon, 0);
         }
 
-        qemu_chr_fe_set_handlers(&mon->parent_obj.chr,
+        qemu_chr_fe_set_handlers(&hmon->parent_obj.chr,
                                  monitor_can_read,
                                  monitor_read,
                                  monitor_event, NULL,
-                                 &mon->parent_obj, NULL, true);
-        monitor_list_append(&mon->parent_obj);
+                                 &hmon->parent_obj, NULL, true);
+        monitor_list_append(&hmon->parent_obj);
     }
 }
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 6cb0b587fbd..4ca87857c3f 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -166,10 +166,10 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
     char *output = NULL;
-    MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
+    MonitorHMP *hmon = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
+        int ret = monitor_set_cpu(&hmon->parent_obj, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
@@ -177,14 +177,14 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
         }
     }
 
-    handle_hmp_command(hmp, command_line);
+    handle_hmp_command(hmon, command_line);
 
-    WITH_QEMU_LOCK_GUARD(&hmp->parent_obj.mon_lock) {
-        output = g_strdup(hmp->parent_obj.outbuf->str);
+    WITH_QEMU_LOCK_GUARD(&hmon->parent_obj.mon_lock) {
+        output = g_strdup(hmon->parent_obj.outbuf->str);
     }
 
 out:
-    object_unref(hmp);
+    object_unref(hmon);
     return output;
 }
 
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 06f4030ce4f..fb13eca0b0c 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -343,8 +343,8 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
-        monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
+        MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
+        monitor_read_password(hmon, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
     }
-- 
2.53.0


