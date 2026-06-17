Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4E7CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtri-0000ZQ-Oo; Wed, 17 Jun 2026 13:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrg-0000YV-JP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtre-00075g-N2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHAjeN3446894
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r/Vk/6apucM4nBt03xY1qhRC+Z5fpGBh/10BnHaz5YI=; b=YaVOzCBDxeeYxP0P
 g4c0BvokLaLdFiUrjVWqD33pdkggGwzyZma6znHTnCQdQtzJV2N2qVqV9SbNcVRy
 Qjdrmg8kjyhrAwbPYo/36e2Bfo6tKkFMaoYHnvU+OV9yEnHB5e3C0zt2ugkQfV0T
 eDUYTK3MND8xfYrWK6kuxPnQ++ZSHEMCp/kAPT3w0rJI3udJGIdL//a4oOk07L3B
 rdSW1iojtPqE6FhH6Ls+JQdtZyNenCI5HA10U5PtQDcFgBLytxoccl1I1t5W6Q4I
 H+zOUUxu/MaotZnUlcZRiM3xcA6V6WnovPjDPNzEGakla2kdq7Vk14Y4liukzFS/
 abJ/Pg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jrpub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-966d2fd33b1so565576241.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716545; x=1782321345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/Vk/6apucM4nBt03xY1qhRC+Z5fpGBh/10BnHaz5YI=;
 b=FufV/X7yYlw6Z/WJhwpLrJo0H6iJxyoCFIEPPFG0HmvXCpLOJj+YxlpJJD5LyVqOq1
 JP9XChT6w+WJNnr8hFvINMJHB+fA0FY0124xMy174lW42UvuXXX5LxYa3dOcwqku2IGx
 HepTxQiuFPNliYbj1V7XlPvy1Dr7/Dy2cp+3cKbyV3zfDG1976CDlwFLNRIGylH7i9xj
 ld5TT0M0EWZRag6ZpHKbfHliFCtCV9eelfJ6NyNnC1Av+61ntgynnPS5NegzOv7jJnds
 iWdMSbxlfQKuQKYQLR5FDrzRrc97V75oDdB2C5xs4ijN+JBvuVw0Ac6pQgsB5tJtVxUn
 WXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716545; x=1782321345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/Vk/6apucM4nBt03xY1qhRC+Z5fpGBh/10BnHaz5YI=;
 b=aDDjFgLn3i9IqTgx87tiiTxKPrc/s1bDyMBqo+7TdMKYQigYIGDvtYNRD0oTEpxybZ
 GKc2armKN1bbJme5Fb+Co9Lyb1hoib8CYkRt15vnVsPpiSCKJuKNAT7ttIpV2p9kv0IE
 ptIMZBZ3B5zUh5C0FEHJkF2Ora9b+Iar0SzXU2ghVqkRkwcvdV5xAdbzi+VwudVfU3hG
 4ojCRZF1go1s8xrqp5vEUvRft49d5/ebgIinxxyqkZbfktoIp06aJ0HTbG10vKS3TsxP
 pO+xBVDohHN8bMP+PRS4kbgwDsIyyQKONji0G2HKtKw28Uq3UvfZIveStOdmlrp9ZDU9
 1SWQ==
X-Gm-Message-State: AOJu0YzdV0AmAqHI/tQ4RZaGFyzGs4Nzj1Fqu+fD1h5Y+PQAf1kA6K6f
 +yHmtVwXVl9LsWdVkKZUfHSWD62CtZiO+2EnJqcdMiF80zmR2e/2bYA5whsklGcZqydrxOySuNt
 m3NVg71j5KxcyBPmqooln/KRFvGFJM7CE9v0jRozFnj+7Q2hkLto3j16V1ivmkKqokQ==
X-Gm-Gg: AfdE7clQ9Zrs1zYo39Wujbd/gwf29lFlCM2O9GqXNTuAQkz71lLpK67H/K3y7iIA8MK
 TjUCQrB3BQez1KCBvhDMtZNOj5PnWwnLXOCgBPzNu+rHDa22sVHItL/Ux2qzVaqMwT9j9gvaQ7r
 0+WCnl+4cKbmkR01ZcuUhrZj5r1psgVMcNA8Cu34qrjXIPZOjap6sQazT6qUt3hXNLNNjrI+32g
 CLH64Qc1j3WH27Z91BQXb1NFdbh8hbRV4pGTuVQrihlADXNL9Rvne8dOT7nPiYJK4MHOgwEnfVS
 G8V8zr39q/78CgYzIq0GluxJaqZ+CUD5zj/5lyjmwsF1EXulCxUvT6cQDS+2Fw9JxUI6V30+7tT
 BOG83Ndsr+uhRBsNLFq7Kvgmwz0NYCZz+Gi9lpmLNdohDuOF7zjoXgpvEVqUip9hduMu6
X-Received: by 2002:a05:6102:390a:b0:632:73ad:6c4 with SMTP id
 ada2fe7eead31-727c4fb92f3mr345425137.8.1781716544990; 
 Wed, 17 Jun 2026 10:15:44 -0700 (PDT)
X-Received: by 2002:a05:6102:390a:b0:632:73ad:6c4 with SMTP id
 ada2fe7eead31-727c4fb92f3mr345376137.8.1781716544532; 
 Wed, 17 Jun 2026 10:15:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4631217027bsm4868204f8f.12.2026.06.17.10.15.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 09/11] accel/tcg: Move cpu_loop_exit_requested() out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:36 +0200
Message-ID: <20260617171438.75914-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfXyLniRRSNwuT+
 JkcA4P5nTbTvzVI8XwHMZSZB80xD6B/d1ejanpk23wJ6EME8JHEYFma6G2s+fr7kA29wdwBQYMX
 0gmY+JuZ5Zu9RO1PH0eOAwO+vU9mplrZNJKZ2/NkqSAyIm7T+u/ga2XEYehBMtXja/u7HiBI833
 Ae6FdSINC0wTxeZtXyB7hcKqyqwD5cysOB998m6RmzUXkU2UFkdV5DEKHOSpRVLED5eWttUOIr3
 2Biao3McdnrEUT6er2eza37FVFW2mjPKIQLWLp+FHhw53+7V/Cp42QVjBDEX1pzEQMGHUSoE+qY
 1c4dzIfRXn/iDUjwxeIRtqlhFTqX57Mdp2xMyg7O0c/ui7LyJS2k9OmAlMBzAKD3fvBtWZlQOJq
 5S4T/9I+oLIj9BIrYEf5+7cD5KqF9mYvdQKWeIyDoBeDJqgbc7F+X6XwKGQroboYDfaN1g9iX7J
 7yTIUE9w8+LH6TZWx+Q==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32d641 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=b-U9umB2Q9Dvb73q-1QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 7gEdU1sAIaAnYEqn2cK6h2HF3jvVEDSl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX95mISnJWfMd+
 Yy2rLRJdMF2P+0ujDD6yF9dd6HnJeYk9zDY4BFZAAzxRGWXIp4b/6uQc8bzgQ5DD13JolDf0kRF
 nYF3ARRgvGtn3rBHSTsNKAKvxs1TJhw=
X-Proofpoint-GUID: 7gEdU1sAIaAnYEqn2cK6h2HF3jvVEDSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170166
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

cpu_loop_exit_requested() is part of the TCG cpu-loop API,
defined in "accel/tcg/cpu-loop.h". Ideally we'd move it
declaration there, but it is defined inlined and access
CPUState internal fields, itself defined in "hw/core/cpu.h".
Since keeping it inlined in the 3 call sites is important,
move the definition to "hw/core/cpu.h" and call it a day.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h     | 19 -------------------
 include/hw/core/cpu.h         | 20 ++++++++++++++++++++
 target/arm/tcg/helper-a64.c   |  1 +
 target/s390x/tcg/mem_helper.c |  1 +
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9919ffb1838..aedd60a6986 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -62,25 +62,6 @@ void cpu_destroy_address_spaces(CPUState *cpu);
 void list_cpus(void);
 
 #ifdef CONFIG_TCG
-#include "qemu/atomic.h"
-
-/**
- * cpu_loop_exit_requested:
- * @cpu: The CPU state to be tested
- *
- * Indicate if somebody asked for a return of the CPU to the main loop
- * (e.g., via cpu_exit() or cpu_interrupt()).
- *
- * This is helpful for architectures that support interruptible
- * instructions. After writing back all state to registers/memory, this
- * call can be used to check if it makes sense to return to the main loop
- * or to continue executing the interruptible instruction.
- */
-static inline bool cpu_loop_exit_requested(const CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
-
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 72666189774..eaf30d13e8e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -612,6 +612,26 @@ static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
 {
     return &cpu->neg.tlb.f[mmuidx_to_fast_index(mmu_idx)];
 }
+
+#include "qemu/atomic.h"
+
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loop
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(const CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
+
 #endif
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index a0f9215f1c9..cdac560d086 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -43,6 +43,7 @@
 #include "user/page-protection.h"
 #endif
 #include "vec_internal.h"
+#include "hw/core/cpu.h"
 
 #define HELPER_H "tcg/helper-a64-defs.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 8474a694110..bfe0208324c 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -43,6 +43,7 @@
 #include "hw/core/boards.h"
 #include "system/memory.h"
 #endif
+#include "hw/core/cpu.h"
 
 #ifdef CONFIG_USER_ONLY
 # define user_or_likely(X)    true
-- 
2.53.0


