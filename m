Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B9CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6Z-0002bE-Uv; Mon, 15 Jun 2026 15:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD64-0002PD-8u
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0001C1-6L
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxJFF781720
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QBs8hcj5K4I
 t44y13S9/c8NGqkWalfz+udaJQow+pPk=; b=FpjzWZhbbTECbbkIA7o69ONHfbc
 nqMB2TA8KjWYzpkcZm/ChC3lMOk7HqVCwfSFUhfi4j7ZMfBUfdUhxZBz6+hJhOfX
 sDxMHfKXCxh/gAD49/AER5r7McoDTS09ZxqvOyrbCkabvQLpTc+mqaj00r0PLdK9
 tgUWraElEPwc2snC7EuuMTJOLVntJUUZTruaNJTdDDRJli4GXXHrtN4d7V2KFzgz
 mpXsAgpmaflox9AB0PL6QpJXKWzF64EJ3LYPf92ceffw8GLf+KvEjyyIFEIAWPQO
 ZR0KYENrAmGhAkJcVYyAcuvKf5MOjq/HRbu98oE8ARAXs7JWr4mTuD129wQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtnqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:40 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139553dd8acso3745830c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552139; x=1782156939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBs8hcj5K4It44y13S9/c8NGqkWalfz+udaJQow+pPk=;
 b=VPG/XFmfYEst7SP65udcN+wIfXaESYU1WSuzAR4+To4Fv1mZCtOswOfBENForwH21l
 BlZsKeWwpdhMzFD50cXE+PCp/9hFJYz4g3UEaTooZlsZddHDJi3LIyG/c5jWofISRQUL
 9q6VezW/0bnRNpNOPxZRI4nstv/ycAjMTQD0hYnNxJvtUCEYRvfYnbjQCPC5qP7bP/I6
 d6RCigAQGXmWp7t1o7EV5xmBslKe8wMgLyH0pLsqsGPCJ90g9J6ZiwL/j+OjXlFidNqu
 6UrFwwJRL6cG2WlqjHTssN761E1f1DTRJSt5sEvirkWikfIc1JQrKY5kZwdYUlcu9pHu
 8n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552139; x=1782156939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBs8hcj5K4It44y13S9/c8NGqkWalfz+udaJQow+pPk=;
 b=ZFxoC23oUgkoNKeb3Qa7Wwc8DOcRkUe0eXRL886Xu8KXA7GlmVuQq7ADzMjtMEe9jm
 +G8MtWGMB0NQOg3Ob5m+7UCjGpJKpZesGg4FJBHQJMah3hkOA90lE7AgO7qAdGBGLO3q
 tutKGdY4EDsKMF/ERCXxulHvG8XOcndGYkdY0zeFiYKbhP20OwJBX1woPmV2Mlgqq40n
 rxeEmrB5FBatS0ShxE+PCbgjRTgkOTt06agXmJcoCDvnVQkjvm+gS4KyUFbv6EzrdG4/
 n6ZSU3/omgkKAflODXaUHnT9LwVqos2ZG4NcektyD08/5XoBNcYwvwj4Ov7eW8xaUU/2
 /nLg==
X-Gm-Message-State: AOJu0Yy+Q3qdCsJFepvTirYG38fGEbt/4tAF67vmllhNm8zh0G7MXf8b
 srzJWSVMYvYL2eZATnaNkGtGTNaIHN0w9qbtkcBHQM/05Q4jdBIM4P1W5ITcTifk6cfzV3rUOj6
 r/4Cg6XfspLiKaoOt9JieAeqijpaPYrVR6kzXjmXLkOOXhxX2OyQ5vSXal1u7hgDzbXuw
X-Gm-Gg: Acq92OH0a9rj4iMXerJjcQYyEKI8iEuzBxbiQ8PeTC+jgi0aqaslxtR3+CAb9scHA16
 8O6lJXtKKYo+QuRDTcMIMy27X8/Mmv96kO9xHj1kvCzZIaF2lne4+suL0GE8kHPXc0YLy5JlqGf
 qtoQhTVD6tDQQcvoQwtiDSQ636ksYerWXPB1FBWS5ew5Lf6aOhUmd9eLxoz48gNt9x43bZTRtLY
 9a7V6cAT8jFUtJ8IXfcGM9bfoLaZ0FVGDoIfXtP9TbaAHiU6Ta+nUs5MIoS7bhFq7gmgicqbl0L
 erfe2m8T0x2r521Sl4gP+mwLrTzjJFiSgGZpPx+S946VdOzIJPQnkflmaCZk1JJm6wfY7iqvgFa
 IxSaNK24TjYwBcD5rCJs331yA/8zU03lMxv6Okt0tKBQEbSuzIatLifMxAoXPrhX2MGCEkHwJKS
 kSdZ9NSA==
X-Received: by 2002:a05:7022:98e:b0:138:236a:c521 with SMTP id
 a92af1059eb24-13985e96053mr224970c88.2.1781552139458; 
 Mon, 15 Jun 2026 12:35:39 -0700 (PDT)
X-Received: by 2002:a05:7022:98e:b0:138:236a:c521 with SMTP id
 a92af1059eb24-13985e96053mr224946c88.2.1781552138912; 
 Mon, 15 Jun 2026 12:35:38 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:38 -0700 (PDT)
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
Subject: [PATCH v2 08/26] plugins: add userdata to
 qemu_plugin_register_vcpu_exit_cb
Date: Mon, 15 Jun 2026 12:35:07 -0700
Message-ID: <20260615193526.2883349-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX3s/UmbuKaLpj
 y9iunLc/VRctQzQ0wFrTAXkbAojEZwBizSXa6ICXaV1SFgPCHiDHkNgP7piz8wZo6aW9cM5dilo
 13BU6wK8Q9eeDWy/Wuzg2S1FNDllQT7u+4Ewbix9j16D2J+jIZHjCFDC02Qf5byNXo38D/Valmu
 22/sXSFXw1reh1SPrSI6B8aGct76n+t/lejpv4f7uWN7SRkeZRySFYeGunyHhZ5QmZ5vwsGGg8K
 Askm2g505SLXLmaUp7aLhGYfIjGPl0jv+HgRLDMUfjKyzkMkWLZvpp2nQjCdrLjQCnbXQKomHNq
 e/bQEYBa2IdZ03aFBLrL3Y2TVcOTrXNZGb9F2tjz+p3XnWYf3Th0tkNm39TVUd8q6FfgoPREMkM
 CBNgUvlq9tlOKavVBxOcI5oTKtjgU9vid+q4WOTpvBXOYrAFmwvFtEubZF1u3S+ygM/y9dunLue
 /Z9BuSAGqSixnhknq9Q==
X-Proofpoint-ORIG-GUID: xyJyBipzviRr1k_1x4oUVNADlq9owJ59
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX6ElRlzfoKpRD
 pYa4lsQPeonWbcz21M+wTsTLZ26SMOfVQA9IEolRjl6z3h1VAS7pbKD5CDG0GUhpSeQRpkxunOs
 rCPmshbxlUHDLSFD29cWS8j1MrLXIUg=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a30540c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=0jW8HPKGe0YpTzYbc6QA:9 a=Fk4IpSoW4aLDllm1B1p-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xyJyBipzviRr1k_1x4oUVNADlq9owJ59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
 contrib/plugins/ips.c         | 4 ++--
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 1290a624489..2c110906731 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -97,7 +97,7 @@ static void vcpu_init(unsigned int cpu_index, void *userdata)
     vcpu->last_quantum_time = now_ns();
 }
 
-static void vcpu_exit(unsigned int cpu_index)
+static void vcpu_exit(unsigned int cpu_index, void *userdata)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     update_system_time(vcpu);
@@ -208,7 +208,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index bb4569a2291..d4f8a99027e 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -257,6 +257,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU exits.
  *
@@ -264,7 +265,8 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
diff --git a/plugins/api.c b/plugins/api.c
index 68b564bb9c2..849790fe13b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -78,9 +78,10 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb, userdata);
 }
 
 static bool tb_is_mem_only(void)
diff --git a/plugins/core.c b/plugins/core.c
index 48db38fe924..c7dda9b2ff1 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
         /* iterate safely; plugins might uninstall themselves at any time */
@@ -115,6 +114,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
             func(cpu->cpu_index, cb->udata);
@@ -307,7 +307,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
     bool success;
 
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
+    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 
     assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
-- 
2.43.0


