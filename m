Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE554CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD68-0002R9-4y; Mon, 15 Jun 2026 15:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD61-0002NU-DQ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD5w-0001Bi-N2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1URU1433453
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t2bYWvc1Jcu
 RE6kIhJNG9vEcyanzDaz0CZ8YQ1WeCdM=; b=CFrUcnpGgLuC+Qkf+ICAB0+1c+v
 hWT/GfEh5u1Pd7LYir1e4GE2SeUGqZKBwtUYhv0VbqjaYzfdiBRuVbk98RgylaEH
 xtDqm5LmQNf9eQqf0uxJfywBf3wyXWm8M0IXyU6mAbXPY/VSyA45Zw3Za/vgm/5t
 tl6wXTsB1J5o1npiuZKhdPqdI8hjZlS4RY0Ukiuwcd6btym7Ij1onIbaIWZSrA+J
 2GoGeI4USEM5iGL1NSzDuYlZBXTTEmNghdBWdYXppcGNpWztX9oXclGogWMoM6ax
 S4WP2ddgeneWMjHDde6lPu+gZ8qmZBtsmb7qgUkA+fOEW6ke6eZg7wZwvDw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhj46c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1382f39e4b5so2455204c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552138; x=1782156938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2bYWvc1JcuRE6kIhJNG9vEcyanzDaz0CZ8YQ1WeCdM=;
 b=iI/2gdiJhJKJL/ngUpWnKS5S3QtmIWwJJDinsDiNkVdxxnUN3tg6rx87cVRK2cBfOK
 Nswl0uOG4nSys6MpiY/piHMc6JPVW6GGB0CWZPgmM65SuGbbNPNY39BLxRHZMH6VIFmO
 GgE0D7LtISb33cPPoN4NPdDBQC430xREn/FJdlqlDGab33zFNlqgMqQSEPvNhWeI74Qc
 FSXW8VpLlIMQAIQMBWnBHIsaVe5AVYLcYm5GMCnyhw1T0rufJJhkxPwbWP/zfJue9IrI
 Th2LK4KrP5YjqQ1HxVOpLfJv0lNswbRUyThIjZhrJGD/kzJmeaaVusM5sR/EWCtuw1J8
 hfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552138; x=1782156938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2bYWvc1JcuRE6kIhJNG9vEcyanzDaz0CZ8YQ1WeCdM=;
 b=AH/6Xx3SPbV7W5Gd2186MYNEJXg0jRDvthgdkHz5bVg7LqO5SkVwAgz/xVnOcBG6/H
 BN+cuMfEP0G1YvDka9Oegp4WrgUUwbjsMHrAuyLLogH36KQBXe8ciYPcA7MsQxgr4i2Z
 qeT2RmiNxMR/YL69k5Vt4sDQLcrMztaJWAS36WgGTJrQLKvbG6S+EkwRoMQbQTaI4IqG
 UY/ijgPxezeHio5uGm4WMGHhgssVwUoDTR42SdB0rdCWkRli0zMNsen83RpVlVRQkeDC
 0yvh2Wcb+57qROKZwJvW2+e5UjFKATYir2zBAf4cEfwsOg1D8zDKofFW0o65fklqex7a
 hOPw==
X-Gm-Message-State: AOJu0YyKbxlE0Qt0TkzBfUlx2SQlc7pFDE5+tu2ky4iU/2d2SqVLdwVv
 Z2NGzKs5L4PpSwGZFJ6A+KdDtCujcvlC3XHzEZ19FXP+osd1tdzTxg43ICMWPXrbl9OQrYJXhbP
 4cvwiyc1/QBfMX3fE6zYtmVuF1relv5QFAkV0SNDwq9++Jgk6VR4sKgHX8XEyIz3hWNPG
X-Gm-Gg: Acq92OECSMRySftwbn7My1JOsQCSb2bVQuWwBsgnFk4E+/9Bh7YInGzOiXzzzF5kwjs
 bYzpbplAbpOlB27hgeBYJZTY7Y4m6cxGhPbz6iX/2ypEew8cWmzI81Wz5eoMAmeDTla82BKMnRo
 3MbX+2S0+UyS5lNEzPON1aFMZqQTQ5rK7xxS8M5bw8y6LVsRxjpEk89xwJeym8Fh/CGJRNRUFFO
 MGT4cDzaReHFrByxVRPVPgUfXwhn3A4pZdsjb1DJI2+tm0rtZx54fcTak3nMpIoTQKPMXgntvjK
 MmU5ADsKdLqyVZos4pwTCNp5ZgfWNwYQ/BYOXjX5bQLB/RXliSvFJ33pTztJ8U2j16A2DJKjFgk
 2G6xMcBYZ+CEueOs4xG59n/lyLM52/bIWmTz28hGEAvLY7pb6ER6GlBZdpvpRijNbko1jEen56w
 SD5VZxPg==
X-Received: by 2002:a05:7022:78e:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-13985818f2amr409486c88.19.1781552138367; 
 Mon, 15 Jun 2026 12:35:38 -0700 (PDT)
X-Received: by 2002:a05:7022:78e:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-13985818f2amr409468c88.19.1781552137803; 
 Mon, 15 Jun 2026 12:35:37 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 07/26] plugins: add userdata to
 qemu_plugin_register_vcpu_init_cb
Date: Mon, 15 Jun 2026 12:35:06 -0700
Message-ID: <20260615193526.2883349-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0YnnVTAbyQjy
 /z3k90QfUtr1cdDjcktk6y0WGhr507Wa/yL1KN06zLWWeREC1duGaddnFOPv5dLfdS0cRuP4ryn
 XBxryDWfSV6F1f4sSfQdtYvRyw0G8CQ=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a30540b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=mDV3o1hIAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=g9HC7tbVjW3t9h3uCicA:9
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qnxR5BR8FsK-i4qfqAm1cOT5bnNpwYl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX8NlSUfsgwSYn
 LaMjvx5Nf73JPFS5mEOwX32rSICFkwmKypoHayXHS9u6aEFHxjTp+QpMLQAH/us4MgG1GrmKUaP
 ABiL9yMvVIdVCu0oRg0xGaYChCYzMa/u61ln9s9wI2sliHeY7JSdPrEnnJd7/BRLz4SAdhgPS78
 BNzX7OlOj+plmGMt3Ff41AmKcrCC8REaH7febgN3RUKJZzV/lrUsKuqmrVRcElrlDI5WqDT24lG
 xta4wxrbjWWH56avkQFxHnQBAZ2uBg0vlLwHWhTkfYPhR5yNCXaVwA40/wwDM0CnbOfrRfWzqL0
 y5skNH/nYnLFBM7FqOQpI0C4FFuuFuo6E3FWRTz56mDmJ2JzlYjfyZTq3LHqFiLqZyxGyjzOQPO
 Q+RHEuXcxUR/5Zkw+EBB+ajsNHNfLa7cvkpHIC2Zs6xP8qMsPj2UuKzU9PhkkyhK/ZWRJlOXG1x
 f6D5szs7DMUnMRmnYRg==
X-Proofpoint-ORIG-GUID: qnxR5BR8FsK-i4qfqAm1cOT5bnNpwYl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         |  4 ++--
 contrib/plugins/execlog.c     |  4 ++--
 contrib/plugins/ips.c         |  4 ++--
 contrib/plugins/uftrace.c     |  4 ++--
 include/plugins/qemu-plugin.h |  4 +++-
 plugins/api.c                 |  5 +++--
 plugins/core.c                | 25 +++++++++++++++++++++++--
 tests/tcg/plugins/insn.c      |  4 ++--
 tests/tcg/plugins/registers.c |  4 ++--
 9 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index 72cc896a0a6..0ad1301a1de 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
     return qemu_plugin_scoreboard_u64(bb->count);
 }
 
-static void vcpu_init(unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index, void *userdata)
 {
     g_autofree gchar *vcpu_filename = NULL;
     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
@@ -156,7 +156,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, free_bb);
     vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 398aa4a1f3f..2d02816a184 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
  * As we could have multiple threads trying to do this we need to
  * serialise the expansion under a lock.
  */
-static void vcpu_init(unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index, void *userdata)
 {
     CPU *c;
 
@@ -481,7 +481,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 32fd86c87ac..1290a624489 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
     g_mutex_unlock(&global_state_lock);
 }
 
-static void vcpu_init(unsigned int cpu_index)
+static void vcpu_init(unsigned int cpu_index, void *userdata)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     vcpu->total_insn = 0;
@@ -207,7 +207,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     g_assert(time_handle);
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 438cebf2831..8be8409dce2 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-static void vcpu_init(unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index, void *userdata)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     cpu->ops = arch_ops;
@@ -985,7 +985,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 8aaf404504b..bb4569a2291 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -242,6 +242,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU is initialized.
  *
@@ -249,7 +250,8 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
diff --git a/plugins/api.c b/plugins/api.c
index 91c9a24a6b2..68b564bb9c2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -71,9 +71,10 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
  */
 
 void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INIT, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index 217d6608c1d..48db38fe924 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_INIT:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
@@ -104,6 +103,28 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb, *next;
+
+    switch (ev) {
+    case QEMU_PLUGIN_EV_VCPU_INIT:
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
+            func(cpu->cpu_index, cb->udata);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -271,7 +292,7 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
     qemu_rec_mutex_unlock(&plugin.lock);
 
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
+    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 80f7cbb2967..d9f94888d6f 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
 /*
  * Initialise a new vcpu with reading the register list
  */
-static void vcpu_init(unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index, void *userdata)
 {
     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
     g_autoptr(GByteArray) reg_value = g_byte_array_new();
@@ -296,7 +296,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
     /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
index 94776d887fe..0e41734435f 100644
--- a/tests/tcg/plugins/registers.c
+++ b/tests/tcg/plugins/registers.c
@@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  * registers that cannot be written to, which would fail the test.
  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
  */
-static void vcpu_init_cb(unsigned int vcpu_index)
+static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
 {
     g_autoptr(GArray) regs = qemu_plugin_get_registers();
     g_assert(regs != NULL);
@@ -74,6 +74,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb, NULL);
     return 0;
 }
-- 
2.43.0


