Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFBCCD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6Q-0002Uo-NQ; Mon, 15 Jun 2026 15:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002Oz-GF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0001EG-3p
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1afF1367854
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RJFWVPkG9Qr
 ZJmZNctfVzSlroAJyL4r2vLEikBq53Qs=; b=RpzABoCz0abvMPBdeIdej0/VJDm
 Kp0s70XFgblT7UNnleNZgWeVzap/XctOitbszLe2c5Cr+dvENyjyC38cLyK7b4q6
 go7s7w4GPZ3Z7DmuKRYMGvAAO9l6wAsOyUsyi4DnKn5Tje5S+lmnXLgs7lOSvtle
 TXFGTMnLQIrRZf8+1orBfGst1qmhl3uLwyaxRFZmJy4/TdXzhRvFo4mth0IhJQwO
 f42Sow3rCPt1s1QbUmmfSvYdok+Tfp7RhKpvnOANF3BRFAwmJyR7fbluPyaqlTyP
 W1QJRiLwZDHR2g+VYTrfIG58THelVSqcTrYGF5sbwuCsE99HJdAPZVEaTFw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegutnfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30b877ee493so1082406eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552140; x=1782156940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJFWVPkG9QrZJmZNctfVzSlroAJyL4r2vLEikBq53Qs=;
 b=iG/XrbcUYsWdiG2i2fBII5BZOKdQ8chOzu1bHspPVvThdvzHDf62W0PduuzaGCq0YF
 mT+qAXuxgFxaMT/To/vhaV7afhe1D+RsTckRCM6sYfKiahNRubCwn8x8OpKx8CBQECYd
 6u62VzgAdRmM4Wr2hw6Hq6zQvDLpIdmvFgr/WMOny2h2luXc6wfk/NaP9kFTKyLKvA2N
 7JMrTRMrkH/rP39jR7RPnRFdqrMvl/OhKwllgids4hOjTtncbp+CBNIssylk/Kkd6xJp
 MPWP1NeAhyp27Fnaf40jNcQTpuxmHI4QR1EmpRZryS2rrO05Dz6dVw8LA09cywCxj/TP
 2Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552140; x=1782156940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJFWVPkG9QrZJmZNctfVzSlroAJyL4r2vLEikBq53Qs=;
 b=qtStidMOGwr8rMqXj2MzjWpTPAIV4THnENaGYDIIk2wb0CUgtl4OC2Va/MwL/osN/i
 W6bsM04uyDnKZN56RJcecKuJVRPwlXu5jaUsJOeibxs+aTpAXHT6Wh4rkjadruarxxh0
 krcJPtqu28caqnGMtSOpKKRLGVjmDZTsad5rocJj2P/3iEbTWYdoaxr/5uvLGu/eZRIp
 3yECLp5KR/rY0uqHY1ZrPifSuQcMBkuWiJLcWMwvlEPfEmSBo51DLYkx86MjnChcZ6fH
 04XjGyJXq7AP2ayeT7I/8Ha44iqrIepbqyn5uIOikSWR2Wbnu4E8P4hWCOA9iYidHNFY
 m0Og==
X-Gm-Message-State: AOJu0Yyx4G+QJLeSn1orhNmJObgFTCI+2I27bflKYgCgcwAL6xhSg4Sm
 mz28Kc/JuYFItuO4i0yKm2d+bZXulebFw/BPH3cZpEPvJwDh/UJ4S1vIsVopHh0Hs1r/i08gsCu
 QqVfKvej6TtZcRQnfVELMJoLL+xFzaiPQ9qJ9vKVm3BpyE8THHca+Pmly/3CnqsjgcKnQ
X-Gm-Gg: Acq92OFluyQ9xTrmgNYPhwpxH4pUVAMoEEcLX10tFnjH+SD4c6mFNYwcsZhLL3aUQvW
 68l/sxebEn1NWlwZNpHYI/vUGxey6lLufAmuxLsboA56L7EdBJM1TeSKIy99g76K8kKPHw81z9/
 pJJFcFtq+g1YBccDyLf0UfGwm5g47wy24sITkLme2Bo7KIb9y7YF7/y12TwOo1B/uwkPWGKBcAX
 g12oKRGOiaBWqMReMPqUJvRzAhq9fTw0mJiN2Rj5CbcFilyPa6Z+9UnFreKes0rxUZEollO+som
 sOj8C/dXUKFgtQkFIq3zckOn4nMgK4tVE+iGOL06yaCeAsZwOGrfIyoXbywwNU5wAZr/jMR+fec
 A8Qj5Z6eGaP/k+2gwTbAvy8Thimnq3E9f1FfCK8epwkuPIrbZUsCLRRlGjJDCEIXqKI0+bbjc70
 caVWKBYw==
X-Received: by 2002:a05:7022:ba9:b0:136:aebc:24f5 with SMTP id
 a92af1059eb24-139857f4e3cmr408433c88.15.1781552140170; 
 Mon, 15 Jun 2026 12:35:40 -0700 (PDT)
X-Received: by 2002:a05:7022:ba9:b0:136:aebc:24f5 with SMTP id
 a92af1059eb24-139857f4e3cmr408421c88.15.1781552139679; 
 Mon, 15 Jun 2026 12:35:39 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:39 -0700 (PDT)
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
Subject: [PATCH v2 09/26] plugins: add userdata to
 qemu_plugin_register_vcpu_idle_cb
Date: Mon, 15 Jun 2026 12:35:08 -0700
Message-ID: <20260615193526.2883349-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX9i9LaFQ/XYkr
 yLivUNfI7DZN/qx7YEzhMPVj80HplgpI+I1tHVuQurtvtrrgDFyjzvgAW0FaJKOS9/ZLINHKv52
 /vT8XKYcB3AMNthVqJiDiNPHhWIYtyGVFKnYSfXdzpZYPSmQgQzZ0iPxQM+XjeAA46P40Sj/rWA
 JY5Qx3Kd4Q6TdoiFpoM+ZwWuMricvRRAb3c5Sq4YqworY8wzU9y37NKgObUM2cjwDbnRKPhCbY1
 eaEOfCPF3UE1ij/v/LDq3rdUID/Flgm3WJGRv0xHWDbtcs3wdE+PQv8GUDv/bwSViav9OG9SdVn
 Rdq3HbGS5cuLUKXMJBZyvP2hFpNJnfmQeFluxBGFR3epAilCTciY+hGsGT7W4YLKf16bpbKpgrQ
 syLDYnzrJClB8rFLAGIk/9KDRlZXWIAHlpc/tTDvQYRSAgLAFzn5+aRDzUx9YqwhkLfa52oKLSW
 OWuTTXLXu4395gvwyMA==
X-Proofpoint-ORIG-GUID: A6y5oF7SGxlLiV8vnNOLdrLlI2QBGjBX
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30540d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=1QjUMDCEHWFJ5QTWXisA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX9Zhlrxis0KFR
 d+FDT9GbVd1PTXkk28zdlhfq7xIP1Y1y5BMF3+/Hc8Plr9rjkZQ2zwhHgzta7ZdT/p/hBVlSGIj
 avpkB4vMufQen5uD8BSzvtuKXZHyvbA=
X-Proofpoint-GUID: A6y5oF7SGxlLiV8vnNOLdrLlI2QBGjBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
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
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/core.c                | 9 +++++----
 tests/tcg/plugins/bb.c        | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d4f8a99027e..75d2a69a3bd 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -272,12 +272,14 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU idles.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
diff --git a/plugins/core.c b/plugins/core.c
index c7dda9b2ff1..47244603786 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -114,6 +113,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
@@ -627,7 +627,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -660,9 +660,10 @@ void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index f29b466dab2..ba605246eb0 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
     qemu_plugin_scoreboard_free(counts);
 }
 
-static void vcpu_idle(unsigned int cpu_index)
+static void vcpu_idle(unsigned int cpu_index, void *userdata)
 {
     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
@@ -124,7 +124,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         counts, CPUCount, insn_count);
 
     if (idle_report) {
-        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-- 
2.43.0


