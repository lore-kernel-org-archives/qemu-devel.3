Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1E7CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6h-0002f1-QC; Mon, 15 Jun 2026 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD64-0002PC-5c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0001LA-5g
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxEKP861125
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D2WZShCxOeB
 Mbg6JyEuHBQvUsRPOhsAn5CaloYZ2nrg=; b=E1Hz4yI6xlD77KewWoIHp+BVAD0
 bIzPKs8s4GkwoJoOVBgHFzvOwY+3K6X+VbVx5UUS/fWVLxFFeckQfz+YvG0nN+7S
 VjWZ0/n+voyyma9eEj0vFg/zJKdOz3Dg68iiK8lwgjlb0xsR333CkzMN9A6MdJn2
 qnf+hSqgzLybWzYvbczDW1EYFUvjqiOaQTRnmpDo4j9MJbQSaPEVMu8qWppfeDGq
 jmSCQ7qv3AWUwnOz86hg2xPrFZYJd8lKGwIGfFILOnuabxyDbE525ZvdracgjA6O
 ST6rF6oxEpuqU30UmS0TbgW0SV5fHvhMEMQ/NZoDDG+svery3QduhWdmACA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydaky8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:42 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1382f39e4b5so2455222c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552141; x=1782156941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2WZShCxOeBMbg6JyEuHBQvUsRPOhsAn5CaloYZ2nrg=;
 b=Z68TOeQvw8AxL5IsH8evsqGEG9cSS7tLdE3my+yki2DDqPAUqaI/KGL6LMb/aIuekV
 jdE/Vf7I5PCb/i1AHnVefodtwT9QHr/GaT8UG3F0kcz+7dPhG0Krs7q7GfMKA8AD1PCK
 u3aUKAS/F0dGh1f012zLft+9MKR4iBkFoFddIxgxY/iObq1pzHcE5r2L26FRuRUc01IO
 G+kA+CEbUMtQd6VdgAkrTZEzI3DOw/1pUfqZDABmUYzg0TFL3q+C9fcsJIwFJb/kfE1R
 +XklXBnToRGKWk2In6ZU9v8uV6OuozMhggC5xlE+YnfKjG2xfzRhuBsHVVAPtNK+pz/1
 SS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552141; x=1782156941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D2WZShCxOeBMbg6JyEuHBQvUsRPOhsAn5CaloYZ2nrg=;
 b=GHZWRvhaM2/LWEhasAAUNHgL7Z474foqhMsHcLH+tEszN7aV9nviKi5BPhSuTQJWDI
 DUd7+PbCR6uFvsAoykmehr0OwxBpNnxlbPZoKkwEeG4TLqvQsw+pBYJhJg0gQxt3umEF
 K43po/C3bzcEqq7ftjdkcybM6QinEe5hSvC9g+Alk11YPWjwR69b0V0hG+/t2MjaAgeS
 +OnrCcZIo7wSssS/+W/tezfyRP6MCFQs0LN+tZbsW+hHbb/C+TcopGQK/ypqBm7NU6LT
 /vABgrDtlFN9lWaBHry/BlkMQAD/neJZn6vy+E7XPyn88NIkmj/zL3pxt/spEchS688Q
 2QZg==
X-Gm-Message-State: AOJu0YwrY+O1ml+X3uhi+9ag1a8AQ0Z/wGHc7ygi1NLZIpSD6eC1zbhw
 s3EssSMucF5AhWBaz1aybio7o2oTwF6Q5kEVvIba0cglc6xqMdToC7SMe9uNEbjQRCkExgoh5fi
 4T5Pb6jOvl9rZZfDNrlwKUqgepWfLZYARfqTw3v65Pd8wAqAxm/lZd6EwQL52lGeIavYY
X-Gm-Gg: Acq92OEVQyFqMcvWkNoWn4ZVq3i+/xjYUTNrBjEdXLiFbsuqP/bH7lGnGi1Eya3D4NN
 OYYGXgdVqTGuJYW+K88xLZne6uU9aLKGPYS5/mRAA9bfxxBW4pHl+zXaXMTNsodRQ3IH9uA1NyM
 xKa5mfJskAOrWGZVjWuSIVDRLhS1dlaooBhX/hvnKnbbcymxeSrIuCqtMrZv15IXzohYqbgL3Te
 vl40A2MH/FhoZRN/npjnb4G4fKtCfz06awBzHSVZP1OkOlFA43F/Y98eyOQzBrnfce1uYfM5NLZ
 cJyWXPegzexDAluKlYpBMskGAmVbpzu425o4aTSCjy7lbFI5H7pkzcBryjm5Bx1Vuw5rjar96Ca
 mYWjQEvFexXdR3AV2UA5reGU8qEvYbCitqbYbFbIDk7lPvo9EpMJIGJmHtF2pFDpOlR8r3h8V7W
 dwqpQpbw==
X-Received: by 2002:a05:7022:23a3:b0:134:d3bc:b4b4 with SMTP id
 a92af1059eb24-139857b9d3emr400302c88.4.1781552141433; 
 Mon, 15 Jun 2026 12:35:41 -0700 (PDT)
X-Received: by 2002:a05:7022:23a3:b0:134:d3bc:b4b4 with SMTP id
 a92af1059eb24-139857b9d3emr400287c88.4.1781552140840; 
 Mon, 15 Jun 2026 12:35:40 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:40 -0700 (PDT)
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
Subject: [PATCH v2 10/26] plugins: add userdata to
 qemu_plugin_register_vcpu_resume_cb
Date: Mon, 15 Jun 2026 12:35:09 -0700
Message-ID: <20260615193526.2883349-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a74k_CIUTPJKlFVrIVQnX4goNKGPRbNT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX3FL67L4mCBRM
 i63fP7gbGCQxNMiObbbnU4xFHE09yOiajnEX7qXtyZUp1Lu49m6oPww31Xuy2+taHh6K014Zlv9
 E6q1E28xNyrNgEiU2sZsOcSh4mKowQw=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30540e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=jbUUBHnpNWWeZ8W5LfIA:9 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: a74k_CIUTPJKlFVrIVQnX4goNKGPRbNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX6yjblwIzV/wr
 BstuYKUpfKGZztZXVUMfh1bm0vwMKvoh1K63sHMtHuEq+pPohUrYaC5sZC6Q2v6PJsGIH5Q53Vk
 Two9/RrQWccrsvI9XnoRM9HLT5NcouDkdELO5ttAyA0y5NMiisU9+b1dr9UXVyGJA3eSU2iJEyo
 J2HIXv+COpcRgLxnWfzeUFxdXXV9tfwGMO64XK7JEW60mMVgFoMOW9hwhPuhGIC5vTjgO5bix00
 4nNHiP/esvg0niFTvwP+nmc+0J08d6ULklLN8AI7asW4GlckhZFelyORajmG8EBI8YQeGMPYxSE
 BTF9ehpWWmR4ztp8qvluZ8juVwXCdfUgLdhOCv8V7GdFe9OfbA+UWsZxcuNxve7UP1YDsJEUjdx
 6Zn0p8JPcoFFC8YPyZM3p9+LIsCYYoud+QbHET9bg9U0s+rpztFJ792vAsfyiFYmNC5OYiwOwn0
 +Li4mHVBPsJzgh16DMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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
 include/plugins/qemu-plugin.h |  4 +++-
 plugins/core.c                | 31 +++++--------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 75d2a69a3bd..8c146ea49c2 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -285,12 +285,14 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_simple_cb_t cb);
+                                         qemu_plugin_vcpu_udata_cb_t cb,
+                                         void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
diff --git a/plugins/core.c b/plugins/core.c
index 47244603786..342357a7499 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -78,29 +78,6 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     }
 }
 
-/*
- * Disable CFI checks.
- * The callback function has been loaded from an external library so we do not
- * have type information
- */
-QEMU_DISABLE_CFI
-static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
-{
-    struct qemu_plugin_cb *cb, *next;
-
-    switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_RESUME:
-        /* iterate safely; plugins might uninstall themselves at any time */
-        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
-            qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
-            func(cpu->cpu_index);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -114,6 +91,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
+    case QEMU_PLUGIN_EV_VCPU_RESUME:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
@@ -636,7 +614,7 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -667,9 +645,10 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
-                                         qemu_plugin_vcpu_simple_cb_t cb)
+                                         qemu_plugin_vcpu_udata_cb_t cb,
+                                         void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
-- 
2.43.0


