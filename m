Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHT-0001Ox-Fe; Fri, 03 Jul 2026 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHR-0001NR-EY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHK-0002Ay-3K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiOcn678075
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lwpVwBDDDxbZlL85oChz1dGE8ep3DnXhx+lsrvnx0ss=; b=G2GFHcdfjcL9HKVo
 sJp1X61yewpXjeWUsPkNAAalRun/J/yG/RQPbC+8+l964/s3PAes636ONveLj+Py
 CyYM3mKccAIaDScMo0b/zDCRYb349E7oUi21a+BPljqQZmATIsSMicrKE8XzR4bh
 IYFzZu9Z4UcJQ9zTfpXSN8FXPS31RiN7s9vqcprHW3cxrGaTtCryU5weocT71X6Q
 o0IeNjDsJfRBh21wvSUoWABIL7CsPKOVn9aTZiANt/2SwaneEdeZ9n6b3OuS8/RS
 FDYEhwzt1A2aHtcTcEiRVRKGee8IlAqjtf5WRHm9Tivbz5JRloH5dIrsK4KcPXkG
 mo/vPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u3290e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso9399871cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101965; x=1783706765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwpVwBDDDxbZlL85oChz1dGE8ep3DnXhx+lsrvnx0ss=;
 b=AXzxHU01u4GFETjIi6/rKjS1ABqV5QpTl7uybGAAYDxJ053WjNwgUgpS7FmsFp9UNk
 kgzFmePLvrKE8GgsfwwRR2IHZ4oAHKsS519JWQ3Sk4cFc7jfsKZUXMqlBAd2gfHenmSu
 weAXW/AZY1+4mRqxmRsjJz1LszSUBRBNPjn+QuaYj/79cTHWcDKV0KN1gYovpzDvlHCB
 AkZBfXa7haU+HcFqkcBrOMmIWC50tMJDmXfbvzi0Bk0g5CnDQ9yD+NO1wpujFQPQ6CDK
 1J35axlvYBg0KBFhRscm2DBkRj0OctuIatYHJl06/tMNNrrbmh+Nvbas/bMQ2n15eTOG
 Szbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101965; x=1783706765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lwpVwBDDDxbZlL85oChz1dGE8ep3DnXhx+lsrvnx0ss=;
 b=E5U97wLZanYu/3fhmQuusFyJR/22k2zlcj7KEO9bD1wa/CCtWkPBSqAxO96Cn9xiCR
 vSXVSvcj3mwvBRBydX1lsi+NwvYM0TowfhAlos6V/FfAmcaLW+3cNVxJdYV+z6FPj9r6
 XLlzPJeLtJUCGYTkhkJg0IwyRnUmPTglMITGzF6jINTeVdwi3HKRR6NgS8lUf4bMudVw
 nLEJKiq1jAffx8WVHw0t6smQ+h9CCUoMsggNICGf0TlTwvE/Vu13jApMfXyK044W5/AV
 P6on6dKCahM/Iva/kwcbJa4/+udJBl4UbYZ3f4ASkBQFxGUM3zGjhwvyYB5rtpRVP8ha
 HBEw==
X-Gm-Message-State: AOJu0Yy+s8ddkS4uDstOiqfeCyL1uQILevTG42/xAKrzCNuJCmKKUTZu
 TBpcJfu/tJ5DkfB4erFBu+IHw8fSMADsTlJgMvDCbi0ps/JZpO4pN40RclLEsxIAfcVY4gcG9bL
 5tTTSyMqwQsOm0LNFQrqEHlOrYH2JDuKT4EvD8gdXhw4NupmyOYEUoXjC/Ckbb3FZFg==
X-Gm-Gg: AfdE7cmjnbk8wVfriIRWnxURMAWttshEg8FYRn4UekKCQOSVfxUqI0VSg0Zg8+JY+3A
 qzvneH8ou9bQ/M5X+b9z8BKZbabFleLxgQM79GfmMTA4yPRpz3X6v1Dem0nddJ5F4IFq5wp4L4e
 1t4cReJe006JdqePdbV+3wmrDqpvgFtvN6BdbCimrsiNKg1aizyGquVB7v1TM0UzmVy4yK3DlNs
 VSpTa9yLxtJglkVcJDUfXQ2Jr9CyOf0I1CxIlO+gaSBdMZMoIIzsWFQ0y2WLMvOq2DeEnqX2AhM
 gNWkAakm1C4JzJmGOO3064Wrtf6MeGqYSk/S5iVvXIGf8IpNCipz7BdX3QJRQVK6p4rlb5W7Myk
 N4PjI71OvEf69y5ae4Em2GnUxQsr+CRHIUzBKzVBQx3j24Q==
X-Received: by 2002:ac8:7c49:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-51c4c20a94amr10077191cf.24.1783101964595; 
 Fri, 03 Jul 2026 11:06:04 -0700 (PDT)
X-Received: by 2002:ac8:7c49:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-51c4c20a94amr10076411cf.24.1783101963986; 
 Fri, 03 Jul 2026 11:06:03 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 07/24] target/riscv: tidy up riscv_sysemu_ops
Date: Fri,  3 Jul 2026 15:05:19 -0300
Message-ID: <20260703180538.3346781-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U5-uFK2-OYpIAKO8LGsIequWB90WKDaE
X-Proofpoint-ORIG-GUID: U5-uFK2-OYpIAKO8LGsIequWB90WKDaE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX5HUM/w9P9Ky5
 bfcDLtdu5m8uqgo/oClonkotTYf75Vb7eHJQq32seYAbdoBhhPblr/B9IYGmB5m+CiUHu/54+lw
 zQNihAH+bISClgwmPLh74/+MHeyafso=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX/ffSen5k/B48
 RyPUz6PPAUAvTytGUC7zy5f2VaaQoRScjWHSgzqz8elZ26f2GZKI0preE3SHqrp/+TcTqGNkV+y
 rPVHcZ0MZrazMFejAbM4ea1R7GO8BP345BA41dYDL4xXF/K8tA4O+wBXR2NK1YHWi0vU1JHV6Lk
 ojUh05X6FK03UobYHqTB/j0HENKMqOBZvyqRy4nF+RxpIqbh/pgJdTitdS5TP5ex1Dcm+1IDKSj
 n/D1vzRuqSBgMLB/LMeRemXMRR1xaJ+Mtrx73Ch2aF4dfvF1mZ3hpJLoRoTtdaSQ2vNNaOojwyY
 eF7EAgP0UEXOxVjlqJeOBwtqZaUSLL2PGi1lJvGkEFKqJzkD/AbCjh+QVyi1kp2r0VPqP8W2ktr
 WXfgrnFbjfQLSGT3kOMt8UmgNIwTlCNuslMboL3c6XJNqcnQOFEjJcSMCkR2PLGlKv+yRyFLbmr
 iA+aaL8EvUiq5CF/Pyw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47fa0d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=QY3w21f5PuwKoA3dFekA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

monitor_get_register at this moment has a TCG exclusive implementation
for RISC-V, even though the callback is supposed to be arch independent.
Until we address how KVM is going to implement it we need to filter it out
in cpu.c.

Same goes for get_phys_addr_debug - it has a TCG only implementation and
KVM can't use it for now.  It would also need to be filtered out, but
since we're at it, let's convert it to the newer 'translate_for_debug'
API too.  Same restrictions apply.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c            |  6 ++++--
 target/riscv/cpu.h            |  3 ++-
 target/riscv/monitor.c        |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cae4e96232..d17ba0474a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2693,11 +2693,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
+#ifdef CONFIG_TCG
+    .translate_for_debug = riscv_cpu_translate_for_debug,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
+#endif
 };
 #endif
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ecf2913d42..18fbd4edb6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -665,7 +665,8 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MMUAccessType access_type,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr);
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3e89dcaf7c..7aacd1d89c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
+#ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
@@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
 
     return -EINVAL;
 }
+#endif
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 2db07f5dfb..885b4172c0 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1779,7 +1779,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1789,17 +1790,22 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true, false)) {
-        return -1;
+        return false;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
                                  0, MMUIdx_U, false, true, true, false)) {
-            return -1;
+            return false;
         }
     }
 
-    return phys_addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.43.0


