Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29500CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8x-0007Pj-3l; Tue, 23 Jun 2026 20:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8v-0007Ou-12
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8s-0003BW-0n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0o5G1285719
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gxdHg8ThLg3IWBFqDHiyuv+moEUD77xWG/b/9Q74awg=; b=gvJGCQYWEk7YinOu
 D7LII4oTIboIyi4RJkX+133lQaw7jPUnw5Gut4eV2EmJ/ytfdsu8k0D+ckUoDGMc
 QROKT49p5/DjuPDAnau57GB6sxsJd7aoTSijrz57N/Z0G7/7rzHtiV3xkUtHiClL
 or0mzU/yV9HVt0tIUkC20gnm5NpWLbP0r9e86Vlu0ANZ3N1wbjHT7Vx/ktx3m84Y
 HJaLu48d8z9vjKJ0/xAJCSZD71qqTJMuWsG9+qUkQswG6Se8SPUsUKIUpmv5cZJg
 M340+cqg5ZPZE+r24gUDXm3kkN6zyMv2SdEyHSwWpvZTJP7knO5KVNMTLFSVXMCs
 qGviPw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr323618-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dd6d58b606so9463156d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259616; x=1782864416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxdHg8ThLg3IWBFqDHiyuv+moEUD77xWG/b/9Q74awg=;
 b=IG1DrLJiBdT3xMlNYI0KX73tuZ3QVFnSP/j+qjoelyerK1EYJXxlBJMvHW5JDh0hPO
 vQ5YPEH1HUFgxeywC/QJV/E3kwJNXFIgnq66579/8oZlyZwA5aBCERdD/wWPtYpOlkxZ
 DWGV0htFDO9bSmu67Lun0fUOzzUcOqx/ZXAAkMDea94SC/z5q3Hn9CwXDnSdaWFdKC6c
 SKpJtV9e/cETgM3f4kuRBKlohFgqff1/EyytoPrTNxkEMgmp4dujPfFK5ljmkOEZoRFi
 9Q8d+EDTwN6YgxEnpe3mPcvb3a9EvhFeAq6ea7EXTnR8J7QC8NX/EX2A2kL0Y7XTmXdb
 VLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259616; x=1782864416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxdHg8ThLg3IWBFqDHiyuv+moEUD77xWG/b/9Q74awg=;
 b=eIXfJ5YBOFWYzd0lLwrbq34ZRu2AXzCU0b+5y6c+TyJPl8BKgku7KecI3sUuDufq02
 driqMAkTBQOXelyP2y9wt3TfZCWU5bvQfhxJNw0htzgJaZ7B/Xg6DbZR3Fpjmav0hkMJ
 E1onEWuysT4BDj/qYpqeHsbcHcZdcW02MmErurrpZpo8BPY8UNPdrKKrFpkPWB7OO/sK
 41113ge+BmCRC/K4W3jaEsWqEr9/uUY/bDke3SVQreqS2hh7OHw6mgNyydZi0tgrr+qW
 /TMxsp5/vVaOaVFSACCJ0VX9akgo0yXPSt6eb1g1yWR18VhvkVM02SmeFAH/d4r+Mwua
 MAZQ==
X-Gm-Message-State: AOJu0YwfFmvvOOs4Ns89rtgVz4pz2OrcEybxaLPvu3sJoEOqypgpUtYn
 rsdZYMPqom/hayiveExR6XKpcyPaw9TAqWxa9vYq+aypeoVKi/ldTetZTgWpBxZeYXxhmAnT5TD
 En6v3WuOdR6464MxNAkqECvxP8XaHw1+qSyS3w2Se7rVxiHmANqdaEWjMVvhkKPHt/g==
X-Gm-Gg: AfdE7cmHYTH9MWJDnG5YQT4CzXbq35wuWvoNLccSG2tznEZUym5T9X7QIm2/wbYwlJB
 hWHxvbRAin1fEziHq50BlZvwrkDR1HJBzm3h7IdBVJRGc5VVynpiAYItFjJBkP4rfVuoES6/+03
 BAqFx0wOFukzER+SRBJV2y9KQRKHncxfTQ3smQ+8w1JTR5Ytuj0LiPMm0BPfBYyFojDDiv32WBr
 IDnxtD66zKujyxbE2enWfUCXvUpdhCswjwlD91c9PjxJnJX+dH6zBKN8EAcSjuWyNJ8S/7FvG5Y
 RfZUk1P4lgw67cuINoSWZi/85deXDMHxhTOe/4GuX7tuNb07YzCj51UEHMFbSGqrx2ML7INsY6K
 q9tf6+6pxhJGc6V2/fckgCBKie5NBZsFqIG8Arr/xgFNM7Q==
X-Received: by 2002:ad4:5bcf:0:b0:8ae:60c4:857 with SMTP id
 6a1803df08f44-8e4012ea890mr92170506d6.18.1782259616378; 
 Tue, 23 Jun 2026 17:06:56 -0700 (PDT)
X-Received: by 2002:ad4:5bcf:0:b0:8ae:60c4:857 with SMTP id
 6a1803df08f44-8e4012ea890mr92169726d6.18.1782259615800; 
 Tue, 23 Jun 2026 17:06:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 05/24] target/riscv: tidy up riscv_sysemu_ops
Date: Tue, 23 Jun 2026 21:06:12 -0300
Message-ID: <20260624000632.2149359-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX/mu9mAd/8SMY
 90KDv1pGjTKZ+7k8yB93/E5aaKQH+BsrP3F8PE022/MIcReVMtHJ2ckRbaTqjYA3sdgZUu4FAVa
 XYRKyajIYKFrDm+RljBIUKdGX0ProV4=
X-Proofpoint-ORIG-GUID: ChCLGofSP3OXm3xczPDpVXb5q2b0c0r4
X-Authority-Analysis: v=2.4 cv=HrxG3UTS c=1 sm=1 tr=0 ts=6a3b1fa0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=t0TUB-rRe_9fwXOx4ZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXzxJ0J3iyNFCe
 v03Ka4ydJv/zR3MdLlwJwBzhMHbhpbtTqx3e+4m9TOAkZwHFSfW1FIUX3PyXXT8+qtrA4lMoCrR
 mAsHuCG56PwCB2pLke1QZFc1pK8RoUxh1y0gkuWodiGauNRIA7r8cvIt44SPD4GWXqE1AsqOMF4
 OpfiAAxjZAXcLtLCQKXRro+h1j9b8hqaxxa659EI448N6p3qOBAMTxh6mexoekRJWD+IbWX59Bd
 0ZZuyfVQuiXpCdwOGi5Vzu1pA5+ZhG8mf7FUOTj/QuiyrobldicdicPiXDxeteOAFeM+1dYbHX7
 AiQTgoOTix1KTGu4ko0qwgq7hZJhGi9WGTEVqPwuogtHkHiiyn/dtD5fcAWMfuksLrAkwlRjHUs
 g9pMB9ALtf9ICspvlBb93rugThMd51MJ2rHjIRlIhUI6jyheIPYCABoWex65KJyB2CKZF9S/3ay
 RhXUI6tyvVZP0HjaxVg==
X-Proofpoint-GUID: ChCLGofSP3OXm3xczPDpVXb5q2b0c0r4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
in cpu.c.v

Same goes for get_phys_addr_debug - it has a TCG only implementation and
KVM can't use it for now.  It would also need to be filtered out, but
since we're at it, let's convert it to the newer 'translate_for_debug'
API too.  Same restrictions apply.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c            |  6 ++++--
 target/riscv/cpu.h            |  3 ++-
 target/riscv/monitor.c        |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e96bbeb60..319825882a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
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
index f0c78c1474..70b8729bd7 100644
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
index 59edcdd370..a893472c4e 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1771,7 +1771,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1781,17 +1782,22 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
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


