Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9353606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=obmTciyM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kSwl9nE6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jm-0003P9-2r; Thu, 22 Oct 2026 17:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jj-0003JT-UV
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ji-0007iq-6l
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLceXS1410787
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gZ+086wOOPwuAWexDVUZzxqQdQ7on9cXWlvASIRxjfg=; b=obmTciyMRq09oWsN
 Dc092+IhcrPJmjoCjl726rxGPyz7eTc5/dazVd28OqSjDSCsxd6RPsj3FiUyS9Jy
 k+5qL2eXxrSYbDD4Us+ynDqPH7+NlWgLlr5Q3hifbvn4VUttQvluv5NGbVt6dxzH
 AdJT9rCXoV81dYwyFiE+29pOeYmcGom/Ny4ppct2lgQH0OMCxIYm9CLzKSG6xZOK
 bojxMX6Lxx/LteuHOYmn51MqcGUzIlf8+t5qai8U+g3en2Scw1lKfMQuOeNiI73J
 WuoLqKJ8yS9kdHvJTlRAREA1kysaMjflw019fqx4nQs7fagTtMxA6sFhh44piXXk
 S5rKew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8qwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f33438950so54600685a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706048; x=1793310848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gZ+086wOOPwuAWexDVUZzxqQdQ7on9cXWlvASIRxjfg=;
 b=kSwl9nE6ncJwcfLUmSWM0eMEt+qErGdJw2K/xn3az0dzsX08nPSPiWNzQuXdX+nhXG
 iS5ypwcS9RYZW35pbof5IqCmmXOQstEMEkfUL76KHZEgCkd5MCi6Ad32HUX7v/SmPqr+
 U+1CNmIg5onv6R+6obt6X1escFFxNnuB2O54oFiXFrhi0wWR367f/v272YzRgY5uqaVw
 ebwL5XJnNiKC/87zF+kVdKyUtVxwd826UDH6bTIa55bQIR9LC9cWoqbGJCBp8gbIb3bn
 ALG+KHofUjrX+mhwcjCbaoT75DhTHFpvzJL5aAQp8V5k0tFbqIrMWOoljco/8OMZbYLi
 U0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706048; x=1793310848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gZ+086wOOPwuAWexDVUZzxqQdQ7on9cXWlvASIRxjfg=;
 b=JsIpYjfSJWcJH/lpdEwok+TwElVxcuax/8Uh/FDnKkvbptQDs1s8fA8ucjMFGlvxFP
 1iSxlE5gTslD7JNAd6IecgAfDacc7/PqBk/ZRGiOWqJcSRtuDtwm3u0b2wCR0R9Tnh7m
 wum5jK2LYgZ3oiPWB2RqCIBqGJYmEyuB7KEnfFDGf50arIVnMF22D5xpV1vzxoieGA2z
 TkplUwSREndWRvX5GaRVJCYpjyOo4rXNJ7JU+gckUyFARrjyKy/WmPFcY/TNCvwrp4OS
 gKxy+9b5CLsrjJJRO6mAhJqQ9Gi33l7IVE2m3ZhS/Q0bOUWRXEzNxrXXMSRGmkY7/sMf
 sb/A==
X-Gm-Message-State: AFq9FYLWPXCJtDqGS/z5WxVNP0lGV5QzYOLu+O0vDhGYSsuDG9PXO3WZ
 CxxiTuHmvcL07RqthaxRVXhUOFOzG7wO26nccHrjr4uci2nrHm021TOXZ1jHG0R9tO1h12Z2rqO
 PcJnBOfs1mYm1j2DKNBtpxzKJED/7MufEjVKfjIQ0pcEgoXOE9LqLZlRL/KX8IHmvCA==
X-Gm-Gg: AYBFou2Kxkk7TJhJmYT27T36D7Py90gWwYkUjWWLkbm/+XdihAbFi+CSk0GcFat09vO
 n7YZzQebSRhnHhdDMgUv6ldS8sw9Ltfc47nvYA3TNsuA+zm31CadqekPvnF1XHUd7cHGkqH7dSo
 sN4RkEFuT/zxj6p1RkrRj2OTvnrPgrHWep4wwNxQovLe7eRRT9ghTFPoOGr3jtbaS/3djOrkU4T
 4DsMZKcz4mI5GOV2n+zW+9pAl4aCetIihD8eHHwGZb/huMFSRDc2/CoQ9NSVQs+VtkZ8MUQoA9k
 IcUK0GFWLFmXBKfQAt8vnwchMSmZheocfQsbuBOKN0KKqubtvKRtWlleptiMj3m07FGlkcIjeDD
 q/Ltj7wDPwHp8unMJZWHLJLi1OEaeKAlvUSCFTJj1
X-Received: by 2002:a05:620a:6841:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-93f6f657f8dmr132182485a.18.1792706048332; 
 Thu, 22 Oct 2026 14:54:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6841:b0:93f:2ba5:1704 with SMTP id
 af79cd13be357-93f6f657f8dmr132179085a.18.1792706047814; 
 Thu, 22 Oct 2026 14:54:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211bda21dsm12016075e9.11.2026.10.22.14.54.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH v3 23/33] target/riscv: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:51:03 +0200
Message-ID: <20261022215115.19680-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6jygKcCNGtG2GYbNbiZkfrYfJ462NKxC
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada8601 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=y9j7XMdMAJhvWi9Kj2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXwNWxFbiB/t+Z
 KBlYfZe/RbpiNdMYv60IlqNNY6PoSgBEPqWISIKRctsgS48LWfkXFzmeAFq87BbXkT47BKqLzlD
 nIPwTG41fXHWpcyKMQt7Igo6VaijJ3M=
X-Proofpoint-ORIG-GUID: 6jygKcCNGtG2GYbNbiZkfrYfJ462NKxC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6xMDcDVLTLbW
 2nx/6Tn9Z3Fn6jB25XPMDxLLAxT1Rum1Sa8YRVEqjm6XD4NbLmkFs3kYTZbgkaKdrZ/bRgTCMi1
 bjMjAWn0UMPm3/j534a3Q7YhO/i5w3kHNwQ3RhALS9HoLRZ6GJ1+6YN1b3qmPVRTOVNES/wrVyH
 qJr/K9avxCv7AGHnBkiSvLhRWMZVfVnfSgkremWMsijXjZAhShxkc+iY6QjJlCL+Q8xNaObXswD
 ZOxcieyqseAnCQa+nluLXdwsJ5cVApxiQzsGUL2LVtrepjKvXM1NV4ouvAQxroRygDuLdTiGdQQ
 LSW9vdHSRI6mHsq6pwg0c3kq8tXQPKhqA7EUHW0yvuE+/XUhodfsRA9ZeruiOOhe+mR2Homv4SJ
 w5TEf/dPc/Hc/Gp73FERKI1wzYhX4RHSz/jmWEULcw3XWOYpUWtEV6A29G/EGNrhkP0FINipQbn
 6kgFD2Wx3sJyB0Ut95A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Factor riscv_excp_name() and riscv_intr_name() out of
riscv_cpu_get_trap_name(). Register riscv_excp_name()
as the CPUClass::exception_name() handler, so the common
exception logging can resolve RISCV exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/cpu.h           |  1 +
 target/riscv/cpu.c           | 20 ++++++++++----------
 target/riscv/tcg/op_helper.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d6319940..49a1186bdbb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -672,6 +672,7 @@ G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
+const char *riscv_excp_name(int excp);
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08a4d14ea1f..e1652bd2a40 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
 #include "qemu/log.h"
@@ -398,6 +399,11 @@ static const char * const riscv_excp_names[] = {
     [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
+const char *riscv_excp_name(int excp)
+{
+    return STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, excp) ?: "unknown";
+}
+
 static const char * const riscv_intr_names[] = {
     [IRQ_U_SOFT] = "u_software",
     [IRQ_S_SOFT] = "s_software",
@@ -417,17 +423,10 @@ static const char * const riscv_intr_names[] = {
 
 const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
-    if (async) {
-        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
-            return riscv_intr_names[cause];
-        }
-    } else {
-        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
-            return riscv_excp_names[cause];
-        }
-    }
+    const char *name = async ? STR_ARRAY_ELEM_OR_NULL(riscv_intr_names, cause)
+                             : STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, cause);
 
-    return "(unknown)";
+    return name ?: "unknown";
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
@@ -3128,6 +3127,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
+    cc->exception_name = riscv_excp_name;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b8b3e43ccd5..f85f5cd83c9 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -41,7 +41,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
     CPUState *cs = env_cpu(env);
 
     trace_riscv_exception(exception,
-                          riscv_cpu_get_trap_name(exception, false),
+                          riscv_excp_name(exception),
                           env->pc);
 
     cs->exception_index = exception;
-- 
2.55.0


