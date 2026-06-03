Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C835CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZf-00083H-Sl; Wed, 03 Jun 2026 16:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZU-0007z4-Nd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZQ-0004DU-Sj
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653GdpBO2368043
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=epPLegPgQTu
 V2yJ21CDLla7A2wgulQVaoXgygT+ANhc=; b=b83XWYF6i73XV22h/6EdpguASgo
 RZH26doiu/MnPIBA3hGgLjVcaTDF9vzhsL8ww157XDtSC9ISy5CQbfFAIpwa+udo
 ZfhjJkoOT/7oScN5AfnBbc6REnPoELCtPJWRWnBAv+R3yHHFisGgJ+Nfmzv7A3IJ
 fVKoHMpRzv8t/BYvcS7/tN2+g6TjeOWS9BgoaAeHTARPa3PvRoYEGiRPoLUvGDSB
 NbGySqpSWzEM/flhypl65I/FvZe7isAtZW3ivIzLQa1Up62hJg2Su0Os68fHJmzi
 O1kAyD2/uqv52V1OaJ+okCkq6TuBg1cJ2ylBdk6O1Y8/BxDSXGpliRoejJw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gjnd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ec73b015so815547eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519929; x=1781124729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epPLegPgQTuV2yJ21CDLla7A2wgulQVaoXgygT+ANhc=;
 b=S889ZuIgjwi4Kz5PYobsJBTKdIhJaB/3p2r2MjnECfSDzdavVIQ0fUQPCLArhXRh7U
 O1a9nwyuCIhNa2Fp8xkoaaodUS6glf1v2CQgaVMleSqFmPxc0yuUhomIUrrIU0sN1uMp
 P6Kat933p1RTdhXC5IANUcotIxaO84jx/CyRJSek7r/WNWLcYxwVPKbhy77eN+OzlIEC
 +sG6j1+jF2QHo4DpJ2w2PZupnp2jBCR/cnw9xve0QIoBZ55JcNIOU0oBdJ22SR8CsAe7
 a7jqPsoGSP2dzXwSQ/r66DK/fFgBrh0DLrivBbsd0FPJaJJajnStjW+0yaXLWZUs9lBr
 /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519929; x=1781124729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=epPLegPgQTuV2yJ21CDLla7A2wgulQVaoXgygT+ANhc=;
 b=mH5pVVm+iPsaTyIGFSjzI+XBC7buPa8lE+dJAsK4gj9o2hIsZlvIiXvCjDIyCt+NOR
 ci7m67BGy//cNRFF62u45SBrDvIrjxZ00PjyX/JYoCoBcJtuuUtbj9ryRDlVvKYL/Bxu
 AWwVo6jyV8557OrjXE64FWtwf2Th58KZrgewof4v5M6S2IHci6pxKQc9Yevz+xzSd1K8
 T6BBPhuRMYrZCaCKLU+229S1xED1xqnIGuQRacd31YcJ7QDJV2NHkagGxKsg1sixeRp0
 taJvlfnNwC3nxfiegMX9PP/DpcRsOJwN+9hkDCIec99jJ+uhbRPqssH1nRBuEzKz+yW7
 9ODw==
X-Gm-Message-State: AOJu0YyTHyOWb7pH5V6zJD5w+14o1+qoaXdcZEnn7D0p6jpaeD4NpwgX
 Zl34gZeAaKfU3an5MMiJllvi4aealPZ3COKUMBa/fVNsq+eV85kYDLzwDtGOgcoXTIxSi1u7KkY
 RgjrJWP7rxdIoUCqZzQSbmHcUXpYupUPTJfwCKeXloEcYdLZx1aL/Q/4jGy2zPnmAHvbA
X-Gm-Gg: Acq92OEwOPM9nmPyw77M2QBMDdYpE4U2hEfNHS1LbddgoAurfrZUbZYCtf48Q7SB6d3
 ekE57kiS1mxT5HE9n/et0BTs8P+CHnrT2tB0r65uMC57x40aZHYmOyvP2RLAU5ExSw53ELNY5xt
 nY+fIRPCoMNxNr5oQgSEI1ZW6zyueS0XLZvhdCMl2WayIu6/oMe/6UkF6y3AgfK/GfIfz65LAsI
 tngTUBEHpYwn7DuvRNAZawE1PYQvlxD8XB5riAxwhk6+KPYkH18Xr7vvcwu/6NJcIzImmo1QQRA
 npmrC3BGp4ZTzPKEy8dyyvWLl6XKNOhVDA8kFC16t7snbmQgo8MexLrZ4/c/NoXGRp8bhR6lWGw
 9e34E7p93L8kk5qvIHmaLRcIz1R16Mss088Ga3mPu7FOoaFcKu1OoFUsN/IEvwC5sX3riYgJhRl
 R32MLtxOxSy8i6s9av
X-Received: by 2002:a05:7300:fd09:b0:304:d32e:65e5 with SMTP id
 5a478bee46e88-3074fa7fc9dmr3005479eec.8.1780519929148; 
 Wed, 03 Jun 2026 13:52:09 -0700 (PDT)
X-Received: by 2002:a05:7300:fd09:b0:304:d32e:65e5 with SMTP id
 5a478bee46e88-3074fa7fc9dmr3005457eec.8.1780519928628; 
 Wed, 03 Jun 2026 13:52:08 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 07/25] plugins: add userdata to
 qemu_plugin_register_vcpu_init_cb
Date: Wed,  3 Jun 2026 13:51:34 -0700
Message-ID: <20260603205152.1440291-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXy+fnpJ7L5tuc
 iXu8AQbe08Exv0b8QZXhWoXp2GHKThoheJsz+lyKl0iAwp6cPZYd8aelHC1IKrKZGlUTQ8C6IVo
 tvqOIW2mCyjtzcDb94i5oOAjYib3bg7zMceAxZoFmdXLGADcyQCieKVxZboDDA+MgVLMhbeQV0g
 +K6rHhAdHeO4leDHY116A2Y4Jn7f0vRRNmCuU0Witex26U+i3YRTlydwsNY9zb4uqCbA/m/Yzze
 SgRzI+qheBnfaERZJ08E7HsGYNKYkB6QJiJkL/eW/Bi/CkOSowwNnLVscssBubwy8OU1PN63aSP
 ozuLJ/fykS4Qcxfht9o5bueE4NASciFOGP85di5yLWIERsZcadrQqJq0XYOBY4BHhTFfEpKXekP
 5mTdvjCLkFm9BRetn8iCveai5sA4hp/irt32e4OFUMutLiJBhnzXzwQgcBT0wyo/8GYZkAYf4Ov
 KVt0y9ok6iS1ziS0qDQ==
X-Proofpoint-GUID: 1wtHugtqMnHfnI68zM1pP6qLcJRrn-6C
X-Proofpoint-ORIG-GUID: 1wtHugtqMnHfnI68zM1pP6qLcJRrn-6C
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a2093fa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=YM_NDQi6F0E_l5RYA_wA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         |  4 ++--
 contrib/plugins/execlog.c     |  4 ++--
 contrib/plugins/ips.c         |  4 ++--
 contrib/plugins/uftrace.c     |  4 ++--
 include/plugins/qemu-plugin.h |  4 +++-
 plugins/api.c                 |  5 +++--
 plugins/core.c                | 26 +++++++++++++++++++++++---
 tests/tcg/plugins/insn.c      |  4 ++--
 tests/tcg/plugins/registers.c |  4 ++--
 9 files changed, 41 insertions(+), 18 deletions(-)

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
index 217d6608c1d..1d5692b3f41 100644
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
@@ -145,7 +166,6 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
     case QEMU_PLUGIN_EV_FLUSH:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_udata_cb_t func = cb->f.udata;
-
             func(cb->udata);
         }
         break;
@@ -271,7 +291,7 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
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


