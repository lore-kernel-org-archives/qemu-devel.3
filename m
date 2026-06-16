Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15FCCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYko-0004oH-LH; Tue, 16 Jun 2026 14:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYka-0004Tt-1w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkW-0000Qa-Bn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOlsF397701
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8aWw34KT6c5
 IUtRKjPziAEK8iWqWDVoQjSGiZyt+f3g=; b=kYb0kTLeWjgQr99aMGFZWn62bk9
 +455o2KGk3ztaDNuKLj6loVIJi6hxMThlu9A/7dKsJpqZEF+uQB2xzRJwlcJHUJd
 zS2aXT/IGkiVGZ/OsJhLGoST5hkTBTDWrgpkTZIa/qbr8dNDCIuvi0EVW5PEvMP+
 s5vLK86/0S/IFRUSCR3hY1/oFzq/OFAjHs7fHVDK7Z7RV0GD0WEiDLNdRINifBTC
 lDjijSe3GRE72GIs9CosE2EPCyaq/AqqZnZqpjKtmaiC6+ALyuk25BdxVdnxIkYE
 wH5UjsneauIApV+fEV1z4VBNZFaQPCALd5jTO/wGncqqAdsnSPSIavNErWg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ety52uvpw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423f24dcedso5951653b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635368; x=1782240168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aWw34KT6c5IUtRKjPziAEK8iWqWDVoQjSGiZyt+f3g=;
 b=Bl+Wy4ICpFSd6do49FcBzlLXP7cfTtWWFaAfUEsfWrDcqTStH2VyyvYJONo9kqTj4i
 E9MocyqehFknqUAwIU0aUceXay8C+4S1TdjYbISSbKCtBUa5p6EJFsBktB/WKk167+qN
 z5u9yeHQQrM+JWRo05bQ7rL5fNNbUbtHIc/odaZevOZbYbeXxA3MbOXC7kTq8LDCvh9c
 L72E3NRNfGW6JrB2joj4MulKkXIFNaZu9ves1+o6pZg6ErVgpu6eQ9hYAIFcv+g2O+Ge
 j1vB86kbRJpDOnhfKC/YhheyExjIbb0lhRlm6f/+nHwwYb3iy/ZRDNt0eEyOmW44BVND
 FrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635368; x=1782240168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8aWw34KT6c5IUtRKjPziAEK8iWqWDVoQjSGiZyt+f3g=;
 b=i8hm193yAA4EWkR97VlFiX/qE1rYtxXbONmXF8U4+E1vYo08Df4jvy+l7O1vBvh785
 MY9bD7lOovK71Y9j9DbYsrno2pXu7AIAo7LpP+YiQKwciVNB+Iwe7udkBLIBNLfx617I
 KPk2PpKc+VuHrppZtaf2G7ckPQTzLfxeMYD8tBqiNDUehaFYAvmvejI55w2Gps7Z3c0c
 KUhyffgysSRcB3WqPoz94LJteb9OGo9GyU5QzpbZ8g1F4M6NS7Z+33m9NRMe4jXVz/k8
 gGypESPQ4cytkTDjH9Q2llQiZgV4MKkTjbKock8ylVnSl/RezM8RLusreC7zv5UykpMb
 mSOQ==
X-Gm-Message-State: AOJu0YznK+ritKA7p/MUFOmsKvYiU6kW/rpqtXvnPlxCTL/ngMgb8EPS
 GjySej4kxwGWd36YEdNRxVvqvg/4eFiKsCuXsXTzxUBExqynsySOcGmSMQ4FLSLg7tv7A35588+
 G0sTiDN21hYBxnHJgf8CswkV6dFd9NVknT4mgn5tpsc44OPgmixUveJea6gtiblubtK45
X-Gm-Gg: Acq92OExmTU9iTV9HyXgGQiHyfeVM00ucnbClgzdWMKetVJSZyP3WvaqOuAeE/eugh6
 8yuKXLqTu2YnwgBaeyQ2xUOwi4KLGep5KJkoW9RoXEwCMS6itHTdKnPaPPxYS7qD149XY6X3cCj
 9/AAkIj5H7ANVfPgcVN8AQXr+MXFElm9hJtf8+wSgDXDAnT+33+gRuFugK5kFrTBynEjYahzMeq
 THg7PVU0snA4rJP0HhcFTPHovsqoFvTk2CDc4BsR9qGSh5PpZI+9hwmOQ0vl8woZ2v5kPS8leWo
 F3ptDSCDfrJybVUKotWwqcaUMtW6c1bvgJANNUE4qI1DRZIsYAWTzWNtWsKW4691DUwe5iQI4Is
 kGVZJdFxL1QNqUbx/6GTL/Lw8PbFazKF9vChi06nXe8xUjUGsAq+uKJOXUC0nfSgqof05H9GmIr
 X+v9pb6ns=
X-Received: by 2002:a05:6a00:10d2:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-8452445d6dfmr343632b3a.11.1781635368376; 
 Tue, 16 Jun 2026 11:42:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d2:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-8452445d6dfmr343598b3a.11.1781635367920; 
 Tue, 16 Jun 2026 11:42:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/26] plugins: add userdata to qemu_plugin_vcpu_for_each
Date: Tue, 16 Jun 2026 11:42:15 -0700
Message-ID: <20260616184230.303038-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXyeuoSm1XZ3b6
 FP0UN4DIUSCnv3AR7aMFfdgreoruXpTVTw0gmOnBvE5k0fF6gwwlZ38OX5GHwj9g02K/LijzT+G
 rcr8OmfNQpxvk8yfkhVj+slO20Z/teQ=
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a319929 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6uvAROY9rCAfoAu75HUA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX+XfYTm+6hGh/
 PfezqARq92dw6wvC28d9w59UvP8bUJPWTuXR3L3PlyEDJ9851MNtUNoaxm7//B2+YW05UNEcXAw
 sP4ZJ4PXZ5+xY8McKSpRLVDwV2QTWNwkUU7ylts40nldYYt7v+2iNqt1ereIpHj5euYFbUgU96Q
 A+ALHJ9opwGzbOKay+/dtQl50QGwHfLWf1rGnCLxp+xyutq7u7MfwEd7dB08/tL2I0Ps4qZBgjp
 soz0/5B1+nBbD/D6jr596wGiouVqik3AeFM9EWIlFeRn35bjl++ZqfT0fAjvzNw3x1VOEdv64vs
 Wmh4oMIUaCKPGRieayda2MaqUr4djn3fY0nJddfadTGzybVmmzlE9POb3a3lXy+/25539pJ4ntC
 TJF1dkT8ORDPhz8aezufbGbSoKY17R7tdTKHf//JL7SaUW7sJQkVrGAfGakluHImMmauJIuY+c8
 HU5WF3aWTvsoBgL9Mzw==
X-Proofpoint-ORIG-GUID: LcWcCzjFzq_MoqgbWA0GI0Re420lbpep
X-Proofpoint-GUID: LcWcCzjFzq_MoqgbWA0GI0Re420lbpep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-12-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/core.c                | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 8c146ea49c2..320644a2f0a 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -957,6 +957,7 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: user data for callback
  *
  * The @cb function is called once for each existing vCPU.
  *
@@ -964,7 +965,8 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  */
 QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb);
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata);
 
 /**
  * qemu_plugin_register_flush_cb() - register code cache flush callback
diff --git a/plugins/core.c b/plugins/core.c
index 342357a7499..5b4ed0ce213 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -297,18 +297,20 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 
 struct plugin_for_each_args {
     struct qemu_plugin_ctx *ctx;
-    qemu_plugin_vcpu_simple_cb_t cb;
+    qemu_plugin_vcpu_udata_cb_t cb;
+    void *userdata;
 };
 
 static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
 {
     struct plugin_for_each_args *args = udata;
     int cpu_index = *(int *)k;
-    args->cb(cpu_index);
+    args->cb(cpu_index, args->userdata);
 }
 
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb)
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata)
 {
     struct plugin_for_each_args args;
 
@@ -318,6 +320,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
     qemu_rec_mutex_lock(&plugin.lock);
     args.ctx = plugin_id_to_ctx_locked(id);
     args.cb = cb;
+    args.userdata = userdata;
     g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
     qemu_rec_mutex_unlock(&plugin.lock);
 }
-- 
2.47.3


