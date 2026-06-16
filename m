Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A088CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkO-0004O8-81; Tue, 16 Jun 2026 14:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkL-0004NT-85
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkH-0000Pa-KQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYSs331236
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=84ZdvV/U3s5
 tJFqOMewo0p+lYTVRy/VnXo056yaqK5Y=; b=oaS+yRwi34lvxRcYazGl/qBXYLQ
 bT6wlAQL1uG4tvG8M6nKilcwlCc6Ew+9qPq7bS9FKxX6daYk2aZp5xREXtTL55rx
 uZhCrwBv66twnsukrqU0nJRPDivk7XzxruHBQE6oftmaPHCWMDGcSpSqU3jDHrOO
 WqsZQF0DM3siXa/OQDF1n3aBDZ5qlzcU5pGz0tZ2t9taGMtRo7t44g32EC4b/m78
 ioYUfO+siZBDO/2Wm69MTGkE9ohgjpbh6EDoLUul4ypQw4VwzfdCog07KaV5smdn
 GT58M6w7zaqelws32AGdcY/ZJonGWDXGOuq4VWAJQVomdA/TtrmglCQF1zg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbks2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-842692bf60aso6294098b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635364; x=1782240164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84ZdvV/U3s5tJFqOMewo0p+lYTVRy/VnXo056yaqK5Y=;
 b=hPXfF9UfbbRBC4q2MvZ2FURDYwQaxgJHLv/VjRocwmafcT4/sNd0FsVwQagEAfuT5n
 qY67UtITp8F4Uxi8DGBMav3PUx9xlWJx814ZcLG8A99ssrMBCLqi/35+lZgky5+g0IeY
 J0SB9zc0qId2E606MXeDw9OxqwOXR43v+5o0UG4h178Tm2eN01PQBUccTFaJi88wdo9l
 qXCpAJmikUxUverE10aEUpxKotVPjNlVQlt8u8DNptT0nht7R4tv9Zgli5v5bPcnevZK
 LcePd6HPaDP6wxZwsIGl6qpjQSRR/cuku2gSksI8tH7NmFJThqBvFENqPWJRhdHOcYO2
 KSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635364; x=1782240164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84ZdvV/U3s5tJFqOMewo0p+lYTVRy/VnXo056yaqK5Y=;
 b=VOIMyWvlILlgavDLTLw4y8HSDy+lLCGqyumP8F5ILNv+m71TpTO07x6NzaMUHqyYDy
 7LLzDVBrHwKVnLKdvL5EG3jeJFnWZjJxs8GEiK40J7mkG0c9kPHyq8y1HjcLNCXhNnlM
 K9JGE21StVVZOl0IdfsxfUs0Fi6BNQHGCh7JvynfQy2DJ+RmilyjnsYfYslzklPgQoIV
 v+F7ZxZL8ShrD0cnw7MTWvl3lx9bJRcGZuGHyB/p0l+j1FuP5hOs1ttU3xJ3OD6STLT+
 lDH7rZi1PItfDitYhHLemejQu73yeOc4vllt5H4Scu7Tk1qC1SjVDPAwE9P0VSbABMxa
 Wqmg==
X-Gm-Message-State: AOJu0YyZZaRoYI9wrf9RaVxydu/lwNC3bP9EMO+AU0XFnjvLPt82jL9v
 uJesu2ZOezQuELUBApKHqy4gODWxhYLSa277MlDDk1mu9gi/ahNgnGblB511AydfPG3c6AbJ+Dq
 5FTa+/NLN9jiJbq3sjsRFsSWaG+reoYrCrSa6AzIFl060NX3MQPsnkNQA3VGFkBMKHtIh
X-Gm-Gg: Acq92OELRe0GdmKFasrEbQDKm1UUkw7LUSUejbEnMWGQlfp+nnNY2zfS8+Zx71RLPzg
 2S1XT39GNG1Lie4WgeCCor0bAyvfSPor7yr6tXlVz1kHUD0npDvmXO7az0iKv4tKi7sYiN7GAZc
 NuhyNGAv4LlPQ3gJrKu9xUIlyWECAkpHd/xQt++zPhWonNE/zMfTiiXYe5kAh8he+MgS87j9uWx
 cK60sydp2uTGf+702BNNYsHCLzecWr75BTTYjcnd76SX1p1VGyqalAzwKc4ln1w9Q5lb4YFBE0j
 8+lHJSoPfyeQkoORAmSS8glPk90AYE73p28g0TL+nM1t7Es/O70g4/aluxVN4SDi7MaevmmI63R
 S/KTjmgS+O4q64BBnIhLAWPmhYOxsL3ZYU7ZGmehk9vztpDtAptGa+QFAUGl7ArfqLNYujaKt8L
 HuVbd5b0o=
X-Received: by 2002:a05:6a00:3c8c:b0:82c:b808:4c59 with SMTP id
 d2e1a72fcca58-845247c7141mr317864b3a.46.1781635363556; 
 Tue, 16 Jun 2026 11:42:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8c:b0:82c:b808:4c59 with SMTP id
 d2e1a72fcca58-845247c7141mr317840b3a.46.1781635362965; 
 Tue, 16 Jun 2026 11:42:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/26] plugins: add userdata to
 qemu_plugin_register_vcpu_init_cb
Date: Tue, 16 Jun 2026 11:42:11 -0700
Message-ID: <20260616184230.303038-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXy5hTzGD8YetO
 lfulTFCVEAAruJ3qqfnwbCk7JqmtKP4nmkEFt3+A3+V/xUG+8/pUAT0/KeNNH0G2DRjPFqKujrk
 GfXW4a1Ec25+V2i6l8rOR4DRiuhH3SckZwBNh5tfvhvp1A0OKqbeM8tuX7O6SFy/xv2ko0PlIQe
 BnD4TBuGZHiFkvU2XCoO31E36Yv1yXQsWHhJBc7QRVdsI/ELYaRzxe8F595F4JnmgqUTtYUT96x
 v421V0YltR5P3dJ1PIBZYSv79PlcXLSbVpd4oWHWDIQeUVkFB/w/KeV+2Th4CUAwhnTZCZW+b5X
 XZJbWMqBWn+ucm8uaufTIhG81TveE1/AZRNtj22A8ePWHtj+M1zDtvXWuwqIdcTvE5VAcR4n8Jh
 N9ydR+Re3ErDp4y+zv6DIi4neDOxgRf/Gq1IkhmDSehc4+KYsfkEamrRlHIUxYaQ1xyeAIUM6YD
 2WkxrBiPx5h+iljAjgA==
X-Proofpoint-ORIG-GUID: QmXDV-ovY275BZspm6QG21TFLOoHSvc2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX+NMLgOPy2F3Y
 s5b3UsSXm71q3oB/UbtT/fMMq2yXxodnMwcG2cOiWG3RO939FdXAvtXf4qNX44TxsRcWWJKOHLQ
 TZp/Cq1mXWIrM8wTo0dIz/AHOZ1mlGI=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a319924 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8 a=g9HC7tbVjW3t9h3uCicA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QmXDV-ovY275BZspm6QG21TFLOoHSvc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-8-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


