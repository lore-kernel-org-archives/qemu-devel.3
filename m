Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06145CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZts8-0000kh-Si; Wed, 17 Jun 2026 13:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrs-0000gU-D4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:16:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtro-00078o-2Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpLEr3015154
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PtKLf+JLfWQC0nqpMAHw1zZfvB9sJ/wLTHK66olaC2Y=; b=JbIRPteeQOL0HlQe
 EeOkIChn5+2wgDAqgPex8wxMOTDHlGhgjZPQ0S4W50hhezE5L8NBI7YhJXuDbNHs
 AKcR69ruAWbw0cEyo50jd51hOAd5WlUCKgn5f5yPQouRB3ecnpQY9DxkmLwQyqWH
 IrlPl6e4d6mG4IJ4TAl8aMDyeO/OpUpR1iAC08iWVD2p/y3hTs3t9jrVXLac2f9Q
 GR/LkEqTeWu89asZyL/j/OHjS23Kdp2RUVWqR75L6BiouDTjyqUOrZJXX+LN8xJy
 Z8G66qmI137D4W9wqWBUKqfMv79BbsKvCTy8a+ER0ufFWnkllg3Vgzc88izUCCdD
 nQUumg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euees4hfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6751c50552dso13426137.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716554; x=1782321354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtKLf+JLfWQC0nqpMAHw1zZfvB9sJ/wLTHK66olaC2Y=;
 b=St+wEmh3zu5piLx1cPmXNNsUNWEquU3xzvrS2ER7NobP/beTzr2P70b/9Kv53CCDeJ
 uOmMWhJ0kR8jrEYFNdTwMNQ0vMCdXfcud+RG40bUP3LWkbS44ZqpWN5a0qqe7P9gZ7cV
 rVhVFja5o5PHGJqSJkpSCluT8uIiQlNh6ZpUsB5bD4ZQMVsJgMnC8zRXG6BLe2Xo5YVM
 b9ZYZlwsw3jEqO8awkNwyuHipEPWHP9eMrKoonJf6mSaOBhHtseSyKKKOJcz3QM3GEHL
 tiSRH9cSWjUTfuR4xmu9cV9uuivsoDaS/O5CkV8OvcV8Po3APFO/k8DFHNuTIuErJzpy
 yaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716554; x=1782321354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PtKLf+JLfWQC0nqpMAHw1zZfvB9sJ/wLTHK66olaC2Y=;
 b=PiOKmDcr+ZZCgafNiAdhhnjdOaaGo3LNaGiirPC7CVygdHpHrvcXXkGZPBSGKDNppU
 r4IaWM8XW5gJcmyf2U+x8Azsj++GwPEdxcMYScdOUrkFo7bsi0dFsmdeK9kQUbsYUfhc
 Z7NdDSnx1nMSxki0OBwlPArgQWUOKniwr8S+y4trXfz1DtYC/jEnTHnGlp0n0K0WHjRo
 a4Df9OlivRC8DooIorfF+tsSxyRG3KFgIK0682rZa3LAWZycWiZvOW8h9dBpTxHncQui
 9JJ1LAJLcKH8YfMtLAuYAJwFkMshcFTYGoXaC+msBS0izjjq9RvnKpkD/XN5Yns+7ZGj
 8NjA==
X-Gm-Message-State: AOJu0YxxlGL5CWJ26ttuRyzB66q8BSO9E4xhaazdl1KHfVGaMaaXF7GM
 xHqoNtNKg3nllEQCJOAlKatLvGhVcDajzdkAizdLqvq/ie7f/S5016I7jXQCk660LkgNZI9KhgG
 5CQ0MSiYioT8RlqZeaOamHR75EZgVRngE5+aRnBt0ofAr8yaQ5d1vvjne6rYsI1gB3g==
X-Gm-Gg: AfdE7cl6mB5qNc8yll2mWwUMmx2Agex8EvaMvl/jN9BKcLcC2NFUiIS7A6PtKWUBTCl
 XcWMSwPp3u0b0bTi65J5grgDkXV67ZtAdkOvMnCHw0fotz2DuHGFdfxr+9FSn5cAAf6ho1F4G/F
 3R48kIAqaKXFEDr5fVQ2uVf9yopl1EKwzzYE0Dyfvf5DUHhSG8s+fN2KEzpeHWtd7eq3swQrowP
 VoHf+CHDuQNrmhayhR6sOl8Vuf73kfZIeqhZ2z0H9eHpcdKzrLyeaY4vlJQFLZtMUOFeAaEPWhS
 zW55J4AFgiH+Kr0KxZfPPHsio0Tjcj0+P0++rG8qbBWokEU7uTTqkjjEQZE/gFzWy4T8maww9rT
 4zwWEregYdFV4g5Bmc4PQZR68k9v24aJR84G/JA2koekhdPVtqmHgV4Msa7DUCqBSh0uy
X-Received: by 2002:a05:6102:f95:b0:71e:1c56:e78e with SMTP id
 ada2fe7eead31-7246c99f37emr3200675137.17.1781716553851; 
 Wed, 17 Jun 2026 10:15:53 -0700 (PDT)
X-Received: by 2002:a05:6102:f95:b0:71e:1c56:e78e with SMTP id
 ada2fe7eead31-7246c99f37emr3200457137.17.1781716551831; 
 Wed, 17 Jun 2026 10:15:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm12089843f8f.2.2026.06.17.10.15.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 10/11] accel/tcg: Move cpu_loop_exit_*() out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:37 +0200
Message-ID: <20260617171438.75914-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: enBZdZqTgxzMy9tct6ygFsM7-pZQ2iUx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfXwdZMQSBW6u/P
 kgKrVf+o0yTPzDEPOOtFKaHCUYWozk94WBpgacyI/cpCFKA4756O87x/Y59Op27kF7RYRhLiQKm
 j+nYZsIspYdVg2qH49rnNPZdzYEyMk0bLU7p0awV3oofVVyzfkXIdCSEtU6eY3gYLKl1QYjZsAf
 f3opW3njaPZmTTdm6Kvn/VKxdHgT8Qy9gUVE6fB+vCRDlMyRi2uhuJeQX+XhULWBUhXhgchfV9q
 tjDDB/o5R7frExQ7gposCBilPsRN+5J5yZJmPAuscpR6J1qeZNoZCmTTzVOo3IynsRXQEAeiYnH
 uw7M1AK9GKM1y6W8KI2wehtKsdT3F3btlD2txpBlWzKhts8Ua4hcsIeWNqgOP183JPjHQD+X/2g
 vmL2ZHba1k7BNE/gRlEIHbnHFUH0zC5WwD85ZXX2L3ATsN1XC0XJMrlxQrsYTdzBTwD94lJp5Dl
 o/Djo3ckTNDJOac737g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX7Z5B67sCiXYk
 ibGSzC7eSlAs1H20b+Zt05lb6C2d6UUBA+JszwFY8I8MECoHt98cnRZTdulXXwKrHwFjQlzov+b
 +NXoY8S1qhLWOcOrVJZ7cnhWWiPTGNg=
X-Authority-Analysis: v=2.4 cv=KeTidwYD c=1 sm=1 tr=0 ts=6a32d64a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UIuFhqY3-SwQPA8ZuEMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: enBZdZqTgxzMy9tct6ygFsM7-pZQ2iUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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

Move the following TCG-specific cpu_loop_exit_*() declarations
out of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one, documenting them:

 - cpu_loop_exit_noexc()
 - cpu_loop_exit_atomic()
 - cpu_loop_exit_restore()
 - cpu_loop_exit()

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-loop.h         | 30 ++++++++++++++++++++++++++++
 include/exec/cpu-common.h            |  7 -------
 accel/tcg/cputlb.c                   |  1 +
 accel/tcg/tb-maint.c                 |  1 +
 accel/tcg/tcg-runtime.c              |  1 +
 accel/tcg/watchpoint.c               |  1 +
 hw/misc/mips_itu.c                   |  1 +
 plugins/api.c                        |  1 +
 semihosting/console.c                |  1 +
 target/arm/tcg/helper-a64.c          |  1 +
 target/avr/helper.c                  |  1 +
 target/hexagon/op_helper.c           |  1 +
 target/i386/tcg/excp_helper.c        |  1 +
 target/i386/tcg/misc_helper.c        |  1 +
 target/i386/tcg/system/bpt_helper.c  |  1 +
 target/i386/tcg/system/misc_helper.c |  1 +
 target/i386/tcg/user/excp_helper.c   |  1 +
 target/i386/tcg/user/seg_helper.c    |  1 +
 target/loongarch/tcg/tcg_cpu.c       |  1 +
 target/loongarch/tcg/tlb_helper.c    |  1 +
 target/m68k/helper.c                 |  1 +
 target/microblaze/op_helper.c        |  1 +
 target/mips/tcg/exception.c          |  1 +
 target/mips/tcg/system/tlb_helper.c  |  1 +
 target/or1k/exception_helper.c       |  1 +
 target/or1k/fpu_helper.c             |  1 +
 target/or1k/mmu.c                    |  1 +
 target/ppc/user_only_helper.c        |  1 +
 target/riscv/cpu_helper.c            |  1 +
 target/riscv/op_helper.c             |  1 +
 target/rx/op_helper.c                |  1 +
 target/s390x/mmu_helper.c            |  3 +++
 target/s390x/tcg/cc_helper.c         |  1 +
 target/s390x/tcg/debug.c             |  1 +
 target/s390x/tcg/mem_helper.c        |  1 +
 target/s390x/tcg/misc_helper.c       |  1 +
 target/sh4/helper.c                  |  1 +
 target/sparc/helper.c                |  1 +
 target/sparc/mmu_helper.c            |  1 +
 target/tricore/helper.c              |  1 +
 target/xtensa/exc_helper.c           |  1 +
 41 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 2fc38c8f1c4..8559e99efaf 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -5,6 +5,8 @@
 #error Can only include this header with TCG
 #endif
 
+#include "qemu/atomic.h"
+
 /**
  * cpu_exec:
  * @cpu: the cpu context
@@ -40,4 +42,32 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
  */
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
 
+/**
+ * cpu_loop_exit_noexc:
+ * @cpu: the cpu context
+ *
+ * Exit the current TB, but without causing any exception to be raised.
+ */
+G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
+
+/**
+ * cpu_loop_exit_restore:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If @host_pc is not in translated code no state is
+ * restored. Finally, exit the current TB.
+ */
+G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t host_pc);
+G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t host_pc);
+
+/**
+ * cpu_loop_exit:
+ * @cpu: the cpu context
+ *
+ * Exit the current TB.
+ */
+G_NORETURN void cpu_loop_exit(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index aedd60a6986..da359ee3128 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -61,13 +61,6 @@ void cpu_destroy_address_spaces(CPUState *cpu);
 /* vl.c */
 void list_cpus(void);
 
-#ifdef CONFIG_TCG
-G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
-G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
-#endif /* CONFIG_TCG */
-G_NORETURN void cpu_loop_exit(CPUState *cpu);
-
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 31c8351231a..6860ac97081 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/target-info.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/iommu.h"
 #include "accel/tcg/probe.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0c7ac5a72c0..d9801a34275 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -26,6 +26,7 @@
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index f483c9c2ba2..7c0aab98a80 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -25,6 +25,7 @@
 #include "qemu/host-utils.h"
 #include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index cfb37a49e72..c75ed278459 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -25,6 +25,7 @@
 #include "exec/translation-block.h"
 #include "system/tcg.h"
 #include "system/replay.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "hw/core/cpu.h"
 #include "internal-common.h"
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 82c0a90f704..c20eca28a1e 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -25,6 +25,7 @@
 #include "hw/core/cpu.h"
 #include "hw/misc/mips_itu.h"
 #include "hw/core/qdev-properties.h"
+#include "accel/tcg/cpu-loop.h"
 #include "target/mips/cpu.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
diff --git a/plugins/api.c b/plugins/api.c
index 2d5fe9327f7..690b5994f62 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -40,6 +40,7 @@
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "system/memory.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/tcg.h"
 #include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
diff --git a/semihosting/console.c b/semihosting/console.c
index a4db8d8e76d..91e5d50d502 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index cdac560d086..ca8cfc6c9a3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -31,6 +31,7 @@
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "exec/target_page.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f3be8483b27..f452c9d9040 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 368391bb846..0a946433644 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 32f2784e923..1eaa602c91d 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "qemu/log.h"
 #include "system/runstate.h"
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 2b5f092a23f..f7342871ded 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index aebb5caac37..2feea69c8a1 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index bb79d4e470e..2998b1aae75 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "exec/cputlb.h"
diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index 6c5df5e0e88..0957ad2e9ec 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 28bbef1bbae..3a4a6d5a745 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index f556234d9d2..8dc4bb15a1d 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -10,6 +10,7 @@
 #include "qemu/log.h"
 #include "qemu/plugin.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 7623f4f9bdb..a4b90beca65 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -17,6 +17,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 2dd9ec1bdcb..5f91d206f59 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -25,6 +25,7 @@
 #include "exec/target_page.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "system/memory.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 84c60c2636e..3da0c68da39 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index d32bcebf469..630b8b809fa 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -24,6 +24,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
+#include "accel/tcg/cpu-loop.h"
 
 target_ulong exception_resume_pc(CPUMIPSState *env)
 {
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index c850ddd9650..4398c6f80b4 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index 3e76acae9c3..eeb82bc49f4 100644
--- a/target/or1k/exception_helper.c
+++ b/target/or1k/exception_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/helper-proto.h"
 
 #include "target/or1k/cpu.h"
diff --git a/target/or1k/fpu_helper.c b/target/or1k/fpu_helper.c
index 39b6195dd7d..e680606d4da 100644
--- a/target/or1k/fpu_helper.c
+++ b/target/or1k/fpu_helper.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 3ff288a1f94..3fc56e1b771 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -24,6 +24,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/host-utils.h"
 #include "hw/core/loader.h"
 
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index ae210eb8474..cc6d7ee88aa 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "internal.h"
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb75..97fea4d0c7e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -29,6 +29,7 @@
 #include "system/memory.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb8..987ef67d177 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -23,6 +23,7 @@
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index ca3e9e85fc7..36df7d377e5 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 255271b9d34..2f886d424a1 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -24,6 +24,9 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/memory.h"
+#ifdef CONFIG_TCG
+#include "accel/tcg/cpu-loop.h"
+#endif
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/core/hw-error.h"
diff --git a/target/s390x/tcg/cc_helper.c b/target/s390x/tcg/cc_helper.c
index 6595ac763c3..e538a75d713 100644
--- a/target/s390x/tcg/cc_helper.c
+++ b/target/s390x/tcg/cc_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "accel/tcg/cpu-loop.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 50d2853d443..99140b1ac9a 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "exec/breakpoint.h"
 #include "exec/watchpoint.h"
+#include "accel/tcg/cpu-loop.h"
 #include "target/s390x/cpu.h"
 #include "target/s390x/s390x-internal.h"
 #include "tcg_s390x.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index bfe0208324c..ecdecd5102f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -28,6 +28,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 036be93fb32..09a45e58a5d 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b3ec7ce64d0..b6b057f104b 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -24,6 +24,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index c5d88de37c9..8de261b0e30 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index e441ffb8f7e..07ba25dfcea 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index ce1693622b7..273713a1473 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "hw/core/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index fdc522698dc..7cb67d179a8 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-- 
2.53.0


