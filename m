Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D954AC5CFDB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJD-0007A4-Dj; Tue, 11 Aug 2026 14:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJB-00077f-Qn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJA-0002Vv-1d
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGNtpn407252
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=; b=W4ZnKQyGudgYfdvg
 vR0atE4NCPEQq7o7k8asvxb8GUNsw6UsNRq1w1ie8aV/r9uQ+/6NQ8PunjksLvy9
 SqsLtm8k0TT+OYSUcYbT986G07zFrTLzqoAfhEBOmU/n/xGvhmw8XcuuDDTWeIuX
 IBNefVyPdIgzAyQYTu7uy1HBwceQU9FCzm5CleyCTkzT04ZpyPHmB9phc2zsJOe3
 ZlAVXFYn/j7LE6rCwOX/U/bmuSN9qp6fdxmMCp3DF7yZvHowePkd+Z4U4xa01ipU
 uj83AZqLXjQnWjfgj3zeRkKV0lwSq7GxQQ0SHw2aAcOTfEyKneSkAdwHaA3kIohT
 HRyOJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g1jch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso1798531cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473275; x=1787078075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=;
 b=b9621XROuZhun3lhdxuw5YdS6OjUBD0My0UJLfeTgn9pBv6FhN8llC1Gsay5Lczy0F
 aFx1xGwMjJB06sC+BuSJqF77PsfB/tvTAkkWXPF4EPiF8ymah8syLdA5kc+gxO13gDPX
 uQU2GiaYW+j3/XggVPYysRmxZW0BrTGJnDRITvqNRmPeYR9tCUskAGjhBi4BTEbpk7s5
 slvIHKzJEhN/WYSMyOq3Uv5CR1HwYMyz6PDg4UZQZbvY+GQS6OVySJymfhRSYBeIw8//
 i0ityPWwJHNWTYUbeFFnVi5AymwHfWnRkpy7BkYM+AyBlzW1dl+MzP810SStAmZGKtDd
 QI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473275; x=1787078075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=;
 b=XprzgfiQIOxA4XTxIosr0PrWajzkH6yj33XXkOd6KTG2iLWnpY16fWJ1TANbWmSd9o
 3A1rWs0SAcOyUT/IO0pXTEcXM3L66/ST6UMcuwMFLc+V5Yy6mamzEV4EBFbntBulD98i
 t+6uYWpgplWJZEB9qx2MGJcTX94zViX0h9jDDsW52rcBYfM33IVb4n+MUefFPPTQ4utl
 XWctwHwWhws8zY6uOG9kKyak/Yx1lqLupxN8bEQw9wlx+ych9sshpUz/4zbt1P1FL/bM
 4hPRsqKPGI9oJ2MzR0/JvskkvnU2vGm7ps/IZNvt8vJcfHWdIWqXwbZsHhcOB6FCDQid
 N3Jw==
X-Gm-Message-State: AOJu0YyGQJyxgigcS5ILY9unUgF1vUcQcHQ6aLIZonCJmpeX5z0KOKFu
 rkT3qyWhE0Edp7IzcEeq56KHkqR6nRThEgr2WdsK6Trb7bT4RDtHVagofWbGQU7vCnnp2zHgrCE
 IFHS6utLlmCmUDzCIJB7hVRKsoUOJ9pW+4PA0LcPUj2N17yRNEa3Qn8O+epZsPQUmgA==
X-Gm-Gg: AR+sD13CTIIYj3lN4UHT+8CIlbCRjRgHfZpuEiP34m2aVWKSw5hoiXqbmfjnl1VpMg1
 vprMkdBnRRtadshjuGOCbknO3jpBVuKU1Dm5xVKfgU+QDYyJoOr2ppm2HWScDgC2CAdOybcIyd0
 5ByfJYWz8r345h9lYmpFwUpnhma2/DPx25a20DWKIZH096q/buhogvoEFSb+YrkUMzEQbUrWCDa
 nIN+AvoX4xnO+D52seF4zMjrVdC7ZHq4qv+p6+pbGiS5ib1JgTMtDy7KBMUnmFF5CRzrhqsjvJc
 C3aNujblXfgfFptyyoPtCVMBCG7TtywhUIEWaHw9bmBS3QHQaTIG1dEbJOn5bvKynnN76prPuK1
 Gv2d7POZMMbIQ5t7HRb0ZnIV0ajQxbNX6BjrDnae0jw==
X-Received: by 2002:ac8:5a88:0:b0:51c:d1c:10e2 with SMTP id
 d75a77b69052e-52d602bc7d1mr22186691cf.12.1786473275461; 
 Tue, 11 Aug 2026 11:34:35 -0700 (PDT)
X-Received: by 2002:ac8:5a88:0:b0:51c:d1c:10e2 with SMTP id
 d75a77b69052e-52d602bc7d1mr22186181cf.12.1786473275051; 
 Tue, 11 Aug 2026 11:34:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4c10asm330805f8f.20.2026.08.11.11.34.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 3/8] hw/cpu: Move internal declarations to new
 'cpu-internal.h' header
Date: Tue, 11 Aug 2026 20:34:05 +0200
Message-ID: <20260811183410.22428-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: doXQabvdqBDwncPSAJ5KqGPmRma4Xt10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX0tDP+uSH4wEv
 RMSNHnN5FNx4Hc+3vj1VcmrlV1S3EeHGVua6vK+5mdp10UwoHXH44QSQjcoPn8kpXOcsIEQwrbr
 X151g4N/UY154E92VOZJZ3p2vBl33zo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4aQvMkh/ZXk3
 1wBeuYgq+M3f7E5cW8QD4gobzqdp+H6hcaqtmVeLy8By7uy7b3RzMK2f1iZWbz9TSBxJ47jxPjx
 w7TnloIoEt8Gzs4yCLmAw74R8o+PqOjyiEq1OAkZrqR4bJzYGNIcsZ2RczwUV0cEm+phDXO1b0P
 ytbKWhov8ShEDACaR4ysgfj7yPhIvZ4ZmBbcZTmRAE7iE50+8uWn+jAmD4qZk6Ye+tp1Z5TLLZc
 n2n4bO4q5DUS9QJ3mMc1kXl8Tc244KwMog3+/79wOs18jbpdZqpG5eFYpnKVmVghXQL4fTJIW1B
 9/ZAfHZUhXnTOPbJlcJLxcpWUTo3M3eIJixn7882FfNpShYT8QVHs8MQnZFF6qUKE2x0A2OcsLC
 3ZzMIA5H8EgJlNd9rDLesk026RnArTA59j+rqcuukEjOx88rmRhj4Gj/5cy7JwcMg4SlYUvbyQu
 mm2JA7+V4g1HlCOoNLw==
X-Proofpoint-ORIG-GUID: doXQabvdqBDwncPSAJ5KqGPmRma4Xt10
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7b6b3c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EfUqco5ci4O9xaNkQFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155
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

Some declarations are only used within hw/core/, in particular
by the 3 cpu-{common,user,system}.c. Restrict the declarations
scope by moving them to a new "cpu-internal.h" local header.

Rename cpu_exec_initfn() -> cpu_exec_init() because we usually
have the 'fn' suffix for handler, not API entry point methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-internal.h | 22 ++++++++++++++++++++++
 include/hw/core/cpu.h  |  6 ------
 hw/core/cpu-common.c   |  3 ++-
 hw/core/cpu-system.c   |  3 ++-
 hw/core/cpu-user.c     |  3 ++-
 5 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 hw/core/cpu-internal.h

diff --git a/hw/core/cpu-internal.h b/hw/core/cpu-internal.h
new file mode 100644
index 00000000000..ae6a31bca2d
--- /dev/null
+++ b/hw/core/cpu-internal.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU private CPU interface between user / system modes)
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_CORE_CPU_INTERNAL_H
+#define HW_CORE_CPU_INTERNAL_H
+
+#include "hw/core/qdev.h"
+#include "hw/core/cpu.h"
+
+void cpu_class_init_props(DeviceClass *dc);
+void cpu_exec_class_post_init(CPUClass *cc);
+
+void cpu_exec_init(CPUState *cpu);
+
+void cpu_vmstate_register(CPUState *cpu);
+void cpu_vmstate_unregister(CPUState *cpu);
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c5064a5449b..6490fb070f2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,12 +1178,6 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-/* $(top_srcdir)/cpu.c */
-void cpu_class_init_props(DeviceClass *dc);
-void cpu_exec_class_post_init(CPUClass *cc);
-void cpu_exec_initfn(CPUState *cpu);
-void cpu_vmstate_register(CPUState *cpu);
-void cpu_vmstate_unregister(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c9ff25e04a..17d76580930 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -39,6 +39,7 @@
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
 #endif
+#include "cpu-internal.h"
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -326,7 +327,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu_exec_initfn(cpu);
+    cpu_exec_init(cpu);
 
     /*
      * Plugin initialization must wait until the cpu start executing
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 14eb4ed87f8..8a9f2fcea84 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "cpu-internal.h"
 
 bool cpu_has_work(CPUState *cpu)
 {
@@ -188,7 +189,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     g_assert(cc->sysemu_ops->has_work);
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 25aa25ad240..c2cb00a85d3 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -11,6 +11,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "migration/vmstate.h"
+#include "cpu-internal.h"
 
 static const Property cpu_user_props[] = {
     /*
@@ -32,7 +33,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     /* nothing to do */
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     /* nothing to do */
 }
-- 
2.53.0


