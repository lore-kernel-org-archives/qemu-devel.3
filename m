Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440C1CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBve-0000CK-3T; Thu, 18 Jun 2026 08:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvb-0008Tm-Pe
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvZ-0001KQ-Jb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAsMA6982637
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vUQPzZ/J+oQ2/ytcVfR8rbnQ6dB73FWmxgUq4+klSOI=; b=MyC4qnE7ELWSaYJ/
 kLUlJA1w+bdGA3PgEcUkpVWivCZZNl9sl4xVg/lovbB3iD5+Hs3gb0TkAG7vNGEh
 4+Ny5uLP4Cuz36v7/xuobOWtuhRK3H4+PLrv83Thp42zT6zYEeel2K0XWCtC7p/0
 0S9JplScpej3F34xrspCTA5k5wZ8mOhXRRU0GqLIzaynMJWK9PYM8/yBNI0zx/EJ
 5PiweTMR5hnohDlZz9C3ahXxVWd2hSdr9HvQ23MVplZAEO+njJu6yISEtbn9fopA
 0VfZqwpwTVwN41gAeaYQy3tiSn3r9dMEL/o1NL7e+dGE2jZ5CFCWdlxyBunnApUB
 0Wqgng==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn40p5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c89de84f33so1384404137.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785979; x=1782390779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vUQPzZ/J+oQ2/ytcVfR8rbnQ6dB73FWmxgUq4+klSOI=;
 b=D6WQKkCghgAn1C9Lv33DZKSkOWOXTKHtoJpA2fJD6MRASQJO9Uc+Aa70FMoZi5FpE6
 3J+YUY5dq73NH64+qLTBC6zJ6JgmmL9Q/j1oxQ3uuEKIGq2ofopk8p6Y1lFymgDM9Ejd
 38BDX4lZw+NHoLEPdM9PfBG/pQWGIndMJeFSQaOSnbV7TU/LKQYYLBhUFvf8Ifc8rngU
 vKRFBoqgQbQiz6c4SI+iAhRyD6oHGcUUh52yP+yRGnvhn33I0U5+oSG8ZhVLyhI66Mfe
 LHTE2MaIFolnU1JJV9SpWXgSFHjO/tK05CJ+bHapvKzfKKf/V19MWVw62d2M9Ze3R3n/
 hApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785979; x=1782390779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vUQPzZ/J+oQ2/ytcVfR8rbnQ6dB73FWmxgUq4+klSOI=;
 b=Bjb9AlT/IjiWfSU1VHa0q4da/uo3jOKL5lrw6dXo89jUath4zVVUIqjYOUg5Q5tUiI
 rGJuk8c7KP4qA1/RB0MOsWAEpTIhLbwroOiDRBtbk4lI3aMOOqphK8ZAsIgG3rIl5g6Y
 HpkQRfwPXpAM57Ji1nuvH6MVOZG51Kv+SoQuebuCknXagKAw3nlC6BIklzszH1ty4h2K
 JmoSe0QdLFZKlddGs0ZTzMUU6L9cEhTV0kMZ8xjACrT9oWuh5i9cK+TPXv8/q/4nrT1y
 RMOFtS7dpfeSu/VPFFmjqr4gpl2KJt3yWmO7CcScF5DdlhXAGiBJzkfBrsHj3pk+C9gZ
 vTyQ==
X-Gm-Message-State: AOJu0YxE+NWN41dU5pdP7i9tQzt7jcyqRlH/PBvozMx0sMe+kyTKnqvK
 ayutg/jkEt3NeN1pS1lVHsbOoJj80v1I8p3EPcv8rmxErh2WeFB3DPgBx6IptoGCDtFASi+T0C7
 1TYOjxKw5gCjZud+dnx53ykfwkwKPURVVnaOw48TGG0OyMomG5hWRU+Dw6rz7i+QIjA==
X-Gm-Gg: AfdE7ckg0tMZqPMHdkDfnJFvj7RQwTuRN4Hw100IDuGYwpZIXG2O8MredkLUVo182k3
 hJDWzsyJaT95xvTJA34oTBaf7jQ5CW8olORjaiCZYQeGb5l0wMoMvB4lDR5xHb0Eq2SqcnY+vak
 68n7g6olcMsi6hR0EncxNAZ+je3dNLYQsNKrsd9G6KmIjWyyHBrdm5eQle6Gffck8Ts2Te2djhP
 jU/Q1CJO4ZKA6IvB4p7YkUEehz7J7p63O09+peE/rpZ8MF+X0y1vz15e77mnhHBEY/mIPAaH/+6
 s9lJozJ66pCaLPeNB85VNTMybKMl37dx2QYb68m8jwxTapJceRmqXlXVkKXqhLq1uskgIeG0JpD
 pBI0iRaaInfo5MO9DXVnr1XHT7CChDLRmMPsoQdBw0CBtOjoBEx+xBzApcr6Ihu8nmSKh
X-Received: by 2002:a05:6102:2ac4:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-727c6a40c5fmr1927362137.18.1781785979048; 
 Thu, 18 Jun 2026 05:32:59 -0700 (PDT)
X-Received: by 2002:a05:6102:2ac4:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-727c6a40c5fmr1927342137.18.1781785978540; 
 Thu, 18 Jun 2026 05:32:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa5120esm255500895e9.8.2026.06.18.05.32.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/48] exec/cpu-common.h: Avoid including unused
 exec/page-protection.h header
Date: Thu, 18 Jun 2026 14:28:14 +0200
Message-ID: <20260618122825.90331-38-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX1HwupbEK/cCp
 kJKfbnW9vpit+CjdzqijG+BcPGhO/4w6Jdae8pFLPEqkOX6uOmZJ7GV/br8+VqUjua0KObILkxj
 3iMnLPXVwBvkN0uq3okvCk7gJdrrADXpMaLDrUlDZ9XFErWK7eMTRYL/JAflu1Ivabn0e8mU12b
 Lc/IJftvIpvLF0w4Fo5ESlt2CLheOREEx2yJo2Tje0Dmy/VQlOOzgiFPz/8rmEhnRzsULw8Qh+p
 qzVErzaj24yEDr52GRrsJtD66uSjoh7C/TqQNdr36WW4eyz/8xy7Fi4YDgs9MiVbBQjZ4I3xTQo
 6vARcRTkyccFxn4hYo9C2PtpNaQ0k/lTtc1ycIbfiI9nZ/Ie+exErRQqovlFIEnGR55kMIPC7nC
 zA9gezZvbJG1Bb9652J0PKyBNjUXs8NyHnZvCSWR54sqSfaNmxo2X/9EUts3vAlIvrEMwhU/gl1
 bIUgH5AeDInHyAHNUvA==
X-Proofpoint-ORIG-GUID: PFxThUTpxaFuXkGVqdJVEeLXJ9Xr1Nvz
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33e57c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=9HOtloT3Mt6GOow7qMAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PFxThUTpxaFuXkGVqdJVEeLXJ9Xr1Nvz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXxXPvlAH6M9An
 /8/B6XQdzC39SafXQnU74NHmhe8/1OeFdi6X0tdfoxYkHR7hyu7Fthb6bGMYQzKT6Pi0urMk6WY
 M3Qc0TmDAd+1jFJkrVKOnMk8dYuAD1o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

Since commit e74781c0888e ("exec/cpu: Extract page-protection
definitions to page-protection.h") the "exec/cpu-common.h" isn't
using anything defined in "exec/page-protection.h"; remove it.

Include it in few files where it is currently pulled in indirectly,
otherwise we'd get:

  linux-user/qemu.h:182:22: error: ‘PAGE_READ’ undeclared
    182 | #define VERIFY_READ  PAGE_READ
        |                      ^~~~~~~~~
  target/loongarch/cpu_helper.c:329:25: error: use of undeclared identifier 'PAGE_READ'
    329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
        |                         ^
  target/loongarch/cpu_helper.c:329:37: error: use of undeclared identifier 'PAGE_WRITE'
    329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
        |                                     ^
  target/loongarch/cpu_helper.c:329:50: error: use of undeclared identifier 'PAGE_EXEC'
    329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
        |                                                  ^
  target/ppc/mmu-hash32.h:98:20: error: use of undeclared identifier 'PAGE_READ'
     98 |             prot = PAGE_READ | PAGE_WRITE;
        |                    ^
  target/ppc/mmu-hash32.h:98:32: error: use of undeclared identifier 'PAGE_WRITE'
     98 |             prot = PAGE_READ | PAGE_WRITE;
        |                                ^
  hw/ppc/ppc_booke.c:39:17: error: use of undeclared identifier 'PAGE_RWX'
     39 |     tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
        |                 ^
  hw/ppc/ppc_booke.c:39:33: error: use of undeclared identifier 'PAGE_VALID'
     39 |     tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
        |                                 ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617160426.64461-6-philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h     | 1 -
 linux-user/qemu.h             | 1 +
 target/ppc/mmu-hash32.h       | 1 +
 hw/ppc/ppc_booke.c            | 1 +
 linux-user/arm/elfload.c      | 1 +
 linux-user/hppa/elfload.c     | 1 +
 linux-user/x86_64/elfload.c   | 1 +
 target/arm/tcg/cpregs-at.c    | 1 +
 target/loongarch/cpu_helper.c | 1 +
 target/ppc/cpu_init.c         | 1 +
 10 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d1a04025363..7eb45a95b6c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -10,7 +10,6 @@
 
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
-#include "exec/page-protection.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 #define EXCP_HLT        0x10001 /* hlt instruction reached */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 07fe8016282..fc5d7973021 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -6,6 +6,7 @@
 
 #include "user/abitypes.h"
 #include "user/page-protection.h"
+#include "exec/page-protection.h"
 
 #include "syscall_defs.h"
 #include "target_syscall.h"
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index bfea03ea872..c6e2c60db19 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,6 +3,7 @@
 
 #ifndef CONFIG_USER_ONLY
 
+#include "exec/page-protection.h"
 #include "system/memory.h"
 
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 052c8c931ae..6f0cad1c752 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
+#include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index fef61022a3d..13b589ea2c5 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -2,6 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu.h"
+#include "exec/page-protection.h"
 #include "loader.h"
 #include "user-internals.h"
 #include "target_elf.h"
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 3354e1b840d..2ebb9924f19 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "exec/page-protection.h"
 #include "qemu.h"
 #include "loader.h"
 #include "target_elf.h"
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 5914f76e833..49a6f6180e0 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -2,6 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "exec/page-protection.h"
 #include "qemu.h"
 #include "loader.h"
 #include "target_elf.h"
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 1c819c1cdb2..d6d5b73430a 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -4,6 +4,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/page-protection.h"
 #include "cpu.h"
 #include "cpu-features.h"
 #include "internals.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 7f0e64a8739..123cad3d930 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,6 +11,7 @@
 #include "system/tcg.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-csr.h"
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d25f69f13ba..a02187ce5af 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -40,6 +40,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
+#include "exec/page-protection.h"
 #include "exec/watchpoint.h"
 #include "helper_regs.h"
 #include "internal.h"
-- 
2.53.0


