Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A8606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNx1dKSS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTz0wLvf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHup-00054l-SO; Fri, 23 Oct 2026 12:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHul-0004rk-4f
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuh-000271-Kc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vMu4072851
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chcsydOzYjGZYjKR3ymCPHisdiVWvP4EYSmzidp8kug=; b=UNx1dKSS9Wo3UERB
 71fXRCHTepR7p9Ts79jXLTxY+v6VeAqflLEhnTTxyIhwRpvRQKsQM9dL9Z0MbCED
 30pMRHJivjB0U0bXSjb6BhklT1KY9yv6lEPTlYPfK6/KuREkCcn80qiLEX5M3tJL
 9iVUwmn7bYmGMpskThLw9N6opK4TIWhW8HwCIo7mXfGbc8VYbYeQ6Kfj0hG/IEdK
 5IqySQBPTt+vqgqzIp4rxZJDLB0ktUaWzTjOUKFHi+/4pwV3qPlAVm1gS/YuEZTK
 5D8Hy8MhuDnUCVLDU4dZHHJTPUAsdlLy2aULtJBhTdMPAmaSYYGuQz0yO0meVfaw
 wI6/kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0wtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so167460485a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772075; x=1793376875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chcsydOzYjGZYjKR3ymCPHisdiVWvP4EYSmzidp8kug=;
 b=KTz0wLvfcR1yZxxjE/S+YL8/zYawuRF2gbwaphd6QztoLCdPhxj81KVqjx4jzcHoLh
 sKz/n/BHMZJNmELY5LGdl0RLHCZZEJWeHpc8bpHZuZFR5qSlcalRlSp96/lQg+IMcASO
 q4yvxnPmX0EexxvzEpxOTqkYjHlaXCYZShNlwO55cPrVNeUwR2B4va9sLK+FuhP2sZCS
 pu68bpi1fxXrqffbHc1SGvbe/3y12hXl+okgtCNiyTkbPTk5DIuSzpSs/6et8/LD/k8L
 IBXHfBRilzpYRN+uzFiAyje6v+BgOESMog5CkvPrGIxJXnpdZiOPvZEW7xpI2c0G54gT
 9N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772075; x=1793376875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=chcsydOzYjGZYjKR3ymCPHisdiVWvP4EYSmzidp8kug=;
 b=GjBK1f2rsd2i65A0z2t/Gwr/7cqePusytIjhsvzBNOXZx8N9geBzmTYcewBwf4v66a
 p0j0yew+aSx424Becv7RGJWhtsR9onfieHvv6J/pq/Km+1L4YInipm/b/tXoaR4UmboY
 i/b9P19NvSfiuLk8aCpLjCmo9wocv+qAfoPf+LW5XrwSgR16nVOohDM/e8EcrczkM/TT
 n557VU/ouBUTBJQgnXXtkbuj6FydsudQkr/pwMWW7bCTWVSReEUNAZK8xbm29ZAd5gT4
 EAObPh8p59XT9dQ5C2OiSUWnfua/zbzPISy1fzn7g2D4KxqC0U+mr9MaEG1Ud9ZJ8rTd
 OW4w==
X-Gm-Message-State: AFq9FYL6CJyyE6+ZNv2xbSVho/WPgwt+dNbbDMzCS/ruFqfhsy/mcW4s
 1qAAOr7Q3UPTq1JfnYKyPSEYANi6bpaB+3FkZ0r0kO0ahIJWsauo1Sihk7Vi7gsS0yz4m3EUZ9E
 HFT4YXjk7HiE8QRMnvWZ+4qTfCMEYsH7ADo0HJEAcSPngAZXoQXVptQpC/0FwAfr22jmQ
X-Gm-Gg: AYBFou1MTOe3vBuQx/cZ3DzlQRRGKCh6jhiRJFPU4DFyB5/4sxvRQRJWbx4nRhkyUeT
 Y3KeLgyWLMKV8hkwUxF2d3DjFAzPdc04V9pZmrHiiVRgkVW+PBU1VwG+bewIUtNdDKVnm+Mbp3a
 AI8AIVhYxpAbF4INpYVZ1FtcgZt2V6sw+AbRycu4dOlnKfgJYQ+zyYGhBxJ0JLyaBqSzRBQHLW8
 hT1+tTd6I3Edzwu3N4nk8iYgjhYIYEjGJdB+8wPj+7oxfdXrWk+XfnhaYc/4+TNx+1cQ/Nj+plD
 EprlWyL3E3iofmc80csZjV+XnJJ+yT637oKUlxqeuf11FuZmaaQdEbSFuKm2dwi2Cke9hOscVGw
 7c0iPDwyh4+tnm2RbIqfxIPKzo/YJRK24gs6FyC2K
X-Received: by 2002:a05:620a:6841:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-93f6f657f8dmr451616485a.18.1792772075058; 
 Fri, 23 Oct 2026 09:14:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6841:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-93f6f657f8dmr451611085a.18.1792772074331; 
 Fri, 23 Oct 2026 09:14:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe0e577csm9083385e9.0.2026.10.23.09.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/83] accel/tcg: Remove the redundant cpu_exec_halt() hook
Date: Fri, 23 Oct 2026 18:12:16 +0200
Message-ID: <20261023161332.60153-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fGeXPfR8RpamDe63sPucTPkrKvtS3Vzq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4OGCFMXZBjMQ
 zwyxgCnWM62h2/1uph6dpM0tK3ngzmK5aGMp06Cx7RLZVjMBHat/IdygdFUXuMzKNV6iiYeJncH
 4UvIdjyFrL/vuS1gQFRXYwQMAd9noho=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb87ec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Fma_We6Em7EAR7gKL-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fGeXPfR8RpamDe63sPucTPkrKvtS3Vzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX68dNbnmMQ3JR
 81k9/PQAqHrUEKfNAhB0/luNt3T4sa1o30tOOPLgZtFmouGKm9ZwQ43tlMjypdDwDCSFGgd20xn
 1vzG5var/Bzgg/WGG+Zjv8zaHljK0ocyaWhYDdJ+UpboWIq5C5sVO31r3KIqDHPETmjFc7Tuh7k
 ni1G4qXhZ/VT/BGQ5d57nd4UZn+zXzKfk16z33DuaYRziFEps1BI2YI81zKEUHqi+C5YvRXfZ05
 CukPXQSeKt5f7iahjg5Ad9PGi1vAm6FWDJcqx3EDzZx5cy2TsZtzPiYR/W6MYf9iPOBRpNPk26x
 LsV3jkacNlwk+V8IVDXqiSEXw16tZMydvuMH1ODjqz4uT56l0gnMEO9SQ7RJ4Yqi1kLKq+0KRwi
 0T8C/d1Dh5DKaoTnMhfRg8QjBJWpeWm3EJwx4GI3aBflKlpvBN/b9b+JlkGE/r7Pt2SmQuWhhqT
 anqRIGvU3mvrR4m/iNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All remaining users of cpu_exec_halt simply alias cpu_has_work().
Call cpu_has_work() directly from the generic halt flow and remove
the redundant hook registrations and interface definition.

Make affected cpu_has_work() helpers private where possible.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-9-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h    | 18 ------------------
 target/loongarch/internals.h   |  1 -
 target/riscv/internals.h       |  5 -----
 target/s390x/s390x-internal.h  |  1 -
 accel/tcg/cpu-exec.c           | 23 ++++++++---------------
 target/alpha/cpu.c             |  1 -
 target/avr/cpu.c               |  1 -
 target/hexagon/cpu.c           |  1 -
 target/hppa/cpu.c              |  1 -
 target/loongarch/cpu.c         |  2 +-
 target/loongarch/tcg/tcg_cpu.c |  1 -
 target/m68k/cpu.c              |  1 -
 target/microblaze/cpu.c        |  1 -
 target/mips/cpu.c              |  1 -
 target/or1k/cpu.c              |  1 -
 target/ppc/cpu_init.c          |  1 -
 target/riscv/cpu.c             |  2 +-
 target/riscv/tcg/tcg-cpu.c     |  1 -
 target/rx/cpu.c                |  1 -
 target/s390x/cpu-system.c      |  2 +-
 target/s390x/cpu.c             |  1 -
 target/sh4/cpu.c               |  1 -
 target/sparc/cpu.c             |  1 -
 target/tricore/cpu.c           |  1 -
 target/xtensa/cpu.c            |  1 -
 25 files changed, 11 insertions(+), 60 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 1ee5d3d8bdb..4195a29e1e4 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -187,7 +187,6 @@ struct TCGCPUOps {
      * resume execution from the halted state. This callback performs any
      * necessary target-specific state transitions or synchronization before
      * instruction execution resumes. The caller does not hold the BQL.
-     * Either this callback or @cpu_exec_halt must be provided (but not both).
      */
     void (*leaving_halt)(CPUState *cpu);
     /** @do_interrupt: Callback for interrupt handling.  */
@@ -196,23 +195,6 @@ struct TCGCPUOps {
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
     void (*cpu_exec_reset)(CPUState *cpu);
-    /**
-     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
-     *
-     * The target CPU should do any special processing here that it needs
-     * to do when the CPU is in the halted state.
-     *
-     * Return true to indicate that the CPU should now leave halt, false
-     * if it should remain in the halted state. (This should generally
-     * be the same value that cpu_has_work() would return.)
-     *
-     * Either @leaving_halt or this method must be provided, but not both.
-     * If the target does not need to
-     * do anything special for halt, the same function used for its
-     * SysemuCPUOps::has_work method can be used here, as they have the
-     * same function signature.
-     */
-    bool (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill_align: Handle a softmmu tlb miss
      * @cpu: cpu context
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 952c98f74ae..9d064d1948b 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -38,7 +38,6 @@ void cpu_loongarch_timer_cb(void *opaque);
 uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
 uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
 void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
-bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9f1dec6748f..5466879a4aa 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -201,11 +201,6 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-/* Our implementation of SysemuCPUOps::has_work */
-bool riscv_cpu_has_work(CPUState *cs);
-#endif
-
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                          const GuestPhysBlockList *guest_phys_blocks);
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 9dd2243d486..1dfd4317d28 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -248,7 +248,6 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
-bool s390_cpu_has_work(CPUState *cs);
 
 void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                         const GuestPhysBlockList *guest_phys_blocks);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 122ad9e2e49..9ead35418d3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,7 +48,6 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -661,21 +660,16 @@ static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
+    if (tcg_ops->poll_during_halt) {
+        tcg_ops->poll_during_halt(cpu);
+    }
+
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
     if (tcg_ops->leaving_halt) {
-        assert(!tcg_ops->cpu_exec_halt);
-        if (tcg_ops->poll_during_halt) {
-            tcg_ops->poll_during_halt(cpu);
-        }
-        if (!cpu_has_work(cpu)) {
-            return false;
-        }
         tcg_ops->leaving_halt(cpu);
-    } else {
-        assert(!tcg_ops->poll_during_halt);
-        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
-        if (!tcg_ops->cpu_exec_halt(cpu)) {
-            return false;
-        }
     }
 
     cpu->halted = 0; /* allow execution */
@@ -1074,7 +1068,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(tcg_ops->cpu_exec_halt || tcg_ops->leaving_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..7d1d036e1d3 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -265,7 +265,6 @@ static const TCGCPUOps alpha_tcg_ops = {
     .tlb_fill = alpha_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
-    .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..a01e6fa4751 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -246,7 +246,6 @@ static const TCGCPUOps avr_tcg_ops = {
     .restore_state_to_opc = avr_restore_state_to_opc,
     .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
-    .cpu_exec_halt = avr_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index f20d6de6f63..304031e97f0 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -821,7 +821,6 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
     .do_unaligned_access = hexagon_cpu_do_unaligned_access,
-    .cpu_exec_halt = hexagon_cpu_has_work,
     .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..7b1309a7c38 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -270,7 +270,6 @@ static const TCGCPUOps hppa_tcg_ops = {
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
-    .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5e182922b7d..a95fdfc2b62 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -117,7 +117,7 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-bool loongarch_cpu_has_work(CPUState *cs)
+static bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..7ea2a1eb933 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -327,7 +327,6 @@ const TCGCPUOps loongarch_tcg_ops = {
     .tlb_fill = loongarch_cpu_tlb_fill,
     .pointer_wrap = loongarch_pointer_wrap,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
-    .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..c7771cbf643 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -710,7 +710,6 @@ static const TCGCPUOps m68k_tcg_ops = {
     .tlb_fill = m68k_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
-    .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..6013a8def8e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -448,7 +448,6 @@ static const TCGCPUOps mb_tcg_ops = {
     .tlb_fill = mb_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
-    .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..c069aa1c0b7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -716,7 +716,6 @@ static const TCGCPUOps mips_tcg_ops = {
     .tlb_fill = mips_cpu_tlb_fill,
     .pointer_wrap = mips_pointer_wrap,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
-    .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..42d9351b6d7 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -266,7 +266,6 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .tlb_fill = openrisc_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
-    .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 578dd9194eb..0431c0e0ae5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7498,7 +7498,6 @@ static const TCGCPUOps ppc_tcg_ops = {
   .tlb_fill = ppc_cpu_tlb_fill,
   .pointer_wrap = ppc_pointer_wrap,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
-  .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b202a4eb6ea..f9946f54ced 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -963,7 +963,7 @@ uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
     return qatomic_read(&env->mip);
 }
 
-bool riscv_cpu_has_work(CPUState *cs)
+static bool riscv_cpu_has_work(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e07ca95e49b..80c04636175 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -306,7 +306,6 @@ const TCGCPUOps riscv_tcg_ops = {
     .pointer_wrap = riscv_pointer_wrap,
     .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
-    .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..69946928995 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -227,7 +227,6 @@ static const TCGCPUOps rx_tcg_ops = {
     .pointer_wrap = cpu_pointer_wrap_uint32,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
-    .cpu_exec_halt = rx_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = rx_cpu_do_interrupt,
 };
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 784bf4e90b9..715ff3ca945 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,7 +39,7 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-bool s390_cpu_has_work(CPUState *cs)
+static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 85afc5dec9a..e7f81fabff6 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -384,7 +384,6 @@ static const TCGCPUOps s390_tcg_ops = {
     .tlb_fill = s390_cpu_tlb_fill,
     .pointer_wrap = s390_pointer_wrap,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
-    .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d5..55c73a1da35 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -312,7 +312,6 @@ static const TCGCPUOps superh_tcg_ops = {
     .tlb_fill = superh_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
-    .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..1529f9570da 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1074,7 +1074,6 @@ static const TCGCPUOps sparc_tcg_ops = {
     .tlb_fill = sparc_cpu_tlb_fill,
     .pointer_wrap = sparc_pointer_wrap,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
-    .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 84a05e3d363..82b56c3cd56 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -223,7 +223,6 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
-    .cpu_exec_halt = tricore_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
 };
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..99c8bd4b5fb 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -325,7 +325,6 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .tlb_fill = xtensa_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
-    .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
-- 
2.55.0


