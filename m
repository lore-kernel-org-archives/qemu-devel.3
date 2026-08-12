Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018EAC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMe-0003qZ-5I; Wed, 12 Aug 2026 17:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMc-0003Ww-Gs
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMa-0007wt-2G
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2VFj947953
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLtqyIX4rXVf0sJjNCYge/H7pnr+ce0FOPvj5DKPgLo=; b=jAJMTwVi2WukUttd
 o2pdyE018d9dY1pxmzgE6wk2nwEttZvCJ6EKEMWbMe1OcyrT0wVs9+pwCe8HcBzL
 Ck8CB7gNNKcYAMWPFiXRtQtkRyrsS5JW8KoWfEMxKSmbH/lFrmQ4VbHUvHKO2qR/
 Khiu4z19AWLgJ9vyuYxaZa9zlMYTqlR8AjQp+mn7xDQcyFpLaDEcVaz68mqkCmLk
 qK1RT1iRBHeNgQToArpNmt8Jrv5gvHPjWHMe2FWYSJZPEv3NHfTrgb8Do3lMkfr6
 dgY7jLnClBNvhbNA160sDgCtr+eDIoK1UmqtNX8psmTnaee5XWfP3mHzTPQr232O
 Q8spvg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nuck70v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-907c59bd73bso23615186d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569589; x=1787174389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLtqyIX4rXVf0sJjNCYge/H7pnr+ce0FOPvj5DKPgLo=;
 b=gx3PqgQYE/ZIPJiaEpFZyyoh+yPcoBsPerWjUz70Z4Ol+Y7N/ar+q3EgCkb2UsKXtW
 X+GOcjHjtVpvvxtVlAuG2pRdU/bbgNeHSu2sH/RfP12igzqztcatX7lbTE6SFpTYEbG4
 0bh2flQJI0+HeR4QlsphkXq1bZfVLQIEgeDHM9ThaVwaH0a1HEgWmkMp3yOJ0PSqJ4nW
 4/lQhwaurjRzwNN4YYmElcyJfw0YbYbQLzfW1+H4BGyiSFu/MV5Q11SMlMEiKFPtmHXA
 cSWXucIf/UNPYAcwhHD3vnqvM2F1Bp9vht4j4+v13a60BPEcjpIDHVx8WEWeoN3shOIJ
 jpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569589; x=1787174389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLtqyIX4rXVf0sJjNCYge/H7pnr+ce0FOPvj5DKPgLo=;
 b=pAMSRAir6zfEMj1H4jqdhzy1pHUPsYizsHXlQAZmGBdToXqYCPsf4FxnnrfJ7NH4XF
 PJWHBrpIF6jws3yvJwRAh2J19Y39/cMngzPjcnnpGwOh5168SCvXfsbUwtRCaHADOzZr
 Zgp7in0u5NxanYmb7cd1jVqL1Tbfus0rApjCvtIbJAZ0G9XFF8Ee4mT5GR4FZNVaESMu
 WUMsfTEefdm1qAtiiO1OZ2shn/6iv0r4nLP4kj5jhBdHkrodvK55BatgDehOqku2rSHh
 rphNOB39buIAzy4IWfRIZw2iGJeSyEUKTWfqPbVQl9L0irDrP0/2oolrcX25mCWN/W/6
 cM1g==
X-Gm-Message-State: AOJu0Yzy4+2h4QM983Yvr9XeotSwE8CF5dhULNULLhnoZ7kV9CiVJNhG
 MSdVbTAxnkjXCzo5r5d0RfLkAfJEUp68LsowVXtS/SdkJnWHT0oyF8nZ/ziiWEgYiyl4RBbi5Tz
 a6UNvBXdkTwZwXGH6AORF5Zba4dM7nD7s5zRHQSPAu85eoemRPvcV+EONIkGRFhadvQ==
X-Gm-Gg: AR+sD10vpskitNvomNqmU9FxqBqniUg3WMFtui1LgqaqPpWYmd5wUZepR0kfnFh9xt2
 f9zvl/YltQ/o+AZ5MVTBkkS9saAvdf9p48V0nVW8m90BkR3Ffl993nb3t+Mdq3KYFOp9Z4Os7Vt
 nMM3fx27SLJyYNSI6wgWduD1DrHAIi47/RgypWhWZanBWwrmo4wRhhNctoTICR6axB4v8iLgt1f
 gcBqhX5iC8U44M94cP5sPo/1EHfnbqT2t/CsEPfohT3t2FO/NHHp052fgFoXg9gqs7gY/dkLbrT
 QXQ587qmEt38mOSQG0D6nABxyeOH54jp+nGbzAYKhpvI9z7SzsI0G28WtL4VNpsMx5/J5hen3z5
 G29VfnwWP0Gm/Vwx+pK9Cw5zcQySNcjTtIzMDuyo2VQ==
X-Received: by 2002:ac8:6903:0:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52d73c1bbf9mr12938701cf.6.1786569588200; 
 Wed, 12 Aug 2026 14:19:48 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52d73c1bbf9mr12938171cf.6.1786569587709; 
 Wed, 12 Aug 2026 14:19:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5613e2sm880305f8f.6.2026.08.12.14.19.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 21/23] monitor: Use QOM MONITOR() macro to access
 MonitorHMP->parent_obj
Date: Wed, 12 Aug 2026 23:17:05 +0200
Message-ID: <20260812211708.92824-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S_FrOkVClz7RJsd--a3ClkuYjUbr4VVo
X-Proofpoint-ORIG-GUID: S_FrOkVClz7RJsd--a3ClkuYjUbr4VVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX7/R9XTSUz59P
 37URMzEDdU1JwWP5ZU1MS2tNqrjUXdnE+8ZFFlfSY8MvCwR+rKBuiExpk0GGdMQzCCSxkAKwfCz
 Rv3s2r6YBcdmPvEg1q55hl956Dx8dBbB5w0Czdm8C+ZYdGXwFliX230zgg5o87/MekwSRGAFgq1
 WZKx0+I3DLMxrNFM86LlqnOaSPX83CdtVXZiPQGfopK70OGD9h9sXQlRAOvl4emOaOZEkkl02ZX
 y3JseiR27Z0cY0584JC2DfAFPNdCfMeVkObagprGfHL8BKh0FZRYH5u+TcZKNXnGGDy+L84LuXG
 587VRLaDfU+YH/yTjT+XM72wO6UCMGJs33YN19apUu4doQIsPy3sYOciU3kHW56gqTCZ5/4fHtN
 3j2TXj58vhjVI1aFHnG5uM0VlcAvxlmuJv4Kw1ghOw5GA6C0i49ULr/xf5bU/5sWElS9CptcCYt
 0q99hRs6eAnzOSAVKVQ==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7ce375 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ePcbETNVwOqpRS83YfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX0oGPMPkTWWN2
 UhYR7sSFLfZN1KMcKz55aeYCiwfwpjkMXPckRyX1cBfQgVUdfNaGweYTiqzoIh0IckhJIRPVVMc
 zm/bTFTO/ai6VnbZB9MKxBUPj4V+VDc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
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

MonitorHMP QOM parent is Monitor, so we can use the following
QOM-cast macro:

  MONITOR(hmon) == &hmon->parent_obj

When introducing a Monitor variable, name it @mon.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/hmp.c      | 44 ++++++++++++++++++++++++++------------------
 monitor/qmp-cmds.c |  7 ++++---
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index bfe3cea902c..428ef014284 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -129,10 +129,11 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
     MonitorHMP *hmon = opaque;
+    Monitor *mon = MONITOR(hmon);
 
-    monitor_suspend(&hmon->parent_obj);
+    monitor_suspend(mon);
     handle_hmp_command(hmon, cmdline);
-    monitor_resume(&hmon->parent_obj);
+    monitor_resume(mon);
 }
 
 void monitor_read_command(MonitorHMP *hmon, int show_prompt)
@@ -155,7 +156,8 @@ int monitor_read_password(MonitorHMP *hmon, ReadLineFunc *readline_func,
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
-        monitor_printf(&hmon->parent_obj,
+        Monitor *mon = MONITOR(hmon);
+        monitor_printf(mon,
                        "terminal does not support password prompting\n");
         return -ENOTTY;
     }
@@ -777,7 +779,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmon,
                                                const char **cmdp,
                                                HMPCommand *table)
 {
-    Monitor *mon = &hmon->parent_obj;
+    Monitor *mon = MONITOR(hmon);
     const char *p;
     const HMPCommand *cmd;
     char cmdname[256];
@@ -1257,6 +1259,7 @@ static void handle_hmp_command_co(void *opaque)
 void handle_hmp_command(MonitorHMP *hmon, const char *cmdline)
 {
     QDict *qdict;
+    Monitor *mon = MONITOR(hmon);
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
 
@@ -1270,17 +1273,17 @@ void handle_hmp_command(MonitorHMP *hmon, const char *cmdline)
 
     if (!cmd->cmd && !cmd->cmd_info_hrt) {
         /* FIXME: is it useful to try autoload modules here ??? */
-        monitor_printf(&hmon->parent_obj, "Command \"%.*s\" is not available.\n",
+        monitor_printf(mon, "Command \"%.*s\" is not available.\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
     }
 
-    qdict = monitor_parse_arguments(&hmon->parent_obj, &cmdline, cmd);
+    qdict = monitor_parse_arguments(mon, &cmdline, cmd);
     if (!qdict) {
         while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
             cmdline--;
         }
-        monitor_printf(&hmon->parent_obj,
+        monitor_printf(mon,
                        "Try \"help %.*s\" for more information\n",
                        (int)(cmdline - cmd_start), cmd_start);
         return;
@@ -1289,18 +1292,18 @@ void handle_hmp_command(MonitorHMP *hmon, const char *cmdline)
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
         Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(),
-                                           &hmon->parent_obj);
-        handle_hmp_command_exec(&hmon->parent_obj, cmd, qdict);
+                                           mon);
+        handle_hmp_command_exec(mon, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &hmon->parent_obj,
+            .mon = mon,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &hmon->parent_obj);
+        monitor_set_cur(co, mon);
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1529,7 +1532,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&hmon->parent_obj, "corrupted command\n");
+            monitor_printf(mon, "corrupted command\n");
         } else {
             handle_hmp_command(hmon, (char *)buf);
         }
@@ -1601,16 +1604,20 @@ static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
                                                        const char *fmt, ...)
 {
     MonitorHMP *hmon = opaque;
+    Monitor *mon = MONITOR(hmon);
+
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(&hmon->parent_obj, fmt, ap);
+    monitor_vprintf(mon, fmt, ap);
     va_end(ap);
 }
 
 static void monitor_readline_flush(void *opaque)
 {
     MonitorHMP *hmon = opaque;
-    monitor_flush(&hmon->parent_obj);
+    Monitor *mon = MONITOR(hmon);
+
+    monitor_flush(mon);
 }
 
 void monitor_new_hmp(const char *id, const char *chardev_id,
@@ -1629,6 +1636,7 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
 static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
 {
     MonitorHMP *hmon = MONITOR_HMP(uc);
+    Monitor *mon = MONITOR(hmon);
     UserCreatableClass *ucc_parent =
         USER_CREATABLE_CLASS(
             object_class_get_parent(
@@ -1640,7 +1648,7 @@ static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (hmon->parent_obj.chardev_id) {
+    if (mon->chardev_id) {
         if (hmon->use_readline) {
             hmon->rs = readline_init(monitor_readline_printf,
                                     monitor_readline_flush,
@@ -1649,12 +1657,12 @@ static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
             monitor_read_command(hmon, 0);
         }
 
-        qemu_chr_fe_set_handlers(&hmon->parent_obj.chr,
+        qemu_chr_fe_set_handlers(&mon->chr,
                                  monitor_can_read,
                                  monitor_read,
                                  monitor_event, NULL,
-                                 &hmon->parent_obj, NULL, true);
-        monitor_list_append(&hmon->parent_obj);
+                                 mon, NULL, true);
+        monitor_list_append(mon);
     }
 }
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 4ca87857c3f..48a2231b439 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -167,9 +167,10 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
 {
     char *output = NULL;
     MonitorHMP *hmon = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
+    Monitor *mon = MONITOR(hmon);
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmon->parent_obj, cpu_index);
+        int ret = monitor_set_cpu(mon, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
@@ -179,8 +180,8 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
 
     handle_hmp_command(hmon, command_line);
 
-    WITH_QEMU_LOCK_GUARD(&hmon->parent_obj.mon_lock) {
-        output = g_strdup(hmon->parent_obj.outbuf->str);
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        output = g_strdup(mon->outbuf->str);
     }
 
 out:
-- 
2.53.0


