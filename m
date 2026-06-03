Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40060CD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZa-00080X-Qc; Wed, 03 Jun 2026 16:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZR-0007xf-9d
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZO-0004Cy-1i
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653I6rwC1994324
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XhSPAuZ4gft
 1csafaJeDbNyucEwqasToONotZJGr0Eg=; b=XgnS6m69STaOWqFksq5GFMhJbGC
 VZiGr3GyZ6ScvYHlq69gdggu4PHCBcGMWZ16uOGfkMl0LS1m4zBdXrdNfgUy4fIK
 V9ijmZ0TGdRbKKKGMl/bXNB+JWOa/50KR4MQS6pa8ZfZoCl6sPn2/gjXW9dKhAFb
 qNlNxs93tYKHBGWv/nPvjz5LKItjytR0SYGIsoD1R+Pk8Tt9E9vUrWdswOViCb1f
 ftf5FidYoif/6ULxzEbCVPC1YxGs7fgsCxx2tC7NbHeTe+X3M0aOh0T17pjH3y3d
 C3wsybleZoZcmEZmvLod1AdC+y6x5DnFVkLKjzuCK11BWiaCtz9icFLRQ0g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8prknk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307625ee07fso1179639eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519928; x=1781124728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhSPAuZ4gft1csafaJeDbNyucEwqasToONotZJGr0Eg=;
 b=A0gJH4ca2i25VSMbKkxXPBGnOMFG+Hlj2JLOA/bksejVU9exDVBhwhvsoafB61t80G
 ebVPYKlYTZo0dyf0kBJAD9p89nYf7gXR8xpdp8vksFwQI3+ZRPUFhayWk4Cc/duYCX0O
 Ql+XXgwE15VkoM/vqrxGe+inpVtTPOplfJwG7UwpkzUgFw44bGeJiMgLKQdEAkdisY/a
 6Q64oEPffA3hVkoaaM78V2lovX+zNnmJqdcnKQlAeNRYDcX8h/TbtI0JYWWwEvkVPfuD
 0DQI3WrRrPWO2xjtRgisphstUQGWLBC5ONldGHHija8vF9GiCNMe1wgwBYps2MAtwRwp
 s2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519928; x=1781124728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XhSPAuZ4gft1csafaJeDbNyucEwqasToONotZJGr0Eg=;
 b=p5BU+pfsDHlrZJsivMTQihnJKO5U4WhqzcZQdII1bbra/DqC2bvEQpBEZcu4x0bLUW
 ZqUnp9zmTJat5muvsAqVnI8VZBKjZ860v3s7h5nbKP4/llVMlbcqk1/HA/G6veHOkBH7
 WqA4gD3NxuujWy6VET523rA2NhLLt0CH/vZKYNW4ZChZfXYfFQWdT+FV/DFDoznfzg+w
 Kdn/8pMM0vajLI2ld4exhMM3Wp/mq/O15h3AE6HutbGRfR1vZNOYxOn+8T7pY/i1k6nE
 BjIpIBuhduD5wNSP/AeR9gddETE2la0OaEW88DID2GHwTcWGvgtp0yB4ku5J/c2e1vlk
 EGug==
X-Gm-Message-State: AOJu0YxqgW3tN42NpedfEMEBWLBXRNDt/3nQ9UCnHdhVX3UAPmlVIVzb
 NHgrTR/22VIjbRFLSUBCIYlt24NZPZO+fwygBCsvhnGLli7OmsFVzNU3I2GMCFXuOVj9ThVSMx/
 7UHUn2a+aaeccj783VbLmYVlJtwwuKBK30oucj/W8Wud070T43CQ/IJrIY7XYFdNLYwdq
X-Gm-Gg: Acq92OH9LnBB1fq5NCKQ4r2Qa/fmDZMniVWw9YO0W7/XddcJh4azYcjxxPi4cD9wDUA
 4BqKqJysvMjTcMWceA6dyvVh+aNjSeTT9tGddjDkZLRf6V9XXLQ4dmZ8ZdruRCsXzoTuMaUCDTD
 PBgYyrteO1mXuYZ30YC1mVlDLNqoxTGS9rJSH3Qtvu8BjSmS6WKEPMkwPJ/5iPcCFALFCCEIcKP
 ISkxmDTer6jZgEvkUD+yJkQ1HierziHT3IZUGQ5NNX5YSsK3wB9BgrM6enE+bK4FZgGK/lrxQbR
 dPviOj2PtAjXsKjk26iupzWRkso/lEw+SnlakllZ7MQdrhArwEQagu9u6/VxKB9qgbZoYD1Fhs9
 eqjxfSnpz8LLy/CXn0tUoPvuOIFec+Do0H5hr8Y0AG1uF/WJ4HrtPSohXSkk2V5zEsJypz9OpFL
 +HFKAlra4HTi7UQ6pS
X-Received: by 2002:a05:7300:3208:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-3074fbc704amr2807409eec.23.1780519927911; 
 Wed, 03 Jun 2026 13:52:07 -0700 (PDT)
X-Received: by 2002:a05:7300:3208:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-3074fbc704amr2807389eec.23.1780519927403; 
 Wed, 03 Jun 2026 13:52:07 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 06/25] plugins: remove qemu_plugin_id_t from
 qemu_plugin_vcpu_simple_cb_t
Date: Wed,  3 Jun 2026 13:51:33 -0700
Message-ID: <20260603205152.1440291-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zqorllA3ZpnYSePgN7ufXYM6QYoo9qWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX0be3MlOAZr6k
 IBdMlcpOzkXHrnVAkBogxNdGrJCpTRQ3RpCWFPsDyQfaSfkvI8bdFZRCEsp2vMzKNcE3RZnYtOh
 54v3AZajhVEijWGnTE1q5wvmXtmBXNwCTW8KENsLiOqi4XvDpP4vykg3jagtnSNts3VlGVSFu7o
 PCGlrVIIiunlMmenXdjPETT3KZ4gyGCTt4wf0tdAwp5gOGb7tHtd0uWtJntJ0FFZv8hb+3zqeeo
 IM2o3oY4/BAhPTf3apGehFMEt+GYum5TaNK1b6QGNxoFlXlCzLaaIoTTIPHxWkKHtRxMJHnj1Nb
 prgjJTfiZYkzm9BKwYHYw6JmyDD9y/+6b/4QV2FIcZ7jKqMPHhUSwENs/WT1ZwNZmSfHaDGDS5O
 ISzMuVeog1iENuDHXodUYlJJTbj5HwoC9sO9HuTOCbAfNU8xzVhWD3T/SKEaaYSu4E/6aUrQ4+e
 P/2/JXlfa41t6gGjUpw==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a2093f8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=rXe6YV4CopgQa2I4tT4A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: zqorllA3ZpnYSePgN7ufXYM6QYoo9qWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Not used in all our plugins.
Future commits will remove qemu_plugin_vcpu_simple_cb_t completely, and
replace it with qemu_plugin_vcpu_udata_cb_t, so id information can be
passed using userdata if needed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         | 2 +-
 contrib/plugins/execlog.c     | 2 +-
 contrib/plugins/ips.c         | 4 ++--
 contrib/plugins/uftrace.c     | 2 +-
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 6 ++----
 tests/tcg/plugins/bb.c        | 2 +-
 tests/tcg/plugins/insn.c      | 2 +-
 tests/tcg/plugins/registers.c | 2 +-
 9 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index f2b1b258a90..72cc896a0a6 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
     return qemu_plugin_scoreboard_u64(bb->count);
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     g_autofree gchar *vcpu_filename = NULL;
     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d347ac25b6f..398aa4a1f3f 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
  * As we could have multiple threads trying to do this we need to
  * serialise the expansion under a lock.
  */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     CPU *c;
 
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 7614ae1eafd..32fd86c87ac 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
     g_mutex_unlock(&global_state_lock);
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_init(unsigned int cpu_index)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     vcpu->total_insn = 0;
@@ -97,7 +97,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
     vcpu->last_quantum_time = now_ns();
 }
 
-static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_exit(unsigned int cpu_index)
 {
     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
     update_system_time(vcpu);
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a071a34ea75..438cebf2831 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     cpu->ops = arch_ops;
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d7d972103cb..8aaf404504b 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -149,11 +149,9 @@ typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
- * @id: the unique qemu_plugin_id_t
  * @vcpu_index: the current vcpu context
  */
-typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
-                                             unsigned int vcpu_index);
+typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
 
 /**
  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
diff --git a/plugins/core.c b/plugins/core.c
index b0532e8d0de..217d6608c1d 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -96,8 +96,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
-
-            func(cb->ctx->id, cpu->cpu_index);
+            func(cpu->cpu_index);
         }
         break;
     default:
@@ -306,8 +305,7 @@ static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
 {
     struct plugin_for_each_args *args = udata;
     int cpu_index = *(int *)k;
-
-    args->cb(args->ctx->id, cpu_index);
+    args->cb(cpu_index);
 }
 
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index 8a854408aaa..f29b466dab2 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
     qemu_plugin_scoreboard_free(counts);
 }
 
-static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
+static void vcpu_idle(unsigned int cpu_index)
 {
     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 12421054f67..80f7cbb2967 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
 /*
  * Initialise a new vcpu with reading the register list
  */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init(unsigned int vcpu_index)
 {
     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
     g_autoptr(GByteArray) reg_value = g_byte_array_new();
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
index 6d627c70371..94776d887fe 100644
--- a/tests/tcg/plugins/registers.c
+++ b/tests/tcg/plugins/registers.c
@@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  * registers that cannot be written to, which would fail the test.
  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
  */
-static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+static void vcpu_init_cb(unsigned int vcpu_index)
 {
     g_autoptr(GArray) regs = qemu_plugin_get_registers();
     g_assert(regs != NULL);
-- 
2.43.0


