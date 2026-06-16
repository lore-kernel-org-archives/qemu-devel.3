Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04572CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZIf-0003WP-If; Tue, 16 Jun 2026 15:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIc-0003Hh-1W
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIZ-0004to-ID
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:18:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOiKW3914081
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K+7vQkmZEx5hLsUpa5c7U/zOGIraZiiT7l/D8vb+OWU=; b=npBBpCwpAy/kM8nt
 u+xcUgb33y1rg8zibKsTGDNHdiQVdFX39fsO5hig4NcXMI+sk7S9IQaPb2tdWuEu
 XzK5ARXRlw7AgCBBbkO6+q8MdVIHpJlZIVhiV0kzUBeBhnzes2fwtOn0nBGDhzlI
 fzW+32uszIzHaYQXwcyetLxeGjNTC63y3tBPNfwG+2383kUfKO7u4VmqApqR+Ysk
 TVIRe1yQiG5jn3n4HbcD725jYRq+CmdYcaIxyWXnwrKkD4iesTgh2QD7kX1pTzqI
 vU0+62jqQxC1Kd34VsYopEfQj6fTFMq7qOnljxE1FLyP6xTbdOHBOgQE9d7pEc1U
 Ywq33A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu0a7urxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:18:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157d38ab37so491157985a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637488; x=1782242288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+7vQkmZEx5hLsUpa5c7U/zOGIraZiiT7l/D8vb+OWU=;
 b=Rh7IjkNzQARbOMF5nZ3ORGtUBqKD139ssP2FAIwRggXuZWKJkvZcB6Dc69sUEvzYyg
 z/eaRSF3uqO0ak9HvUQwoZRR5IppWKIQpTnlIZXHPl7DwMo4i5bnzX99+o5z02O1/I0p
 iv5H0W0LdPkzHiezjSvfCeZgagZ1RYQbRqHSxioXQlEWGGb8MLbToq4rSLXJoUVWiJWh
 gVR2q1JloXTh7L31padhq7DP/gm6R6UuBP57R3EeS7nxtBYwA+nPBL33WvTeri3cYmJk
 AkCKV0LfnPWlLJU9DZHJ40jmHFgE6EMno7FdzrcZ2Y1YG5QfD4HON8PsxQj9DRzI2swK
 PPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637488; x=1782242288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K+7vQkmZEx5hLsUpa5c7U/zOGIraZiiT7l/D8vb+OWU=;
 b=tWf7N7LfoYzKufaw2BGyx8NjUViyJGVKlA+6PzoiZOdwGOW8HFM/EUVw4rgWh+D+KF
 D63b7HrQWdEEbcL9RzFaBvQS6mSqNGM+JbiUJWmq4W9o7b2K6cgpe9c0yPEBgvBqA09M
 KI+o5vVvccipJukuc8IZtq/kVW4gdgVDesX+v1XVFAWX3MPJ+xd8AdZnHGlegpvADbsk
 FcCu1hJvuXmaLpYq79a9jjWWlX6iq2ACud7Lbmgo5G9nxRnqwOiYRHkkll6zhPxdyaNd
 sWBgU/UrK1a8NOTl2hkEmUCmx23Lr3aZsGnQ14zHaF2p2KqiqJ0TAUrMQNCEhAZZXsbf
 aUkQ==
X-Gm-Message-State: AOJu0Yx9bvSDVTiJN69Dp+lH15nFtMqLIDk1GaQ2yD6T67d+cQDqvMfx
 mWMvKSitenfpLM3r7UQOfFOzXtga5uncH4R8Y8c9DK3CloCxm9xvASnYzTNB8staIdRVQt1jdxx
 pcOiMWkAPcCFwVjEERqJXaOHbf8FXJpgoLh2fqNmzR1sz3JPeu4BVTMNBhJ7OsItVuQ==
X-Gm-Gg: Acq92OGTtKiu3fZPfRk0snbeOV8qYSrGatB+oWabYO0yTWecDut9yWZdJC5Gw3wp7a3
 nHWgU+wn7xg2y1fv9wJ0tBgFZonHKV4DPgttSBP58s3Mr6f4OKuqVie+XFLZTohcK27zx00HH9M
 BOiDEFOrozmC4qfAP3fEUaCCcMG04X9SZ7mE4gHeF+iajbRS3a5762BfMlOZUzVu/HbqWGKRxAq
 ABG5vSud5GvMazussSTVoKngl5tc5ZOZvfOWBj5kJpicSZrgkEBQYNUh8iGHI6EqicMWoCd0RgM
 h4KLUUXTVp47BhtvnRv7wCPVUmagIErZNHRVVx0PcRFO0am2PMFfVQagmroy1Dzru+PuEdYM+nQ
 bB9kFuBmqV3JntVeBndlirEoI6i6xwjIz47f8i1R/UgPTYgK4GWnHE1VIOHHmK8lrNZzMeXQkWE
 +kjx0=
X-Received: by 2002:a05:620a:4442:b0:915:f664:2568 with SMTP id
 af79cd13be357-91d8dea67femr159971685a.50.1781637487757; 
 Tue, 16 Jun 2026 12:18:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:915:f664:2568 with SMTP id
 af79cd13be357-91d8dea67femr159965085a.50.1781637487142; 
 Tue, 16 Jun 2026 12:18:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa890d8sm112657555e9.10.2026.06.16.12.18.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:18:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/10] accel/tcg: Move cpu_restore_state() out of
 'exec/cpu-common.h'
Date: Tue, 16 Jun 2026 21:17:13 +0200
Message-ID: <20260616191716.12932-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX/BwY/fZ3Y19u
 aCUlQeZScQ5jf54GWASE5gNadxZhNBUKGAB/RR9gfs3JMyMzX9TK6yJ/HUVh2ILvpk4/VXooioh
 MIIQiJ2uQJYdE5F+4dnes6OV72Rl9/2nyj+zFd8RpsMrFXpAN7gqAXMC9UbRiR0hVFEPTeIjmVC
 haR8FHbz0zVXXOHkhaKmblwWkDp6rSGI3cQKHk3WsKHh85G4Q18q0RYu5bZOG07DAftc2BcGDo5
 huWl9PVKOcq+S11Y4JlfHL/hZ++k5Mn9tmXSk+iXAjs9TiGUs2iAVIqVut8Wj1aXoJmpY/hyVUt
 FSLI94rDU1B9Nzx0KceQPdDwLSMs/kwqjela4R93cdZzrNVkD93fjIKHrGRf5rZEwG7WPzUSo0j
 d3UxS2cognaScEQ0+XhE1gsMv0YnGQX+wa9RpkQS/69EMkYgXqPY1Zn90pX0plIpadyWvA034rl
 6ecSsiQ0NheNbI6B3jQ==
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a31a170 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=mtRK1ZlsaID05NlGe3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: QZZBgH68wUDPeeom0uFOSsqUnfHqszCY
X-Proofpoint-GUID: QZZBgH68wUDPeeom0uFOSsqUnfHqszCY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NyBTYWx0ZWRfX37Gb83v36cbl
 yxLVGwJLrq/Q1rt56axtQQHzuqL67aDgR1xnwYRXmROgFl8X7va5EPMqvpz4Hn2nZ7wFYQya1bS
 uAPGbUfM3tdbZHK8jG23HXl7N7C8NQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Move the TCG-specific cpu_restore_state() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-loop.h        | 12 ++++++++++++
 include/exec/cpu-common.h           | 12 ------------
 accel/tcg/user-exec.c               |  1 +
 target/alpha/helper.c               |  1 +
 target/alpha/mem_helper.c           |  1 +
 target/arm/tcg/op_helper.c          |  1 +
 target/arm/tcg/tlb_helper.c         |  1 +
 target/hppa/cpu.c                   |  1 +
 target/hppa/mem_helper.c            |  1 +
 target/hppa/op_helper.c             |  1 +
 target/i386/tcg/system/svm_helper.c |  1 +
 target/m68k/op_helper.c             |  1 +
 target/microblaze/helper.c          |  1 +
 target/ppc/tcg-excp_helper.c        |  1 +
 target/s390x/tcg/excp_helper.c      |  1 +
 target/sh4/op_helper.c              |  1 +
 target/tricore/op_helper.c          |  1 +
 target/xtensa/helper.c              |  1 +
 18 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index f328aaa0377..2fc38c8f1c4 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -28,4 +28,16 @@ void cpu_exec_step_atomic(CPUState *cpu);
  */
 bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
 
+/**
+ * cpu_restore_state:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @return: true if state was restored, false otherwise
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If @host_pc is not in translated code no state is
+ * restored and the function returns false.
+ */
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index ba98304c5fa..3757ab15967 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,18 +64,6 @@ void list_cpus(void);
 #ifdef CONFIG_TCG
 #include "qemu/atomic.h"
 
-/**
- * cpu_restore_state:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @return: true if state was restored, false otherwise
- *
- * Attempt to restore the state for a fault occurring in translated
- * code. If @host_pc is not in translated code no state is
- * restored and the function returns false.
- */
-bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
-
 /**
  * cpu_loop_exit_requested:
  * @cpu: The CPU state to be tested
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc724..7704e4017dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,6 +25,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2abf07c1919..c3614ecafda 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -28,6 +28,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 572ea9cb418..b3988417e4b 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 504526153a6..9f9ea39be5a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,6 +23,7 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index f90765cb597..2ce63734099 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "helper.h"
+#include "accel/tcg/cpu-loop.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6443122cf1a..a68152f9682 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -29,6 +29,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f5076492264..01e6149c811 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f961046e4c5..76a8d8a0d34 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "qemu/timer.h"
 #include "trace.h"
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index d5ffabc2f4d..52a234e7fac 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/helper-tcg.h"
 
 /* Secure Virtual Machine helpers */
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e7..38f7a689814 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/semihost.h"
 #include "qemu/plugin.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 6a982c18c0f..05a90f5ecb2 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5e6c1e326d4..b04f07a6377 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "target/ppc/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 05e448d3f20..d952bb20cf1 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-loop.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index cf0f80e4a54..90c065b217b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 3cff5000c73..46b17da2bc6 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2d93b45036d..5a0e8655146 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "qemu/host-utils.h"
-- 
2.53.0


