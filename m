Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31105C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhj7-0007oF-25; Wed, 19 Aug 2026 10:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhix-0007lj-VQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhiv-0000Sa-6u
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbv4U483824
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LN/PuTlUMhyncpHtTbGbDh8uFDhQHI1t9gAGtQTvIiM=; b=pCLu2JV8v7PljXfG
 P5GPzu+UXUuQIeXb9eztAUfMelcuCDCU3WSg+Tu6wyK4MkZiKlMtTHeL1h9ZLMDc
 CrRs/11QJmi2eQHT560QFRulK2OfGuhTm7vEF8ujpZVWS+LYySCA44XNi0q//SN9
 5hPKaIbe8qaCbODJw5hMGEFMhmMSCNwm9waqtFruUNHZd0sUNOp9kO3RRGzo97L/
 A363C1tPNgZiSRfM0aQ8j9FBNq4PWJlLBfi5Z6VAKNyKZ2JROvkEC8OG63xs+SVU
 8c2mab2xxcC18lWYGLFuq5UKdmGmh8AQoJnuO4WZdtfE5+KSLGBLhkWbLOkJazKa
 5BP9Dg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfnbsq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936d067836eso142076085a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151419; x=1787756219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LN/PuTlUMhyncpHtTbGbDh8uFDhQHI1t9gAGtQTvIiM=;
 b=heJk36rRGUgYi04ue1sQKC5WM3uA6cbsirbOHl3in2CQEpe2ylLW1ye9Acmy30Detn
 wUXvZWvk4LnNo7vaH46wE0tz1G/tEQSNOKoJVAr0qKkl4xfWsAHPBq59+m8hqfb2ycoW
 dvC3q5EQkEGAG5QkIQUZ+QGag8TuP/g+lxkQJVWPTvUcHpdaH18Zw5WG2mi2RJKeiCDs
 o/FEKnffEEIqBR0d2NIOUKfBYSAPosqxkXBprMx1bV2nk9hheHkxJvyy2zEIk4KWxl+c
 tRagMVFVjmpEpcVIflWKVS58C5EWISEbHYVKtg2nM5qZHYmODzkqwhv5VRc2lr2mMxxu
 GXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151419; x=1787756219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LN/PuTlUMhyncpHtTbGbDh8uFDhQHI1t9gAGtQTvIiM=;
 b=GvvxgFZhB3gkVzvSG3wnrnb5Rl0mL8ThvaOn4RWGfqNpoeR5V6e3Px2FxK8wMF93fz
 B+CzjZlmNyxp9eCGpj5f1sj75b6+2OSlVvuR9J4hdmxA1dtodA1DDM1tTZZJEsjHqk1X
 PUNQXVjAS86rz7N87Ck6VK+wtMdmQ7gKvzoYY2NRPVf6PoprRFv2flAmbIR7UQm/4yf3
 s9zdnme/TSa2cRO/H0g3nYvmEkWdhmxGRAxPW1efYO9a0fb1N/QpDhEkoL56AB1JoEwx
 sXNRUkJOheRP8YmCfUAGntdHDjwTQsLSHqT59keV+ZeqM42nXsl3djThMhF12z0E5dIl
 O07g==
X-Gm-Message-State: AOJu0Yy7cNg48K/PbvpPUdPS+lFhCriNr1a5axtBrwaLhzvzL+iozCh0
 qLJ27pchxdpsrhJorUv+5orRwNb1J4K7zAYMYu5MvHfrLroST5hIQi0R5k9wdUZc5IsPlRkjDo2
 UMFEJ/mbF+2M+gpRwCFnQ36rHLFJqPYdl9UH8aH8ftqvH88d//M5s9MifMZ9oFWVZ4qYY
X-Gm-Gg: AR+sD11REwNHWbweQcBBgyOLvJu6vIQJnbcV4iXMtN+zS4Mihsr2xe52O8NysDFbGsA
 Tc6YxTdBxu5G/924PXIM50o+70dcyii2C8sE+88/t45fDOxHUe42W2HfOnaavSEtCOQSP80taB4
 HcQSJcD04Ph1OlmB5V1XTFurtCjg3tZvooJIlY+kRGNTmOEAFncdnAXykaSLQEG9psOhTMTbjyR
 0mt2JO6HPZuVGq0lxOBqdfyeWqUayVe9aSRJX5dbsv83rCGSsoh3fQUBRniQmxMNd/FcvYP9y/1
 K0TzXcw2mZCRIp0i9Jk/EHjdtZtot7GUVF5EK9OrmNNDZQFbfcsBx4c+dylr10ncsJ/EqHHiB9e
 Rf5XSnLaCSZvNPVbGs7pntjDq/dyVTgfJFwBSLDPRVw==
X-Received: by 2002:a05:620a:2a12:b0:936:e4d1:fa2b with SMTP id
 af79cd13be357-9371e6b762fmr471976485a.44.1787151419398; 
 Wed, 19 Aug 2026 07:56:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:936:e4d1:fa2b with SMTP id
 af79cd13be357-9371e6b762fmr471970585a.44.1787151418892; 
 Wed, 19 Aug 2026 07:56:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm6877488f8f.5.2026.08.19.07.56.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:56:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/11] accel/tcg: Rename for exception codes named @ret as
 @excp
Date: Wed, 19 Aug 2026 16:56:39 +0200
Message-ID: <20260819145649.23439-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QedWeMbv c=1 sm=1 tr=0 ts=6a85c43c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_j5oqwj-hJjEN08MGkoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: KtYXTf-pqkFAAUxLUNEFEhxDCUPo5a2i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX4b4+hv6SpCzf
 tbFFYya6B66fP+dWn0seHBVAwUC8iFfr23toWvyXyaWN/HXOuigAG85e7LCu66Gm9G00ggUZEe8
 3DntxlS6o2mDTxne45o2K8gUoa/ysVU=
X-Proofpoint-GUID: KtYXTf-pqkFAAUxLUNEFEhxDCUPo5a2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX7oHX+HluUjGk
 Bq46rsVZV35G918OMhX0BetsepCF9SfjXKKOeJwS0mq6d4Isr1nTBHXrLsWOwxH5FAlmTCh/qjK
 T6CVYW22NWWmHcpNGuB8JTVHLhKOM7mKFWKwj9Lo5FmC6eFyjsT6JdfAB2F2UPcLES3syXGko+8
 K3uUH49IjDRClThNoQcsovjj0LNknXpj1XQ8g/o5tTjC4weExyK2N/rqxFljkHC5DNKZCGH5dEh
 cEO8odgbXBExjFfl2LCaaQT1hKcTi1UQF0do8VK4iA0UR3YBlJnpdk20HFydcBXsNrEDUq1AgNL
 Pt6EjQQ5ODYjfochYWFKfEvff8EvQlO8o9PB4E2BjTjfQ2Ta5KuKGLnXuteOtN0Y0LpcMHRkt7+
 XfRXFRIUfGFCLKzUs53hDUW7d+ibG2Tyq5XGqp1l+WeIAerI0aJ/VIY2BTOLQjgzBts0ucm45PG
 22/USjLHYvYgZTDaVVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Rename meaningless @ret or @r variables as @excp to
directly denote the value is an exception. No logical
changes, purely cosmetic/clarity improvement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c            | 24 ++++++++++++------------
 accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++---
 accel/tcg/tcg-accel-ops-rr.c    |  8 ++++----
 accel/tcg/tcg-accel-ops.c       |  7 ++++---
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 257211235db..53d90c400d5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -687,7 +687,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
     }
 }
 
-static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
+static inline bool cpu_handle_exception(CPUState *cpu, int *excp)
 {
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
@@ -703,8 +703,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
     if (cpu->exception_index >= EXCP_INTERRUPT) {
         /* exit request from the cpu execution loop */
-        *ret = cpu->exception_index;
-        if (*ret == EXCP_DEBUG) {
+        *excp = cpu->exception_index;
+        if (*excp == EXCP_DEBUG) {
             cpu_handle_debug_exception(cpu);
         }
         cpu->exception_index = -1;
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (tcg_ops->fake_user_interrupt) {
         tcg_ops->fake_user_interrupt(cpu);
     }
-    *ret = cpu->exception_index;
+    *excp = cpu->exception_index;
     cpu->exception_index = -1;
     return true;
 #else
@@ -738,13 +738,13 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
              * raised when single-stepping so that GDB doesn't miss the
              * next instruction.
              */
-            *ret = EXCP_DEBUG;
+            *excp = EXCP_DEBUG;
             cpu_handle_debug_exception(cpu);
             return true;
         }
     } else if (!replay_has_interrupt()) {
         /* give a chance to iothread in replay mode */
-        *ret = EXCP_INTERRUPT;
+        *excp = EXCP_INTERRUPT;
         return true;
     }
 #endif
@@ -935,10 +935,10 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
 static int __attribute__((noinline))
 cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 {
-    int ret;
+    int excp;
 
     /* if an exception is pending, we execute it here */
-    while (!cpu_handle_exception(cpu, &ret)) {
+    while (!cpu_handle_exception(cpu, &excp)) {
         TranslationBlock *last_tb = NULL;
         int tb_exit = 0;
 
@@ -1006,7 +1006,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
             align_clocks(sc, cpu);
         }
     }
-    return ret;
+    return excp;
 }
 
 static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
@@ -1021,7 +1021,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 
 int cpu_exec(CPUState *cpu)
 {
-    int ret;
+    int excp;
     SyncClocks sc = { 0 };
 
     /* replay_interrupt may need current_cpu */
@@ -1042,10 +1042,10 @@ int cpu_exec(CPUState *cpu)
      */
     init_delay_params(&sc, cpu);
 
-    ret = cpu_exec_setjmp(cpu, &sc);
+    excp = cpu_exec_setjmp(cpu, &sc);
 
     cpu_exec_exit(cpu);
-    return ret;
+    return excp;
 }
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 69560fdb9d8..e7edd1945f2 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -90,11 +90,12 @@ static void *mttcg_cpu_thread_fn(void *arg)
         qemu_process_cpu_events(cpu);
 
         if (cpu_can_run(cpu)) {
-            int r;
+            int excp;
+
             bql_unlock();
-            r = tcg_cpu_exec(cpu);
+            excp = tcg_cpu_exec(cpu);
             bql_lock();
-            switch (r) {
+            switch (excp) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
                 break;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index cdaa3e11808..d6c2fc019c9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -277,22 +277,22 @@ static void *rr_cpu_thread_fn(void *arg)
                               (cpu->singlestep_flags & SSTEP_NOTIMER) == 0);
 
             if (cpu_can_run(cpu)) {
-                int r;
+                int excp;
 
                 bql_unlock();
                 if (icount_enabled()) {
                     icount_prepare_for_run(cpu, cpu_budget);
                 }
-                r = tcg_cpu_exec(cpu);
+                excp = tcg_cpu_exec(cpu);
                 if (icount_enabled()) {
                     icount_process_data(cpu);
                 }
                 bql_lock();
 
-                if (r == EXCP_DEBUG) {
+                if (excp == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
                     break;
-                } else if (r == EXCP_ATOMIC) {
+                } else if (excp == EXCP_ATOMIC) {
                     bql_unlock();
                     cpu_exec_step_atomic(cpu);
                     bql_lock();
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 560fe2554ba..9c3d2214162 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -77,13 +77,14 @@ void tcg_cpu_destroy(CPUState *cpu)
 
 int tcg_cpu_exec(CPUState *cpu)
 {
-    int ret;
+    int excp;
+
     assert(tcg_enabled());
     cpu_exec_start(cpu);
-    ret = cpu_exec(cpu);
+    excp = cpu_exec(cpu);
     cpu_exec_end(cpu);
 
-    return ret;
+    return excp;
 }
 
 static void tcg_cpu_reset_hold(CPUState *cpu)
-- 
2.53.0


