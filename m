Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C7FCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1V-0002sE-F7; Mon, 01 Sep 2025 23:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1U-0002lk-4o
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1R-0004dS-GA
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Y3QI000383
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ham6MQtFO1fUrUbOlSblP5ZqRQ62nQJgT8MQifuMG3Q=; b=aYFR48Jc7GdE5HY0
 3EMmLaUEdd+CpYnyAxFk1GrbJ3hBuyMqvuiYd6+s3PNh5qfMPzP6+ZuJozsDhMpq
 SoSQLa3x0mzOg0bg6W7oR67La3DJYB9r6WRS/JAT6kC6bUWSHZZjammn8ujgyAh2
 E9aiG5G4N0ePTTPIEYo45Js0QVcQ0shapx/p+kkWpKic1EUyPzNgx8dK6QWdfkMJ
 5tm0TH99iL/dE3O6hkg6uLT+4rPiY0ecDPZEjmoySoM8sDIFWxgbvUmnIUCks5SE
 rdKLpzVoUuohwxNYKU/tD8kjKPmOmxAkJsOMDVm3FQWvqvqpM3wXukppQLN10cY0
 NeGIkw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw853y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso8954529a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784956; x=1757389756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ham6MQtFO1fUrUbOlSblP5ZqRQ62nQJgT8MQifuMG3Q=;
 b=uzwosPaavAxP1zS8EX01hzSmhZRIcp1l4JApDtzGR8y0fMZZ/6FfpBFN6Lod0PK4Wc
 nKNxCeaRspldRG3u1YISrovw7gsXHxiO/8+SYEnEYGedtCeOAQNJY96YQnA1fOeUFKKI
 45JRrJfGzj5gYVILS6ceUnq5vF8ESVK/0MBWUoOpDUJf7VABVQYJ+xjH/17qFysQPjuD
 fwewKzJNVKaaXwehcaa6WGsnAY1hWujnp7daKdx6Rww3tf0AbmJy7mz/IkIP3amJBLCR
 WvuaGJAB1DHuWCrJns3Baywd+x5iywgqD65NFMgE8TH1BGUY5e2klh+vt/QygkfloKpB
 15sQ==
X-Gm-Message-State: AOJu0Yyv6gQSKnuVqsSa4RA3BTKkhfJbGRhM7szvtESHFzDmFRbsGMlw
 HHmuo0Vib0/8uLPbY7AtQWPUYFkpkIR+lMUqbUolckPDWHzv1ngkEMmZPkfuJ1baO11COitoDwt
 RtVlB2maeckgXUBYZCL5rStfNRHVoxcQR3CAymR0c2wbIo2tSQCvt6UlsdiCyqqgEuLs3
X-Gm-Gg: ASbGncvspf/hSSebVRg80Po/ucmF/LW2CcM8m8ACRIl/LnE4EMJbwIH6LXtI/vN0hGQ
 WWiAzdYSI0Aj6/PiOOHE8HFG9arDJQLesLTy9ezdGWXNXYzKB1hTWiYvBwL2nNQ5rBRj4n4ryVZ
 o6+c4fFaSLj7hDQAZ0lq4dlcKTwCz9M37nOihbLk/aa6zyEUcwmI+L7ZWIhhx5waqwWs4zJAS2R
 kVcKkAC19EXLB6K4yXi0rZ+5vBs0caedaLqdxzyXnDGNNbPoswHv0a8t7g2nPcZNze3pmZIMmkv
 utCAbMWxN5fjSEiv/RnLKV4dmkq7WvWtaykVpX8R/easY2ZjyxL0WUSKA7FEGPNwkLTHvD+GydI
 gbP3ZIpBoJrTX
X-Received: by 2002:a17:90b:3948:b0:327:70a1:3bfd with SMTP id
 98e67ed59e1d1-32815414358mr12718989a91.3.1756784956252; 
 Mon, 01 Sep 2025 20:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIlYl+vbOgjKJo2gpFrYHHgS9TPCqlQgT9J30bnMubDU5nbBzkMh9go1W9IgQQxthL4M2kLA==
X-Received: by 2002:a17:90b:3948:b0:327:70a1:3bfd with SMTP id
 98e67ed59e1d1-32815414358mr12718966a91.3.1756784955724; 
 Mon, 01 Sep 2025 20:49:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 19/39] target/hexagon: Implement hexagon_tlb_fill()
Date: Mon,  1 Sep 2025 20:48:27 -0700
Message-Id: <20250902034847.1948010-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX5fpwkTmkybw8
 BDFevUeoC1Gbnp566zoRwUhVEQ/WaGHFmRYhZ2eZmdXhZH9VBpidY0GITDdgRwL3f1GtT7B2dIV
 M5GFewxPxlspEvDnUxPI6/4lGJbLpOEuVkxjyrnlWa6AhsiPsUrC7WPZoLBxoG4PBi5bp1m7lXs
 yR2DClrReLuLTUhcP79GmRT2f4YEVnrC346woZcxw4c9X7n2ypxkofoOJjfkWKrwK4NVjuSusvw
 66zr44aM4Hv5Ze3XhR9TM59XQC6nB6/msZp3J3TQNB/icsuiBSHfUYN7luRFTPcnx7SDI5Au+pa
 hrSNbV/KpCbarivC6b46nqQyOHgvFx7LoAVmuHBwrNyYcLSuGodOhfGhDcgs5qniXQtZMFILRBU
 EJ73w9Vs
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b6693d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=yz7b9sy1sBSXNk6fZdQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QwUu9Pu8V2w5HLN7R6WLgrSy9bA-EBmg
X-Proofpoint-ORIG-GUID: QwUu9Pu8V2w5HLN7R6WLgrSy9bA-EBmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 134 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0445146f2b..2ae6874841 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -37,6 +37,8 @@
 #include "hex_interrupts.h"
 #include "hexswi.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_page.h"
+#include "hw/hexagon/hexagon_globalreg.h"
 #endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
@@ -490,7 +492,136 @@ static void hexagon_cpu_init(Object *obj)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY)
+static bool get_physical_address(CPUHexagonState *env, hwaddr *phys, int *prot,
+                                 int *size, int32_t *excp, target_ulong address,
+                                 MMUAccessType access_type, int mmu_idx)
+
+{
+    if (hexagon_cpu_mmu_enabled(env)) {
+        return hex_tlb_find_match(env, address, access_type, phys, prot, size,
+                                  excp, mmu_idx);
+    } else {
+        *phys = address & 0xFFFFFFFF;
+        *prot = PAGE_VALID | PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        *size = TARGET_PAGE_SIZE;
+        return true;
+    }
+}
+
+/* qemu seems to only want to know about TARGET_PAGE_SIZE pages */
+static void find_qemu_subpage(vaddr *addr, hwaddr *phys, int page_size)
+{
+    vaddr page_start = *addr & ~((vaddr)(page_size - 1));
+    vaddr offset = ((*addr - page_start) / TARGET_PAGE_SIZE) * TARGET_PAGE_SIZE;
+    *addr = page_start + offset;
+    *phys += offset;
+}
+
+
+#define INVALID_BADVA 0xbadabada
+
+static void set_badva_regs(CPUHexagonState *env, target_ulong VA, int slot,
+                           MMUAccessType access_type)
+{
+    arch_set_system_reg(env, HEX_SREG_BADVA, VA);
+
+    if (access_type == MMU_INST_FETCH || slot == 0) {
+        arch_set_system_reg(env, HEX_SREG_BADVA0, VA);
+        arch_set_system_reg(env, HEX_SREG_BADVA1, INVALID_BADVA);
+        SET_SSR_FIELD(env, SSR_V0, 1);
+        SET_SSR_FIELD(env, SSR_V1, 0);
+        SET_SSR_FIELD(env, SSR_BVS, 0);
+    } else if (slot == 1) {
+        arch_set_system_reg(env, HEX_SREG_BADVA0, INVALID_BADVA);
+        arch_set_system_reg(env, HEX_SREG_BADVA1, VA);
+        SET_SSR_FIELD(env, SSR_V0, 0);
+        SET_SSR_FIELD(env, SSR_V1, 1);
+        SET_SSR_FIELD(env, SSR_BVS, 1);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void raise_tlbmiss_exception(CPUState *cs, target_ulong VA, int slot,
+                                    MMUAccessType access_type)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    set_badva_regs(env, VA, slot, access_type);
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        cs->exception_index = HEX_EVENT_TLB_MISS_X;
+        if ((VA & ~TARGET_PAGE_MASK) == 0) {
+            env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE;
+        } else {
+            env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NORMAL;
+        }
+        break;
+    case MMU_DATA_LOAD:
+        cs->exception_index = HEX_EVENT_TLB_MISS_RW;
+        env->cause_code = HEX_CAUSE_TLBMISSRW_CAUSE_READ;
+        break;
+    case MMU_DATA_STORE:
+        cs->exception_index = HEX_EVENT_TLB_MISS_RW;
+        env->cause_code = HEX_CAUSE_TLBMISSRW_CAUSE_WRITE;
+        break;
+    }
+}
+
+static void raise_perm_exception(CPUState *cs, target_ulong VA, int slot,
+                                 MMUAccessType access_type, int32_t excp)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    set_badva_regs(env, VA, slot, access_type);
+    cs->exception_index = excp;
+}
+
+static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
+                                           "MMU_INST_FETCH" };
+
+static const char *mmu_idx_names[] = { "MMU_USER_IDX", "MMU_GUEST_IDX",
+                                       "MMU_KERNEL_IDX" };
+
+static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
+                             MMUAccessType access_type, int mmu_idx, bool probe,
+                             uintptr_t retaddr)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    static int slot = 0 /* This is always zero for now */;
+    hwaddr phys;
+    int prot = 0;
+    int page_size = 0;
+    int32_t excp = 0;
+    bool ret = 0;
+
+    qemu_log_mask(
+        CPU_LOG_MMU,
+        "%s: tid = 0x%x, pc = 0x%08" PRIx32 ", vaddr = 0x%08" VADDR_PRIx
+        ", size = %d, %s,\tprobe = %d, %s\n",
+        __func__, env->threadId, env->gpr[HEX_REG_PC], address, size,
+        access_type_names[access_type], probe, mmu_idx_names[mmu_idx]);
+    ret = get_physical_address(env, &phys, &prot, &page_size, &excp, address,
+                               access_type, mmu_idx);
+    if (ret) {
+        if (!excp) {
+            find_qemu_subpage(&address, &phys, page_size);
+            tlb_set_page(cs, address, phys, prot, mmu_idx, TARGET_PAGE_SIZE);
+            return ret;
+        } else {
+            raise_perm_exception(cs, address, slot, access_type, excp);
+            do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
+                               retaddr);
+        }
+    }
+    if (probe) {
+        return false;
+    }
+    raise_tlbmiss_exception(cs, address, slot, access_type);
+    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
+}
 
 static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -533,6 +664,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .cpu_exec_interrupt = hexagon_cpu_exec_interrupt,
     .pointer_wrap = hexagon_pointer_wrap,
     .cpu_exec_reset = cpu_reset,
+    .tlb_fill = hexagon_tlb_fill,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.34.1


