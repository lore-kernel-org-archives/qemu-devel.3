Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF34CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkU-0004SI-8n; Tue, 16 Jun 2026 14:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkM-0004Ni-Os
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkJ-0000Pe-0n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOtc0172554
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p/FeWc9woaa
 ModnQ0FQdUq35NUyOgS03oizq9HTmyF8=; b=laFoVPJZNX5IISkhjREKa3E7YgQ
 H7PO2pPFPN/rScw5F0XBkfCt/D+KwGxjgMnvK9RTc/dRLKwa2BdXpIXRPqPCoJ0S
 cD9WQHZP0JBbl1luL3GDey1deCsceD3UZ5Tj2kEehoF6Ef9lBmQS0Icd0iq7UPUK
 qo7yb1hdTTqpxe6ccfZCDTGNkkecxLjvrKj750lT9u1SNKbzEtYOggofBLHHHIR8
 oXbRUBqTEo19maCwi3rTAcGnpHexa6eZuOOjxbbO1Z1o9vyCV9rpuVtGgL2JOYJ9
 9x8mEcj0IdMib2BL0C2UzXYZiZteWas63RhPmWCDuJlJnk3nnR6/dkPunaw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kbhw8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84240b58211so3275018b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635365; x=1782240165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/FeWc9woaaModnQ0FQdUq35NUyOgS03oizq9HTmyF8=;
 b=PnAUA7xhwTxfiIRnCfQcXhp6jM4mDpLSaKyKMFJRScGmfXT73wIuTlsvcEwDRu2Dtc
 /Hf/Wy2kwvEy2CISWrEDha7v4fOcs+H6I5tYkr2j3+6uY6fANGnWyJ2//cyhFYqM8KyD
 MSFg0PzbvnkTnGWn7VJEc2YEAjPCiGmwOcQAzEYKco2hgmZGC06SN3yRyLJ908v90C5N
 xi/3G2/ywdGtONwA2d6JwvLQcxTes8B5JZ1UEr1/a/PcrQinHGyS1PZxN5whoSWEtW1I
 23qKaT9V1Z8u8nwtSYV71gV5i7Hi+8cuImOVe4O+EtaHikTC8YP8ypGdk6NhehIKIBCa
 nOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635365; x=1782240165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/FeWc9woaaModnQ0FQdUq35NUyOgS03oizq9HTmyF8=;
 b=MfuX8ssDSrP3RRG9sWYY4DNWcAUNzYVT7M32o0mHX2aZWlfBxQlzSfpgxnE1VtirNJ
 nVEXNpMy1KE9K1hPs7awGZg4Lte/F4NkV0EtOOXtodSNeLxGSU8Z5zvjNkaWL1SxCyya
 VB3hpz+HxFRUWk0uRC5eRiUHd+FPBjnjo0Hkg4HZoCURBNDA6IjfQuMiWGclpl7ClLcC
 XihRkVCKgzM+2+LCKyTfuIF69TPyE80DnT+9r4XdM5KLsIWDD602a5JGokpQ+ctsQYnc
 yfpjDDY+2PKuXIt+J+kkEOc/DJz4jota55Gla+eNmmy9sAW4pbck27J1qZyz3APQ4nuT
 33ww==
X-Gm-Message-State: AOJu0Yz13I6lvfJysfzmu9DZvO95xGPmjSNdmBsA5cFtjs/99vJHG1Iw
 S1a4EErfXyyx8qx7LaJ2nVqzYZrAXXOLB8kj3KtVzHLm0REkmpId/BiB5gccAaugpZjJMib5K34
 F6NB7/p6b/XQGydNstbI9DhTPI62EbdkTYVVIntx7YBcK6HSoGQ+TX2dawDG9tvgMooPE
X-Gm-Gg: Acq92OHr4PD60j6+EG2XR02b2H6TiDFz5EVOW4AtlfC/spyJuVlK1XUy11EVHkm53qU
 kVyfZsJmYuT+XK8C0zFNFmnYhkU7hk+zQ3nRNXYZBXJdAcueWommBZz8q1iIt35qIinMmnH29d7
 DkaVH/itrwjxDpGilm8SAGIpfd8IYyeAOmm1T5u9yZm1LtgP61sMc1FY6XcE78IAaeWTQteIIHU
 v+EXQjNGxPZGdaSUyCDCyJGU2RUpgHHuPJ6EksRW1wVR5w+WhoLH2iB2VJ1GpwO1ilRhVbUoUne
 EhuN76ljTFxd3T9fFnctskeWws8gyIRhiGJP1aATcqhXHx5KDSEvk6wsKuEJlZzTezMVNxPikg8
 jLBZ1drCaQ6xx6RALoE+X6LMW4uz30SfXlN4pxYTfIRdzI1Qvi9/legNAZsKgoWhvbC6fZzz1Ae
 VI0IbCt2c=
X-Received: by 2002:a05:6a00:94ed:b0:842:21f0:5114 with SMTP id
 d2e1a72fcca58-845245659c2mr321476b3a.30.1781635364636; 
 Tue, 16 Jun 2026 11:42:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:94ed:b0:842:21f0:5114 with SMTP id
 d2e1a72fcca58-845245659c2mr321456b3a.30.1781635364192; 
 Tue, 16 Jun 2026 11:42:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/26] plugins: add userdata to
 qemu_plugin_register_vcpu_exit_cb
Date: Tue, 16 Jun 2026 11:42:12 -0700
Message-ID: <20260616184230.303038-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0YxEYOTjg480
 WcRF13ED8wsSF+SN5xp4hEDLLSI41sZKZsqO6PG3njBsNIJ/ytJDul/dREv52dZ9x6BU8DRridT
 CGoXMVlAdpGHXkjLd+Roh48nwUW2Afk=
X-Proofpoint-GUID: 3z5yOEQANliZlLpJ2ijpWB9XYquxjawE
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a319925 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=X8LPHkEh1HOtIop4kdcA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3z5yOEQANliZlLpJ2ijpWB9XYquxjawE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0Bm8vaFsWGAb
 74YTn5bCEK/WFhZnuyIDMF57tzkQeu+gtZEinY8qJndSgsywfqVeoCrqUjLX63i38bn+Bw5BtTq
 0bY0tcGk1VMXPt82HO0G2CHTU/mHSm1jlPaOqdrd74Tl1QcCkAc8fZRDsTSa26YCGXSFiJSrq3+
 kkYUqs8Yp1mfk1g351orLLpFa5sE/XKRL4sW7G72/QKkq0OeCurpTvNpNrYJBLi7Bf73apY1ne5
 b947qr8ACgx2kOaF2dtOEMfQtAtHJ+zNbBxz3GuhKwLJTXT7wYGVDuu9/4Qj3g/cW0Td2uFOeFh
 qcmpHU1J2JdEjAd7cSDQeiPE+3aaEos4zLU8YuODztQHy27oaEfzA3h1K1qIBP5+Mwxe1DZiF7q
 p2lW82i3E5hpqLRl5wmhzzQ25znhQ5WkQOZJFGBSTjMQmjaHNaIuBJzEelvmmmhg9/NNmivnd87
 L4GjzeS6bUn/q4AQ0eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-9-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


