Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3DAC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwC-0001ok-15; Fri, 03 Jul 2026 12:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwA-0001kE-TK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgw3-0000E4-7d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIo3s498273
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2JSb3GKs+UbA4ySm8lGmjxcRTMIXk9HC933K4tfDCDo=; b=kSbFZubdpU56xiTf
 VOxb8jVn7+PfIZ8Zd4P4yG+LBv5FbwBVik/jvDQ1gKlKE+S6COcoBEqcuzrlOLjC
 JOpwZLwNEFkXGyfXq2C5nrgJCAMbTEimpmTOtah4vMROa+N6OZY26uxJM/Yif4a1
 zLBndBM1HGdYpsNx9vVgTDHPJ2axiNOjjYTEe8/YNWYaPGYZzOVVrZld63bzKXjC
 cCXKrjAZg7iw5DsuTJsR2YKEVYwgxQM+GIDuBjvbfAi+n49ZHVk9qJLGoQiiBJv0
 cG8ja1/Gm+tOivs5qcl+xckqTRd+g3z2M7Pv+HArjmZuX2KmikLzeh/JkCjPZjqA
 qyCJTQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjwxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915c364ae3bso65451585a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096801; x=1783701601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JSb3GKs+UbA4ySm8lGmjxcRTMIXk9HC933K4tfDCDo=;
 b=YG92/6mix8UcHkOoWtC2CKCyfE0m4Le57qfD/ReYZGagzReQQ5ikKYxqmEc1latvWv
 P/TBqwJ27/1tEjb1BdDJr3l6u3KXubIjADwKP3yE5DqpJimoUW17MxSHjnvhHqtzeWTy
 fPX94YkXvZBrY3kgVBlY+aftFrkXgJ5g2WYpzqtx5P6bHckqpRq3W85Buiz7aZVWXR1D
 HQo2soS2rEjn+cM3/+7E5vwSHh0z7Zlulwtt6bwDlpPvMumn76s5CG7xuCH7wJpLSPQZ
 +HdaVNkUPOiXDBZrIuu/5TDFTGzHfYxM2h66f0MxJi+KcDt0bv+kaIgclaLPzYtiNPDx
 F2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096801; x=1783701601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JSb3GKs+UbA4ySm8lGmjxcRTMIXk9HC933K4tfDCDo=;
 b=hjePQdzB6Ftt4aoPVua1dlY//+dMSJrf9sOMY2I2SuVbwvbxd8Igq+LL5vtEJbqTlj
 koPicft+VK6ss3U0F6EdDVtrpxkzZRHiS6lHg1yRW2KUv1eAzOrSVwfBcK+AgiDkMDTs
 FR4f+P3lvSRuyadsk5fjTP+v6Hju7tkVDZ4dIfY89M0khoOU0wCgJce4otBDelbLrk0J
 CiA1BR9nkFlgFVLZzFpJr/ZezihRsL3/MRM9RWAFO0kvbbS9D5T3uEOMj71W5oEqHwnU
 sN+7s44AtJTVSOyp5sloYhKNEp40s4DDdHQe+X5vghoCBG0eOk4zzRfYpifgXZ008ZTN
 5ZFg==
X-Gm-Message-State: AOJu0YzrgjVBd7H9YIyD5pRN8uPm7tRLUbo1Yk/XzPUQKNMgxW2aPJbI
 ZwtAfn9cNTDnjNIZSTzQLeC+47W4ndrtG2RHTQ9ufaiCRYDsoauZ25kBrBTWjsM50YhYm0cfAg5
 Nm8m+9CSTSaignRbUksnmN7+pli07EQfNM+RnYjRUkqk+Gatew3+/chfKKx6lRGJ2Zw==
X-Gm-Gg: AfdE7cln+R4sk/iXyHvcmmoKzOm1s78gFSLikQIjEYITg6c745zaXPDBac22n6rP7GM
 MK+u3dOHp0kQ0dMGcXIGbyaaa/4hgjFRc8K7d5BWAWvMxV1nsr21e7w4+GFwf1XiAYkeWFW4rG3
 LafbdS4LcRGZYAf5HTtkkTUBHc2PYS9oBYBMwovEASIejYFz1b1WPSryAOTIqe+4mxnhzGtzx4L
 7eB8fJyc96zIigYo0FKI9ghUHEjHZlMAJoYoVL81wUTZhv4pibCWYrs8pFq/PDh0AQqE0F8O8B7
 je7qEL2PZ4dLWZtUgflXNZsad42OEwMvtuAR2c2F9+629oFAkofTvHgM9sAQmRNajMdX2fQ+H5w
 mjieCnbfu1DrbVfDURbqpdmbzgX8DQqcI/UKqAq88w8Ph8s5WRpe584UWtUNnHqAOeGY3
X-Received: by 2002:a05:620a:2982:b0:92e:4773:5a00 with SMTP id
 af79cd13be357-92e9a4c57demr26624085a.48.1783096800682; 
 Fri, 03 Jul 2026 09:40:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2982:b0:92e:4773:5a00 with SMTP id
 af79cd13be357-92e9a4c57demr26618185a.48.1783096800096; 
 Fri, 03 Jul 2026 09:40:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm233534045e9.7.2026.07.03.09.39.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 16/33] accel: Hold @can_reverse information in
 AccelGdbConfig
Date: Fri,  3 Jul 2026 18:37:39 +0200
Message-ID: <20260703163757.55500-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mYknMUw2WU_3x2nXWEm7jk25nsONxI1i
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e5e1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SMEfN5HU43_l-HwGlA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: mYknMUw2WU_3x2nXWEm7jk25nsONxI1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXwXl3pneQYlx5
 XSxTWKrrDM0WBMHLN/bmtX8Srg1ed622LmVIF6GJHUD9ihYTlBISIfTKZBixpi1fnyumMF3e79b
 LRc5wqFbAslFJ7KemuBSb1dwD6vhp1zrtY2oxaZsDA9yWRK+07+rH1hpUaM3V5kG/xM5uqOw3pa
 0Z8gQDkkhDG3Wkx+hgmR02AHY7PHlFzYo1oqlh/xS8N2lT9uqvVOKqvPksELgTvGvLS2MWuOVpJ
 6WODdqoN12huhdPvltAWWKSYfbmC4u3+yTVaYwiaTVGduUpn8L63LPZKwyWfaZpCopqqE1HNej8
 NG+8imDytOMANuTLdIQlzgBNlpRD/8U9P7Zk10P2eHEkCs6We1B5W4CjC6fBttrJu8four9tyri
 BjVZxRc3RIgjFftkjQ7tAMXQB9vOSIhJdOapPtorGx4GnxB5IzUcR3023gKmv5YVWXhJL3Lpsii
 NuPWoJsxKZLe//Iaf0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX/Pa97hjhlLei
 bfHK78Pr5MOF4POFHOqGBeqEE/9guxQ9UbRpsLFWyL5Ox6f1nX4fsqkXL4Q5DRQMEqgXeVPY6V1
 ijpNCSY20mnJRFdZz/CaOAra2KEn3CQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hold @can_reverse in AccelGdbConfig, set it when initializing
AccelState in AccelClass::init_machine handlers (only TCG sets
it). Remove gdb_can_reverse() as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h  | 1 -
 include/qemu/accel.h | 2 ++
 accel/tcg/tcg-all.c  | 1 +
 gdbstub/gdbstub.c    | 4 ++--
 gdbstub/system.c     | 5 -----
 gdbstub/user.c       | 6 ------
 6 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 0444dee2246..0b74ea4000f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -154,7 +154,6 @@ CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
-bool gdb_can_reverse(void); /* system emulation, stub for user */
 int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3b01d55741b..8e0c3dfe088 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -77,9 +77,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
  * struct AccelGdbConfig - gdbstub configuration for an accelerator.
  *
  * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ * @can_reverse: Whether reverse mode is supported.
  */
 typedef struct AccelGdbConfig {
     unsigned sstep_flags;
+    bool can_reverse;
 } AccelGdbConfig;
 
 #endif /* QEMU_ACCEL_H */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d30b53cd3b7..79a8a08c768 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -158,6 +158,7 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
          * them occurring every time we single step.
          */
         as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
+        as->gdbstub.can_reverse = true;
     }
 
     page_init();
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6533d78b1ca..6aa7d8677f4 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1376,7 +1376,7 @@ static void handle_step(GArray *params, void *user_ctx)
 
 static void handle_backward(GArray *params, void *user_ctx)
 {
-    if (!gdb_can_reverse()) {
+    if (!gdbserver_state.accel_config.can_reverse) {
         gdb_put_packet("E22");
         return;
     }
@@ -1684,7 +1684,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
-    if (gdb_can_reverse()) {
+    if (gdbserver_state.accel_config.can_reverse) {
         g_string_append(gdbserver_state.str_buf,
             ";ReverseStep+;ReverseContinue+");
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1179c82cb86..2e8c457097b 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -479,11 +479,6 @@ unsigned int gdb_get_max_cpus(void)
     return ms->smp.max_cpus;
 }
 
-bool gdb_can_reverse(void)
-{
-    return replay_mode == REPLAY_MODE_PLAY;
-}
-
 /*
  * Softmmu specific command helpers
  */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index f7bc4e63dfd..299388b9f71 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -786,12 +786,6 @@ unsigned int gdb_get_max_cpus(void)
     return max_cpus;
 }
 
-/* replay not supported for user-mode */
-bool gdb_can_reverse(void)
-{
-    return false;
-}
-
 /*
  * Break/Watch point helpers
  */
-- 
2.53.0


