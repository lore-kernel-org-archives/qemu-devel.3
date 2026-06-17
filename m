Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE2ACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZslb-0004oV-DY; Wed, 17 Jun 2026 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZslM-0004ZL-4n
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:05:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZslJ-0001Bd-Ur
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:05:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoYnT1235811
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /NTOhstnkAMp3At8bpIZZCfw8tB0O9Bn8aY1fZumqhI=; b=EwgSfPNpSwZiqhlX
 PWMKq1URB8NcEDTcgmML4RD2paZrxSP0W4Q1gRtolmRnc80a7h72KTeajYLeIkG8
 SeTXfGcQI4/F7IEEzFqKE19AdmHx0K78o7QLPSjW3OI7BSiUMp/DF9PjrGidKlan
 Dt9PCgyM0rHO4PmwmSmXEI1mgf7NBoY8uVzwtsYJj3rOwdbcFBXKR5kV2XvGslCr
 MhlhUR2cyWK0DyqJH1CM2S/ZLi1128oxIKk3f/zc9ug/fq1MK1HoEob3sRO+sMMQ
 OGRz+UoU5rG4xn64BoZLqLYA7+HymhOYUfhMl4isO6Tx/RwSvf2TVqKfPXpWPLHx
 a4dDQQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepm1eh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:05:07 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4867831a9a8so9132976b6e.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712306; x=1782317106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NTOhstnkAMp3At8bpIZZCfw8tB0O9Bn8aY1fZumqhI=;
 b=BXRbXzVlMpTPFuxQxLeSzd+z1ybHejraowO7eUuvcvsdVtt0CsOUcgTEIjrARdeXZb
 GOVvxuLsX65yRwb5AZcl/AU0ol7lfKq2gDBE5OdWpYZfy7LKxE+d+lNFbZ6//rfc7gtP
 5Sb7JtZQxln9cW3dIpzElJveeTtLSwNwFlYgBmk9zapR4d4EtUVu/A0I8arz89fPhJCi
 lf5HCW2KcpRVLyttzz5lVdQ2H+DWExJ6x7QRKVZ+EkrQhmXBWFCz08WCs1p+E3OimUmW
 81HbrHrN8FFJJsMfL/R+vSLfUz0i6OTUYlKij7PoL74lMDqjafTu72RuHvSr1klyhtgK
 6z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712306; x=1782317106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/NTOhstnkAMp3At8bpIZZCfw8tB0O9Bn8aY1fZumqhI=;
 b=svxY6fupas5wcrIdZIAeTUiFUpXnrn3OHwIBxtB48R8hkUUTQybdtnc4E49pO4x+nx
 lQ8c10ZLBy3c6zIh8ib0S1NLt8bShWNRAuwP3r+0eh2/W31zAJP4yIqLz4/uU0gp0lb3
 /dOk84kHvYc5aX+MQH99zHgTb7a0d3igon8XI20ALBSZWqH+jhrniMOOYIMbvDQbwgAb
 zXFxo0IA6h4u3KZc/IwIFrdiSrkCZPBCVnf+InHThmwQ7diPWwXxnNsA3K4AXksNnvuD
 uKgM8PA/dk3B2RZLJdmH7r/ETtP2l11Ib8ijvcUJEcySOI2tl7vikSPvDKJ9awJwVVVi
 vxTw==
X-Gm-Message-State: AOJu0Yws+eioKLyzfwrY+I2dKvFlJ2S2dikrvsgV97HBD3hhBCBHKRCC
 FZxiDcPeGY1a355/bcHNPYGOk/jC7gFP6NtfDoYP1dbq9eaxphgnLcI4No0KLB3BlEMn7y2Onct
 jO4hP6cHYhIBiBc7OnD/QYZKZuHnjvaua5Bh1hoJn80D7n8jGZoMwhA6mPQwxHw4JVQ==
X-Gm-Gg: Acq92OEDLgiR+jICTMeuIA8RmyVAQoE7jZh53iJ1QK3cs5rpw5Akh3KHWGwIVCUmYPw
 /+cqyOn2UB0kn+yG8nfUzZNbwESk8eMYFewbXtoOREWc56eOMAOKmW6J6MvauIsokGQneIi7hlE
 5U0hh6IIryzXh2ZW4jiwcWzpvubYhx0xVNFr5vnr9dejuzCfHflhLA6nTYRUichHdbsNLuYc2yV
 iS9NFVeT4N/zqgEPTNCDmX/IsTF5je+Lnx7aUmDCqqI+Ukp0eFUSR7FuL76Rb7QTnKH20ZqAg0C
 kwCYU27YB8foId/hVKopVX5zEuvbrf/h3FUGvvMPfveMZEepwHAvOdXNJtKxEnwnTJyQRfujRAG
 oP9GXxN1nGeg2ei8gloYkeIj4u9RMtIbym6fWGpRV6i4iKeKluLECQke8Vp7hczZWFKW1
X-Received: by 2002:a05:6808:f01:b0:479:d779:3544 with SMTP id
 5614622812f47-4894445affemr4137486b6e.5.1781712305853; 
 Wed, 17 Jun 2026 09:05:05 -0700 (PDT)
X-Received: by 2002:a05:6808:f01:b0:479:d779:3544 with SMTP id
 5614622812f47-4894445affemr4137401b6e.5.1781712305166; 
 Wed, 17 Jun 2026 09:05:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm298254855e9.14.2026.06.17.09.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:05:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/5] exec/cpu-common.h: Avoid including unused
 exec/page-protection.h header
Date: Wed, 17 Jun 2026 18:04:26 +0200
Message-ID: <20260617160426.64461-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a32c5b3 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cPMCRr05qPJdhiTk-AYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: YbtQJ4SrwDkXpaXYEY74fQEGM1wodkKF
X-Proofpoint-ORIG-GUID: YbtQJ4SrwDkXpaXYEY74fQEGM1wodkKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX8QlIPLblocQW
 sfWIUEGiZEac2YDq75Ip+D864clxOCR9Z7NTZm+UlErs/B9Ts8XWuTimT4tHtjq6ZtoiTNlx+dL
 kmu74KVGLmo8Y9YtSwH02xZDqXKQsJUYkXxTrIgB+gfiJOw45HXMyYVeqiY6i3bJdsC3uqR6cWD
 x/eRHTUFGuJPJ+gp2j0Oe0sGke/3SsFNuzo5Bvpjyttg2vL6bufTrwFTLJTVeeYPCY/ZSpQmTKu
 jUkX3V7Y9dmnxMaWuV7LoU79ni7bnjnkMqq0x5h48YyFvUVWzEqnQWLZ8iQI3VbSAJ6s0D2km2m
 L84nGfXKOQizeLJ6VECaAnaUEMraAsD05aQYJb7KKbtiIdhFfc1KIMuUmUpphkrPJOQoiFbuaxS
 3c9gt8G/mAEYVVDsbzkIQ86JdC2FmFgyOxFcDWT4D3VivVo7jw44foxPu3kVZmi63oOjec/q4y0
 wABhkSpnTj9axM8BrcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX6uKT5RxfX6qm
 k6z8VJcG1lPDeHDnKdKryVsvU4qLVqBE4NXhvtmKoIZejGJ6EvFBl7ONCDDPrppTMiZoBwuDPSh
 yFlD9IWEzbowpHb6YEFH2M/g1N1uRPE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170154
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


