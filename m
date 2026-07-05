Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC005C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrv-0007ph-Bf; Sun, 05 Jul 2026 17:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrt-0007mb-9y
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrr-0000KG-KG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxE4n2868067
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e9dI60VL+YjzzhVjIatuzq+x8DZHXeIawZtKVfZQSRU=; b=nfgvrMUT4coR8XiH
 oZDkTSqT9CNx95GuIRYLHM6TOc2gDpx0K23F/Pg4R9SCrgmrtIHdxbfbiKqt8EUu
 WBrP+t6lZR/pTqTPN1M5YQvPmf/qOi66F+JtYqU2w1XnoSoMwZCeljPB1EeH/hY1
 kPMV8XO5E6Y7oejpLczalRrLY4uNf1K291QtyldLt7NdtEX09SYUtgfUCFSrXVGi
 jL1ChzHjkLTEKZq2kgq2HOX0pGKnbXTCNHOQtKamhp/FHDnVDmpkVFSccocP/YJH
 dpVSgLyfBuM5A8s0E7NfIDXYQSxpYiqR3qV2ZBDUhUVGFe3WB9Kxgh6uLAtxGq+q
 hWOsvg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sum65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so228423685a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288752; x=1783893552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9dI60VL+YjzzhVjIatuzq+x8DZHXeIawZtKVfZQSRU=;
 b=FGtqf46jjqYcKY6SNfRJufl1Xk12PkcXgp1D4zkGUnUnM7bosxekRxvqS2sI6sYQo4
 SDOKuQZnAvh1T9HwJZFV8S91mgdciT9YLbaQeYcJ6eQSq8M3lpoxyDq7u31hSbjrx3j0
 jN1eAw02G35BhQMOyU3PUBYtkh6uA6RC4cCuXgKs1zCwOi8LphZQir7rPcMErD7IOO36
 5Vq1b7yLxuWrXfEcAQIg6N0WPAoLZ+Fc1wScVfslj+uelRAed+0TI12TCVMRAwAOUEI4
 6dDLUN+QXoCd5M2zrokx4YAZqrS68rKPAwgexhqaouRyjVf4QXoqeyufH17qoBR/0P2Q
 GNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288752; x=1783893552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9dI60VL+YjzzhVjIatuzq+x8DZHXeIawZtKVfZQSRU=;
 b=SWLuoNEyzAXkXXRKWTT9HCbQ2tjyTomf4MqE57fO1wzFvigu10gxcsxjk680tZfPfa
 yrcT9B1/mk7wNNZkkVFnuNVx0Rf6v5EUe80fibP7riQG1krc7WRo3PfWXd42n1jXJMYX
 0HFbRzYTPWfDhQVEqFlVCZuIhk4tKLAR0Qf9QUfj8KcqXfEbFc4PWaIgvuu6w3sRRNde
 tfIlT8FPwb2SS43Iz+4LIzW7Xgin8Mfdf+IHRKCSVIBEwNIikLkLv8f6l2c3vtTsXgdU
 Sb+RRZMZC+bSVJwWgJAXkiS9qttDvg09dA8DRAGg/f7WfN6XijtU3ItBRika5LKvINPH
 NGYg==
X-Gm-Message-State: AOJu0YwOhrrqIexA7E4jub6Qe3d1RBE2p3xXbbZKHif6tZRftgdQ5s79
 hno3n51vBxoQqtr2W3gNYfVRjY/SdG+rWDmXfCpa7AOewCS6oCTEqprycU27VMFmj60Xqp3aEoO
 Z+NNRyGTWd3YRuqcDus2XjlTlqIcan+7TX3mjcfi7NOGVMn8jH/iLcpuIs38A7b1zDg==
X-Gm-Gg: AfdE7cmHuBewKtnev4CO+CYQjQtkJg/JPgT8JtEPEKzuqa8RPHnZNL9R0xkvIQ6h4o7
 v6csoh+q1D9GI/qaUDuNrABEgqDLqrM5bJkjIq91gFyCXpLU2CojFa18eFSrrUj1vQ+vUkJ73cL
 qxbB6zSrK8zOOCt7EpowA2y/+vYdedeeSPkuP6dupMTphBxH+TQ0NhJUtKQAW6u6mV4p4YQmhAp
 tTQiafmXZvsd9q6JcMl3gx6ASj/hF+XwESFLt13l4Cn5BWXWxBD29DAxT5QHPQcQ3SJv9IE959F
 urogS8X6yTr9Oqec6gV95iy6MVyPF+HlK63rrzEdP6AUNo+0DnSPePIqCNDYl4Ynwv/BKbwfq8E
 sjKOPfC3wM/P713ze4aEFEB5Uo2cwS/G4L/sPoQ01vnCWKy7VDh2DF2nm6iBKqcFo6XPX
X-Received: by 2002:a05:620a:468d:b0:92e:8405:7ae8 with SMTP id
 af79cd13be357-92e9a343946mr1087960585a.4.1783288751181; 
 Sun, 05 Jul 2026 14:59:11 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:92e:8405:7ae8 with SMTP id
 af79cd13be357-92e9a343946mr1087957585a.4.1783288750736; 
 Sun, 05 Jul 2026 14:59:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm17947977f8f.19.2026.07.05.14.59.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 13/32] gdbstub: Move supported_sstep_flags in
 AccelGdbConfig structure
Date: Sun,  5 Jul 2026 23:57:09 +0200
Message-ID: <20260705215729.62196-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX/mvoEoJMz3DL
 KgfSd5BHadgdowA2MIlZ/7ff6WhvqRt7VqhExayy+N+CO27uh6SZxWQ0xHZnCvO6z0caav48BMa
 iUMjv9vd+/r6SA1jI7m0z8cG/BcDq00=
X-Proofpoint-ORIG-GUID: ceM6cqJ2oiacCtSi7UAKYq8LYQBZBVVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXyr3Xq8kHjBLo
 n5169/d+kXQKBzl2Z9S4XCXe+0USVgAUApfJwHg0iXkuE6mPMOGWhZnOBRytV5JImnQRX3+xSDw
 Epgdvp0HFoz4/1gtEll/LrRMPwWQaemEnxaXBcdrPUgqkvcI0MQyE8fgHUNd3aUFMacc8K89mID
 y2Up5sTqRDzISOCAeBFUJ062fXJf5GqLd9Ax1iutyVjePm3fMyvxNzWTOsNMcm531XeJrWM1QAh
 BE0vJw15tU1fNMdXGxGQ6iKHVfHXywoSZN6587lRfP7LRf2CJOmLslUvnFqLyQJ7jLDE8KyX+d2
 gqjoFRvTX7v/7aap0WLTTexSvpq8GspysYcUq1h57d/qiflmbGc0l5HGOmGhRVMWtQ6vRmTz/fM
 Qu5zepoRO7G6XaN3RpVCiNDXDl1cskyEan3b0szF9dyPEa3+4fR/1ikIIpFbA68dSJkpUld3CSh
 6V8s5PgIqZSqdjw2aew==
X-Proofpoint-GUID: ceM6cqJ2oiacCtSi7UAKYq8LYQBZBVVo
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ad3b1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-SUpAgEnhvh4vktFIKIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

supported_sstep_flags are per-accelerators. Move them
to a new AccelGdbConfig structure, still in GDBState.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/internals.h  |  3 ++-
 include/qemu/accel.h |  9 +++++++++
 gdbstub/gdbstub.c    | 10 +++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 60ddc146661..0444dee2246 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -9,6 +9,7 @@
 #ifndef GDBSTUB_INTERNALS_H
 #define GDBSTUB_INTERNALS_H
 
+#include "qemu/accel.h"
 #include "exec/cpu-common.h"
 
 /*
@@ -83,8 +84,8 @@ typedef struct GDBState {
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
+    AccelGdbConfig accel_config;
     int sstep_flags;
-    int supported_sstep_flags;
     /*
      * Whether we are allowed to send a stop reply packet at this moment.
      * Must be set off after sending the stop reply itself.
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda..052b4c59313 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -73,6 +73,15 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
  */
 void accel_cpu_common_unrealize(CPUState *cpu);
 
+/**
+ * struct AccelGdbConfig - gdbstub configuration for an accelerator.
+ *
+ * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ */
+typedef struct AccelGdbConfig {
+    unsigned sstep_flags;
+} AccelGdbConfig;
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f54415a9db7..06b712562c5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,9 +72,9 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    gdbserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    gdbserver_state.accel_config.sstep_flags = accel_supported_gdbstub_sstep_flags();
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
-    gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
+    gdbserver_state.sstep_flags &= gdbserver_state.accel_config.sstep_flags;
 }
 
 /* writes 2*len+1 bytes in buf */
@@ -1537,12 +1537,12 @@ static void handle_query_qemu_sstepbits(GArray *params, void *user_ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "ENABLE=%x", SSTEP_ENABLE);
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOIRQ) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOIRQ) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOIRQ=%x",
                                SSTEP_NOIRQ);
     }
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOTIMER) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOTIMER) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOTIMER=%x",
                                SSTEP_NOTIMER);
     }
@@ -1560,7 +1560,7 @@ static void handle_set_qemu_sstep(GArray *params, void *user_ctx)
 
     new_sstep_flags = gdb_get_cmd_param(params, 0)->val_ul;
 
-    if (new_sstep_flags  & ~gdbserver_state.supported_sstep_flags) {
+    if (new_sstep_flags & ~gdbserver_state.accel_config.sstep_flags) {
         gdb_put_packet("E22");
         return;
     }
-- 
2.53.0


